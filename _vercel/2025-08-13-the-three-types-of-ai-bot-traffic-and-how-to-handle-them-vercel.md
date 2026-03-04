---
title: "The three types of AI bot traffic and how to handle them - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/the-three-types-of-ai-bot-traffic-and-how-to-handle-them"
date: "2025-08-13"
scraped_at: "2026-03-02T09:29:51.137273683+00:00"
language: "en-zh"
translated: true
description: "Bots account for over 20% of all web traffic. A quarter of that is AI crawlers alone. But not all bots are bad. Some are key to how your site gets discovered. Learn how AI bots shape visibility and wh..."
---
&#123;% raw %}

Aug 13, 2025

2025年8月13日

AI机器人流量正在全网持续增长。我们[实时追踪这一趋势](https://bots.fyi/stats)，数据显示，当前存在三类AI驱动型网络爬虫——它们常独立运行，却共同构成一个“发现飞轮”（discovery flywheel），许多团队在无意中扰乱了这一机制。

并非所有机器人都是有害的。数十年来，网络爬虫一直是搜索引擎的核心驱动力，而我们也同样花了数十年时间对其进行适配与优化。如今，大语言模型（LLM）亟需高质量训练数据，而构建于其上的AI工具则依赖及时、相关的内容更新。这标志着可发现性（discoverability）的新一轮浪潮已然到来；能否从一开始就正确应对，将直接决定AI是成为你的增长渠道，还是沦为一次错失的机遇。

今天屏蔽AI爬虫，无异于在搜索引擎发展早期就将其屏蔽，而后又困惑于自然搜索流量为何骤然消失。随着用户行为正从“在Google中搜索网页”，转向“向AI提问以获取直接答案及引用来源”，那些能清晰识别各类机器人、并精准判断“在何处开放访问才能创造价值”的网站，将占据显著优势。

## 三类AI机器人流量

## 三类AI机器人流量

当我们提及“AI机器人流量”时，所指的并非仅是恶意抓取器（spammy scrapers），而是专为训练、更新或运行AI系统而设计的自动化网络爬虫。它们访问你的网站，目的包括：采集内容用于模型训练、获取实时更新信息，或推送AI驱动的导流请求。

可将AI流量视作一条具有明确阶段划分的管道。你的内容不会被爬取一次便被遗忘；相反，每个阶段都以前一阶段为基础，层层递进，最终抵达终端用户。若你屏蔽爬虫，你的内容便无法进入训练数据集；没有训练数据，内容便无法被AI引用；而一旦无法被引用，你就无法获得AI驱动的导流。

你是否知道？上周，在所有Vercel部署站点的总流量中，机器人流量占比已超过20%；其中约四分之一，即单独来自AI爬虫。这部分流量中，虽有部分属恶意行为并已被自动拦截，但若妥善管理，相当大比例的AI爬虫流量实则能有效推动内容发现与业务增长。

### AI训练型爬虫：全面扫描一切内容

### AI训练型爬虫：全面扫描一切内容

AI训练型爬虫的目标，是广泛、实时地捕获全网信息，以便将这些数据整合进未来AI模型的回答能力之中。你网站上的内容，由此成为这些模型关于你产品的“知识储备”的一部分。此类爬虫（例如GPTBot和ClaudeBot）会尽可能访问所有公开页面，涵盖文档、博客文章、产品介绍页、定价页面以及更新日志等。

In our bot traffic dataset last week, training crawlers made up the largest share of AI bot traffic as they don't just revisit popular pages, they aim to cover the full breadth of a site so they can store as much relevant material as possible.

在我们上周的机器人流量数据集中，训练型爬虫（training crawlers）占据了 AI 机器人流量的最大份额——它们不仅会反复访问热门页面，更致力于全面覆盖整个网站，以便尽可能多地抓取并存储相关材料。

For an e-commerce site, if you publish detailed product descriptions, a training crawler can store them so an AI model can later answer “Where can I buy X?” and link to your store. Without being indexed, your docs will never make it into those answers.

对于一个电商网站而言，若您发布了详尽的产品描述，训练型爬虫便可将其抓取并存入模型知识库，使 AI 模型日后能回答“我在哪里可以买到 X？”之类的问题，并直接链接至您的店铺。若您的内容未被索引，就永远无法出现在这些答案中。

### AI engine grounding bots fetch real-time updates

### AI 引擎“接地”型爬虫获取实时更新

Grounding crawlers run when a user’s question needs current information that might not be in the training data. When someone asks ChatGPT “What’s new in Next.js 15?”, or Perplexity “Which startups are building in AI infrastructure?”, these systems check both their training data and live websites for updates.

当用户提出的问题需要当前信息（而该信息可能尚未纳入训练数据）时，“接地”型爬虫（grounding crawlers）便会启动。例如，当有人向 ChatGPT 提问“Next.js 15 有哪些新特性？”，或向 Perplexity 提问“哪些初创公司在构建 AI 基础设施？”，这些系统会同时检索其训练数据与实时网页，以获取最新动态。

If your content is in the training set, the system can reference it in responses. Without it, the system has nothing to reference, making citations unlikely. Out of sight often means out of mind.

如果您的内容已被纳入训练数据集，系统便可在回复中引用它；反之，系统将无从援引，导致引用几乎不可能发生。“看不见”往往就意味着“想不到”。

Even a single well-indexed page can generate [hundreds or thousands of mentions](https://x.com/rauchg/status/1910093634445422639) across different queries.

即使仅有一篇索引良好、质量上乘的页面，也可能在各类查询中引发[数百乃至数千次提及](https://x.com/rauchg/status/1910093634445422639)。

**Example**: A blog post announcing a new feature can be fetched by grounding bots within days of publication, letting the AI recommend your product to users searching for related tools much faster.

**示例**：一篇宣布新功能的博客文章，可能在发布后数日内即被“接地”型爬虫抓取，从而让 AI 能够更快地向正在搜索相关工具的用户推荐您的产品。

### AI referrals bring high-intent visitors

### AI 引荐流量带来高意向访客

AI referrals are human visitors who click through from AI-generated responses to your site. They often arrive after a highly relevant prompt led to a response that cited your content, so they already know what they are looking for and are ready to act. Many convert at higher rates after seeing a tailored summary or recommendation.

AI 引荐流量（AI referrals）是指那些从 AI 生成的回答中点击跳转至您网站的真实用户。他们通常是在输入高度相关的提示词（prompt）后，获得了一条明确引用了您内容的 AI 回复，因而抵达您网站时已清楚自己所需，并随时准备采取行动。许多用户在看到为其量身定制的摘要或推荐后，转化率显著提升。

In our network data, AI referrals still trail traditional search referrals in total volume but continue to grow each month. Some sites report higher conversion rates from this group than from organic search visitors.

根据我们网络的数据，AI 引荐流量在总访问量上目前仍低于传统搜索引擎引荐流量，但每月持续增长。部分网站反馈，该群体的转化率甚至高于自然搜索（organic search）访客。

**Example**: If an AI platform suggests your product in a list of “the best platforms for serverless deployment” and the user clicks through, they often arrive ready to evaluate or purchase.

**示例**：如果某个 AI 平台在“最佳无服务器部署平台”列表中推荐了您的产品，而用户点击进入，他们往往已做好评估或购买的准备。

![](images/the-three-types-of-ai-bot-traffic-and-how-to-handle-them-vercel/img_001.jpg)

## **Why blocking AI crawlers backfires**

## **为何屏蔽 AI 爬虫反而适得其反**

Some websites once blocked Google’s crawlers, thinking bots wasted bandwidth. "Why should I let Google crawl my site for free?" Those sites missed the search boom. Today, developers are making the same mistake with AI crawlers.

过去，一些网站曾屏蔽 Google 的爬虫，认为这类机器人会浪费带宽。“我凭什么免费让 Google 抓取我的网站？”结果，这些网站错失了搜索流量爆发的红利。如今，开发者正重蹈覆辙——对 AI 爬虫采取同样的屏蔽策略。

AI-powered search already handles billions of queries. Users now discover content through AI platforms alongside traditional search. Blocking AI crawlers cuts off a growing discovery channel, and these channels are an integral part of the source material AI systems draw from when generating answers, recommendations, and comparisons.

AI 驱动的搜索目前已处理数十亿次查询。用户如今既通过传统搜索引擎，也通过 AI 平台发现内容。屏蔽 AI 爬虫等于切断一条日益重要的内容发现渠道；而这些渠道，恰恰是 AI 系统生成答案、推荐和对比分析时所依赖的核心原始数据来源。

Compare this to traditional SEO, where you're competing for one of ten blue links. With AI systems, your content can surface across countless user queries.

这与传统 SEO 形成鲜明对比——在传统 SEO 中，你仅需争夺搜索结果页上那十个蓝色链接之一；而在 AI 系统中，你的内容却可能在成千上万种用户查询场景下自然浮现。

## **When to block AI crawlers, without hurting discoverability**

## **何时屏蔽 AI 爬虫，才能既保护业务又不损害可发现性**

There are legitimate cases for restricting AI crawlers. If your content is your product (news sites, educational platforms, premium research), then unlimited AI access might cannibalize your business model. But even beyond that, different pages serve different purposes.

在某些情况下，限制 AI 爬虫确有正当理由。例如，当您的内容本身就是核心产品（如新闻网站、教育平台、付费研究报告），那么对 AI 的无限制访问可能侵蚀您的商业模式。但除此之外，不同网页本身承载着不同功能与目标。

Crawler access should be selective, allowing only the pages that benefit your discoverability.

因此，对爬虫的访问权限应采取选择性策略——仅向那些有助于提升您内容可发现性的页面开放抓取。

For example, you may want to:  

例如，您可能希望：

- Block AI crawlers from sensitive routes like `/login`, `/checkout`, `/admin`, and user dashboards. These pages provide no value for training data and do little to improve discoverability  

- 禁止 AI 爬虫访问敏感路径，例如 `/login`、`/checkout`、`/admin` 以及用户仪表板。这些页面对训练数据毫无价值，也几乎无法提升内容的可发现性。

- Allow crawlers on discovery content such as documentation, blog posts, landing pages, product pages, and pricing pages. This is where being cited or recommended can drive traffic and increase brand visibility  

- 允许爬虫抓取用于内容发现的页面，例如文档、博客文章、落地页、产品页和定价页。这些页面正是被引用或推荐时能够带来流量、提升品牌曝光度的关键所在。

The best approach is to protect pages that neither explain your product nor answer likely user queries in AI tools, while keeping high-value discovery content open. Tools like [Vercel Firewall](https://vercel.com/docs/vercel-firewall), [Bot Protection](https://vercel.com/blog/one-click-bot-protection-now-in-public-beta), and [BotID](https://vercel.com/docs/botid) can help verify legitimate crawlers, block impersonators, and filter suspicious traffic without shutting down AI-driven discovery.  

最合理的策略是：保护那些既不解释产品功能、也无法回答 AI 工具中用户常见问题的页面；同时保持高价值的“发现型”内容开放可访问。[Vercel Firewall](https://vercel.com/docs/vercel-firewall)、[Bot Protection](https://vercel.com/blog/one-click-bot-protection-now-in-public-beta) 和 [BotID](https://vercel.com/docs/botid) 等工具，可帮助验证合法爬虫身份、拦截冒名爬虫，并过滤可疑流量——而无需关闭由 AI 驱动的内容发现机制。

## AI crawlers are the new discovery process  

## AI 爬虫已成为新的内容发现机制

The web is shifting to serve both human visitors and AI systems. As more users turn to AI tools for answers, those tools depend on crawlers to find and recommend content. Sites that adapt see more AI referrals, more citations, and greater authority in their domains.  

互联网正朝着同时服务人类访客与 AI 系统的方向演进。随着越来越多用户依赖 AI 工具获取答案，这些工具本身则依赖爬虫来发现并推荐内容。主动适配这一趋势的网站，将收获更多来自 AI 的引荐流量、更高频次的内容引用，以及在所属领域中更强的专业权威性。

Bots have always been part of the internet. What is changing is where people go for answers and how those answers are sourced. Making your content accessible can be the difference between being discovered or overlooked.  

机器人（bots）始终是互联网生态的一部分。真正发生变化的是：人们寻求答案的渠道，以及这些答案的来源方式。让您的内容保持可访问性，可能就是决定您是被 AI 发现，还是被彻底忽视的关键所在。
&#123;% endraw %}
