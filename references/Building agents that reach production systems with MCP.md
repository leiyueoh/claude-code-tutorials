---
title: Building agents that reach production systems with MCP
source: https://claude.com/blog/building-agents-that-reach-production-systems-with-mcp
---

[[index]]

[[mcp]]

---

agent 的价值取决于他们能接触到的系统。团队通常会倾向于采用三种连接外部系统的方式——直接API调用、CLI和MCP。本文阐述了每种技术的定位，生产代理为何倾向选择MCP，以及有效构建这些集成的模式。

## 将代理连接到外部系统

我们通常看到代理与外部系统连接的路径有三种：直接API调用、CLI和MCP。每个角色在某些地方都有意义，取决于你建造的是什么。关键区别在于代理和服务之间是否存在一个共同层，以及这个层覆盖的范围有多远。

### 直接API调用

代理直接调用你的 API——要么在代码执行沙箱中编写代码，发送 HTTP 请求，要么通过通用函数调用工具。大多数团队都是从这里开始的，对于一个坐席与一个服务通信，或者少数不需要跨代理平台重复使用的集成来说，它都能很好地运行。  
  
挑战开始大规模出现。由于代理与服务之间没有共同层，每对代理–服务都成为定制集成，拥有自己的认证处理、工具描述和边缘情况——这就是M×N集成问题。

### 命令行界面（CLI）

代理在 shell 中运行你的命令行工具。这速度快、轻便，并且依赖于已有的模具。它非常适合本地环境和沙箱容器——只要有文件系统和壳层。这提供了一层共用的，但很薄。  
  
CLI在覆盖不暴露容器的移动、网页或云托管平台时达到了硬性限制，认证由CLI自身机制处理——通常是磁盘上的凭证文件。这最适合在本地环境中快速且宽松地集成。

### 模型上下文协议（MCP）

MCP作为协议提供公共层。代理连接到一台服务器，服务器会暴露你的系统能力，认证、发现和丰富的语义都已标准化。一台远程服务器可访问任何兼容客户端（Claude、ChatGPT、Cursor、VS Code 等），在任何部署环境中。

这需要更多的前期投入。其特点是集成具有可移植性，并提供了功能丰富的代理集成所需的语义。

## 生产代理运行在云端

