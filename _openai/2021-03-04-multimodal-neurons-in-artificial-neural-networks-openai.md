---
title: "Multimodal neurons in artificial neural networks | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/multimodal-neurons"
date: "2021-03-04"
scraped_at: "2026-03-02T10:26:52.884015355+00:00"
language: "en-US"
translated: false
description: "We’ve discovered neurons in CLIP that respond to the same concept whether presented literally, symbolically, or conceptually. This may explain CLIP’s accuracy in classifying surprising visual rend..."
tags: ["Research"]
---
{% raw %}

March 4, 2021


# Multimodal neurons in artificial neural networks

[Read paper(opens in a new window)](https://distill.pub/2021/multimodal-neurons/) [(opens in a new window)](https://github.com/openai/CLIP-featurevis)

![Multimodal Neurons](images/multimodal-neurons-in-artificial-neural-networks-openai/img_001.png)



We’ve discovered neurons in CLIP that respond to the same concept whether presented literally, symbolically, or conceptually. This may explain CLIP’s accuracy in classifying surprising visual renditions of concepts, and is also an important step toward understanding the associations and biases that CLIP and similar models learn.

Fifteen years ago, Quiroga et al.[1](https://openai.com/index/multimodal-neurons/#citation-bottom-1) discovered that the human brain possesses multimodal neurons. These neurons respond to clusters of abstract concepts centered around a common high-level theme, rather than any specific visual feature. The most famous of these was the “Halle Berry” neuron, a neuron featured in both [Scientific American⁠(opens in a new window)](https://www.scientificamerican.com/article/one-face-one-neuron) and [The New York Times⁠(opens in a new window)](https://www.nytimes.com/2005/07/05/science/a-neuron-with-halle-berrys-name-on-it.html), that responds to photographs, sketches, and the text “Halle Berry” (but not other names).

Two months ago, OpenAI announced [CLIP⁠](https://openai.com/index/clip/), a general-purpose vision system that matches the performance of a ResNet-50,[2](https://openai.com/index/multimodal-neurons/#citation-bottom-2) but outperforms existing vision systems on some of the most challenging datasets. Each of these challenge datasets, _ObjectNet_, _ImageNet Rendition_, and _ImageNet Sketch_, stress tests the model’s robustness to not recognizing not just simple distortions or changes in lighting or pose, but also to complete abstraction and reconstruction—sketches, cartoons, and even statues of the objects.

Now, we’re releasing our discovery of the presence of multimodal neurons in CLIP. One such neuron, for example, is a “Spider-Man” neuron (bearing a remarkable resemblance to the “Halle Berry” neuron) that responds to an image of a spider, an image of the text “spider,” and the comic book character “Spider-Man” either in costume or illustrated.

Our discovery of multimodal neurons in CLIP gives us a clue as to what may be a common mechanism of both synthetic and natural vision systems—abstraction. We discover that the highest layers of CLIP organize images as a loose semantic collection of ideas, providing a simple explanation for both the model’s versatility and the representation’s compactness.

Biological NeuronProbed via depth electrodesHalle Berry

Clip neuronNeuron 244 from pen­ultimate layer in CLIP RN50x4Spider-Man

Previous artificial neuronNeuron 483, generic person detector from Inception v1human face

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_002.png)

Responds to photos of Halle Berry and Halle Berry in costume

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_003.png) View more

Responds to photos of Spider-Man in costume and spiders

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_004.png)

Responds to photos of human faces

Photorealistic images

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_005.png)

Responds to skeches of Halle Berry

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_006.png) View more

Responds to comics or drawings of Spider-Man and spider-themed icons

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_007.png)

Does not respond significantly to drawings of faces

Conceptual drawings

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_008.png)

Responds to the text “Halle Berry”

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_009.png) View more

Responds to the text “spider” and others

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_007.png)

Does not respond significantly to text

Images of text

Biological neurons, such as the famed Halle Berry neuron, do not fire for visual clusters of ideas, but semantic clusters. At the highest layers of CLIP, we find similar semantic invariance. Note that images are replaced by higher resolution substitutes from Quiroga et al.,1 and that the images from Quiroga et al. are themselves substitutes of the original stimuli.

