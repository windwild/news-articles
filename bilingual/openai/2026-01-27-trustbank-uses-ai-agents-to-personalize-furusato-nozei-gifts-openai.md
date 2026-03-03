---
title: "TRUSTBANK uses AI agents to personalize Furusato Nozei gifts | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/trustbank"
date: "2026-01-27"
scraped_at: "2026-03-02T10:08:25.175016623+00:00"
language: "en-US"
translated: true
description: "TRUSTBANK partnered with Recursive to build Choice AI using OpenAI models, delivering personalized, conversational recommendations that simplify Furusato Nozei gift discovery. A multi-agent system hel..."
tags: ["API"]
---

January 27, 2026

2026年1月27日

[API](https://openai.com/stories/api/) Enterprise

[API](https://openai.com/stories/api/) 企业版

# TRUSTBANK uses AI agents to personalize Furusato Nozei gifts

# TRUSTBANK 利用 AI 智能体为“故乡纳税”礼品提供个性化推荐

TRUSTBANK partnered with Recursive to build Choice AI using OpenAI models, enabling personalized conversational recommendations that simplify Furusato Nozei gift discovery.

TRUSTBANK 与 Recursive 合作，基于 OpenAI 模型构建了 Choice AI，通过个性化的对话式推荐，大幅简化了“故乡纳税”（Furusato Nozei）礼品的发现过程。

![TrustBank Logo on pink texture background](images/trustbank-uses-ai-agents-to-personalize-furusato-nozei-gifts-openai/img_001.png)

![粉色纹理背景上的 TRUSTBANK 标志](images/trustbank-uses-ai-agents-to-personalize-furusato-nozei-gifts-openai/img_001.png)

Japan’s hometown tax donation program, known as Furusato Nozei, allows taxpayers to support municipalities they care about by making a donation. As people move to large cities like Tokyo, local tax bases in rural towns shrink, so the program was designed to let taxpayers redirect a portion of their taxes to the communities they want to support. In practice, it works through a tax credit system: up to an income based cap, most of the donated amount is credited against the donor’s income and resident taxes for the following year. In return, municipalities send donors “thank-you gifts,” typically local specialty products, so donors can enjoy regional offerings while contributing to local communities.

日本的“故乡纳税”（Furusato Nozei）制度是一项地方税捐赠计划，允许纳税人通过捐款支持自己关心的市町村。随着人口向东京等大城市迁移，农村地区的本地税基不断萎缩，因此该制度旨在让纳税人将部分税款重新定向至希望支持的社区。在实际操作中，该制度采用税收抵扣机制：在以收入为基准设定的上限范围内，捐赠金额的大部分可抵扣捐赠人下一年度的所得税和居民税。作为答谢，各市町村会向捐赠人寄送“感谢礼品”，通常为当地特色产品，使捐赠人在支持地方社区的同时，也能体验各地风物。

However, many donors find the program difficult to navigate, given the sheer number of municipalities and the enormous catalog of thank-you gifts. To simplify the process and help donors compare options by region or theme, dedicated platforms have emerged. Furusato Choice, operated by TRUSTBANK, is one of Japan’s largest Furusato Nozei platforms, with roughly 760,000 thank-you gifts listed. Its intuitive interface has helped municipalities connect with donors, and it has supported many platform users, especially those participating for the first time.

然而，由于参与的市町村数量庞大、感谢礼品目录极为丰富，许多捐赠者感到该制度难以驾驭。为简化流程，并帮助捐赠者按地区或主题比较不同选项，一批专门平台应运而生。由 TRUSTBANK 运营的“故乡选择”（Furusato Choice）便是日本规模最大的“故乡纳税”平台之一，目前上线的感谢礼品约达 76 万种。其直观友好的用户界面，不仅助力市町村更高效地对接捐赠者，也切实支持了众多平台用户——尤其是首次参与的用户。

To further improve the experience, TRUSTBANK looked to AI, recognizing its potential to help users make decisions when the range of options feels overwhelming. Using the OpenAI API, the company developed the Choice AI feature, which helps users discover thank-you gifts that match their preferences.

为进一步提升用户体验，TRUSTBANK 将目光投向人工智能，认识到 AI 在选项繁多、令人无所适从时，可有效辅助用户决策。借助 OpenAI API，公司开发了 Choice AI 功能，帮助用户发现契合其偏好的感谢礼品。

#### Building Choice AI through collaboration with Recursive

#### 与 Recursive 协作共建 Choice AI

More than 15 years after Furusato Nozei was introduced, many taxpayers still struggle to make the most of it. Yuki Tateyama, Product General Manager at Choice Business HQ, explains, “Many people find the hometown tax donation system complicated or intimidating. To address this, we added AI powered features to our Furusato Choice app to make the process easier to navigate.” TRUSTBANK’s first step was to introduce AI powered search to help users explore thank-you gifts.

“故乡纳税”制度实施已逾 15 年，但许多纳税人仍难以充分享受其益。Choice Business HQ 产品总负责人武山 祐贵（Yuki Tateyama）表示：“许多人觉得‘故乡纳税’制度复杂难懂，甚至望而生畏。为此，我们在‘故乡选择’App 中加入了 AI 驱动的功能，以降低使用门槛、提升操作便捷性。”TRUSTBANK 的第一步，便是引入 AI 驱动的搜索功能，助力用户高效探索各类感谢礼品。

Tateyama adds, “In the Furusato Nozei system, people are not simply shopping for products they need immediately, as they might on typical ecommerce platforms. Instead, they focus on how to make the best use of their donation limit. With a catalog of thank you gifts on par with major online marketplaces, finding the right option has always been challenging.”

武田氏补充道：“在‘故乡纳税’（Furusato Nozei）制度中，人们并非像在普通电商平台那样，仅出于即时需求而购物；相反，他们更关注如何最大限度地利用自身的捐赠额度。由于答谢礼品目录的丰富程度堪比主流在线零售平台，用户始终难以从中精准选出最合适的选项。”

![Mobile app screens showing the ふるさとチョイス interface, including product recommendations, food images, prices, and an AI chat feature suggesting local gifts.](images/trustbank-uses-ai-agents-to-personalize-furusato-nozei-gifts-openai/img_002.png)

![显示「故乡选择」（Furusato Choice）移动应用界面的手机截图，包含商品推荐、食品图片、价格信息，以及一项通过AI聊天功能推荐本地特产的特性。](images/trustbank-uses-ai-agents-to-personalize-furusato-nozei-gifts-openai/img_002.png)

Providing personalized recommendations for thank-you gifts, based on each user’s information and intent, is an area where AI can be especially effective. However, TRUSTBANK did not have internal developers who specialized in AI, so external support was essential. To address this, TRUSTBANK partnered with Recursive, now an official OpenAI services partner.

基于每位用户的信息与意图，为其提供个性化的答谢礼品推荐，正是人工智能大显身手的关键领域。然而，TRUSTBANK内部并无专精于AI开发的工程师，因此外部技术支持不可或缺。为此，TRUSTBANK携手Recursive公司展开合作——后者如今已成为OpenAI官方认证的服务合作伙伴。

Issei Hirano, Head of Platform Promotion in the Product Division, explains the decision, “We selected Recursive as our partner because of their advanced AI expertise and their global experience.”

产品事业部平台推广负责人平野一成（Issei Hirano）解释了这一合作决策：“我们选择Recursive作为合作伙伴，正是看中其前沿的AI技术实力与丰富的全球项目经验。”

He describes how the teams worked together. “Recursive provided technical support from the planning stage, designed and implemented the conversational AI agent, and built the RAG system. We prepared the thank-you gift database, defined functional requirements, and integrated these features into our app.” This collaboration enabled a smooth build and rollout of Choice AI, allowing users to discover recommended items through interactive conversations within the Furusato Choice app.

他进一步介绍了双方团队的协作方式：“Recursive自项目规划阶段起便提供全程技术支持，负责设计并实现对话式AI智能体（conversational AI agent），同时构建了检索增强生成（RAG）系统；我方则负责准备答谢礼品数据库、明确功能需求，并将上述能力集成至我们的移动应用中。”此次协同合作保障了Choice AI系统的高效开发与顺利上线，使用户得以在「故乡选择」App内通过自然、交互式的对话，轻松发现个性化推荐商品。

#### Driving personalization using a multi agent architecture

#### 借助多智能体架构驱动个性化体验

The core of Choice AI is its multiagent architecture. A routing model analyzes user input to determine intent and delegates tasks to the appropriate agents. Beneath this routing layer, specialized agents such as the Search Agent, Recommendation Agent, and Greeting Agent operate. Each agent can invoke additional subagents and tools, enabling smooth orchestration and accurate, intent based results.

Choice AI的核心在于其多智能体（multi-agent）架构。其中，路由模型（routing model）首先解析用户输入以识别其意图，并据此将任务分派给相应的智能体。在此路由层之下，搜索智能体（Search Agent）、推荐智能体（Recommendation Agent）与问候智能体（Greeting Agent）等专业化智能体协同运行。每个智能体均可按需调用其他子智能体或工具，从而实现流程的顺畅编排，并输出精准契合用户意图的结果。

Personalization is also built into the prompting. Matthew Whalley, a software engineer at Recursive who led agent development, explains, “We combine agents dynamically based on user specific information. For instance, existing users follow one interaction path, while first time users follow another. We dynamically generate prompts to manage these interaction paths.”

个性化亦深度融入提示工程（prompting）之中。主导智能体开发工作的Recursive软件工程师马修·沃利（Matthew Whalley）解释道：“我们依据用户的特定信息，动态组合不同智能体。例如，老用户与新用户将分别进入不同的交互路径；我们亦会据此动态生成提示词（prompts），以精准管理各类交互路径。”

![Flowchart of a user query pipeline: Start → “User Query” → “User Intent Detection (GPT-4.1-mini),” which routes into three branches—“Searching for a product,” “Looking for a recommendation,” and “Other Queries.” Product search goes to “Search Agent (GPT-4.1-mini),” uses an “SQL Query Agent (GPT-4.1-mini)” and “Product DB,” then outputs through “Final Reranking & Recommendation (GPT-4.1).” Recommendation requests go to “Recommendation Agent (GPT-4.1-mini),” use “User History” and “User Purchase & Search History,” then produce “Personalized Recommendation (GPT-4.1-mini).” Other queries go to “Greeting Agent (GPT-4.1-nano).” All paths merge into “Final Output.”](images/trustbank-uses-ai-agents-to-personalize-furusato-nozei-gifts-openai/img_003.png)

![用户查询处理流程图：起点 → “用户查询” → “用户意图识别（GPT-4.1-mini）”，随后分流至三条路径——“搜索商品”、“寻求推荐”与“其他查询”。其中，“搜索商品”路径接入“搜索智能体（GPT-4.1-mini）”，调用“SQL查询智能体（GPT-4.1-mini）”与“商品数据库（Product DB）”，最终经由“最终重排序与推荐模块（GPT-4.1）”输出结果；“寻求推荐”路径则接入“推荐智能体（GPT-4.1-mini）”，结合“用户历史记录”及“用户购买与搜索历史”，生成“个性化推荐（GPT-4.1-mini）”；“其他查询”路径则交由“问候智能体（GPT-4.1-nano）”处理。所有路径最终汇聚至“最终输出”。](images/trustbank-uses-ai-agents-to-personalize-furusato-nozei-gifts-openai/img_003.png)

Choice AI currently runs on the GPT‑4.1 series. Whalley explains, “By default, we use GPT‑4.1 mini, but we are experimenting with dynamically switching to either the nano version or larger models based on latency and accuracy during testing.”

Choice AI当前运行于GPT‑4.1系列模型之上。沃利解释道：“默认情况下我们采用GPT‑4.1 mini模型；但在测试过程中，我们正积极探索根据响应延迟（latency）与准确率（accuracy）指标，动态切换至GPT‑4.1 nano或更大规模模型的可行性。”

Whalley also notes that analyzing real user behavior led to new insights: “Our analysis revealed that many users interact with the app similarly to how they would use a search engine. They provide extensive product information to the LLM and expect immediate recommendations. We also found that short, built-in prompts designed to start conversations were used frequently.” Based on these findings, the team incorporated a range of improvements into Choice AI. For example, the recommendation flow was adjusted to surface suggestions earlier, and the variety of recommended products was expanded to increase exposure to more diverse options.

惠利（Whalley）还指出，分析真实用户行为带来了新的洞见：“我们的分析显示，许多用户与应用的交互方式类似于使用搜索引擎——他们向大语言模型（LLM）提供大量商品信息，并期望即时获得推荐结果。我们还发现，那些简短、内嵌式、旨在启动对话的提示语被高频使用。” 基于这些发现，团队将一系列改进措施融入了 Choice AI。例如，优化了推荐流程，使建议更早呈现；同时扩大了推荐商品的种类，以提升用户接触更多元化选项的机会。

#### Expanding user choice with randomized search results

#### 通过随机化搜索结果拓展用户选择空间

Choice AI addresses two challenges in the Furusato Nozei experience:

Choice AI 着力应对“故乡纳税”（Furusato Nozei）体验中的两大挑战：

1. Reducing user confusion caused by the vast number of thank-you gifts, by offering personalized recommendations through interactive conversations.  
1. 通过互动式对话提供个性化推荐，缓解因答谢礼品数量庞大而引发的用户困惑；  

2. Avoiding concentration on a small set of municipalities or popular items, by helping users discover a wider range of regions and thank-you gifts through tailored suggestions.  
2. 避免推荐过度集中于少数几个地方政府或热门商品，借助定制化建议帮助用户发掘更广泛地域及更多样化的答谢礼品。

With the multiagent architecture inside Choice AI, users can find relevant thank-you gifts even without search skills or detailed product knowledge. Natural conversations, or even vague requests such as “a gift for my parents,” can be enough to surface suitable recommendations.

得益于 Choice AI 内置的多智能体（multiagent）架构，用户即使不具备搜索技巧或缺乏具体商品知识，也能轻松找到契合需求的答谢礼品。自然的日常对话，甚至模糊的请求（例如“想给我父母挑一份礼物”），都足以触发精准匹配的推荐结果。

Choice AI reduces bias toward specific municipalities or items by adding controlled randomness to search results. Whalley explains, “We introduce randomness and vary recommendations across prefectures based on donation data to support fairness and regional diversity, unless users clearly indicate their preferences.” This helps users discover smaller municipalities and niche products, creating a more diverse and engaging experience.

Choice AI 通过在搜索结果中引入受控的随机性，有效降低了对特定地方政府或商品的推荐偏差。惠利解释道：“除非用户明确表达偏好，否则我们会基于捐赠数据，在各都道府县之间动态调整推荐内容并注入适度随机性，以保障公平性与地域多样性。” 这一机制助力用户发现规模较小的地方政府及小众特色商品，从而营造出更具多样性与吸引力的整体体验。

As a result, users who used Choice AI saw higher conversion rates than those who relied on standard on-site search. Hirano explains the reason, saying, “Because the AI could draw out vague needs, like preferences and budget, that users themselves often struggled to put into words, and could even recommend specific thank-you gifts.”

结果表明，使用 Choice AI 的用户转化率显著高于仅依赖网站标准站内搜索的用户。平野（Hirano）解释其原因时指出：“因为 AI 能够主动挖掘用户自身往往难以言明的模糊需求——例如偏好倾向与预算范围，甚至能直接推荐具体的答谢礼品。”

#### Toward an AI Concierge for Furusato Nozei

#### 迈向“故乡纳税”的 AI 礼宾服务

Today, Furusato Choice primarily uses AI to improve the experience of searching for thank-you gifts, helping users quickly find options that fit their needs. Looking ahead, the company plans to expand AI into additional areas and further enhance the overall value of the service.

目前，故乡纳税平台 Furusato Choice 主要依托 AI 优化答谢礼品的搜索体验，助力用户快速锁定契合自身需求的商品。展望未来，公司计划将 AI 应用拓展至更多业务环节，持续提升整体服务价值。

Tateyama envisions Furusato Choice becoming a platform that connects users and municipalities through genuine goodwill, rather than focusing only on economic benefit. To support that vision, the company aims to refine the quality of AI-driven recommendations and personalize the end-to-end user experience, ultimately creating a concierge-style service that is closely attuned to each individual user.

竹山（Tateyama）构想中的 Furusato Choice，是一个以真诚善意为纽带连接用户与地方政府的平台，而非仅聚焦于经济收益。为支撑这一愿景，公司致力于持续提升 AI 推荐的质量，并实现端到端用户旅程的深度个性化，最终打造一种高度契合每位个体用户的礼宾式（concierge-style）服务。