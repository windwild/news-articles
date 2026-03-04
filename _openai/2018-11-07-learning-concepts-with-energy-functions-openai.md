---
title: "Learning concepts with energy functions | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/learning-concepts-with-energy-functions"
date: "2018-11-07"
scraped_at: "2026-03-02T10:29:32.887356005+00:00"
language: "en-US"
translated: false
description: "We’ve developed an energy-based model that can quickly learn to identify and generate instances of concepts, such as near, above, between, closest, and furthest, expressed as sets of 2d points. Ou..."
tags: ["Research"]
---
&#123;% raw %}

November 7, 2018


# Learning concepts with energy functions

[Read paper(opens in a new window)](https://arxiv.org/abs/1811.02486) [View code(opens in a new window)](https://sites.google.com/site/energyconceptmodels/)

![Learning Concepts With Energy Functions](images/learning-concepts-with-energy-functions-openai/img_001.png)



We’ve developed an [energy-based model⁠(opens in a new window)](https://arxiv.org/abs/1708.06008) that can quickly learn to identify and generate instances of concepts, such as near, above, between, closest, and furthest, expressed as sets of 2d points. Our model learns these concepts after only five demonstrations. We also show cross-domain transfer: we use concepts learned in a 2d particle environment to solve tasks on a 3-dimensional physics-based robot.

![Visualization of energy function from an example](images/learning-concepts-with-energy-functions-openai/img_002.gif)

Many hallmarks of human intelligence, such as generalizing from limited experience, abstract reasoning and planning, analogical reasoning, creative problem solving, and capacity for language require the ability to consolidate experience into _concepts_, which act as basic building blocks of understanding and reasoning. Our technique enables agents to learn and extract concepts from tasks, then use these concepts to solve other tasks in various domains. For example, our model can use concepts learned in a two-dimensional particle environment to let it carry out the same task on a three-dimensional physics-based robotic environment— **without retraining in the new environment.**

A simulated robot trained via an energy-based model navigates its arm to be between two points, using a concept learned in a different 2D domain.

This work uses energy functions to let our agents learn to _classify_ and _generate_ simple concepts, which they can use to solve tasks like navigating between two points in dissimilar environments. Examples of concepts include visual (“red” or “square”), spatial (“inside”, “on top of”), temporal (“slow”, “after”), social (“aggressive”, “helpful”) among others. These concepts, once learned, act as basic building blocks of agent’s understanding and reasoning, as shown in other research from [DeepMind⁠(opens in a new window)](https://deepmind.com/blog/imagine-creating-new-visual-concepts-recombining-familiar-ones/) and [Vicarious⁠(opens in a new window)](https://www.vicarious.com/2018/02/07/learning-concepts-through-sensorimotor-interactions/).

![Flow diagram of point visualization undergoing generalization and identification processes](images/learning-concepts-with-energy-functions-openai/img_003.png)

Energy functions let us build systems that can generate (left) and also identify (right) basic concepts, like the notion of a square.

Energy functions work by encoding a _preference_ over states of the world, which allows an agent with different available actions (changing torque vs directly changing position) to learn a policy that works in different contexts—this roughly translates to the development of a conceptual understanding of simple things.

## How it works

To create the energy function, we mathematically represent concepts as [energy models⁠(opens in a new window)](http://yann.lecun.com/exdb/publis/pdf/lecun-06.pdf). The idea of energy models is rooted in physics, with the intuition that observed events and states represent low-energy configurations.

We define an energy function E(x, a, w) for each concept in terms of:

- The state of the world the model observes (x)
- An [attention mask⁠(opens in a new window)](http://akosiorek.github.io/ml/2017/10/14/visual-attention.html) (a) over entities in that state.
- A continuous-valued vector (w), used as conditioning, that specifies the concept for which energy is being calculated

States of the world are composed of sets of entities and their properties and positions (like the dots below, which have both positional and colored properties). Attention masks, used for “identification”, represent a model’s focus on some set of entities. The energy model outputs a single positive number indicating whether the concept is satisfied (when energy is zero) or not (when energy is high). A concept is satisfied when an attention mask is focused on a set of entities that represent a concept, which requires both that the entities are in the correct positions (modification of x, or generation) and that the right entities are being focused on (modification of a, or identification).

We construct the energy function as a neural network based on the [relational network architecture⁠(opens in a new window)](https://arxiv.org/abs/1706.01427), which allows it to take an arbitrary number of entities as input. The parameters of this energy function are what is being optimized by our training procedure; other functions are derived implicitly from the energy function.

This approach lets us use energy functions to learn a single network that can perform **both generation and recognition**. This allows us to cross-employ concepts learned from generation to identification, and vice versa. (Note: This effect is already observed in animals via [mirror neurons⁠(opens in a new window)](https://www.ncbi.nlm.nih.gov/pubmed/21227300).)

## Single network training

Our training data is composed of trajectories of (attention mask, state), which we generate ahead of time for the specific concepts we’d like our model to learn. We train our model by giving it a set of demonstrations (typically 5) for a given concept set, and then give it a new environment (X0) and ask it to predict the next state (X1) and next attention mask (a). We optimize the energy function such that the next state and next attention mask found in the training data are assigned low energy values. Similar to generative models like [variational autoencoders⁠(opens in a new window)](https://arxiv.org/abs/1606.05908), the model is incentivized to learn values that usefully compress aspects of the task. We trained our model using a variety of concepts involving, visual, spatial, proximal, and temporal relations, and quantification in a two-dimensional particle environment.

Spatial Region Concepts: given demonstration 2D points (left), energy function over point placement is inferred (middle), stochastic gradient descent over energy is then used to generate new points (right)

## Key results

We evaluated our approach across a suite of tasks designed to see how well our single system could learn to identify and generate things united by the same concept; our system can learn to classify and generate specific sets of spatial relationships, or can navigate entities through a scene in a specific way, or can develop good judgements for concepts like quantity (one, two, three, or more than three) or proximity.

Quantity Concept: demonstration attention is placed on one, two, three, or more than three entities. Inference is used to generate attention masks of similar quantity

Models perform better when they can share experience between learning to generate concepts (by moving entities within the state vector x) and identify them (by changing the attention mask over a fixed state vector): when we evaluated models trained on _both_ of these operations, they performed _better_ on each single operation than models trained only on that single operation alone. We also discovered indications of [transfer learning⁠(opens in a new window)](https://en.wikipedia.org/wiki/Transfer_learning)—an energy function trained only on a recognition context performs well on generation, even without being explicitly trained to do so.

Proximity Concepts: demonstration events bring attention to the entity closest or furthest to the marker or to bring the marker to be closest or furthest to entity of a particular color (left). Inference is used to generate attention masks for closest or further entity (recognition) or to place the marker to be closest or furthest from an entity (generation) (right)

## Next steps

In the future we’re excited to explore a wider variety of concepts learned in richer, three-dimensional environments, integrate concepts with the decision-making policies of our agents (we have so far only looked at concepts as things learned from passive experience), and explore connections between concepts and language understanding. If you are interested in this line of research, consider [working at OpenAI⁠](https://openai.com/careers/)!

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
&#123;% endraw %}
