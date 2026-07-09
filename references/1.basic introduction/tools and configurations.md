
[[index（索引）]]

previous article  [[operating environment]]

next article  [[a-claude code/references/2.installation and configuration/installation|installation]]

---

# **1. shell

**Shell（命令行解释器）** 就是人与操作系统之间的"翻译官"

如果把操作系统看成汽车：
- Windows/Linux 内核 = 发动机
- Shell = 方向盘 + 仪表盘
- 用户 = 驾驶员

通过向 shell 输入**命令行**来操控电脑，例如：
- 输入  `mkdir test`
- 电脑就会创建一个名叫 test 的文件夹

## Windows 的 shell

Windows 发展了很多代 shell，包含：
- cmd（command prompt）
- power shell
cmd 和 power shell 都是很常用且好用的 shell

## wsl 的 shell

wsl 本质上运行的是 Linux，因此使用的是 Linux shell，包含：
- bash
- zsh
- fish
- sh
不过 ubuntu 下常用的是 ==bash==

## 终端（terminal）

这不是 shell，它其实是一个**终端程序**，是一个窗口；可以通过 terminal 打开 cmd powershell bash wsl 等 shell

## ==claude code 与 shell 的关系==

claude code 的核心工作方式，是通过 Shell 与本地开发环境交互，再结合 AI 模型进行分析、规划和生成代码
- AI（LLM）负责思考
- shell 负责执行

---

# **2. github and git

## GitHub
**基于 Git 的代码托管与协作开发平台**。它允许开发者将本地 Git 仓库同步到云端，并提供团队协作、代码审查、项目管理和自动化部署等功能，目前已成为全球最大的开源代码托管平台之一，并于 2018 年被 Microsoft 收购

GitHub 为每个项目提供一个远程仓库（Repository），用于存储代码和完整的版本历史。包括：云端备份、多设备同步、团队共享、永久保存历史记录

作为世界上最大的开源社区，GitHub 聚集了大量开源项目，开发者可以：浏览源码、学习优秀项目、提交改进建议、修复 Bug、参与开源贡献

## Git 
**分布式版本控制系统，主要用于管理代码、文档以及任何文件的历史版本

简单来说，如果你把写代码、写文档比作在游戏里闯关，那 Git 就是你的**存档神器**。它不仅能帮你随时随地存档，还能在你玩砸了的时候一键读档，甚至能让你和好几个朋友同时在同一个存档里各玩各的，最后还能完美合并

## github 和 git 的关系

**GitHub** 是一个基于 **Git 系统的**第三方线上的代码托管平台。它为开发者提供远程服务器来存储 Git 仓库，使团队成员可以突破地域限制，将各自本地的代码提交（Push）到同一个远程仓库中进行协同开发。此外，GitHub 还围绕 Git 扩展了拉取请求（Pull Request/代码评审）、问题追踪（Issues）、权限管理和自动化部署等可视化协作功能

核心关系：Git 是基础的工具，GitHub 是基于该工具搭建的云端平台。你可以只用 Git 在本地管理项目而不使用 GitHub；但 GitHub 的所有核心代码版本管理功能，都必须依赖 Git 来实现

## ==claude code 和 git 的关系==

**Claude Code 依赖 Git，是因为 Git 是它作为 AI 代理安全、高效操作代码的“时空感知与控制系统”**。在安全层面上，Git 为 Claude 提供了完美的“安全网”，使其在自动重构或大范围改动代码时，能通过暂存区或分支随时一键回滚、容错试错；在效能层面上，Claude 利用 Git 的分支和 Worktree 机制来实现多智能体（Sub-agents）并行开发，并利用 Git 历史（Diff/Log）精准读取代码上下文与变更意图；最终，它依托本地 Git 配置实现自动建分支、规范提交、推送及创建 PR 的全自动化研发闭环

==虽然我们使用 claude code 不会进行编程开发，但是可以利用这一工具将个人数据同步上传到 github 上，作为免费的云盘备份；同时 github 上有非常多优秀好用的开源项目，claude code 便可以利用 git 这一工具直接从 github 中获取项目内容==

---

# **3. SSH

**SSH**（全称 **Secure Shell**，安全外壳协议）是一种加密的网络传输协议。它主要用于在不安全的网络中，为计算机之间的远程登录和其他网络服务提供安全的加密渠道。简单来说，它就像是在你的电脑和远程服务器之间挖了一条**安全加密隧道**。即便有人在网络中窃听，他们也只能看到一堆乱码，无法得知你发送的密码或执行的命令

## ==claude code 与 SSH 的关系==

claude code 本质上是通过你本地电脑上的 Git 工具来与 GitHub 交互的。如果已经在本地电脑上配置好了 GitHub 的 SSH 密钥，Claude Code 就会直接复用这些凭证去拉取（Pull）或推送（Push）代码或者文件

