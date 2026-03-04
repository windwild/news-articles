---
title: "How Bertelsmann Built a Multi-Agent System to Empower Creatives"
source: "LangChain Blog"
url: "https://blog.langchain.com/customer-bertelsmann/"
date: "2025-07-29"
scraped_at: "2026-03-03T07:28:22.111175870+00:00"
language: "en-zh"
translated: true
description: "See how one of the world’s biggest media companies leveraged LangGraph from its earliest days to build and deploy a multi-agent system to production that empowers creativity."
tags: ["Case Studies"]
---
&#123;% raw %}

[Bertelsmann](https://www.bertelsmann.com/?ref=blog.langchain.com) is one of the world's largest media companies that has produced some of the most influential content of our time. From publishing Barack Obama's and Prince Harry's bestselling biographies and Pulitzer-winning novels, to producing Emmy- and Academy Award-winning productions like *Poor Things* and *The Young Pope*, the company's creative teams span dozens of brands and platforms to reach millions globally.

贝塔斯曼（[Bertelsmann](https://www.bertelsmann.com/?ref=blog.langchain.com)）是全球最大的媒体公司之一，创作了当今最具影响力的内容之一。从出版巴拉克·奥巴马和哈里王子的畅销传记、普利策奖获奖小说，到制作艾美奖与奥斯卡奖获奖影视作品——如《可怜的东西》（*Poor Things*）和《年轻的教宗》（*The Young Pope*），该公司创意团队横跨数十个品牌与平台，触达全球数千万受众。

But with that scale also comes a challenge: When a creative or researcher at Bertelsmann asks a seemingly simple question like "What kind of content do we have about Barack Obama?" the answer could be scattered across dozens of different systems, databases, and platforms.

但如此庞大的规模也带来一项挑战：当贝塔斯曼的一位创意人员或研究人员提出一个看似简单的问题，例如“我们拥有哪些关于巴拉克·奥巴马的内容？”，答案可能分散在数十个不同的系统、数据库和平台之中。

The internal Bertelsmann Content Search changes that. Built by Bertelsmann's AI Hub team using LangGraph, this multi-agent system has gone from early prototype to full production deployment. It now powers content search and discovery across the company, empowering creativity across the entire organization.

贝塔斯曼内部的“内容搜索”（Content Search）系统正改变这一现状。该多智能体系统由贝塔斯曼AI中心（AI Hub）团队基于LangGraph构建，已从早期原型发展为全面投入生产的系统。如今，它驱动着全公司范围内的内容检索与发现，赋能整个组织的创意工作。

## **The Challenge: Unified Search Across a Media Empire**

## **挑战：在媒体帝国中实现统一搜索**

![](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_001.jpg)

Bertelsmann's creative teams face a unique internal challenge: navigating a vast, decentralized content ecosystem. Across its divisions, the company produces and manages:

贝塔斯曼的创意团队面临一项独特的内部挑战：在庞大且高度分散的内容生态中穿行。在其各业务板块中，公司生产并管理着：

- Books and audiobooks  
- 图书与有声读物  
- TV shows, films, and documentaries  
- 电视剧、电影与纪录片  
- News archives and journalistic content  
- 新闻档案与新闻类内容  
- Third-party commentary and web trends  
- 第三方评论与网络热点趋势  

Each division at Bertelsmann operates within its own systems, databases, and content workflows. So, if a producer wants to understand what content exists around a trending topic, or if a marketing team needs to identify cross-platform opportunities, they need to know exactly where to look and need to have access to each relevant system.

贝塔斯曼各业务板块均运行于各自独立的系统、数据库及内容工作流之中。因此，若一名制片人希望了解围绕某一热门话题已存在哪些内容，或市场团队需识别跨平台联动机会，他们就必须准确知晓信息所在位置，并拥有访问每个相关系统的权限。

This fragmentation leads to missed opportunities, research effort duplication, and creative teams spending more time searching for information than creating.

这种碎片化局面导致错失机遇、重复开展研究工作，更使创意团队将大量时间耗费在信息搜寻上，而非内容创作本身。

## **The Solution: Multi-Agent Content Discovery**

## **解决方案：多智能体内容发现系统**

![](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_002.jpg)

![](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_002.jpg)

The Bertelsmann Content Search takes a fundamentally different approach. Instead of centralizing all data into a single system— a daunting task given Bertelsmann’s expansive portfolio— the team built a multi-agent system that orchestrates searches across existing platforms and data sources.

贝塔斯曼内容搜索采用了截然不同的方法。鉴于贝塔斯曼庞大而多元的业务组合，将所有数据集中到单一系统中是一项艰巨任务；因此，团队构建了一套多智能体系统，协调调用现有平台与数据源开展联合检索。

Here's how it works:

其工作原理如下：

**Natural Language Interface**: Users can ask questions in natural language, such as: "What documentaries do we have about renewable energy?" or "Show me content related to emerging artists in electronic music."

**自然语言交互界面**：用户可用自然语言提问，例如：“我们有哪些关于可再生能源的纪录片？”或“请展示与电子音乐新兴艺术家相关的内容。”

**Intelligent Routing**: Behind the scenes, a router analyzes each query and determines which specialized agents should handle the search. One agent might query the documentary archives, another searches the catalog for related books, while a third checks internal news archives for journalistic coverage.

**智能路由调度**：在后台，一个路由模块分析每个查询，并决定由哪些专业智能体执行相应检索任务。例如，一个智能体负责查询纪录片档案库，另一个在图书目录中检索相关书籍，第三个则在内部新闻档案中查找相关的新闻报道。

**Specialized Domain Agents**: Each agent is purpose-built for its specific domain – understanding the metadata, search patterns, and content types unique to that system.

**专业化领域智能体**：每个智能体均针对其特定领域定制开发——能够理解该系统独有的元数据结构、检索模式及内容类型。

**Unified Response Generation**: Individual agent responses are synthesized into a single, coherent answer.

**统一响应生成**：各智能体返回的独立结果被整合为一个连贯、完整的最终答案。

**Flexible Agent Deployment**: With LangGraph’s flexible architecture, agents can be deployed directly within the systems that own the data. For example, an agent searching the proprietary news archive can be deployed as a standalone API that internal teams can integrate directly into their existing systems. This means divisions get enhanced agentic search capabilities within their own platforms, while the broader organization benefits from cross-platform search through the unified system.

**灵活的智能体部署方式**：依托 LangGraph 的灵活架构，智能体可直接部署于数据所属的系统内部。例如，用于检索专有新闻档案的智能体可封装为独立 API，供内部团队无缝集成至其现有系统中。这意味着各业务部门可在自有平台上获得增强型智能检索能力，而整个组织则可通过统一系统实现跨平台协同检索。

## **Inside the Architecture**

## **架构详解**

![](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_003.jpg)

![](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_003.jpg)

At the core of Bertelsmann Content Search is a LangGraph-powered multi-agent architecture that coordinates complex, cross-domain content discovery in production. Here’s how it works:

Bertelsmann 内容搜索系统的核心是一个由 LangGraph 驱动的多智能体架构，该架构在生产环境中协调复杂的跨领域内容发现。其工作原理如下：

### **Intelligent Query Routing via a Coordinator**

### **通过协调智能体实现智能查询路由**

The system begins with a coordinator agent, which analyzes the user questions and sends them to the respective agents. This isn't simple keyword matching— the router understands context, intent, and domain relevance to ensure queries reach the most appropriate specialists.

系统首先启动一个协调智能体（coordinator agent），用于分析用户提问，并将问题分发至相应的专业智能体。这并非简单的关键词匹配——该路由机制能够理解上下文、用户意图及领域相关性，从而确保查询被精准送达最合适的专家级智能体。

### **Parallelized Domain-Specialized Agents**

### **并行化、领域专用的智能体**

These queries then get sent to a central and parallelized node, triggering relevant agents for each specific content domain. For example:

这些查询随后被发送至一个中心化且支持并行处理的节点，进而触发针对各个特定内容领域的相关智能体。例如：

- **Publishing Agent**: Searches catalogs, understanding book metadata, author information, and publication timelines  
- **出版智能体**：检索图书目录，理解图书元数据、作者信息及出版时间线  

- **Broadcasting Agent**: Queries archives with knowledge of show formats, air dates, and content classifications  
- **广播智能体**：查询音视频档案，具备对节目格式、播出日期及内容分类的理解能力  

- **News Agent**: Navigates journalistic archives with understanding of article metadata, publication dates, and content categorization.  
- **新闻智能体**：浏览新闻类档案，可解析文章元数据、发布日期及内容分类信息  

- **Web Intelligence Agent**: Monitors external trends and commentary to provide context from beyond Bertelsmann's owned content.  
- **网络情报智能体**：监测外部趋势与评论，提供源自贝塔斯曼自有内容之外的背景信息  

LangGraph helped Bertelsmann to access these diverse data sources in a variety of ways. The agents interfaced with:

LangGraph 帮助贝塔斯曼以多种方式接入这些多样化的数据源。各智能体通过以下方式与数据源交互：

- Vector databases (e.g. Qdrant) for fast semantic search  
- 向量数据库（例如 Qdrant），用于快速语义搜索  

- APIs for structured queries.  
- API 接口，用于结构化查询  

- Graph databases for relationship-based lookup  
- 图数据库，用于基于关系的检索  

- Custom tools to simplify complex interactions and boost reliability  
- 自定义工具，用以简化复杂交互并提升系统可靠性  

### **Response Synthesis**

### **响应合成**

The final  layer combines individual agent responses into coherent, actionable insights. The system understands relationships between different content types and can identify cross-platform opportunities. Users can also drill down into any content by chatting directly with an individual agent.

最终层将各智能体的独立响应整合为连贯、可操作的洞察结果。系统能够理解不同类型内容之间的关联，并识别跨平台协同机会。用户还可通过直接与任一智能体对话，深入探究任意具体内容。

![](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_004.jpg)

### **Supercharging Agent Use via Modular APIs**

### **通过模块化 API 强化智能体应用**

One of LangGraph's most powerful features for Bertelsmann’s use case is how easily individual agents can be deployed as standalone APIs. This architectural flexibility allowed the team to serve the same agent that powers their cross-platform search directly to the division that owns the underlying data source. For example, teams can integrate their specialized news agent directly into their content management systems all while maintaining the agents' availability for the broader unified search platform.

LangGraph 针对贝塔斯曼实际场景最具优势的功能之一，便是能极为便捷地将各个智能体独立部署为单独的 API。这种架构上的灵活性，使团队得以将驱动其跨平台搜索的同一智能体，直接提供给底层数据源所属的业务部门使用。例如，各团队可将专用于新闻领域的智能体直接集成至自身的内容管理系统中，同时仍确保该智能体对更广泛的统一搜索平台保持可用。

![](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_005.jpg)

As a result, the multi-agent system can kill two birds with one stone: Business units can pick up and use smart, agentic search for data sources that are deployed in Content Search. They can use these agents to help their own teams and place them right in people’s workflows, for example in the news archives UI.

因此，该多智能体系统一举两得：各业务单元可直接采用“智能、具备自主能力”的搜索功能，对接已接入“内容搜索（Content Search）”平台的数据源；同时，他们还能将这些智能体嵌入自身团队工作流中——例如，直接集成至新闻档案系统的用户界面（UI）中，切实赋能一线员工。

## **Why LangGraph: First mover and still state of the art**

## **为何选择 LangGraph：先行者，亦是当前业界标杆**

The Bertelsmann AI Hub team started to work with LangGraph the first week it was released— back in 2024, when "agents" were far from the buzzword they've become today. This early adoption proved crucial, and their multi-agent systems are deployed in production today.

贝塔斯曼 AI Hub 团队在 LangGraph 发布首周便启动了合作——那是在 2024 年，“智能体（agents）”远未成为如今这般炙手可热的流行词。这一前瞻性布局被证明至关重要，其多智能体系统目前已全面投入生产环境运行。

"We started exploring a multi-agent approach towards empowering creative discovery in late 2023" says Moritz Glauner, Head of Data Science at Bertelsmann Data Services. "And what was initially earmarked as a pilot for exploring the potential of the still early agentic tech, evolved into fully-fledged internal product development given what turned out to be possible with LangGraph and agentic tech", adds Carsten Mönning, Bertelsmann AI Hub Lead. "Looking back, we started by exploring a lot of what were then research frameworks across the market,” points out Lion Schulz, Head of Machine Learning at the Bertelsmann AI Hub. "We then quickly realized that LangGraph was exactly what we were looking for, as it offered reliability and predictability for our production systems – so we committed to building our multi-agent system on it, and haven’t looked back."

“我们自 2023 年底起便开始探索多智能体方法，以赋能创意发现。”贝塔斯曼数据服务公司（Bertelsmann Data Services）数据科学负责人莫里茨·格劳纳（Moritz Glauner）表示。“最初，该项目仅被定位为一项试点，旨在评估当时尚处早期阶段的智能体技术潜力；但随着 LangGraph 与智能体技术展现出的实际能力日益清晰，它迅速演变为一项全面展开的内部产品开发工作。”贝塔斯曼 AI Hub 负责人卡斯滕·门宁（Carsten Mönning）补充道。“回溯整个选型过程，我们起初广泛调研了当时市场上诸多尚处于研究阶段的框架，”贝塔斯曼 AI Hub 机器学习负责人莱昂·舒尔茨（Lion Schulz）指出，“随后我们很快意识到，LangGraph 正是我们所寻找的答案——它为我们的生产系统提供了所需的可靠性与可预测性。因此，我们坚定选择以 LangGraph 作为多智能体系统的基础平台，并自此再未动摇。”

In particular, the Bertelsmann team benefitted from LangGraph and its:

尤其值得一提的是，贝塔斯曼团队从 LangGraph 及其以下特性中获益良多：

- **Modular Design**: The node-based architecture allowed the team to build specialized agents for each content domain while maintaining clean interfaces between components.

- **模块化设计**：基于节点的架构使团队能够针对不同内容领域构建专用智能体，同时确保各组件之间接口清晰、职责分明。

- **Production-Ready Infrastructure**: The maturity of the LangChain ecosystem provided the observability and debugging capabilities necessary for lifting the system from prototype to production and maintaining a complex multi-agent system at scale.

- **面向生产的基础设施**：LangChain 生态系统的成熟度，为系统从原型迈向生产环境提供了必需的可观测性与调试能力，也支撑着复杂多智能体系统在大规模场景下的长期稳定运维。

- **Scalable Orchestration**: As Bertelsmann's content universe expanded, the system could easily accommodate new agents and data sources without architectural changes.

- **可扩展的编排能力**：随着贝塔斯曼内容生态体系持续扩展，该系统无需改动整体架构，即可轻松接入新的智能体与数据源。

## **Impact: Empowering Creativity at Scale**

## **影响：规模化赋能创意生产力**

Built on LangGraph, the Bertelsmann Content Search has transformed how creative teams find information across the organization:

基于 LangGraph 构建的贝塔斯曼内容搜索系统（Bertelsmann Content Search），已彻底改变了创意团队在整个组织范围内查找信息的方式：

**Faster content discovery**: What used to require **hours** of searching across multiple systems now takes **seconds**. Creative teams spend less time hunting for information and more time creating with it.

**更快的内容发现**：过去需在多个系统中耗费**数小时**才能完成的搜索，如今仅需**几秒钟**。创意团队不再将大量时间耗费在信息搜寻上，而是能将更多精力投入到内容创作之中。

**Cross-platform insights**: The system reveals connections and opportunities that might be missed when searching individual systems in isolation. A documentary producer might discover related books that could inform their research, or a book editor might find inspiration in the news archives.

**跨平台洞察力**：该系统可揭示单个系统孤立搜索时容易忽略的关联性与潜在机会。例如，纪录片制作人可能由此发现与其选题相关的图书资料，从而丰富研究素材；而图书编辑则可能从新闻档案中获得全新创作灵感。

**Democratized access**: Teams no longer need to know which system contains what information—or have access to every database. The unified interface makes the entire Bertelsmann content universe accessible to authorized users.

**普惠式访问**：团队无需再记忆或判断某类信息具体存于哪个系统，也无需拥有全部数据库的访问权限。统一的交互界面，使所有经授权的用户均可便捷触达贝塔斯曼浩瀚的内容宇宙。

**Enhanced collaboration**: By surfacing content across divisions, the system encourages collaboration and identifies opportunities for cross-brand initiatives.

**强化协作能力**：通过打通各业务部门间的内容壁垒，该系统不仅促进跨团队协作，更主动识别出跨品牌联合项目的新契机。

The result is a more agile, informed creative organization that can respond quickly to trends and opportunities while making the most of Bertelsmann's vast content portfolio.

最终成果是一个更敏捷、更富洞见的创意型组织——它既能快速响应市场趋势与新兴机遇，又能充分释放贝塔斯曼庞大内容资产的价值潜力。

## **Looking Ahead: The Future of Agentic Content Systems**

## **展望未来：智能体驱动型内容系统的前景**

The Bertelsmann Content Search represents more than just a successful deployment— it's a proof point for the future of AI in media and creative industries. By starting early with LangGraph and focusing on production reliability from day one, the team has built a system that continues to evolve with the organization's needs.

贝塔斯曼内容搜索系统所代表的，远不止一次成功的落地部署——它更是人工智能在媒体与创意产业未来演进道路上的一个关键验证。团队自项目初期即采用 LangGraph，并从第一天起便将生产环境的可靠性置于核心地位，由此构建出一个能够持续随组织需求演进的系统。

As multi-agent systems become more mainstream, the Bertelsmann Content Search stands as an example of what's possible when cutting-edge technology meets thoughtful engineering and real-world creative needs. Even beyond the Content Search, the Bertelsmann AI Hub Team now employs LangGraph in its agentic developments, for example supporting ideation or storyboarding.

随着多智能体系统（multi-agent systems）日益走向主流，贝塔斯曼内容搜索系统成为前沿技术、审慎工程实践与真实创意需求三者深度融合的典范。不仅如此，贝塔斯曼 AI 中心团队（Bertelsmann AI Hub Team）目前已将 LangGraph 广泛应用于各类智能体开发场景，例如创意构思（ideation）与分镜脚本（storyboarding）等环节。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_006.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_006.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_007.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_007.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_008.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_008.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + 沃达丰：利用 LangGraph 与 LangSmith 构建 AI 智能体，重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_009.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_009.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_010.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现客户成功智能体的可观测性](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_010.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现客户成功智能体的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_011.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 与 LangSmith 构建数据 + AI 可观测性智能体](images/how-bertelsmann-built-a-multi-agent-system-to-empower-creatives/img_011.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 与 LangSmith 构建数据 + AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
&#123;% endraw %}
