---
title: "How Webtoon Entertainment built agentic workflows with LangGraph to scale story understanding"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-webtoon/"
date: "2025-05-19"
scraped_at: "2026-03-03T07:32:15.115833065+00:00"
language: "en-zh"
translated: true
description: "See how Webtoon is transforming storytelling with agent workflows built on LangGraph for content discovery to help marketing, transation, and recommendation teams."
tags: ["Case Studies"]
---
&#123;% raw %}

**WEBTOON Entertainment** (Nasdaq: **WBTN**) is a global digital entertainment company transforming the future of storytelling.  
**WEBTOON Entertainment**（纳斯达克股票代码：**WBTN**）是一家全球性数字娱乐公司，致力于重塑叙事的未来。

Best known as the pioneer of the vertical scroll web comic format, WEBTOON Entertainment operates two of the world’s largest storytelling platforms: **WEBTOON** and **Wattpad**.  
作为垂直滚动式网络漫画格式的开创者，WEBTOON Entertainment 运营着全球规模最大的两大叙事平台：**WEBTOON** 和 **Wattpad**。

Together, they connect millions of users around the globe with diverse, creator-driven content across genres such as romance, fantasy, action, and thriller.  
二者共同将全球数百万用户与涵盖爱情、奇幻、动作、惊悚等多元类型的、由创作者主导的丰富内容连接起来。

With a strong international presence and partnerships across the media industry, WEBTOON Entertainment adapts its original IP into films, TV series, and animations—producing cross-media hits that resonate with global audiences.  
凭借强大的国际影响力及遍及媒体行业的广泛合作，WEBTOON Entertainment 将其原创 IP 改编为电影、电视剧和动画作品，打造出引发全球观众共鸣的跨媒体爆款。

The company continues to lead the content-tech landscape by investing in cutting-edge AI to support creators and make their lives easier.  
公司持续引领“内容+科技”领域的发展，通过投资前沿人工智能技术，赋能创作者，切实减轻其工作负担。

To support teams working with massive volumes of content, the team built WEBTOON Comprehension AI (WCAI)—a system powered by agentic workflows using LangGraph.  
为支持需处理海量内容的各业务团队，团队构建了 **WEBTOON 理解型人工智能（WCAI）**——一套基于 LangGraph 驱动的智能体（agentic）工作流系统。

Whether it's a marketer generating ideas from trending arcs, a translator capturing tone for localization, or a product manager retrieving metadata to target segments — WCAI automates deep narrative comprehension, enabling teams to dedicate their resources, rather than spending time on manual browsing, to empowering creators and protecting their rights as WEBTOON's global footprint expands.  
无论是营销人员从热门故事线中激发创意、本地化译员精准把握原文语调，还是产品经理调取元数据以精准定位用户群体——WCAI 均可自动化实现深度叙事理解，使团队得以将宝贵资源聚焦于赋能创作者、保障其权益，而非耗费时间在人工浏览与信息筛选上；这一能力正有力支撑着 WEBTOON 全球版图的持续拓展。

WCAI achieves this without any model training on creators’ works; instead, it analyzes content to interpret and structure information.  
WCAI 的实现无需在创作者作品上进行任何模型训练；它仅通过对内容进行分析，即可完成语义解读与信息结构化。

## Technical Details: Agentic Workflows Powering WEBTOON Comprehension

## 技术细节：驱动 WEBTOON 内容理解的智能体工作流

**WCAI** is built on a hybrid architecture that leverages **Vision-Language Models (VLMs)** and workflow-based AI agents orchestrated through **LangGraph**.  
**WCAI** 采用混合架构，融合了**视觉-语言大模型（VLMs）** 与基于工作流的 AI 智能体，并通过 **LangGraph** 实现统一编排。

We evaluated several frameworks—including LangGraph—to find one that could meet production demands. While many frameworks support agentic patterns, our requirements went further. We needed a system that could:  
我们评估了多个框架（包括 LangGraph），旨在遴选一款能满足生产级需求的解决方案。尽管诸多框架均支持智能体模式，但我们的要求更为严苛：我们需要一个能够——

- Scale across a vast amount of WEBTOON series metadata,  
- 承载海量 WEBTOON 系列元数据的规模化处理需求；  

- Integrate **subject-matter expertise (SME)** into workflows,  
- 将**领域专家知识（SME）** 深度融入工作流；  

- Maintain high **quality and consistency** for internal business use.  
- 在内部业务应用中持续保障**高质量与高一致性**。

