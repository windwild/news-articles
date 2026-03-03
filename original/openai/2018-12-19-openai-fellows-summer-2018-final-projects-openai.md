---
title: "OpenAI Fellows Summer 2018: Final projects | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/openai-summer-fellows-2018"
date: "2018-12-19"
scraped_at: "2026-03-02T10:29:01.342593253+00:00"
language: "en-US"
translated: false
description: "Our first cohort of OpenAI Fellows has concluded, with each Fellow going from a machine learning beginner to core OpenAI contributor in the course of a 6-month apprenticeship."
tags: ["Company"]
---

December 19, 2018


# OpenAI Fellows Summer 2018: Final projects

Our first cohort of OpenAI Fellows has concluded, with each Fellow going from a machine learning beginner to core OpenAI contributor in the course of a 6-month apprenticeship.

![OpenAI Summer Fellows 2018](images/openai-fellows-summer-2018-final-projects-openai/img_001.jpg)



During this time, we’ve seen how expertise in other scientific fields like theoretical physics and bioengineering can yield insights to push AI research forward. All 6 Fellows have authored or contributed to papers and completed projects investigating a novel research idea while embedded in an OpenAI research team.

Research projects from our next class of Fellows are underway and we are in the process of selecting our [next cohort⁠(opens in a new window)](https://blog.openai.com/openai-fellows-interns-2019/). We’re also excited to welcome a number of our Fellows to OpenAI as full-time members of our technical staff.

## Final projects

# Karl Cobbe

### Team: Games

### Mentor: [John Schulman](http://joschu.net/)

### Social links for Karl Cobbe

[![Photo of Karl Cobbe](images/openai-fellows-summer-2018-final-projects-openai/img_002.jpg)](https://www.linkedin.com/in/kcobbe)

Previous role: Software Developer at Art of Problem Solving, Computer Science/AI undergrad at Stanford University

Interesting learning: “My previous experience in deep RL came only from personal projects. OpenAI Fellows allowed me to dive headfirst into research, providing the necessary support every step of the way. What stands out most is the phenomenal mentorship I’ve received. My mentors were always actively engaged in my work, sharing key intuitions and suggesting useful course corrections. At times I became flustered, and they helped me stay grounded. They helped me develop a better sense for which ideas to pursue and which to drop. It’s been an exciting journey, and I now feel much better prepared to face new challenges in this field.”

Final project: Created a procedurally generated game, called CoinRun, to help measure how well trained RL agents can generalize to new environments. By training and testing agents on distinct sets of generated levels, we found that agents overfit to surprisingly large training sets. We then showed how we can significantly reduce overfitting by using deeper convolutional architectures, and by using techniques common in supervised learning, including L2 regularization, dropout, data augmentation and batch normalization.

![](images/openai-fellows-summer-2018-final-projects-openai/img_003.gif)![](images/openai-fellows-summer-2018-final-projects-openai/img_004.gif)![](images/openai-fellows-summer-2018-final-projects-openai/img_005.gif)![](images/openai-fellows-summer-2018-final-projects-openai/img_006.gif)![](images/openai-fellows-summer-2018-final-projects-openai/img_007.gif)![](images/openai-fellows-summer-2018-final-projects-openai/img_008.gif)

- [Final blog post](https://blog.openai.com/quantifying-generalization-in-reinforcement-learning/)

What’s next: Joining the Games team at OpenAI, continuing to investigate generalization in RL.

# Sam McCandlish

### Team: Safety

### Mentor: [Dario Amodei](https://www.linkedin.com/in/dario-amodei-3934934)

### Social links for Sam McCandlish

[![Photo of Sam McCandlish](images/openai-fellows-summer-2018-final-projects-openai/img_009.jpg)](https://www.linkedin.com/in/sam-mccandlish)

Previous role: Theoretical Physics PhD at Stanford University, Postdoctoral Researcher at Boston University

Interesting learning: “The friendly and open culture here at OpenAI allowed me to become quickly acquainted with a wide variety of cutting-edge research by learning from the experts. I was surprised to learn that despite the rapid pace of progress in the field, there are many seemingly-basic questions about how current techniques work that have yet to be answered.”

Final project: Studied the use of large amounts of computing hardware for distributed neural network training. We found predictable patterns across a wide variety of machine learning tasks, ranging from MNIST to Dota.

### The tradeoff between experience and training time needed to achieve a given score is predictable.

- [Final blog post](https://blog.openai.com/science-of-ai/)

What’s next: Joining OpenAI’s Safety Team to continue studying the “Science of AI.”

# Yilun Du

### Team: Multiagent

### Mentor: [Karthik Narasimhan/Igor Mordatch](https://scholar.google.com/citations?user=Vzr1RukAAAAJ&hl=en)

### Social links for Yilun Du

[![Photo of Yilun Du](images/openai-fellows-summer-2018-final-projects-openai/img_010.jpg)](http://yilundu.github.io/)

Previous role: Undergrad at MIT

Interesting learning: “I found that it is important to be determined and keep pushing at an idea if you think it should work. Early on, I found a pretty nice connection between the way we were training energy based models and GAN training. Based on this connection and flexibility of models, I wanted to get the models to work, but for the next two and a half months, everything I tried got junk on CIFAR-10. Later on, just by adding a replay buffer, my samples just suddenly became fairly good.”

Final project: My first project was on exploring how to integrate dynamics knowledge into deep reinforcement learning. I explored ways to integrate and transfer dynamics information learned from videos and previous environments into new environments. I also explored and developed a new architecture for better long term physics predictions.

My second project was on exploring how to scale and stabilize training of energy based models. With these tricks, I found that energy based models generated much better samples than other state-of-the-art likelihood models. I found that energy based models exhibited good likelihoods model and are able to inpaint and restore test CIFAR-10 samples. I further found that energy based models generalized well, showing state-of-the-art out-of-distribution generalization, compositional ability, and lower long term trajectory prediction error.

- [Read paper 1](https://cdn.openai.com/openai-summer-fellows-2018/implicit-generation.pdf)
- [Read paper 2](https://cdn.openai.com/openai-summer-fellows-2018/learning-physics-priors.pdf)

What’s next: Returning to MIT to finish undergraduate studies.

# Josh Meier

### Team: Games

### Mentor: [John Schulman](http://joschu.net/)

### Social links for Josh Meier

[![Photo of Josh Meier](images/openai-fellows-summer-2018-final-projects-openai/img_011.jpg)](https://www.linkedin.com/in/joshua-meier-27a6861a)

Previous role: Chemistry & Computer Science undergrad at Harvard University

Interesting learning: “I learned that significant advancements can be made by cleverly combining various cutting-edge ideas. For example, in my project, I combined three recent OpenAI discoveries to make progress on the long-standing RL transfer problem: fine-tuning language models, scaling transformer networks, and advancing RL with PPO.”

Final project: It is well known that RL agents struggle with transferring knowledge between tasks. In my project, I discovered that pre-training neural networks to model the environment leads to increased sample efficency and better transfer across tasks. To do this, we pre-train a large generative model on unsupervised observations and then fine-tune the model on-policy using PPO.

What’s next: Moving to NYC to join Facebook AI Research.

# Johannes Otterbach

### Team: Algorithms

### Mentor: [Ilya Sutskever](https://twitter.com/ilyasut)

### Social links for Johannes Otterbach

[![Photo of Johannes Otterbach](images/openai-fellows-summer-2018-final-projects-openai/img_012.jpg)](http://jotterbach.github.io/)

Previous role: Theoretical Physics PhD, Postdoc at Harvard, Applied researcher and software engineering in a Quantum Computing startup

Interesting learning: “OpenAI Fellows allowed me to study in a structured fashion, what amazing insights go into advancing the field and the difficulty of disentangling the factors that led to the improvements. Thanks to my mentor and colleagues, I was able to quickly dive into state-of-the-art architectures of generative models and I was, at times, stunned to see how challenging it can be to even reproduce current research results. Consequently, I started to study easier datasets to build intuition and falsify/verify my expectations. The main learning, I take away from the fellowship, is that due to the complexity of the problems it is important to gain basic understanding about challenges an algorithm or approach faces -- as Feynman put it: ‘what I cannot create, I do not understand’.”

Final project: Generative models, i.e. models that learn the distribution of real-world datasets and allow the generation of new samples from this distribution, are becoming increasingly more powerful. During my project, I focused specifically on Normalizing Flow models, which approximate the data-distribution using a continuous deformation of a simpler distribution. A more visual analogue of this is a piece of play-dough that gets stretched, squeezed, bent or anything else, except that it cannot be glued to itself or torn apart. As a consequence of this properties, I was able to create and study artificial datasets that are intrinsically hard to approximate with these models. These can be used to benchmark future generations of generative models for their flexibility and expressivity.

What’s next: Joining OpenAI’s Algorithm team to continue studying generative models.

# Xingyou (Richard) Song

### Team: Games

### Mentor: [John Schulman](http://joschu.net/)

### Social links for Xingyou (Richard) Song

[![Photo of Xingyou (Richard) Song](images/openai-fellows-summer-2018-final-projects-openai/img_013.jpg)](https://www.linkedin.com/in/xingyou-song-355629a1/)

Previous role: Computer Science undergrad at UC Berkeley

Interesting learning: “When it comes to large-scale reinforcement learning and highly experimental fields, I learned that mitigating noise is key. Too often on complex datasets like Sonic would I get noisy results from which I couldn’t get a good conclusion, and eventually I got better results by either improving workflow or using less noisy environments. I also learned to trust in my theoretical intuition even in such an experimental field, which led to pretty good analysis on what was happening in overfitting in RL, through the lens of sample complexity, optimization landscapes, and other theoretical ideas. I think combining the concepts from CS theory with experimental evidence will be very valuable in the future. Also, never Git Pull someone else’s repo when it comes to research code!”

Final project: We analyze from an optimization and synthetic point of view, which types of overfitting occur in reinforcement learning. While the majority of our analysis comes from observation overfitting, we also analyzed other reasons overfitting may occur, and what happens in the optimization landscape that affect generalization gaps. We also present (with Joshua Meier and others) the performance of certain state of the art methods on Sonic The Hedgehog, including (but not limited to) generative modelling and special architectures, and why they may fail on large datasets such as Sonic.

What’s next: Joining Google Research/Brain.

## Next steps

We’d like to congratulate our Summer 2018 Fellows on their outstanding work and thank them for their contributions to OpenAI. We are excited to see what research they publish next!

As part of our effort to educate and attract more people like our class of Fellows, we recently open sourced part of their introductory curriculum. You can start your ML education today by completing our tutorial, “ [Spinning up in Deep RL⁠(opens in a new window)](https://blog.openai.com/spinning-up-in-deep-rl/).” Spinning up consists of crystal-clear examples of RL code, educational exercises, [documentation⁠(opens in a new window)](https://spinningup.openai.com/en/latest/), and tutorials that will help you become a skilled practitioner in RL.

_Applications for our 2019 Winter Fellows Cohort have closed—please stay tuned for our next call for applications later in 2019._

- [Culture & Careers](https://openai.com/news/?tags=culture-careers)
- [2018](https://openai.com/news/?tags=2018)