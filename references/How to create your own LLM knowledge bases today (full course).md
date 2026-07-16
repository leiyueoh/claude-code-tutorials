---
title: How to create your own LLM knowledge bases today (full course)
source: https://x.com/hooeem/status/2041196025906418094
---
![图片](https://pbs.twimg.com/media/HFPI3-PboAEpm2d?format=jpg&name=large)

如果你能学会创建大型语言模型知识库，那么你实际上就创造了自己的“外部大脑”，你可以利用它，此外，这还可能改变你经营业务、内容、网络和生活的方式，这一切都可以通过你自己定制的外部大脑来运行。事实上，如果你能与本地企业建立联系并向他们展示为整个业务打造外部智慧的价值，可能就有市场。

**发生了什么？**

Andrej Karpathy出现了，展示了他如何使用LLM知识库，这些知识本质上就像外部大脑......

> 4月3日
> 
> LLM 知识库 我最近发现非常有用的一点是：利用大型语言模型（LLM）来建立各种研究兴趣主题的个人知识库。这样一来，我最近的代币吞吐量中有很大一部分投入到操作代码上，而不是操作代码

所以，我想在这份完整指南中一步步展示这个系统，于是我和我的朋友Claude来回沟通，我们决定讨论三个版本来创建大型语言模型知识库，以下是它们......

选择你的版本：

1. 完整初学者>点击CTRL F并输入：“你的第一个知识库”
2. 熟悉 AI 工具>点击 CTRL F 并输入“THE FULL SYSTEM”，然后自动阅读。
3. 开发者/开发者>点击CTRL F，输入“THE FULL SYSTEM”，然后读完整个流程。

**在你开始前，问问自己是否想这么做并阅读这篇：**

大多数人把AI当作失忆的搜索引擎。

你问了个问题，得到答案，然后关闭标签页。明天你得从头开始。没有积聚。没有什么会叠加。你是在烧代币，反复发现同样的背景。

卡帕西的系统完全颠覆了这一点：

1. **你收集原材料。** 文章、论文、YouTube文字稿、PDF，任何与你关心的主题相关的内容
2. **AI会阅读所有内容并编写结构化的维基。** 摘要、概念解释、思想间的联系、主索引
3. **你会对着维基提问。** 它根据自身汇编的知识进行研究，并给出引用的综合答案
4. **每个答案都会被归档回维基。** 所以下一个问题受益于之前所有的努力
5. **AI会定期检查维基的健康状况。** 发现矛盾、漏洞、过时的信息并加以修正

结果呢？一个每次触摸都会变得更智能的个人知识库。

经过一个月的养育，你拥有了一个深度互联的资源，任何谷歌搜索都无法复制。因为它是综合的，而不仅仅是索引。

**这适用于任何话题。** 加密市场。医学研究。法律判例法。竞争情报。学术研究。哲学。如果你想随着时间积累和连接知识，这就是系统。

## 1：你的第一个知识库：

这里不需要任何技术（tekkerzzz是英国俚语，指球员，而那又是英国俚语，指的是有足球技巧的人，实际上就是说你有技能，我本可以直接说零技能，但那不是我，所以零tekkerzz就是init）......

如果你能安装应用并复制粘贴文字，现在就能做到。

你需要什么

- **Obsidian**（免费）。一个使用纯文本文件的笔记应用。下载自 [obsidian.md](https://obsidian.md/).Mac、Windows、Linux、iOS、Android。
- **Claude订阅**（每月20美元Pro，地点为 [claude.ai](https://claude.ai/)).或者你喜欢的任何AI聊天机器人：ChatGPT、Gemini，随你怎么选。

就这样。

步骤1：创建你的金库（2分钟）

打开黑曜石。它会让你创建或打开一个“保险库”。保险库只是你电脑上的一个文件夹，笔记就存放在那里。

1. 点击**“创建新保险库”**
2. 用一个描述性的名字（比如“加密研究”或“健康知识”）
3. 选择保存在哪里（文档文件夹没问题）
4. 点击**“创建”**

你现在有一个空的金库。黑曜石盯着这个文件夹。你放入的任何标记文件都会自动显示为备注。

步骤2：创建两个文件夹（1分钟）

在Obsidian左侧边栏，右键点击并选择**“新建文件夹**”。创建这两个：

- 原始素材（文章、笔记、你收集的任何东西）
- 关于AI构建你编译知识库的维基

这就是你整个起始结构。

步骤3：添加你的第一个原始资料（5分钟）

选一个你真正感兴趣的话题。找3到5篇关于它的好文章。对每个人：

1. 在Obsidian中，右键点击RAW文件夹**\>“新笔记”**
2. 给它一个描述性的名字（例如“bitcoin-halving-2024-explainer”）
3. 将文章文本复制粘贴到备注中
4. 在最顶部添加一行，比如：来源：\[将网址粘贴在这里\]

别想太多格式。别为结构感到压力。直接把原文放进去就行了。

**快速获胜：**安装**Obsidian Web Clipper**浏览器扩展（免费，Chrome/Firefox/Safari/Edge）。它能一键将网页保存为格式化的 markdown 笔记，直接存入你的保险库。但第一次尝试时，复制粘贴完全没问题。

步骤4：让AI编译你的维基（5分钟）

打开Claude（或者你喜欢的AI）。复制粘贴此提示，替换括号中的部分：

```markdown
I'm building a personal knowledge base about [YOUR TOPIC].

I have [NUMBER] source articles. I'm going to paste them below.
For each source, please:

1. Write a 200-word summary capturing the key points
2. List the main concepts mentioned (as a simple list)
3. Identify any connections between this source and the others

After processing all sources, please:
4. Write a "master index" listing every concept with a one-line
   description
5. Write one "concept article" (300-500 words) for the single
   most important concept across all sources

Format everything as markdown. Use [[double brackets]] around
concept names so they work as links in Obsidian.

Here are my sources:

[PASTE YOUR RAW NOTES HERE, separated by --- between each one]
```

Claude 会产出结构化的输出。将每个章节复制到你的维基文件夹内的新笔记中：

- 将摘要保存为单独笔记（例如 wiki/summary-bitcoin-halving.md）
- 把主索引保存为wiki/index.md
- 请用描述性名称保存概念条目到 wiki/

第五步：见识魔力

打开Obsidian的**图表视图**（点击左侧边栏的图表图标，或按Ctrl/Cmd+G）。

你会看到笔记以点状排列，通过AI创建的\[\[wikilinks\]\]连接。这是你的知识库，被可视化为一个连接的思想网络。

点击笔记中的任意\[\[链接概念\]\]。如果有相关页面，Obsidian 会打开它。如果还不存在，Obsidian愿意帮忙创造。这就是维基自然成长的方式。

**你现在拥有了一个可用的知识库。** 接下来的一切都是为了让它更大、更快、更强大。

## 扩展你的知识库（每日习惯）

一旦有了基本结构，工作流程就变得非常简单了：

新增资料来源

每当你读到值得收藏的东西时：

1. 剪辑或粘贴到你的RAW文件夹里
2. 打开Claude并粘贴这个：

```markdown
I'm adding a new source to my knowledge base about [TOPIC].

Here is my current wiki index (so you know what already exists):
[PASTE the contents of wiki/index.md]

Here is the new source:
[PASTE the new article]

Please:
1. Write a summary of this source
2. Update my index with any new concepts
3. Note any connections to existing concepts (mark these with
   [[wikilinks]])
4. Flag anything that contradicts existing wiki content with ⚠️
```

1. 把输出保存到你的维基文件夹里，用更新后的索引替换旧的索引

提问

这才是真正强大的地方。一旦你整理了10+篇文章：

```markdown
Here is my knowledge base index:
[PASTE wiki/index.md]

My question: [YOUR QUESTION]

Please research the answer using the concepts and sources in my
wiki. If you need to see specific articles, tell me which ones
and I'll paste them. Cite your sources using [[wikilinks]].

After answering, save the answer as a markdown file I can add
to my wiki.
```

**关键习惯：答案总是归档到维基。** 把它保存到你的维基文件夹里。这就是复利循环。每个问题都丰富了未来问题的基础。

每周健康检查

每周一次，把你的完整索引粘贴到 Claude 上，附上以下内容：

```markdown
Here is my knowledge base index:
[PASTE wiki/index.md]

Please perform a health check:
1. Which concepts are mentioned but don't have their own article
   yet? (These are gaps I should fill)
2. Are any summaries likely outdated? (Flag anything over 6 months
   old)
3. What are 3 interesting questions I could research next?
4. Are there orphan concepts with no connections to other topics?
```

每周三次互动。一两个来源补充，偶尔提问，还有一次健康检查。这就是知识库稳步增长所需的全部。

## 2：完整系统：

## 完整系统：架构与设置

以上所有功能只用Obsidian和Claude Chat就能正常工作。但如果你想要Karpathy实际描述的系统，即AI自动处理文件创建、维护和索引，这里有完整的架构。

三层设计

**第1层：原始源（RAW/文件夹）。** 你唯一的真相来源。AI从这里读取，但从不修改它。文章、论文、仓库、数据集、图片都在这里。可以把它想象成你图书馆的收纳书架。

**第二层：编译后维基（wiki/文件夹）。**由AI生成并维护。摘要、概念文章、实体页面（人员、组织、工具）、交叉链接、索引和查询输出都在这里。你很少直接编辑这些内容。AI负责写作。

**第3层：模式（CLAUDE.md 文件）。** 一份配置文档，告诉AIwiki的结构、应遵循的命名规范以及可用的操作。这是控制人工智能行为的程序。它存在你保险库的根文件夹里。

四个运营周期

这些内容不断重复，进一步提升了维基的价值：

**吞下。** 你会添加原始资料。AI会阅读这些内容，生成摘要、概念页和关联。

**编译。** AI负责构建和更新维基页面，维护索引，并将新信息编织进现有结构中。

**查询。** 你会问问题。AI会在维基上进行研究，生成引用的答案，这些答案会被归档回去。

**绒毛。** AI会检测矛盾、漏洞、断链、陈旧内容和缺失页面。它能修复的就修正，标记不能修复的。

完整的文件夹结构

在你的黑曜石宝库里创建这个：

```markdown
my-knowledge-base/
├── raw/
│   ├── articles/          ← Web-clipped articles
│   ├── papers/            ← Academic papers, PDFs
│   ├── repos/             ← Code documentation
│   ├── datasets/          ← Dataset descriptions
│   └── assets/            ← Images from sources
├── wiki/
│   ├── index.md           ← Master index (AI-maintained)
│   ├── log.md             ← Activity log (AI-maintained)
│   ├── concepts/          ← One file per concept
│   │   └── _index.md      ← Category overview
│   ├── entities/          ← People, orgs, tools
│   │   └── _index.md
│   ├── sources/           ← One summary per raw source
│   │   └── _index.md
│   ├── syntheses/         ← Cross-cutting analyses
│   │   └── _index.md
│   ├── outputs/           ← Filed query results
│   │   └── _index.md
│   └── attachments/
│       └── images/        ← AI-generated charts, diagrams
├── templates/             ← Note templates
└── CLAUDE.md              ← AI schema/instructions
```

你不需要第一天就拥有所有子文件夹。先从原始、维基和 CLAUDE.md 开始。随着维基的增长，添加子文件夹。

为你的文件命名

所有文件名均使用**kebab大写**（小写，单词用连字符分隔）：

- active-inference.md✓
- 主动 Inference.md ✗
- active\_inference.md ✗

对于来源摘要，请使用 author-year-short-title.md（例如 friston-2010-free-energy.md）。对于概念，直接使用概念名称（例如 transformer-architecture.md）。

**为什么这很重要：**kebab-case 适用于所有操作系统，支持网址，且 AI 能一致引用。相信我。等你有200+个文件时，你会感谢自己的。

## 搭建你的AI环境

无论你选哪个工具，基本的工作流程都是一样的。AI会读取你的Markdown文件，处理它们，然后生成Markdown输出。不同的是 AI访问你文件的方式。

选项A：Claude聊天（最简单，无需技术技能）

**大多数人应该从这个开始。**

克劳德·查特[claude.ai](https://claude.ai/)无法直接写入你的电脑文件。你处于复制粘贴循环中：上传或粘贴文件，让Claude处理，再把输出复制回你的保险库。

**设置：**

1. 前往[claude.ai](https://claude.ai/)并登录（建议按月20美元订阅专业版）
2. 创建**项目**（左侧栏>项目>新项目）
3. 在项目说明中，粘贴你的 CLAUDE.md 文件内容
4. 将你的原始资源和现有维基文件上传到项目中

该项目中的每一次对话现在都有持续的背景。Claude会记住你的维基结构和对话中的惯例。

**工作流程：**

- 粘贴新源码时>Claude会生成维基页面>你将它们复制到Obsidian中
- 提问时>Claude会生成引用答案>你将其保存为笔记
- 请求健康检查>Claude会识别问题>你进行修复

是的，是手动的。但它运行可靠，且不需要终端知识。

选项B：Claude代码（最强大，需要终端舒适度）

Claude Code 是 Anthropic 的命令行工具，支持完整的文件系统访问。它直接读取、写入、创建和修改文件。非常适合自动化维基维护。

**在选择此选项之前：**

- 你需要基本的终端操作（导航文件夹、执行命令）
- 最低 Pro 订阅费每月 20 美元，最大套餐 100 美元或 200 美元用于重度使用。
- Claude Code 没有免费套餐

如果你想继续，那就去Claude Code开始一个会话。

在终端里进入你的保险库文件夹，输入 claude 开始会话。Claude Code 会自动从保险库根读取你的 CLAUDE.md 文件。

**它的强大原因：**Claude Code 可以读取你所有的文件，创建新的维基页面，编辑已有页面，运行搜索工具，并执行脚本。而且你完全没有复制粘贴任何内容。一个提示，比如“处理所有新文件在 RAW/”，就能自动触发整个导入-编译循环。

选项C：其他AI工具

有几个替代方案也支持这种工作流程，但我用的是Claude Code，不过Codex也可以，因为任何工具的核心要求都是一样的：读取markdown文件进来，输出Markdown文件。

## 写作 CLAUDE.md：控制一切的图式

CLAUDE.md 文件是系统中最重要的单一文件。它会准确告诉AI你的维基结构、应遵循的规则以及它能执行哪些操作。

可以把它看作是你AI研究图书管理员的工作描述。

如果你用的是Claude Code，这个文件会在每次会话开始时自动加载。如果你用的是Claude Chat，可以把它粘贴到你的项目说明里，或者每次对话的开头。

模板（复制这个，自定义第一行）

```markdown
# LLM Knowledge Base — Schema

## Overview
Personal knowledge base on [YOUR TOPIC HERE — e.g., "DeFi protocols
and yield strategies" or "machine learning fundamentals"]. Raw sources
live in raw/. The compiled wiki lives in wiki/. You (the AI) maintain
all wiki content. I direct strategy; you execute compilation,
maintenance, and queries.

## Directory Structure
- raw/ — Source material (read-only for you, I add files here)
- wiki/index.md — Master index linking every page with a one-line
  summary
- wiki/log.md — Append-only changelog of all operations
- wiki/concepts/ — One article per concept
- wiki/entities/ — People, organisations, tools (one per file)
- wiki/sources/ — One summary per raw source document
- wiki/syntheses/ — Cross-cutting analysis articles
- wiki/outputs/ — Filed answers to my queries

## File Conventions
- All filenames: kebab-case, lowercase (e.g., active-inference.md)
- Source summaries: {author}-{year}-{short-title}.md
- Every page MUST have YAML frontmatter at the top:
  ---
  title: "Page Title"
  date_created: YYYY-MM-DD
  date_modified: YYYY-MM-DD
  summary: "One to two sentences describing this page"
  tags: [topic-tag, domain-tag]
  type: concept | entity | source | synthesis | output
  status: draft | review | final
  ---
- Use [[wikilinks]] for all internal cross-references
- Link only the first occurrence of a concept per section
- Bold key terms on first use in each article

## Operations

### INGEST (when I add new raw sources)
1. Read the new source document
2. Create a source summary in wiki/sources/
3. Identify concepts and entities mentioned
4. Create new concept/entity pages if they don't exist yet
5. Update existing pages with new information (append, don't
   rewrite from scratch)
6. Add [[wikilinks]] to connect new content to existing pages
7. Update wiki/index.md with new entries
8. Append to wiki/log.md

### QUERY (when I ask a question)
1. Read wiki/index.md to understand available content
2. Read the relevant wiki pages
3. Synthesise an answer with citations to wiki pages
4. Save the answer as wiki/outputs/{question-slug}.md
5. Update wiki/index.md and wiki/log.md

### LINT (periodic health check)
1. Find contradictions between pages
2. Find orphan pages (no inbound links)
3. Find broken [[wikilinks]]
4. Identify missing frontmatter fields
5. Flag stale content (source date >6 months, no updates)
6. Suggest new articles for frequently mentioned but unlinked
   concepts
7. Output a report and fix what you can automatically

## Page Creation Threshold
- Create a full concept/entity page when a subject appears in 2+
  sources
- For single-mention subjects, create a stub page (frontmatter +
  one-line definition + link back to the source that mentioned it)
- Never leave a [[wikilink]] pointing to nothing — always create
  at least a stub

## Quality Standards
- Summaries: 200-500 words, synthesise — don't copy
- Concept articles: 500-1500 words with a clear lead section
- Always trace claims to specific source pages
- Flag contradictions with ⚠️, noting both positions
- Prefer recency when sources conflict
```

**保持这份文件简洁。** 每一行都会消耗你的AI上下文窗口预算。告诉AI如何查找信息，而不是把所有信息都包含在内联。上面的模板刻意设计在80行以内。抵制过度具体的冲动。

## 利用Web Clipper实现超充数据收集

手动复制文章是可行的，但**Obsidian Web Clipper**浏览器扩展让收集速度大大加快。只需点击一下，页面就能在你的保险库内变成干净的降价记录。

安装

从浏览器的扩展商店（Chrome、Firefox、Safari、Edge）安装免费开源扩展。点击浏览器工具栏中的Obsidian图标，然后点击齿轮图标进行配置。

配置

设置这些：

- **通用> Vault：请**完全按照Obsidian中显示的地址输入你的Vault名称
- **模板 > 默认模板 > 备注位置**：设置为 raw/articles/
- **模板 > 默认模板>属性**：添加以下元数据字段：

```yaml
---
title: "{{title}}"
source: "{{url}}"
author: "{{author}}"
published: "{{published}}"
clipped: "{{date}}"
tags:
  - raw
type: article
status: raw
---
```

- **模板 > 默认模板 > 备注内容**：设置为 {{content}}

这能给你带来什么

阅读一篇值得保存的文章？点击浏览器工具栏中的Obsidian图标，确认模板，点击**“添加到Obsidian**”。完成了。文章会以格式化的标记记录形式出现在你的 raw/articles/ 文件夹中，准备让 AI 处理。

让图片离线运行

默认情况下，网页剪辑器将图片保存为网页链接，当页面离线时这些链接会中断。用 **Local Images Plus** 插件解决这个问题：

1. 在Obsidian中：设置>社区插件>关闭限制模式>浏览
2. 搜索“Local images plus”并安装
3. 在插件设置里，把下载文件夹设置为 raw/assets/
4. 在剪辑后运行“Localise attachments”命令

该程序会在本地下载所有引用的图片。一切都离线运行，如果你使用具备视觉功能的模型，AI还能引用图像。

非网络资源的转换

对于PDF、Word文档及其他文件，请使用**MarkItDown**（Microsoft的免费工具）：

```bash
pip install markitdown
markitdown document.pdf > raw/papers/document-name.md
```

不习惯用命令行吗？打开PDF，全部选择，复制，粘贴到RAW/的新笔记中。格式可能不会完美，但AI只需要文本内容。

## 维基汇编：将原始资源转化为结构化知识

这是核心行动。你收集了资料。现在AI会把它们汇编成一个活维基。

首次合辑

**如果使用Claude代码**，请在终端操作你的保险库，输入：claude，然后输入：

```markdown
Read CLAUDE.md for project conventions. Then read all files in
raw/articles/. For each raw source:
1. Create a source summary page in wiki/sources/
2. Identify key concepts and entities
3. Create concept pages in wiki/concepts/ and entity pages
   in wiki/entities/
4. Add cross-references between all related pages using
   [[wikilinks]]
5. Generate wiki/index.md with categorised links and one-line
   summaries
6. Generate wiki/log.md with entries for each operation
Start with the first 5 sources, then continue with the rest.
```

**如果用Claude Chat**，上传原始源文件（或粘贴）和 CLAUDE.md，并使用相同的提示。你需要手动把每个生成的页面复制到正确的文件夹里。

对于十篇文章，预计包含大约10篇来源摘要、15到30个概念/实体页面，以及一个全面的索引。通常只需一次对话，并有几次后续。

增量编译（添加新源）

初始构建后，每个新源都会触发增量更新，而不是重新处理所有内容：

```markdown
A new source has been added: raw/articles/new-article-title.md
Read it, then read wiki/index.md to understand existing coverage.
Produce:
1. A new source summary page
2. Updates to EXISTING pages (append, don't rewrite)
3. New concept/entity pages if needed
4. Updated index.md and log.md entries
Flag any contradictions with existing wiki content using ⚠️
```

**这是关键的效率原则：**人工智能将新的资源整合进现有结构，而不是从零重建。快速且高效。

当事情出错时（而且肯定会出错）

AI偶尔会输出不完美的结果。完全正常。你将会遇到以下情况：

**缺少或畸形的前置物。** AI有时会忘记页面顶部的YAML模块，或者格式错误。修正方法：在下一个提示中提醒它（“请确保所有页面都包含 CLAUDE.md 中指定的完整YAML前置”）。

坏掉的**维基链接。** AI创建了一个尚未存在的页面\[\[链接\]\]。解决办法：这其实没问题。在Obsidian中，点击断开的链接可以创建该页面。你也可以让AI在lint pass时为所有未关联的概念创建存根页面。

幻**觉连接。** AI声称两个概念相关，但源材料并不支持。修正：这正是为什么要保持原始源不变。你总可以核对理赔和原件。标记可疑关联，并让AI用具体的引用来验证。

**上下文窗口溢出。** 如果你的维基越来越大，AI就无法一次全部阅读。解决办法：始终从索引文件开始，然后只加载所需的特定页面。

## 主目录：AI如何导航你的维基

索引文件是让整个系统在没有复杂数据库基础设施的情况下正常运行的关键。这是AI首先读取的目录，允许它决定为任何任务加载哪些具体页面。

一个好的指数是什么样子（示例）：

```markdown
---
title: "Wiki Index"
date_modified: 2026-04-06
total_articles: 47
---

# Wiki Index

## Overview
This wiki covers DeFi yield strategies and protocol analysis.
47 articles compiled from 32 raw sources.

## Concepts (18 articles)
- [[automated-market-maker]] — Mechanism for decentralised token
  exchange using liquidity pools instead of order books | sources: 5
- [[impermanent-loss]] — Opportunity cost faced by liquidity
  providers when token prices diverge | sources: 3
- [[yield-farming]] — Strategy of deploying capital across DeFi
  protocols to maximise returns | sources: 7

## Entities (12 articles)
- [[uniswap]] — Largest decentralised exchange by volume,
  pioneered the constant product AMM | sources: 6
- [[aave]] — Lending protocol enabling variable and stable rate
  borrowing | sources: 4

## Source Summaries (32 articles)
- [[adams-2024-uniswap-v4]] — "Uniswap v4: Architecture" | tags: paper, dex

## Recently Added
1. [2026-04-06] [[concentrated-liquidity]] (concept)
2. [2026-04-05] [[eigenlayer-restaking]] (concept)
```

每个条目都有一个\[\[wikilink\]\]、大约50字的摘要、关键标签和来源数量。 **这种格式允许AI扫描你整个维基内容，大约用6500个代币，涵盖100篇文章。** 与现代上下文窗口相比，简直小得多。

**活动日志**

wiki/log.md 是一个仅附录记录，跟踪每一项操作：

```markdown
# Wiki Log

## [2026-04-06] ingest | Uniswap V4 Paper
- Created: wiki/sources/adams-2024-uniswap-v4.md
- Updated: wiki/concepts/automated-market-maker.md
- Created: wiki/concepts/concentrated-liquidity.md (new)

## [2026-04-06] query | How do AMM affect MEV?
- Filed: wiki/outputs/amm-hooks-mev-impact.md
```

完整的审计记录。这有助于AI理解最近发生了什么。

## 提问：复利循环

一旦你的维基达到10到20篇汇编文章，你就可以开始提出跨多个来源综合的复杂问题。

查询提示：

```markdown
Read wiki/index.md. I want to understand: [YOUR QUESTION]

Research the answer across the wiki's content — read the relevant
pages, synthesise an answer with citations to specific wiki pages,
and save it as wiki/outputs/[question-slug].md. Update index.md
and log.md.
```

AI会读取索引，识别相关页面，阅读它们，并生成引用答案。如果用Claude Chat，你会手动粘贴索引和相关页面。

**关键步骤是把答案归档。** 保存在wiki/outputs/。这就是复利循环。每一个问题都丰富了未来查询的知识基础。

不同的输出格式

你的维基不必只产出文本：

**幻灯片演示**（使用Marp格式）：

```markdown
Answer my question as a Marp slideshow. Separate slides with ---
and use # for slide titles. Save to wiki/outputs/topic-slides.md
```

**数据可视化**（如果使用 Claude Code 或其他带代码执行的工具）：

```markdown
Generate a Python script that creates a chart comparing [data from
the wiki]. Save the image to wiki/attachments/images/
```

比较表、决策框架、阅读清单。维基就是你的画布。

## Obsidian 插件

这些免费插件将 Obsidian 从简单的笔记查看器转变为严肃的知识库界面（请对你使用的插件进行 DYOR 审核，我的大语言模型建议如下）：

如何安装插件

\>社区插件设置>关闭限制模式>浏览。搜索插件名称，点击安装，然后启用。

基本内容

**Dataview** 是该工作流程中最强大的插件。它把你的保险库当作可查询数据库，自动读取你所有的 YAML 前页文件。在任何笔记中嵌入实时查询：

```markdown
TABLE summary, tags, date_modified
FROM "wiki/concepts"
SORT date_modified DESC
```

这样可以创建一个实时表格，列出你所有的概念文章，按最近更新排序。用它来构建仪表盘，查找未处理的源代码，并发现漏洞。

**Templater** 在创建笔记时会自动填充日期、文件名和其他变量。手动创建维基页面时节省了时间。

**Obsidian Git** 提供自动版本控制功能。配置它每30分钟自动提交一次，并推送到远程仓库。每一次变化都会被追踪并可逆转。当AI犯错时，你的安全网。

**标签整理**器可批量重命名并合并整个保险库的标签。一旦分类体系扩展，这点至关重要。

**Linter**会自动在保存时格式化笔记。强制一致地使用YAML前页、标题等级和间距。当AI写很多文件时，格式化会有偏差，这点至关重要。

**Marp Slides** 将 Markdown 文件渲染为演示幻灯片。任何带有marp： true的音符，前言中都变成了幻灯片。导出为PDF、HTML或PowerPoint。

**主页**会指定备注作为你保险库的登陆页。搭建一个带有Dataview查询的仪表盘，显示近期活动和统计数据。

图视图（内置，无需插件）

Obsidian 的图表视图将你的维基可视化为一个互动网络。音符是点。\[\[维基链接\]\]是连接线路。高度连通的概念表现为更大的节点。

利用它来发现相关知识的聚集，发现需要整合的孤儿笔记，并发现主题间的意外联系。

## 健康检查与质量维护

定期的健康检查可以防止你的维基变成一堆零散的笔记。每周运行一次，或者每批新资料发布后。

绒毛提示：

```markdown
Perform a health check on the wiki. Read all files in wiki/ and
report:

1. CONTRADICTIONS — claims in one article that conflict with
   another. List both sources.
2. ORPHAN PAGES — articles with no inbound [[wikilinks]].
   Suggest where to add links.
3. MISSING PAGES — concepts frequently referenced as [[wikilinks]]
   but lacking their own article. Create stubs for the top 5.
4. BROKEN LINKS — [[wikilinks]] pointing to non-existent pages.
5. INCOMPLETE METADATA — articles missing required frontmatter.
   Fix them.
6. STALE CONTENT — articles based on sources over 6 months old
   with no updates.
7. SUGGESTED QUESTIONS — 3-5 research questions worth exploring
   next.

Fix all issues you can automatically. For contradictions and major
gaps, create a report at wiki/outputs/lint-report-[today's date].md
```

补充自动检查

如果你对命令行操作很熟悉，这些免费工具可以帮你发现AI可能忽略的结构性问题：

- **MarkDdownLint**（NPM 安装 -g MarkDupLint-CLI）强制一致的 Markdown 格式
- **Markdown-Link-Check**（NPM 安装 -g Markdown-Link-Check）验证所有超链接

可选。AI的语义细节捕捉到了重要内容。这些会发现格式问题。

双模型验证模式

对于高风险知识库（医学研究、法律分析、投资论文），可以使用两种不同的人工智能模型：一种编写维基页面，另一种在进入“实时”维基前独立验证。

这可以防止幻觉的叠加。这是许多评论者对卡帕西原始帖子提出的真实担忧。

用Claude编译，用GPT-4o验证（反之亦然）。如果双方都同意，内容很可能是合理的。如果他们不同意，就去调查。

## 扩展：当你的维基变得庞大时

你能装多少？

在小规模（大约100篇文章以下）时，索引文件方法效果非常好。AI会读取索引，挑选相关页面，只加载它需要的内容。

![图片](https://pbs.twimg.com/media/HFPCdUvWcAAXhia?format=jpg&name=large)

用QMD添加搜索

**QMD** 是由 Tobi Lütke（Shopify 首席执行官）开发的免费开源本地搜索引擎。专为折扣知识库设计。结合关键词搜索、语义（基于意义）搜索和人工智能重新排序。所有设备都运行在你的机器上，没有云依赖。

## 自动化整个工作流程

手动复制粘贴的工作流程是有效的。但进展缓慢。这个系统的真正力量是在维基自我构建时解锁的。

最简单且最佳的方法：安装现成插件（2分钟）

自从Karpathy分享了他的模式后，社区已经开发了现成的Claude Code插件，将整个维基工作流程变成简单的斜杠命令。 **你不需要写任何配置、创建模板或制作提示。** 安装，输入两个命令，完成。

**最快的路径是wiki-skills插件：**

```bash
# In Claude Code, run:
/plugin marketplace add kfchou/wiki-skills
/plugin install wiki-skills@kfchou/wiki-skills
```

你现在有以下命令：

- /wiki-init 在几秒钟内构建整个文件夹结构
- /wiki-ingest 将原始源处理到维基（摘要、概念、实体、维基链接、索引更新）
- /wiki-query 会在你的维基中研究问题并返回答案
- /wiki-lint 运行健康检查并修复它能修复的部分

**你的工作流程将变成：**

1. 将文章导入原始文档（通过网页剪辑器或复制粘贴）
2. 在 Claude Code 中输入 /wiki-ingest
3. 完成了。打开Obsidian，浏览你的维基。

## 重要提示：

**如果你不想要插件**，或者想了解底层原理，本节其余部分将介绍DIY自动化的五个层级。

**第一级：单命令编译（Claude Code CLI）**

如果你安装了Claude Code（每月至少20美元Pro），你可以通过一个命令处理RAW/文件夹里的每个新源码：

```bash
claude -p "Read CLAUDE.md. Find all files in raw/ that don't yet have a corresponding summary in wiki/sources/. For each one: create a source summary, create or update concept and entity pages, add wikilinks, and update wiki/index.md and wiki/log.md."
```

就这样。Claude Code 会读取你的原始码，写入所有 markdown 文件，将它们放到正确的文件夹里，创建所有交叉链接，更新你的索引。打开Obsidian，所有东西都在那里。

\-p 标志表示“提示”。它运行时是非交互式的，完成后会自动退出。

**第二级：自定义斩击命令（输入/编译后离开）**

Claude Code 支持自定义斜杠命令。可重复使用可重复使用的 markdown 文件，使用 /command-name 调用。

**创建此文件为 .claude/commands/wiki-compile.md：**

```markdown
---
description: Compile new raw sources into the wiki
allowed-tools: Read, Write, Bash, Glob, Grep
---

# Wiki Compilation

Read CLAUDE.md for project conventions.

1. Scan raw/ for all source files
2. Read wiki/sources/ to identify which sources have already
   been processed
3. For each NEW (unprocessed) source:
   a. Create a source summary in wiki/sources/
   b. Identify key concepts and entities
   c. Create new concept/entity pages if they don't exist
   d. Update existing pages with new information (append only)
   e. Add [[wikilinks]] between related pages
4. Regenerate wiki/index.md with all pages listed
5. Append all operations to wiki/log.md
6. Report: how many sources processed, pages created, pages
   updated
```

现在在你的保险库内的任何Claude Code会话中，输入：

```markdown
/wiki-compile
```

Claude会读取命令文件，跟着每一步，构建你的维基。

为其他操作创建类似命令：

- .claude/commands/wiki-lint.md > /wiki-lint 用于健康检查
- .claude/commands/wiki-query.md > /wiki-query AMMs 是如何工作的？用于研究

第三级：计划任务（维基每天都会自己构建）

这时它真正实现了自主性。Claude Code 支持自动运行**的定时任务**，无需你输入任何内容。

**使用 Claude 桌面（Mac/Windows）：**

打开一个任务，输入 /schedule，配置：

- **什么**：“读一读 CLAUDE.md。所有新文件都处理成 RAW/。编译成维基。”
- **时间**：每天早上9点（或你方便的时间）
- **重复**：每天/工作日/每周

每次运行都会启动一个新会话，处理你的原始源代码，编写维基页面，然后退出。你一天中剪辑文章;维基会在一夜之间自行编译。

**使用CLI的说明：**

```markdown
/loop 24h Read CLAUDE.md. Check for new files in raw/ that haven't been processed. Compile any new sources into wiki pages and update the index.
```

**使用 cron（Mac/Linux）：**

```markdown
crontab -e

# Runs compilation daily at 6am
0 6 * * * cd ~/my-knowledge-base && claude -p "Read CLAUDE.md. Process all new raw/ files not yet in wiki/. Create summaries, concept pages, and update index." >> ~/kb-compile.log 2>&1
```

这在背景中运行。你的维基是在你睡觉时增长的。

**重要说明：**

- 每次计划运行都会消耗你的Claude使用配额
- 桌面任务只在电脑清醒且Claude Desktop开启时运行
- Cron 任务需要在机器上安装并认证 Claude 代码

第四级：GitHub 操作（云自动化，电脑关闭）

最强大的配置。你的电脑可以关机。编译工作在GitHub的服务器上进行。

1. 把你的保险库存储在GitHub仓库里
2. 当你推送新文件到RAW/时，GitHub Action 会触发
3. Claude Code 编译了维基
4. 更新后的维基文件提交回仓库
5. 把更改拉到你本地的Obsidian Vault（或者用Obsidian Git自动同步）

**工作流程文件**（.github/workflows/compile-wiki.yml）：

```yaml
name: Compile Wiki
on:
  push:
    paths:
      - 'raw/**'
  schedule:
    - cron: '0 6 * * *'  # Daily at 6am UTC

jobs:
  compile:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install Claude Code
        run: curl -fsSL https://claude.ai/install.sh | bash

      - name: Compile wiki
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          claude -p "Read CLAUDE.md. Process all raw/ files \
          not yet in wiki/. Create summaries, concept pages, \
          and update index."

      - name: Commit changes
        run: |
          git config user.name "Wiki Bot"
          git config user.email "bot@example.com"
          git add wiki/
          git diff --staged --quiet || git commit -m "Auto-compile wiki $(date +%Y-%m-%d)"
          git push
```

**费用说明：**这使用Claude API（按代币付费），不是你的订阅。你需要从以下获得一个API密钥 [console.anthropic.com](https://console.anthropic.com/).对于5到10个新来源，4.6号十四行诗每轮可获得不到0.50美元。

5级：完整特工技能（自我维护维基）

Claude Code 支持在检测到正确上下文时自动触发的代理技能。与挥砍指令（需要调用）不同，技能会自动激活。

创建 .claude/skills/wiki-maintainer/SKILL.md：

```markdown
---
name: wiki-maintainer
description: Automatically maintain the knowledge base wiki.
  Triggers when new files appear in raw/, when the user asks
  questions about the wiki topic, or when a health check is
  needed. Handles compilation, querying, and linting.
allowed-tools: Read, Write, Bash, Glob, Grep
---

# Wiki Maintainer

You are maintaining a personal knowledge base wiki.
Read CLAUDE.md in the project root for full conventions.

## When to activate
- User adds files to raw/ → run INGEST cycle
- User asks a question about the wiki topic → run QUERY cycle
- User mentions "health check" or "lint" → run LINT cycle
- More than 7 days since last lint (check wiki/log.md) →
  suggest a lint pass

## Ingest cycle
1. Glob raw/**/*.md to find all sources
2. Glob wiki/sources/**/*.md to find processed sources
3. Diff to identify unprocessed sources
4. For each new source: create summary, concept pages, entity
   pages, wikilinks
5. Update wiki/index.md and wiki/log.md

## Query cycle
1. Read wiki/index.md
2. Identify relevant pages from index summaries
3. Read those pages
4. Synthesise answer with [[wikilink]] citations
5. Save to wiki/outputs/{slug}.md
6. Update index and log

## Lint cycle
1. Check for contradictions, orphan pages, broken links
2. Check for missing frontmatter
3. Create stubs for frequently linked but non-existent pages
4. Fix automatically where possible
5. Write report to wiki/outputs/lint-report-{date}.md
```

有了这个技能，只要说“我给RAW添加了三篇新文章/”，Claude就知道该怎么做了。不需要命令。

![图片](https://pbs.twimg.com/media/HFPD6y-aMAAV_pJ?format=jpg&name=large)

从第一级开始。随着熟悉，逐步增加自动化。每个关卡都在前一关基础上进行扩展。只要你跳到前面，什么都不会坏。

**合成数据生成（高级）**

一旦你的维基成熟，你可以用它来创建一个“了解”你领域权重的微调模型的训练数据。

把每篇维基文章都交给Claude：

```markdown
Given this wiki article, generate 5 question-answer pairs:
- 2 factual questions (who/what/when)
- 2 reasoning questions (why/how/compare)
- 1 synthesis question (connecting to other concepts)
Output as JSON.
```

从100篇维基文章中，预计会有300到500对质量保证。足够通过OpenAI的API（大约每百万个训练代币8美元）或本地用消费级GPU上的QLoRA微调小型模型。

微调则教会模型你领域的词汇和推理模式。它记忆具体事实很差，所以这些信息更适合靠维基本身来帮助。理想的设置？结合了维基来提供具体细节，是一个经过细致调整的行为模型。

## 现有工具与社区实现

你不是从零开始建设。已有多个开源项目实现了这一模式：

- **LLM-wiki-编译**器，带有 /wiki-init 和 /wiki-compile 命令
- **Sage-Wiki** 作为一个完整的 CLI，包含编译、搜索、查询和服务命令（将 wiki 暴露为 MCP 服务器）
- **CRATE** 作为 Python CLI，实现了三层模式，兼容 OpenAI，支持 Obsidian。
- **QMD** 作为本地 markdown 搜索引擎，支持关键词、向量搜索和混合搜索，并支持 MCP 服务器
- **Fabric** 拥有 140+ 精心策划的提示模式，用于标准化操作

## YAML 前置快速引用

每个维基页面顶部都应该有元数据。这支持Dataview查询、自动化维护和一致的AI处理。

```yaml
---
# Required for all pages
title: "Page Title"
date_created: 2026-04-06
date_modified: 2026-04-06
summary: "One to two sentences describing this page."
status: draft          # draft | review | final
type: concept          # concept | entity | source | synthesis | output
tags:
  - topic-tag

# For source summaries (add these)
source_url: "https://example.com/article"
authors:
  - "Author Name"

# For concepts (add these)
related:
  - "[[related-page]]"
source_count: 5
confidence: established  # established | emerging | speculative
---
```

## 常见问题排查

**“AI一直在重写页面，而不是更新。”** 添加明确的说明：“在现有章节中添加新信息。不要重写未曾更改的内容。保留所有现有的维基链接。”

**“我的食指越来越长，太难用了。”** 分成类别索引。保持wiki/index.md作为轻量级概述（页面标题+仅一行摘要）。在每个 \_index.md 文件的子文件夹里放详细摘要。

**“人工智能会幻觉无关主题之间的联系。”** 最常见的质量问题。通过始终追踪特定源页的声明、对关键内容运行双模型验证模式，并在 CLAUDE.md 中加入“仅明确由源材料支持的连接”来缓解。

**“我在完成编译前就达到了克劳德的使用限制。”** 工艺源分小批量（一次3到5个）。使用增量编译，而不是全部重新处理。如果你经常达到限额，可以考虑Max（每月100美元）或API按需付费。

**“我的维基上有不同名字的重复概念。”**当AI遇到不同来源表达不同的想法时，这种情况自然而然发生。在 CLAUDE.md 里加一条“lint rule”：“检查概念页是否用不同名称描述同一内容。合并它们，保留最常用的名字并添加重定向。”

**“我想把我的维基分享给别人。”** 所有内容都是普通的 Markdown 文件。可以把保险库推送到 GitHub 仓库，通过云存储分享（Dropbox、Google Drive、iCloud），或者用 MkDocs Material 部署成网站（pip install mkdocs-material & mkdocs serve）。

## 结论

卡帕西指出，从“人工智能作为答录机”向“人工智能作为知识基础设施”的转变，改变了个人管理技术的方式。该系统无需编程背景，无需数据库管理，也无需基础设施，仅需免费笔记应用和AI订阅。

有三点使这与普通AI使用不同：

**归档循环是超能力。** 每保存回维基的查询都会丰富它，方便以后查询。化合物每次互动都会有回报。没有任何聊天界面能提供这些功能。

**AI是编译器，不是搜索引擎。** 它以分块检索无法做到的方式综合和连接思想。它理解 文档之间的关系，而不仅仅是相似性。

**纯文本是永远的。** 你的知识库是一个包含markdown文件的文件夹，任何工具、任何操作系统都能读取，只要有计算机存在。没有供应商锁定。无专有格式。没有不透明的数据库。

从小处做起。选一个话题。剪辑五篇文章。运行汇编。问个问题。看看维基给你的反馈。然后继续喂它。

**唯一的问题是你构建第一个维基的主题是什么。**

请留言说明你的话题。我告诉你这个系统是否适合。

最后，既然我花了大半天时间免费为你们整理这篇文章，我相信我可以自己推销通讯。

请去看看昨天的免费通讯，里面有大量有用的AI阿尔法应用：

> 2023年3月26日
> 
> http://sevenc.substack.com 免费注册