LangGraph’s **node-based architecture** offered the modularity and precision we needed. It enabled us to inject domain-specific knowledge into individual workflow stages—such as visual comprehension, narrative summarization, and translation. Additionally, LangGraph’s tight integration with LangSmith provided robust tracing, debugging, and observability—crucial for development and deployment at scale.  
LangGraph 的**节点式架构**为我们提供了所需的模块化能力与执行精度。它使我们得以将特定领域的专业知识注入各个工作流环节——例如视觉理解、叙事摘要生成与本地化翻译。此外，LangGraph 与 LangSmith 的深度集成，提供了强大的链路追踪、调试与可观测能力——这对大规模开发与部署至关重要。

### Core Agentic Workflows

### 核心智能体工作流

![](images/how-webtoon-entertainment-built-agentic-workflows-with-langgraph-to-scale-story-/img_001.png)

WCAI is built around specialized agentic workflows, each designed to handle a specific aspect of WEBTOON series comprehension. Thanks to **dynamic workflow routing**, important information about a webcomic can be processed for multiple business needs simultaneously.

WCAI 围绕一系列专业化的智能体工作流（agentic workflows）构建，每个工作流专为处理 WEBTOON 系列理解的某一特定方面而设计。得益于**动态工作流路由（dynamic workflow routing）**，一部网络漫画的关键信息可被同步处理，以满足多种业务需求。

Here are some core workflows:

以下是若干核心工作流：

1. **Character Identification:** Identifies important information about each webcomic’s characters by identifying names, roles, and representative images. By analyzing both visual and textual data, it builds structured character profiles—foundational for downstream agents.

1. **角色识别（Character Identification）**：通过识别角色姓名、身份定位及代表性图像，提取每部网络漫画中各角色的关键信息；结合视觉与文本数据的联合分析，构建结构化角色档案——这是下游智能体运行的基础。

2. **Speaker Identification:** Since WEBTOON series inherit many conventions from cartoons and comics, speech bubbles are essential to narrative comprehension. This workflow analyzes speech balloons and attributes them to characters using a blend of VLMs and advanced computer vision techniques.

2. **说话人识别（Speaker Identification）**：由于 WEBTOON 系列承袭了动画与漫画的诸多表现惯例，对话气泡（speech bubbles）对叙事理解至关重要。该工作流融合视觉语言模型（VLMs）与先进计算机视觉技术，分析对话气泡并将其准确归属至对应角色。

3. **Narrative Understanding:** Generates a textual representation of the WEBTOON series, capturing key plot points, events, and emotional beats from visual scenes. It outputs structured summaries that downstream agents or users can easily understand.

3. **叙事理解（Narrative Understanding）**：生成 WEBTOON 系列的文本化表征，从视觉画面中提取关键情节节点、重要事件及情绪高潮点；输出结构清晰的摘要，便于下游智能体或终端用户快速理解。

4. **SME application:** Built atop the foundational workflows, this agent produces business-specific insights based on user intent. For example, the marketing team can discover titles that align with campaign themes, while recommendation teams can identify highlight-worthy scenes. This layer is critical, as outputs are often tied directly to quantifiable KPIs such as Click-Through Rate (CTR). WCAI analyzes a large number of WEBTOON titles and generates high-quality keywords for each one—such as genre, narrative style, and cliffhangers—which are then exposed to help users discover titles that match their preferences.

4. **领域专家应用（SME application）**：基于前述基础工作流构建，该智能体依据用户意图生成面向具体业务场景的深度洞察。例如，市场团队可借此发现契合营销活动主题的作品；推荐团队则可识别出值得重点推广的高光场景。该层级尤为关键，因其输出结果往往直接关联可量化的业务指标（KPI），如点击率（Click-Through Rate, CTR）。WCAI 对海量 WEBTOON 作品进行分析，为每一部作品生成高质量关键词——例如类型（genre）、叙事风格（narrative style）与悬念设置（cliffhangers）等，并将这些关键词开放给用户，助力其发现更符合个人偏好的作品。

By combining these workflows, WEBTOON Comprehension transforms unstructured visual narratives into actionable, structured data.

通过整合上述工作流，“WEBTOON 理解”系统将非结构化的视觉叙事转化为可操作、结构化的数据。

## Why LangGraph?

## 为何选择 LangGraph？

After extensive production testing, LangGraph stood out for several reasons:

经过长期生产环境测试，LangGraph 在多个维度脱颖而出，主要原因如下：

1. **Controllable Workflows:** While multi-agent frameworks can be useful in research settings, our production use cases—especially those involving SME collaboration—demanded **controllability, interpretability, and reliability**. Internal users also wanted transparency and the ability to steer outcomes. LangGraph’s architecture was a perfect match.

1. **可控性工作流（Controllable Workflows）**：尽管多智能体框架在研究场景中颇具价值，但我们的实际生产用例——尤其是涉及领域专家（SME）协同的场景——对工作流提出了**强可控性、高可解释性与高可靠性**的严苛要求。内部用户亦强调流程透明度及对结果走向的主动干预能力。LangGraph 的架构设计恰好完美契合这些需求。

