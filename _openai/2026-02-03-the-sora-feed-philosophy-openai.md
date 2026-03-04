---
title: "The Sora feed philosophy | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/sora-feed-philosophy"
date: "2026-02-03"
scraped_at: "2026-03-02T10:08:22.733039888+00:00"
language: "en-US"
translated: true
description: "Discover the Sora feed philosophy—built to spark creativity, foster connections, and keep experiences safe with personalized recommendations, parental controls, and strong guardrails."
tags: ["Product"]
---
&#123;% raw %}

February 3, 2026

2026年2月3日

[Product](https://openai.com/news/product-releases/) [Safety](https://openai.com/news/safety-alignment/)

[产品](https://openai.com/news/product-releases/) [安全](https://openai.com/news/safety-alignment/)

# The Sora feed philosophy

# Sora 信息流的设计理念

## Principles

## 核心原则

Our aim with the Sora feed is simple: help people learn what’s possible, and inspire them to create. Here are some of core starting principles to bring this vision to life:

我们设计 Sora 信息流的目标非常明确：帮助人们了解 AI 能够实现什么，并激发他们的创作热情。为将这一愿景付诸实践，我们确立了以下几项核心初始原则：

- **Optimize for creativity.** We’re designing ranking to favor creativity and active participation, not passive scrolling. We think this is what makes Sora joyful to use.  
- **以创造力为优化核心。** 我们在排序机制的设计中优先考虑创造力与主动参与，而非被动浏览。我们认为，这正是 Sora 使用体验令人愉悦的关键所在。

- **Put users in control.** The feed ships with steerable ranking, so you can tell the algorithm exactly what you’re in the mood for. Parents can also turn off feed personalization and control continuous scroll for their teens through ChatGPT parental controls.  
- **赋予用户掌控权。** 信息流内置“可引导式排序”（steerable ranking）功能，让你能明确告诉算法你此刻想看什么内容。家长还可通过 ChatGPT 家长控制功能，关闭信息流个性化推荐，并为青少年限制连续滚动浏览。

- **Prioritize connection.** We want Sora to help people strengthen and form new connections, especially through fun, magical Cameo flows. Connected content will be favored over global, unconnected content.  
- **重视人际联结。** 我们希望 Sora 助力用户巩固既有关系、建立全新联结——尤其依托趣味十足、充满魔力的 Cameo 互动流程。相比泛化的、彼此孤立的内容，具有社交关联性的内容将在排序中获得更高优先级。

- **Balance safety and freedom.** The feed is designed to be widely accessible and safe. Robust guardrails aim to prevent unsafe or harmful generations from the start and we block content that may violate our Usage Policies. At the same time, we also want to leave room for expression, creativity, and community. We know recommendation systems are living, breathing things. As we learn from real use, we’ll adjust the details—in service of these principles.  
- **兼顾安全与自由。** 信息流旨在广泛可及且安全可靠。我们设置了强有力的防护机制，从源头防范不安全或有害内容的生成，并屏蔽任何可能违反《使用政策》的内容。与此同时，我们也致力于为表达、创意与社区互动保留充分空间。我们深知推荐系统是动态演进、持续成长的有机体；随着真实使用数据的积累，我们将不断微调具体实现细节——始终服务于上述核心原则。

## How it works

## 运作机制

Our recommendation algorithms are designed to give you personalized recommendations that inspire you and others to be creative. Each individual has unique interests and tastes so we’ve built a personalized system to best serve this mission.

我们的推荐算法旨在为你提供个性化的灵感启发，不仅激发你本人的创造力，也激励他人展开创作。由于每位用户都拥有独特的兴趣与审美偏好，我们构建了一套高度个性化的系统，以最有效地践行这一使命。

To personalize your Sora Feed, we may consider signals like:  

为个性化你的 Sora 信息流，我们可能会参考如下信号：

- **Your activity on Sora:** This may include activity including your posts, followed accounts, liked and commented posts, and remixed content. It may also include the general location (such as the city) from which your device accesses Sora, based on information like your IP address.  
- **您在 Sora 上的活动：** 这可能包括您的发帖、关注的账号、点赞和评论过的帖子，以及 remix（再创作）的内容。此外，还可能包括根据您的 IP 地址等信息推断出的设备访问 Sora 的大致地理位置（例如所在城市）。

- **Your ChatGPT data:** We may consider your ChatGPT history, but you can always turn this off in Sora’s Data Controls, within Settings.  
- **您的 ChatGPT 数据：** 我们可能会参考您的 ChatGPT 历史记录，但您始终可以在 Sora 的“设置”→“数据控制”中关闭此功能。

- **Content engagement signals:** This may include signals such as views, likes, comments, instructions to “see less content like this,” and remixes.  
- **内容互动信号：** 这可能包括浏览量、点赞数、评论数、“减少此类内容推荐”的用户指令，以及 remix（再创作）行为等信号。

- **Author signals:** This may include follower count, other posts, and past post engagement.  
- **作者信号：** 这可能包括关注者数量、其他发帖内容，以及过往帖子的互动情况。

- **Safety signals**: Whether or not the post is considered violative or appropriate.  
- **安全信号：** 判断该帖子是否被认定为违规或适宜发布。

We may use these signals to predict if this content is something you may like to see and riff off of.  
我们可能利用上述信号，预测您是否会对该内容感兴趣，并激发您的创意再创作（riff off of）。

Parents are also able to turn off feed personalization and manage continuous scroll for their teens using parental controls in ChatGPT.  
家长还可通过 ChatGPT 中的家长控制功能，为青少年子女关闭信息流个性化推荐，并管理其连续滚动浏览行为。

## How we balance safety & expression  
## 我们如何兼顾安全与表达

Keeping the Sora Feed safe and fun for everyone means walking a careful line: protect users from harmful content, while leaving enough freedom for creativity to thrive.  
确保 Sora 信息流对所有用户都安全且有趣，需要谨慎把握平衡：既要保护用户免受有害内容侵害，又要为创造力留出充分自由空间。

We may remove content that violates our [Global Usage Policies](https://openai.com/policies/usage-policies/). Additionally, content deemed inappropriate for users may be removed from Feed and other sharing platforms (such as user galleries and side characters) in accordance with our [Sora Distribution Guidelines](https://openai.com/policies/creating-sora-videos-in-line-with-our-policies/). This includes:  
我们可能移除违反[《全球使用政策》](https://openai.com/policies/usage-policies/)的内容。此外，根据我们的[《Sora 分发指南》](https://openai.com/policies/creating-sora-videos-in-line-with-our-policies/)，被判定为不适宜面向用户传播的内容，也将从信息流及其他分享平台（例如用户画廊、侧边角色等）中移除。这包括：

- Graphic sexual content;  
- 露骨的性相关内容；  
- Graphic violence or content promoting violence;  
- 露骨的暴力内容或鼓吹暴力的内容；  
- Extremist propaganda;  
- 极端主义宣传内容；  
- Hateful content;  
- 仇恨性内容；  
- Content that promotes or depicts self harm or disordered eating;  
- 宣扬或呈现自残行为或进食障碍的内容；  
- Unhealthy dieting or exercise behaviors;  
- 不健康的节食或运动行为；  
- Appearance-based critiques or comparisons;  
- 基于外貌的批评或比较；  
- Bullying content;  
- 欺凌相关内容；  
- Dangerous challenges likely to be imitated by minors;  
- 可能被未成年人模仿的危险挑战；  
- Content glorifying depression;  
- 美化抑郁症的内容；  
- Promotion of age-restricted goods or activities including illegal drugs or harmful substances; and  
- 推广受年龄限制的商品或活动（包括非法毒品或有害物质）；以及  
- Low quality content where the primary purpose is engagement bait;  
- 主要目的在于诱导互动（engagement bait）的低质量内容；  
- Content that recreates the likeness of living individuals without their consent, or deceased public figures in contexts where their likeness is not permitted for use;  
- 未经本人同意即复现在世人物肖像的内容，或在禁止使用肖像的语境下复现已故公众人物肖像的内容；  
- Content that may infringe on the intellectual property rights of others.  
- 可能侵犯他人知识产权的内容。

**Our first layer of defense is at the point of creation.** Because every post is generated within Sora, we can build in strong guardrails that prevent unsafe or harmful content before it’s made. If a generation bypasses these guardrails, we may remove the sharing of that content.  
**我们的第一道防线设在内容生成环节。** 由于所有帖子均在 Sora 内生成，我们可内置强有力的防护机制，在有害或不安全内容产生前即予以阻止。若某次生成绕过了这些防护机制，我们可能禁止该内容的分享。

Beyond generation, the feed is designed to be appropriate for all Sora users. Content that may be harmful, unsafe, or age-inappropriate is filtered out for teen accounts. **We use automated tools to scan all feed content for compliance with our** [**Global Usage Policies**](https://openai.com/policies/usage-policies/) **and feed eligibility.** These systems are continuously updated as we learn more about new risks. If you see something you think does not follow our Usage policies, [you can report it](https://openai.com/form/report-content/).  
除生成环节外，信息流本身也专为全体 Sora 用户设计。对青少年账号而言，可能存在危害性、不安全性或年龄不适配的内容将被自动过滤。**我们采用自动化工具，全面扫描信息流中的所有内容，以核查其是否符合[《全球使用政策》](https://openai.com/policies/usage-policies/)及信息流准入标准。** 随着我们对新型风险认知的不断深入，这些系统将持续更新迭代。若您发现任何疑似违反我们使用政策的内容，[欢迎举报](https://openai.com/form/report-content/)。

**We complement this with human review.** Our team monitors user reports and proactively checks feed activity to catch what automation may miss. If you see something you think does not follow our Usage Policies, you can [report it](https://openai.com/form/report-content/).  
**我们辅以人工审核机制。** 我们的团队持续监控用户举报，并主动巡查信息流动态，以捕捉自动化系统可能遗漏的问题。若您发现任何疑似违反我们使用政策的内容，欢迎[提交举报](https://openai.com/form/report-content/)。

**But safety isn’t only about strict filters.**

**但安全并不仅仅依赖于严格的过滤机制。**

Too many restrictions can stifle creativity, while too much freedom can undermine trust. We aim for a balance: proactive guardrails where the risks are highest, combined with a reactive “report + takedown” system that gives users room to explore and create while ensuring we can act quickly when problems arise. This approach has served us well in ChatGPT’s 4o image generation model, and we’re building on that philosophy here.

限制过多会扼杀创造力，而自由度过高又可能损害信任。我们的目标是实现一种平衡：在风险最高的环节主动设置防护栏，同时辅以响应式的“举报 + 下架”机制，既为用户留出探索与创作的空间，又能确保问题出现时迅速响应。这一思路已在 ChatGPT 的 4o 图像生成模型中得到良好验证，我们正将这一理念延续并深化于此。

We also know we won’t get this balance perfect from day one. Recommendation systems and safety models are living, evolving systems, and your feedback will be essential in helping us refine them. We look forward to learning together and improving over time.

我们也深知，这种平衡不可能从第一天起就臻于完美。推荐系统与安全模型是持续演进、动态发展的系统，而您的反馈对我们不断优化它们至关重要。我们期待与您共同学习、持续进步。

- [Sora](https://openai.com/news/?tags=sora)  
- [Sora](https://openai.com/news/?tags=sora)

- [Policies and Procedures](https://openai.com/news/?tags=policies-procedures)  
- [政策与规程](https://openai.com/news/?tags=policies-procedures)

- [2026](https://openai.com/news/?tags=2026)  
- [2026](https://openai.com/news/?tags=2026)
&#123;% endraw %}
