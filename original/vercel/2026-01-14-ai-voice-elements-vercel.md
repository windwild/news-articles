---
title: "AI Voice Elements - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ai-voice-elements"
date: "2026-01-14"
scraped_at: "2026-03-02T09:22:46.274028033+00:00"
language: "en"
translated: false
description: "Today we're releasing a brand new set of components for AI Elements designed to work with the Transcription and Speech functions of the AI SDK, helping you build voice agents."
---




Jan 14, 2026

![](images/ai-voice-elements-vercel/img_001.jpg)![](images/ai-voice-elements-vercel/img_002.jpg)

Today we're releasing a brand new set of components for AI Elements designed to work with the [Transcription](https://ai-sdk.dev/docs/ai-sdk-core/transcription) and [Speech](https://ai-sdk.dev/docs/ai-sdk-core/speech) functions of the AI SDK, helping you build the next generation of voice agents, transcription services and apps powered by natural language.

## Persona

The `Persona` component displays an animated AI visual that responds to different conversational states. Built with Rive WebGL2, it provides smooth, high-performance animations for various AI interaction states including idle, listening, thinking, speaking, and asleep. The component supports multiple visual variants to match different design aesthetics.

```bash
npx ai-elements@latest add persona
```

## Speech Input

The `SpeechInput` component provides an easy-to-use interface for capturing voice input in your application. It uses the Web Speech API for real-time transcription in supported browsers (Chrome, Edge), and falls back to MediaRecorder with an external transcription service for browsers that don't support Web Speech API (Firefox, Safari).

```bash
npx ai-elements@latest add speech-input
```

## Transcription

The `Transcription` component provides a flexible render props interface for displaying audio transcripts with synchronized playback. It automatically highlights the current segment based on playback time and supports click-to-seek functionality for interactive navigation.

```bash
npx ai-elements@latest add transcription
```

## Audio Player

The `AudioPlayer` component provides a flexible and customizable audio playback interface built on top of media-chrome. It features a composable architecture that allows you to build audio experiences with custom controls, metadata display, and seamless integration with AI-generated audio content.

```bash
npx ai-elements@latest add audio-player
```

![](images/ai-voice-elements-vercel/img_003.jpg)![](images/ai-voice-elements-vercel/img_004.jpg)

## Microphone Selector

The `MicSelector` component provides a flexible and composable interface for selecting microphone input devices. Built on shadcn/ui's Command and Popover components, it features automatic device detection, permission handling, dynamic device list updates, and intelligent device name parsing.

```bash
npx ai-elements@latest add mic-selector
```

![](images/ai-voice-elements-vercel/img_005.jpg)![](images/ai-voice-elements-vercel/img_006.jpg)

## Voice Selector

The `VoiceSelector` component provides a flexible and composable interface for selecting AI voices. Built on shadcn/ui's Dialog and Command components, it features a searchable voice list with support for metadata display (gender, accent, age), grouping, and customizable layouts. The component includes a context provider for accessing voice selection state from any nested component.

```bash
npx ai-elements@latest add voice-selector
```

![](images/ai-voice-elements-vercel/img_007.jpg)![](images/ai-voice-elements-vercel/img_008.jpg)