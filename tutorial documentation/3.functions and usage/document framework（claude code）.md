
[[index]]

previous article  [[configuration]]

next article  [[instructions]]

---

![[document farmework-1.png]]

- 下载了 ubuntu 版本的 Linux 后，电脑资源管理器左下角则会出现所对应的系统文件夹
- 里面有非常多的文件夹，这里我们都不用太在意，直接瞄准 home

---

![[document farmework-2.png]]

- 点击 home 后则可以看到 user（用户名）文件夹
- 继续点击文件夹

---

![[document framework-3.png]]

**核心文件**：
- ==projects：存放 claude code 所产出的文件
- ==CLAUDE.md：是写给 **AI Agent** 看的行为规范守则==

==CLAUED.md 可提供持久的记忆，每次出发 claude code 这份文档就回被读取一遍，可根据后续使用慢慢积累信息==

**claude code 相关内容**：
- ==.claude：claude code 核心文件==
- .claude.json：claude code 的主要配置文件
- .claude.json.backup：配置文件的自动备份文件
- .claude.json.tmp：配置文件的临时文件

**shell 配置**：
- .bashre：bash shell 配置文件，每次打开终端都会加载
- .bash_history：输入过的所有 bash 命令历史记录
- .bash_logout：退出终端时执行的清理脚本
- .profile：登录shell的配置文件

**开发工具配置**：
- .gitconfig：git 全局配置信息
- .gh.json：github 的认证配置
- .npm：npm包管理器的缓存和配置
- .nvm：node version manager，用于管理多个 node.js 版本
- .ssh：ssh密钥和配置（用于 github 和服务器连接）

**其他应用配置**：
- config：应用程序配置文件的通用目录
- .local：本地安装的软件和用户数据
- .cache：应用程序缓存
- .modelscope：modelscope 的配置和缓存
- .agent：AI 代理工具的配置

**其他**：
- Desktop：wsl 桌面文件
- bin：安装的可执行文件，脚本目录

==当中只有 CLAUDE.md 、 projects 、 .claude 这三个文件很重要，其他的不用太在意；里面的文件千万不要误删！==

---

- 点击打开 .claude ，显示 claude code 的核心文件部分

![[document framework-4.png]]

**主要文件说明（文件内容跟用户使用相关，不完全相同）**：
- ==skill：所有自定义 skill 的存放文件夹==
- ==projects：项目和会话历史记录==
- settings.json：claude code 的全局配置（模型、权限、MCP 服务等）
- settings.local.json：本地覆盖配置
- history.jsonal：所有对话的历史记录（json lines 格式，给 AI 看的）
- cache：临时缓存数据
- sessions：会话状态存储
- plans：计划模式的计划文件
- tasks：任务管理数据
- file-history：文件修改历史
- paste-cache：粘贴修改历史
- session-env：会话环境变量
- telemetry：使用数据记录
- plugins：插件目录
- jobs：定时任务数据
- stats-cache.json：使用统计缓存
- .last-cleanup：上次清理时间记录
- .last-update-result.json：上次更新结果
- .update.lock：更新锁文件

==日常使用只用关注 skill 和 projects 两个文件夹，其余的不用在意；其余的文件千万不要误删==

---

![[document framework-5.png]]

- 点开 projects
- 可以看到有很多 json 文件，每一个文件则对应了每一次 claude code 内的会话
- ==projects 下的 json 和文件夹可以删除作为清理（一般非必要不删除）==

---

![[document framework-6.png]]

- 点开 skills
- 这里存放了所有自定义的 skill 文件
- 存放在这里的 skill 文件都可以在 claude code CLI 界面中显示并打开