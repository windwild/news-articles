---
title: "Scaling social science research | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/scaling-social-science-research"
date: "2026-02-13"
scraped_at: "2026-03-02T10:08:19.268356991+00:00"
language: "en-US"
translated: true
description: "GABRIEL is a new open-source toolkit from OpenAI that uses GPT to turn qualitative text and images into quantitative data, helping social scientists analyze research at scale."
tags: ["Global Affairs"]
---
&#123;% raw %}

February 13, 2026

2026年2月13日

[Global Affairs](https://openai.com/news/global-affairs/) [Publication](https://openai.com/research/index/publication/) [Research](https://openai.com/news/research/)

[全球事务](https://openai.com/news/global-affairs/) [出版物](https://openai.com/research/index/publication/) [研究动态](https://openai.com/news/research/)

# Scaling social science research

# 扩展社会科学的研究能力

A new tool to help researchers turn qualitative data into numbers they can analyze.

一款新工具，帮助研究人员将定性数据转化为可分析的数值。

[See the tutorial(opens in a new window)](https://colab.research.google.com/drive/1RMUeAWACpViqiUMlPMMwPTKyGU-OX756?usp=sharing) [Read our paper(opens in a new window)](https://cdn.openai.com/pdf/7517a586-5bfa-4b87-bd3d-6ea0e9e844c7/GPT-as-a-measurement-tool.pdf)

[查看教程（在新窗口中打开）](https://colab.research.google.com/drive/1RMUeAWACpViqiUMlPMMwPTKyGU-OX756?usp=sharing) [阅读我们的论文（在新窗口中打开）](https://cdn.openai.com/pdf/7517a586-5bfa-4b87-bd3d-6ea0e9e844c7/GPT-as-a-measurement-tool.pdf)

A core part of our work at OpenAI is enabling scientists to move faster and solve harder problems. Today, our Economic Research Team is releasing GABRIEL: an open-source toolkit that uses GPT to turn unstructured text and images into quantitative measurements. It is designed for economists, social scientists, and data scientists to study qualitative data at scale.

OpenAI 工作的核心之一，是赋能科学家加速科研进程、攻克更艰巨的难题。今天，我们的经济研究团队正式发布 GABRIEL：一个开源工具包，利用 GPT 将非结构化的文本与图像转化为定量测量结果。该工具专为经济学家、社会科学家及数据科学家设计，支持对海量定性数据开展规模化研究。

Qualitative data tells the richest stories about the world—what people say, write, teach, argue, and experience. It spans everything from syllabi and interviews to social media and photographs. There is a tremendous amount of it. But transforming that type of data into rigorous evidence is incredibly time-consuming. Often it isn't feasible at all. In too many cases, social scientists are forced to forego important avenues of research, not because the data doesn’t exist, but because it’s impossible to analyze.

定性数据讲述着关于世界最丰富、最生动的故事——人们所说、所写、所教授、所争论以及所经历的一切。其形式涵盖课程大纲、访谈记录、社交媒体内容、照片等方方面面，数量极为庞大。然而，将此类数据转化为严谨的实证证据却异常耗时，很多时候甚至根本不可行。在太多情况下，社会科学家不得不放弃重要的研究方向，并非因为数据不存在，而是因为这些数据难以分析。

GABRIEL is built to make qualitative data much more accessible. It allows researchers to describe what they want to measure in everyday words—like “how family-friendly is this job listing?”—and then applies that same question consistently across thousands (or millions) of documents, returning a score for each one. This lets researchers spend less time on repetitive data labeling and more time on the work that actually requires expertise: choosing what to measure, validating results, and drawing careful conclusions.

GABRIEL 的设计目标，正是大幅提升定性数据的可及性与可用性。它允许研究人员用日常语言描述待测目标——例如，“这份招聘启事对家庭是否友好？”——随后，该问题将被一致地应用于成千上万（甚至上百万）份文档，并为每份文档返回一个量化评分。这使研究人员得以大幅减少在重复性数据标注任务上耗费的时间，从而将更多精力投入到真正需要专业判断的工作中：确定测量对象、验证结果可靠性，以及审慎得出结论。

For example, GABRIEL can analyze a large collection of scientific papers to see what specific methods are used and how they evolve over time. It can look at course curricula to measure how much attention is given to different subjects or skills. It can extract structured historical details for every small town across Europe, or examine a trove of customer reviews and discover patterns in what people value most. In [our paper⁠(opens in a new window)](https://cdn.openai.com/pdf/7517a586-5bfa-4b87-bd3d-6ea0e9e844c7/GPT-as-a-measurement-tool.pdf), we benchmark GPT at labeling qualitative data across many use cases and find that it is highly accurate.

例如，GABRIEL 可用于分析大量学术论文，识别其中所采用的具体研究方法及其随时间的演变趋势；可用于评估课程大纲，量化不同学科或技能所获得的关注程度；可为欧洲每一座小镇提取结构化的史料细节；亦可深入分析海量客户评论，挖掘用户最看重的价值维度。在[我们的论文（在新窗口中打开）](https://cdn.openai.com/pdf/7517a586-5bfa-4b87-bd3d-6ea0e9e844c7/GPT-as-a-measurement-tool.pdf)中，我们针对多种应用场景对 GPT 在定性数据标注任务上的表现进行了基准测试，结果表明其准确率极高。

Beyond this type of measurement, GABRIEL also provides practical tools researchers often need. These include merging datasets even when the columns don’t match, smart deduplication, passage coding, ideating new scientific theories, and deidentifying personal information from text to preserve privacy.

除了这类测量功能外，GABRIEL 还提供了研究人员经常需要的实用工具。这些工具包括：即使列名不匹配也能合并数据集、智能去重、段落编码、构思新的科学理论，以及对文本中的个人信息进行匿名化处理以保护隐私。

GABRIEL is available now as an [open-source Python library⁠(opens in a new window)](https://github.com/openai/GABRIEL), with a [tutorial notebook⁠(opens in a new window)](https://colab.research.google.com/drive/1RMUeAWACpViqiUMlPMMwPTKyGU-OX756?usp=sharing) to get started. It is designed to require minimal technical background. We’ll keep improving GABRIEL over time based on feedback from the academic community. We hope this tool will help more researchers bring the richness of qualitative data and human stories into their work.

GABRIEL 现已作为一款 [开源 Python 库⁠(在新窗口中打开)](https://github.com/openai/GABRIEL) 发布，并附带一份 [入门教程 Notebook⁠(在新窗口中打开)](https://colab.research.google.com/drive/1RMUeAWACpViqiUMlPMMwPTKyGU-OX756?usp=sharing)，方便用户快速上手。其设计目标是尽可能降低技术门槛。我们将持续根据学术界反馈优化和完善 GABRIEL。我们希望这一工具能帮助更多研究人员将定性数据的丰富内涵与真实的人文故事融入其研究工作之中。

- [2026](https://openai.com/news/?tags=2026)

- [2026](https://openai.com/news/?tags=2026)
&#123;% endraw %}
