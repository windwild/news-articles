---
title: "Fine-tuning GPT-2 from human preferences | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/fine-tuning-gpt-2"
date: "2019-09-19"
scraped_at: "2026-03-02T10:27:51.793957439+00:00"
language: "en-US"
translated: false
description: "We’ve fine-tuned the 774M parameter GPT-2 language model using human feedback for various tasks, successfully matching the preferences of the external human labelers, though those preferences did no..."
tags: ["Safety & Alignment"]
---
&#123;% raw %}

September 19, 2019


# Fine-tuning GPT‑2 from human preferences

[Read paper(opens in a new window)](https://arxiv.org/abs/1909.08593) [View code(opens in a new window)](https://github.com/openai/lm-human-preferences)

![The image shows an abstract painting with soft, blended strokes in warm tones of peach, orange, and pink, contrasted with patches of blue and yellow. The texture resembles a sky or landscape at sunset with a dreamy, impressionistic style.](images/fine-tuning-gpt-2-from-human-preferences-openai/img_001.webp)



We’ve fine-tuned the 774M parameter GPT‑2 language model using human feedback for various tasks, successfully matching the preferences of the external human labelers, though those preferences did not always match our own. Specifically, for summarization tasks the labelers preferred sentences copied wholesale from the input (we’d only asked them to ensure accuracy), so our models learned to copy. Summarization required 60k human labels; simpler tasks which continue text in various styles required only 5k. Our motivation is to move safety techniques closer to the general task of “machines talking to humans,” which we believe is key to extracting information about human values.

We believe language is a key ingredient in making reinforcement learning practical and safe for real-world tasks. [Previous⁠](https://openai.com/index/learning-from-human-preferences/) [work⁠(opens in a new window)](https://arxiv.org/abs/1811.06521) on learning models of human preferences has focused on simple simulated environments (Atari games or robotics tasks) which do not capture the complexity of language. Language is also a necessary ingredient for algorithms such as [amplification⁠](https://openai.com/index/learning-complex-goals-with-iterated-amplification/) and [debate⁠](https://openai.com/index/debate/), which target the reasoning behind preferences.

This work applies human preference learning to several natural language tasks: continuing text with positive sentiment or physically descriptive language using the [BookCorpus⁠(opens in a new window)](https://github.com/soskek/bookcorpus), and summarizing content from the [TL;DR⁠(opens in a new window)](https://www.aclweb.org/anthology/W17-4508) and [CNN/Daily Mail⁠(opens in a new window)](https://github.com/abisee/cnn-dailymail) datasets. Each of these tasks can be viewed as a text completion problem: starting with some text _X_, we ask what text _Y_ should follow.[A](https://openai.com/index/fine-tuning-gpt-2/#citation-bottom-A)

We start with a pretrained language model ( [the 774M parameter version of GPT‑2⁠](https://openai.com/index/gpt-2-6-month-follow-up/)) and fine-tune the model by asking [human labelers⁠(opens in a new window)](https://scale.ai/) which of four samples is best. Fine-tuning for the stylistic continuation tasks is sample efficient: 5,000 human samples suffice for strong performance according to humans. For summarization, models trained with 60,000 comparisons learn to copy whole sentences from the input while skipping irrelevant preamble; this copying is an easy way to ensure accurate summaries, but may exploit the fact that labelers rely on simple heuristics.

## Stylistic text continuation

For the stylistic continuation tasks, samples comparing the raw 774M GPT‑2 model and our fine-tuned versions are shown below.[B](https://openai.com/index/fine-tuning-gpt-2/#citation-bottom-B)

- [Sentiment](https://openai.com/index/fine-tuning-gpt-2/#)
- [Descriptiveness](https://openai.com/index/fine-tuning-gpt-2/#)

Given some text, generate a natural continuation of the text with **positive sentiment**:

View another sample

ContextAnd a knife. A metal knife. I don’t know if it’s important. I don’t know if any of it’s important, or even true.” Jogging up the steep steps, Loora found herself tiring and worked on keeping her breath steady as she talked.

Zero-shot baseline“But what is important is the journal and the things it’s got to say, and the things it doesn’t.

RL-fine-tuning“I’m glad you’re here. I’m glad you have the power of Voice.

According to the same human labelers used to train them, our fine-tuned models are preferred to the base GPT‑2 model (zero-shot) 88% and 86% of the time for sentiment and descriptiveness, respectively.

## Summarization

We also applied human fine-tuning to two summarization tasks: summarization of articles from the CNN/Daily Mail dataset, and summarization of Reddit snippets from the TL;DR dataset.

These tasks are harder: our main models use 60,000 four-way comparisons. We also need _online_ data collection, where the samples shown to humans are collected throughout training as the policy changes; an _offline_ data collection strategy which shows humans only samples from the base GPT‑2 language model performed poorly.

Our models achieve very good performance according to human labelers, but are likely exploiting the fact that labelers rely on simple heuristics: they prefer the lead-3 baseline of copying the first three sentences to our models. However, when combining supervised fine-tuning with human fine-tuning, our models outperform lead-3 on ROUGE scores.

Samples from zero-shot and supervised baselines, as well as RL fine-tuning of each, are shown below.

- [CNN/Daily Mail](https://openai.com/index/fine-tuning-gpt-2/#)
- [tl;dr](https://openai.com/index/fine-tuning-gpt-2/#)

View another sample

Context‘If you can find my submarine, it’s yours,’ Russian oil billionaire Roman Abramovich once said.

And it seems the oligarch and Chelsea FC owner, whose submarine is just one of the extras that came with his £300million superyacht Eclipse (perfect for getting to shore undetected), is not the only wealthy businessman splashing out on underwater exploration.

Dubbed Earth’s real ‘final frontier’, the oceans are still so little-explored that billionaires are queuing up to buy vessels that give them a glimpse of the dramatic seascapes and incredible wildlife of the world’s oceans.

So if you have a spare few million in the bank and want some holiday snaps and Instagram posts that will really trump everyone else, you may want to snap up one of these...

Whale of a time: The OrcaSub takes you 2000 feet beneath the surface in two pressurised Perspex viewing domes for optimum exploration

The OrcaSub by Spymaster

Sleek, silent and somewhat expensive, this submarine is the perfect toy for the underwater wildlife-lover.

The streamlined vessel was built with the intention of allowing explorers to come eye to eye with the creatures of the deep without scaring them off.

In light of this, the luxury vehicle is battery power to allow passengers to sail silently through the water.

Adventurers can explore up to 2,000ft below the surface at a speed of 6 knots per hour.

Pilots will be encased in pressurised spaces with Perspex domes, which give a 360 degree underwater view of everything from shipwrecks to coral reefs.

The OrcaSub does not come cheap and will set you back £1,284,169 ($1.9 million).

Whale watch! What makes the Migaloo stand out from the crowd is the ability to experience nature both above and below the water, as the vessel can be both a yacht or a submarine

At one with nature: The vehicle by Motion Code: Blue allows a diving depth of 820 feet, providing your guests with a luxury adventure

Luxury surroundings! Sail through the seas in a two-storey owner’s suite and eight VIP suites for guests

Migaloo by Motion Code: Blue

The super rich do not have to decide whether to use their yacht or their submarine, as the two double up as one with the Migaloo by Motion Code: Blue.

The 377 feet long private white yacht allows for complete privacy as you can chose whether to lounge on the sun roof above waters, or whale watch below the surface with a maximum diving depth of 820 feet (250 metres).

It also boasts a helipad, a two-storey owner’s suite with a private patio and eight VIP suites for guests.

Motion Code: Blue are yet to build one of these to order, but it is estimated to cost about $2.3 billion to construct one, if you compare it to a similar Virginia-class attack submarine by the U.S. Navy, which dives at the same sort of depths.

Sir Richard Branson enjoying a ride in the Super Falcon from DeepFlight which automatically floats to the surface for safety

The technology allows submarines to be piloted by the owner (or a designated crew member) after a short training session and do not require a highly specialised pilot. Pictured here is The Dragon

Super Falcon and Dragon by DeepFlight

If these submarines are good enough for Sir Richard Branson, they are surely good enough for us.

These personal submarines aim to be both innovative and safe, as being buoyant, they automatically float to the surface of the water.

They currently offer two DeepFlight submarines: Super Falcon and Dragon.

They are both capable of barrel rolls with dolphins, or spy-hopping out of the water like a whale.

Additionally, DeepFlight are all-electric and have zero emissions.

The Super Falcon and Dragon are priced at £1.15 million ($1.7 million) and £1 million ($1.5 million) respectively.

The Super Yacht Sub 3 offers compact private submersible sailing, and allows three passengers to explore the ocean

U-Boat Worx has developed the submarine, which is perfect for exploring underwater life up to 984 feet below the surface

Super Yacht Sub 3 by U-Boat Worx

It has a somewhat ominous name, but the U-Boat Worx design is a somewhat intimate way to explore the ocean beneath your superyacht.

The Super Yacht Sub 3 is known as the sports car of the seas and lets a pilot and two passengers plunge 984 feet (300 metres) below the surface.

Not only a luxurious trip, but the panoramic front window allows for incredible views of the fish, and aquatic life.

Costing slightly more than the average car, the all-included price is £900,000 - a snip for a billionaire.

A unforgettable night! Oliver’s Travels lets you rent out a submarine, complete with Captain, chef and butler for £175,000 a night

Ocean dining! To complete the luxury experience, a specialist aphrodisiac tasting menu has been developed to ensure that guests are in the mood to make full use of the Lovers Deep facilities, free of charge for those with a honeymoon package booking

Mile Low Club by Oliver’s Travels

For those wanting to plan a date with a difference look no further than a trip aboard Lovers’ Deep, a luxury submarine specialising in romantic getaways.

It’s the perfect underwater escape for those who can’t stretch to buying their own submarine, but can still pay big bucks for an ultra-luxurious experience.

Guests will be looked after by a crew consisted of a captain, chef and personal butler, who reside at the other end of the vessel.

The world is your oyster as the concierge service allows you to be in complete control of your adventure, so you can moor up anywhere from a stunning coral reef off the coast of St. Lucia to near a sunken battleship in the Red Sea.

With optional extras including helicopter transfers with a beach landing, free rose petal scattering service or champagne breakfast in bed, it could make an unusual romantic package.

That is if you can afford the price tag, which is a hefty £175,000 per night (excluding air travel).

The Trilobis 65 is a 65 foot long eco-yacht for six people, ideal for bays, atolls and sea parks

Best of both worlds! Whether you want to lounge on deck, or see underwater, the vessel caters for all

Trilobis 65 by Giancarlo Zema Design Group

This vessel is the water equivalent of a space ship, and is the first eco-yacht allowing guests to experience underwater life in a non-polluting habitat.

Trilobis 65 consists of four levels that are connected by a spiral staircase, including an ocean viewpoint submerged at 9 feet below the surface.

It houses six seating places, connect with high-tech software to control lighting, and get real time information on the sea-bed and fish surrounding it.

The windows are electrochemical and change their opacity manually or automatically, depending on how light it is outside.

The solar energy on top help to power the vehicle, and the electric engines are driven by hydrogen fuel cells that produce drinking water as waste material, through an electrochemical process, making the vessel a non-polluting project.

It is priced at approximately £3.6 million (€5 million) with customisation available for furnishings and décor.

Aqua adventure: The C-Explorer 3’s bowl-like interior makes you feel as though you are in an aquarium as you navigate passed fish and aquatic life

C-Explorer 3 by U-Boat Worx

Another offering by the U-Boat Worx team is the C-Explorer 3.

This boasts 360 degree panoramic viewing thanks to its acrylic hull, enabling you to feel as close to nature as possible.

The round orb gives the feeling of being in an aquarium, creating the ultimate ocean experience.

Enjoy your submersion in luxury, with a comfortable interior and viewing area.

The extra view comes at an added cost, with prices for this vessel starting from £1,450,000 (€2,000,000).

- [Zero-shot](https://openai.com/index/fine-tuning-gpt-2/#)
- [Supervised](https://openai.com/index/fine-tuning-gpt-2/#)

Zero-shot baselineThis luxury submarine is able to dive to depths of 820ft and has a cruising speed of 6 knots.

The Migaloo by Motion Code: Blue is a two-storey yacht with a cruising speed of 6 knots and is powered by a diesel engine.

The luxury superyacht is powered by a diesel engine that will give you an incredible 360 degree view of the world’s oceans.

RL fine-tuning‘If you can find my submarine, it’s yours,’ Russian oil billionaire Roman Abramovich once said.

And it seems the oligarch and Chelsea FC owner, whose submarine is just one of the extras that came with his £300million superyacht Eclipse (perfect for getting to shore undetected), is not the only wealthy businessman splashing out on underwater exploration.

The OrcaSub takes you 2000 feet beneath the surface in two pressurised Perspex viewing domes for optimum exploration

The reader may have noticed a few things about these samples. First, our RL fine-tuned model is mostly a smart copying engine: it typically summarizes content by copying entire sentences from the article or Reddit snippet. By contrast, the zero-shot and supervised fine-tuned samples are more novel:

|     |     |     |
| --- | --- | --- |
| **Model** | **CNN/Daily Mail** | **tl;dr** |
| Reference Summaries | 96.7 | 98.9 |
| Zero-shot | 91.7 | 96.3 |
| Fine-tuned | 2.5 | 29.0 |
| Supervised | 83.6 | 96.9 |
| Supervised + fine-tuned | 69.6 | 94.0 |

**Sentence novelty**: Percentage of sentences in summaries that do not appear in source text.

The RL fine-tuned model does vary where it copies from: while they copy the start of the input 28.3% and 77.6% of the time on TL;DR and CNN/Daily Mail, these numbers fall to 0.2% and 1.4% if the input starts with uninformative preamble (defined as “hi”, “hello”, “hey”, “ok”, “okay”, “so” for TL;DR, or a colon in the first three words for CNN/Daily Mail such as “Winner: Simon Wood took home the TV crown \[...\]”).

The visualization below shows where the variation in where the summarization models copy from, illustrated by the longest common subsequence of bigrams between context and summary for randomly chosen contexts.

Zero-shotFine-tunedSupervisedSupervised + fine-tuned

CNN/Daily MailContext
,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,
Summary
,


,


,


,


,

,

,

,

,

,


,


,


,


,

,

,


,

,


,


,


,


,


,


,

,


,


,


,


,

,

,

,


,

,

,

,

,

,


,

,

,


,


,

,


,

,

,


,

,

,


,


,

,


,

,

,

,


,

,


,

,

,

,

,

,


,

,


,

,

,

,

,


,


,


,

,


,


,

,


,

,


,


,

,

,

,


,


,

,

,


,

,


,
TL;DRContext
,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,

,
Summary
,


,


,


,


,


,


,


,


,


,


,


,


,

,

,


,


,


,


,


,


,


,


,


,

,


,


,


,


,


,


,

,


,


,

,


,


,


,


,


,


,


,


,


,

,


,


,

,

,


,

,

,

,

,


,

,

,


,


,


,


,


,


,

,


,


,


,


,


,


,


,


,


,

,


,

,


,


,


,


,


,


,


,


,


,


,


,


,

,

,

,

,


,


,


,


,


,

,


,


,


,


,


,


,


,


,


,

,

,


,


,


,


,


,


,


,

,

,

,


,


,


,


,


,


,


,

,

,

,

,

,


,


,


,


,


,

,


,


,


,


,


,


,


,

,

,


,


,


,


,


,


,


,


,


,

,

,


,


,


,


,


,


,

,

,


,


,


,


,

,


,

,


,


,


,

,


,


,

,


,


,

,


,


,


,


,


,


,


,


,


,


,

,

,


,


,

,

,


Selected Context


(CNN)Angelina Jolie took the stage Saturday at Nickelodeon's 28th Annual Kids' Choice Awards and delivered a message of hope to anyone who's ever felt out of place. In her first public appearance since revealing that she underwent a second preventive surgery to lower her risk of cancer, Jolie attended the show with her children, Shiloh and Zahara.  She hugged them before she went to the stage to accept the favorite villain award for her role as Maleficent in the live-action reimagining of "Sleeping Beauty." "When I was little, like Maleficent, I was told that I was different.  And I felt out of place -- too loud, too full of fire, never good at sitting still, never good at fitting in," the 39-year-old actor and humanitarian said. "And, then one day I realized something, something that I hope you all realize: Different is good," she said, prompting enthusiastic screams from the young crowd. "And, as your villain, I would also say cause a little trouble -- it's good for you." Jolie's career has been full of unconventional twists and turns, from her breakthrough role in the biopic "Gia" to her current role as an actor, filmmaker and special envoy of the U.N.'s High Commissioner for Refugees. Her personal life also has made front page headlines over the years, including her adoption of children from developing countries and her candor in discussing her health. Jolie, 39, wrote Tuesday in a New York Times essay that she had opted for the surgery after blood tests revealed markers that might have been an indication of early cancer. Two years ago, she underwent a double mastectomy for similar reasons. Jolie's mother died of ovarian cancer, and the actress has a gene mutation that makes her chances of developing breast cancer and ovarian cancer much higher than the overall population. Jolie's revelation provoked an outpouring of support as the news spread across social media. "It is not easy to make these decisions. But it is possible to take control and tackle head-on any health issue. You can seek advice, learn about the options and make choices that are right for you. Knowledge is power," she wrote. @highlight Angelina Jolie tells Kids' Choice Awards audience that she felt out of place growing up @highlight She came to accept that "different is good"

Selected Summary


Angelina Jolie took the stage Saturday at Nickelodeon's 28th Annual Kids' Choice Awards and delivered a message of hope to anyone who's ever felt out of place. In her first public appearance since revealing that she underwent a second preventive surgery to lower her risk of cancer, Jolie attended the show with her children, Shiloh and Zahara. "When I was little, like Maleficent, I was told that I was different.

Second, while summaries from GPT‑2 zero-shot and the supervised fine-tuned version of GPT‑2 are more novel as measured by n-grams or sentences, they are also more novel in terms of content. That is, they’re not true:

|     |     |     |
| --- | --- | --- |
| **Model** | **CNN/Daily Mail** | **tl;dr** |
| Zero-shot | 6/30 | 6/30 |
| Fine-tuned | 29/30 | 26/30 |
| Supervised | 19/30 | 8/30 |
| Supervised + fine-tuned | 20/30 | 11/30 |

**Summary accuracy**: Accuracy frequency of generated summaries, judged by authors on 30 articles from each dataset.

There are at least two ways of interpreting these results. The first is that copying is the easiest way to be accurate. The labelers were told to penalize inaccuracy but not copying. The zero-shot model copies some of the time, and when it copied it was accurate, so copying was reinforced. The result is a model that mostly copies, but at least does not lie.

However, this does not fully explain the results of human evaluation: both our model and a simple lead-3 baseline which copies the first three sentences are strongly preferred by the labelers to the human reference summaries in both datasets. The authors do not agree: we find the reference summaries are accurate and better capture the overall message. This reveals a mismatch between the notion of quality we wanted our model to learn, and what the humans labelers actually evaluated. Labelers want to work as quickly as possible, and they can work very quickly by following the heuristic of “if the summary copies, then select it.”

## Challenges and lessons learned

### Online data collection is hard

Online data collection was necessary to achieve the best results on summarization, but led to multiple difficulties:

1. **Software complexity**. Interleaving data gathering, reward model training, and RL fine-tuning led to a far more complex system than if each component was separate.
2. **Machine learning complexity**. An ML bug in any component would break the whole system, and it was awkward to debug one component in isolation.
3. **Quality control issues**. Online label collection required low latency between generating a sample and receiving data back from [Scale⁠(opens in a new window)](https://scale.ai/) (typically ~30 minutes). Quality control with low latency is hard, and regressions in data quality were often not detected until after training runs were complete.

We believe the right middle ground between offline and online data collection is _batched_ data collection: we would alternate between collecting large batches of data (with higher latency) and training on collected data. The cost of human data means that volume will always be low, so it is easy to retrain from scratch (or rather, from the GPT‑2 starting point) each time.

### Ambiguous tasks make labeling hard

A single human may have a clear notion of whether a given sample is separately accurate, grammatical, nonredundant, or hits the key points, but comparing two summaries often requires subjective weighing of different kinds of deficiencies. When possible, it seems better to design less ambiguous labeling tasks that get at the same information. For example, rather than asking a person to compare summaries, we could ask for a verbal description of the problems with a summary, or a suggested correction. Even if two people disagree on the most important problem, they may agree that the other picked _some_ problem, and more agreement eases data quality control and the overall experimental process.

### Bugs can optimize for bad behavior

One of our code refactors introduced a bug which flipped the sign of the reward. Flipping the reward would usually produce incoherent text, but the same bug also flipped the sign of the KL penalty. The result was a model which optimized for negative sentiment while preserving natural language. Since our instructions told humans to give very low ratings to continuations with sexually explicit text, the model quickly learned to output only content of this form. This bug was remarkable since the result was not gibberish but maximally bad output. The authors were asleep during the training process, so the problem was noticed only once training had finished. A mechanism such as Toyota’s [Andon cord⁠(opens in a new window)](https://en.wikipedia.org/wiki/Andon_(manufacturing)) could have prevented this, by allowing any labeler to stop a problematic training process.

## Looking forward

We’ve demonstrated reward learning from human preferences on two kinds of natural language tasks, stylistic continuation and summarization. Our results are mixed: for continuation we achieve good results with very few samples, but our summarization models are only “smart copiers”: they copy from the input text but skip over irrelevant preamble. The advantage of smart copying is truthfulness: the zero-shot and supervised models produce natural, plausible-looking summaries that are often lies. We believe the limiting factor in our experiments is data quality exacerbated by the online data collection setting, and plan to use batched data collection in the future.

We believe the application of reward learning to language is important both from a capability and safety perspective. On the capability side, reinforcement learning lets us correct mistakes that supervised learning would not catch, but RL with programmatic reward functions “ [can be detrimental to model quality⁠(opens in a new window)](https://arxiv.org/abs/1705.04304).” On the safety side, reward learning for language allows important criteria like “don’t lie” to be represented during training, and is a step towards scalable safety methods such as a [debate⁠](https://openai.com/index/debate/) and [amplification⁠](https://openai.com/index/amplifying-ai-training/).

- [GPT](https://openai.com/research/index/?tags=gpt)
- [Language](https://openai.com/research/index/?tags=language)
- [Generative Models](https://openai.com/research/index/?tags=generative-models)
- [Transformers](https://openai.com/research/index/?tags=transformers)

## Footnotes

1. A
For summarization, the text is the article plus the string “TL;DR:”.

2. B
Each fine-tuned model is trained using 5,000 four-way comparisons by humans.
&#123;% endraw %}
