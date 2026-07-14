
[[index]]

previous article  [[mode]]

next article  [[agent]]

---

# 1. introduction to skill（skill介绍）

==下面有四种 skill 格式，前面三种仅为了解，一般适用于开发使用；但是我们日常使用和最方便使用的是最后 front matter + markdown 格式==

---

## SON Schema 格式（函数调用型）

这是目前大模型生态中应用最广泛的标准，由 OpenAI 引入，并被 Anthropic、Google Gemini 等厂商全面采纳的 **Function Calling（函数调用）** 规范

- **格式特点**：纯 JSON 结构。它不包含具体的执行代码，而是向模型声明函数的名称、功能描述以及严格的参数类型约束。模型阅读此 JSON 后，决定是否输出符合该格式的参数
    
- **适用场景**：API 接口对接、数据库查询、外部计算器联动等硬核编程工具
    
- **核心结构**：

```

{
  "name": "get_current_weather",
  "description": "Get the current weather for a given location",
  "parameters": {
    "type": "object",
    "properties": {
      "location": { "type": "string", "description": "The city and state, e.g. San Francisco, CA" },
      "unit": { "type": "string", "enum": ["celsius", "fahrenheit"] }
    },
    "required": ["location"]
  }
}
```

---

## YAML / JSON 配置 + 代码托管格式（云服务架构型）

传统语音助手（如 Amazon Alexa Skill）以及部分企业级 Agent 平台（如 Dify、Coze 的插件系统）使用的格式

- **格式特点**：将配置与代码彻底分离。配置文件（YAML 或 JSON）只声明技能的意图（Intents）和槽位（Slots），具体的业务逻辑则指向一个远程的 Webhook URL 或云函数（如 AWS Lambda）
    
- **适用场景**：语音助手技能开发、低代码 Agent 平台的插件集成
    
- **核心结构**（以 Alexa 意图配置为例）：

```
interactionModel:
  languageModel:
    invocationName: my custom skill
    intents:
      - name: OrderPizzaIntent
        samples:
          - 'please order a {size} pizza'
          - 'i want to buy a pizza'
        slots:
          - name: size
            type: AMAZON.Food
```

---

## 纯代码装饰器格式（代码原生型）

在开发框架（如 LangChain、Semantic Kernel、AutoGPT）中，开发者直接在编程语言中定义 Skill，无需编写额外的配置文件

- **格式特点**：直接利用编程语言（如 Python、TypeScript）的**装饰器（Decorator）** 或**注释文档（Docstring）**。框架在启动时会自动解析代码中的文档注释，将其转换为大模型可读的技能描述
    
- **适用场景**：纯代码驱动的 Agent 应用开发
    
- **核心结构**（Python 示例）：

```
from langchain.agents import tool

@tool
def calculate_mortgage(principal: float, rate: float, years: int) -> float:
    """
    计算房屋贷款每月还款额。当用户需要计算房贷、利息或月供时使用此工具。
    参数 principal 为贷款本金，rate 为年利率（如 0.05），years 为贷款年限。
    """
    # 具体的计算逻辑代码
    return monthly_payment
```

---
## front matter + markdown 格式（文档驱动型）

**原理：**  
LLM 的 ==**prompt skill**== 本质上是一套可复用、可组合的提示词模板，它将模型完成某一类任务所需的行为逻辑进行结构化封装，使模型能够稳定调用相同的思考模式，而不必每次重新编写 prompt

**作用：**  
prompt skill 能够降低 prompt 编写成本，提高模型回答的一致性、准确性和可维护性，并通过模块化设计实现技能的复用、迭代与组合，使 LLM 从通用对话工具转变为能够稳定执行特定任务的专业智能体

**结构：**  
一个完整的 Prompt Skill 通常由**任务目标（Objective）**、**角色定义（Role）**、**上下文信息（Context）**、**执行流程（Workflow）**、**规则约束（Constraints）**、输出格式（Output Format）以及**示例（Examples，可选)** 等部分组成，各模块共同约束模型的输入、推理过程与输出结果，从而保证任务执行的稳定性和可复现性

==**以下是比较简单的 skill 结构说明（符合简单的日常使用）**==

![[skill-2.png]]

- 一个完整的 skill 是一个文件夹（文件夹命名为 skill 名称）内包含 ==SKILL.md 这个命名（只能这个命名）== markdown 格式的文档（核心）
- 有些比较复杂的 skill 可以新建一个 references（参考） 文件夹来存放更多信息
- references 内也必须为 markdown 格式，命名无特别要求

==SKILL.md 与 references 内文件的关系如下==：

例如 skill 文件结构为：

```
power-48-laws
- SKILL.md
- references
	- 48-laws-full.md
	- 48.laws-details.md
```

在 SKILL.md 中就可以引用 references 内的文件内容；那么 LLM 则会按需要进行读取信息，减少了 token 的过度消耗

**在 SKILL.md 内引用 references 文件的格式为**：

```
更多细节参考 `references/48-laws-full.md`
```

![[skill-1.png]]

