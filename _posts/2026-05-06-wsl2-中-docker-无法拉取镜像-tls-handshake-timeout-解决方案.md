---
layout: post
title: WSL2 中 Docker 无法拉取镜像（TLS handshake timeout）解决方案
date: 2026-05-06 18:22 +0800
description: 解决 WSL2 环境下 Docker pull 镜像时报 TLS handshake timeout 的问题
categories: [开发工具]
tags: [WSL2, Docker, Proxy, Clash]
---

## 目的

解决在 WSL2 环境中执行 `docker pull` 时出现 `TLS handshake timeout`，无法拉取镜像的问题。

---

## 环境前提

* Windows + WSL2
* 已开启代理（如 Clash / v2ray / sing-box）
* WSL 内可以访问外网（如 `curl` 正常）
* Docker 已安装在 WSL 中

---

## 问题表现

执行：

```bash
docker pull mongo:8.0
```

报错：

```text
failed to resolve reference "docker.io/library/mongo:8.0":
net/http: TLS handshake timeout
```

---

## 核心原因

Docker daemon 不会继承 shell 中的代理环境变量，导致：

* `curl` 可以访问外网（走代理）
* `docker pull` 无法访问（未走代理）

---

## 解决步骤

### 1. 创建 Docker 代理配置目录

```bash
sudo mkdir -p /etc/systemd/system/docker.service.d
```

---

### 2. 配置 HTTP / HTTPS 代理

```bash
sudo nano /etc/systemd/system/docker.service.d/http-proxy.conf
```

写入：

```ini
[Service]
Environment="HTTP_PROXY=http://127.0.0.1:7897"
Environment="HTTPS_PROXY=http://127.0.0.1:7897"
```

说明：

* `127.0.0.1:7897` 为本地代理端口，根据实际代理软件调整
* 必须使用 HTTP 代理格式

---

### 3. 重新加载并重启 Docker

```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl restart docker
```

---

### 4. 验证代理是否生效

```bash
systemctl show --property=Environment docker
```

输出中应包含：

```text
HTTP_PROXY=http://127.0.0.1:7897
HTTPS_PROXY=http://127.0.0.1:7897
```

---

### 5. 测试拉取镜像

```bash
docker pull mongo:8.0
```

若成功开始下载镜像，说明问题已解决。

---

## 使用方式

后续正常使用 Docker 命令即可，例如：

```bash
docker pull ubuntu
docker run -it ubuntu bash
```

无需额外配置。

---

## 补充说明

* 若代理端口变化，需要同步修改配置文件并重启 Docker
* 若使用 TUN 模式代理，建议确保本地代理端口对 WSL 可访问
* 该方法适用于所有 Docker 网络访问问题（如超时、连接失败等）

---

## 总结

通过为 Docker daemon 单独配置代理，使其网络请求走本地代理，从而解决 WSL2 环境下无法拉取镜像的问题。
