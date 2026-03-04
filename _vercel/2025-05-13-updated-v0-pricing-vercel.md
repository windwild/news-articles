---
title: "Updated v0 pricing - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/updated-v0-pricing"
date: "2025-05-13"
scraped_at: "2026-03-02T09:33:36.294113052+00:00"
language: "en-zh"
translated: true
description: "More flexible pricing for v0 that scales with your usage and lets you pay on-demand through credits."
---
{% raw %}

May 13, 2025

2025 年 5 月 13 日

We’re updating how pricing works in [v0](https://v0.dev/). Usage is now metered on input and output tokens which convert to credits, instead of fixed message counts.

我们正在更新 [v0](https://v0.dev/) 的计价方式：用量现按输入与输出 token 计量，并折算为积分（credits），不再按固定消息条数计费。

This gives you more predictable pricing as you grow and increases the amount of usage available on our free tier.

这使您在业务增长过程中获得更可预测的费用支出，同时提升了免费套餐所包含的可用用量额度。

Existing v0 users will transition to the new pricing at the start of your next billing period. New users will start on the improved pricing today.

现有 v0 用户将在您的下一个计费周期开始时自动切换至新计价方案；新用户则从今日起即采用优化后的计价方案。

## How it works

## 计费机制说明

Each v0 plan now comes with included monthly credits:

每档 v0 套餐现均包含每月固定额度的积分：

- Free users get $5 in included credits every month  
- 免费用户每月享有 $5 的含在套餐内的积分  

- Premium users get $20 in included credits every month  
- 高级用户每月享有 $20 的含在套餐内的积分  

- Each user on a Team plan gets $30 in included credits every month  
- 团队版（Team plan）下的每位用户每月享有 $30 的含在套餐内的积分  


**No action is required for existing v0 users**. All existing users will automatically move to the new billing model at the start of your next billing cycle. New users will automatically start with the updated billing model.

**现有 v0 用户无需任何操作**。所有现有用户将在您的下一个计费周期开始时自动切换至新计费模式；新用户将自动启用更新后的计费模式。

Users on Premium, Team, and Enterprise plans can purchase additional credits as needed. Existing Enterprise contracts remain unchanged. Purchased credits expire after one year and can be shared across your team on Team and Enterprise plans.

订阅 Premium、Team 和 Enterprise 套餐的用户可根据需要额外购买积分。现有 Enterprise 合同条款保持不变。所购积分有效期为一年，且在 Team 和 Enterprise 套餐下可由团队成员共享。

### Using credits

### 积分使用方式

v0 根据输入和输出的 token 数量，从您的账户余额中扣除相应积分：

![](images/updated-v0-pricing-vercel/img_001.jpg)![](images/updated-v0-pricing-vercel/img_002.jpg)

提示词越长、生成结果越庞大，所用 token 就越多，因此不同操作消耗的积分也各不相同。

v0 在生成响应时，还会自动纳入相关上下文信息，例如聊天历史、源文件以及 Vercel 特定知识。这些上下文内容均计入输入 token；而高质量响应往往需调用更多上下文，因而可能消耗更多 token。

以下是一些示例提示词：

- “ **我的应用该采用哪种渲染策略？**”

→ 输入短、输出短 = token 消耗低

- “ **为我构建一个支持深色主题的加密货币应用**”

→ Medium input, large output = more tokens

→ 中等长度输入，生成大量输出 = 消耗更多 token

- “ **Generate a multi-page app with a Supabase backend and authentication that incorporates the design from this screenshot**”

- “ **基于此截图的设计，生成一个带 Supabase 后端和身份认证功能的多页应用**”

→ Large input (from a large attachment), large output = even more tokens

→ 大型输入（例如来自大附件），配合大型输出 = 消耗更多 token

You can track usage and remaining credits in your settings page. Team and Enterprise owners can track usage for their entire teams.

您可在设置页面中查看用量统计及剩余积分。团队版（Team）与企业版（Enterprise）管理员可查看整个团队的用量情况。

![Updated Billing and Usage tab of your v0 Project Settings. ](images/updated-v0-pricing-vercel/img_003.jpg)![Updated Billing and Usage tab of your v0 Project Settings. ](images/updated-v0-pricing-vercel/img_004.jpg)Updated Billing and Usage tab of your v0 Project Settings.

![v0 项目设置中的“计费与用量”标签页已更新。](images/updated-v0-pricing-vercel/img_003.jpg)![v0 项目设置中的“计费与用量”标签页已更新。](images/updated-v0-pricing-vercel/img_004.jpg)v0 项目设置中的“计费与用量”标签页已更新。

## What’s next

## 下一步

All new v0 usage, beginning today, will be metered in tokens. You can view the updated pricing on [v0's pricing page](https://v0.dev/pricing).

自今日起，所有新增的 v0 使用量均将以 token 为单位进行计量。您可前往 [v0 官方定价页面](https://v0.dev/pricing) 查看最新定价详情。
{% endraw %}
