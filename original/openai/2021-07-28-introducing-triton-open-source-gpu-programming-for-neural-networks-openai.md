---
title: "Introducing Triton: Open-source GPU programming for neural networks | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/triton"
date: "2021-07-28"
scraped_at: "2026-03-02T10:26:14.588430438+00:00"
language: "en-US"
translated: false
description: "We’re releasing Triton 1.0, an open-source Python-like programming language which enables researchers with no CUDA experience to write highly efficient GPU code—most of the time on par with what a..."
tags: ["Research"]
---

July 28, 2021


# Introducing Triton: Open-source GPU programming for neural networks

[View code(opens in a new window)](https://github.com/openai/triton) [Read documentation(opens in a new window)](https://triton-lang.org/main/index.html)

![Introducing Triton Open Source Gpu Programming For Neural Networks](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_001.webp)



We’re releasing Triton 1.0, an open-source Python-like programming language which enables researchers with no CUDA experience to write highly efficient GPU code—most of the time on par with what an expert would be able to produce.

## Why it matters

Triton makes it possible to reach peak hardware performance with relatively little effort; for example, it can be used to write FP16 matrix multiplication kernels that match the performance of cuBLAS—something that many GPU programmers can’t do—in under 25 lines of code. Our researchers have already used it to produce kernels that are up to 2x more efficient than equivalent Torch implementations, and we’re excited to work with the community to make GPU programming more accessible to everyone.

Novel research ideas in the field of Deep Learning are generally implemented using a combination of native framework operators. While convenient, this approach often requires the creation (and/or movement) of many temporary tensors, which can hurt the performance of neural networks at scale. These issues can be mitigated by writing specialized GPU kernels, but doing so can be surprisingly difficult due to the many intricacies of GPU programming.[1](https://openai.com/index/triton/#citation-bottom-1), [2](https://openai.com/index/triton/#citation-bottom-2), [3](https://openai.com/index/triton/#citation-bottom-3) And, although a variety of systems have recently emerged[4](https://openai.com/index/triton/#citation-bottom-4), [5](https://openai.com/index/triton/#citation-bottom-5) to make this process easier, we have found them to be either too verbose, lack flexibility or generate code noticeably slower than our hand-tuned baselines. This has led us to extend and improve Triton[6](https://openai.com/index/triton/#citation-bottom-6), a recent language and compiler whose original creator now works at OpenAI.

## The challenges of GPU programming

The architecture of modern GPUs can be roughly divided into three major components—DRAM, SRAM and ALUs—each of which must be considered when optimizing CUDA code:

- Memory transfers from DRAM must be _coalesced_ into large transactions to leverage the large bus width of modern memory interfaces.
- Data must be manually stashed to SRAM prior to being re-used, and managed so as to minimize shared memory bank conflicts upon retrieval.
- Computations must be partitioned and scheduled carefully, both across and within Streaming Multiprocessors (SMs), so as to promote instruction/thread-level parallelism and leverage special-purpose ALUs (e.g., tensor cores).

![GPU Architecture](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_002.svg)

Basic architecture of a GPU.

Reasoning about all these factors can be challenging, even for seasoned CUDA programmers with many years of experience. The purpose of Triton is to fully automate these optimizations, so that developers can better focus on the high-level logic of their parallel code. Triton aims to be broadly applicable, and therefore does not automatically schedule work across SMs -- leaving some important algorithmic considerations (e.g. tiling, inter-SM synchronization) to the discretion of developers.

|     |     |     |
| --- | --- | --- |
|  | **CUDA** | **TRITON** |
| Memory Coalescing | Manual | Automatic |
| Shared Memory Management | Manual | Automatic |
| Scheduling (Within SMs) | Manual | Automatic |
| Scheduling (Across SMs) | Manual | Manual |

Compiler optimizations in CUDA vs Triton.

## Programming model

Out of all the Domain Specific Languages and JIT-compilers available, Triton is perhaps most similar to Numba: kernels are defined as decorated Python functions, and launched concurrently with different `program_id`’s on a grid of so-called _instances_. However, as shown in the code snippet below, the resemblance stops there: Triton exposes intra-instance parallelism via operations on _blocks_—small arrays whose dimensions are powers of two—rather than a Single Instruction, Multiple Thread (SIMT)[7](https://openai.com/index/triton/#citation-bottom-7) execution model. In doing so, Triton effectively abstracts away all the issues related to concurrency _within_ CUDA thread blocks (e.g., memory coalescing, shared memory synchronization/conflicts, tensor core scheduling).

```mipsasm
BLOCK = 512

# This is a GPU kernel in Numba.
# Different instances of this
# function may run in parallel.
@jit
def add(X, Y, Z, N):
   # In Numba/CUDA, each kernel
   # instance itself uses an SIMT execution
   # model, where instructions are executed in
   # parallel for different values of threadIdx
   tid = threadIdx.x
   bid = blockIdx.x
   # scalar index
   idx = bid * BLOCK + tid
   if id < N:
     # There is no pointer in Numba.
     # Z,X,Y are dense tensors
     Z[idx] = X[idx] + Y[idx]

...
grid = (ceil_div(N, BLOCK),)
block = (BLOCK,)
add[grid, block](x, y, z, x.shape[0])
```

```mipsasm
BLOCK = 512

# This is a GPU kernel in Triton.
# Different instances of this
# function may run in parallel.
@jit
def add(X, Y, Z, N):
   # In Triton, each kernel instance
   # executes block operations on a
   # single thread: there is no construct
   # analogous to threadIdx
   pid = program_id(0)
   # block of indices
   idx = pid * BLOCK + arange(BLOCK)
   mask = idx < N
   # Triton uses pointer arithmetics
   # rather than indexing operators
   x = load(X + idx, mask=mask)
   y = load(Y + idx, mask=mask)
   store(Z + idx, x + y, mask=mask)

...
grid = (ceil_div(N, BLOCK),)
# no thread-block
add[grid](x, y, z, x.shape[0])
```

Vector addition in Triton.

While this may not be particularly helpful for embarrassingly parallel (i.e., element-wise) computations, it can greatly simplify the development of more complex GPU programs.

Consider for example the case of a fused softmax kernel (below) in which each instance normalizes a different row of the given input tensor _X\_∈R\_M\_×\_N_. Standard CUDA implementations of this parallelization strategy can be challenging to write, requiring explicit synchronization between threads as they concurrently reduce the same row of _X_. Most of this complexity goes away with Triton, where each kernel instance loads the row of interest and normalizes it sequentially using NumPy-like primitives.

#### Python

`1import triton

2import triton.language as tl

3

4@triton.jit

5def softmax(Y, stride_ym, stride_yn, X, stride_xm, stride_xn, M, N):

6    # row index

7    m = tl.program_id(0)

8    # col indices

9    # this specific kernel only works for matrices that

10    # have less than BLOCK_SIZE columns

11    BLOCK_SIZE = 1024

12    n = tl.arange(0, BLOCK_SIZE)

13    # the memory address of all the elements

14    # that we want to load can be computed as follows

15    X = X + m * stride_xm + n * stride_xn

16    # load input data; pad out-of-bounds elements with 0

17    x = tl.load(X, mask=n < N, other=-float('inf'))

18    # compute numerically-stable softmax

19    z = x - tl.max(x, axis=0)

20    num = tl.exp(z)

21    denom = tl.sum(num, axis=0)

22    y = num / denom

23    # write back to Y

24    Y = Y + m * stride_ym + n * stride_yn

25    tl.store(Y, y, mask=n < N)

26

27import torch

28# Allocate input/output tensors

29X = torch.normal(0, 1, size=(583, 931), device='cuda')

30Y = torch.empty_like(X)

31# SPMD launch grid

32grid = (X.shape[0], )

33# enqueue GPU kernel

34softmax[grid](Y, Y.stride(0), Y.stride(1),

35              X, X.stride(0), X.stride(1),

36              X.shape[0]    , X.shape[1])

`

Note that the Triton JIT treats X and Y as _pointers_ rather than tensors; we felt like retaining low-level control of memory accesses was important to address more complex data structures (e.g., block-sparse tensors).

Importantly, this particular implementation of softmax keeps the rows of _X_ in SRAM throughout the entire normalization process, which maximizes data reuse when applicable (~<32K columns). This differs from PyTorch’s internal CUDA code, whose use of temporary memory makes it more general but significantly slower (below). The bottom line here is not that Triton is inherently better, but that it simplifies the development of specialized kernels that can be much faster than those found in general-purpose libraries.

1,0002,0003,0004,0005,0006,0007,0008,0009,00010,00011,00012,000N05001000 GB/sTritonTorch (native)Torch (jit)

A100 performance of fused softmax for M=4096.

The lower performance of the Torch (v1.9) JIT highlights the difficulty of automatic CUDA code generation from sequences of high-level tensor operations.

#### Python

`1@torch.jit.script

2def softmax(x):

3    x_max = x.max(dim=1)[0]

4    z = x - x_max[:, None]

5    numerator = torch.exp(x)

6    denominator = numerator.sum(dim=1)

7    return numerator / denominator[:, None]

`

Fused softmax with the Torch JIT.

## Matrix multiplication

Being able to write fused kernels for element-wise operations and reductions is important, but not sufficient given the prominence of matrix multiplication tasks in neural networks. As it turns out, Triton also works very well for those, achieving peak performance with just ~25 lines of Python code. On the other hand, implementing something similar in CUDA would take [a lot more effort⁠(opens in a new window)](https://github.com/openai/blocksparse/blob/master/src/matmul_op_gpu.cu) and would even be likely to achieve lower performance.

#### Python

`1@triton.jit

2def matmul(A, B, C, M, N, K, stride_am, stride_ak,

3            stride_bk, stride_bn, stride_cm, stride_cn,

4            **META):

5    # extract metaparameters

6    BLOCK_M, GROUP_M = META['BLOCK_M'], META['GROUP_M']

7    BLOCK_N = META['BLOCK_N']

8    BLOCK_K = META['BLOCK_K']

9    # programs are grouped together to improve L2 hit rate

10    _pid_m = tl.program_id(0)

11    _pid_n = tl.program_id(1)

12    pid_m = _pid_m // GROUP_M

13    pid_n = (_pid_n * GROUP_M) + (_pid_m % GROUP_M)

14    # rm (resp. rn) denotes a range of indices

15    # for rows (resp. col) of C

16    rm = pid_m * BLOCK_M + tl.arange(0, BLOCK_M)

17    rn = pid_n * BLOCK_N + tl.arange(0, BLOCK_N)

18    # rk denotes a range of indices for columns

19    # (resp. rows) of A (resp. B)

20    rk = tl.arange(0, BLOCK_K)

21    # the memory addresses of elements in the first block of

22    # A and B can be computed using numpy-style broadcasting

23    A = A + (rm[:, None] * stride_am + rk[None, :] * stride_ak)

24    B = B + (rk [:, None] * stride_bk  + rn[None, :] * stride_bn)

25    # initialize and iteratively update accumulator

26    acc = tl.zeros((BLOCK_M, BLOCK_N), dtype=tl.float32)

27    for k in range(K, 0, -BLOCK_K):

28        a = tl.load(A)

29        b = tl.load(B)

30        # block level matrix multiplication

31        acc += tl.dot(a, b)

32        # increment pointers so that the next blocks of A and B

33        # are loaded during the next iteration

34        A += BLOCK_K * stride_ak

35        B += BLOCK_K * stride_bk

36    # fuse leaky ReLU if desired

37    # acc = tl.where(acc >= 0, acc, alpha * acc)

38    # write back result

39    C = C + (rm[:, None] * stride_cm + rn[None, :] * stride_cn)

40    mask = (rm[:, None] < M) & (rn[None, :] < N)

41    tl.store(C, acc, mask=mask)

`

Matrix multiplication in Triton.

One important advantage of handwritten matrix multiplication kernels is that they can be customized as desired to accommodate fused transformations of their inputs (e.g., slicing) and outputs (e.g., Leaky ReLU). Without a system like Triton, non-trivial modifications of matrix multiplication kernels would be out-of-reach for developers without exceptional GPU programming expertise.

5001,0001,5002,0002,5003,0003,5004,000M = N = K020406080100 TFLOPscuBLASTritonTriton + LeakyReLUcuBLAS +torch.nn.LeakyReLU

V100 tensor-core performance of matrix multiplication with appropriately tuned values for BLOCKM\_MM​​, BLOCKN\_NN​​, BLOCKK\_KK​​, GROUPM\_MM​.

## High-level system architecture

The good performance of Triton comes from a modular system architecture centered around Triton-IR, an LLVM-based intermediate representation in which multi-dimensional blocks of values are first-class citizens.

Python

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_003.svg)

Triton-IR

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_004.svg)

LLVM-IR

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_005.svg)

PTX

```python
@jit
def add(X, Y, Z, N):
   pid = program_id(0)
   idx= pid * 512 + arange(512)
   mask = idx < N
   x = load(X + idx, mask=mask)
   y = load(Y + idx, mask=mask)
   store(Z + idx, x + y, mask=mask)
```

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_006.svg)

