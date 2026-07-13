
[[index]]

previous article  [[fault resolution]]

next article  [[skill]]

---

# 1. 介绍

**CLAUDE.md 是 Claude Code 中的一个核心配置文件，用于为大模型（LLM）提供持久化项目上下文**

## 主要作用

- **持久化记忆与上下文**：每次启动 Claude Code 会话时，Claude 会**自动读取** CLAUDE.md 文件的内容，并将其作为系统提示（System Prompt）的一部分加载。这样 Claude 在整个交互过程中都能记住项目的关键信息，而不需要你每次都重复说明
- 它相当于给 AI 准备的“**项目入职手册**”或“配置文档”，让 Claude 更好地理解：
    - 项目背景和技术栈
    - 代码规范和风格
    - 常用命名
    - 架构决策、关键目录结构和注意事项
    - 团队工作流、偏好和禁忌

有了它，大模型（LLM）生成的内容会更一致、更符合项目规范，减少“重复纠正”的工作量

## 文件位置与层级（加载优先级）

Claude Code 支持**分层加载**，更具体的文件会覆盖更通用的：

| 层级           | 位置                                      | 作用域     | 是否共享        |
| ------------ | --------------------------------------- | ------- | ----------- |
| **组织级**      | 系统目录（如 /etc/claude-code/CLAUDE.md）      | 整个组织/机器 | 所有人（IT 管理）  |
| **用户级**      | ==~/.claude/CLAUDE.md==                 | 你所有项目   | 仅自己         |
| **项目级**（最常用） | 项目根目录 ./CLAUDE.md 或 ./.claude/CLAUDE.md | 当前仓库    | 团队（提交到 Git） |
| **子目录级**     | 子文件夹内的 CLAUDE.md                        | 特定模块    | 团队          |

**规则**：更具体的指令优先级更高

==我们日常使用不会涉及到太多层级下的 CLAUDE.md，所以只用写好用户级的即可==

## 如何创建和使用

- **快速初始化**：在项目根目录运行 Claude Code，输入 /init 命令。Claude 会自动扫描代码库（package.json、目录结构等），生成一个初始的 CLAUDE.md 模板
- **手动编写**：用 Markdown 格式，保持简洁（推荐 **< 200 行**，最好控制在 60-100 行以内，避免上下文过载）

---

# 2. 内容

虽然我们日常使用并不会接触到编程开发，但是 CLAUDE.md 仍然有非常重要的作用

以下有几点是值得写入 CLAUDE.md 文档的：

- claude code 文件存放路径
- github 相关的 SSH
- 重要 skill 相关信息
- skill 下载指定文件存放路径
- 大模型（LLM）特定的语气或风格
- github 的 ssh

接下来会根据分类进行详细讲解：

---

## **文件路径**

根据我们的使用场景主要会涉及到以下几点：

- claude code 产出项目文件的默认保存路径
- 通过 github 抓取的 skill 默认保存路径
- obsidian 仓库路径
- github 的 ssh

通过写入 CLAUDE.md，每次打开会话都能提醒 claude code 各类文件的存放路径，避免后续我们找不到文件；同时为了让 claude code 能实时获取读取我们的信息，则需要告诉它我们各类文件的存放地址

---

### claude code 产出项目文件的默认保存路径

![[CLAUDE.md-1.png]]

- 在 ~/home/user 文件夹下
- 默认一开始是没有 projects 文件夹的，claude code 会默认全放在 ~/home/user 里，会很乱
- 所以我们就需要告诉 claude code，需要在 ~/home/user 里新建 projects 文件夹，并且以后所有产出项目都放里面
- 然后再让 claude code 整理进 CLAUDE.md 即可

![[CLAUDE.md-2.png]]

==**注**==：
- 在跟 claude code 进行此类操作的时候，是一定要给它提供准确的文件路径的
	- 那么我们该如何获取准确的文件路径呢
	
- **方法一**：
	- 首先在资源管理器中打开对应的文件夹
	- 然后在上面工具栏中点击三个点的进行展开
	- 然后就可以看到复制路径相关的字样
	
