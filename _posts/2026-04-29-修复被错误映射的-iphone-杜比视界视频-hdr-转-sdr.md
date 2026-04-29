---
layout: post
title: 修复被错误映射的 iPhone 杜比视界视频（HDR 转 SDR）
date: 2026-04-29
description: 使用 DaVinci Resolve 通过 Color Space Transform 将错误解析的 HDR 视频还原为正常 SDR 显示
categories: [摄影, 视频剪辑]
tags: [HDR, DaVinciResolve, 视频修复]
---

## 目的

将被错误解析为 SDR 的 iPhone 杜比视界（Dolby Vision）视频，还原为正常显示的 SDR 视频。

---

## 环境

- DaVinci Resolve
- 素材：iPhone 拍摄的 HDR 视频（出现发灰问题）

---

## 操作步骤

### 1. 导入素材

将视频拖入时间线（Timeline），进入 **Color（调色）** 页面。

---

### 2. 添加 Color Space Transform

在右上角 **Effects** 面板中搜索：

```text
Color Space Transform（色彩映射变换）
````

拖拽到当前素材的节点（Node）上。

---

### 3. 设置参数（核心）

在右侧 Inspector 中设置如下参数：

```text
Input Color Space: Rec.2020
Input Gamma: Rec.2100 HLG

Output Color Space: Rec.709
Output Gamma: Gamma 2.4

Tone Mapping Method: DaVinci DRT
```

---

## 使用说明

* 设置完成后，画面会从“发灰”恢复为正常对比度和色彩
* 如果画面亮度异常，可尝试修改：

```text
Input Gamma: ST2084 (PQ)
```

---

## 说明

* 使用 Color Space Transform 是标准的色彩空间转换方法
* 相比直接调整对比度，可以更准确还原原始画面信息
