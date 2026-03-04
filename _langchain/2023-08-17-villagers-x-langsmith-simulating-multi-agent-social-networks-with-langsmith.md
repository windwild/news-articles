---
render_with_liquid: false
title: "Villagers x LangSmith: Simulating multi-agent social networks with LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/villagers-x-langsmith-simulating-multi-agent-social-networks/"
date: "2023-08-17"
scraped_at: "2026-03-03T09:15:19.300705074+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

_Editor's Note: This post was written in collaboration with Kevin Hu, Tae Hyoung Jo, John Kim, and Tejal Patwardhan from the Villagers team. Villagers came in second at a recent Anthropic hackathon. We really LOVED this project as it shows off complex prompt engineering with their multi-agent social network simulation that runs many agents in parallel. We were really excited to see how [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) could help the team automate traces, quickly iterate on prompts, and efficiently debug for this complex use-case!_

_编辑注：本文由 Villagers 团队的 Kevin Hu、Tae Hyoung Jo、John Kim 和 Tejal Patwardhan 共同撰写。Villagers 在近期举办的 Anthropic 黑客松中荣获亚军。我们非常喜爱这一项目——它通过并行运行大量智能体的多智能体社交网络仿真，充分展现了复杂的提示工程能力。我们尤其兴奋地看到，[LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 如何助力团队实现链路追踪自动化、快速迭代提示词，并高效调试这一高度复杂的应用场景！_

We are excited to write about our experience building a proof-of-concept for [simulated multi-agent social networks](https://devpost.com/software/realistic-multi-agent-simulations?ref=blog.langchain.com) using LangSmith. Simulating language-based human interactions on social networks has shown potential across economics, politics, sociology, business, and policy applications (e.g., \[ [1](https://arxiv.org/pdf/2304.03442.pdf?ref=blog.langchain.com)\], \[ [2](https://www.science.org/content/article/can-ai-chatbots-replace-human-subjects-behavioral-experiments?ref=blog.langchain.com)\]). We use the example of a text-based online community (Twitter/X) with real user personas to demonstrate how LLMs can be used to create realistic multi-agent simulations.

我们很高兴分享使用 LangSmith 构建[模拟多智能体社交网络](https://devpost.com/software/realistic-multi-agent-simulations?ref=blog.langchain.com)概念验证（PoC）的实践经历。在社交网络上模拟基于语言的人类互动，在经济学、政治学、社会学、商业及政策等领域已展现出广阔潜力（例如：\[ [1](https://arxiv.org/pdf/2304.03442.pdf?ref=blog.langchain.com)\]、\[ [2](https://www.science.org/content/article/can-ai-chatbots-replace-human-subjects-behavioral-experiments?ref=blog.langchain.com)\]）。本文以一个基于文本的在线社区（Twitter/X）为案例，结合真实用户画像，展示大语言模型（LLM）如何用于构建逼真的多智能体仿真系统。

![](https://lh6.googleusercontent.com/cNlxRy4lkz0Gb9vcZDmIB9O1rMCD2h6ngEMI4zCi875ND2RkPIfydXCG9qlLSjI2H37-Su04HJ5M4xZQrA948J56HsNG8mulFGlVL5FCVSTzzGj0xVxYhhPVXqAxIrgCevxmuBJow7VWZz46VhSkaLg)

![](https://lh6.googleusercontent.com/cNlxRy4lkz0Gb9vcZDmIB9O1rMCD2h6ngEMI4zCi875ND2RkPIfydXCG9qlLSjI2H37-Su04HJ5M4xZQrA948J56HsNG8mulFGlVL5FCVSTzzGj0xVxYhhPVXqAxIrgCevxmuBJow7VWZz46VhSkaLg)

Building a useful simulation requires mimicking what an actual user would do, ideally based on histories of past behavior. We built agents to simulate real Twitter users interacting online based on their tweet, retweet, quote tweet, comment, and like history. Each user is an agent with their own specific prompt based on their past history. We then tested the response of the community to various ad campaigns from brands, political statements from candidates, and social commentary from comedians. This served as a proof of concept for a new simulation platform to predict engagement, responses, and behavior modification for online social networks.

构建一个有价值的仿真系统，关键在于尽可能真实地复现真实用户的行为——理想情况下，应以用户过往行为历史为依据。我们据此构建了多个智能体，用以模拟真实 Twitter 用户的线上互动行为，其行为模式基于每位用户的推文（tweet）、转发（retweet）、引用推文（quote tweet）、评论（comment）和点赞（like）历史。每位用户均被建模为一个独立智能体，拥有专属提示词（prompt），该提示词由其历史行为数据生成。随后，我们测试了社区对各类品牌广告活动、候选人政治声明以及喜剧演员社会评论的响应。这一实践成功验证了一种新型仿真平台的可行性——该平台可预测在线社交网络中的用户参与度、反馈倾向与行为变化。

![](https://lh5.googleusercontent.com/pkycBFqgV4FbNUeUdmTfcblIgUVA--dUw5Tobf09Cu4yf6om4Nvb25KbnQC1dLb4K2chyv1siz2B7adAwPdECwXZHdqYnZosiWJgbjYkpem3WTdXqbkMB-t_6UrwGIwJko0-ZMQt3665iOuWTS8QrnU)

![](https://lh5.googleusercontent.com/pkycBFqgV4FbNUeUdmTfcblIgUVA--dUw5Tobf09Cu4yf6om4Nvb25KbnQC1dLb4K2chyv1siz2B7adAwPdECwXZHdqYnZosiWJgbjYkpem3WTdXqbkMB-t_6UrwGIwJko0-ZMQt3665iOuWTS8QrnU)

One of the major technical hurdles we encountered was debugging and prompt engineering given the number of agents that would be interacting at once. We were really excited by LangSmith, which allowed us to have automatic traces and to iterate effectively on prompts, helping build the foundation of the multi-agent network.

我们在开发过程中面临的主要技术挑战之一，是如何在大量智能体实时交互的场景下开展高效调试与提示工程。LangSmith 的出现令我们倍感振奋——它支持自动链路追踪（tracing），并助力我们高效迭代优化提示词，从而为多智能体网络的构建奠定了坚实基础。

![](https://lh6.googleusercontent.com/Yf8dFfrPQA0p0NEPbpi_0Ip0ewBalaWxkZb5zTTeCj2D9bV_5M2c-SQUb3Mvid0JQsZUR58195qRxhE8fk9YEwc1XVx4pgIN_Kuy7RiTgqtShZ1a6MTAkb_cclbvhK-OecRR4TcbXB7RWH29TNwGXhA)

![](https://lh6.googleusercontent.com/Yf8dFfrPQA0p0NEPbpi_0Ip0ewBalaWxkZb5zTTeCj2D9bV_5M2c-SQUb3Mvid0JQsZUR58195qRxhE8fk9YEwc1XVx4pgIN_Kuy7RiTgqtShZ1a6MTAkb_cclbvhK-OecRR4TcbXB7RWH29TNwGXhA)

With LangSmith, we were able to significantly speed up development time and feel more confident about the quality of our prompts. We found it to be the easiest-to-use LLMops tool for a product that has a high magnitude of agents running in parallel.

借助 LangSmith，我们大幅缩短了开发周期，同时对提示词的质量也更有信心。对于需要并行运行海量智能体的产品而言，我们认为 LangSmith 是目前最易上手、最高效的 LLMops 工具。