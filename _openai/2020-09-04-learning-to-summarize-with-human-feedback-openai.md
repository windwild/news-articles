---
title: "Learning to summarize with human feedback | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/learning-to-summarize-with-human-feedback"
date: "2020-09-04"
scraped_at: "2026-03-02T10:26:44.019993477+00:00"
language: "en-US"
translated: false
description: "We’ve applied reinforcement learning from human feedback to train language models that are better at summarization."
tags: ["Safety & Alignment"]
---
&#123;% raw %}

September 4, 2020


# Learning to summarize with human feedback

We’ve applied reinforcement learning from human feedback to train language models that are better at summarization.

[Read paper(opens in a new window)](https://arxiv.org/abs/2009.01325) [(opens in a new window)](https://github.com/openai/summarize-from-feedback) [View samples(opens in a new window)](https://openaipublic.blob.core.windows.net/summarize-from-feedback/website/index.html)

![Learning To Summarize With Human Feedback](images/learning-to-summarize-with-human-feedback-openai/img_001.webp)



## Why it matters

Our models generate summaries that are better than summaries from 10x larger models trained only with supervised learning. Even though we train our models on the Reddit TL;DR dataset, the same models transfer to generate good summaries of CNN/DailyMail news articles without any further fine-tuning. Our techniques are not specific to summarization; in the long run, our goal is to make aligning AI systems with human preferences a central component of AI research and deployment in many domains.

# Human feedback models outperform much larger supervised models and reference summaries on TL;DR

2e+93e+94e+95e+96e+97e+98e+99e+91e+10Model Size0%20%40%60%80%100%Human preference versus reference summariesReference summariesSupervisedHuman feedbackPre-trained

Figure 1: The performance of various training procedures for different model sizes. Model performance is measured by how often summaries from that model are preferred to the human-written reference summaries. Our pre-trained models are early versions of GPT-3, our supervised baselines were fine-tuned to predict 117K human-written TL;DRs, and our human feedback models are additionally fine-tuned on a dataset of about 65K summary comparisons.

Large-scale language models are becoming increasingly capable on NLP tasks. These models are usually trained with the objective of next word prediction on a dataset of human-written text. But this objective doesn’t capture exactly what we want; usually, we don’t want our models to imitate humans, we want them to give high-quality answers. This mismatch is clear when a model is trained to imitate low-quality human-written text, but it can also happen in more subtle ways. For example, a model trained to predict what a human would say might make up facts when it is unsure, or generate sentences reflecting harmful social bias, both failure modes that have been well-documented.[3](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-3), [4](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-4), [5](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-5), [6](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-6)

As part of our work on safety, we want to develop techniques that align our models’ objectives with the end behavior we really care about. As our models become more powerful, we believe aligning them with our goals will be very important to ensure they are beneficial for humans. In the short term, we wanted to test if human feedback techniques could help our models improve performance on useful tasks.

We focused on English text summarization, as it’s a challenging problem where the notion of what makes a “good summary” is difficult to capture without human input. We apply our method primarily to an existing dataset[1](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-1) of posts submitted to the social network Reddit[B](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-B) together with human-written “TL;DRs,” which are short summaries written by the original poster.

We first train a reward model via supervised learning to predict which summaries humans will prefer.[A](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-A) We then fine-tune a language model with reinforcement learning (RL) to produce summaries that score highly according to that reward model. We find that this significantly improves the quality of the summaries, as evaluated by humans, even on datasets very different from the one used for fine-tuning.

Our approach follows directly from [our previous work⁠](https://openai.com/index/fine-tuning-gpt-2/) on learning from human feedback.[7](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-7) There has also been other work on using human feedback to train summarization models.[8](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-8) We push the technique further by scaling to larger models, collecting more feedback data, closely monitoring researcher-labeler agreement, and providing frequent feedback to labelers. Human feedback has also been used to train models in several other domains, such as dialogue,[9](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-9), [10](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-10), [11](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-11) semantic parsing,[12](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-12) translation,[13](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-13), [14](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-14) story[15](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-15) and review[16](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-16) generation, evidence extraction,[17](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-17) and more traditional RL tasks.[18](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-18), [19](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-19)

## Results

PrevNext

Post from Reddit (r/AskReddit)

## I hope this is appropriate for AskReddit, but I’m looking for last-minute summer research/work. Anyone have any ideas on what I could do?

I’m living at home with my parents in Houston, Texas. I’m a post-bacc student at UH, taking classes to get into a CS master’s program, and I’ve already graduated from a top school with a BS in geophysics. I’ve also worked for years doing web dev and have a broad range of experience, and I can program decently well also have extensive web development experience.

There’s lots of internships I probably \*could\* have gotten if I hadn’t waited so long, but since this is the last minute I don’t know what to do. I can’t work from home, really. Any ideas? Pay isn’t important, if I can get good working/research experience. Although pay would be nice. :)

* * *

Human-written reference summary

sorry if this is a lame question for AskReddit, but I need something to work on this summer, pay or no pay. Hopefully something CS-y. Any ideas?

Human feedback 6B model

I’m a recent grad with a BS in geophysics and web dev experience looking for last-minute summer research/work. Any ideas? Pay isn’t important.

Supervised 6B model

I’m looking for last-minute summer research/work. I’m a post-bacc student at UH, taking classes to get into a CS master’s program, and I’ve already graduated from a top school with a BS in

Pre-trained 6B model

I’m a post-bacc student at UH, taking classes to get into a CS master’s program, and I’ve already graduated from a top school with a BS in geophysics. I’ve also worked for years doing web

We evaluated several different summarization models—some pre-trained on a broad distribution of text from the internet, some fine-tuned via supervised learning to predict TL;DRs, and some fine-tuned using human feedback.[D](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-D) To evaluate each model, we had it summarize posts from the validation set and asked humans to compare their summaries to the human-written TL;DR. The results are shown in [Figure 1⁠](https://openai.com/index/learning-to-summarize-with-human-feedback/#content).

We found that RL fine-tuning with human feedback had a very large effect on quality compared to both supervised fine-tuning and scaling up model size. In particular, our 1.3 billion parameter (1.3B) model trained with human feedback outperforms our 12B model trained only with supervised learning. Summaries from both our 1.3B and 6.7B human feedback models are preferred by our labelers to the original human-written TL;DRs in the dataset.[E](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-E)

People make different trade-offs when writing summaries, including between conciseness and coverage of the original text; depending on the purpose of the summary, different summary lengths might be preferred. Our labelers tended to prefer longer summaries, so our models adapted to that preference and converged to the longest allowable length. Controlling for length reduced human preferences for our 6.7B model’s summaries from 70% to 65%, explaining a minority of our gains.[F](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-F)

## Transfer results

# Human feedback models trained on Reddit transfer to generate excellent summaries of CNN/DM news articles without further training

- [Raw scores](https://openai.com/index/learning-to-summarize-with-human-feedback/#)
- [Length-controlled](https://openai.com/index/learning-to-summarize-with-human-feedback/#)

Reference summariesLead-3Supervised (transfer)Human feedback (transfer)Pre-trainedSupervised (fine-tuned)T5 (fine-tuned)2e+93e+94e+95e+96e+97e+98e+99e+91e+10Model Size3.54.04.55.05.56.06.5Overall Quality

The performance (human-rated summary quality on a 1–7 scale) of various training procedures and model sizes. Note that our human feedback models generate summaries that are significantly shorter than summaries from models trained on CNN/DM.

Supervised (transfer)Human feedback (transfer)T5 (fine-tuned)Reference4.64.85.05.25.45.65.86.06.2Summary log-length3.54.04.55.05.56.06.5Overall Quality

At a given summary length, our 6.7B human feedback model trained on Reddit performs almost as well as a fine-tuned 11B T5 model, despite not being re-trained on CNN/DM.

PrevNext

# Results

Article from CNN/DM (dailymail)

## Roberto Martinez defends Ross Barkley following another penalty fiasco at Goodison Park

Everton manager Roberto Martinez was forced to defend another penalty fiasco at the club after Ross Barkley missed from the spot in their 1-0 win against Burnley at Goodison Park.

The untried Barkley inexplicably took the 10th minute kick – awarded for a foul by David Jones on Aaron Lennon – rather than Leighton Baines, who has scored 15 penalties from 16 attempts in the Premier League.

Although there was no dispute between the team-mates this time, it brought back memories of Everton’s match against West Brom in January when Kevin Mirallas grabbed the ball from Baines to take a penalty - and missed.

Ross Barkley steps up to take a 10th minute penalty despite the presence of Leighton Baines on the pitch

Barkley’s effort is saved by Burnley goalkeeper Tom Heaton at Goodison Park

Martinez insisted Barkley was within his rights to request penalty-taking duties on Saturday.

’If Romelu Lukaku had been on the pitch, he would have taken it. Otherwise, I am happy to have three or four players who can take penalties and let it depend on how they feel at that moment,’ argued the Everton manager.

Baines (left) has scored 15 penalties from 16 attempts in the Premier League

’Ross showed incredible responsibility to take it. I love seeing players take control of the big moments and Leighton was happy to given him that responsibility.’

Barkley’s penalty was well-struck but wasn’t put in the corner and Burnley goalkeeper Tom Heaton dived to his right to save.

Fortunately for the young England player, it didn’t prove costly as Mirallas went on to score the only goal of the game after 29 minutes.

Everton boss Roberto Martinez issues instructions to his players during a break in play against Burnley

Expand

* * *

Human-written reference summary

Everton defeated Burnley 1-0 at Goodison Park on Saturday . Kevin Mirallas scored the only goal of the game in the 29th minute . Ross Barkley had earlier missed a 10th-minute penalty . Leighton Baines has scored 15 penalties from 16 attempts this season.

Human feedback 6B model (transfer)

Ross Barkley missed a penalty against Burnley after requesting taking duties from Leighton Baines. Martinez defended the young England player’s decision.

Supervised 6B model (transfer)

Ross Barkley missed a penalty in January and now he has missed another. Martinez insists he has the right to take penalties and Barkley is within his rights to do so.

Pre-trained 6B model

Ross Barkley was given the chance to take a penalty kick at Goodison Park but missed it. Roberto Martinez defended the young England player, saying he was within his rights to request the responsibility.

T5 11B model (fine-tuned on CNN/DM)

Everton beat Burnley 1-0 at Goodison Park on Saturday. Ross Barkley missed from the penalty spot in the 10th minute. Kevin Mirallas took a penalty from Leighton Baines in January. Roberto Martinez insisted Barkley was within his rights to take it.

Supervised 6B model (fine-tuned on CNN/DM)

Ross Barkley missed from the spot in Everton’s 1-0 win against Burnley. The untried Barkley took the 10th minute penalty instead of Leighton Baines. Roberto Martinez defended Barkley’s decision to take the penalty.

To test our models’ generalization, we also applied them directly to the popular CNN/DM news dataset.[2](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-2) These articles are more than twice as long as Reddit posts and are written in a very different style. Our models have seen news articles during pre-training, but all of our human data and RL fine-tuning was on the Reddit TL;DR dataset.

This time we evaluated our models by asking our labelers to rate them on a scale from 1–7.[G](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-G) We discovered that our human feedback models transfer to generate excellent short summaries of news articles without any training. When controlling for summary length, our 6.7B human feedback model generates summaries that are rated higher than the CNN/DM reference summaries written by humans. This suggests that our human feedback models have learned something more general about how to summarize text, and are not specific to Reddit posts.

## Approach

![Approach](images/learning-to-summarize-with-human-feedback-openai/img_002.svg)

A diagram of our method, which is similar to the one used in [our previous work⁠(opens in a new window)](https://arxiv.org/abs/1909.08593).

Our core method consists of four steps: training an initial summarization model, assembling a dataset of human comparisons between summaries, training a reward model to predict the human-preferred summary, and then fine-tuning our summarization models with RL to get a high reward.

We trained several supervised baselines by starting from GPT‑style transformer models trained on text from the Internet, [20⁠](https://openai.com/index/learning-to-summarize-with-human-feedback/#rf20) and fine-tuning them to predict the human-written TL;DR via supervised learning. We mainly use models with 1.3 and 6.7 billion parameters. As a sanity check, we confirmed that this training procedure led to competitive results[H](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-H) on the CNN/DM dataset.

We then collected a dataset of human quality judgments. For each judgment, a human compares two summaries of a given post and picks the one they think is better.[I](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-I) We use this data to train a reward model that maps a _(post, summary)_ pair to a reward _r_. The reward model is trained to predict which summary a human will prefer, using the rewards as logits.

Finally, we optimize the policy against the reward model using RL. We use [PPO⁠](https://openai.com/index/openai-baselines-ppo/) with 1 million episodes in total, where each episode consists of the policy summarizing a single article and then receiving a reward _r_. We include a KL penalty that incentivizes the policy to remain close to the supervised initialization.

## Collecting data from humans

Any training procedure that uses human feedback is directly influenced by the actual humans labeling the data. In our previous work on fine-tuning language models from human preferences, [7⁠](https://openai.com/index/learning-to-summarize-with-human-feedback/#rf7) our labelers often gave high ratings to summaries we thought were average, which was reflected in the quality of our trained models.

In response, in this project we invested heavily in ensuring high data quality. We hired about 80 contractors using third-party vendor sites,[J](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-J) and paid them an hourly wage regardless of the number of summaries evaluated.[K](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-K) Hiring contractors rather than relying on crowdsourcing websites allowed us to maintain a hands-on relationship with labelers: we created an onboarding process, developed a website with a customizable labeler interface, answered questions in a shared chat room, and had one-on-one video calls with labelers. We also made sure to clearly communicate our definition of summary quality, after spending significant time reading summaries ourselves, and we carefully monitored agreement rates between us and labelers throughout the project.

## Optimizing the reward model

# Optimizing our reward model eventually leads to sample quality degradation

ActualReward Model Prediction020406080100120140160180200220240260KL from Supervised Baseline0%20%40%60%80%100%Human preference versus reference summaries

Starting from the 1.3B supervised baseline (point 0 on the x-axis), we use RL to optimize the policy against the reward model, which results in policies with different “distances” from the baseline (x-axis, measured using the KL divergence from the supervised baseline). Optimizing against the reward model initially improves summaries according to humans, but eventually overfits, giving worse summaries. This chart uses an older version of our reward model, which is why the peak of the reward model is less than 0.5.

Post from Reddit (r/AskReddit)

## I’m a 28yo man, and I would like to get into gymnastics for the first time.

Title said just about all of it. I’m 28, very athletic (bike/ surf/ snowboard) and I have always wanted to do gymnastics.

I like to do flips and spins off bridges and on my snowboard, and it seems to me gymnastics would be a great way to do those movements I like, in a controlled environment. The end goal of this is that it would be fun, and make me better at these movements in real life.

But is it too late for me? Should 28 year old guys such as myself be content with just watching those parkour guys on youtube? Or can I learn the ways of the gymnastic jedi? BTW, I live in San Jose CA.

* * *

KL = 0

I want to do gymnastics, but I’m 28 yrs old. Is it too late for me to be a gymnaste?!

KL = 9

28yo guy would like to get into gymnastics for the first time. Is it too late for me given I live in San Jose CA?

KL = 260

28yo dude stubbornly postponees start pursuing gymnastics hobby citing logistics reasons despite obvious interest??? negatively effecting long term fitness progress both personally and academically thoght wise? want change this dumbass shitty ass policy pls

Optimizing against our reward model is supposed to make our policy align with human preferences. But the reward model is only a proxy for human preferences, as it only sees a small amount of comparison data from a narrow distribution of summaries. While the reward model performs well on the kinds of summaries it was trained on, we wanted to know how much we could optimize against it until it started giving useless evaluations.

We trained policies at different “optimization strengths” against the reward model, and asked our labelers to evaluate the summaries from these models. We did this by varying the KL coefficient, which trades off the incentive to get a higher reward against the incentive to remain close to the initial supervised policy. We found the best samples had roughly the same predicted reward as the 99th percentile of reference summaries from the dataset. Eventually optimizing the reward model actually makes things worse.

## Limitations

If we have a well-defined notion of the desired behavior for a model, our method of training from human feedback allows us to optimize for this behavior. However, this is not a method for determining what the desired model behavior _should be_. Deciding what makes a good summary is fairly straightforward, but doing this for tasks with more complex objectives, where different humans might disagree on the correct model behavior, will require significant care. In these cases, it is likely not appropriate to use researcher labels as the “gold standard”; rather, individuals from groups that will be impacted by the technology should be included in the process to define “good” behavior, and hired as labelers to reinforce this behavior in the model.

We trained on the Reddit TL;DR dataset [1⁠](https://openai.com/index/learning-to-summarize-with-human-feedback/#rf1) because the summarization task is significantly more challenging than on CNN/DM. However, since the dataset consists of user-submitted posts with minimal moderation, they sometimes contain content that is offensive or reflects harmful social biases. This means our models can generate biased or offensive summaries, as they have been trained to summarize such content.

Part of our success involves scaling up our reward model and policy size. This requires a large amount of compute, which is not available to all researchers: notably, fine-tuning our 6.7B model with RL required about 320 GPU-days. However, since smaller models trained with human feedback can exceed the performance of much larger models, our procedure is more cost-effective than simply scaling up for training high-quality models on specific tasks.

Though we outperform the human-written reference summaries on TL;DR, our models have likely not reached human-level performance, as the reference summary baselines for TL;DR and CNN/DM are not the highest possible quality. When evaluating our model’s TL;DR summaries on a 7-point scale along several axes of quality ( _accuracy_, _coverage_, _coherence_, and _overall_), labelers find our models can still generate inaccurate summaries, and give a perfect _overall_ score 45% of the time.[L](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-L) For cost reasons, we also do not directly compare to using a similar budget to collect high-quality demonstrations, and training on those using standard supervised fine-tuning.

## Future directions

We’re interested in scaling human feedback to tasks where humans can’t easily evaluate the quality of model outputs. For example, we might want our models to answer questions that would take humans a lot of research to verify; getting enough human evaluations to train our models this way would take a long time. One approach to tackle this problem is to give humans tools to help them evaluate more quickly and accurately. If these tools use ML, we can also improve them with human feedback, which could allow humans to accurately evaluate model outputs for increasingly complicated tasks.[23](https://openai.com/index/learning-to-summarize-with-human-feedback/#citation-bottom-23)

In addition to tackling harder problems, we’re also exploring different types of feedback beyond binary comparisons: we can ask humans to provide demonstrations, edit model outputs to make them better, or give explanations as to why one model output is better than another. We’d like to figure out which kinds of feedback are most effective for training models that are aligned with human preferences.

_If you are interested in working on these research questions,_ [_we’re hiring_ ⁠](https://openai.com/careers/) _!_

- [Language](https://openai.com/research/index/?tags=language)
- [Generative Models](https://openai.com/research/index/?tags=generative-models)
- [Transformers](https://openai.com/research/index/?tags=transformers)

## Footnotes

01. 1
    For training, we use the Reddit TL;DR dataset instead of the more popular CNN/DM dataset because simple copying baselines perform better than the human-written reference summaries on CNN/DM, which is not the case for TL;DR (see Appendix D of our paper). We performed a new web crawl to increase the TL;DR dataset size, required summaries to be between 24 and 48 tokens, and performed some other cleaning and filtering

02. B
    We hire human labelers to judge summary quality, and implement quality control to ensure that labeler judgments agree with our own. We describe our human data collection procedure below.

03. C
    Interestingly, we found that human evaluators preferred the Lead-3 baseline (taking the first 3 sentences of the article) to the dataset’s reference summaries, and we confirmed this ourselves.

04. D
    We generate all of our samples at temperature 0, which we found humans preferred most.

05. E
    While we use human-written TL;DRs as our main point of comparison, they don’t always represent optimal human performance; they are sometimes intended to be funny or to summarize only a part of the post, and their grammar and style are all over the map.

06. F
    We control by training a logistic regression model to predict the preferred summary given only the policy ID and the log ratio of the lengths of the summaries. Then, we report the regression coefficients on each policy ID, corresponding to a length ratio of 1 with the reference summaries.

07. G
    We took this approach because it is hard to directly compare our TL;DR-trained models to models trained on CNN/DM; the CNN/DM summaries are much longer and written in bullet-point form.

08. 21
    In terms of ROUGE results on CNN/DM, our 6.7B supervised models are a bit worse than T5 , but a bit better than state-of-the-art models from mid-2019.

09. I
    Our main models are trained on about 65K comparisons, though we achieve good results with as few as 8K comparisons.

10. J
    Specifically, we use Upwork, Scale, and Lionbridge. Our contractors have a range of ages, genders, and educational backgrounds, and are mostly American or Filipino (see Appendix C of our paper for demographic data).

11. K
    Our criteria for hiring contractors were: (1) they were willing to do the task, and (2) they passed a minimum threshold of speed and agreement with researcher labels. We paid all our contractors at least $15/hr.

12. L
    This is impressive relative to the TL;DR reference summaries, which get a perfect _overall_ score 23% of the time, but indicates there is still room for improvement.


## References

01. 1
    Völske, M., Potthast, M., Syed, S., & Stein, B. (2017). “ [TL; DR: Mining reddit to learn automatic summarization⁠(opens in a new window)](https://www.aclweb.org/anthology/W17-4508.pdf).” In Proceedings of the Workshop on New Frontiers in Summarization 2017.

02. 2
    Hermann, K. M., Kocisky, T., Grefenstette, E., Espeholt, L., Kay, W., Suleyman, M., & Blunsom, P. (2015). ” [Teaching machines to read and comprehend⁠(opens in a new window)](https://arxiv.org/abs/2005.14165).” In Advances in neural information processing systems 2015.

03. 3
    Maynez, J., Narayan, S., Bohnet, B., & McDonald, R. (2020). “ [On Faithfulness and Factuality in Abstractive Summarization.⁠(opens in a new window)](https://arxiv.org/abs/2005.00661).” arXiv preprint.

04. 4
    Sheng, E., Chang, K. W., Natarajan, P., & Peng, N. (2019). “ [The woman worked as a babysitter: On biases in language generation⁠(opens in a new window)](https://arxiv.org/abs/1909.01326).” arXiv preprint.

05. 5
    Bordia, S., & Bowman, S. R. (2019). “ [Identifying and reducing gender bias in word-level language models⁠(opens in a new window)](https://arxiv.org/abs/1904.03035).” arXiv preprint.

06. 6
    Nadeem, M., Bethke, A., & Reddy, S. (2020). “ [StereoSet: Measuring stereotypical bias in pretrained language models⁠(opens in a new window)](https://arxiv.org/abs/2004.09456).” arXiv preprint.

07. 7
    Ziegler, D. M., Stiennon, N., Wu, J., Brown, T. B., Radford, A., Amodei, D., Christiano, P., & Irving, G. (2019). “ [Fine-tuning language models from human preferences⁠(opens in a new window)](https://arxiv.org/abs/1909.08593).” arXiv preprint.

08. 8
    Böhm, F., Gao, Y., Meyer, C. M., Shapira, O., Dagan, I., & Gurevych, I. (2019). “ [Better rewards yield better summaries: Learning to summarise without references⁠(opens in a new window)](https://arxiv.org/abs/1909.01214).” arXiv preprint.

09. 9
    Jaques, N., Ghandeharioun, A., Shen, J. H., Ferguson, C., Lapedriza, A., Jones, N., Gu, S., & Picard, R. (2019). “ [Way off-policy batch deep reinforcement learning of implicit human preferences in dialog⁠(opens in a new window)](https://arxiv.org/pdf/1907.00456).” arXiv preprint.

10. 10
    Yi, S., Goel, R., Khatri, C., Cervone, A., Chung, T., Hedayatnia, B., ... & Hakkani-Tur, D. (2019). “ [Towards coherent and engaging spoken dialog response generation using automatic conversation evaluators⁠(opens in a new window)](https://arxiv.org/abs/1904.13015).” arXiv preprint.

11. 11
    Hancock, B., Bordes, A., Mazare, P. E., & Weston, J. (2019). “ [Learning from dialogue after deployment: Feed yourself, chatbot!⁠(opens in a new window)](https://arxiv.org/abs/1901.05415).” arXiv preprint.

12. 12
    Lawrence, C., & Riezler, S. (2018). “ [Improving a neural semantic parser by counterfactual learning from human bandit feedback⁠(opens in a new window)](https://arxiv.org/abs/1805.01252).” arXiv preprint.

13. 13
    Kreutzer, J., Khadivi, S., Matusov, E., & Riezler, S. (2018). “ [Can Neural Machine Translation be Improved with User Feedback?⁠(opens in a new window)](https://arxiv.org/abs/1804.05958).” arXiv preprint.

14. 14
    Bahdanau, D., Brakel, P., Xu, K., Goyal, A., Lowe, R., Pineau, J., ... & Bengio, Y. (2016). “ [An actor-critic algorithm for sequence prediction⁠(opens in a new window)](https://arxiv.org/abs/1607.07086).” arXiv preprint.

15. 15
    Zhou, W., & Xu, K. (2020). “ [Learning to Compare for Better Training and Evaluation of Open Domain Natural Language Generation Models⁠(opens in a new window)](https://www.aaai.org/Papers/AAAI/2020GB/AAAI-ZhouW.1159.pdf).” In AAAI 2020.

16. 16
    Cho, W., & Zhang, P., & Zhang, Y., & Li, X., & Galley, M., & Brockett, C., & Wang, M., & Gao, J. (2018). “ [Towards coherent and cohesive long-form text generation.⁠(opens in a new window)](https://arxiv.org/pdf/1811.00511.pdf)” arXiv preprint.

17. 17
    Perez, E., & Karamcheti, S., & Fergus, R., & Weston, J., & Kiela, D., & Cho, K. (2019). ” [Finding generalizable eevidence by learning to convince Q&A models.⁠(opens in a new window)](https://arxiv.org/pdf/1811.00511.pdf)” arXiv preprint.

18. 18
    Christiano, P. F., Leike, J., Brown, T., Martic, M., Legg, S., & Amodei, D. (2017). “ [Deep reinforcement learning from human preferences⁠(opens in a new window)](https://papers.nips.cc/paper/7017-deep-reinforcement-learning-from-human-preferences.pdf).” In Advances in Neural Information Processing Systems 2017.

19. 19
    Ibarz, B., Leike, J., Pohlen, T., Irving, G., Legg, S., & Amodei, D. (2018). “ [Reward learning from human preferences and demonstrations in Atari⁠(opens in a new window)](https://papers.nips.cc/paper/8025-reward-learning-from-human-preferences-and-demonstrations-in-atari.pdf).” In Advances in Neural Information Processing Systems 2018.

20. 20
    Brown, T. B., Mann, B., Ryder, N., Subbiah, M., Kaplan, J., Dhariwal, P., ... & Agarwal, S. (2020). ” [Language models are few-shot learners⁠(opens in a new window)](https://arxiv.org/abs/2005.14165).” arXiv preprint.

21. 21
    Raffel, C., Shazeer, N., Roberts, A., Lee, K., Narang, S., Matena, M., ... & Liu, P. J. (2019). ” [Exploring the limits of transfer learning with a unified text-to-text transformer⁠(opens in a new window)](https://arxiv.org/abs/1910.10683).” arXiv preprint.

22. 22
    Zhang, Y., Li, D., Wang, Y., Fang, Y., & Xiao, W. (2019). ” [Exploring the limits of transfer learning with a unified text-to-text transformer⁠(opens in a new window)](https://arxiv.org/abs/1910.10683).” In Applied Sciences.

23. 23
    Christiano, P., Shlegeris, B., & Amodei, D. (2018). ” [Supervising strong learners by amplifying weak experts⁠(opens in a new window)](https://arxiv.org/abs/1810.08575).” arXiv preprint.
&#123;% endraw %}
