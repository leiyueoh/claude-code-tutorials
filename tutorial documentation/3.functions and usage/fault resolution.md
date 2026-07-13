
[[index]]

previous article  [[instructions]]

next article  [[CLADUE.md]]

---

**注**：使用 claude update 指令升级时，要保持耐心，切记不要中断了，否则就回出现下面的 ==claude code 故障==

![[fault resolution-3.png]]

- ==更新全程需开启 VPN==
- 更新时间受更新文件大小、网速影响，尽量耐心一些；实在是卡了很久下策才是中断，然后按照下面指示进行重装

---

# claude code 故障

==解决 claude code 故障时需全程开启 VPN ，且优先选择新加坡、日本、美国节点==

![[fault resolution-1.png]]

![[fault resolution-2.png]]

**当在 ubuntu 启动 claude code 时出现上述故障报错**

```
claude：command not found
-bash：/home/user/.nvm/versions/node/v18.20.8/bin/claude： No such file or directory
```

==都是（自动）更新失败或文件缺失造成的==

**可以通过重装 claude code 解决以上问题**：

==**在 ubuntu 里逐条复制粘贴指令回车执行即可**==

**方法一**：

**删除 claude code（历史文件保留）**

```
npm uninstall -g @anthropic-ai/claude-code
```

**重新安装**

```
npm install -g --include=optional @anthropic-ai/claude-code
```

==方法一有可能会因为 claude code 有残留程序而导致删除文件失败，那么就使用方法二==

**方法二**：

**关闭现有进程**

```
pkill -f claude || true
```

**删除主目录**

```
rm -rf ~/.nvm/versions/node/v18.20.8/lib/node_modules/@anthropic-ai/claude-code
```

**删除 npm 残留临时目录**

```
rm -rf ~/.nvm/versions/node/v18.20.8/lib/node_modules/@anthropic-ai/.claude-code-*
```

**清理 npm 缓存**

```
npm cache clean --force
```

**删除 claude code（历史文件保留）**

```
npm uninstall -g @anthropic-ai/claude-code
```

**重新安装**

```
npm install -g --include=optional @anthropic-ai/claude-code
```

---

# API 故障（基本不会出问题）

## 1. `400` / `invalid_request_error`

- **终端直接显示的特征**：
    
     `API Error: 400 {"type": "error", "error": {"type": "invalid_request_error", "message": "..."}}`
    
- **常见原因**：
    
    1. **DeepSeek 官方端点**：由于 DeepSeek 严格校验了请求体，而 Claude Code 会默认发送 `user_id` 等 Anthropic 特有的追踪字段，导致协议冲突报 400
        
    2. **MiMo 端点**：使用了不支持图片的多模态模型（如 `mimo-v2.5-pro`），却在会话中通过 `@` 引入了图片或包含富媒体的文件
    
- **处理方法**：在终端执行以下命令，关闭 Claude Code 发送非必要追踪头，然后重试：
	
	 export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1

### 2. `401` / `authentication_error`

- **终端直接显示的特征**：
    
    `API Error: 401 {"type": "error", "error": {"type": "authentication_error", "message": "invalid api key"}}`
    
- **常见原因**： `ANTHROPIC_API_KEY` 变量填错了，或者在当前的终端窗口中没有生效
	
 - **处理方法**： 更新 DeepSeek/MiMo API Key 并重新配置 json

### 3. `404` / `not_found_error`

- **终端直接显示的特征**：
    
    `There's an issue with the selected model (...). It may not exist or you may not have access to it.` 或者 `API Error: 404 {"type": "error", "error": {"type": "not_found_error", "message": "..."}}`
    
- **常见原因**：
    
    1. **MiMo 独有 Bug**：在交互中只要不小心输入了图片，MiMo 偶尔会非标地返回 404，导致 Claude Code 误以为“模型不存在”。
        
    2. **Base URL 路径不对**：比如 DeepSeek 的 Anthropic 兼容端点通常是 `[https://api.deepseek.com/anthropic](https://api.deepseek.com/anthropic)`（或者服务商指定的特殊后缀），如果少写了后缀，请求发到了错误的路径就会报 404
	
- **处理方法**：
	
	检查 `echo $ANTHROPIC_BASE_URL 的路径是否完整，必须严格按照服务商文档填写（不能只写到域名）
    
	在 Claude Code 中切勿发送或 @ 任何图片文件

### 4. `APIConnectionTimeoutError` / `504 Gateway Timeout`

- **终端直接显示的特征**：
    
     `APIConnectionTimeoutError: Request timed out.` 或者 `API Error: 504 Gateway Timeout`
    
- **常见原因**： Claude Code 作为一个 Agent，会让模型执行复杂的“思考-写代码”循环。中转平台（MiMo）或 DeepSeek 官方在单次响应上通常有 60~120 秒的最大超时限制。如果任务太庞大，模型还没吐完 Token，连接就被中转网关强行掐断了
	
- **处理方法**： 不要给大而全的指令；拆分任务：一次只让它改一个文件、写一个函数，让单次 API 响应时间控制在几十秒内

### 5. `429` / `rate_limit_error`

- **终端直接显示的特征**：
    
     `API Error: 429 {"type": "error", "error": {"type": "rate_limit_error", "message": "..."}}`
    
- **常见原因**：
    
    1. 触发了第三方账号的每分钟请求数（RPM）或每分钟 Token 数（TPM）限制
        
    2. 你的第三方账户余额扣完了
	
- **处理方法**：官网充值 