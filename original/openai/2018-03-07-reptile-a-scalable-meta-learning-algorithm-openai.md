---
title: "Reptile: A scalable meta-learning algorithm | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/reptile"
date: "2018-03-07"
scraped_at: "2026-03-02T10:31:21.186410012+00:00"
language: "en-US"
translated: false
description: "We’ve developed a simple meta-learning algorithm called Reptile which works by repeatedly sampling a task, performing stochastic gradient descent on it, and updating the initial parameters towards t..."
tags: ["Research"]
---

March 7, 2018


# Reptile: A scalable meta-learning algorithm

[Read paper(opens in a new window)](https://arxiv.org/abs/1803.02999) [View code(opens in a new window)](https://github.com/openai/supervised-reptile)

![Three simple digital outline drawings of a letter, a fish, and a triangle](images/reptile-a-scalable-meta-learning-algorithm-openai/img_001.png)



We’ve developed a simple meta-learning algorithm called Reptile which works by repeatedly sampling a task, performing stochastic gradient descent on it, and updating the initial parameters towards the final parameters learned on that task. Reptile is the application of the Shortest Descent algorithm to the meta-learning setting, and is mathematically similar to first-order MAML (which is a version of the well-known MAML algorithm) that only needs black-box access to an optimizer such as SGD or Adam, with similar computational efficiency and performance.

Meta-learning is the process of learning how to learn. A meta-learning algorithm takes in a distribution of tasks, where each task is a learning problem, and it produces a quick learner—a learner that can generalize from a small number of examples. One well-studied meta-learning problem is few-shot classification, where each task is a classification problem where the learner only sees 1–5 input-output examples from each class, and then it must classify new inputs. Below, you can try out our interactive demo of 1-shot classification, which uses Reptile.

Training Data

Draw Here

Draw Here

Draw Here

0.0%

99.5%

0.4%

Edit All

Input

Draw Here

Edit

Try clicking the “Edit All” button, drawing three distinct shapes or symbols, then drawing one of them again in the input field on the right, and see how well Reptile can classify it. The first three drawings are the labelled examples: each drawing defines one of the classes. The final drawing represents the unknown example, and Reptile outputs the probabilities of it belonging to each of the classes.

## How Reptile works

Like MAML, Reptile seeks an initialization for the parameters of a neural network, such that the network can be fine-tuned using a small amount of data from a new task. But while MAML unrolls and differentiates through the computation graph of the gradient descent algorithm, Reptile simply performs [stochastic gradient descent (SGD)⁠(opens in a new window)](https://en.wikipedia.org/wiki/Stochastic_gradient_descent) on each task in a standard way—it does not unroll a computation graph or calculate any second derivatives. This makes Reptile take less computation and memory than MAML. The pseudocode is as follows:

```
Initialize Φ \Phi Φ, the initial parameter vector
for iteration 1,2,3,…1,2,3,\dots 1,2,3,… do
  Randomly sample a task $T$
  Perform k>1 k > 1 k>1 steps of SGD on task $T$, starting with parameters Φ \Phi Φ, resulting in parameters W W W
  Update: Φ←Φ+ϵ(W−Φ) \Phi \gets \Phi + \epsilon (W-\Phi) Φ←Φ+ϵ(W−Φ)
end for
Return Φ \Phi Φ

```

As an alternative to the last step, we can treat Φ−W \\Phi - W Φ−W as a gradient and plug it into a more sophisticated optimizer like [Adam⁠(opens in a new window)](https://arxiv.org/abs/1412.6980).

It is at first surprising that this method works at all. If k=1 k=1 k=1, this algorithm would correspond to “joint training”—performing SGD on the mixture of all tasks. While joint training can learn a useful initialization in some cases, it learns very little when zero-shot learning is not possible (e.g. when the output labels are randomly permuted). Reptile requires k>1 k>1 k>1, where the update depends on the higher-order derivatives of the loss function; as we show in the paper, this behaves very differently from k=1 k=1 k=1 (joint training).

To analyze why Reptile works, we approximate the update using a [Taylor series⁠(opens in a new window)](https://en.wikipedia.org/wiki/Taylor_series). We show that the Reptile update maximizes the inner product between gradients of different minibatches from the same task, corresponding to improved generalization. This finding may have implications outside of the meta-learning setting for explaining the generalization properties of SGD. Our analysis suggests that Reptile and MAML perform a very similar update, including the same two terms with different weights.

In our experiments, we show that Reptile and MAML yield similar performance on the [Omniglot⁠(opens in a new window)](https://github.com/brendenlake/omniglot) and [Mini-ImageNet⁠(opens in a new window)](https://arxiv.org/abs/1606.04080) benchmarks for few-shot classification. Reptile also converges to the solution faster, since the update has lower variance.

Our analysis of Reptile suggests a plethora of different algorithms that we can obtain using different combinations of the SGD gradients. In the figure below, assume that we perform k steps of SGD on each task using different minibatches, yielding gradients g1,g2,…,gk g\_1, g\_2, \\dots, g\_k g1​,g2​,…,gk​. The figure below shows the learning curves on Omniglot obtained by using each sum as the meta-gradient. g2 g\_2 g2​​ corresponds to first-order MAML, an algorithm proposed in the original MAML paper. Including more gradients yields faster learning, due to variance reduction. Note that simply using g1 g\_1 g1​​ (which corresponds to k=1 k=1 k=1) yields no progress as predicted for this task since zero-shot performance cannot be improved.

![Reptile Chart](images/reptile-a-scalable-meta-learning-algorithm-openai/img_002.png)

## Implementations

Our implementation of Reptile is [available on GitHub⁠(opens in a new window)](https://github.com/openai/supervised-reptile). It uses TensorFlow for the computations involved, and includes code for replicating the experiments on Omniglot and Mini-ImageNet. We’re also releasing [a smaller JavaScript implementation⁠(opens in a new window)](https://github.com/openai/supervised-reptile/tree/master/web) that fine-tunes a model pre-trained with TensorFlow—we used this to create the above demo.

Finally, here’s a minimal example of few-shot regression, predicting a random sine wave from 10 (x,y) (x, y) (x,y) pairs. This one uses PyTorch and fits in a gist:

This file contains hidden or bidirectional Unicode text that may be interpreted or compiled differently than what appears below. To review, open the file in an editor that reveals hidden Unicode characters.
[Learn more about bidirectional Unicode characters](https://github.co/hiddenchars)

[Show hidden characters](https://openai.com/index/reptile/)

|     |     |
| --- | --- |
|  | importnumpyasnp |
|  | importtorch |
|  | fromtorchimportnn, autogradasag |
|  | importmatplotlib.pyplotasplt |
|  | fromcopyimportdeepcopy |
|  |  |
|  | seed=0 |
|  | plot=True |
|  | innerstepsize=0.02\# stepsize in inner SGD |
|  | innerepochs=1\# number of epochs of each inner SGD |
|  | outerstepsize0=0.1\# stepsize of outer optimization, i.e., meta-optimization |
|  | niterations=30000\# number of outer updates; each iteration we sample one task and update on it |
|  |  |
|  | rng=np.random.RandomState(seed) |
|  | torch.manual\_seed(seed) |
|  |  |
|  | \# Define task distribution |
|  | x\_all=np.linspace(-5, 5, 50)\[:,None\] \# All of the x points |
|  | ntrain=10\# Size of training minibatches |
|  | defgen\_task(): |
|  | "Generate classification problem" |
|  | phase=rng.uniform(low=0, high=2\*np.pi) |
|  | ampl=rng.uniform(0.1, 5) |
|  | f\_randomsine=lambdax : np.sin(x+phase) \*ampl |
|  | returnf\_randomsine |
|  |  |
|  | \# Define model. Reptile paper uses ReLU, but Tanh gives slightly better results |
|  | model=nn.Sequential( |
|  | nn.Linear(1, 64), |
|  | nn.Tanh(), |
|  | nn.Linear(64, 64), |
|  | nn.Tanh(), |
|  | nn.Linear(64, 1), |
|  | ) |
|  |  |
|  | deftotorch(x): |
|  | returnag.Variable(torch.Tensor(x)) |
|  |  |
|  | deftrain\_on\_batch(x, y): |
|  | x=totorch(x) |
|  | y=totorch(y) |
|  | model.zero\_grad() |
|  | ypred=model(x) |
|  | loss= (ypred-y).pow(2).mean() |
|  | loss.backward() |
|  | forparaminmodel.parameters(): |
|  | param.data-=innerstepsize\*param.grad.data |
|  |  |
|  | defpredict(x): |
|  | x=totorch(x) |
|  | returnmodel(x).data.numpy() |
|  |  |
|  | \# Choose a fixed task and minibatch for visualization |
|  | f\_plot=gen\_task() |
|  | xtrain\_plot=x\_all\[rng.choice(len(x\_all), size=ntrain)\] |
|  |  |
|  | \# Reptile training loop |
|  | foriterationinrange(niterations): |
|  | weights\_before=deepcopy(model.state\_dict()) |
|  | \# Generate task |
|  | f=gen\_task() |
|  | y\_all=f(x\_all) |
|  | \# Do SGD on this task |
|  | inds=rng.permutation(len(x\_all)) |
|  | for\_inrange(innerepochs): |
|  | forstartinrange(0, len(x\_all), ntrain): |
|  | mbinds=inds\[start:start+ntrain\] |
|  | train\_on\_batch(x\_all\[mbinds\], y\_all\[mbinds\]) |
|  | \# Interpolate between current weights and trained weights from this task |
|  | \# I.e. (weights\_before - weights\_after) is the meta-gradient |
|  | weights\_after=model.state\_dict() |
|  | outerstepsize=outerstepsize0\* (1-iteration/niterations) \# linear schedule |
|  | model.load\_state\_dict({name : |
|  | weights\_before\[name\] + (weights\_after\[name\] -weights\_before\[name\]) \*outerstepsize |
|  | fornameinweights\_before}) |
|  |  |
|  | \# Periodically plot the results on a particular task and minibatch |
|  | ifplotanditeration==0or (iteration+1) %1000==0: |
|  | plt.cla() |
|  | f=f\_plot |
|  | weights\_before=deepcopy(model.state\_dict()) \# save snapshot before evaluation |
|  | plt.plot(x\_all, predict(x\_all), label="pred after 0", color=(0,0,1)) |
|  | forinneriterinrange(32): |
|  | train\_on\_batch(xtrain\_plot, f(xtrain\_plot)) |
|  | if (inneriter+1) %8==0: |
|  | frac= (inneriter+1) /32 |
|  | plt.plot(x\_all, predict(x\_all), label="pred after %i"%(inneriter+1), color=(frac, 0, 1-frac)) |
|  | plt.plot(x\_all, f(x\_all), label="true", color=(0,1,0)) |
|  | lossval=np.square(predict(x\_all) -f(x\_all)).mean() |
|  | plt.plot(xtrain\_plot, f(xtrain\_plot), "x", label="train", color="k") |
|  | plt.ylim(-4,4) |
|  | plt.legend(loc="lower right") |
|  | plt.pause(0.01) |
|  | model.load\_state\_dict(weights\_before) \# restore from snapshot |
|  | print(f"-----------------------------") |
|  | print(f"iteration {iteration+1}") |
|  | print(f"loss on plotted curve {lossval:.3f}") \# would be better to average loss over a set of examples, but this is optimized for brevity |

[view raw](https://gist.github.com/joschu/f503500cda64f2ce87c8288906b09e2d/raw/28ef66e0b072cb2db6fc017d2b9e4798b5cbe311/reptile-sinewaves-demo.py) [reptile-sinewaves-demo.py](https://gist.github.com/joschu/f503500cda64f2ce87c8288906b09e2d#file-reptile-sinewaves-demo-py)
hosted with ❤ by [GitHub](https://github.com/)

Several people have pointed out to us that first-order MAML and Reptile are more closely related than MAML and Reptile. These algorithms take different perspectives on the problem, but end up computing similar updates—and specifically, Reptile’s contribution builds on the history of both Shortest Descent and avoiding second derivatives [in⁠(opens in a new window)](https://arxiv.org/abs/1606.04474) [meta⁠(opens in a new window)](https://openreview.net/pdf?id=rJY0-Kcll)- [learning⁠(opens in a new window)](https://arxiv.org/pdf/1703.03400.pdf). We’ve since updated the first paragraph to reflect this.

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
- [Language](https://openai.com/research/index/?tags=language)
- [Software & Engineering](https://openai.com/research/index/?tags=software-engineering)