```python
def void add(i32* X .aligned(16) , i32* Y .aligned(16) , i32* Z .aligned(16) , i32 N .multipleof(2) )
{
entry:
  %0 = get_program_id[0] i32;
  %1 = mul i32 %0, 512;
  %3 = make_range[0 : 512] i32<512>;
  %4 = splat i32<512> %1;
  %6 = add i32<512> %4, %3;
  %9 = splat i32<512> N;
  %11 = icmp_slt i1<512> %6, %9;
  %14 = splat i32*<512> X;
  %16 = getelementptr i32*<512> %14, %6;
  %19 = broadcast i1<512> %11;
  %21 = splat i32<512> undef;
  %22 = masked_load i32<512> %16, %19, %21;
  %26 = splat i32*<512> Y;
  %28 = getelementptr i32*<512> %26, %6;
  %31 = broadcast i1<512> %11;
  %33 = splat i32<512> undef;
  %34 = masked_load i32<512> %28, %31, %33;
  %38 = splat i32*<512> Z;
  %40 = getelementptr i32*<512> %38, %6;
  %43 = add i32<512> %22, %34;
  %46 = broadcast i32<512> %43;
  %48 = broadcast i1<512> %11;
  masked_store void %40, %46, %48;
  ret void;
}
```

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_006.svg)

