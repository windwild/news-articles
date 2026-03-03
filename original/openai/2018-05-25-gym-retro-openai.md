---
title: "Gym Retro | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/gym-retro"
date: "2018-05-25"
scraped_at: "2026-03-02T10:30:16.498678196+00:00"
language: "en-US"
translated: false
description: "We’re releasing the full version of Gym Retro, a platform for reinforcement learning research on games. This brings our publicly-released game count from around 70 Atari games and 30 Sega games to ..."
tags: ["Research"]
---

May 25, 2018


# Gym Retro

![A colorful collage of square-dimension moving 2D video game interfaces](images/gym-retro-openai/img_001.png)



We’re releasing the full version of [Gym Retro⁠(opens in a new window)](https://github.com/openai/retro), a platform for reinforcement learning research on games. This brings our publicly-released game count from around 70 Atari games and 30 Sega games to over 1,000 games across a variety of backing emulators. We’re also releasing the tool we use to add new games to the platform.

We use Gym Retro to conduct research on RL algorithms and study generalization. Prior research in RL has mostly focused on optimizing agents to solve single tasks. With Gym Retro, we can study the ability to generalize between games with similar concepts but different appearances.

This release includes games from the Sega Genesis and Sega Master System, and Nintendo’s NES, SNES, and Game Boy consoles. It also includes preliminary support for the Sega Game Gear, Nintendo Game Boy Color, Nintendo Game Boy Advance, and NEC TurboGrafx. Some of the released game integrations, including those games in the `data/experimental` folder of Gym Retro, are in a beta state — please try them out and let us know if you encounter any bugs. Due to the large scale of the changes involved the code will only be available on a [branch⁠(opens in a new window)](https://github.com/openai/retro) for the time being. To avoid breaking contestants’ code we won’t be merging the branch until after the contest concludes.

The ongoing [Retro Contest⁠(opens in a new window)](https://contest.openai.com/) (ending in a couple weeks!) and our recent [technical report⁠(opens in a new window)](https://arxiv.org/abs/1804.03720) focus on the easier problem of generalizing between different levels of the same game (Sonic The Hedgehog™). The full Gym Retro dataset takes this idea further and makes it possible to study the harder problem of generalization between different games. The scale of the dataset and difficulty of individual games makes it a formidable challenge, and we are looking forward to sharing our research progress over the next year. We also hope that some of the solutions developed by participants in the Retro Contest can be scaled up and applied to the full Gym Retro dataset.

## Integration tool

We’re also releasing the tool we use to integrate new games. Provided you have the ROM for a game, this tool lets you easily create save states, find memory locations, and design scenarios that reinforcement learning agents can then solve. We’ve written an [integrator’s guide⁠(opens in a new window)](https://retro.readthedocs.io/en/latest/integration.html) for people looking to add support for new games.

The integration tool also supports recording and playing movie files that save all the button inputs to the game. These files are small because they only need the starting state and sequence of button presses, as opposed to storing each frame of the output. Movie files like these are useful for visualizing what your reinforcement learning agent is doing as well as storing human input to use as training data.

## Reward farming

While developing Gym Retro we’ve found numerous examples of games where the agent learns to farm for rewards (defined as the increase in game score) rather than completing the implicit mission. In the above clips, characters in _Cheese Cat-Astrophe (left)_ and _Blades of Vengeance (right)_ become trapped in infinite loops because they’re able to rapidly accrue rewards that way. This highlights a [phenomenon⁠(opens in a new window)](https://blog.openai.com/faulty-reward-functions/) we’ve discussed previously: the relatively simple reward functions we give to contemporary reinforcement learning algorithms, for instance by maximizing the score in a game, can lead to undesirable behaviors.

For games with dense (frequent and incremental) rewards where most of the difficulty comes from needing fast reaction times, reinforcement learning algorithms such as PPO do very well.

In a game such as Gradius (pictured on the right), you get points for each enemy you shoot, so it’s easy to get rewards and start learning. Surviving in a game like this is based on your ability to dodge enemies, which is no problem for reinforcement learning algorithms since they play the game one frame at a time.

For games that have a sparse reward or require planning more than a few seconds into the future, existing algorithms have a hard time. Many of the games in the Gym Retro dataset have a sparse reward or require planning, so tackling the full dataset will likely require new techniques that have not been developed yet.

If you are excited about conducting research on transfer learning and meta-learning with an unprecedentedly large dataset, then consider [joining OpenAI⁠](https://openai.com/careers/).

- [Community & Collaboration](https://openai.com/research/index/?tags=community-collaboration)
- [Exploration & Games](https://openai.com/research/index/?tags=exploration-game)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
- [Software & Engineering](https://openai.com/research/index/?tags=software-engineering)
- [Simulated Environments](https://openai.com/research/index/?tags=simulated-environments)