Using the tools of interpretability, we give an unprecedented look into the rich visual concepts that exist within the weights of CLIP. Within CLIP, we discover high-level concepts that span a large subset of the human visual lexicon—geographical regions, facial expressions, religious iconography, famous people and more. By probing what each neuron affects downstream, we can get a glimpse into how CLIP performs its classification.

## Multimodal neurons in CLIP

Our [paper⁠(opens in a new window)](https://distill.pub/2021/multimodal-neurons/) builds on nearly a decade of research into interpreting convolutional networks,[3](https://openai.com/index/multimodal-neurons/#citation-bottom-3), [4](https://openai.com/index/multimodal-neurons/#citation-bottom-4), [5](https://openai.com/index/multimodal-neurons/#citation-bottom-5), [6](https://openai.com/index/multimodal-neurons/#citation-bottom-6), [7](https://openai.com/index/multimodal-neurons/#citation-bottom-7), [8](https://openai.com/index/multimodal-neurons/#citation-bottom-8), [9](https://openai.com/index/multimodal-neurons/#citation-bottom-9), [10](https://openai.com/index/multimodal-neurons/#citation-bottom-10), [11](https://openai.com/index/multimodal-neurons/#citation-bottom-11), [12](https://openai.com/index/multimodal-neurons/#citation-bottom-12) beginning with the observation that many of these classical techniques are directly applicable to CLIP. We employ two tools to understand the activations of the model: _feature visualization_,[6](https://openai.com/index/multimodal-neurons/#citation-bottom-6), [5](https://openai.com/index/multimodal-neurons/#citation-bottom-5), [12](https://openai.com/index/multimodal-neurons/#citation-bottom-12) which maximizes the neuron’s firing by doing gradient-based optimization on the input, and _dataset examples_,[4](https://openai.com/index/multimodal-neurons/#citation-bottom-4) which looks at the distribution of maximal activating images for a neuron from a dataset.

Using these simple techniques, we’ve found the majority of the neurons in CLIP RN50x4 (a ResNet-50 scaled up 4x using the EfficientNet scaling rule) to be readily interpretable. Indeed, these neurons appear to be extreme examples of “multi-faceted neurons,” [11](https://openai.com/index/multimodal-neurons/#citation-bottom-11) neurons that respond to multiple distinct cases, only at a higher level of abstraction.

- [By neuron](https://openai.com/index/multimodal-neurons/#)
- [By facet](https://openai.com/index/multimodal-neurons/#)

##### [summer](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/2364)

















##### [winter](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1829)

















##### [shocked](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/2478)

















##### [mid-1900s](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/2403)

















##### [self + relief](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/926)

















##### [Christmas](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/865)

















##### [Roman art](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/865)

















##### [child’s drawing](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1717)

















##### [USA](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/862)

















##### [India](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1067)

















##### [heart](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/696)

















##### [West Africa](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1257)

















##### Any










[self + relief](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/926)




[Roman art](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/865)


[child’s drawing](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1717)








[West Africa](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1257)

##### Text










[self + relief](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/926)




[Roman art](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/865)


[child’s drawing](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1717)








[West Africa](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1257)

##### Face










[self + relief](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/926)




[Roman art](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/865)


[child’s drawing](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1717)








[West Africa](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1257)

##### Logo










[self + relief](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/926)




[Roman art](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/865)


[child’s drawing](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1717)








[West Africa](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1257)

##### Architecture










[self + relief](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/926)




[Roman art](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/865)


[child’s drawing](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1717)








[West Africa](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1257)

##### Indoor










[self + relief](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/926)




[Roman art](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/865)


[child’s drawing](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1717)








[West Africa](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1257)

##### Nature










[self + relief](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/926)




[Roman art](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/865)


[child’s drawing](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1717)








[West Africa](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1257)

##### Pose










[self + relief](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/926)




[Roman art](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/865)


[child’s drawing](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1717)








[West Africa](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1257)

Selected neurons from the final layer of four CLIP models. Each neuron is represented by a feature visualization with a human-chosen concept labels to help quickly provide a sense of each neuron. Labels were picked after looking at hundreds of stimuli that activate the neuron, in addition to feature visualizations. We chose to include some of the examples here to demonstrate the model’s proclivity towards stereotypical depictions of regions, emotions, and other concepts. We also see discrepancies in the level of neuronal resolution: while certain countries like the US and India were associated with well-defined neurons, the same was not true of countries in Africa, where neurons tended to fire for entire regions. We discuss some of these biases and their implications in later sections.

Indeed, we were surprised to find many of these categories appear to mirror neurons in the medial temporal lobe documented in epilepsy patients with intracranial depth electrodes. These include neurons that respond to emotions,[17](https://openai.com/index/multimodal-neurons/#citation-bottom-17) animals,[18](https://openai.com/index/multimodal-neurons/#citation-bottom-18) and famous people.[1](https://openai.com/index/multimodal-neurons/#citation-bottom-1)

But our investigation into CLIP reveals many more such strange and wonderful abstractions, including neurons that appear to count \[ [17⁠(opens in a new window)](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/17), [202⁠(opens in a new window)](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/202), [310⁠(opens in a new window)](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/310)\], neurons responding to art styles \[ [75⁠(opens in a new window)](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/75), [587⁠(opens in a new window)](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/587), [122⁠(opens in a new window)](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/122)\], even images with evidence of digital alteration \[ [1640⁠(opens in a new window)](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1640)\].

## Absent concepts

While this analysis shows a great breadth of concepts, we note that a simple analysis on a neuron level cannot represent a complete documentation of the model’s behavior. The authors of CLIP have demonstrated, for example, that the model is capable of very precise geolocation,[19](https://openai.com/index/multimodal-neurons/#citation-bottom-19) (Appendix E.4, Figure 20) with a granularity that extends down to the level of a city and even a neighborhood. In fact, we offer an anecdote: we have noticed, by running our own personal photos through CLIP, that CLIP can often recognize if a photo was taken in San Francisco, and sometimes even the neighborhood (e.g., “Twin Peaks”).

Despite our best efforts, however, we have not found a “San Francisco” neuron, nor did it seem from attribution that San Francisco decomposes nicely into meaningful unit concepts like “California” and “city.” We believe this information to be encoded within the activations of the model somewhere, but in a more exotic way, either as a direction or as some other more complex manifold. We believe this to be a fruitful direction for further research.

## How multimodal neurons compose

These multimodal neurons can give us insight into understanding how CLIP performs classification. With a sparse linear probe,[19](https://openai.com/index/multimodal-neurons/#citation-bottom-19) we can easily inspect CLIP’s weights to see which concepts combine to achieve a final classification for ImageNet classification:

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_011.png)

piggy bank

=

2.5

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_012.png)

finance

+

1.1

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_013.png)

dolls, toys

+

...

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_014.png)

barn spider

=

2.9

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_015.png)

Spider-Man

+

1.5

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_016.png)

animal

+

...

The piggy bank class appears to be a composition of a “finance” neuron along with a porcelain neuron. The Spider-Man neuron referenced in the first section of the paper is also a spider detector, and plays an important role in the classification of the class “barn spider.”

For text classification, a key observation is that these concepts are contained within neurons in a way that, similar to the word2vec objective,[20](https://openai.com/index/multimodal-neurons/#citation-bottom-20) is _almost linear_. The concepts, therefore, form a simple algebra that behaves similarly to a linear probe. By linearizing the attention, we too can inspect any sentence, much like a linear probe, as shown below:

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_017.png)

surprised

=

1.0

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_018.png)

