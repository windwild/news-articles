---
title: "Slack Agent Skill simplifies building Slack agents with coding assistants - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/slack-agent-skill-simplifies-building-slack-agents-with-coding-assistants"
date: "2026-02-24"
scraped_at: "2026-03-02T09:21:24.864837210+00:00"
language: "en-zh"
translated: true
description: "Use the Slack Agent Skill in your favorite coding agent to simplify the otherwise complex task of building Slack integrated agents"
---
{% raw %}

Feb 24, 2026

2026 年 2 月 24 日

[The Slack Agent Skill](https://skills.sh/vercel-labs/slack-agent-skill/slack-agent) is now available, enabling developers to build and deploy Slack agents in a single session with their coding agent of choice.

[Slack Agent 技能](https://skills.sh/vercel-labs/slack-agent-skill/slack-agent) 现已上线，使开发者能够借助自己选择的编程智能体（coding agent），在一个会话中完成 Slack 智能体的构建与部署。

The skill handles the complexity of OAuth configuration, webhook handlers, event subscriptions, and deployment so you can focus on what your agent should do rather than on infrastructure setup.

该技能自动处理 OAuth 配置、Webhook 处理器、事件订阅及部署等复杂环节，让您专注于定义智能体的功能逻辑，而非基础设施搭建。

The wizard walks through five stages:

向导将引导您完成五个阶段：

1. **Project setup:** Choose your LLM provider and initialize from the Slack Agent Template

1. **项目初始化：** 选择您的大语言模型（LLM）提供商，并基于 Slack Agent 模板进行初始化

2. **Slack app creation:** Generate a customized app manifest and create the app in Slack's console

2. **创建 Slack 应用：** 生成定制化的应用清单（app manifest），并在 Slack 控制台中创建该应用

3. **Environment configuration:** Set up signing secrets, bot tokens, and API keys with validation

3. **环境配置：** 配置签名密钥（signing secret）、机器人令牌（bot token）和 API 密钥，并自动执行有效性验证

4. **Local testing:** Run locally with ngrok and verify the integration

4. **本地测试：** 使用 ngrok 在本地运行并验证集成效果

5. **Production deployment:** Deploy to Vercel with environment variables configured automatically

5. **生产环境部署：** 自动配置环境变量，并一键部署至 Vercel

Install the skill and run the wizard by invoking it in your coding agent (for example, `/slack-agent new` in Claude Code).

在您的编程智能体中调用该技能（例如，在 Claude Code 中输入 `/slack-agent new`），即可安装技能并启动向导。

```bash
npx skills add vercel-labs/slack-agent-skill
```

```bash
npx skills add vercel-labs/slack-agent-skill
```

Try the [skill](https://skills.sh/vercel-labs/slack-agent-skill/slack-agent) to make your custom agent or use the [Slack Agent Template](https://vercel.com/templates/nitro/slack-agent-template) to deploy right away and customize later.

试用该 [技能](https://skills.sh/vercel-labs/slack-agent-skill/slack-agent)，快速构建您自己的定制化智能体；或直接使用 [Slack Agent 模板](https://vercel.com/templates/nitro/slack-agent-template)，立即部署，后续再进行个性化定制。
{% endraw %}
