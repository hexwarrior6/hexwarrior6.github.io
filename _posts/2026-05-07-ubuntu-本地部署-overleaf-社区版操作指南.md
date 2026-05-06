---
layout: post
title: Ubuntu 本地部署 Overleaf 社区版操作指南
date: 2026-05-07 00:09 +0800
description: 记录在 Ubuntu 环境下使用 Docker 部署 Overleaf 社区版的完整流程，包含核心配置与局域网访问设置。
categories: [实用工具]
tags: [Overleaf, Docker, Ubuntu, LaTeX]
---

### 1. 部署目的
在本地服务器或内网环境中部署 Overleaf 社区版，实现 LaTeX 文档的本地化编写与多人协作，确保数据完全掌握在自己手中，并解决公共网络访问不稳定及隐私安全问题。

### 2. 环境
*   **操作系统**：Ubuntu 22.04 LTS
*   **依赖工具**：需提前安装 Docker 和 Docker Compose。

### 3. 部署操作流程

#### 3.1. 安装系统依赖与 Docker 环境
更新系统基础环境，并安装 Docker 及 Docker Compose。

#### 3.2. 获取并初始化 Overleaf Toolkit
使用官方 Toolkit 工具包进行部署管理。

```bash
# 克隆工具包仓库
git clone https://github.com/overleaf/toolkit.git ./overleaf-toolkit
cd ./overleaf-toolkit

# 初始化配置文件
bin/init
```

#### 3.3. 修改核心配置文件
编辑 `config/overleaf.rc` 文件，配置监听 IP、端口及数据存储路径。

```bash
# 编辑配置文件
nano config/overleaf.rc
```

**关键配置项修改如下：**
*   `OVERLEAF_LISTEN_IP=0.0.0.0`：允许所有 IP 访问（支持局域网访问）。
*   `OVERLEAF_PORT=9000`：指定访问端口（避免与系统 80 端口冲突）。

#### 3.4. 启动 Overleaf 服务
使用 Toolkit 封装的脚本 `bin/up` 安装启动 Docker 容器。

```bash
# 后台启动服务
bin/start

# 查看服务运行状态与日志
docker compose ps
```

#### 3.5. 创建管理员账号
服务启动成功后，在浏览器中访问 `http://你的服务器IP:9000/launchpad`。
在页面中输入管理员邮箱和密码，点击 Register 完成注册，随后即可登录主界面。

### 4. 使用与维护

*   **访问地址**：
    *   本机访问：`http://localhost:9000`
    *   局域网访问：`http://服务器内网IP:9000`
*   **服务管理**：
    *   停止服务：`bin/stop`
    *   查看日志：`docker compose logs -f`
    *   重启服务：`bin/stop && bin/start`

### 5. 故障排查：数据库异常重置
当遇到 MongoDB 版本兼容性报错（如 Invalid MONGO_VERSION）或数据库数据损坏导致无法启动时，可执行终极重置操作。

**⚠️ 注意：此操作会彻底删除所有 Overleaf 项目数据，请谨慎执行！**

```bash
# 1. 停止所有 Overleaf 相关容器
bin/stop

# 2. 彻底删除本地挂载的数据目录
rm -rf data

# 3. 重新启动服务（会自动生成全新的数据目录）
bin/up
```