celebration, hug

+

1.0

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_019.png)

shock

+

0.17

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_020.png)

smile, grin

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_021.png)

intimate

=

1.0

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_022.png)

soft smile

+

0.92

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_023.png)

heart

−

0.8

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_024.png)

illness

Probing how CLIP understands words, it appears to the model that the word “surprised” implies some not just some measure of shock, but a shock of a very specific kind, one combined perhaps with delight or wonder. “Intimate” consists of a soft smile and hearts, but not sickness. We note that this reveals a reductive understanding of the the full human experience of intimacy-the subtraction of illness precludes, for example, intimate moments with loved ones who are sick. We find many such omissions when probing CLIP's understanding of language.

## Fallacies of abstraction

The degree of abstraction in CLIP surfaces a new vector of attack that we believe has not manifested in previous systems. Like many deep networks, the representations at the highest layers of the model are completely dominated by such high-level abstractions. What distinguishes CLIP, however, is a matter of degree—CLIP’s multimodal neurons generalize across the literal and the iconic, which may be a double-edged sword.

Through a series of carefully-constructed experiments, we demonstrate that we can exploit this reductive behavior to fool the model into making absurd classifications. We have observed that the excitations of the neurons in CLIP are often controllable by its response to _images of text_, providing a simple vector of attacking the model.

