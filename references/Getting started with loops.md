---
title: Getting started with loops
source: https://x.com/ClaudeDevs/status/2074208949205881033
---

[[indez]]

[[mode]]

---

![图像](https://pbs.twimg.com/media/HMkRVmsaEAA3Dl5?format=jpg&name=large)

现在很多人都在讨论“设计循环”，而不是直接提示你的编码助手。如果你花些时间研究一下 X，试图弄清楚循环到底是什么，你会发现很多不同的答案。

在 Claude Code 团队中，我们将**循环定义为代理重复执行工作周期直至满足停止条件的过程**。我们根据以下几个方面对循环进行分类：

- 它们是如何被触发的
- 他们是如何被阻止的
- 使用了哪种 Claude Code 原语？
- 哪种类型的任务最适合他们？

我们将介绍主要的循环类型、每种类型的适用场景，以及如何在管理令牌使用的同时保持代码质量。并非所有任务都需要复杂的循环；从最简单的解决方案入手，并根据实际情况选择性地使用这些模式。

## 回合制循环

![图像](https://pbs.twimg.com/media/HMkOVNybEAAncbL?format=jpg&name=large)

- **触发方式**：用户提示。
- **停止标准**：Claude 判断它已完成任务或需要更多上下文。
- **最适合用于：**不属于常规流程或计划的较短任务。
- **通过以下方式管理使用：编写具体提示并改进验证技巧，以减少回合数**。

你发送的每一个指令都会启动一个手动循环，每一步都由你来控制。Claude 会收集上下文信息，采取行动，检查结果，必要时重复操作，并做出响应。我们称之为“代理循环”。

例如，让 Claude 创建一个点赞按钮。它会读取你的代码，进行修改，运行测试，然后返回它认为有效的结果。之后，你手动检查结果，并编写下一个提示。

您可以将手动步骤编码为 SKILL.md 文件，从而改进验证步骤，以便 Claude 可以端到端地检查更多自身工作。这应包含工具或连接器，使 Claude 能够查看、衡量结果或与之交互。检查越量化，Claude 就越容易进行自我验证。

例如，您可以在 SKILL.md 文件中指定：

```markdown
--- 
name: verify-frontend-change 
description: Verify any UI change end-to-end before declaring it done. 
--- 

# Verifying frontend changes 
Never report a UI change as complete based on a successful edit alone. Verify it the way a human reviewer would: 

1. Start the dev server and open the edited page in the browser. 

2. Interact with the change directly. For a new control (button, input, toggle): click it, confirm the expected state change, and screenshot before/after. 

3. Check the browser console: zero new errors or warnings. 

4. Use the Chrome Devtools MCP, run a performance trace and audit Core Web Vitals.

If any step fails, fix the issue and rerun from step 1 — do not hand back partially verified work.
```

## 基于目标的循环（/goal）

![图像](https://pbs.twimg.com/media/HMkOlk3bcAAHX46?format=jpg&name=large)

- **触发方式**：实时手动提示。
- **停止标准**：达到目标或达到最大转弯次数。
- **最适合用于：**具有可验证退出标准的任务。
- **通过以下方式管理使用：**设定具体的完成标准和明确的回合上限，“尝试 5 次后停止”。

有时，单次迭代不足以完成任务，尤其是在处理更复杂的任务时。智能体在迭代过程中表现更佳。你可以通过使用 \`/goal\` 定义完成状态来延长 Claude 的迭代时间。

当你定义成功标准后，Claude 就无需判断什么是“足够好”并提前结束循环。每次 Claude 试图停止时，评估模型都会检查你的条件，并让它继续运行，直到达到目标或你设定的回合数为止。

这就是为什么确定性标准（例如通过的测试次数或达到一定的分数阈值）如此有效的原因。

例如：

```bash
/goal get the homepage Lighthouse score to 90 or above, stop after 5 tries.
```

## 基于时间的循环（/loop 和 /schedule）

- **触发条件**：指定的时间间隔。
- **停止条件**：您取消它，或者工作完成（PR 合并，队列为空）。
- **最适合用于：**重复性工作，或与外部环境/系统进行交互。
- **通过以下方式管理使用：设置更长的间隔或根据事件而不是时间做出反应。

有些代理工作是重复性的：任务本身保持不变，只有输入内容会改变。例如，每天早上汇总 Slack 消息。其他工作则依赖于外部系统，与这些系统交互的一种简单方法是定期检查系统并根据变化做出反应。例如，一个 PR 可能需要进行代码审查或持续集成失败。

对于这些操作，您可以使用 \`/loop\` 在 Claude 运行时触发，该命令会按指定时间间隔重新运行提示符。例如：

```bash
/loop 5m check my PR, address review comments, and fix failing CI
```

\`/loop\` 在您的计算机上运行，​​因此如果您将其关闭，它就会停止。您可以通过使用 \`/schedule\` 创建例程，将循环迁移到云端。

## 主动循环

![图像](https://pbs.twimg.com/media/HMkPQM8bEAA3RAk?format=jpg&name=large)

- **触发方式**：由事件或日程安排触发，无需人工实时操作。
- **停止条件**：每个任务在其目标达成后即退出。程序本身会一直运行，直到您将其关闭。
- **最适合用于：重复性的、定义明确的工作流：错误报告、问题分类、迁移、依赖项升级等。
- **通过以下方式管理使用：将例程路由到更小、更快的模型，并使用功能最强大的模型进行判断。

上述基本元素，以及 Claude Code 的其他功能（如**自动模式**和**动态工作流**（研究预览）），可以组合成一个循环，用于长时间运行的工作。

例如，要处理收到的反馈，您可以使用：

1. **\`/schedule\`** （研究预览）用于运行检查新报告的例程
2. **\`/goal\`**用于定义完成状态的外观和**所需技能**，并记录如何验证完成状态。
3. **动态工作流程**用于协调代理，对每个报告进行分类、修复并审查修复结果。
4. **自动模式**，程序无需停止即可运行并请求许可。

综合起来，提示信息可能如下所示：

```bash
/schedule every hour: check the project-feedback channel for bug reports. /goal: don't stop until every report found this run is triaged, actioned, and responded to. When fixing a bug, use a workflow to explore three solutions in parallel worktrees and have a judge adversarially review them.
```

## 保持代码质量

循环输出的质量取决于其周围的系统。设计系统时：

- **保持代码库本身的整洁**：Claude 遵循代码库中已存在的模式和约定。
- **让 Claude 能够验证自身的工作成果**：用代码定义你和你的团队眼中的“好”的标准。[技能](https://code.claude.com/docs/en/skills)。
- **让文档易于获取：**框架和库的文档包含最新的最佳实践。
- **使用第二个代理进行代码审查**：审查者拥有更新鲜的背景信息，因此偏见更少，也不会受到主代理推理的影响。您可以使用内置的 \`/code-review\` 技能，或者[代码审查](https://code.claude.com/docs/en/code-review)适用于 GitHub。

当某个结果不符合标准时，不要仅仅满足于解决该具体问题，而应该尝试对其进行编码，以改进系统，使其适用于所有未来的迭代。

## 管理代币使用情况

为了管理令牌的使用，循环应该有明确的边界：

- **根据任务选择合适的基元和模型：**较小的任务不需要多个代理或循环。有些任务可以使用更便宜、更快速的模型。
- **明确成功和停止的标准：**具体说明完成是什么样子，这样 Claude 就能更快地找到解决方案（但不要太快）。
- **大规模运行前先进行试点：**动态工作流程可能会生成数百个代理。请先在较小规模的工作量上评估其使用情况。
- **对于确定性工作，可以使用脚本**：运行脚本比逐步推理更高效。例如，PDF 处理技能可以提供一个表单填写脚本，Claude 每次运行该脚本即可，而无需重新编写代码。
- **不要过于频繁地运行例程：将运行间隔与你所观察事物的变化频率相匹配。
- **查看使用情况：**\`/usage\` 命令按技能、子代理和 MCP 细分最近的使用情况，\`/goal\` 不带参数显示到目前为止的回合数和令牌使用情况，\`/workflows\` 显示每个代理的令牌使用情况，您可以随时停止代理。

## 入门

总结起来：

| 环形 | 你交接 | 使用它 | 伸手 |
| --- | --- | --- | --- |
| 回合制 | 检查 | 你正在探索或决定 | 自定义验证技能 |
| 目标导向 | 停止条件 | 你知道完成的样子。 | /目标 |
| 基于时间 | 触发器 | 这项工作是在你的项目之外，按照既定计划进行的。 | /环形  ，  /日程 |
| 积极主动的 | 提示 | 这项工作是重复性的，而且定义明确。 | 以上所有因素，以及动态工作流程 |

要开始使用循环，首先要审视一下你目前的工作。选择一个你遇到瓶颈的任务，然后问问自己：哪些部分可以交给别人做？你能编写验证检查吗？目标是否足够清晰？工作是否按计划完成？

一旦你有了想法，就运行循环，观察结果，比如它在哪里停滞或超出范围，不要害怕对其进行迭代。

更多信息，请阅读 Claude Code 文档。[并行运行代理，](https://code.claude.com/docs/en/agents)以及[环形](https://code.claude.com/docs/en/goal)，[日程](https://code.claude.com/docs/en/routines)，[目标](https://code.claude.com/docs/en/goal)， 和[动态工作流程](https://code.claude.com/docs/en/workflows#orchestrate-subagents-at-scale-with-dynamic-workflows)页数。

本文由……撰写[@delba\_oliveira](https://x.com/@delba_oliveira)