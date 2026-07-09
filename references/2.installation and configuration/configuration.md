
[[index（索引）]]

previous article  [[a-claude code/references/2.installation and configuration/installation|installation]]

next article  [[document framework（claude code）]]

---

# 添加 claude code 配置

## step1

运行 ubuntu后，输入以下指令

`nano .claude/settings.json`

## step2

从下面配置代码中替换准备好的==API KEY==，并复制粘贴进配置界面

![[configuration-1.png]]

## step3

保存并退出该界面
- ctrl + x
- y
- 回车

**注**：全程切换至英文输入法

---

==**小米 mimo==  （首推这个）

{
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.xiaomimimo.com/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "==API KEY==",
    "ANTHROPIC_MODEL": "mimo-v2.5[1m]",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "mimo-v2.5-pro[1m]",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "mimo-v2.5-pro-ultraspeed[1m]",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "mimo-v2.5[1m]"
  }
}

---

==**deepseek==  （其次这个）

{
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.deepseek.com/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "==API KEY==",
    "ANTHROPIC_API_KEY": "",
    "ANTHROPIC_MODEL": "deepseek-v4-flash[1m]"
  }
}

---

==**openrouter==  （国外模型用这个）

{
  "env": {
    "ANTHROPIC_BASE_URL": "https://openrouter.ai/api",
    "ANTHROPIC_AUTH_TOKEN": "==API KEY==",
    "ANTHROPIC_API_KEY": "",
    
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "anthropic/claude-3.5-sonnet",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "anthropic/claude-opus-4",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "anthropic/claude-3.5-haiku"
  }
}

---
