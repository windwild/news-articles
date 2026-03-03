---
title: "How MUFG Bank increased sales efficiency by 10x with LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-mufgbank/"
date: "2025-02-28"
scraped_at: "2026-03-03T07:38:33.178896815+00:00"
language: "en"
translated: false
description: "See how MUFG Bank used LangChain to streamline corporate sales research, cutting data analysis time from hours to minutes and boosting efficiency 10x."
tags: ["Case Studies"]
---

MUFG Bank is Japan’s largest bank and one of the world's leading financial institutions. They provide capital market solutions to major corporate clients and promote economic growth around the world.

## **Problem: Solving data overload for corporate sales**

In MUFG Bank's Global Capital Markets Division, the FX & Derivative Sales team faced a key challenge. FX & Derivative Sales team members needed to gather and analyze vast amounts of corporate data in order to create compelling client presentations – from 10k reports, to market data, to financial disclosures. This was a time-consuming process and skill-dependent (with junior members often needing additional guidance and assistance), which limited efficiency.

To address these challenges, MUFG’s AI/ML team leveraged Generative AI (GenAI) to streamline data digestion and automate the creation of presentation materials. Their goal was to empower sales teams with rapid insights, reducing manual burden and ensuring more effective client interactions.

## **Solution: Using LangChain for retrieval and summarization**

To improve the FX & Derivative Sales team’s client research process, the MUFG AI/ML team implemented two key steps:

### **1) Data extraction & summarization**

Annual reports often spanned 100-200 pages, with only a fraction containing relevant insights for the sales teams. Using LangChain, MUFG developed a system to extract critical financial data efficiently – and they implemented fine-tuned prompt engineering and retrieval-augmented generation (RAG) to surface the most relevant sections for sales teams.

### **2) Automatically generate presentations**

The FX & Derivative Sales teams required tailored presentations based on the extracted insights. To ensure the insights were actionable, the AI/ML team implemented few-shot prompting techniques and step-by-step guidance that helped FX & Derivative Sales professionals – even those with limited experience – quickly analyze financial opportunities and provide structured recommendations.

This enabled sales teams to assess interest rate risks, identify potential FX derivative purchases, and suggest regional currency positioning strategies.

The production RAG application now serves as a knowledge-sharing tool for corporate sales teams, simplifying the search for internal documents and deal-making ideas.

## **Impact: Improving efficiency 10x in sales processes**

The adoption of LangChain-powered GenAI has yielded substantial improvements for MUFG’s corporate sales team. Specifically, the process of analyzing corporate client data and generating presentation materials has been **reduced** from several hours to just **3-5 minutes**.

Previously, only limited experienced sales personnel could manually generate insightful presentations. With the new system, hundreds of sales professionals can now access the same level of intelligence, leading to a **10x increase** in the number of corporate clients receiving tailored financial recommendations.

These efficiency gains have also begun converting into tangible business outcomes, with deal execution timelines shortening over the past six months.

## **Behind the scenes: How LangChain enabled MUFG’s success**

The MUFG AI/ML team benefited from the LangChain programming library in the following two phases:

**R&D / PoC phase**

The MUFG AI/ML team chose the Python version of LangChain and built a simple chat and RAG app. LangChain is well integrated with Streamlit, allowing them to easily manage conversation history and implement interactive apps. This enabled them to quickly start experiments, gather feedback from the sales, and iterate on improvements. Furthermore, thanks to the Retriever interface, they were able to switch between several specific vector databases and search engines, allowing them to compare and validate the accuracy at a low implementation cost.

**Development / Production phase**

The MUFG team switched to the TypeScript version of LangChain for a more sustainable and secure application via Next.js. The interface was nearly identical to the Python version, ensuring a smooth transition. In addition, Runnable Lambda allowed them to dynamically change the content filter and target index on demand and enabled them to invoke it in their custom RAG chain.

## **What’s Next**

MUFG Bank plans to refine its GenAI applications by enhancing its evaluation metrics, exploring graph-based AI architectures or AI agents for complex reasoning tasks, and expanding its RAG-driven retrieval system to incorporate broader financial data sources.

By leveraging LangChain, MUFG continues to advance AI-driven sales intelligence, improving efficiency, scalability, and strategic decision-making for its global clientele.

### Tags

[Case Studies](https://blog.langchain.com/tag/case-studies/)



[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_001.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_002.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read