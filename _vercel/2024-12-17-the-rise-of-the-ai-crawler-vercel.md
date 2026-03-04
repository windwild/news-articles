---
title: "The rise of the AI crawler - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/the-rise-of-the-ai-crawler"
date: "2024-12-17"
scraped_at: "2026-03-02T09:38:37.050616327+00:00"
language: "en-zh"
translated: true
description: "New research reveals how ChatGPT, Claude, and other AI crawlers process web content, including JavaScript rendering, assets, and other behavior and patterns—with recommendations for site owners, dev..."
---
&#123;% raw %}

Dec 17, 2024

2024 年 12 月 17 日

来自 MERJ 和 Vercel 的真实世界数据揭示了主流 AI 网络爬虫的独特行为模式。

AI 网络爬虫已成为互联网上一股不可忽视的力量。过去一个月内，OpenAI 的 GPTBot 在 Vercel 网络上共发出 5.69 亿次请求，Anthropic 的 Claude 紧随其后，发出 3.7 亿次请求。**作为参照，这两者合计的请求量约占同期 Googlebot 总请求数（45 亿次）的 20%。**

在与 [MERJ](https://merj.com/) 合作完成对 [Googlebot 如何处理 JavaScript 渲染](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process) 的分析后，我们将研究重点转向了这些 AI 助手。最新数据揭示了 OpenAI 的 ChatGPT、Anthropic 的 Claude 以及其他 AI 工具如何抓取和处理网页内容。

我们发现了这些爬虫在 JavaScript 处理方式、内容类型优先级排序以及网页导航策略等方面的清晰规律——这些规律直接影响 AI 工具对现代 Web 应用的理解与交互能力。

## Data collection process

## 数据收集过程

我们的主要数据来源于过去数月对 `nextjs.org` 及整个 Vercel 网络的持续监控。为验证研究结论在不同技术栈下的普适性，我们还额外分析了两个招聘网站：采用 Next.js 构建的 [Resume Library](https://www.resume-library.com/)，以及使用自研单体框架开发的 [CV Library](https://www.cv-library.co.uk/)。这一多样化的数据集有助于确保我们关于爬虫行为的观察结论，在各类 Web 架构中均具有一致性和代表性。

如需了解本数据采集方法的更多细节，请参阅 [我们的首篇相关文章](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process)。

注：由于 Microsoft Copilot 缺乏可用于追踪的唯一 User-Agent 标识，本次研究未将其纳入分析范围。

## Scale and distribution

## 规模与分布

The volume of AI crawler traffic across Vercel's network is substantial. In the past month:

- Googlebot: 4.5 billion fetches across Gemini and Search

- GPTBot (ChatGPT): 569 million fetches

- Claude: 370 million fetches

- AppleBot: 314 million fetches

- PerplexityBot: 24.4 million fetches

Vercel 网络中 AI 爬虫流量的规模十分可观。过去一个月内：

- Googlebot：在 Gemini 和搜索服务中共抓取 45 亿次  

- GPTBot（ChatGPT）：抓取 5.69 亿次  

- Claude：抓取 3.7 亿次  

- AppleBot：抓取 3.14 亿次  

- PerplexityBot：抓取 2440 万次  

While AI crawlers haven't reached Googlebot's scale, they represent a significant portion of web crawler traffic. For context, GPTBot, Claude, AppleBot, and PerplexityBot combined account for nearly 1.3 billion fetches—a little over 28% of Googlebot's volume.

尽管 AI 爬虫尚未达到 Googlebot 的规模，但它们已构成网络爬虫流量中不可忽视的重要部分。作为参照，GPTBot、Claude、AppleBot 和 PerplexityBot 四者合计抓取量接近 13 亿次，约为 Googlebot 抓取量的 28% 多一点。

![](images/the-rise-of-the-ai-crawler-vercel/img_001.jpg)![](images/the-rise-of-the-ai-crawler-vercel/img_002.jpg)

![](images/the-rise-of-the-ai-crawler-vercel/img_001.jpg)![](images/the-rise-of-the-ai-crawler-vercel/img_002.jpg)

### Geographic distribution

### 地理分布

All AI crawlers we measured operate from U.S. data centers:

我们所监测到的所有 AI 爬虫均运行于美国数据中心：

- ChatGPT: Des Moines (Iowa), Phoenix (Arizona)

- ChatGPT：得梅因（爱荷华州）、凤凰城（亚利桑那州）

- Claude: Columbus (Ohio)

- Claude：哥伦布（俄亥俄州）

In comparison, traditional search engines often distribute crawling across multiple regions. For example, Googlebot operates from seven different U.S. locations, including The Dalles (Oregon), Council Bluffs (Iowa), and Moncks Corner (South Carolina).

相比之下，传统搜索引擎通常将网络爬取任务分散至多个地理区域。例如，Googlebot 在美国七个不同地点运行，包括达尔斯（俄勒冈州）、康瑟尔布拉夫斯（爱荷华州）和蒙克斯角（南卡罗来纳州）。

## JavaScript rendering capabilities

## JavaScript 渲染能力

Our analysis shows a clear divide in JavaScript rendering capabilities among AI crawlers. To validate our findings, we analyzed both Next.js applications and traditional web applications using different tech stacks.

我们的分析表明，各类 AI 网络爬虫在 JavaScript 渲染能力方面存在明显差异。为验证这一发现，我们分别对基于 Next.js 的应用以及采用不同技术栈的传统 Web 应用进行了分析。

The results consistently show that none of the major AI crawlers currently render JavaScript. This includes:

结果一致表明，目前主流 AI 网络爬虫均不具备 JavaScript 渲染能力。这包括：

- OpenAI (OAI-SearchBot, ChatGPT-User, GPTBot)

- OpenAI（OAI-SearchBot、ChatGPT-User、GPTBot）

- Anthropic (ClaudeBot)

- Anthropic（ClaudeBot）

- Meta (Meta-ExternalAgent)

- Meta（Meta-ExternalAgent）

- ByteDance (Bytespider)

- 字节跳动（Bytespider）

- Perplexity (PerplexityBot)

- Perplexity（PerplexityBot）

The results also show:

结果还显示：

- Google's Gemini leverages Googlebot's infrastructure, enabling full JavaScript rendering.

- 谷歌的 Gemini 借助 Googlebot 的基础设施，支持完整的 JavaScript 渲染。

- AppleBot renders JavaScript through a browser-based crawler, similar to Googlebot. It processes JavaScript, CSS, Ajax requests, and other resources needed for full-page rendering.

- AppleBot 通过基于浏览器的爬虫渲染 JavaScript，其方式与 Googlebot 类似；它会处理 JavaScript、CSS、Ajax 请求以及实现整页渲染所需的其他资源。

- Common Crawl (CCBot), which is often used as a training dataset for Large Language Models (LLMs) does not render pages.

- Common Crawl（CCBot）通常被用作大语言模型（LLM）的训练数据集，但它**不执行页面渲染**。

The data indicates that while ChatGPT and Claude crawlers do _fetch_ JavaScript files (ChatGPT: 11.50%, Claude: 23.84% of requests), they don't _execute_ them. They can't read client-side rendered content.

数据显示：尽管 ChatGPT 和 Claude 的爬虫确实会**获取** JavaScript 文件（ChatGPT 占全部请求的 11.50%，Claude 占 23.84%），但它们**并不执行**这些脚本，因此无法读取客户端渲染（CSR）的内容。

Note, however, that content included in the initial HTML response, like JSON data or delayed React Server Components, may still be indexed since AI models can interpret non-HTML content.

但需注意：包含在初始 HTML 响应中的内容（例如 JSON 数据或延迟加载的 React 服务端组件）仍可能被索引，因为 AI 模型能够解析非 HTML 格式的内容。

In contrast, Gemini's use of Google's infrastructure gives it the same rendering capabilities we documented in our [Googlebot analysis](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process), allowing it to process modern web applications fully.

相比之下，Gemini 借助谷歌基础设施所具备的渲染能力，与我们在[《Googlebot 如何处理索引过程中的 JavaScript》](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process)一文中所记录的能力完全一致，因而可完整处理现代 Web 应用。

## Content type priorities

## 内容类型优先级

AI crawlers show distinct preferences in the types of content they fetch on `nextjs.org`. The most notable patterns:

AI 爬虫在 `nextjs.org` 上抓取的内容类型呈现出明显差异。最显著的规律包括：

- ChatGPT prioritizes HTML content (57.70% of fetches)

- ChatGPT 优先抓取 HTML 内容（占全部抓取请求的 57.70%）

- Claude focuses heavily on images (35.17% of total fetches)

- Claude 高度聚焦于图像内容（占全部抓取请求的 35.17%）

- Both crawlers spend significant time on JavaScript files (ChatGPT: 11.50%, Claude: 23.84%) despite not executing them

- 两者均在 JavaScript 文件上投入大量抓取资源（ChatGPT：11.50%，Claude：23.84%），尽管它们并不执行这些脚本

For comparison, Googlebot's fetches (across Gemini and Search) are more evenly distributed:

作为对比，Googlebot 的抓取行为（涵盖 Gemini 和搜索场景）分布更为均衡：

- 31.00% HTML content

- 31.00% HTML 内容

- 29.34% JSON data

- 29.34% JSON 数据

- 20.77% plain text

- 20.77% 纯文本

- 15.25% JavaScript

- 15.25% JavaScript

These patterns suggest AI crawlers collect diverse content types—HTML, images, and even JavaScript files as text—likely to train their models on various forms of web content.

上述模式表明，AI 网络爬虫会采集多种类型的内容——包括 HTML、图像，甚至以纯文本形式抓取 JavaScript 文件——这很可能是为了在其模型训练中覆盖多样化的网页内容形态。

While traditional search engines like Google have optimized their crawling patterns specifically for search indexing, newer AI companies may still be refining their content prioritization strategies.

尽管 Google 等传统搜索引擎已针对搜索索引任务专门优化了其爬取策略，新兴的 AI 公司可能仍在持续调整和完善自身的内容优先级判定机制。

## efficiency) Crawling (in)efficiency

## 效率）爬虫（低）效率

Our data shows significant inefficiencies in AI crawler behavior:

我们的数据显示，AI 爬虫行为存在显著的低效问题：

- ChatGPT spends 34.82% of its fetches on 404 pages

- ChatGPT 将其 34.82% 的抓取请求发送至返回 404 状态的页面。

- Claude shows similar patterns with 34.16% of fetches hitting 404s

- Claude 表现出类似模式，其 34.16% 的抓取请求命中 404 页面。

- ChatGPT spends an additional 14.36% of fetches following redirects

- ChatGPT 还额外将 14.36% 的抓取请求用于跟随重定向（redirects）。

Analysis of 404 errors reveals that, excluding `robots.txt`, these crawlers frequently attempt to fetch outdated assets from the `/static/` folder. This suggests a need for improved URL selection and handling strategies to avoid unnecessary requests.

对 404 错误的分析表明：除 `robots.txt` 外，这些爬虫频繁尝试从 `/static/` 目录抓取已过时的资源。这提示我们需要优化 URL 选择与处理策略，以避免发出不必要的请求。

These high rates of 404s and redirects contrast sharply with Googlebot, which spends only 8.22% of fetches on 404s and 1.49% on redirects, suggesting Google has spent more time optimizing its crawler to target real resources.

此类高比例的 404 和重定向请求，与 Googlebot 形成鲜明对比——后者仅将 8.22% 的抓取请求用于 404 页面，1.49% 用于重定向。这表明 Google 已投入更多精力优化其爬虫，使其更精准地定位真实可用资源。

## Traffic correlation analysis

## 流量相关性分析

Our analysis of traffic patterns reveals interesting correlations between crawler behavior and site traffic. Based on data from `nextjs.org`:

我们对流量模式的分析揭示了爬虫行为与网站流量之间存在若干有趣的相关性。基于 `nextjs.org` 的数据：

- Pages with higher organic traffic receive more frequent crawler visits

- 有机搜索流量更高的页面，会收到爬虫更频繁的访问。

- AI crawlers show less predictable patterns in their URL selection  
- AI 爬虫在 URL 选择上表现出较低的可预测性  

- High 404 rates suggest AI crawlers may need to improve their URL selection and validation processes, though the exact cause remains unclear  
- 高比例的 404 错误率表明，AI 爬虫可能需要优化其 URL 选取与验证机制，但具体成因尚不明确  

While traditional search engines have developed sophisticated prioritization algorithms, AI crawlers are seemingly still evolving their approach to web content discovery.  
尽管传统搜索引擎已开发出高度成熟的优先级排序算法，AI 爬虫在网页内容发现策略方面似乎仍处于持续演进阶段。

> “Our research with Vercel highlights that AI crawlers, while rapidly scaling, continue to face significant challenges in handling JavaScript and efficiently crawling content. As the adoption of AI-driven web experiences continues to gather pace, brands must ensure that critical information is server-side rendered and that their sites remain well-optimized to sustain visibility in an increasingly diverse search landscape.Our research with Vercel highlights that AI crawlers, while rapidly scaling, continue to face significant challenges in handling JavaScript and efficiently crawling content. As the adoption of AI-driven web experiences continues to gather pace, brands must ensure that critical information is server-side rendered and that their sites remain well-optimized to sustain visibility in an increasingly diverse search landscape.”  
> “我们与 Vercel 合作开展的研究表明：AI 爬虫虽正快速扩展规模，但在处理 JavaScript 及高效抓取内容方面仍面临显著挑战。随着 AI 驱动型网页体验的普及步伐不断加快，品牌方必须确保关键信息采用服务端渲染（SSR），并持续优化网站性能，以在日益多元化的搜索生态中维持可见性。”  

> ![](images/the-rise-of-the-ai-crawler-vercel/img_003.jpg)  
> ![](images/the-rise-of-the-ai-crawler-vercel/img_003.jpg)  

> **Ryan Siddle,** Managing Director of MERJ  
> **瑞安·西德尔（Ryan Siddle）**，MERJ 公司董事总经理  

## Recommendations  
## 建议  

### For site owners who want to be crawled  
### 希望被爬取的网站所有者  

- **Prioritize server-side rendering for critical content.** ChatGPT and Claude don't execute JavaScript, so any important content should be server-rendered. This includes main content (articles, product information, documentation), meta information (titles, descriptions, categories), and navigation structures. [SSR, ISR, and SSG](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app) keep your content accessible to all crawlers.  
- **优先对关键内容采用服务端渲染（SSR）。** ChatGPT 和 Claude 不执行 JavaScript，因此所有重要信息均需通过服务端渲染输出。这包括主体内容（文章、产品信息、文档）、元信息（标题、描述、分类）以及导航结构。[SSR、ISR 与 SSG](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app) 可确保您的内容对所有爬虫均保持可访问性。  

- **Client-side rendering still works for enhancement features.** Feel free to use client-side rendering for non-essential dynamic elements like view counters, interactive UI enhancements, live chat widgets, and social media feeds.  
- **客户端渲染（CSR）仍适用于增强型功能。** 您可放心将客户端渲染用于非核心的动态元素，例如页面浏览量计数器、交互式 UI 增强组件、在线客服小部件及社交媒体信息流等。  

- **Efficient URL management matters more than ever.** The high 404 rates from AI crawlers highlight the importance of maintaining proper redirects, keeping sitemaps up to date, and using consistent URL patterns across your site.  
- **高效的 URL 管理比以往任何时候都更加重要。** AI 爬虫产生的高 404 错误率凸显了以下几点的关键性：设置恰当的重定向规则、及时更新站点地图（sitemap），以及在整个网站中统一使用规范的 URL 模式。  

### For site owners who don't want to be crawled  
### 不希望被爬取的网站所有者

- **Use** **`robots.txt`** **to control crawler access.**  
- **使用 `robots.txt` 控制爬虫访问权限。**  
The `robots.txt` file is effective for all measured crawlers. Set specific rules for AI crawlers by specifying their user agent or product token to restrict access to sensitive or non-essential content. To find the user agents to disallow, you’ll need to look in each company’s own documentation (for example, [Applebot](https://support.apple.com/en-us/119829) and [OpenAI’s crawlers](https://platform.openai.com/docs/bots)).  
`robots.txt` 文件对所有已观测到的爬虫均有效。您可通过指定 AI 爬虫的 User Agent 或产品标识符（product token），为其设置专属规则，从而限制其对敏感内容或非必要内容的访问。如需获取需屏蔽的 User Agent 列表，请查阅各公司官方文档（例如，[Applebot](https://support.apple.com/zh-cn/119829) 和 [OpenAI 的爬虫](https://platform.openai.com/docs/bots)）。

- **Block AI crawlers with Vercel's WAF.**  
- **使用 Vercel 的 Web 应用防火墙（WAF）屏蔽 AI 爬虫。**  
Our [Block AI Bots Firewall Rule](https://vercel.com/templates/vercel-firewall/block-ai-bots-firewall-rule) lets you block AI crawlers with one click. This rule automatically configures your firewall to deny their access.  
我们的 [屏蔽 AI 机器人防火墙规则（Block AI Bots Firewall Rule）](https://vercel.com/templates/vercel-firewall/block-ai-bots-firewall-rule) 支持一键屏蔽 AI 爬虫。该规则将自动配置您的防火墙，拒绝相关爬虫的访问请求。

### For AI users  
### 面向 AI 用户的注意事项  

- **JavaScript-rendered content may be missing.**  
- **JavaScript 渲染的内容可能缺失。**  
Since ChatGPT and Claude don't execute JavaScript, their responses about dynamic web applications may be incomplete or outdated.  
由于 ChatGPT 和 Claude 不执行 JavaScript，它们对动态网页应用的相关回答可能不完整或已过时。

- **Consider the source.**  
- **请审慎评估信息来源。**  
High 404 rates (>34%) mean that when AI tools cite specific web pages, there's a significant chance those URLs are incorrect or inaccessible. For critical information, always verify sources directly rather than relying on AI-provided links.  
高达 34% 以上的 404 错误率意味着：当 AI 工具引用具体网页时，这些 URL 很可能存在错误或无法访问。对于关键信息，请务必直接核实原始来源，切勿仅依赖 AI 提供的链接。

- **Expect inconsistent freshness.**  
- **内容时效性参差不齐。**  
While Gemini leverages Google's infrastructure for crawling, other AI assistants show less predictable patterns. Some may reference older cached data.  
尽管 Gemini 借助 Google 的基础设施进行网络抓取，其他 AI 助手的更新模式则更难预测——部分工具可能仍引用较早的缓存数据。

Interestingly, even when asking Claude or ChatGPT for fresh Next.js docs data, we often don't see immediate fetches in our server logs for `nextjs.org`. This suggests that AI models may rely on cached data or training data, even when they claim to have fetched the latest information.  
有趣的是，即便我们向 Claude 或 ChatGPT 明确请求最新的 Next.js 文档内容，服务器日志中也常常未见针对 `nextjs.org` 的即时抓取记录。这表明：即使 AI 模型声称已获取最新信息，其实际响应仍可能基于缓存数据或训练数据。

## Final thoughts  
## 总结与思考  

Our analysis reveals that AI crawlers have quickly become a significant presence on the web, with nearly 1 billion monthly requests across Vercel's network.  
我们的分析显示，AI 爬虫已迅速成为互联网上一股不可忽视的力量——仅在 Vercel 网络中，其月度请求量就已接近 10 亿次。

However, their behavior differs markedly from traditional search engines, when it comes to rendering capabilities, content priorities, and efficiency. Following established web development best practices—particularly around content accessibility—remains crucial.  
然而，在渲染能力、内容抓取优先级及抓取效率等方面，AI 爬虫的行为与传统搜索引擎存在显著差异。因此，坚持遵循既有的 Web 开发最佳实践——尤其是确保内容可访问性（content accessibility）——依然至关重要。

Blog post

博客文章

Jan 19, 2024

2024年1月19日

### How Core Web Vitals affect SEO

### 核心网页指标（Core Web Vitals）如何影响搜索引擎优化（SEO）

![](images/the-rise-of-the-ai-crawler-vercel/img_004.jpg)![](images/the-rise-of-the-ai-crawler-vercel/img_005.jpg)

Malte and Alice

马尔特与爱丽丝

Blog post

博客文章

Jul 31, 2024

2024年7月31日

### How Google handles JavaScript throughout the indexing process

### Google 在整个索引过程中如何处理 JavaScript

![](images/the-rise-of-the-ai-crawler-vercel/img_006.jpg)![](images/the-rise-of-the-ai-crawler-vercel/img_005.jpg)![](images/the-rise-of-the-ai-crawler-vercel/img_008.jpg)+2

Giacomo, Alice, and 2 others

贾科莫、爱丽丝及另外两位作者
&#123;% endraw %}
