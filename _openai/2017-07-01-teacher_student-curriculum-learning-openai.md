---
title: "Teacher–student curriculum learning | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/teacher-student-curriculum-learning"
date: "2017-07-01"
scraped_at: "2026-03-02T10:32:43.035097896+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
&#123;% raw %}

July 1, 2017


# Teacher–student curriculum learning

[Read paper(opens in a new window)](https://arxiv.org/abs/1707.00183)

![Teacherstudent Curriculum Learning](images/teacher_student-curriculum-learning-openai/img_001.webp)



## Abstract

We propose Teacher–Student Curriculum Learning (TSCL), a framework for automatic curriculum learning, where the Student tries to learn a complex task and the Teacher automatically chooses subtasks from a given set for the Student to train on. We describe a family of Teacher algorithms that rely on the intuition that the Student should practice more those tasks on which it makes the fastest progress, i.e. where the slope of the learning curve is highest. In addition, the Teacher algorithms address the problem of forgetting by also choosing tasks where the Student's performance is getting worse. We demonstrate that TSCL matches or surpasses the results of carefully hand-crafted curricula in two tasks: addition of decimal numbers with LSTM and navigation in Minecraft. Using our automatically generated curriculum enabled to solve a Minecraft maze that could not be solved at all when training directly on solving the maze, and the learning was an order of magnitude faster than uniform sampling of subtasks.

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
&#123;% endraw %}