|**工具/概念**|**它是什么？**|**它的核心职责**|**在这个体系中扮演的角色**|
|---|---|---|---|
|**Claude Code**|AI 编程助手 (Agent)|读写代码、运行测试、自动调用工具|**大脑与双手**：负责想代码、写代码。|
|**Git**|版本控制软件 (Tool)|记录代码历史、管理分支、打包修改|**本地管家**：负责记录谁在什么时候改了什么。|
|**SSH**|加密传输协议 (Protocol)|提供安全的、免密的远程连接通道|**保安队**：负责在数据传输时防窃听、防篡改。|
|**GitHub**|代码托管平台 (Platform)|存放团队代码、管理项目、协作开发|**云端总部**：所有人的代码最终汇总、备份的地方。|

---

# **4. python

Python 是一种简洁、优雅、高效的解释型高级编程语言，由荷兰程序员 Guido van Rossum 于 1991 年创建。它以“优雅”、“明确”、“简单”为核心设计哲学，采用缩进来划分代码块，极大降低了学习和阅读门槛，被称为“伪代码级”的语言

想要运行 python 程序，则需要电脑具有相应的 python 运行环境，所以也就需要在电脑中做好相应的环境配置；用一句话概括：**为不同的项目打造独立、稳定且干净的“集装箱”，防止代码因版本冲突而“打架”**

## ==claude code 与 python 的关系==

**claude code 在以下任务情况下会主动调用 Python 执行**：

**数据处理与分析类任务**（最常见）
- 读取、清洗、分析 CSV、Excel、JSON 等数据文件
- 进行统计计算、数据可视化（生成图表）
- 批量处理文件、文本数据提取

**复杂计算与算法实现**
- 数学建模、数值计算、优化问题
- 实现自定义算法（如排序、搜索、机器学习模型）
- 科学计算、模拟实验

**自动化脚本与批量操作**
- 文件批量重命名、转换、整理
- 数据爬取后处理（虽然不能直接联网，但可处理已有的数据）
- 生成报告、自动化测试脚本

**原型开发与快速验证**
- 快速编写并测试函数、类、API 逻辑
- 验证算法正确性
- 生成可运行的完整 Python 脚本

**图表与可视化生成**
- Matplotlib / Seaborn / Plotly 绘制各类统计图
- 生成 PNG、PDF 等可视化结果文件

**其他场景**
- 需要精确计算（如财务、金融模型）
- 格式转换（Markdown 转 HTML、图片处理等）
- 模拟环境测试代码逻辑

==python 是目前 AI、数据科学和自动化领域最重要的编程语言之一。对于 **claude code** 来说，python 更像是它最强大的"执行工具"之一：AI （LLM）负责思考和生成方案，python 负责计算、处理数据和执行复杂任务==

---

# **5. node.js

node.js 是目前全球最流行的后端开发技术之一。简单来说，它让 Javascript 摆脱了只能在浏览器里运行的局限性，直接晋升为可以编写服务器端程序的全能型开发语言

同时 node.js 不是开发语言，也不是框架；它是一个运行环境，让 Javascript 能直接在电脑上运行的环境

**注**：JavaScript 是互联网中最核心的编程语言，它最初是专门为浏览器设计的脚本语言，用来让网页“动起来”。但发展到今天，JavaScript 已经无处不在，从前端网页、后端服务器到移动端 App，它都能胜任

## npm and npx and pnpm（依赖/包的管理与执行工具）

**npm（包管理器鼻祖）**
npm (Node Package Manager) 是 Node.js 官方自带的、也是全球最大的包管理器
- **它的角色**：它是你的“大管家”，负责安装、共享和管理项目依赖 
- **工作原理**：当你运行 `npm install` 时，它会把依赖包下载到当前项目的 `node_modules` 文件夹中
**缺点**：
- **速度慢**：每次新建项目，即使是用过的包，npm 也会重新从网络或缓存中复制一份到新项目的 `node_modules` 中。
- **体积臃肿**：如果电脑里有 10 个项目都用了同一个大包，你的硬盘就会存 10 份这个包，极度浪费空间

**npx（包执行器）**
npx (Node Package Execute) 并不是 npm 的替代品，而是 npm 5.2.0 之后**内置的一个辅助工具（执行器）**
- **它的角色**：它是你的“临时工”，负责**运行**（执行）某个包的命令，而不是安装它
- **核心优势：无需全局安装**
    - _以前_：你想用 `create-react-app` 脚手架建个项目，必须先全局安装它，然后才能运行。久而久之，电脑里塞满了过时的全局工具
    - _现在_：只需运行 `npx create-react-app my-app`。npx 会自动在云端下载这个包的最新版，在内存中运行完建项目指令后，**立刻把它删掉**，不占硬盘
