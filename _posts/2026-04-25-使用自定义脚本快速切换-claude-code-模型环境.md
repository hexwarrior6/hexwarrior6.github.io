---
layout: post
title: 使用自定义脚本快速切换 Claude Code 模型环境
date: 2026-04-25
description: 通过 shell 脚本封装环境变量，实现一键切换 Claude Code 不同模型与 API 配置
categories: [开发工具]
tags: [Claude, Shell, 环境配置]
---

## 背景

在使用 Claude Code 时，如果需要在不同的 API 服务或模型之间切换（例如不同的 coding plan），每次手动修改配置会比较繁琐。因此可以通过 shell 脚本封装环境变量，实现“一条命令直接启动对应环境”。

---

## 目标

实现如下效果：

```bash
claude_minimax
````

直接启动 Claude，并自动使用指定的：

* API 地址
* API Key
* 模型名称

---

## 实现步骤

> 以 minimax 为例

### 1. 创建脚本

在目录 `~/.local/bin` 下创建脚本：

```bash
nano ~/.local/bin/claude_minimax
```

写入内容：

```bash
#!/bin/bash

export ANTHROPIC_BASE_URL="your-API-endpoint"
export ANTHROPIC_AUTH_TOKEN="your-token"
export ANTHROPIC_MODEL="minimax-m2.5"

claude
```

---

### 2. 添加执行权限

```bash
chmod +x ~/.local/bin/claude_minimax
```

---

### 3. 配置 PATH（如果尚未配置）

编辑：

```bash
nano ~/.zshrc
```

加入：

```bash
export PATH="$HOME/.local/bin:$PATH"
```

使其生效：

```bash
source ~/.zshrc
```

---

### 4. 使用

直接在终端执行：

```bash
claude_minimax
```

即可启动 Claude，并使用对应配置。

---

## 说明

* 脚本中的 `export` 仅在当前进程中生效，不会污染全局环境
* 每个脚本对应一套独立配置，适合多环境切换
* 可以按同样方式创建多个脚本，例如：

```bash
claude_glm5
claude_kimi
claude_xxx
```

---

## 总结

通过将环境变量与启动命令封装进 shell 脚本，并放入 `~/.local/bin`，可以将复杂配置简化为一个命令，实现高效、可复用的多环境切换。
