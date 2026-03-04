---
render_with_liquid: false
title: "AI SDK and AI Gateway now integrated in GitHub Actions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ai-sdk-and-ai-gateway-now-integrated-in-github-actions"
date: "2025-09-08"
scraped_at: "2026-03-02T09:28:55.204136077+00:00"
language: "en-zh"
translated: true
description: "You can now access the AI SDK and AI Gateway with the vercel/ai-action@v2 GitHub Action.  Use it to generate text or structured JSON directly in your workflows by configuring a prompt, model, and api-..."
---
render_with_liquid: false
render_with_liquid: false

Sep 8, 2025

2025 年 9 月 8 日

You can now use the `vercel/ai-action@v2` [GitHub Action](https://github.com/marketplace/actions/vercel-ai) to access the [AI SDK](https://ai-sdk.dev/) and [AI Gateway](https://vercel.com/ai-gateway), generating text or structured JSON directly in your workflows by specifying a `prompt`, `model`, and `api-key`.

现在，您可使用 `vercel/ai-action@v2` [GitHub Action](https://github.com/marketplace/actions/vercel-ai) 接入 [AI SDK](https://ai-sdk.dev/) 和 [AI Gateway](https://vercel.com/ai-gateway)，只需在工作流中指定 `prompt`、`model` 和 `api-key`，即可直接生成文本或结构化 JSON。

This integration enables new AI powered use cases for Github Actions, like summarizing what made it into a release, a light PR code review, comment moderation, or finding duplicate or relevant issues. For example, you can use it to triage issues like:

该集成为 GitHub Actions 开启了多种全新 AI 驱动的应用场景，例如：汇总本次发布包含的内容、执行轻量级的 Pull Request 代码审查、评论内容审核，或查找重复或相关的问题。例如，您可用它实现问题分类（triage），如下所示：

triage.yml

triage.yml

```text
on:

2  issues:

3    types: [opened]



jobs:

6  generate-text:
```

7    runs-on: ubuntu-latest

7    运行环境：ubuntu-latest

8    steps:

8    步骤：

9      - uses: vercel/ai-action@v2

9      - 使用：vercel/ai-action@v2

10        id: prompt

10        ID：prompt

11        with:

11        参数：

12          model: "openai/gpt-5"

12          模型："openai/gpt-5"

13          api-key: ${{ secrets.AI_GATEWAY_API_KEY }}

13          API 密钥：${{ secrets.AI_GATEWAY_API_KEY }}

14          prompt: |

14          提示词：|

15            Is this an urgent issue? Say "yes" if it's preventing a user from doing something critical.

15            这是否是一个紧急问题？如果该问题正阻碍用户执行某项关键操作，请回答“yes”。

17            Issue Title: ${{ github.event.issue.title }}

17            问题标题：${{ github.event.issue.title }}

19            Issue Body: ${{ github.event.issue.body }}

19            问题正文：${{ github.event.issue.body }}

20      - if: steps.prompt.outputs.text == 'yes'

20      - if: steps.prompt.outputs.text == 'yes'

21        run: gh issue edit ${{ github.event.issue.html_url }} --add-label urgent

21        run: gh issue edit ${{ github.event.issue.html_url }} --add-label urgent

22        env:

22        env:

23          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}

23          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

Learn more and see examples in the [Github Actions marketplace](https://github.com/marketplace/actions/vercel-ai) or [view the source code](https://github.com/vercel/ai-action).

更多详情及示例，请参阅 [GitHub Actions 市场](https://github.com/marketplace/actions/vercel-ai)，或 [查看源代码](https://github.com/vercel/ai-action)。

[**Start using Vercel AI Gateway**\\
\\
Unify access to hundreds of AI models through one endpoint with automatic failover, simplified authentication, and no key management.\\
\\
Get an API Key](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fapi-keys%3Futm_source%3Dai_gateway_landing_page&title=Get+an+API+Key)

[**立即开始使用 Vercel AI Gateway**\\
\\
通过单一端点统一访问数百种 AI 模型，支持自动故障转移、简化的身份验证，且无需管理 API 密钥。\\
\\
获取 API 密钥](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fapi-keys%3Futm_source%3Dai_gateway_landing_page&title=Get+an+API+Key)