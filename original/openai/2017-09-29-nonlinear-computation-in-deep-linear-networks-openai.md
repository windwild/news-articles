---
title: "Nonlinear computation in deep linear networks | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/nonlinear-computation-in-deep-linear-networks"
date: "2017-09-29"
scraped_at: "2026-03-02T10:32:09.433515718+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

September 29, 2017


# Nonlinear computation in deep linear networks

![Nonlinear Computation In Deep Linear Networks](images/nonlinear-computation-in-deep-linear-networks-openai/img_001.webp)



We’ve shown that deep linear networks—as implemented using floating-point arithmetic—are not actually linear and can perform nonlinear computation. We used [evolution strategies⁠](https://openai.com/index/nonlinear-computation-in-linear-networks/#ES) to find parameters in linear networks that exploit this trait, letting us solve non-trivial problems.

Neural networks consist of stacks of a linear layer followed by a nonlinearity like tanh or rectified linear unit. Without the nonlinearity, consecutive linear layers would be in theory mathematically equivalent to a single linear layer. So it’s a surprise that floating point arithmetic is nonlinear enough to yield trainable deep networks.

## Background

Numbers used by computers aren’t perfect mathematical objects, but approximate representations using finite numbers of bits. Floating point numbers are commonly used by computers to represent mathematical objects. Each floating point number is represented by a combination of a fraction and an exponent. In the IEEE’s float32 standard, 23 bits are used for the fraction and 8 for the exponent, and one for the sign.

![Single-precision floating-point format](images/nonlinear-computation-in-deep-linear-networks-openai/img_002.png)

Image Credit: [Wikipedia⁠(opens in a new window)](https://en.wikipedia.org/wiki/Single-precision_floating-point_format)

As a consequence of these conventions and the binary format used, the smallest normal non-zero number (in binary) is _1.0..0 x 2^-126_, which we refer to as _min_ going forward. However, the next representable number is _1.0..01 x 2^-126_, which we can write as _min + 0.0..01 x 2^-126_. It is evident that the gap between the 2nd number is by a factor of 2^20 smaller than gap between 0 and min. In float32, when numbers are smaller than the smallest representable number they get mapped to zero. Due to this ‘underflow’, around zero all computation involving floating point numbers becomes nonlinear.

An exception to these restrictions is [denormal numbers⁠(opens in a new window)](https://en.wikipedia.org/wiki/Denormal_number), which can be disabled on some computing hardware. While the GPU and cuBLAS have denormals enabled by default, TensorFlow builds all its primitives with denormals off (with the `ftz=true` flag set). This means that any non-matrix multiply operation written in TensorFlow has an implicit non-linearity following it (provided the scale of computation is near 1e-38).

So, while in general the difference between any “mathematical” number and their normal float representation is small, around zero there is a large gap and the approximation error can be very significant.

![Image1](images/nonlinear-computation-in-deep-linear-networks-openai/img_003.png)

This can lead to some odd effects where the familiar rules of mathematics stop applying. For instance, (a+b)×c (a + b) \\times c (a+b)×c becomes unequal to a ×c+b×c \\times c + b \\times c ×c+b×c

For example if you set a=0.4×min a = 0.4 \\times min a=0.4×min, b=0.5×min b = 0.5 \\times min b=0.5×min, and c=1/min c = 1 / min c=1/ min.

Then: (a+b)×c=(0.4×min+0.5×min)×1/min=(0+0)×1/min=0 (a+b) \\times c = (0.4 \\times min + 0.5 \\times min) \\times 1 / min = (0 + 0) \\times 1 / min = 0 (a+b)×c=(0.4×min+0.5×min)×1/min=(0+0)×1/min=0.However: (a×c)+(b×c)=0.4×min/min+0.5×min×1/min=0.9 (a \\times c) + (b \\times c) = 0.4 \\times min / min + 0.5 \\times min \\times 1 / min = 0.9 (a×c)+(b×c)=0.4×min/min+0.5×min×1/min= 0.9.

In another example, we can set a=2.5×min a = 2.5 \\times min a=2.5×min, b=−1.6×min b = -1.6 \\times min b=−1.6×min, and c=1×min c = 1 \\times min c=1×min.

Then: (a+b)+c=(0)+1×min=min (a+b) + c = (0) + 1 \\times min = min (a+b)+c=(0)+1×min=min.However: (b+c)+a=(0×min)+2.5×min=2.5×min (b+c) + a = (0 \\times min) + 2.5 \\times min = 2.5 \\times min (b+c)+a=(0×min)+2.5×min=2.5×min.

At this smallest scale the fundamental addition operation has become nonlinear!

## Exploiting Nonlinearities with Evolution Strategies

We wanted to know if this inherent nonlinearity could be exploited as a computational nonlinearity, as this would let deep linear networks perform nonlinear computations. The challenge is that modern differentiation libraries are blind to these nonlinearities at the smallest scale. As such, it would be difficult or impossible to train a neural network to exploit them via backpropagation.

We can use [evolution strategies (ES)⁠(opens in a new window)](https://blog.openai.com/evolution-strategies/) to estimate gradients without having to rely on symbolic differentiation. Using ES we can indeed exploit the near-zero behavior of float32 as a computational nonlinearity. When trained on MNIST a deep linear network trained via backpropagation achieves a training accuracy of 94% and a testing accuracy of 92%. In contrast, the same linear network can achieve >99% training and 96.7% test accuracy when trained with ES and ensuring that the activations are sufficiently small to be in the nonlinear range of float32. This increase in training performance is due to ES exploiting the nonlinearities in the float32 representation. These powerful nonlinearities allow any layer to generate novel features which are nonlinear combinations of lower level features. Here is the network structure:

#### Python

`1x = tf.placeholder(dtype=tf.float32, shape=[batch_size,784])

2y = tf.placeholder(dtype=tf.float32, shape=[batch_size,10])

3

4w1 = tf.Variable(np.random.normal(scale=np.sqrt(2./784),size=[784,512]).astype(np.float32))

5b1 = tf.Variable(np.zeros(512,dtype=np.float32))

6w2 = tf.Variable(np.random.normal(scale=np.sqrt(2./512),size=[512,512]).astype(np.float32))

7b2 = tf.Variable(np.zeros(512,dtype=np.float32))

8w3 = tf.Variable(np.random.normal(scale=np.sqrt(2./512),size=[512,10]).astype(np.float32))

9b3 = tf.Variable(np.zeros(10,dtype=np.float32))

10

11params = [w1,b1,w2,b2,w3,b3]

12nr_params = sum([np.prod(p.get_shape().as_list()) for p in params])

13scaling = 2**125

14

15def get_logits(par):

16    h1 = tf.nn.bias_add(tf.matmul(x , par[0]), par[1]) / scaling

17    h2 = tf.nn.bias_add(tf.matmul(h1, par[2]) , par[3] / scaling)

18    o =   tf.nn.bias_add(tf.matmul(h2, par[4]), par[5]/ scaling)*scaling

19    return o

`

Beyond MNIST, we think other interesting experiments could be extending this work to recurrent neural networks, or to exploit nonlinear computation to improve complex machine learning tasks like language modeling and translation. We’re excited to explore this capability with our fellow researchers.

- [Software & Engineering](https://openai.com/research/index/?tags=software-engineering)