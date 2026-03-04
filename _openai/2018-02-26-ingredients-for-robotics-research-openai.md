---
title: "Ingredients for robotics research | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/ingredients-for-robotics-research"
date: "2018-02-26"
scraped_at: "2026-03-02T10:31:43.377597065+00:00"
language: "en-US"
translated: false
description: "We’re releasing eight simulated robotics environments and a Baselines implementation of Hindsight Experience Replay, all developed for our research over the past year. We’ve used these environment..."
tags: ["Research"]
---
{% raw %}

February 26, 2018


# Ingredients for robotics research

[View Gym environments(opens in a new window)](https://gym.openai.com/envs/#robotics) [View Baselines(opens in a new window)](https://github.com/openai/baselines) [Read paper(opens in a new window)](https://arxiv.org/abs/1802.09464)

![Ingredients For Robotics Research](images/ingredients-for-robotics-research-openai/img_001.jpg)

Ben Barry



We’re releasing eight simulated robotics environments and a Baselines implementation of Hindsight Experience Replay, all developed for our research over the past year. We’ve used these environments to train models which work on physical robots. We’re also releasing a set of requests for robotics research.

![Ingredients For Robotics Research Poster](images/ingredients-for-robotics-research-openai/img_002.jpg)

00:00

This release includes four environments using the [Fetch⁠(opens in a new window)](http://fetchrobotics.com/platforms-research-development/) research platform and four environments using the [ShadowHand⁠(opens in a new window)](https://www.shadowrobot.com/products/dexterous-hand/) robot. The manipulation tasks contained in these environments are significantly more difficult than the MuJoCo continuous control environments currently available in Gym, all of which are now easily solvable using recently released algorithms like [PPO⁠](https://openai.com/index/openai-baselines-ppo/). Furthermore, our newly released environments use models of real robots and require the agent to solve realistic tasks.

## Environments

### Fetch

![](images/ingredients-for-robotics-research-openai/img_003.png)

[FetchReach-v0](https://gym.openai.com/envs/FetchReach-v0/): Fetch has to move its end-effector to the desired goal position.

![](images/ingredients-for-robotics-research-openai/img_004.png)

[FetchReach-v0](https://gym.openai.com/envs/FetchReach-v0/): Fetch has to hit a puck across a long table such that it slides and comes to rest on the desired goal.

![](images/ingredients-for-robotics-research-openai/img_005.png)

[FetchReach-v0](https://gym.openai.com/envs/FetchReach-v0/): Fetch has to move a box by pushing it until it reaches a desired goal position.

![](images/ingredients-for-robotics-research-openai/img_006.png)

[FetchReach-v0](https://gym.openai.com/envs/FetchReach-v0/): Fetch has to pick up a box from a table using its gripper and move it to a desired goal above the table.

### ShadowHand

![](images/ingredients-for-robotics-research-openai/img_007.png)

[HandReach-v0](https://gym.openai.com/envs/HandReach-v0/): ShadowHand has to reach with its thumb and a selected finger until they meet at a desired goal position above the palm.

![](images/ingredients-for-robotics-research-openai/img_008.png)

[HandReach-v0](https://gym.openai.com/envs/HandReach-v0/): ShadowHand has to manipulate a block until it achieves a desired goal position and rotation.

![](images/ingredients-for-robotics-research-openai/img_009.png)

[HandReach-v0](https://gym.openai.com/envs/HandReach-v0/): ShadowHand has to manipulate an egg until it achieves a desired goal position and rotation.

![](images/ingredients-for-robotics-research-openai/img_010.png)

[HandReach-v0](https://gym.openai.com/envs/HandReach-v0/): ShadowHand has to manipulate a pen until it achieves a desired goal position and rotation.

This release ships with eight robotics environments for [Gym⁠(opens in a new window)](https://github.com/openai/gym) that use the [MuJoCo⁠(opens in a new window)](https://www.mujoco.org/) physics simulator. The environments are:

## Goals

All of the new tasks have the concept of a “goal”, for example the desired position of the puck in the slide task or the desired orientation of a block in the hand block manipulation task. All environments by default use a sparse reward of -1 if the desired goal was not yet achieved and 0 if it was achieved (within some tolerance). This is in contrast to the shaped rewards used in the old set of Gym continuous control problems, for example [Walker2d-v2⁠(opens in a new window)](https://github.com/openai/gym/blob/master/gym/envs/mujoco/walker2d.py) with its [shaped reward⁠(opens in a new window)](https://github.com/openai/gym/blob/master/gym/envs/mujoco/walker2d.py#L16-L18).

We also include a variant with dense rewards for each environment. However, we believe that sparse rewards are more realistic in robotics applications and we encourage everyone to use the sparse reward variant instead.

![3D diagram depicting a virtual goal](images/ingredients-for-robotics-research-openai/img_011.png)

## Hindsight Experience Replay

Alongside these new robotics environments, we’re also [releasing code⁠(opens in a new window)](https://github.com/openai/baselines) for [Hindsight Experience Replay⁠(opens in a new window)](https://arxiv.org/abs/1707.01495) (or HER for short), a reinforcement learning algorithm that can learn from failure. Our results show that HER can learn successful policies on most of the new robotics problems from only sparse rewards. Below, we also show some potential directions for future research that could further improve the performance of the HER algorithm on these tasks.

![3D diagram depicting a virtual goal versus failure](images/ingredients-for-robotics-research-openai/img_012.png)

## Understanding HER

To understand what HER does, let’s look at in the context of [FetchSlide⁠(opens in a new window)](https://gym.openai.com/envs/FetchSlide-v0), a task where we need to learn to slide a puck across the table and hit a target. Our first attempt very likely will not be a successful one. Unless we get very lucky, the next few attempts will also likely not succeed. Typical reinforcement learning algorithms would not learn anything from this experience since they just obtain a constant reward (in this case: `-1`) that does not contain any learning signal.

The key insight that HER formalizes is what humans do intuitively: Even though we have not succeeded at a specific goal, we have at least achieved a different one. So why not just pretend that we wanted to achieve this goal to begin with, instead of the one that we set out to achieve originally? By doing this substitution, the reinforcement learning algorithm can obtain a learning signal since it has achieved _some_ goal; even if it wasn’t the one that we meant to achieve originally. If we repeat this process, we will eventually learn how to achieve arbitrary goals, including the goals that we really want to achieve.

This approach lets us learn how to slide a puck across the table even though our reward is fully sparse and even though we may have never actually hit the desired goal early on. We call this technique Hindsight Experience Replay since it replays experience (a technique often used in off-policy RL algorithms like [DQN⁠](https://openai.com/index/openai-baselines-dqn/) and [DDPG⁠(opens in a new window)](https://arxiv.org/abs/1509.02971)) with goals which are chosen in hindsight, after the episode has finished. HER can therefore be combined with any off-policy RL algorithm (for example, HER can be combined with DDPG, which we write as “DDPG + HER”).

## Results

We’ve found HER to work extremely well in goal-based environments with sparse rewards. We compare DDPG + HER and vanilla DDPG on the new tasks. This comparison includes the sparse and the dense reward versions of each environment.

![Handmanipulateblockrotatexyz V0](images/ingredients-for-robotics-research-openai/img_013.png)

Median test success rate (line) with interquartile range (shaded area) for four different configurations on HandManipulateBlockRotateXYZ-v0. Data is plotted over training epochs and summarized over five different random seeds per configuration.

DDPG + HER with sparse rewards significantly outperforms all other configurations and manages to learn a successful policy on this challenging task only from sparse rewards. Interestingly, DDPG + HER with dense reward is able to learn but achieves worse performance. Vanilla DDPG mostly fails to learn in both cases. We find this trend to be generally true across most environments and we include full results in our accompanying [technical report⁠(opens in a new window)](https://arxiv.org/abs/1802.09464).

### Requests for Research: HER edition

Though HER is a promising way towards learning complex goal-based tasks with sparse rewards like the robotics environments that we propose here, there is still a lot of room for improvement. Similar to our recently published [Requests for Research 2.0⁠](https://openai.com/index/requests-for-research-2/), we have a few ideas on ways to improve HER specifically, and reinforcement learning in general.

- **Automatic hindsight goal creation**. We currently have a hard-coded strategy for selecting hindsight goals that we want to substitute. It would be interesting if this strategy could be learned instead.
- **Unbiased HER**. The goal substitution changes the distribution of experience in an unprincipled way. This bias can in theory lead to instabilities, although we do not find this to happen in practice. Still, it would be nice to derive an unbiased version of HER, for example by utilizing [importance sampling⁠(opens in a new window)](https://en.wikipedia.org/wiki/Importance_sampling).
- **HER + HRL**. It would be interesting to further combine HER with a [recent idea⁠(opens in a new window)](https://arxiv.org/abs/1712.00948) in hierarchical reinforcement learning (HRL). Instead of applying HER just to goals, it could also be applied to actions generated by a higher-level policy. For example, if the higher level asked the lower level to achieve goal A but instead goal B was achieved, we could assume that the higher level asked us to achieve goal B originally.
- **Richer value functions**. It would be interesting to extend [recent⁠(opens in a new window)](http://proceedings.mlr.press/v37/schaul15.pdf) [research⁠(opens in a new window)](https://openreview.net/forum?id=Skw0n-W0Z) and condition the value function on additional inputs like discount factor or success threshold and (maybe?) also substitute them in hindsight.
- **Faster information propagation**. Most off-policy [deep⁠(opens in a new window)](https://www.nature.com/articles/nature14236) [reinforcement⁠(opens in a new window)](https://arxiv.org/abs/1509.02971) [learning⁠(opens in a new window)](https://arxiv.org/abs/1603.00748) [algorithms⁠(opens in a new window)](https://arxiv.org/abs/1801.01290) use target networks to stabilize training. However, since changes need time to propagate, this will limit the speed of training and we have noticed in our experiments that it is often the most important factor determining the speed of DDPG+HER learning. It would be interesting to investigate other means of stabilizing training that do not incur such a slowdown.
- **HER + multi-step returns**. The experience used in HER is extremely off-policy since we substitute goals. This makes it hard to use it with [multi-step returns⁠(opens in a new window)](https://arxiv.org/pdf/1703.01327.pdf). However, multi-step returns are desirable since they allow much faster propagation of information about the returns.
- **On-policy HER**. Currently, HER can only be used with off-policy algorithms since we substitute goals, making the experience extremely off-policy. However, recent state of the art algorithms like [PPO⁠(opens in a new window)](https://arxiv.org/abs/1707.06347) exhibit very attractive stability traits. It would be interesting to investigate whether HER can be combined with such on-policy algorithms, for example by [importance sampling⁠(opens in a new window)](https://en.wikipedia.org/wiki/Importance_sampling). There are already some [preliminary results⁠(opens in a new window)](https://arxiv.org/abs/1711.06006) in this direction.
- **RL with very frequent actions**. Current RL algorithms are very sensitive to the frequency of taking actions which is why frame skip technique is usually used on Atari. In continuous control domains, the performance goes to zero as the frequency of taking actions goes to infinity, which is caused by two factors: inconsistent exploration and the necessity to bootstrap more times to propagate information about returns backward in time. How to design a sample-efficient RL algorithm which can retain its performance even when the frequency of taking actions goes to infinity?
- **Combine HER with recent advances in RL**. There is a vast body of recent research that improves different aspects of RL. As a start, HER could be combined with [Prioritized Experience Replay⁠(opens in a new window)](https://arxiv.org/abs/1511.05952), [distributional RL⁠(opens in a new window)](https://arxiv.org/abs/1707.06887), [entropy-regularized RL⁠(opens in a new window)](https://arxiv.org/abs/1704.06440), or [reverse curriculum generation⁠(opens in a new window)](https://arxiv.org/abs/1707.05300).

You can find additional additional information and references on these proposals and on the on the new Gym environments in our accompanying [technical report⁠(opens in a new window)](https://arxiv.org/abs/1802.09464).

## Using goal-based environments

Introducing the notion of a “goal” requires a few backwards-compatible changes to the [existing Gym API⁠(opens in a new window)](https://gym.openai.com/docs):

- All goal-based environments use a `gym.spaces.Dict` observation space. Environments are expected to include a desired goal, which the agent should attempt to achieve (`desired_goal`), the goal that it has currently achieved instead (`achieved_goal`), and the actual observation (`observation`), e.g. the state of the robot.
- We expose the reward function of an environment and thus allow to re-compute a reward with changed goals. This allows for HER-style algorithms, which substitute goals.

Here is a simple example that interacts with the one of the new goal-based environments and performs goal substitution:

This file contains hidden or bidirectional Unicode text that may be interpreted or compiled differently than what appears below. To review, open the file in an editor that reveals hidden Unicode characters.
[Learn more about bidirectional Unicode characters](https://github.co/hiddenchars)

[Show hidden characters](https://openai.com/index/ingredients-for-robotics-research/)

|     |     |
| --- | --- |
|  | importnumpyasnp |
|  | importgym |
|  |  |
|  |  |
|  | env=gym.make('FetchReach-v0') |
|  | obs=env.reset() |
|  | done=False |
|  |  |
|  | defpolicy(observation, desired\_goal): |
|  | \# Here you would implement your smarter policy. In this case, |
|  | \# we just sample random actions. |
|  | returnenv.action\_space.sample() |
|  |  |
|  | whilenotdone: |
|  | action=policy(obs\['observation'\], obs\['desired\_goal'\]) |
|  | obs, reward, done, info=env.step(action) |
|  |  |
|  | \# If we want, we can substitute a goal here and re-compute |
|  | \# the reward. For instance, we can just pretend that the desired |
|  | \# goal was what we achieved all along. |
|  | substitute\_goal=obs\['achieved\_goal'\].copy() |
|  | substitute\_reward=env.compute\_reward( |
|  | obs\['achieved\_goal'\], substitute\_goal, info) |
|  | print('reward is {}, substitute\_reward is {}'.format( |
|  | reward, substitute\_reward)) |

[view raw](https://gist.github.com/matthiasplappert/7860effd77d533e54797b4bdc277b4cb/raw/7bf6e3e7e7a7d9a0a4ff7a0fc23d9080888cf49e/example.py) [example.py](https://gist.github.com/matthiasplappert/7860effd77d533e54797b4bdc277b4cb#file-example-py)
hosted with ❤ by [GitHub](https://github.com/)

The new goal-based environments can be used with existing Gym-compatible reinforcement learning algorithms, such as [Baselines⁠(opens in a new window)](https://github.com/openai/baselines). Use `gym.wrappers.FlattenDictWrapper` to flatten the dict-based observation space into an array:

This file contains hidden or bidirectional Unicode text that may be interpreted or compiled differently than what appears below. To review, open the file in an editor that reveals hidden Unicode characters.
[Learn more about bidirectional Unicode characters](https://github.co/hiddenchars)

[Show hidden characters](https://openai.com/index/ingredients-for-robotics-research/)

|     |     |
| --- | --- |
|  | importnumpyasnp |
|  | importgym |
|  |  |
|  |  |
|  | env=gym.make('FetchReach-v0') |
|  |  |
|  | \# Simply wrap the goal-based environment using FlattenDictWrapper |
|  | \# and specify the keys that you would like to use. |
|  | env=gym.wrappers.FlattenDictWrapper( |
|  | env, dict\_keys=\['observation', 'desired\_goal'\]) |
|  |  |
|  | \# From now on, you can use the wrapper env as per usual: |
|  | ob=env.reset() |
|  | print(ob.shape) \# is now just an np.array |

[view raw](https://gist.github.com/matthiasplappert/1e4860600275efd00b9b80bcc4a4e2bc/raw/e9f703914af2e9c40a61747fa3bdff90a6741646/example.py) [example.py](https://gist.github.com/matthiasplappert/1e4860600275efd00b9b80bcc4a4e2bc#file-example-py)
hosted with ❤ by [GitHub](https://github.com/)

- [Dactyl](https://openai.com/research/index/?tags=dactyl)
- [Robotics](https://openai.com/research/index/?tags=robotics)
- [Simulated Environments](https://openai.com/research/index/?tags=simulated-environments)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
- [Exploration & Games](https://openai.com/research/index/?tags=exploration-game)
{% endraw %}