2. **Production-Ready Deployment:** LangGraph is built with real-world deployment in mind, and its robustness is well validated by the LLM community. We were able to build and deploy API servers with ease and integrate them seamlessly into our systems. Reliable, efficient data generation was a top priority, and **LangSmith’s tracing capabilities** helped us identify issues like excessive token usage stemming from inefficient handling of visual tokens.

2. **开箱即用的生产部署能力（Production-Ready Deployment）**：LangGraph 从设计之初即面向真实世界部署场景，其稳定性已在大语言模型（LLM）社区获得广泛验证。我们得以轻松构建并部署 API 服务，并将其无缝集成至现有系统中。稳定、高效的数据生成是我们的首要目标，而 **LangSmith 的追踪（tracing）能力** 帮助我们精准定位了诸如“因视觉 Token 处理低效导致的 Token 过度消耗”等关键问题。

## Conclusion

## 结论

**WEBTOON Entertainment** has successfully integrated agentic AI workflows into its internal operations using LangGraph. This initiative has:

**WEBTOON Entertainment** 已成功借助 LangGraph，将智能体 AI 工作流深度融入企业内部运营。本项目取得了以下成果：

- Enabled deep understanding of multi-modal WEBTOON series data for both research and business applications  
- 实现了对多模态 WEBTOON 系列数据的深度理解，全面赋能科研探索与商业应用；

- Proven that agentic workflows can support a broad range of internal teams  
- 验证了智能体工作流可有效支撑公司内广泛多元的业务团队；

- Significantly reduced the manual effort required for story comprehension, boosting overall productivity. For example, the content team was previously responsible for manually reading every new title to extract keywords for user guidance. By leveraging WCAI, this process was automated— **reducing their workload by over 70%** and enabling the team to focus on more strategic and creative content promotion tasks.

- 大幅降低了故事理解所需的人工投入，显著提升了整体运营效率。例如，内容团队此前需人工通读每一部新上线作品，从中提取关键词以指导用户发现；借助 WCAI，该流程已实现自动化——**团队工作量减少逾 70%**，从而得以将精力集中于更具战略意义与创意价值的内容推广任务。

We are actively developing new features and improvements for WCAI, including:

我们正在积极为 WCAI 开发新功能与改进，包括：

- Systematic evaluation of workflows across various business scenarios,  
- 面向多种业务场景的工作流系统性评估；

- Fine-grained control over human-agent interaction through architectural refinements,  
- 通过架构优化实现对人机协作的细粒度控制；

- Enhanced tool-chaining to incorporate external data sources.  
- 增强的工具链能力，以整合外部数据源。

With WCAI and LangGraph, we’re shaping the future of scalable narrative understanding—empowering creativity across teams and unlocking the full potential of WEBTOON series. On the technical side, we are also continuously validating emerging LangChain features, such as the MCP adapter, to incorporate broader external knowledge into WEBTOON series analysis.

借助 WCAI 与 LangGraph，我们正共同塑造可扩展叙事理解的未来——赋能跨团队创意协作，并充分释放 WEBTOON 系列的全部潜力。在技术层面，我们也在持续验证 LangChain 的新兴功能（例如 MCP 适配器），以将更广泛的外部知识融入 WEBTOON 系列分析中。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-webtoon-entertainment-built-agentic-workflows-with-langgraph-to-scale-story-/img_002.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-webtoon-entertainment-built-agentic-workflows-with-langgraph-to-scale-story-/img_002.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-webtoon-entertainment-built-agentic-workflows-with-langgraph-to-scale-story-/img_003.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成自动化入驻](images/how-webtoon-entertainment-built-agentic-workflows-with-langgraph-to-scale-story-/img_003.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 完成数千名客户的入职流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-webtoon-entertainment-built-agentic-workflows-with-langgraph-to-scale-story-/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith 利用 AI 智能体重塑客户体验](images/how-webtoon-entertainment-built-agentic-workflows-with-langgraph-to-scale-story-/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith 利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-webtoon-entertainment-built-agentic-workflows-with-langgraph-to-scale-story-/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-webtoon-entertainment-built-agentic-workflows-with-langgraph-to-scale-story-/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-webtoon-entertainment-built-agentic-workflows-with-langgraph-to-scale-story-/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何借助 LangSmith 实现对其客户成功智能体的可观测性](images/how-webtoon-entertainment-built-agentic-workflows-with-langgraph-to-scale-story-/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何借助 LangSmith 实现对其客户成功智能体的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-webtoon-entertainment-built-agentic-workflows-with-langgraph-to-scale-story-/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-webtoon-entertainment-built-agentic-workflows-with-langgraph-to-scale-story-/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
&#123;% endraw %}