**如上图所示，这就是 SKILL.md 的文件格式和内容**

==其中最重要，且格式最严格的部分为被框起来的第一部分==，格式必须严格执行，且 skill 命名必须为英文

```
---
name: [技能的唯一英文标识符，如：data-cleaning-expert]
description: >-
  [详细的技能描述与自动触发说明。此处需使用自然语言详细阐述：该技能的核心功能是什么？
  在何种场景下应该被激活？包含哪些触发关键词？
  例如：当用户提到数据清洗、格式转换、处理缺失值、去除重复项，或者提及关键词“数据清洗”、“格式对齐”时触发。
  说明该技能的处理边界，确保 Agent 能够在语义匹配时主动唤醒此技能。]
---

# [技能的正式标题，如：Data Cleaning & Preprocessing Expert Skill]

[关于本技能的简要概述，阐明其核心设计目的与最终能为用户解决什么问题。]

## ## Language Mirroring Rule

**CRITICAL: The skill must respond in the same language the user uses.** If the user writes in Chinese, respond entirely in Chinese (distinguishing between Simplified and Traditional Chinese). If the user writes in English, respond entirely in English. The skill content (analysis templates, workflow descriptions, reference material) is in English, but the response to the user must match their language. Never switch languages mid-conversation - once the user establishes a language, stay in it.

## ## Trigger Conditions

This skill auto-triggers in the following scenarios:

1. **[触发场景分类 1，如：Format Inconsistency]**: [具体场景描述，如：The user provides data with messy formatting or mixed data types in a single column.]
2. **[触发场景分类 2，如：Explicit Request]**: [包含的显式触发词列表，如：The user asks "clean this data", "fix formatting", "handle missing values" / "帮我清洗数据", "格式化文本", "处理空值".]
3. **[触发场景分类 3，如：Implicit Analysis]**: [隐式触发条件，如：The user uploads a CSV/JSON file and complains about generic loading errors or parser crashes.]

## ## Analysis Flow / Execution Steps

### ### Phase 0: Situation Assessment
[阶段 0 的具体执行指令。例如：检查输入数据的编码格式，识别当前的数据结构定义。]

### ### Phase 1: Error Identification
[阶段 1 的具体执行指令。例如：扫描数据中的 null 值、异常极值以及不符合字段类型定义的脏数据。]

## ## Output Format Rules
[定义最终输出给用户的格式规范，如：必须包含清洗前后的对比表格、错误日志列表以及优化建议。]
```

---

# 2. skill 的使用

![[skill-3.png]]

- 在 claude code CLI 界面中输入 ==**/skills**== 即可显示所有存储在 ~/.claude/skills 内的 skill
- 在这个界面中不能选择使用相应的 skill
- 按回车或者空格键会更改 skill 状态
	- on 通常保持这个模式正常使用即可
	- user-only 该状态只能用户手动触发
	- name-only 该状态也是只能用户手动触发，并且必须使用 / + skill name 才能触发
	- off 该模式是直接屏蔽掉skill
- 按 esc 退出该界面

---

![[skill-4.png]]

- 在 claude code 当中正常的触发
- 使用 / + skill name 回车即可触发
- 或者 / + skill name + prompt
- 一般输入 / + 关键词后就会有相关 skill 在下方显示，可以通过回车进行触发

---

![[skill-5.png]]

- 如上图所示，我给 claude code 所提供的 prompt 为一个 X 文章的网址 + ,md
- 那么为什么会触发 skill（obsidian-article）呢
- 是因为我在 obsidian-article 的 SKILL.md 文档内写了触发条件为：URL,md
- 所以 claude code 就会触发 skill 并执行 skill 内所要求的 workflow（工作流）

---

# 3. skill 安装工具

由于 claude code CLI 端并没有内置系统性的 skill 安装程序，所以当我们从 github 上安装 skill 到 claude code 时会有一点麻烦；对此我制作了一个针对于 WSL + Ubuntu 环境下 claude code 的 skill 安装工具

==只需要给 claude code 发送以下 prompt 即可安装工具==：

```
https://github.com/leiyueoh/clone-skill 参考项目的 readme 安装这个工具
```

该工具会优化 CLAUDE.md ，后续有需要安装的 skill，==只需要给 claude code 提供相应的 github 仓库地址==，claude code 会自动下载并将 skill 文件放置 ~/home/user/.claude/skills 内，后续可直接在 claude code CLI 界面中直接触发使用

---

# 4. skill 的探索和推荐

## skill 探索

可以通过在 X（推特）上搜索，进行探索；有些高质量帖子或文章会有详细的介绍并且附上 github 仓库地址

以下是一些比较高质量的 skill 收录网站

