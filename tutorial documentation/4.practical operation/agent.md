
[[index]]

previous article  [[skill]]

next article  [[mcp]]

---

==这篇所介绍的功能对我们的使用来说不是很重要，仅作了解即可（文档最后很重要）==

==此处标题所提到的 agent 为 claude code 中的 **Sub-Agent（子代理）** 功能==
# 1. agent 概念介绍

## 通用 ai agent 的概念

agent在 AI 领域是一个相对宽泛、学术/工程化的概念：

- **核心特征**：自主性（Autonomy）、感知环境（Perception）、规划（Planning）、工具使用（Tool Use）、记忆（Memory）、行动（Action）、目标导向（Goal-directed）
- 典型架构包括：
    - **ReAct**（Reason + Act）
    - **Plan-and-Execute**
    - **Multi-Agent** 系统（CrewAI、AutoGen 等）
    - **Agentic Workflow**（LangGraph、LangChain 等框架）
- 强调的是**循环迭代的智能体行为**：观察 → 思考 → 行动 → 再观察，不断向目标靠近。
- 它可以是纯文本的、代码执行的、浏览器操作的、甚至多 agent 协作的

==claude code 本质上就是一个 agent AI 工具==

---

## claude code 的 agent 模式

这里是指 claude code 中的 **Sub-Agent（子代理）** 功能

它允许**主claude code 动态创建多个子 Agent**，每个子 Agent 有自己的名字、专长和独立上下文。你可以通过 @子Agent名称 直接给它分配任务，就像给团队成员指派工作一样

这是 claude code 实现**多 Agent 协作**的核心方式之一

### 工作原理

- 主 Agent 负责统筹和协调
- 子 Agent 拥有**独立的上下文窗口**（不会把所有历史都塞进去，节省 token）
- 子 Agent 可以独立思考、执行工具、修改文件
- 完成后会把结果汇报给主 Agent 或直接输出
- 支持**并行运行**多个子 Agent

### 使用步骤

**步骤1：创建子 Agent**

常用命令示例：

```
创建一个名为 demo-writer 的子 Agent，它专门负责写技术文章，要求风格专业、结构清晰、带实际案例。

创建一个 demo-analyzer 子 Agent，角色是代码质量审查专家，特别擅长找出 bug 和坏味道。
```

你也可以更详细地定义：

- 角色与人格
- 专长范围
- 输出格式要求
- 工具使用偏好

**步骤2：调用子 Agent**

```
@demo-writer 写一篇 1500 字的文章，主题是《Claude Code 中的 Agent 模式详解》

@demo-analyzer 分析 src/utils/auth.ts 文件的代码质量，给出详细报告
```

**步骤3：管理子 Agent**

- /agents —— 查看当前所有活跃的子 Agent
- 可以给子 Agent 下达新任务、让它暂停、或让它总结工作

### 优势（为什么好用）

- **上下文干净**：每个子 Agent 只关注自己的任务，不会像单一大 Agent 那样上下文越来越乱
- **分工明确**：写代码的、审查的、写文档的、测试的可以同时进行
- **效率高**：主 Agent 变成“项目经理”，子 Agent 变成“执行员工”
- **灵活性强**：随时创建、随时销毁，适合复杂项目

---

# **2.  细节说明

这里将介绍：
- claude code sub-agent 模式文件
	- 文件格式
	- 文件存放路径
- 该模式的直观解释
	- 运行方式
	- 使用优势
- 日常使用
	- 触发方式
	- 如何使用

---

## 文件格式

一个子 Agent 由一个 markdown 文档进行设定，文档中包含名字、描述、该 agent 能使用的工具、驱动的模型等关键信息

这个跟 skill 是有一些相似，但是本质逻辑是不一样

| 能力       | Agent    | Skill |
| -------- | -------- | ----- |
| 上下文      | 独立窗口     | 共享主会话 |
| 并行执行     | ✅        | ❌     |
| 指定 model | ✅        | ❌     |
| 限制 tools | ✅        | ❌     |
| 权限控制     | ✅        | ❌     |
| 文件结构     | 单个 `.md` | 需要文件夹 |

agent 由单个 `.md` 文件组成，结构如下：
  
```
---
name: my-agent              # 必填，小写 + 连字符
description: 何时使用        # 必填
tools: Read, Write, Bash    # 可选，限制工具
model: sonnet               # 可选，haiku/sonnet/opus/inherit
memory: user                # 可选，持久化记忆
---
你的 system prompt...
```

## 文件路径

![[agent-1.png]]

将单个的 agent markdown 文档存放到该路径，claude code 可以直接识别到

```
~/home/user/.claude/agents
```

---

## 运行方式以及优势

![[agent-2.png]]

- 因为 claude code 本质上就是一个 agent 工具，并且我们有设定好的 CLAUDE.md 上下文，也可以理解为这个窗口界面是一个==主 agent==
	
	- 一个窗口对应一个 agent
	
- 而且我们接入的大模型一般都是 1m（一百万 token）大小的上下文容量
	
	- 那么一个 agent（一个窗口）的上下文容量上限也就是 1m
	
- 正因如此如果我们在主界面（主 agent）中触发了其他的==子 agent==
	
	- 那么就相当于主 agent 在后端新开了一个或几个窗口界面来运行 agent 处理制定任务，只是用户看不到有这样的界面
		
		- 所以通过这样的机制，几个窗口所对应的上下文总容量就更大，能处理的工程也被允许更大
			
		- 将上下文拆开处理，token 的消耗会有所减少
			
		- 并行加速，这也相当于同时有几个人同时干活，处理工作所用的时间也就更短


---

## 如何触发子 agent

**方式一：自然语言

```
用 demo-writer 帮我写一篇文章
```

**方式二：@ 提及

```
@demo-analyzer 分析一下代码质量
```

![[agent-3.png]]

只需要 @ + 子 agent 的关键词即可进行选择，然后再提出 prompt 即可

---

## 终极

以上所有的介绍对我们的日常使用来说都不重要，claude code 有一个模式可以直接取代上面所有的繁琐程序和人工接入

==**ultracode mode==

![[agent-4.png]]

- 输入 /effort
- 选择该模式，那么 claude code 就会以 xhigh 的聪明程度进行处理任务

==在该模式下 claude code 会自动拆解理解任务，并规划好任务区分，并将任务分配给各个子 agent；简单且高效==