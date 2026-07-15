
[[index]]

previous article  [[agent]]

next article  [[x-article skill]]

---

**参考文章**：[[Building agents that reach production systems with MCP]]

# 1. Model Context Protocol (MCP) 概述

**Model Context Protocol (MCP)** 是由 Anthropic 于 2024 年底推出的一项开源开放标准协议。它的核心定位是作为 **AI 大模型与外部数据源、工具之间的通用接口规范**（类似于软件工程领域的“USB-C”接口或针对 AI 领域的 LSP 语言服务协议）

在 MCP 出现之前，将大模型连接到不同的外部系统（如 GitHub、PostgreSQL、Notion 等）需要为每个系统单独编写硬编码的集成代码。MCP 通过定义统一的通信框架，解决了这种碎片化问题

MCP 的用途是为大模型建立一个统一的“软硬件接口规范”，让 AI 不仅能像插 U 盘一样读取任何外部数据，还能像拥有双手一样，直接去修改文件、操作数据库、调用 API 执行各类实体任务

## 核心架构组件

MCP 采用客户端-服务器（Client-Server）架构，主要由以下三个角色组成：

- **MCP Host（宿主应用）**：用户直接交互的 AI 环境或集成开发环境（IDE），例如 Claude Desktop、Cursor 或 Claude Code CLI。它负责管理整体生命周期与权限
    
- **MCP Client（客户端）**：嵌入在宿主应用内部的连接器。它负责与各个独立的 MCP Server 建立状态会话（Stateful Session），并将大模型的意图翻译为协议请求，同时将服务器响应回传给大模型
    
- **MCP Server（服务器）**：独立的模块化服务。它直接与底层基础设施（如文件系统、数据库、第三方 API）对接，并将这些能力标准化地暴露给客户端

claude code = Host
      │
      ├── LLM 调用层（把用户请求发给 Claude API）
      │
      └── MCP Client 层（连接各个 MCP Server）
              ├── filesystem server
              └── playwright server


**同时 MCP 服务分为两种形式：

| **特性**   | ==**Servers (本地服务)**==             | ==**Remote Servers (远程服务)**==           |
| -------- | ---------------------------------- | --------------------------------------- |
| **运行位置** | 运行在你的本地机器上                         | 运行在远程服务器或云端                             |
| **通信协议** | 通常基于 **stdio**（标准输入输出）             | 通常基于 **SSE**（Server-Sent Events / HTTP） |
| **进程管理** | 由 MCP 客户端（如 Claude Desktop）直接启动和关闭 | 独立运行，客户端仅通过网络接口进行连接                     |
| **安全性**  | 拥有本地文件系统和环境变量的访问权限                 | 权限受到网络 API 的限制，相对隔离                     |

---

## 协议支持的三大核心能力

MCP 协议定义了三种主要的数据交互原语：

- **Resources（资源）**：向模型提供只读的上下文数据。可以理解为 AI 的“数据源”，如读取文件内容、查看数据库 Schema 或日志流
    
- **Tools（工具）**：允许模型执行的主动操作。可以理解为 AI 的“函数调用（Function Calling）”，如执行一段代码、修改数据库记录或发送 API 请求
    
- **Prompts（提示词模版）**：服务器预先定义好的结构化提示词，协助模型更好地理解如何处理特定领域的任务

---

## 传输层协议

MCP 底层基于 **JSON-RPC 2.0** 规范进行异步通信。主要支持两种传输方式：

- **stdio（标准输入输出）**：用于本地服务，Host 直接通过子进程启动 Server，通信效率极高，安全性由本地操作系统隔离保障
    
- **SSE（Server-Sent Events / HTTP）**：用于远程服务，支持跨网络的实时数据流传输

---

# 2. MCP 在 Claude Code CLI 中的运行机制

在 claude code 中，MCP 是其实现高度自治、跨系统协同的底层支柱。其具体运行机制可以从以下几个维度剖析：

## 宿主与进程管理机制