[Live trending GitHub repositories — daily momentum ranking | Trendshift](https://trendshift.io/)

[Awesome Claude Skills — Directory of Claude Agent Skills - Awesome Claude](https://awesomeclaude.ai/awesome-claude-skills)

https://www.skills.sh 该网站为 **The Agent Skills Directory**，是由 Vercel 开发的一个针对 AI 智能体（AI Agents）的开源技能生态系统平台，可以在该网站中探索各种 skill。不过这个网站本质是整合了 github 上的开源项目

![[skill-7.png]]

- 在 skills.sh 中选择相应的 skill，会看到框起来的部分有一条 shell 指令
- 如果直接使用这个 shell 指令进行 npx 安装，那么 skill 所下载的路径不是 ~/.claude/skills，那么 claude code 就无法识别
- 不过这个指令中包含了该 skill 所对应的 github 仓库

![[skill-6.png]]

- 我们复制该指令，然后丢给 claude code 即可

**按照以下 prompt 即可触发上面所安装的 skill 安装工具**：

```
npx skills add https://github.com/vercel-labs/agent-browser --skill agent-browser，安装该 github 上的skill
```

---

## 必装 skill

### find-skills

**核心功能**:

**find-skills** 是一个用于扩展智能体（Agent）能力的工具。它的主要功能是帮助用户从开放的智能体生态系统中，发现并安装满足特定需求的专业化 agent skills

**主要用途**:

当用户提出以下需求时，适合使用该 skill：
- 询问如何完成某项特定任务（例如 “如何做到某事” 或 “寻找用于某事物的 skill”）
- 询问智能体是否具备某种专业化能力
- 表现出扩展智能体能力或寻找特定领域的工具、模板和工作流的意愿

![[skill-8.png]]

通过 /find-skills + 需求即可触发 skill 并寻找相符合的 skill，claude code 会列出多个 skill 选择并做出简介，选择安装即可（安装路径会依照之前写进 CLAUDE.md 里的路径 ~/.claude/skills）

---

### skill-cteator

**核心功能**：

**skill-creator** 是一个用于创建、测试和迭代优化 AI 智能体（Agent）技能的工具。它为开发者提供了一套结构化的评估和基准测试流程，以提升技能的质量和触发准确率

**主要用途与工作流**：

该技能引导用户完成技能开发的完整生命周期：
- **意图捕获与起草**：明确技能的核心功能，并撰写初步的代码或逻辑草案
- **测试与定量对比**：自动生成测试用例，并并行运行“启用该技能”与“不启用该技能”的测试对比，从而精确记录执行时间（Latency）和 Token 消耗情况
- **可视化评审**：通过生成基于浏览器的交互式评审页面（`eval-viewer/generate_review.py`），直观展示各次迭代的输出结果、定性反馈以及通过率等基准指标
- **触发描述优化**：系统会生成 20 个包含正向和反向的实际查询用例，通过最多 5 轮的迭代优化，确保技能触发的准确性

![[skill-9.png]]

==**可以使用该 skill 并提出比较模糊的想法，后续 claude code 会逐步引导，并产出规范的 skill 文件，并且在最后还会形成一个 HTML 可视化文件进行验证检测，同时会有一个用户反馈，claude code 会根据反馈进行优化迭代**==

---

## 上述 skill 的安装

为了方便，我已将这两个 skill 整合存放到了 github 仓库，输入以下 prompt 即可安装（自动触发并使用 skill 安装工具）：

```
https://github.com/leiyueoh/skills，安装该仓库里的两个 skill
```

---

乔布斯.skill 思维模型 + 现实扭曲力场 + 决策风格，已开源。 [https://github.com/alchaincyf/steve-jobs-skill](https://t.co/Cf7Kae1FTd) 

马斯克.skill 第一性原理、硬核执行力、推文风格。 [https://github.com/alchaincyf/elon-musk-skill](https://t.co/G5nv93WR11) 

芒格.skill 多元思维模型、反向思考、投资决策神器。 [https://github.com/alchaincyf/munger-skill](https://t.co/xgXuRXusLV) 

费曼.skill 教你怎么讲课、拆解复杂问题、讲物理/学习方法。 [https://github.com/alchaincyf/feynman-skill](https://t.co/VK1pRRW5sd) 

纳瓦尔.skill 财富、幸福、人生哲学，播客级智慧。 [https://github.com/alchaincyf/naval-skill](https://t.co/51QFLJ5n10) 

塔勒布.skill 黑天鹅、反脆弱、风险评估专家。 [https://github.com/alchaincyf/taleb-skill](https://t.co/exTXDxXakn) 

Paul Graham.skill 创业思维、写作、产品哲学。 [https://github.com/alchaincyf/paul-graham-skill](https://t.co/BLal4704HK) 

张一鸣.skill 算法思维、组织管理、产品迭代。 [https://github.com/alchaincyf/zhang-yiming-skill](https://t.co/bnHcUk4ykq) 

Karpathy.skill AI/深度学习教学 + 技术直觉。 [https://github.com/alchaincyf/karpathy-skill](https://t.co/APlrlM58uM) 

Ilya Sutskever.skill AI前沿思考 + 模型哲学。 [https://github.com/alchaincyf/ilya-sutskever-skill](https://t.co/dpRsPxk1Qt) 

特朗普.skill 谈判风格、推文艺术、现实扭曲（已验证超像）。 [https://github.com/alchaincyf/trump-skill](https://t.co/t5E0iUGOhP)