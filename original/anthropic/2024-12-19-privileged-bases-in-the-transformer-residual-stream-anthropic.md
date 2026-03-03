---
title: "Privileged Bases in the Transformer Residual Stream \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/privileged-bases-in-the-transformer-residual-stream"
date: "2024-12-19"
scraped_at: "2026-03-03T06:59:29.030050876+00:00"
language: "en"
translated: false
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

InterpretabilityResearch

# Privileged Bases in the Transformer Residual Stream

Mar 16, 2023

[Read Paper](https://transformer-circuits.pub/2023/privileged-basis/index.html)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.


## Abstract

Our mathematical theories of the Transformer architecture suggest that individual coordinates in the residual stream should have no special significance (that is, the basis directions should be in some sense "arbitrary" and no more likely to encode information than random directions). Recent work has shown that this observation is false in practice. We investigate this phenomenon and provisionally conclude that the per-dimension normalizers in the Adam optimizer are to blame for the effect.

We explore two other obvious sources of basis dependency in a Transformer: Layer normalization, and finite-precision floating-point calculations. We confidently rule these out as being the source of the observed basis-alignment.