当在终端启动 `claude` 命令时，claude code CLI 将作为 **MCP Host** 运行

- **配置文件加载**：CLI 在启动时会读取特定的配置文件（如通过 `--mcp-config ./mcp.json` 参数指定，或读取全局默认配置）。该文件声明了需要加载的各个 MCP Server 的执行路径、环境变量及启动参数
    
- **本地子进程生命周期**：对于最常用的本地集成，Claude Code 会通过 `stdio` 管道，以子进程（Subprocess）的形式拉起配置中的每一个 MCP Server。Server 的生命周期与 `claude` 命令行会话完全绑定，退出会话时子进程协同销毁

---

## 动态能力发现与状态协商

建立连接后，Claude Code 的 MCP Client 会与各个 Server 进行握手（Handshake）和能力协商（Capability Negotiation）：

- Server 通过 JSON-RPC 将自身支持的 `tools`（名称、描述、JSON Schema 参数结构）和 `resources` 列表上报给 Claude Code
    
- Claude Code 会动态地将这些工具描述合并到输入给底层的 Claude 3.5 Sonnet 模型的系统提示词（System Prompt）中。这意味着大模型在 CLI 会话期间，能够感知到当前环境拥有哪些扩展能力

---

## 权限控制与安全准入机制

由于 CLI 具有直接操作本地文件系统和运行指令的权限，MCP 在 Claude Code 中引入了严格的权限控制模型：

- **双层校验**：当模型决定调用某个 MCP Tool 时，请求首先到达 Claude Code CLI。CLI 会根据配置的安全策略判断是否需要中断并提示用户
    
- **交互式确认**：涉及写操作、网络请求或敏感系统行为的工具调用，CLI 会在终端拦截并打印出该工具期望执行的具体参数，由用户手动输入 `y/n` 授权
    
- **非交互模式（CI/CD）**：在自动化脚本中，可以通过 `--permission-mode` 和 `--permission-prompt-tool` 参数，指定由特定的自动化工具来处理权限准入（若涉及核心高危操作且无法交互，则根据安全策略默认降级拒绝）

---

## 执行循环与上下文反馈

实际执行任务时，Claude Code 遵循 Agent 的 **思考-调用-响应** 循环：

```
[LLM] 
       │ (决策：需要调用外部工具)
       ▼
[Claude Code CLI (MCP Client)] 
       │ (解析为 JSON-RPC 请求，通过 stdio 写入管道)
       ▼
[MCP Server (如 PostgreSQL Server)] ─► (执行本地 DB 查询)
       │
       ▼ (封装为标准 JSON-RPC 响应，通过 stdout 写回)
[Claude Code CLI (MCP Client)] 
       │ (将执行结果/错误作为 Context 追加到对话历史)
       ▼
[LLM] (基于最新上下文继续推理或输出最终答案)
```

通过这一套机制，Claude Code CLI 不仅能使用其原生的文件编辑和终端执行能力，还能无缝吞吐用户自定义的 MCP 插件（例如通过 MCP 连接 Jira、Confluence、企业内部 API 等），使其从一个单纯的本地代码助手升级为能够调度企业全局资源的命令行 Agent

---

# 3. mcp 与 skill 的对比

|**特性维度**|**本地 Skill (Local Skill)**|**MCP (Model Context Protocol)**|
|---|---|---|
|**标准化程度**|随项目或工具而变的私有逻辑，无统一标准。|遵循开源开放的工业级网络与进程通信协议。|
|**生命周期**|由当前代码库或当前会话的上下文机制管理。|由 Host 统一通过操作系统进程管理（如 stdio 管道拉起/销毁）。|
|**跨工具复用性**|极低（通常只能在特定工具或当前工作区生效）。|极高（写一次 Server，任何支持 MCP 的 AI 软件都能直接用）。|
|**系统隔离性**|通常在当前运行进程的环境中直接执行。|运行在独立的 Server 进程中，天然具备进程级隔离的安全边界。|
|**能力复杂度**|适合处理简单的规则指导、本地文件模版或小脚本。|适合处理复杂的系统级连接（如对接异构数据库、复杂的企业内部 API）。|
## 用一个开发场景来理解

