---
render_with_liquid: false
title: "Chat SDK adds Telegram adapter support - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/chat-sdk-adds-telegram-adapter-support"
date: "2026-02-27"
scraped_at: "2026-03-02T09:21:21.122510591+00:00"
language: "en-zh"
translated: true
description: "Chat SDK now supports Telegram for webhook-based bot integrations with mentions, reactions, DMs, and interactive buttons."
---
render_with_liquid: false
render_with_liquid: false

Feb 27, 2026

2026 年 2 月 27 日

Chat SDK 现已支持 Telegram，将其“单代码库”架构进一步扩展至 Slack、Discord、GitHub 和 Teams，并新增了 [Telegram 适配器](https://www.chat-sdk.dev/docs/adapters/telegram)。

团队可构建支持提及（mentions）、消息反应（reactions）、私信（direct messages）以及输入状态指示器（typing indicators）的机器人。

该适配器支持单文件上传，并能渲染基础文本卡片（text cards），包括普通按钮（buttons）和链接按钮（link buttons）；这些按钮在 Telegram 中以内联键盘（inline keyboard）形式呈现，使开发者能够直接在 Telegram 聊天界面中创建交互式工作流。

**开始配置 Telegram 适配器：**

```typescript
import { Chat } from "chat";

import { createTelegramAdapter } from "@chat-adapter/telegram";

const bot = new Chat({

5  userName: "mybot",

6  adapters: {

7    telegram: createTelegramAdapter(),

8  },

9});



bot.onNewMention(async (thread, message) => {

12  await thread.post(`You said: ${message.text}`);

13});
```

Telegram 不向机器人开放完整的历史消息 API，因此消息历史依赖于适配器层面的缓存。此外，回调数据（callback data）限制为 64 字节，且该平台目前不支持模态框（modals）或临时消息（ephemeral messages）。

请阅读 [文档](https://www.chat-sdk.dev/docs/adapters/telegram) 开始使用。