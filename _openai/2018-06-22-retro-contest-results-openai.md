---
title: "Retro Contest: Results | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/retro-contest-results"
date: "2018-06-22"
scraped_at: "2026-03-02T10:30:13.458478148+00:00"
language: "en-US"
translated: false
description: "The first run of our Retro Contest—exploring the development of algorithms that can generalize from previous experience—is now complete."
tags: ["Research"]
---
&#123;% raw %}

June 22, 2018


# Retro Contest: Results

The first run of our Retro Contest—exploring the development of algorithms that can generalize from previous experience—is now complete.

![A screenshot of the Sonic the Hedgehog video game interface](images/retro-contest-results-openai/img_001.webp)



Though many approaches were tried, top results all came from tuning or extending existing algorithms such as PPO and Rainbow. There’s a long way to go: top performance was 4,692 after training while the theoretical max is 10,000. These results provide validation that our Sonic benchmark is a good problem for the community to double down on: the winning solutions are general machine learning approaches rather than competition-specific hacks, suggesting that one can’t cheat through this problem.

![Screenshot of a Sonic the Hedgehog video game.](images/retro-contest-results-openai/img_002.jpg)

An AI agent by the Dharmaraja team learning over time on a custom version of Aquatic Ruin Zone. The agent was pre-trained on other Sonic levels, but this is its first time seeing this particular level. Times listed are with respect to wall-clock time.