```python
.visible .entry add(
    .param .u64 add_param_0, .param .u64 add_param_1,
    .param .u64 add_param_2, .param .u32 add_param_3
)
.maxntid 128, 1, 1
{
    .reg .pred     %p<4>;
    .reg .b32     %r<18>;
    .reg .b64     %rd<8>;
    ld.param.u64     %rd4, [add_param_0];
    ld.param.u64     %rd5, [add_param_1];
    mov.u32     %r13, %tid.x;
    ld.param.u32     %r14, [add_param_3];
    shl.b32     %r15, %r13, 2;
    mov.u32     %r16, %ctaid.x;
    mad.lo.s32     %r17, %r16, 512, %r15;
    setp.ge.s32     %p3, %r17, %r14;
    setp.lt.s32     %p1, %r17, %r14;
    mul.wide.s32     %rd7, %r17, 4;
    add.s64     %rd2, %rd4, %rd7;
    @%p1 ld.global.cg.v4.b32 {%r5,%r6,%r7,%r8}, [ %rd2 + 0];
    add.s64     %rd3, %rd5, %rd7;
    @%p1 ld.global.cg.v4.b32 {%r9,%r10,%r11,%r12}, [ %rd3 + 0];
    @%p3 bra     LBB0_2;
    ld.param.u64     %rd6, [add_param_2];
    add.s64     %rd1, %rd6, %rd7;
    add.s32     %r1, %r5, %r9;
    add.s32     %r2, %r6, %r10;
    add.s32     %r3, %r7, %r11;
    add.s32     %r4, %r8, %r12;
    st.global.v4.u32     [%rd1], {%r1, %r2, %r3, %r4};
LBB0_2:
    ret;
}
```

