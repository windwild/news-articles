---
title: "AI Voice Elements - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/ai-voice-elements"
date: "2026-01-14"
scraped_at: "2026-03-02T09:22:46.274028033+00:00"
language: "en-zh"
translated: true
description: "Today we're releasing a brand new set of components for AI Elements designed to work with the Transcription and Speech functions of the AI SDK, helping you build voice agents."
---

render_with_liquid: false
Jan 14, 2026

2026 年 1 月 14 日

![](images/ai-voice-elements-vercel/img_001.jpg)![](images/ai-voice-elements-vercel/img_002.jpg)

今天，我们正式发布一套全新的 AI Elements 组件，专为与 AI SDK 的 [Transcription（语音转文字）](https://ai-sdk.dev/docs/ai-sdk-core/transcription) 和 [Speech（语音合成与识别）](https://ai-sdk.dev/docs/ai-sdk-core/speech) 功能协同工作而设计，助力您构建下一代语音智能体（voice agents）、语音转写服务以及由自然语言驱动的应用程序。

## Persona（AI 角色形象）

## Persona（AI 角色形象）

`Persona` 组件以动画形式呈现 AI 视觉形象，并能响应不同的对话状态。该组件基于 Rive WebGL2 构建，可为各类 AI 交互状态（包括空闲、收听中、思考中、说话中、休眠中）提供流畅且高性能的动画效果。同时支持多种视觉变体，适配不同设计风格与美学需求。

```bash
npx ai-elements@latest add persona
```

## Speech Input（语音输入）

## Speech Input（语音输入）

`SpeechInput` 组件为您的应用提供了一套简洁易用的语音输入接口。它在支持 Web Speech API 的浏览器（如 Chrome、Edge）中采用该 API 实现实时语音转文字；而在不支持 Web Speech API 的浏览器（如 Firefox、Safari）中，则自动回退至 MediaRecorder，并结合外部语音转文字服务完成处理。

```bash
npx ai-elements@latest add speech-input
```

## Transcription（语音转文字）

## Transcription（语音转文字）

The `Transcription` component provides a flexible render props interface for displaying audio transcripts with synchronized playback. It automatically highlights the current segment based on playback time and supports click-to-seek functionality for interactive navigation.

`Transcription` 组件提供了一个灵活的 render props 接口，用于显示与音频播放同步的文本转录内容。它会根据当前播放时间自动高亮显示对应的文字片段，并支持点击跳转功能，实现交互式导航。

```bash
npx ai-elements@latest add transcription
```

## Audio Player

## 音频播放器

The `AudioPlayer` component provides a flexible and customizable audio playback interface built on top of media-chrome. It features a composable architecture that allows you to build audio experiences with custom controls, metadata display, and seamless integration with AI-generated audio content.

`AudioPlayer` 组件基于 media-chrome 构建，提供灵活且可定制的音频播放界面。其采用可组合式架构，支持自定义控制组件、元数据展示，并能与 AI 生成的音频内容无缝集成。

```bash
npx ai-elements@latest add audio-player
```

![](images/ai-voice-elements-vercel/img_003.jpg)![](images/ai-voice-elements-vercel/img_004.jpg)

## Microphone Selector

## 麦克风选择器

The `MicSelector` component provides a flexible and composable interface for selecting microphone input devices. Built on shadcn/ui's Command and Popover components, it features automatic device detection, permission handling, dynamic device list updates, and intelligent device name parsing.

`MicSelector` 组件提供了一个灵活且可组合的麦克风输入设备选择界面。该组件基于 shadcn/ui 的 Command 和 Popover 组件构建，具备自动设备检测、权限管理、动态更新设备列表以及智能解析设备名称等特性。

```bash
npx ai-elements@latest add mic-selector
```

![](images/ai-voice-elements-vercel/img_005.jpg)![](images/ai-voice-elements-vercel/img_006.jpg)

## Voice Selector

## 语音选择器

The `VoiceSelector` component provides a flexible and composable interface for selecting AI voices. Built on shadcn/ui's Dialog and Command components, it features a searchable voice list with support for metadata display (gender, accent, age), grouping, and customizable layouts. The component includes a context provider for accessing voice selection state from any nested component.

`VoiceSelector` 组件提供了一个灵活且可组合的界面，用于选择 AI 语音。该组件基于 shadcn/ui 的 Dialog 和 Command 组件构建，支持搜索的语音列表，并可显示元数据（如性别、口音、年龄）、按类别分组以及自定义布局。组件内置上下文提供器（context provider），使得任意嵌套子组件均可访问语音选择状态。

```bash
npx ai-elements@latest add voice-selector
```

```bash
npx ai-elements@latest add voice-selector
```

![](images/ai-voice-elements-vercel/img_007.jpg)![](images/ai-voice-elements-vercel/img_008.jpg)