Over the two-month contest, 923 teams registered and 229 submitted solutions to the leaderboard. Our automated evaluation systems conducted a total of 4,448 evaluations of submitted algorithms, corresponding to about 20 submissions per team. The contestants got to see their scores rise on the leaderboard, which was based on a test set of five low-quality levels that we created using a level editor. You can watch the agents play one of these levels by clicking on the [leaderboard entries⁠(opens in a new window)](https://contest.openai.com/leaderboard).

![Graph of leaderboard score over days](images/retro-contest-results-openai/img_003.png)

Because contestants got feedback about their submission in the form of a score and a video of the agent being tested on a level, they could easily overfit to the leaderboard test set. Therefore, we used a completely different test set for the final evaluation. Once submissions closed, we took the latest submission from the top 10 entrants and tested their agents against 11 custom Sonic levels made by skilled level designers. To reduce noise, we evaluated each contestant on each level three times, using different random seeds for the environment. The ranking changed in this final evaluation, but not to a large extent.

Three different AIs learning on the same level. Red dots indicate earlier episodes whereas blue dots indicate later episodes. (From top to bottom, ordered by score on the level: Dharmaraja, aborg and mistake)

## Top scores

The top 5 scoring teams are:

|     |     |     |
| --- | --- | --- |
| **Rank** | **Team** | **Score** |
| #1 | Dharmaraja | 4692 |
| #2 | mistake | 4446 |
| #3 | aborg | 4430 |
| #4 | whatever | 4274 |
| #5 | Students of Plato | 4269 |
|  | Joint PPO baseline | 4070 |
|  | Joint Rainbow baseline | 3843 |
|  | Rainbow baseline | 3498 |

**Dharmaraja** topped the scoreboard during the contest, and the lead remained on the final evaluation; **mistake** narrowly won out over **aborg** for second place. The top three teams will receive trophies.

![Trophies Three 2000](images/retro-contest-results-openai/img_004.jpg)

Learning curves of the top three teams for all 11 levels are as follows (showing the standard error computed from three runs).

![Learning Curves Averaged Over 3 Trials](images/retro-contest-results-openai/img_005.png)

Averaging over all levels, we can see the following learning curves.

![Learning Curves Averaged Over 11 Levels And 3 Trials](images/retro-contest-results-openai/img_006.png)

Note that **Dharmaraja** and **aborg** start at similar scores, whereas **mistake** starts much lower. As we will describe in more detail below, these two teams fine-tuned (using PPO) from a pre-trained network, whereas **mistake** trained from scratch (using Rainbow DQN). **mistake**’s learning curves end early because they timed out at 12 hours.

## Meet the winners

![Qing Da](images/retro-contest-results-openai/img_007.jpg)

![Jing-Cheng Shi](images/retro-contest-results-openai/img_008.jpg)

![Anxiang Zeng](images/retro-contest-results-openai/img_009.jpg)

![Guangda Huzhang](images/retro-contest-results-openai/img_010.jpg)

![Run-Ze Li](images/retro-contest-results-openai/img_011.jpg)

![Yang Yu](images/retro-contest-results-openai/img_012.jpg)

### Dharmaraja

Dharmaraja is a six-member team including Qing Da, Jing-Cheng Shi, Anxiang Zeng, Guangda Huzhang, Run-Ze Li, and Yang Yu. [Qing Da⁠(opens in a new window)](http://www.daqings.net/) and Anxiang Zeng are from the AI team within the search department of Alibaba in Hangzhou, China. In recent years, they have studied how to apply reinforcement learning to real world problems, especially in an e-commerce setting, together with [Yang Yu⁠(opens in a new window)](http://lamda.nju.edu.cn/yuy), who is an Associate Professor of the Department of Computer Science at Nanjing University, Nanjing, China.

Dharmaraja’s solution is a variant of joint PPO (described in our [tech report⁠(opens in a new window)](https://arxiv.org/abs/1804.03720)) with a few improvements. First, it uses RGB images rather than grayscale; second, it uses a slightly augmented action space, with more common button combinations; third, it uses an augmented reward function, which rewards the agent for visiting new states (as judged by a perceptual hash of the screen). In addition to these modifications, the team also tried a number of things that didn’t pan out: [DeepMimic⁠(opens in a new window)](https://arxiv.org/abs/1804.02717), object detection through [YOLO⁠(opens in a new window)](https://arxiv.org/abs/1506.02640), and some Sonic-specific ideas.

- [Get the source code(opens in a new window)](https://github.com/eyounx/RetroCodes)

![Peng Xu](images/retro-contest-results-openai/img_013.jpg)

![Qiaoling Zhong](images/retro-contest-results-openai/img_014.jpg)

### Mistake

Team mistake consists of Peng Xu and Qiaoling Zhong. Both are second-year graduate students in Beijing, China, studying at the CAS Key Laboratory of Network Data Science and the Technology Institute of Computing Technology, Chinese Academy of Sciences. In their spare time, Peng Xu enjoys playing basketball, and Qiaoling Zhong likes to play badminton. Their favorite video games are Contra and Mario.

Mistake’s solution is based on the Rainbow baseline. They made several modifications that helped boost performance: a better value of n for n-step Q learning; an extra CNN layer added to the model, which made training slower but better; and a lower DQN target update interval. Additionally, the team tried joint training with Rainbow, but found that it actually hurt performance in their case.

- [Get the source code(opens in a new window)](https://github.com/xupe/mistake-in-retro-contest-of-OpenAI)

![Alexandre Borghi](images/retro-contest-results-openai/img_015.jpg)

### Aborg

Team Aborg is a solo effort from Alexandre Borghi. After completing a PhD in computer science in 2011, Alexandre worked for different companies in France before moving to the United Kingdom where he is a research engineer in deep learning. As both a video game and machine learning enthusiast, he spends most of his free time studying deep reinforcement learning, which led him to take part in the OpenAI Retro Contest.

Aborg’s solution, like Dharmaraja’s, is a variant of joint PPO with many improvements: more training levels from the Game Boy Advance and Master System Sonic games; a different network architecture; and fine-tuning hyper-parameters that were designed specifically for fast learning. Elaborating on the last point, Alexandre noticed that the first 150K timesteps of fine-tuning were unstable (i.e. the performance sometimes got worse), so he tuned the learning rate to fix this problem. In addition to the above changes, Alexandre tried several solutions that did not work: different optimizers, [MobileNetV2⁠(opens in a new window)](https://arxiv.org/abs/1801.04381), using color images, etc.

- [Get the source code(opens in a new window)](https://github.com/aborghi/retro_contest_agent)

## Best write-ups

The Best Write-up Prize is awarded to contestants that produced high-quality essays describing the approaches they tried.

|     |     |     |
| --- | --- | --- |
| Rank | Winner | Writeup |
| #1 | Dylan Djian | [World Models](https://dylandjian.github.io/world-models) |
| #2 | Oleg Mürk | [Exploration algorithms, policy distillation and fine-tuning](https://medium.com/@olegmrk/openai-retro-contest-report-b870bfd014e0) |
| #3 | Felix Yu | [Fine-tuning on per-zone expert policies](https://flyyufelix.github.io/2018/06/11/sonic-rl.html) |

Now, let’s meet the winners of this prize category.

![Dylan Djian](images/retro-contest-results-openai/img_016.jpg)

### Dylan Djian

Dylan currently lives in Paris, France. He is a student in software development at [school 42 in Paris⁠(opens in a new window)](https://en.wikipedia.org/wiki/42_(school)). He got into machine learning after watching [a video⁠(opens in a new window)](https://www.youtube.com/watch?v=qv6UVOQ0F44) of a genetic algorithm learning how to play Mario a year and a half ago. This video sparked his interest and made him want to learn more about the field. His favorite video games are Zelda Twilight Princess and World of Warcraft.

![Oleg Mürk](images/retro-contest-results-openai/img_017.jpg)

### Oleg Mürk

[Oleg Mürk⁠(opens in a new window)](https://www.linkedin.com/in/oleg-m%C3%BCrk-5634b71/) hails from the San Francisco Bay Area, but is originally from Tartu, Estonia. During the day, he works with distributed data processing systems as a Chief Architect at Planet OS. In his free time, he burns “too much money” on renting GPUs for running deep learning experiments in TensorFlow. Oleg likes traveling, hiking, and kite-surfing and intends to finally learn to surf over the next 30 years. His favorite computer game (also the only one he has completed) is Wolfenstein 3D. His masterplan is to develop an automated programmer over the next 20 years and then retire.

![Felix Yu](images/retro-contest-results-openai/img_018.jpg)

### Felix Yu

Felix is an entrepreneur who lives in Hong Kong. His first exposure to machine learning was a school project where he applied PCA to analyse stock data. After several years pursuing entrpreneurship, he got into ML in late 2015; he has become an [active Kaggler⁠(opens in a new window)](https://www.kaggle.com/renman) and has worked on several [side projects⁠(opens in a new window)](https://flyyufelix.github.io/) on computer vision and reinforcement learning.

## Best Supporting Material

One of the best things that came from this contest was seeing contestants helping each other out. Lots of people contributed guides for getting started, useful scripts, and troubleshooting support for other contestants.

![Tristan Sokol](images/retro-contest-results-openai/img_019.jpg)

### Tristan Sokol

The winner of our Best Supporting Material award is [Tristan Sokol⁠(opens in a new window)](https://tristansokol.com/), who wrote [many⁠(opens in a new window)](https://medium.com/@tristansokol/discovering-q-learning-f7780a77b927) [helpful⁠(opens in a new window)](https://medium.com/@tristansokol/a-deep-dive-into-the-jerk-agent-3c553dbab442) [blog⁠(opens in a new window)](https://medium.com/@tristansokol/day-one-of-the-openai-retro-contest-1651ddcd6aa5) [posts⁠(opens in a new window)](https://medium.com/@tristansokol/openai-retro-contest-day-3-7a75289a1c9c) throughout the contest and [made a tool⁠(opens in a new window)](https://medium.com/@tristansokol/making-fun-visuals-history-maps-and-other-tool-improvements-eb5ffe187fd3) for visualizing trajectories through Sonic levels.

During the day, Tristan works for Square, helping to build their developer platform; at night, he is a designer and entrepreneur. This was the first time that he has done any AI/ML, and also his first time using Python for any real use case. Looking forward, Tristan is going to try to make cool things with TensorFlow.js. Whenever he isn’t in front of a computer, Tristan is probably in his Oakland backyard watching plants grow.

## Lessons and next steps

Contests have the potential to overhaul the prevailing consensus on what works the best, since contestants will try a diverse set of different approaches and the best one will win. In this particular contest, the top performing approaches were not radically different from the ones that we at OpenAI had found to be successful prior to the contest.

We were glad to see several of the top solutions making use of transfer learning; fine-tuning from the training levels. However, we were surprised to find that some of the top submissions were simply tuned versions of our baseline algorithms. This emphasizes the importance of hyper-parameters, especially in RL algorithms such as Rainbow DQN.

We plan to start another rendition of the contest in a few months. We hope and expect that some of the more off-beat approaches will be successful in this second round, now that people know what to expect and have begun to think deeply about the problems of fast learning and generalization in reinforcement learning. We’ll see you then, and we look forward to watching your innovative solutions climb up the scoreboard.

_Gotta Learn Fast_

- [Community & Collaboration](https://openai.com/research/index/?tags=community-collaboration)
- [Exploration & Games](https://openai.com/research/index/?tags=exploration-game)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
- [Simulated Environments](https://openai.com/research/index/?tags=simulated-environments)
&#123;% endraw %}
