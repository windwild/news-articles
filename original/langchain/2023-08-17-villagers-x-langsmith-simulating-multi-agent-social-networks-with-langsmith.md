---
title: "Villagers x LangSmith: Simulating multi-agent social networks with LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/villagers-x-langsmith-simulating-multi-agent-social-networks/"
date: "2023-08-17"
scraped_at: "2026-03-03T09:15:19.300705074+00:00"
language: "en"
translated: false
---

_Editor's Note: This post was written in collaboration with Kevin Hu, Tae Hyoung Jo, John Kim, and Tejal Patwardhan from the Villagers team. Villagers came in second at a recent Anthropic hackathon. We really LOVED this project as it shows off complex prompt engineering with their multi-agent social network simulation that runs many agents in parallel. We were really excited to see how [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) could help the team automate traces, quickly iterate on prompts, and efficiently debug for this complex use-case!_

We are excited to write about our experience building a proof-of-concept for [simulated multi-agent social networks](https://devpost.com/software/realistic-multi-agent-simulations?ref=blog.langchain.com) using LangSmith. Simulating language-based human interactions on social networks has shown potential across economics, politics, sociology, business, and policy applications (e.g., \[ [1](https://arxiv.org/pdf/2304.03442.pdf?ref=blog.langchain.com)\], \[ [2](https://www.science.org/content/article/can-ai-chatbots-replace-human-subjects-behavioral-experiments?ref=blog.langchain.com)\]). We use the example of a text-based online community (Twitter/X) with real user personas to demonstrate how LLMs can be used to create realistic multi-agent simulations.

![](https://lh6.googleusercontent.com/cNlxRy4lkz0Gb9vcZDmIB9O1rMCD2h6ngEMI4zCi875ND2RkPIfydXCG9qlLSjI2H37-Su04HJ5M4xZQrA948J56HsNG8mulFGlVL5FCVSTzzGj0xVxYhhPVXqAxIrgCevxmuBJow7VWZz46VhSkaLg)

Building a useful simulation requires mimicking what an actual user would do, ideally based on histories of past behavior. We built agents to simulate real Twitter users interacting online based on their tweet, retweet, quote tweet, comment, and like history. Each user is an agent with their own specific prompt based on their past history. We then tested the response of the community to various ad campaigns from brands, political statements from candidates, and social commentary from comedians. This served as a proof of concept for a new simulation platform to predict engagement, responses, and behavior modification for online social networks.

![](https://lh5.googleusercontent.com/pkycBFqgV4FbNUeUdmTfcblIgUVA--dUw5Tobf09Cu4yf6om4Nvb25KbnQC1dLb4K2chyv1siz2B7adAwPdECwXZHdqYnZosiWJgbjYkpem3WTdXqbkMB-t_6UrwGIwJko0-ZMQt3665iOuWTS8QrnU)

One of the major technical hurdles we encountered was debugging and prompt engineering given the number of agents that would be interacting at once. We were really excited by LangSmith, which allowed us to have automatic traces and to iterate effectively on prompts, helping build the foundation of the multi-agent network.

![](https://lh6.googleusercontent.com/Yf8dFfrPQA0p0NEPbpi_0Ip0ewBalaWxkZb5zTTeCj2D9bV_5M2c-SQUb3Mvid0JQsZUR58195qRxhE8fk9YEwc1XVx4pgIN_Kuy7RiTgqtShZ1a6MTAkb_cclbvhK-OecRR4TcbXB7RWH29TNwGXhA)

With LangSmith, we were able to significantly speed up development time and feel more confident about the quality of our prompts. We found it to be the easiest-to-use LLMops tool for a product that has a high magnitude of agents running in parallel.