The finance neuron \[ [1330⁠(opens in a new window)](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1330)\], for example, responds to images of piggy banks, but also responds to the string “$$$”. By forcing the finance neuron to fire, we can fool our model into classifying a dog as a piggy bank.

Image:Standard poodleChainsawVaultHorse chestnut

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_025.png)

Standard Poodle

39.3%

Angora rabbit

16.0%

Standard Schnauzer

3.6%

Old English Sheepdog

3.3%

Komondor

2.8%

Bedlington Terrier

2.8%

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_026.png)

piggy bank

52.5%

Standard Poodle

23.8%

Miniature Poodle

2.3%

Pyrenean Mountain Dog

1.1%

military cap

0.7%

Chow Chow

0.7%

By rendering text on an image, we artificially stimulate neuron 1330, which has high weight into the class “piggy bank” in a linear probe. This causes the classifier to misclassify a Standard Poodle as a piggy bank.

## Attacks in the wild

We refer to these attacks as _typographic attacks_. We believe attacks such as those described above are far from simply an academic concern. By exploiting the model’s ability to read text robustly, we find that even _photographs of hand-written text_ can often fool the model. Like the Adversarial Patch,[21](https://openai.com/index/multimodal-neurons/#citation-bottom-21) this attack works in the wild; but unlike such attacks, it requires no more technology than pen and paper.

Image:iPodLibraryPizzaToaster

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_027.jpg)

Granny Smith

85.6%

iPod

0.4%

library

0.0%

pizza

0.0%

toaster

0.0%

dough

0.1%

![](images/multimodal-neurons-in-artificial-neural-networks-openai/img_028.jpg)

Granny Smith

0.1%

iPod

99.7%

library

0.0%

pizza

0.0%

toaster

0.0%

dough

0.0%

By rendering text on an image, we artificially stimulate neuron 1330, which has high weight into the class “piggy bank” in a linear probe. This causes the classifier to misclassify a Standard Poodle as a piggy bank.

We also believe that these attacks may also take a more subtle, less conspicuous form. An image, given to CLIP, is abstracted in many subtle and sophisticated ways, and these abstractions may over-abstract common patterns—oversimplifying and, by virtue of that, overgeneralizing.

## Bias and overgeneralization

Our model, despite being trained on a curated subset of the internet, still inherits its many unchecked biases and associations. Many associations we have discovered appear to be benign, but yet we have discovered several cases where CLIP holds associations that could result in representational harm, such as denigration of certain individuals or groups.

