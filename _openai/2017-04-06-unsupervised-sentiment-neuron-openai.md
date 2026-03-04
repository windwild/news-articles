---
render_with_liquid: false
title: "Unsupervised sentiment neuron | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/unsupervised-sentiment-neuron"
date: "2017-04-06"
scraped_at: "2026-03-02T10:32:57.166573329+00:00"
language: "en-US"
translated: false
description: "We’ve developed an unsupervised system which learns an excellent representation of sentiment, despite being trained only to predict the next character in the text of Amazon reviews."
tags: ["Research"]
---

April 6, 2017


# Unsupervised sentiment neuron

We’ve developed an unsupervised system which learns an excellent representation of sentiment, despite being trained only to predict the next character in the text of Amazon reviews.

[(opens in a new window)](https://arxiv.org/abs/1704.01444) [(opens in a new window)](https://github.com/openai/generating-reviews-discovering-sentiment)

![Unsupervised Sentiment Neuron](images/unsupervised-sentiment-neuron-openai/img_001.jpg)

Illustration: Ludwig Pettersson



A [linear model⁠](https://openai.com/index/unsupervised-sentiment-neuron/#methodology) using this representation achieves state-of-the-art sentiment analysis accuracy on a small but extensively-studied dataset, the Stanford Sentiment Treebank (we get 91.8% accuracy versus the previous best of 90.2%), and can match the performance of previous supervised systems using 30-100x fewer labeled examples. Our representation also contains a distinct “ [sentiment neuron⁠](https://openai.com/index/unsupervised-sentiment-neuron/#sentimentneuron)” which contains almost all of the sentiment signal.

Our system beats other approaches on Stanford Sentiment Treebank while using dramatically less data.

![Graph of labelled training examples](images/unsupervised-sentiment-neuron-openai/img_002.png)

The number of labeled examples it takes two variants of our model (the green and blue lines) to match fully supervised approaches, each trained with 6,920 examples (the dashed gray lines). Our L1-regularized model (pretrained in an unsupervised fashion on Amazon reviews) matches \[multichannel CNN\]( [https://arxiv.org/abs/1408.5882⁠(opens in a new window)](https://arxiv.org/abs/1408.5882)) performance with only 11 labeled examples, and state-of-the-art CT-LSTM Ensembles with 232 examples.

We were very surprised that our model learned an interpretable feature, and that simply [predicting⁠(opens in a new window)](http://karpathy.github.io/2015/05/21/rnn-effectiveness/) the next character in Amazon reviews resulted in discovering the concept of sentiment. We believe the phenomenon is not specific to our model, but is instead a general property of certain large neural networks that are trained to predict the next step or dimension in their inputs.

## Methodology

We first trained a [multiplicative LSTM⁠(opens in a new window)](https://arxiv.org/abs/1609.07959) with 4,096 units on a corpus of 82 million Amazon reviews to predict the next character in a chunk of text. Training took one month across four NVIDIA Pascal GPUs, with our model processing 12,500 characters per second.

These 4,096 units (which are just a vector of floats) can be regarded as a feature vector representing the string read by the model. After training the mLSTM, we turned the model into a sentiment classifier by taking a linear combination of these units, learning the weights of the combination via the available supervised data.

## Sentiment neuron

While training the linear model with L1 regularization, we noticed it used surprisingly few of the learned units. Digging in, we realized there actually existed a single “sentiment neuron” that’s highly predictive of the sentiment value.

![Graph depicting positive and negative reviews of the value of the sentiment neuron](images/unsupervised-sentiment-neuron-openai/img_003.png)

Just like with similar models, our model can be used to generate text. Unlike those models, we have a direct dial to control the sentiment of the resulting text: we simply overwrite the value of the sentiment neuron.

|     |     |
| --- | --- |
| Sentiment fixed to positive | Sentiment fixed to negative |
| Just what I was looking for. Nice fitted pants, exactly matched seam to color contrast with other pants I own. Highly recommended and also very happy! | The package received was blank and has no barcode. A waste of time and money. |
| This product does what it is supposed to. I always keep three of these in my kitchen just in case ever I need a replacement cord. | Great little item. Hard to put on the crib without some kind of embellishment. My guess is just like the screw kind of attachment I had. |
| Best hammock ever! Stays in place and holds it’s shape. Comfy (I love the deep neon pictures on it), and looks so cute. | They didn’t fit either. Straight high sticks at the end. On par with other buds I have. Lesson learned to avoid. |
| Dixie is getting her Doolittle newsletter we’ll see another new one coming out next year. Great stuff. And, here’s the contents - information that we hardly know about or forget. | great product but no seller. couldn’t ascertain a cause. Broken product. I am a prolific consumer of this company all the time. |
| I love this weapons look . Like I said beautiful !!! I recommend it to all. Would suggest this to many roleplayers, And I stronge to get them for every one I know. A must watch for any man who love Chess! | Like the cover, Fits good. . However, an annoying rear piece like garbage should be out of this one. I bought this hoping it would help with a huge pull down my back & the black just doesn’t stay. Scrap off everytime I use it.... Very disappointed. |

Examples of synthetic text generated by the trained model. Above, we select random samples from the model after fixing the sentiment unit’s value to determine the sentiment of the review. Below, we also pass the prefix “I couldn’t figure out” through the model and select high-likelihood samples only.

|     |     |
| --- | --- |
| Sentiment fixed to positive | Sentiment fixed to negative |
| I couldn’t figure out the shape at first but it definitely does what it’s meant to do. It’s a great product and I recommend it highly | I couldn’t figure out how to use the product. It did not work.At least there was no quality control; this tablet does not work. I would have given it zero stars, but that was not an option. |
| I couldn’t figure out why this movie had been discontinued! Now I can enjoy it anytime I like. So glad to have found it again. | I couldn’t figure out how to set it up being that there was no warning on the box. I wouldn’t recommend this to anyone. |
| I couldn’t figure out how to use the video or the book that goes along with it, but it is such a fantastic book on how to put it into practice! | I couldn’t figure out how to use the gizmo. What a waste of time and money. Might as well through away this junk. |
| I couldn’t figure out how to use just one and my favorite running app. I use it all the time. Good quality, You cant beat the price. | I couldn’t figure out how to stop this drivel. At worst, it was going absolutely nowhere, no matter what I did.Needles to say, I skim-read the entire book. Don’t waste your time. |
| I couldn’t figure out how to attach these balls to my little portable drums, but these fit the bill and were well worth every penny. | I couldn’t figure out how to play it. |

## Example

The diagram below represents the character-by-character value of the sentiment neuron, displaying negative values as red and positive values as green. Note that strongly indicative words like “ _best_” or “ _horrendous_” cause particularly big shifts in the color.

![Sentiment Prediction](images/unsupervised-sentiment-neuron-openai/img_004.png)

The sentiment neuron adjusting its value on a character-by-character basis.

It’s interesting to note that the system also makes large updates after the completion of sentences and phrases. For example, in “ _And about 99.8 percent of that got lost in the film_”, there’s a negative update after “ _lost_” and a larger update at the sentence’s end, even though “ _in the film_” has no sentiment content on its own.

## Unsupervised learning

Labeled data are the fuel for today’s machine learning. Collecting data is easy, but scalably labeling that data is hard. It’s only feasible to generate labels for important problems where the reward is worth the effort, like machine translation, speech recognition, or self-driving.

Machine learning researchers have long dreamed of developing [unsupervised⁠(opens in a new window)](https://en.wikipedia.org/wiki/Word2vec) [learning⁠(opens in a new window)](https://arxiv.org/abs/1506.06726) [algorithms⁠(opens in a new window)](http://www.mitpressjournals.org/doi/pdfplus/10.1162/neco.2006.18.7.1527) [to⁠(opens in a new window)](http://www-cs.stanford.edu/~acoates/papers/coatesng_nntot2012.pdf) [learn⁠(opens in a new window)](https://arxiv.org/abs/1505.05192) a good representation of a dataset, which can then be used to solve tasks using only a few labeled examples. Our research implies that simply training large unsupervised next-step-prediction models on large amounts of data may be a good approach to use when creating systems with good representation learning capabilities.

## Next steps

Our results are a promising step towards general unsupervised representation learning. We found the results by exploring whether we could learn good quality representations as a side effect of language modeling, and scaled up an existing model on a carefully-chosen dataset. Yet the underlying phenomena remain more mysterious than clear.

- These results were not as strong for datasets of long documents. We suspect our character-level model struggles to remember information over hundreds to thousands of timesteps. We think it’s worth trying hierarchical models that can adapt the timescales at which they operate. Further scaling up these models may further improve representation fidelity and performance on sentiment analysis and similar tasks.
- The model struggles the more the input text diverges from review data. It’s worth verifying that broadening the corpus of text samples results in an equally informative representation that also applies to broader domains.
- Our results suggest that there exist settings where very large next-step-prediction models learn excellent unsupervised representations. Training a large neural network to predict the next frame in a large collection of videos may result in unsupervised representations for object, scene, and action classifiers.

Overall, it’s important to understand the properties of models, training regimes, and datasets that reliably lead to such excellent representations.

- [Generative Models](https://openai.com/research/index/?tags=generative-models)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
- [Language](https://openai.com/research/index/?tags=language)