High-level architecture of Triton.

The `@triton.jit` decorator works by walking the Abstract Syntax Tree (AST) of the provided Python function so as to generate Triton-IR on-the-fly using a common SSA construction algorithm.[8](https://openai.com/index/triton/#citation-bottom-8) The resulting IR code is then simplified, optimized and automatically parallelized by our compiler backend, before being converted into high-quality LLVM-IR—and eventually PTX—for execution on recent NVIDIA GPUs. CPUs and AMD GPUs are not supported at the moment, but we welcome community contributions aimed at addressing this limitation.

## Compiler backend

We have found that the use of blocked program representations via Triton-IR allows our compiler to automatically perform a wide variety of important program optimizations. For example, data can be automatically stashed to shared memory by looking at the operands of computationally intensive block-level operations (e.g., `tl.dot`)—and allocated/synchronized using standard liveness analysis techniques.

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_008.svg)

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_006.svg)

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_010.svg)

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_011.svg)

The Triton compiler allocates shared memory by analyzing the live range of block variables used in computationally intensive operations.

On the other hand, Triton programs can be efficiently and automatically parallelized both (1) across SMs by executing different kernel instances concurrently, and (2) within SMs by analyzing the iteration space of each block-level operation and partitioning it adequately across different SIMD units, as shown below.

Element-wise

```apache
S1 float A[4,4] = ...
S2 float B[4,4] = ...
S3 float C[4,4] = A + B
```

FP16 matrix multiplication

```apache
S1 half A[4,2] = ...
S2 half B[2,2] = ...
S3 float C[4,2] = dot(A,B)
```

