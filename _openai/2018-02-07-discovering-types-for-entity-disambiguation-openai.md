---
render_with_liquid: false
title: "Discovering types for entity disambiguation | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/discovering-types-for-entity-disambiguation"
date: "2018-02-07"
scraped_at: "2026-03-02T10:31:09.443109062+00:00"
language: "en-US"
translated: false
description: "We’ve built a system for automatically figuring out which object is meant by a word by having a neural network decide if the word belongs to each of about 100 automatically-discovered “types” (n..."
tags: ["Research"]
---

February 7, 2018


# Discovering types for entity disambiguation

[Read paper(opens in a new window)](https://arxiv.org/abs/1802.01021) [(opens in a new window)](https://github.com/openai/deeptype)

![Artwork of a jaguar pacing on an elevated highway, the sun setting under a purple gradient sky](images/discovering-types-for-entity-disambiguation-openai/img_001.jpg)



We’ve built a system for automatically figuring out which object is meant by a word by having a neural network decide if the word belongs to each of about 100 automatically-discovered “types” (non-exclusive categories).

For example, given a sentence like “the prey saw the jaguar cross the jungle”, rather than trying to reason directly whether jaguar means the car, the animal, or something else, the system plays “20 questions” with a pre-chosen set of categories. This approach gives a big boost in state-of-the-art on several entity disambiguation datasets.

![](images/discovering-types-for-entity-disambiguation-openai/img_002.svg)![](images/discovering-types-for-entity-disambiguation-openai/img_003.svg)

The man saw a Jaguar

Jaguar Cars

0.60

jaguar

0.29

SEPECAT Jaguar

0.02

Without TypesWith Types

speed on the highway.

![](images/discovering-types-for-entity-disambiguation-openai/img_004.svg)![](images/discovering-types-for-entity-disambiguation-openai/img_005.svg)

The prey saw the jaguar

Jaguar Cars

0.60

jaguar

0.29

SEPECAT Jaguar

0.02

Without TypesWith Types

cross the jungle.

We achieve 94.88% accuracy on [CoNLL (YAGO)⁠(opens in a new window)](https://www.mpi-inf.mpg.de/departments/databases-and-information-systems/research/yago-naga/aida/) (previous state of the arts: [91.50⁠(opens in a new window)](https://arxiv.org/abs/1601.01343)%, [91.70⁠(opens in a new window)](https://research.google.com/pubs/pub45395.html)%) and 90.85% on [TAC KBP 2010 challenge⁠(opens in a new window)](https://pdfs.semanticscholar.org/b7fb/11ef06b0dcdc89ef0a5507c6c9ccea4206d8.pdf) (previous state of the arts: [87.20⁠(opens in a new window)](https://research.google.com/pubs/pub45395.html)%, and [87.70⁠(opens in a new window)](https://arxiv.org/abs/1705.02494)%). Previous methods used [distributed representations⁠(opens in a new window)](https://en.wikipedia.org/wiki/Word2vec). Types can go almost all the way on these tasks, as perfect type prediction would give accuracies of 98.6-99%.

## High-level overview

Our system uses the following steps:

1. _Extract every Wikipedia-internal link to determine, for each word, the set of conceivable entities it can refer to_. For example, when encountering the link `[jaguar](https://en.wikipedia.org/wiki/Jaguar)` in a Wikipedia page, we conclude that `https://en.wikipedia.org/wiki/Jaguar` is one of the meanings of jaguar.
2. _Walk the Wikipedia category tree (using the_ [_Wikidata_ ⁠(opens in a new window)](https://www.wikidata.org/wiki/Wikidata:Introduction) _knowledge graph) to determine, for each entity, the set of categories it belongs to_. For example, at the bottom of [Jaguar cars Wikipedia page⁠(opens in a new window)](https://en.wikipedia.org/wiki/Jaguar_Cars) are the following categories (which themselves have their own categories, such as [Automobiles⁠(opens in a new window)](https://en.wikipedia.org/wiki/Category:Automobiles)): “British brands \| Car brands \| Jaguar cars \| Jaguar vehicles.”
3. _Pick a list of ~100 categories to be your “type” system, and optimize over this choice of categories so that they compactly express any entity_. We know the mapping of entities to categories, so given a type system, we can represent each entity as a ~100-dimensional binary vector indicating membership in each category.
4. _Using every Wikipedia-internal link and its surrounding context, produce training data mapping a word plus context to the ~100-dimensional binary representation of the corresponding entity, and train a neural network to predict this mapping_. This chains together the previous steps: Wikipedia links map a word to an entity, we know the categories for each entity from step 2, and step 3 picked the categories in our type system.
5. _At test time, given a word and surrounding context, our neural network’s output can be interpreted as the probability that the word belongs to each category_. If we knew the exact set of category memberships, we would narrow down to one entity (assuming well-chosen categories). But instead, we must play a probabilistic 20 questions: use [Bayes’ theorem⁠(opens in a new window)](https://en.wikipedia.org/wiki/Bayes%27_theorem) to calculate the chance of the word disambiguating to each of its possible entities.

### More examples

Here are some other examples of our system in action:

Example **1** of **8**

The blackberry is an edible fruit produced by many species in the Rubus genus in the Rosaceae family, hybrids among these species within the Rubus subgenus, and hybrids between the Rubus and Idaeobatus subgenera.

BlackBerry

0.02

Line of wireless handheld devices and services

blackberry

0.97

Fruit of Rubus subg. Rubus

BlackBerry

0.02

Canadian telecommunication and wireless equipment company

## Cleaning the data

Wikidata’s knowledge graph can be turned into a source of training data for mapping fine-grained entities to types. We apply its [`instance of`⁠(opens in a new window)](https://www.wikidata.org/wiki/Property:P31) relation recursively to determine the set of types for any given entity — for example, any descendent node of the [human⁠(opens in a new window)](https://www.wikidata.org/wiki/Q5) node has type human. Wikipedia can also provide entity-to-type mapping through its [`category link`⁠(opens in a new window)](https://en.wikipedia.org/wiki/Help:Category).

Wikipedia-internal link statistics provide a good estimate of the chance a particular phrase refers to some entity. However, this is noisy since Wikipedia will often link to specific instance of a type rather than the type itself ( [anaphora⁠(opens in a new window)](https://en.wikipedia.org/wiki/Anaphora_(linguistics)) — e.g. king → Charles I of England) or link from a nickname ( [metonymy⁠(opens in a new window)](http://www.dictionary.com/browse/metonymy)). This results in an explosion of associated entities (e.g. king has 974 associated entities) and distorted link frequencies (e.g. queen links to the band [Queen⁠(opens in a new window)](https://en.wikipedia.org/wiki/Queen_(band)) 4920 times, [Elizabeth II⁠(opens in a new window)](https://en.wikipedia.org/wiki/Elizabeth_II) 1430 times, and [monarch⁠(opens in a new window)](https://en.wikipedia.org/wiki/Monarch) only 32 times).

The easiest approach is to [prune⁠(opens in a new window)](http://www.di.unipi.it/~ferragin/cikm2010.pdf) [rare⁠(opens in a new window)](https://www.researchgate.net/profile/Faegheh_Hasibi/publication/299394512_On_the_Reproducibility_of_the_TAGME_Entity_Linking_System/links/588fa3f192851c9794c49a71/On-the-Reproducibility-of-the-TAGME-Entity-Linking-System.pdf) [links⁠(opens in a new window)](https://transacl.org/ojs/index.php/tacl/article/viewFile/528/133), but this loses information. We instead use the Wikidata property graph to heuristically turn links into their “generic” meaning, as illustrated below.

"king"'s Anaphora and Metonymy recovery

king

1376

monarch

6289

monarch

732

King of the Romanians

258

Monarchy of Spain

155

George V

154

list of French monarchs

139

list of Portuguese monarchs

130

George King

258

monarchy

3596

William Lyon Mackenzie King

219

The King's School, Parramatta

190

Marlon King

164

King County

485

King County

623

King Records

329

King Records

329

king (chess)

256

king (chess)

256

Elle King

192

Elle King

192

Aggregation of link counts changes the defacto entity from "king" to "monarch".

Different monarchy instances are regrouped under a more general umbrella.

After this process, king goes from 974 to 14 associated entities, while the number of links from queen to [monarch⁠(opens in a new window)](https://en.wikipedia.org/wiki/Monarch) increases from 32 to 3553.

## Learning a good type system

We need to select the best type system and parameters such that disambiguation accuracy is maximized. There’s a huge number of possible sets of types, making an exact solution intractable. Instead, we use heuristic search or stochastic optimization (evolutionary algorithm) to select a type system, and gradient descent to train a type classifier to predict the behavior of the type system.

1.01.0ChanceTrue Positive RateFalse Positive Rate

The receiver operating characteristics curve (ROC) plots how increasing the number of true positives (actual events positively detected) increases with respect to the number of false positives (false alarms caused by being trigger happy). Here the curve has an AUC of 0.75.

A classifier that acts randomly will by chance have a straight line ROC curve (dashed line).

We need to select types that are discriminating (so quickly whittle down the possible set of entities), while being easy to learn (so surrounding context is informative for a neural network to infer that a type applies). We inform our search with two heuristics: learnability (average of [area under the curve⁠(opens in a new window)](http://fastml.com/what-you-wanted-to-know-about-auc/) \[AUC\] scores of a classifier trained to predict type membership), and oracle accuracy (how well we would disambiguate entities if we predicted all types perfectly).

### Type system evolution

For each possible type a different binary classifier is trained: here we decide whether a token refers to an "Animal" article.

IsAnimal?

sigmoid

FC

concat

The word vectors for a text window are concatenated so word order is preserved for the classifier.

The

jaguar

(

Panthera

onca

)

is

a

big

cat

,

a

feline

in

the

Panthera

genus

,

and

is

the

only

extant

Panthera

species

native

to

the

Americas

.

We train binary classifiers to predict membership in each of the 150,000 most common types in our dataset, given a window of context. The [area under the curve⁠(opens in a new window)](http://fastml.com/what-you-wanted-to-know-about-auc/) (AUC) of the classifier becomes the “learnability score” for that type. High AUC means it’s easy to predict this type from context; poor performance can mean we have little training data or that a word window isn’t terribly helpful (this tends to be true for unnatural categories like [ISBNs⁠(opens in a new window)](https://en.wikipedia.org/wiki/International_Standard_Book_Number)). Our full model takes several days to train, so we instead use a much smaller model as a proxy in our “learnability score”, which takes only 2.5s to train.

We can now use these learnability scores and count statistics to estimate the performance of a given subset of types as our type system. Below you can run the [Cross Entropy Method⁠(opens in a new window)](https://en.wikipedia.org/wiki/Cross-entropy_method) to discover types in your browser. Note how changing sample size and penalties affects the solution.

Start Optimization

00500.5Objective00500.5Accuracy00500.5Size

Optimization is off.100 samples will be taken at each step of optimization. More samples make the optimization more exact, but take longer.

0.00Objective J = 0.00%Oracle Accuracy ・ 1.00Learnability \- 0.00007penalty λ ・ 0solution size

To better visualize what parts of the type system design are easy and hard, we invite you to try your hand at designing your own below. After choosing a high-level domain you can start looking at ambiguous examples. The possible answers are shown as circles on the top row, and the correct answer is the colored circle (hover to see its name). The bottom row contains types you can use. Lines connecting the top to the bottom row are inheritance relations. Select the relations you want. Once you have enough relations to separate the right answer from the rest, the example is disambiguated.

Politics & BusinessScience & IndustryMiscellaneousNatureCultureSport

### Neural type system

Using the top solution from our type system optimization, we can now label data from Wikipedia using labels generated by the type system. Using this data (in our experiments, 400M tokens for each of English and French), we can now train a [bidirectional LSTM⁠(opens in a new window)](http://colah.github.io/posts/2015-08-Understanding-LSTMs/) to independently predict all the type memberships for each word. On the Wikipedia source text, we only have supervision on intra-wiki links, however this is sufficient to train a deep neural network to predict type membership with an [F1⁠(opens in a new window)](https://en.wikipedia.org/wiki/F1_score) of over 0.91.

One of our type systems, discovered by beam search, includes types such as `Aviation`, `Clothing`, and `Games` (as well as surprisingly specific ones like `1754 in Canada`—indicating 1754 was an exciting year in the dataset of 1,000 Wikipedia articles it was trained on); you can also view the [full⁠(opens in a new window)](https://cdn.openai.com/discovering-types-for-entity-disambiguation/greedy.txt) type system.

### Inference

Predicting entities in a document usually relies on a “coherence” metric between different entities, e.g., measuring how well each entity fits with each other, which is `O(N^2)` in the length of the document. Instead, our runtime is `O(N)` as we need only to look up each phrase in a trie which maps phrases to their possible meanings. We rank each of the possible entities according to the link frequency seen in Wikipedia, refined by weighting each entity by its likelihood under the type classifier. New entities can be added just by specifying their type memberships (person, animal, country of origin, time period, etc.).

## Next steps

Our approach has many differences to previous work on this problem. We’re interested in how well end-to-end learning of [distributed representations⁠(opens in a new window)](https://en.wikipedia.org/wiki/Word2vec) performs in comparison to the type-based inference we developed here. The type systems here were discovered using a small Wikipedia subset; scaling to all of Wikipedia could discover a type system with broad application. We hope you find our [code⁠(opens in a new window)](https://github.com/openai/deeptype) useful!

If you’d like to help push research like this forward, please [apply⁠](https://openai.com/careers/) to OpenAI!

- [CLIP](https://openai.com/research/index/?tags=technology-clip)
- [Language](https://openai.com/research/index/?tags=language)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
- [Reasonings & Policy](https://openai.com/research/index/?tags=reasoning-policy)

## Related articles

[View all](https://openai.com/news/publication/)

![Three farmers using a mobile app outside](images/discovering-types-for-entity-disambiguation-openai/img_006.png)

[Building agricultural database for farmers\\
\\
APIJan 12, 2024](https://openai.com/index/digital-green/)

![Wix cover image](images/discovering-types-for-entity-disambiguation-openai/img_007.png)

[Creating websites in minutes with AI Website Builder\\
\\
APIMay 29, 2025](https://openai.com/index/wix/)

![WHOOP Coach HIIT](images/discovering-types-for-entity-disambiguation-openai/img_008.png)

[Delivering LLM-powered health solutions\\
\\
APIJan 4, 2024](https://openai.com/index/whoop/)

Discovering types for entity disambiguation \| OpenAI