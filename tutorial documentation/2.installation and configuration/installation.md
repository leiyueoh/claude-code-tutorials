
[[index]]

previous article  [[tools and configurations]]

next article  [[configuration]]

---

==！！VPN优先挂日本美国节点，开tun和全局模式！！==

# step1
## 运行 powershell-wsl（管理员方式运行）

`wsl --install

---

# step2
## 安装 ubuntu

`wsl --install -d Ubuntu

首次启动 ubuntu，设置用户名密码

---

# step3
## 更新系统

`sudo apt update && sudo apt upgrade -y

---

# step4
## 安装配置环境
### git :  

`sudo apt install git -y

### python:  

`sudo apt install python3 python3-pip -y

### ==Node.js==

`curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

`sudo apt install -y nodejs

#### 验证安装

`node --version

`npm --version

#### 创建用户自己的全局目录

`mkdir -p \~/.npm-global

#### 设置 npm 使用这个目录

`npm config set prefix '\~/.npm-global

#### 把路径加入环境变量

`echo 'export PATH=\~/.npm-global/bin:$PATH' >> \~/.bashrc

`source \~/.bashrc

#### 验证

`echo $PATH

`npm config get prefix

---

# step5
## 安装 claude code

`npm install -g @anthropic-ai/claude-code

### 验证是否安装成功

`claude --version

---

==**注**：复制指令时注意别复制到符号了==