- **方法二**：
	- 在最上方文件路径中，选择想复制路径的文件
	- 右键点击
	- 选择第一个，复制路径相关字样
	
- 通过以上两种常见方法，点击后最标准准确的路径则会保存到粘贴板中
- 然后粘贴进 claude code 后即可

==所以我们可以给 claude code 相关的 prompt（提示词）==：

```
在 ~/home/user 路径下新建 projects 文件夹，后续所有产出的文件都默认存放进这里，同时将这个规则优化进 CLAUDE.md 里
```

---

### skill 默认保存路径

![[CLADUE.md-3.png]]

在 [[document framework（claude code）]]中提过，skill 必须存放到 ~/home/user/.claude/skills 这个路径下才能被 claude code 读取到，所以当我们发现不错的 skill 时，就可以把 github 里所对应的网址进行复制粘贴给 claude code 进行处理，让 claude code 直接把 skill 放进这个文件夹里然后后续我们就可以直接在 claude code CLI 界面中直接运行

==所以我们可以给 claude code 相关的 prompt（提示词）==：

```
优化 CLAUDE.md：以后所有的 skill 默认存放路径都为 ~/.claude/skill
```

---

### obsidian 仓库路径

![[CLAUDE.md-4.png]]

- obsidian 仓库的默认地址是在资源管理器里的文件
- 选中对应的 obsidian 仓库文件进行路径复制
- 然后复制给 claude code 让它记住这是数据库即可

==所以我们可以给 claude code 相关的 prompt==：

```
C:\Users\leiyu\Documents\Obsidian 这是我的 obsidian 仓库，写进 CLAUDE.md 里记住路径
```

**补充**：

![[CLAUDE.md-5.png]]

==有些时候我们只需要让 claude code 只读取其中一个或一部分文档，我们就可以在 obsidian 内进行文件路径的复制==

- 在左侧文件目录中选中相应的文件夹或者单一的文件
- 右键点击
- 在复制路径中选择==绝对路径==即可

**注**（以下为示例）：

- 基于库的相对路径：sessions/2026-07/2026-07-07-chrome-glic-unlock
- 绝对路径：C:\Users\leiyu\Documents\Obsidian\Obsidian Claude Code\sessions\2026-07\2026-07-07-chrome-glic-unlock.md

**基于库的相对路径**会省略大量的系统路径，**绝对路径**则是完全完整的路径；虽然理论上，CLAUDE.md 中有 obsidian 的路径，claude code 大概率是能理解的，但是如果 obsidian 仓库不止一个情况下，就会可能会导致 claude code 无法找到对应文件，或者会花费更长的时间和 token

---

### github 的 ssh

将 ssh 配置给 CLAUDE.md 后续 claude code 可以自动处理上传、拉取、更改 github 仓库文件等任务

需要提前准备好 github 个人账号，claude code 是通过 ssh 绑定个人账户，并操作个人仓库

==所以我们可以给 claude code 相关的 prompt==：

```
帮我配置 GitHub SSH 连接，我是一个电脑小白，自动执行所有能自动化的步骤，只在需要我手动操作时告诉我
要求：
  1. 能自动执行的步骤都自动执行，不要问我
  2. 需要我手动操作的步骤（比如打开网页、复制内容），清楚告诉我具体怎么做
  3. 每完成一步，告诉我下一步该做什么
  4. 最后帮我把配置信息记录到 CLAUDE.md
```

根据 claude code 的引导完成配置即可

---

# 3. 总结

基于上面呈现的三种常见情况和使用需求可以整理为以下 prompt：

```
根据提示更新 CLAUDE.md：
1、在 ~/home/user 路径下新建 projects 文件夹，后续所有产出的文件都默认存放进这里
2、以后所有的 skill 默认存放路径都为 ~/.claude/skill
```

3、需要手动复制 obsidian 仓库路径，然后单独再进行操作

```
C:\Users\~\~ 这是我的 obsidian 仓库，写进 CLAUDE.md 里记住路径
```

==后续在使用 claude code 的过程中有什么值得写入 CLAUDE.md 的信息，直接发以下 prompt 即可==：

```
根据上面的信息/对话优化 CLAUDE.md
```