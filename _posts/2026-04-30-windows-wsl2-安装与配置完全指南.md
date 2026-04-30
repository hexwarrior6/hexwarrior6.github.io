---
layout: post
title: Windows WSL2 安装与配置完全指南
date: 2026-04-30
description: WSL2 安装、多发行版管理、文件互访、图形界面、显卡直通、网络配置、Docker 集成一站式操作手册
categories: [开发工具]
tags: [WSL2, Ubuntu, Docker, 显卡直通]
original_url: https://www.bilibili.com/video/BV1tW42197za
original_author: 技术爬爬虾
original_source: 超详细的WSL教程：Windows上的Linux子系统
---

## 1. 用途
在 Windows 中原生运行 Linux 环境，支持命令交互、图形程序、Docker、CUDA 加速，实现 Windows 与 Linux 无缝协同。

---

## 2. 前置条件
1. 开启 CPU 虚拟化（BIOS 开启 Intel VT-x / AMD-V）
2. 启用 Windows 功能：
   - 适用于 Linux 的 Windows 子系统
   - 虚拟机平台
3. 安装后重启电脑

---

## 3. 一键安装 WSL2
```powershell
wsl --install
```
默认安装 Ubuntu，国内网络建议加 `--web-download` 提升稳定性

安装完成后设置 Linux 用户名与密码

---

## 4、发行版管理
### 查看可安装发行版
```powershell
wsl --list --online
```

### 安装指定发行版
```powershell
wsl --install <DistroName>
```

### 查看已安装子系统
```powershell
wsl --list --verbose
```

### 设置默认发行版
```powershell
wsl --set-default <DistroName>
```

### 卸载发行版

```powershell
wsl --unregister <DistroName>
```

---

## 5、备份与迁移
### 导出备份
```powershell
wsl --export <DistroName> 备份文件名.tar
```

### 导入到其他盘
```powershell
wsl --import <新名称> <存放路径> <备份文件.tar>
```

---

## 6、文件互访
- Windows 访问 Linux：文件资源管理器地址栏输入 `\\wsl$`
- Linux 访问 Windows：磁盘自动挂载到 `/mnt/c`、`/mnt/d` 等

### Linux 中运行 Windows 程序
```bash
notepad.exe 文件名
explorer.exe .
```

---

## 7、高级配置
### 启用 systemd（单发行版配置）
```bash
sudo vi /etc/wsl.conf
```
写入：
```ini
[boot]
systemd=true
```
关闭 WSL 等待 8 秒后生效。

### 配置镜像网络（全局配置）
在 Windows 用户目录创建 `.wslconfig`：
```ini
[wsl2]
networkingMode=mirror
```
关闭 WSL 等待 8 秒后生效
