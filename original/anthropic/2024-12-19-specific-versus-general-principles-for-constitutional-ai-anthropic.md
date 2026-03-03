---
title: "Specific versus General Principles for Constitutional AI \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/specific-versus-general-principles-for-constitutional-ai"
date: "2024-12-19"
scraped_at: "2026-03-03T06:54:47.524907164+00:00"
language: "en"
translated: false
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

AlignmentResearch

# Specific versus General Principles for Constitutional AI

Oct 24, 2023

[Read Paper](https://arxiv.org/abs/2310.13798)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.


## Abstract

Human feedback can prevent overtly harmful utterances in conversational models, but may not automatically mitigate subtle problematic behaviors such as a stated desire for self-preservation or power. Constitutional AI offers an alternative, replacing human feedback with feedback from AI models conditioned only on a list of written principles. We find this approach effectively prevents the expression of such behaviors. The success of simple principles motivates us to ask: can models learn general ethical behaviors from only a single written principle? To test this, we run experiments using a principle roughly stated as "do what's best for humanity." We find that the largest dialogue models can generalize from this short constitution, resulting in harmless assistants with no stated interest in specific motivations like power. A general principle may thus partially avoid the need for a long list of constitutions targeting potentially harmful behaviors. However, more detailed constitutions still improve fine-grained control over specific types of harms. This suggests both general and specific principles have value for steering AI safely.