We have observed, for example, a “Middle East” neuron [\[1895\]⁠(opens in a new window)](https://microscope.openai.com/models/contrastive_v2/image_block_4_2_Add_6_0/1895) with an association with terrorism; and an “immigration” neuron [\[395\]⁠(opens in a new window)](https://microscope.openai.com/models/contrastive_v2/image_block_4_2_Add_6_0/395) that responds to Latin America. We have even found a neuron that fires for both dark-skinned people and gorillas \[ [1257⁠(opens in a new window)](https://microscope.openai.com/models/contrastive_4x/image_block_4_5_Add_6_0/1257)\], mirroring earlier photo tagging incidents in other models we consider unacceptable.[22](https://openai.com/index/multimodal-neurons/#citation-bottom-22)

These associations present obvious challenges to applications of such powerful visual systems.[A](https://openai.com/index/multimodal-neurons/#citation-bottom-A) Whether fine-tuned or used zero-shot, it is likely that these biases and associations will remain in the system, with their effects manifesting in both visible and nearly invisible ways during deployment. Many biased behaviors may be difficult to anticipate a priori, making their measurement and correction difficult. We believe that these tools of interpretability may aid practitioners the ability to preempt potential problems, by discovering some of these associations and ambigiuities ahead of time.

Our own understanding of CLIP is still evolving, and we are still determining if and how we would release large versions of CLIP. We hope that further community exploration of the released versions as well as the tools we are announcing today will help advance general understanding of multimodal systems, as well as inform our own decision-making.

## Conclusion

Alongside the publication of “Multimodal Neurons in Artificial Neural Networks,” we are also releasing some of the tools we have ourselves used to understand CLIP—the OpenAI [Microscope⁠(opens in a new window)](https://microscope.openai.com/) catalog has been updated with feature visualizations, dataset examples, and text feature visualizations for every neuron in CLIP RN50x4. We are also releasing the weights of CLIP [RN50x4⁠(opens in a new window)](https://github.com/openai/CLIP) and [RN101⁠(opens in a new window)](https://github.com/openai/CLIP) to further accommodate such research. We believe these investigations of CLIP only scratch the surface in understanding CLIP’s behavior, and we invite the research community to join in improving our understanding of CLIP and models like it.

- [Visit OpenAI Microscope(opens in a new window)](https://microscope.openai.com/)

- [CLIP](https://openai.com/research/index/?tags=technology-clip)
- [Generative Models](https://openai.com/research/index/?tags=generative-models)
- [Transformers](https://openai.com/research/index/?tags=transformers)
- [Language](https://openai.com/research/index/?tags=language)
- [Ethics & Safety](https://openai.com/research/index/?tags=ethics-safety)

## Footnotes

1. A
Note that the released CLIP models are intended strictly for research purposes. See the associated [model card⁠(opens in a new window)](https://github.com/openai/CLIP/blob/main/model-card.md).


## References

01. 1
    Quiroga, R. Q., Reddy, L., Kreiman, G., Koch, C., & Fried, I. (2005). [Invariant visual representation by single neurons in the human brain⁠(opens in a new window)](https://www.nature.com/articles/nature03687). _Nature, 435_(7045), 1102-1107.

02. 2
    He, K., Zhang, X., Ren, S., & Sun, J. (2016). [Deep residual learning for image recognition⁠(opens in a new window)](https://openaccess.thecvf.com/content_cvpr_2016/papers/He_Deep_Residual_Learning_CVPR_2016_paper.pdf). In _Proceedings of the IEEE conference on computer vision and pattern recognition_ (pp. 770-778).

03. 3
    Erhan, D., Bengio, Y., Courville, A., & Vincent, P. (2009). [Visualizing higher-layer features of a deep network⁠(opens in a new window)](https://www.researchgate.net/profile/Aaron_Courville/publication/265022827_Visualizing_Higher-Layer_Features_of_a_Deep_Network/links/53ff82b00cf24c81027da530.pdf). _University of Montreal, 1341_(3), 1.

04. 4
    Szegedy, C., Zaremba, W., Sutskever, I., Bruna, J., Erhan, D., Goodfellow, I., & Fergus, R. (2013). [Intriguing properties of neural networks⁠(opens in a new window)](https://arxiv.org/abs/1312.6199). _arXiv preprint arXiv:1312.6199_.

05. 5
    Mahendran, A., & Vedaldi, A. (2014). [Understanding Deep Image Representations by Inverting Them⁠(opens in a new window)](https://arxiv.org/abs/1412.0035). _arXiv preprint arXiv:1412.0035_.

06. 6
    Nguyen, A., Yosinski, J., & Clune, J. (2015). [Deep neural networks are easily fooled: High confidence predictions for unrecognizable images⁠(opens in a new window)](https://www.cv-foundation.org/openaccess/content_cvpr_2015/html/Nguyen_Deep_Neural_Networks_2015_CVPR_paper.html). In _Proceedings of the IEEE conference on computer vision and pattern recognition_ (pp. 427-436).

07. 7
    Øygard, A. (2015). [Visualizing GoogLeNet Classes⁠(opens in a new window)](https://www.auduno.com/2015/07/29/visualizing-googlenet-classes/). _Accessed in_.

08. 8
    Mordvintsev, A., Olah, C., & Tyka, M. (2015). [Inceptionism: Going deeper into neural networks⁠(opens in a new window)](https://ai.googleblog.com/2015/06/inceptionism-going-deeper-into-neural.html).

09. 9
    Nguyen, A., Dosovitskiy, A., Yosinski, J., Brox, T., & Clune, J. (2016). [Synthesizing the preferred inputs for neurons in neural networks via deep generator networks⁠(opens in a new window)](https://arxiv.org/abs/1605.09304). _arXiv preprint arXiv:1605.09304_.

10. 10
    Nguyen, A., Clune, J., Bengio, Y., Dosovitskiy, A., & Yosinski, J. (2017). [Plug & play generative networks: Conditional iterative generation of images in latent space⁠(opens in a new window)](http://openaccess.thecvf.com/content_cvpr_2017/html/Nguyen_Plug__Play_CVPR_2017_paper.html). In _Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition_ (pp. 4467-4477).

11. 11
    Nguyen, A., Yosinski, J., & Clune, J. (2016). [Multifaceted feature visualization: Uncovering the different types of features learned by each neuron in deep neural networks⁠(opens in a new window)](https://arxiv.org/abs/1602.03616). _arXiv preprint arXiv:1602.03616_.

12. 12
    Olah, C., Mordvintsev, A., & Schubert, L. (2017). [Feature visualization⁠(opens in a new window)](https://distill.pub/2017/feature-visualization). _Distill_, 2(11), e7.

13. 13
    Goh, G., et al. (2021). [Multimodal Neurons in Artificial Neural Networks⁠(opens in a new window)](https://distill.pub/2021/multimodal-neurons/#imagenet-challenge). _Distill_.

14. 14
    Miller, G. A. (1995). [WordNet: a lexical database for English⁠(opens in a new window)](https://dl.acm.org/doi/abs/10.1145/219717.219748). _Communications of the ACM_, 38(11), 39-41.

15. 15
    Crawford, K. & Paglen, T. (2019). [Excavating AI: the politics of images in machine learning training sets⁠(opens in a new window)](https://excavating.ai/). _Excavating AI_.

16. 16
    Hanna, A., Denton, E., Amironesei, R,, Smart A., Nicole, H. [Lines of Sight⁠(opens in a new window)](https://logicmag.io/commons/lines-of-sight/). _Logic Magazine_.

17. 17
    Fried, I., MacDonald, K. A., & Wilson, C. L. (1997). [Single neuron activity in human hippocampus and amygdala during recognition of faces and objects⁠(opens in a new window)](https://www.sciencedirect.com/science/article/pii/S0896627300803153). _Neuron, 18_(5), 753-765.

18. 18
    Kreiman, G., Koch, C., & Fried, I. (2000). [Category-specific visual responses of single neurons in the human medial temporal lobe⁠(opens in a new window)](https://www.nature.com/articles/nn0900_946). _Nature neuroscience, 3_(9), 946-953.

19. 19
    Radford, A., Jozefowicz, R., & Sutskever, I. (2017). [Learning to generate reviews and discovering sentiment⁠(opens in a new window)](https://arxiv.org/abs/1704.01444). _arXiv preprint arXiv:1704.01444_.

20. 20
    Mikolov, T., Chen, K., Corrado, G., & Dean, J. (2013). [Efficient estimation of word representations in vector space⁠(opens in a new window)](https://arxiv.org/abs/1301.3781). _arXiv preprint arXiv:1301.3781_.

21. 21
    Brown, T. B., Mané, D., Roy, A., Abadi, M., & Gilmer, J. (2017). [Adversarial patch⁠(opens in a new window)](https://arxiv.org/abs/1712.09665). _arXiv preprint arXiv:1712.09665_.

22. 22
    Crawford, K. & Paglen, T. (2019). [Excavating AI: the politics of images in machine learning training sets⁠(opens in a new window)](https://excavating.ai/). _Excavating AI_.
{% endraw %}