生产代理越来越多地运行在云端，因此可以扩展并持续运行。他们需要覆盖的系统也是云托管的：你的数据存放在这里，工作被追踪，基础设施运行在这里。这些系统通常处于远程且未获得认证后，MCP提供公共层。当这些系统存在于私有网络中而非公共互联网时， [Claude 托管代理中的 MCP 隧道](https://claude.com/blog/claude-managed-agents-updates) 通过仅外呼连接连接代理——无需暴露端口或公共端点。

我们已经看到这种做法被采用了。该 [MCP SDK](https://modelcontextprotocol.io/docs/sdk) 最近每月下载量突破3亿次，较年初的1亿次有所增长，企业和热门代理平台的广泛采用。每天有数百万人使用 MCP 搭配 Claude，该协议支撑着我们最近发布的许多内容，包括 [克洛德·科沃克](https://claude.com/product/cowork),[Claude 管理代理](https://claude.com/blog/claude-managed-agents) ， 和 [Claude Code 中的通道](https://code.claude.com/docs/en/channels).  
  
随着MCP继续支持生产代理系统，我们分享了构建这些集成的模式：从构建高级服务器到上下文高效的客户端，以及技能与协议的补充。

## 构建高效的MCP服务器

我们有200多个MCP服务器 [目录](https://claude.ai/directory/connectors) 每天有数百万人使用。通过与基于该协议的企业和开发者密切合作，我们发现了一些设计模式，决定了代理如何可靠地使用服务器。

### 构建远程服务器以实现最大覆盖范围

远程服务器是提供分发服务的关键——它是唯一能跨网页、移动和云端代理运行的配置，也是每个主要客户端都针对它进行优化的配置。搭建远程服务器，让代理无论运行在哪里都能使用你的系统。

### 围绕意图而非端点来组工具

较少且描述良好的工具能持续优于穷尽的API镜像。不要把你的 API 一对一包裹进 MCP 服务器——要围绕意图分组工具，这样代理可以在几次调用内完成任务，而不是把许多原语拼接在一起。单个create\_issue\_from\_thread工具比 get\_thread + parse\_messages + create\_issue + link\_attachment 更胜一筹。参见 [为代理人编写有效的工具](https://www.anthropic.com/engineering/writing-tools-for-agents) 了解更多关于完整图案的信息。

### 设计适用于表面积大的代码编排

如果你的服务需要数百个不同的操作，比如Cloudflare、AWS或Kubernetes，意图分组工具组很可能无法覆盖这些。相反，应该暴露一个薄工具表面，接受代码：代理写一个简短脚本，服务器在沙盒中运行它，针对你的 API，只有结果返回。 [Cloudflare 的 MCP 服务器](https://github.com/cloudflare/mcp) 是参考示例——两个工具（搜索和执行）覆盖约2,500个端点，约为1000个令牌。

### 船的语义丰富，它们在帮助方面

[MCP应用](https://modelcontextprotocol.io/extensions/apps/overview) 是第一个官方协议扩展，允许工具返回交互式界面，如图表、表单或仪表盘，所有这些都在线渲染在聊天界面中。发布MCP应用的服务器，其采用率和用户留存率往往明显高于仅返回文本的服务器。利用它在关键时刻将产品界面展示给代理或终端用户——该扩展被 Claude.ai、Claude Cowork及许多其他顶级AI工具支持。

![](https://www.youtube.com/watch?v=bluAmTHoEow)

[引发](https://modelcontextprotocol.io/specification/2025-11-25/client/elicitation) 让你的服务器在工具调用中暂停，向用户征求意见。 [形式模式](https://modelcontextprotocol.io/specification/2025-11-25/client/elicitation#form-mode-elicitation-requests) 发送一个简单的模式，客户端渲染一个原生表单——用它来请求缺失的参数、确认破坏性操作或消除歧义选项。 [URL 模式](https://modelcontextprotocol.io/specification/2025-11-25/client/elicitation#url-mode-elicitation-requests) 将用户交给浏览器——用它完成下游的OAuth、收取款项，或收集任何不应通过MCP客户端的凭证。两者都让用户保持流程，而不是把他们送到设置页面。广泛支持表单模式;Claude Code 支持URL模式，且更多客户端正在开发中。

### 依赖标准化认证

标准化认证使MCP在云托管代理中变得实用。如果你的服务器需要最新的OAuth。 [MCP规范](https://modelcontextprotocol.io/specification/2025-11-25) 支持 [CIMD](https://modelcontextprotocol.io/specification/2025-11-25/basic/authorization#client-id-metadata-documents) （客户端ID元数据文档）用于客户端注册——它为用户提供了快速的首次认证流程，并且意外的重新认证提示大大减少。这是我们推荐的认证方法，该功能已被MCP SDK、Claude.ai 和Claude Code支持，并且正在被整个行业广泛采用。  
  
一旦用户授权，接下来的问题是云托管代理如何在运行时保留和重用这些令牌。 [金库](https://platform.claude.com/docs/en/managed-agents/vaults#mcp-oauth-credential) 在 [Claude 管理代理](https://platform.claude.com/docs/en/managed-agents/overview) 内容涵盖：只需注册一次用户的OAuth令牌，会话创建时通过ID引用保险库，平台会为每个MCP连接注入正确的凭证并代为刷新——无需构建秘密存储，无需每次调用传递令牌。

## 使MCP客户端更具上下文效率

MCP规范了AI代理（ [*客户*](https://modelcontextprotocol.io/docs/develop/build-client#python) 连接并使用他们所需的工具和数据源（ [*服务器*](https://modelcontextprotocol.io/docs/develop/build-server)).服务器安全地暴露了一系列功能，而客户端则负责协调这些能力并管理上下文。如果你正在构建MCP客户端，务必让它具备上下文效率，并引入渐进披露的模式。

### 按需加载工具定义，并使用工具搜索

[工具搜索](https://platform.claude.com/docs/en/agents-and-tools/tool-use/tool-search-tool) 将所有工具加载到上下文中推迟，而不是一开始就加载。这使得代理能够在运行时搜索目录，并在需要时调用相关工具。在我们的 [测试](https://www.anthropic.com/engineering/advanced-tool-use) 工具搜索倾向于将工具定义标记减少85%+，同时保持高选择准确性。

![](https://cdn.prod.website-files.com/68a44d4040f98a4adf2207b6/69e920e636fbec575e46319c_context-usage.webp)

通过工具搜索减少上下文使用。来源： 高级工具使用

### 进程工具生成带有程序化工具调用的代码

[程序化工具调用](https://www.anthropic.com/engineering/code-execution-with-mcp) Process Tool则形成了一个代码执行沙盒，而不是将代码原始返回到模型中。这使得代理能够在代码中循环、过滤和聚合调用，只有最终输出到达上下文。在我们的测试中，这大致减少了令牌使用率 [37%](https://platform.claude.com/docs/en/agents-and-tools/tool-use/programmatic-tool-calling) 关于复杂的多步骤工作流程。

这些模式在多个服务器上自然组合：更精简的上下文、更少的往返、更快的响应。参见 [*高级工具使用*](https://www.anthropic.com/engineering/advanced-tool-use) 完整解析。

## 将MCP服务器与技能配对

[技能和MCP是互补的](https://claude.com/blog/skills-explained).MCP使代理能够访问来自外部系统的工具和数据，而技能则教会代理如何使用这些工具完成实际工作的程序知识。最有能力的代理会同时使用两者，技能使MCP服务器的扩展范围超越少数连接。它们的组合有两种大致模式：

### 捆绑技能和MCP服务器作为插件

[插件](https://code.claude.com/docs/en/plugins-reference#plugin-components-reference) 对于 Claude 来说，是一种有用的抽象，允许开发者将技能、MCP 服务器、钩子、LSP 服务器和专用子代理打包成一种易于消耗的分发方式。采用这种方法是以最小的摩擦统一多个上下文提供者的最佳方式。  
  
将MCP服务器与技能结合，使Claude更像是领域专家。通过MCP获取你的工具，赋予Claude端到端协调工作流程的技能。请参见我们的 [数据插件](https://claude.ai/directory/plugins/data%40knowledge-work-plugins) 以Cowork为例，包含10个技能和8个MCP服务器，适用于Snowflake、Databricks、BigQuery、Hex等应用。

![](https://cdn.prod.website-files.com/68a44d4040f98a4adf2207b6/6945b3dfa8f134d0104e4e23_How%20Skills%20and%20MCP%20work%20together%20-%20v3B%402x%20(2).png)

将技能与MCP结合。来源： 通过技能和MCP服务器扩展Claude的能力

### 从MCP服务器分发技能

越来越多的服务提供者会将技能与MCP服务器一同发布，这样代理既能获得原始能力，也能获得一个明确的使用手册。 [Canva](https://claude.com/connectors/atlassian),[概念](https://claude.com/connectors/notion),[哨兵](https://claude.com/connectors/sentry) 今天更多人在Claude中这样做，技能在他们的连接器旁边列出。 [网页目录](https://claude.com/connectors).

为了让这种配对在每个客户端之间都可移植，MCP社区正在积极开发一个 [扩展](https://github.com/modelcontextprotocol/experimental-ext-skills) 直接从服务器传授技能。这样客户端会自动继承相关的专业知识，并根据它依赖的API进行版本化。我们预计随着扩展稳定，这一模式将被广泛采用。

## 复合层

我们开场时有三条连接代理与外部系统的路径。实际上，成熟的集成将同时发布这三者：作为基础的API、本地优先环境的CLI，以及云代理的MCP。

随着生产代理迁移到云端，MCP成为关键层，并且是复合层。如今，远程服务器能够覆盖任何部署环境中的每个兼容客户端，协议通过认证、交互性和丰富的语义处理。随着更多客户端采用该规范，更多扩展加入，同一台服务器的能力会提升，而无需发布任何新设备。

在构建集成时，如果你的目标是让云端生产代理能够到达你的系统，就搭建一个MCP服务器，并按照上述模式让它变得更出色。每一次基于MCP的集成都会强化生态系统：减少了需要单独解决的边缘案例，减少了需要维护的定制集成。

### 致谢

感谢登·德利马斯基、大卫·索里亚·帕拉、亨利·施、费利克斯·里泽伯格、康纳·凯利、莫莉·沃沃克、安迪·舒迈斯特、凯文·加西亚、艾米·罗瑟汉姆、马特·塞缪尔斯、安吉拉·江、凯特琳·莱斯、AJ·雷贝罗和杰斯·杨为本博客所做的贡献。