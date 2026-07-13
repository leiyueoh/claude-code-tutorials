
[[index]]

previous article  [[document framework（claude code）]]

next article  [[fault resolution]]

---

# 启动指令（ubuntu）

![[instructions-1.png]]

- 点击启动 ubuntu 后在该界面进行指令输入

==claude  **启动claude code**==
claude -c  **启动claude code并同步近一次记录**
claude --dangerously-skip-permissions  **启动claude code并给claude code开启最高权限**
claude update  **检查更新**
claude --version  **查看当前版本**

ctrl + c：重置指令  

---

# claude code 日常指令（启动 claude code 后的指令）

---

ctrl + c（连续按两次）  **退出claude code**

Shift + Tab  **切换权限模式**

---

/help  **查看所有 claude code 指令**

/init  **扫描所有文件自动更新 CLAUDE.md**

---

==/resume  **查看历史会话**==

![[instructions-2.png]]

- 通过上下键，来选择历史会话记录，回车可选中

---

==/rename  **给当前会话重命名**==

![[instructions-3.png]]

- 格式为 **/rename + 空格 + 新名称**
- 如图所示，这个指令触发后，蓝色部分”文件说明“则会变更为”test“
- 同时再次触发 /resume 后，该会话的名称则会变为”test“

---

==/clear  **清空 claude code CLI 界面的上下文本记录**==

![[instructions-4.png]]

- 上下文对话没有了，相关配置和核心记忆还在

---

==/compact  **压缩上下文，节省token**==

![[instructions-5.png]]

- claude code 会自动压缩上下文的内容，形成一个精简版的总结存放在后端
- 整体使用不会有任何影响
- ==在同一会话中当高强度使用了几轮后就可以使用该指令==

---

==/btw  **临时提问，不计入上下文记录**==

![[instructions-6.png]]

- 格式为 **/btw + 问题**

---

==/model  **切换模型**==

![[instructions-7.png]]

- 上下键切换模型，回车确认

==/model + 模型名称  **切换指定模型**==

![[instructions-8.png]]

- 对模型名称的输入准确性要求非常高，不能一丁点出错

---

==/effort  **切换 claude code 的聪明程度**==

![[instructions-9.png]]

- 一般使用 high 即可
- 决定聪明程度的只有 low - max
- effort 越往左越快，越往右就越慢但更聪明
- ultracode 是以 xhigh 的聪明程度为基础的工作模式，是多 agent 并行工作

---

==/status  **查看claude code 和模型使用信息**==

![[instructions-10.png]]

- 上下左右键进行切换查看

---

==/context  **查看当前会话的上下文使用情况**==

![[instructions-11.png]]

- 现在模型的上下文大小额度为 ==1m = 1000k== tokens
- 右边可以查看当前使用模型和上下文使用量和占比
- 使用率达到 50% 时就可以使用 /compact 来压缩上下文省 token 了