假设你想让 Claude Code 能够读写你公司内部的 **Jira 任务管理系统**：

- **如果用“本地 Skill”的做法**：你需要在当前项目的 `.claude` 或 `skill` 文件夹下写一堆具体的 Markdown 说明，或者写几个临时的 Python 脚本去调 Jira API，然后教导 Claude 如何在终端运行这些脚本。这个能力换到别的项目或者换到 Cursor 编译器里，你就得重新配置一遍
    
- **如果用“MCP”的做法**：你直接在本地启动一个社区现成的 `mcp-server-jira`。在 Claude Code 的全局 `mcp.json` 中配置好该 Server 的启动路径。从此，无论你在哪个项目路径下打开 Claude Code，甚至你在用 Claude Desktop 聊天时，AI 都能直接通过这个标准通道去增删改查你的 Jira 任务

==以上提到的 mcp 使用是针对于开发场景，那么我们日常应该如何使用呢==

---

# 4.  探索 mcp

https://mcp.so/

![[mcp-1.png]]

**在这个网站里可以探索各种各样的 mcp

---

# 5. claude code 安装 mcp

==**在安装 mcp 之前我们需要做一个准备工作**==：对 CLAUDE.md 进行一个更新，后续 mcp 的安装交给 claude code 自行处理

```
将一下内容优化进 CLAUDE.md：

MCP Server 配置规则，当用户提供 MCP server 配置（如 `{"mcpServers": {...}}`）时，按以下规则自动处理：

  1. **配置位置**：全局配置写入 `~/.claude.json` 的 `mcpServers` 字段（非 `settings.json`、非 `.mcp.json`）
  2. **必填字段**：http 类型必须包含 `"type": "http"` + `"url"`；stdio 类型必须包含 `"type": "stdio"` + `"command"` + `"args"`
  3. **操作流程**：读取现有 `~/.claude.json` → 合并新 server 到 `mcpServers` → 写回文件 → 提示用户重启 Claude Code

```json
  // http 类型示例
  "mcpServers": {
    "server-name": {
      "type": "http",
      "url": "https://example.com/mcp"
    }
  }

  // stdio 类型示例
  "mcpServers": {
    "server-name": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@package/mcp-server"]
    }
  }
```

==**只需要将上面的 prompt 复制粘贴给 claude code 处理即可**==

![[mcp-3.png]]

- 这是 mcp.so 网站里任意一个 mcp 的界面
- 可以看到下面有配置信息、工具列表等一系列的介绍
- ==如果要安装该 mcp，只需要将上面的配置代码复制下来==

![[mcp-2.png]]

- 只需要把这个配置代码粘贴给 claude code，并要求它进行配置
- 然后 claude code 就会依照上述 CLAUDE.md 的要求进行配置

![[mcp-4.png]]

- 同时我们可以在 claude code CLI 界面中输入 **/mcp** 来查看已安装的 mcp 服务
- 选中相应的 mcp 回车可以查看工具列表，关闭连接该 mcp 服务（不是删除）
- 如要删除，直接跟 claude code 发 prompt 让它处理

---

# 5. 使用 mcp

mcp 的自定义创建有一定的门槛和难度，同时对于我们日常使用来说，自定义的需求并不是很高，所以我们直接跳过创建 mcp

刚刚了解到 mcp 是作为配置存放在配置文件中，所以当 claude code 被触发和打开时，这些配置文件都会被 LLM 所读取，也就是说 LLM 会知道所有已安装配置 mcp 的存在，在我们日常使用中，我们也无需特别去跟 claude code 强调有什么 mcp 可以去处理什么任务，claude code 会自动匹配已安装的 mcp 并进行使用；同时 mcp 的数量也不是越多越好，太多了会导致 LLM 判断错误造成一些负面的影响，同类型的 mcp 保留一个即可