1. Definition of a Triton program _P_ composed of three statements `S1`, `S2`, `S3`

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_012.svg)

Vectorized

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_013.svg)

Tensorized

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_014.svg)

2. Iteration space of `S3`

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_012.svg)

SM

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_016.svg)

3. Mapping of `S3` onto a Stream Multiprocessor (SM)

GPU

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_017.svg)

4. Mapping of _P_ onto the GPU

Element-wise

```apache
S1 float A[4,4] = ...
S2 float B[4,4] = ...
S3 float C[4,4] = A + B
```

FP16 matrix mult.multiplication

```apache
S1 half A[4,2] = ...
S2 half B[2,2] = ...
S3 float C[4,2] = dot(A,B)
```

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_018.svg)

Vectorized

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_013.svg)

Tensorized

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_014.svg)

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_018.svg)

SM

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_022.svg)

GPU

![](images/introducing-triton-open-source-gpu-programming-for-neural-networks-openai/img_023.svg)

1. Definition of a Triton program _P_ composed of three statements `S1`, `S2`, `S3`

2. Iteration space of `S3`

3. Mapping of `S3` onto a Stream Multiprocessor (SM)

4. Mapping of _P_ onto the GPU

Automatic parallelization in Triton. Each block-level operation defines a blocked iteration space that is automatically parallelized to make use of the resources available on a Streaming Multiprocessor (SM).

## Contributing

We intend for Triton to become a community-driven project. Feel free to fork our repository on [GitHub⁠(opens in a new window)](https://github.com/openai/triton)!

_If you’re interested in joining our team and working on Triton & GPU kernels,_ [_we’re hiring_ ⁠](https://openai.com/careers/#acceleration) _!_

- [Community & Collaboration](https://openai.com/research/index/?tags=community-collaboration)
- [Software & Engineering](https://openai.com/research/index/?tags=software-engineering)

## References

1. 1
Gray, S. (2017). [SGEMM Walkthrough⁠(opens in a new window)](https://github.com/NervanaSystems/maxas/wiki/SGEMM). _URL_ [_https://github.com/NervanaSystems/maxas/wiki/SGEMM_ ⁠(opens in a new window)](https://github.com/NervanaSystems/maxas/wiki/SGEMM).

2. 2
Kerr, A. (2020). [Developing CUDA kernels to push Tensor Cores to the Absolute Limit on NVIDIA A100⁠(opens in a new window)](https://developer.nvidia.com/gtc/2020/video/s21745-vid). _URL_ [_https://developer.nvidia.com/gtc/2020/video/s21745-vid_ ⁠(opens in a new window)](https://developer.nvidia.com/gtc/2020/video/s21745-vid).

3. 3
Yan, D., Wang, W., & Chu, X. (2020, May). [Demystifying tensor cores to optimize half-precision matrix multiply⁠(opens in a new window)](https://ieeexplore.ieee.org/abstract/document/9139835/). In _2020 IEEE International Parallel and Distributed Processing Symposium (IPDPS)_. IEEE.

4. 4
[NVIDIA CUTLASS⁠(opens in a new window)](https://github.com/NVIDIA/cutlass)

5. 5
[Apache TVM⁠(opens in a new window)](https://github.com/apache/tvm)

6. 6
Tillet, P., Kung, H. T., & Cox, D. (2019, June). [Triton: an intermediate language and compiler for tiled neural network computations⁠(opens in a new window)](https://dl.acm.org/doi/abs/10.1145/3315508.3329973). In _Proceedings of the 3rd ACM SIGPLAN International Workshop on Machine Learning and Programming Languages_ (pp. 10-19).

7. 7
Lin, Y. & Grover, V. (2018). [Using CUDA Warp-Level Primitives⁠(opens in a new window)](https://developer.nvidia.com/blog/using-cuda-warp-level-primitives/). _URL_ [_https://developer.nvidia.com/blog/using-cuda-warp-level-primitives/_ ⁠(opens in a new window)](https://developer.nvidia.com/blog/using-cuda-warp-level-primitives/).

8. 8
Braun, M., Buchwald, S., Hack, S., Leißa, R., Mallon, C., & Zwinkau, A. (2013, March). [Simple and efficient construction of static single assignment form⁠(opens in a new window)](https://link.springer.com/chapter/10.1007/978-3-642-37051-9_6). In _International Conference on Compiler Construction_ (pp. 102-122). Springer, Berlin, Heidelberg.