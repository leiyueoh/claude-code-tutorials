
[[index]]

previous article  [[claude code]]

next article  [[tools and configurations]]

---

# 简介

claude code 官方主要为 **Linux** /macOS 设计，在 Windows 原生环境下体验较差，所以普遍推荐在 Windows 中安装 **Linux** 系统来运行 claude code

同时，在 [[claude code]] 中提到，**CLI 版（Terminal）** 是功能最完整的核心版本

所以综上所述，我们将在 Windows 中使用 ==wsl + ubuntu==方案

---

# 介绍

## 1. Linux

Linux 是一个免费、开源的操作**系统内核（Kernel）**，由 Linus Torvalds 于 1991 年创建

**核心特点**:
- 开源免费：任何人可以查看、修改、重新发布源代码
- 高度稳定、安全：广泛用于服务器、超级计算机、嵌入式设备
- 命令行强大：Shell（bash/zsh）是其灵魂
- 包管理器：apt（Debian/Ubuntu）、yum/dnf（Red Hat）、pacman（Arch）等
- 多用户、多任务：设计之初就考虑服务器场景
- 跨平台：从手机（Android）、服务器、桌面到超级计算机都能运行

**Linux 是全世界最重要且使用最广泛的系统**：
- 服务器 / 云 / 企业级系统**，占据全球服务器市场 70%+ 份额
- 移动操作系统（全球使用量最大）**
	- Android（基于 Linux 内核）
	- Android 衍生系统：LineageOS、GrapheneOS、HarmonyOS（鸿蒙）
- 嵌入式 / IoT / 智能设备
	- 车机系统
	- 智能家居系统

==Linux 系统是信息时代发展的基石之一，而且是目前最重要、最具基础性的那一块==

**同时 Linux 本身不是一个完整的操作系统，而是一个内核**（Kernel）。不同的发行版就是在 Linux 内核基础上，搭配不同的软件、桌面环境、包管理器和配置，形成的“完整操作系统”

**以下是普通用户可以直接安装使用的发行版**：
- ==**Ubuntu**（最推荐入门）==
- **Linux Mint**（基于 Ubuntu，界面更友好）
- **Fedora**（Red Hat 社区版，新技术快）
- **Debian**（极其稳定）
- **Arch Linux**（高度自定义，滚动更新）
- **Pop!_OS**（System76 出品，适合 NVIDIA 用户）
- **Manjaro**（基于 Arch，易用性更好）
- **Zorin OS**、**elementary OS**（界面类似 Windows / macOS）
- **openSUSE**

## 2. wsl

WSL（Windows Subsystem for Linux） 是微软开发的一项功能，**在 Windows 上能直接运行 Linux 环境**，无需安装虚拟机或双系统

**Claude Code 高度依赖类 Unix 环境（Bash、shell 工具）**
- 它会大量使用 bash、make、各种 Linux CLI 工具来执行代码、调试、文件操作等。
- Windows 原生（PowerShell / CMD / Git Bash）路径兼容性差、shell 脚本经常失败、工具链不完整

同时 wsl 支持 sandboxing（沙箱执行），能安全地让 claude code 执行命令（防止恶意代码或 prompt injection 影响主机）

## 3. ubuntu

ubuntu 是目前全球最受欢迎的 Linux 操作系统之一，由英国公司 Canonical 主导开发和维护。它基于 Debian，目标是让 Linux “人人可用” ，既适合普通用户，也深受开发者、服务器运维和 AI/编程爱好者喜爱

## 4. Windows wsl ubuntu 三者之间关系

简单来说，**Windows、WSL 和 Ubuntu 三者之间是“操作系统”、“兼容层”与“具体 Linux 发行版”的关系。** 它们协同工作，让你可以在不需要安装双系统或复杂虚拟机的情况下，直接在 Windows 里流畅地运行 Linux 环境

![[operating environment-1.png]]

**Windows** 作为大底层，掌控着 CPU、内存、硬盘等所有物理硬件
**WSL** 在 Windows 内部开辟了一个高效的绿色通道（在 WSL2 中是一个超轻量、秒级启动的虚拟机）
**Ubuntu** 躺在 WSL 的通道里运行，当你输入 Linux 命令（比如 `sudo apt update`）时，Ubuntu 把命令交给 WSL，WSL 再找 Windows 伸手要硬件资源来执行

**常见误区澄清**：
- **WSL 不等于 Ubuntu**：WSL 只是一个平台。除了 Ubuntu，你还可以在 WSL 里安装 Debian、Kali Linux、Arch Linux 等其他“外国居民”（Linux 发行版）。Ubuntu 只是其中最常用、官方默认推荐的一个。
- **它不是传统虚拟机（如 VMware / VirtualBox）**：传统的虚拟机非常笨重，需要单独划分几 GB 内存和几十 GB 硬盘，启动慢，且两边系统文件不互通。而 WSL 与 Windows 融合得极深，**你可以在 Windows 里直接访问 Ubuntu 的文件，反之亦然，且性能损耗极低，启动只需 1 秒**
- **它也不是双系统**：双系统要求你在开机时“二选一”，进了 Windows 就不能用 Linux。而 WSL 让你**在用 Windows 的同时，像打开一个软件一样打开 Ubuntu**

---

# 总结

claude code 的核心功能依赖类 Unix 环境，而 wsl + ubuntu 是在 Windows 上实现这一目标的最佳平衡点——既有接近原生的 Linux 体验，又免去虚拟机或双系统带来的割裂感与性能开销

Ubuntu 提供稳定易用的发行版，WSL 提供轻量高效的兼容层，二者结合，是 Windows 用户能以最低门槛获得最完整的 Claude Code 使用体验

因此 wsl + ubuntu 是 Windows 框架下最理想且高效的使用方案

通过长期以 claude code 为出发点对该系统框架的使用，可以大大提升对操作系统的理解，也能很好的锻炼逻辑能力