- **使用场景**：
    - 运行一次性的脚手架工具（如 `npx create-next-app`）
    - 调用项目本地 `node_modules` 里的工具命令（比如无需配置环境变量，直接运行本地的测试工具 `npx jest`）

**pnpm（新一代性能怪兽）**
pnpm (Performant npm) 是近年来极为火爆的替代 npm/yarn 的新一代包管理器。它的名字就代表了它的特点：**高性能**
- **它的角色**：高效的“全能管家”
- **核心大招：硬链接（Hard Links）与全局内容寻址存储**
    - pnpm 会把所有的包都只下载到你电脑里的一个**全局共享盘（.pnpm-store）**
    - 当你不同的项目需要同一个包时，pnpm 不会复制文件，而是通过**硬链接**（类似于快捷方式，但更底层）指向全局存储中的那个文件
- **恐怖的优势**：
    - **极速**：因为省去了大量的文件复制和磁盘 I/O 操作，安装速度比 npm 快数倍
    - **省空间**：同一个包在你的电脑里**永远只占用一份硬盘空间**
    - **杜绝“幽灵依赖”**：npm 允许你在代码中直接 `import` 那些你没有显式声明在 `package.json` 里、但被其他包顺带下载下来的“附赠包”（即幽灵依赖），这会导致潜在的安全和维护隐患。pnpm 通过独特的严格目录结构，彻底封杀了幽灵依赖

## ==claude code 与 node.js 的关系==

 从技术实现上来说，**claude code 命令行工具本身就是用 JavaScript / TypeScript 开发的**。因此，它的安装和运行完全依赖于 Node.js 环境：
- **核心运行环境**：要运行 Claude Code，本地必须安装 **Node.js 18 或更高版本**（官方推荐使用 Node.js 22 LTS，能够带来更好的启动速度和性能）
- **通过 NPM 分发**：Claude Code 作为全局 CLI（命令行接口）工具，是托管在 Node.js 的官方包管理器 **NPM** 上的。开发者需要通过 Node.js 自带的包管理命令才能进行安装

claude code 的一大核心亮点是支持 **MCP（Model Context Protocol，模型上下文协议）**。MCP 允许 Claude 自由连接外部工具、数据库和 API
- **工具链的连接器**：目前开源社区中绝大多数的 MCP 服务端（MCP Servers）都是用 **Node.js / Typescript** 开发的
- **无缝扩展**：依托 Node.js 的异步 I/O 能力，Claude Code 可以通过本地的 Node.js 进程快速调起各种 MCP 工具（如读取本地数据库、联网搜索、连接 Jira/GitHub 接口），实现高并发的工具调用

---

# **6. json

JSON（JavaScript Object Notation） 是一种轻量级的数据交换格式，广泛用于 Web 开发、API 接口、配置文件等场景

## ==claude code 与 json 的关系==

### **配置文件全面使用 JSON**

Claude Code（Anthropic 推出的命令行编码工具）高度依赖 JSON 格式进行配置：

- **核心配置文件**：settings.json（项目级 .claude/settings.json 和用户级 ~/.claude/settings.json）
- **其他 JSON 文件**：
    - ~/.claude.json（存储会话、MCP 配置、缓存等）
    - keybindings.json（键盘绑定）
    - .mcp.json 等

这些文件用来配置模型、权限、Hooks、环境变量、插件、市场工具等，几乎所有持久化设置都用 **JSON** 格式

==我们正是用 claude code 通过 json 配置 API 跳过账号登录才使用上的==

### **结构化输出（Structured Outputs / JSON Mode）**

Claude Code 和 Claude API 都强烈支持 **强制 JSON 输出**：
- 通过 output_config.format 或 --output-format json 参数，让 Claude 返回**严格符合 JSON Schema** 的结构化数据。
- 这在代码生成、分析、报告、工具调用中非常常用，避免了传统“让 AI 输出 JSON”容易出错的问题。

**用途**：
- 代码分析结果
- 自动生成文档
- 提取结构化信息
- Agent/工具链的输入输出

### **Hooks 与自动化**

Claude Code 的 Hooks（钩子）机制使用 JSON 配置，并通过 **stdin/stdout 传递 JSON 数据**，实现自动化工作流（如格式化代码、类型检查、Git 操作等）

### **其他关联**
- **Artifacts**：Claude Code 可以将 JSON 数据、代码等转化为可视化页面
- **JSONL 格式**：部分内部日志或数据存储使用 JSON Lines（每行一个 JSON 对象）
- **Tool Use**：工具调用时，参数通常是 JSON 对象

### 总结

**JSON 是 Claude Code 的“血液”**：
- **配置层** → 几乎全靠 *.json 文件
- **输出层** → 支持原生结构化 JSON（比早期纯 Prompt 可靠得多）
- **交互层** → Hooks、工具、API 都围绕 JSON 设计

这让 Claude Code 特别适合**开发者工具链集成**和**自动化编程工作流**