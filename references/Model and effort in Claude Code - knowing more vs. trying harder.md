---
title: "Model and effort in Claude Code: knowing more vs. trying harder"
source: https://x.com/ClaudeDevs/status/2074900291062034618
---
[[index]]

[[instructions]]

---

![图像](https://pbs.twimg.com/media/HMuGsvQbwAAimdV?format=jpg&name=large)

Claude Code 提供了两个看似都能“改善答案”的设置：模型和努力程度。但它们究竟对输出结果有何影响？又该如何判断是应该选择不同的模型，还是仅仅调整努力程度呢？ 人们很容易认为，选择像 Fable 这样更大的模型会比 Sonnet 得到更智能的输出，而更高的努力程度仅仅意味着 Claude 在回答之前会思考更长时间。

第一个假设是正确的。根据行业标准基准，我们最大的型号**性能更强大。**

但“思考时间”并非衡量算法性能的唯一标准。“思考时间”决定了**Claude 处理你的请求的总工作量**。这不仅包括思考时间，还包括：

- 它读取了多少个文件；
- 它验证了多少；以及
- 在与你确认之前，它能完成多少个多步骤任务。

在高投入模式下，Claude 会执行更多操作（读取文件、运行测试、复核），然后再返回结果。在低投入模式下，它宁愿向你询问更多上下文信息，而不是花费代币自行摸索。

## 模型选择是如何运作的

要了解模型设置实际控制的内容，最好从按下回车键的那一刻开始。

Claude Code 会将您的消息与系统提示符、工具定义、CLAUDE.md 文件、对话历史记录以及上下文中的任何文件组合在一起。所有这些内容都会作为单个请求发送到 API。

![图像](https://pbs.twimg.com/media/HMp7c2RbkAAVN7X?format=jpg&name=large)

Everything Claude Code has gets packed into one API request. On the server, the text is tokenized before it ever reaches the model.

不过，模型永远不会把这些内容当作纯文本来处理。服务器端首先会进行分词：文本会被分割成多个片段，每个片段都会映射到模型训练时使用的固定词汇表中的一个整数。例如，\`const\` 可能映射到 1978，\`await\` 可能映射到 4293。从这里开始，**你的提示符就是一个整数数组**。

![图像](https://pbs.twimg.com/media/HMp7pYKbAAA_X1F?format=jpg&name=large)

The tokenizer splits your text into pieces and maps each piece to an integer in a fixed vocabulary. Each chunk in the top row becomes its token ID (bottom row); IDs shown are illustrative.

该模型的任务是获取数组并预测下一个词元。它通过计算词汇表中每个词元的概率，并从中选择一个概率最高的词元来实现这一点。在执行 \`const x = await\` 之后，一个训练有素的模型会给 \`fetch\` 赋予很高的概率（非常可能），而给 \`banana\` 赋予接近于零的概率（几乎不可能）。

![图像](https://pbs.twimg.com/media/HMp70iMa8AECvcq?format=jpg&name=large)

The model's prediction is a probability for every token in its vocabulary. The gap between the top guess and an unrelated one is enormous.

将输入词元转化为概率的关键在于权重（也称为参数）：数十亿个数字被组织成大型矩阵。为了预测一个词元，模型会将输入输入逐个输入到这些矩阵中（一系列矩阵乘法运算），并在最后读取概率值。**权重包含了模型“知道”的一切信息**。

每个模型的权重在训练期间就已经设定好了，当你发送请求时，**这些权重是只读的**。你的提示符、CLAUDE.md 文件或上下文中的任何内容都不会改变这些权重。如果你遇到了“推理”这个词，它的意思就是：在训练完成后，使用权重固定的模型进行推理。

![图像](https://pbs.twimg.com/media/HMp77BfaQAAuYPa?format=jpg&name=large)

Your prompt goes in, probabilities come out. The weights in the middle don't change.

Claude 所掌握的关于 TypeScript、流行框架或任何其他通用编程知识，都在训练时被编码到这些权重中。

你的提示和上下文仍然可以影响预测结果。将你的实际代码放在 Claude 前面就是在进行引导，而且效果非常好。然而，这并不会改变权重本身。

如果模型训练时某个库不存在，那么它的权重中就不会包含它。你可以提供文档上下文，Claude 会使用它们，但这只是**引导****，而不是训练**。Claude 的响应仅受该请求的影响，但底层模型并没有保留任何信息。

当 Claude 自信地调用一个不存在的 API（一种幻觉）时，这是权重根据训练模式生成了一个看起来很合理的标记序列，而不是查找失败。

那么，改变模型究竟会做什么呢？它**会切换哪一组冻结的权重**来处理你的请求。

该模型不会一次性生成完整的答案。它会预测一个词元，将其添加到序列中，然后再次运行整个计算过程来获得下一个词元。一个包含 200 个词元的响应需要 200 次单独的权重迭代。这个循环是造成大部分等待时间（以及输出成本）的原因。

![图像](https://pbs.twimg.com/media/HMp8BjeaMAAhSeb?format=jpg&name=large)

The sequence grows by exactly one token per step. The model re-reads the whole array each time to predict what comes next.

模型设置决定哪些权重处理您的请求，还决定每个输出令牌的成本。

它无法决定**生成多少个令牌**。对于同一个提示，令牌的数量可能会有很大差异，这取决于 Claude 决定完成多少工作。

这正是努力所能控制的。

## 努力是如何运作的

当 Claude Code 执行任务时，它生成的令牌分为以下几类：

- **思考：**指你在行动之前和行动之间所进行的推理过程。
- **工具调用：**结构化块，用于命名工具（例如读取或编辑）及其参数，然后 Claude Code 会解析并执行这些调用。
- **短信发送给您：**计划、进度更新、最后的总结。

这些都是来自同一循环的普通输出令牌，按相同费率计费。例如，思考令牌的生成方式与其他输出令牌完全相同，并在本回合剩余时间内保持其上下文关联。

当 Claude 开始编写代码时，它之前的推理过程就成了输入的一部分，就像它读取的文件一样。

![图像](https://pbs.twimg.com/media/HMp8IlTa8AA3yea?format=jpg&name=large)

All of Claude's output is tokens. Thinking, tool calls, and text to you are all generated from the same loop.

那么，努力程度如何影响这一切呢？努力程度会**作为请求的一部分**，与您的提示信息一起发送给模型。模型经过训练，能够理解在每个努力程度下应该如何行动，而这些学习到的行为会被写入到冻结的权重中。

当你的请求到达时，努力程度只是模型响应的众多输入之一，就像它响应你的提示文本一样。它决定了克劳德在认为任务完成之前需要达到的彻底程度和确定程度。这一点在每一轮都会被权衡，更高的置信度需要更多的令牌才能达到。

![图像](https://pbs.twimg.com/media/HMp8OpFa0AAXQK4?format=jpg&name=large)

Same prompt, two effort levels. The high effort path generates roughly 7x more tokens to reach a higher confidence answer.

在高投入水平下，克劳德通常会先制定计划，而投入水平会影响计划的深度和广度。但计划并非一成不变。随着克劳德的行动取得成果，它会不断更新对已取得进展以及最终结果确定性的评估。

当三步假设调试计划的第一步就发现了错误时，“调查假设2和3”可能就不再必要了。Claude通常会明确指出这一点（例如，“第一步检查已经发现了错误，所以不需要进行剩余的检查”），然后直接跳过。在Claude Code中，当任务列表在运行过程中被修改时，就会出现这种情况。

更高的投入确实会让 Claude 更倾向于进行复核，例如验证它找到的答案，或者继续研究它本可以跳过的假设。然而，仅仅提高投入水平通常不会人为地增加简单任务的使用量。“过度思考”是我们团队在模型训练过程中特别关注的问题，因为它会降低模型的有效性。

## 选择努力程度

对于大多数任务，**请使用模型的默认努力程度**。默认程度是指 Claude 将代币使用量调整到大多数人愿意在任务上花费的水平。

把努力程度想象成一种手动控制，用来调节克劳德的工作强度和时长。当你根据自身领域或工作类型，对工作细致程度或速度有强烈偏好时，可以有意识地使用努力程度控制，并将其视为一种总体偏好，而不是针对具体任务的决策。

Opus 4.8 发布后的一个实际注意事项：在我们的测试中，对于相同数量的令牌，Opus 4.8 的默认努力程度设置比 Opus 4.7 的默认努力程度设置在同一任务上产生更好的结果。

## 克劳德出错时该如何改变

当克劳德出错时，你的第一反应不应该是更改设置，而应该是查看你给出的上下文。你的提示是否过于模糊？克劳德是否连接到了正确的工具？它是否具备相应的技能？

如果你在不应该需要投入更多精力的任务上投入了更多精力，那么问题通常出在上游：你的上下文、你的 CLAUDE.md 文件，或者任务的范围。

但假设你已经提供了清晰的背景信息，克劳德仍然判断错误。这时你需要问问自己：**是它不够****努力****，还是它****掌握的信息不够****？**

![图像](https://pbs.twimg.com/media/HMp8Xd_aIAAMi_7?format=jpg&name=large)

**模型：问题太难了**

当问题确实棘手时，例如难以发现的 bug、不熟悉的领域或架构决策，就应该选择更大的模型。如果无论提供多少上下文信息，较小的模型都明显错误，那么你就需要更大的模型。

较大的模型也更擅长处理歧义。对于较小的模型，使用明确的指令来指导执行才是提高成功率的更好方法。

如果工作内容比较常规，例如可以精确描述的修改、机械性改动、以及对已在上下文中运行的代码提出的问题，那么选择较小的型号即可。没有必要为任务不需要的功能付费。

如果克劳德掌握了所有相关背景信息，也确实尽力了，但仍然出错，那就说明应该选择更大的模型。如果你已经在使用更大的模型，而且这项工作已经持续了一段时间，那么降低模型大小通常可以提高速度并降低成本，而不会影响输出质量。

**努力程度：克劳德不够努力。**

如果克劳德因为不够努力而犯错，例如跳过某个文件、未运行测试或未仔细检查其结果，则应选择更高的努力程度。如果您选择的努力程度低于模型的默认值，这一点尤为重要。

## 专家、专业人士和通才

我喜欢这样理解这两种角色：Fable 是能解决几乎无人能及难题的专家，Opus 是全能型人才，而 Sonnet 则是一位非常优秀的通才。他们各自投入的时间长短取决于你的任务难度。

Opus 的低成本服务就像是让你花五分钟时间与一位经验丰富的专家交流，他/她对解决你遇到的问题有着深刻的理解。他们能带来你代码库中根本不存在的知识：他们见过的模式、他们知道该检查的陷阱，以及只有解决过大量类似问题才能积累的经验。但五分钟意味着快速浏览你的代码，而不是仔细检查每个文件。

Sonnet 精力充沛时就像个全能型人才，整个下午都能抽出时间来。他们编程能力很强，会阅读所有文档，运行程序，仔细检查自己的工作，最终能彻底理解你的代码。

Fable 是那种当所有人都束手无策时你才会求助的专家。即使工作量不大，他们也能发现别人忽略的问题。这种洞察力也是你付费最多的原因，所以值得把他们的服务留给真正需要它的任务。

这些方法没有绝对的“优劣之分”。模型设定大致反映了**能力水平**；而工作量设定大致反映了**彻底程度**。大多数实际任务都需要两者兼顾。

## 努力程度、模型和代币消耗

那么模型选择、工作量和代币消耗之间是如何相互作用的呢？这取决于具体的任务。

在相同工作量下，无论是大型模型还是小型模型，通常都能正确完成日常工作。大型模型需要消耗更多代币，并进行额外的验证步骤，因此每个代币的价格更高。这就是为什么在日常工作中使用小型模型可以在不损失质量的前提下节省实际成本。

![图像](https://pbs.twimg.com/media/HMp9BhXawAA7MjW?format=jpg&name=large)

Curves are for illustration purposes only, shown for a single task simple enough to be accomplished quickly by both models. They do not represent real benchmark data.

对于难度更高、步骤更多的任务，情况则恰恰相反。较小的模型需要反复迭代，才能达到其能力的极限，而较大的模型只需更少的步骤就能达到相同的质量标准。

虽然大型模型每个代币的成本更高，但对于真正超出小型模型能力范围的任务，其总成本反而可能更低。更重要的是：即使在最高努力度设置下，大型模型也能完成小型模型无法完成的任务。

这一点在 Fable 上体现得最为明显。在处理冗长、多步骤的任务时，它能遥遥领先。在我们的测试中，它完成了 Opus 和 Sonnet 在任何工作量下都无法完成的任务。同时，它的单次计算成本也最高，这也是为什么应该把它留给真正需要它的任务的另一个原因。

![图像](https://pbs.twimg.com/media/HMp9IOba4AArT7v?format=jpg&name=large)

Curves are for illustration purposes only, shown for a single task hard enough to stretch both models. They do not represent real benchmark data.

以上图表的关键点在于：努力程度决定了克劳德愿意沿着曲线走多远。但这并不意味着克劳德必须走那么远才能完成任务。

最后，努力程度会影响代币消耗，但不会限制代币消耗。系统中唯一的硬性上限是[最大令牌数](https://platform.claude.com/docs/en/build-with-claude/extended-thinking#max-tokens-and-context-window-size-with-extended-thinking)它会在触发时截断响应，但这是一种比较粗暴的方法，主要适用于 API 开发人员。更柔和的控制方式，例如[任务预算](https://platform.claude.com/docs/en/build-with-claude/task-budgets#task-budgets-are-advisory-not-enforced)或者，在提示中要求 Claude 言简意赅会更有帮助。这些提示是模型训练时会遵循的指导原则（当接近极限时，模型会尝试结束），而不是它会遇到的障碍。

努力程度会改变克劳德的工作量。模型会改变克劳德的知识水平。

当你对结果不满意时，在调整任何设置之前，请检查上下文：给 Claude 一个清晰的提示、正确的工具和技能，以及验证其自身工作的方法。

如果克劳德还是错了，问问自己：是知识不足，还是努力不够？知识不足是模型问题，努力不够是努力程度问题。

本文由……撰写[@lydiahallie](https://x.com/@lydiahallie)克劳德代码团队的技术人员。