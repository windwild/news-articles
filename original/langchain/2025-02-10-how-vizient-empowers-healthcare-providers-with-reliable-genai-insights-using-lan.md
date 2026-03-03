---
title: "How Vizient empowers healthcare providers with reliable GenAI insights using LangGraph and LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-vizient/"
date: "2025-02-10"
scraped_at: "2026-03-03T07:40:19.661611562+00:00"
language: "en"
translated: false
description: "Vizient's GenAI platform helps users manage data to query for information ranging from patient outcomes to clinical benchmarking. See how they used LangGraph and LangSmith for multi-agent system relia..."
tags: ["Case Studies"]
---

[Vizient](https://www.vizientinc.com/?ref=blog.langchain.com), a leader in healthcare performance improvement, is revolutionizing how healthcare providers access and analyze data. Today, many healthcare providers rely on disparate data sources, needing to mine for data to produce actionable insights on patient care — a long, drawn-out process. Vizient's GenAI platform empowers systems of all sizes to query and unify siloed datasets, driving better decisions in supply chain management and clinical outcomes.

Vizient's GenAI platform helps answer questions like: "Are my ambulatory investments effective?" or "Are we delivering the most cost-effective care?" and get immediate, data-backed answers. The goal is to improve operational efficiency and democratize data analysis for resource-limited health facilities — all while maintaining strong trust and data privacy among their members.

![](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_001.jpg)Scorecard performance for an example hospital system in Vizient’s GenAI platform

### **Reliable AI agent workflows with LangGraph**

Before adopting LangGraph, Vizient's multi-agent system faced several challenges. Each agent had been designed to handle a specific task, such as analyzing historical data or generating visualizations. However, coordinating them was tricky. These agents worked in silos, leading to inconsistent responses and a lack of reliability. Some underlying API workflows also involved managing hundreds of parameters per call, making it difficult to maintain and update application logic.

![](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_002.jpg)Vizient’s AI user interface to chat with data and generate visualizations

To coordinate their multi-agent system and ensure their platform met high-reliability standards, Vizient chose [LangGraph](https://langchain.com/langgraph?ref=blog.langchain.com) to orchestrate their agentic system. With LangGraph's graph structure and fully descriptive primitives, Vizient's engineering team could control and plan their workflows and represent steps that an agent should perform as tools or nodes programmatically to improve reliability. Today, their hierarchical agent structure (with worker agents reporting to a supervisor agent) has greatly streamlined the process of routing requests to the appropriate APIs.

As Vizient continues to expand and enhance its GenAI platform, LangGraph remains a cornerstone of its strategy, enabling the team to adapt and scale its system confidently.

### **LLM observability and prompt management with LangSmith**

To ensure their GenAI platform runs smoothly, Vizient needed visibility into its performance. That's where LangSmith came in. By leveraging LangSmith's tracing capabilities, Vizient's engineers could quickly pinpoint and resolve issues, even during high-stakes, real-time demos. For example, they easily navigated problems caused by Azure OpenAI's content filters and external rate-limiting errors.

LangSmith's Prompt Hub has also proved invaluable. By isolating prompt logic, Vizient's teams gained the flexibility to version and iterate on prompts with ease— a much more flexible approach. As the number of GenAI development teams grows, having this logic separated out will help teams handle and iterate on prompts quickly.

### **Looking Forward**

Vizient is focused on refining evaluations to ensure output consistency and trust. Key initiatives include:

- **Evaluating consistency across data domains:** Aligning generated answers with established tools like Q&A scorecards.
- **Rapid data onboarding**: The team aims to quickly onboard product data to fuel its agentic system using various existing product APIs and other data sources.

Vizient is building a transformative GenAI platform that empowers healthcare providers. It enables even non-experts to ask complex questions and get actionable insights while maintaining the highest trust, security, and innovation standards. With LangGraph and LangSmith as foundational technologies, Vizient is poised to continue raising the bar for healthcare performance improvement.

### Tags

[Case Studies](https://blog.langchain.com/tag/case-studies/)



[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_004.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read