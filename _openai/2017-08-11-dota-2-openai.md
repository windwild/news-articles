---
title: "Dota 2 | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/dota-2"
date: "2017-08-11"
scraped_at: "2026-03-02T10:32:05.758172087+00:00"
language: "en-US"
translated: false
description: "We’ve created a bot which beats the world’s top professionals at 1v1 matches of Dota 2 under standard tournament rules. The bot learned the game from scratch by self-play, and does not use imitati..."
tags: ["Research"]
---
{% raw %}

August 11, 2017


# Dota 2

[Rewatch live event](https://openai.com/the-international/)

![Dota 2 characters](images/dota-2-openai/img_001.jpg)



We’ve created a bot which beats the world’s top professionals at 1v1 matches of Dota 2 under standard tournament rules. The bot learned the game from scratch by self-play, and does not use imitation learning or tree search. This is a step towards building AI systems which accomplish well-defined goals in messy, complicated situations involving real humans.

![Dota Poster](images/dota-2-openai/img_002.jpg)

00:00

Today we played [Dendi⁠(opens in a new window)](http://wiki.teamliquid.net/dota2/Dendi) on mainstage at [The International⁠(opens in a new window)](http://www.dota2.com/international/overview/), winning a best-of-three match. Over the past week, our bot was undefeated against many top professionals including [SumaiL⁠(opens in a new window)](http://wiki.teamliquid.net/dota2/SumaiL) (top 1v1 player in the world) and [Arteezy⁠(opens in a new window)](http://wiki.teamliquid.net/dota2/Arteezy) (top overall player in the world).

Dota 1v1 is a complex game with hidden information. Agents must learn to plan, attack, trick, and deceive their opponents. The correlation between player skill and actions-per-minute is not strong, and in fact, our AI’s actions-per-minute are comparable to that of an average human player.

![Learned Bot Behaviors Poster](images/dota-2-openai/img_003.jpg)

00:00

Success in Dota requires players to develop intuitions about their opponents and plan accordingly. In the above video you can see that our bot has learned—entirely via self-play—to predict where other players will move, to improvise in response to unfamiliar situations, and how to influence the other player’s allied units to help it succeed.

The full game of Dota is played by two teams of five. Each player chooses from a hundred heroes and hundreds of items. Our next step is to create a team of Dota 2 bots which can compete and collaborate with the top human teams. If you’d like to work on the next phase of the project, consider [joining OpenAI⁠](https://openai.com/careers/).

- [OpenAI Five](https://openai.com/research/index/?tags=openai-five)
- [Exploration & Games](https://openai.com/research/index/?tags=exploration-game)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
{% endraw %}
