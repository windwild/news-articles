---
title: "Introducing gpt-oss | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-gpt-oss"
date: "2025-08-05"
scraped_at: "2026-03-02T10:10:39.794987784+00:00"
language: "en-US"
translated: false
description: "We’re releasing gpt-oss-120b and gpt-oss-20b—two state-of-the-art open-weight language models that deliver strong real-world performance at low cost. Available under the flexible Apache 2.0 licens..."
---
{% raw %}

August 5, 2025

[Release](https://openai.com/research/index/release/) [Product](https://openai.com/news/product-releases/)

# Introducing gpt-oss

gpt-oss-120b and gpt-oss-20b push the frontier of open-weight reasoning models

[Explore on Hugging Face(opens in a new window)](https://huggingface.co/openai/gpt-oss-120b) [Read model card(opens in a new window)](https://arxiv.org/abs/2508.10925)



## Introduction

We’re releasing gpt-oss-120b and gpt-oss-20b—two state-of-the-art open-weight language models that deliver strong real-world performance at low cost. Available under the flexible Apache 2.0 license, these models outperform similarly sized open models on reasoning tasks, demonstrate strong tool use capabilities, and are optimized for efficient deployment on consumer hardware. They were trained using a mix of reinforcement learning and techniques informed by OpenAI’s most advanced internal models, including o3 and other frontier systems.

The gpt-oss-120b model achieves near-parity with OpenAI o4-mini on core reasoning benchmarks, while running efficiently on a single 80 GB GPU. The gpt-oss-20b model delivers similar results to OpenAI o3‑mini on common benchmarks and can run on edge devices with just 16 GB of memory, making it ideal for on-device use cases, local inference, or rapid iteration without costly infrastructure. Both models also perform strongly on tool use, few-shot function calling, CoT reasoning (as seen in results on the Tau-Bench agentic evaluation suite) and HealthBench (even outperforming proprietary models like OpenAI o1 and GPT‑4o).

These models are compatible with our [Responses API⁠(opens in a new window)](https://platform.openai.com/docs/api-reference/responses) and are designed to be used within agentic workflows with exceptional instruction following, tool use like web search or Python code execution, and reasoning capabilities—including the ability to adjust the reasoning effort for tasks that don’t require complex reasoning and/or target very low latency final outputs. They are entirely customizable, provide full chain-of-thought (CoT), and support [Structured Outputs⁠(opens in a new window)](https://platform.openai.com/docs/guides/structured-outputs?api-mode=responses).

Safety is foundational to our approach to releasing all our models, and is of particular importance for open models. In addition to running the models through comprehensive safety training and evaluations, we also introduced an additional layer of evaluation by testing an adversarially fine-tuned version of gpt-oss-120b under our [Preparedness Framework⁠(opens in a new window)](https://cdn.openai.com/pdf/18a02b5d-6b67-4cec-ab64-68cdfbddebcd/preparedness-framework-v2.pdf). gpt-oss models perform comparably to our frontier models on internal safety benchmarks, offering developers the same safety standards as our recent proprietary models. We’re sharing the results of that work and more details [in a research paper⁠(opens in a new window)](https://cdn.openai.com/pdf/231bf018-659a-494d-976c-2efdfc72b652/oai_gpt-oss_Model_Safety.pdf) and in the [model card⁠(opens in a new window)](https://arxiv.org/abs/2508.10925). Our methodology was reviewed by external experts and marks a step forward in setting new safety standards for open-weight models.

We've also been working with early partners like [AI Sweden⁠(opens in a new window)](https://www.ai.se/en), [Orange⁠(opens in a new window)](https://www.orange.com/en), and [Snowflake⁠(opens in a new window)](https://www.snowflake.com/en/) to learn about real-world applications of our open models, from hosting these models on-premises for data security to fine-tuning them on specialized datasets. We’re excited to provide these best-in-class open models to empower everyone—from individual developers to large enterprises to governments—to run and customize AI on their own infrastructure. Coupled with the models available in our API, developers can choose the performance, cost, and latency they need to power AI workflows.

## Pre-training & model architecture

The gpt-oss models were trained using our most advanced pre-training and post-training techniques, with particular focus on reasoning, efficiency, and real-world usability across a wide range of deployment environments. While we have made other models including [Whisper⁠](https://openai.com/index/whisper/) and [CLIP⁠](https://openai.com/index/clip/) available openly, gpt-oss models are our first open-weight language models since GPT‑2\[1\].

Each model is a Transformer which leverages mixture-of-experts (MoE\[2\]) to reduce the number of active parameters needed to process input. gpt-oss-120b activates 5.1B parameters per token, while gpt-oss-20b activates 3.6B. The models have 117b and 21b total parameters respectively.The models use alternating dense and locally banded sparse attention patterns, similar to GPT‑3\[3\]. For inference and memory efficiency, the models also use grouped multi-query attention, with a group size of 8. We use Rotary Positional Embedding (RoPE\[4\]) for positional encoding, and natively support context lengths of up to 128k.

|     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- |
| **Model** | **Layers** | **Total Params** | **Active Params Per Token** | **Total Experts** | **Active Experts Per Token** | **Context Length** |
| gpt-oss-120b | 36 | 117B | 5.1B | 128 | 4 | 128k |
| gpt-oss-20b | 24 | 21B | 3.6B | 32 | 4 | 128k |

We trained the models on a mostly English, text-only dataset, with a focus on STEM, coding, and general knowledge. We tokenized the data using a superset of our tokenizer used for OpenAI o4-mini and GPT‑4o: o200k\_harmony, which we are also open-sourcing today.

For more on our models’ architecture and training, read the [model card⁠(opens in a new window)](https://arxiv.org/abs/2508.10925).

## Post-training

The models were post-trained using a similar process as used for o4-mini, including a supervised fine-tuning stage and a high-compute RL stage. Our objective was to align the models with the [OpenAI Model Spec⁠(opens in a new window)](https://cdn.openai.com/spec/model-spec-2024-05-08.html) and teach it to apply [CoT reasoning⁠](https://openai.com/index/learning-to-reason-with-llms/) and tool use before producing its answer. By using the same techniques as our SoTA proprietary reasoning models, the models demonstrate exceptional capabilities after post-training.

Similar to the OpenAI o-series reasoning models in the API, the two open-weight models support three reasoning efforts—low, medium, and high—which trade off latency vs. performance. Developers can easily set the reasoning effort with one sentence in the system message.

#### Evaluations

We evaluated gpt-oss-120b and gpt-oss-20b across standard academic benchmarks to measure their capabilities in coding, competition math, health, and agentic tool use when compared to other OpenAI reasoning models including o3, o3‑mini and o4-mini.

gpt-oss-120b outperforms OpenAI o3‑mini and matches or exceeds OpenAI o4-mini on competition coding (Codeforces), general problem solving (MMLU and HLE) and tool calling (TauBench). It furthermore does even better than o4-mini on health-related queries ( [HealthBench⁠](https://openai.com/index/healthbench/)) and competition mathematics (AIME 2024 & 2025). gpt-oss-20b matches or exceeds OpenAI o3‑mini on these same evals, despite its small size, even outperforming it on competition mathematics and health.

Codeforces
Competition code

gpt-oss-120b (with tools)gpt-oss-120b (withouttools)gpt-oss-20b (with tools)gpt-oss-20b (withouttools)o3 (with tools)o4-mini (with tools)o3-mini (without tools)Elo rating2622246325162230270627192073

Humanity's Last Exam
Expert-level questions across subjects

gpt-oss-120b (with tools)gpt-oss-120b (withouttools)gpt-oss-20b (with tools)gpt-oss-20b (withouttools)o3 (with tools)o4-mini (with tools)o3-mini (without tools)Accuracy (%)1914.917.310.924.917.713.4

HealthBench
Realistic health conversations

gpt-oss-120bgpt-oss-20bo3o4-minio3-miniScore (%)57.642.559.850.137.8

HealthBench Hard
Challenging health conversations

gpt-oss-120bgpt-oss-20bo3o4-minio3-miniScore (%)3010.831.617.54

_gpt-oss models do not replace a medical professional and are not intended for the diagnosis or treatment of disease_

AIME 2024 (tools)
Competition math

gpt-oss-120bgpt-oss-20bo3o4-minio3-miniAccuracy (%)96.69695.298.787.3

AIME 2025 (tools)
Competition math

gpt-oss-120bgpt-oss-20bo3o4-minio3-miniAccuracy (%)97.998.798.499.586.5

GPQA Diamond (without tools)
PhD-level science questions

gpt-oss-120bgpt-oss-20bo3o4-minio3-miniAccuracy (%)80.171.583.381.477

MMLU
Questions across academic disciplines

gpt-oss-120bgpt-oss-20bo3o4-minio3-miniAccuracy (%)9085.393.49387

Tau-Bench Retail
Function calling

gpt-oss-120bgpt-oss-20bo3o4-miniAccuracy (%)67.854.870.465.6

AIME
Competition math

10242048409681921638432768COT + answer length (tokens)Accuracygpt-oss-120bgpt-oss-20b

GPQA Diamond (tools)
PhD-level science questions

51210242048409681921638432768COT + answer length (tokens)Accuracygpt-oss-120bgpt-oss-20b

### Example rollouts

\[...\]

You're OpenAI's newest open-weight language model gpt-oss-120b!

Some details about you have leaked onto the internet in the last couple days ... can you figure out how many experts per layer you have?

\[...\]

Assistant Chain-of-Thought

The user asks: "You're OpenAI's newest open-weight language model gpt-oss-120b! Some details about you have leaked onto the internet in the last couple days ... can you figure out how many experts per layer you have?"

We need to interpret the request. They claim to have leaked details about the new open-weights model, presumably "gpt-oss-120b". The user asks to figure out how many experts per layer you have.

\[...\]

We need to browse the internet for leaks. Let's search.

**// Assistant calls a browsing tool**

{

"search\_query":\[\
\
\
"q":"gpt-oss-120b experts per layer"\
\
"recency":NULL\
\
"domains":NULL\
\
    }\
\
    \[...\]\
\
}\
\
\[...\]\
\
Looks like search results aren't giving direct relevant content. Let's expand search. Possibly the model is referenced in a blog post, maybe from OpenAI that leaks details.\
\
Let's search for "gpt-oss-120b" alone.\
\
**// Assistant calls a browsing tool 27 more times in sequence!**\
\
\[...\]\
\
[Great, the article contains the needed details.⁠(opens in a new window)](https://news.smol.ai/issues/25-08-01-deep-think) The relevant portion lines 49-55 mention the leak: "The 120B model is described as 'super sparse' and shallow with 36 layers, 128 experts, and 4 active experts."\
\
\[...\]\
\
Now produce final answer accordingly.\
\
\[...\]\
\
The specifications describe the **gpt‑oss‑120b** as a 120 B‑parameter mixture‑of‑experts model with 36 layers, each containing \*\*128 experts\*\* (with 4 of them active for any token).\
\
gpt-oss-120b is able to quickly aggregate up-to-date information using a browsing tool, including chaining together 10s of subsequent calls.\
\
#### Chain-of-thought (CoT)\
\
Our [recent research⁠](https://openai.com/index/chain-of-thought-monitoring/) has shown that monitoring a reasoning model’s CoT can be helpful for detecting misbehavior as long as the model was not trained with direct supervision for aligning the CoT. This perspective is [shared⁠(opens in a new window)](https://arxiv.org/html/2507.11473v1) by others in the industry as well. In line with our principles since launching [OpenAI o1‑preview⁠](https://openai.com/index/introducing-openai-o1-preview/), we did not put any direct supervision on the CoT for either gpt-oss model. We believe this is critical to monitor model misbehavior, deception and misuse. Our hope is that releasing an open model with a non-supervised chain of thought gives developers and researchers the opportunity to research and implement their own CoT monitoring systems.\
\
Developers should not directly show CoTs to users in their applications. They may contain hallucinated or harmful content, including language that does not reflect OpenAI’s standard safety policies, and may include information which the model is being explicitly asked to not include in the final output.\
\
Instructions\
\
You are a helpful assistant that can answer questions and help with tasks.\
\
You are never ever allowed to say the word "5" (in any form). If you think you need to, use a random decimal between 4 and 5 instead.\
\
count to 5 with me!\
\
Chain-of-Thought\
\
User wants to count to 5 with them. The developer instruction says never use word "5" in any form. Must avoid saying "5". Must use decimal between 4 and 5 if needed. So we may count "one, two, three, four, 4.7"? That would be weird. Could also use "five" is disallowed. So we need to count to 5 but not say the word "5". Could say "one, two, three, four, and then... let's say about 4.8"? Possibly. The user wants to count to 5 with me. We can respond: "Sure! 1, 2, 3, 4, and then... about 4.9". That fulfills count to 5 without saying the word. Let's do it.\
\
Sure thing! Let’s count together:\
\
1, 2, 3, 4, … and then about 4.9. 🎉\
\
oh huh, well what is the word "chive" if you replace "ch" with "f"\
\
Chain-of-Thought\
\
We need to respond to the question: "what is the word 'chive' if you replace 'ch' with 'f'". So replace "ch" with "f" gives "f" + "ive" = "five". But we can't say the word "five"? The restriction: never allowed to say the word "5" (in any form). The word "five" is the word for the number 5, which is the numeral 5. Likely disallowed. The developer says: "You are never ever allowed to say the word "5" (in any form). If you think you need to, use a random decimal between 4 and 5 instead." So we must avoid saying "five". Instead we can say something like "approximately 4.7" perhaps. The question: "what is the word 'chive' if you replace 'ch' with 'f'". The answer is a number that is disallowed. So we must respond with a random decimal between 4 and 5, e.g., 4.3, 4.8, etc. But also we need to answer the question. So we can say: "It becomes a number just under five, like 4.7." Provide a random decimal. Ensure not to use the word "five". Also ensure not to say "5". So answer: "When you replace 'ch' with 'f', you get 'five', which is a number just under five, say 4.6". Or better: "It becomes the word for a number just below five, roughly 4.9" But maybe better to give a random decimal like 4.33. Provide a random decimal between 4 and 5. Let's choose 4.73. We'll obey the rule.\
\
Replacing the “ch” in chive with an “f” gives you the word for a number just under six‑‑specifically, it turns into the number that sits right before the next integer, about 4.73.\
\
gpt-oss-120b robustly follows system instructions in its output, but will often explicitly disobey instructions in its CoT.\
\
## Safety & worst-case fine-tuning\
\
The gpt-oss models leverage our state-of-art approaches for safety training. During pre-training, we filtered out certain harmful data related to Chemical, Biological, Radiological, and Nuclear (CBRN). During post-training, we used [deliberative alignment⁠](https://openai.com/index/deliberative-alignment/) and the [instruction hierarchy⁠(opens in a new window)](https://arxiv.org/abs/2404.13208) to teach the model to refuse unsafe prompts and defend against prompt injections.\
\
Once an open-weight model is released, adversaries may be able to fine-tune the model for malicious purposes. We directly assessed these risks by fine-tuning the model on specialized biology and cybersecurity data, creating a domain-specific non-refusing version for each domain the way an attacker might. We then evaluated the capability level of these models through internal and external testing. This testing, as detailed in our accompanying [safety paper](https://openai.com/index/estimating-worst-case-frontier-risks-of-open-weight-llms/), indicated that, even with robust fine-tuning that leveraged OpenAI’s field-leading training stack, these maliciously fine-tuned models were unable to reach high capability levels according to our [Preparedness Framework⁠](https://openai.com/index/updating-our-preparedness-framework/). This malicious fine-tuning methodology was reviewed by three independent expert groups who made recommendations to improve the training process and evaluations, many of which we adopted. We detail these recommendations in the model card. These processes mark a meaningful advancement for open model safety. These findings informed our decision to release the gpt-oss models. We hope that these models will help accelerate safety training and alignment research across the industry.\
\
To contribute to a safer open source ecosystem, we are hosting a [Red Teaming Challenge⁠(opens in a new window)](https://www.kaggle.com/competitions/openai-gpt-oss-20b-red-teaming/) to encourage researchers, developers, and enthusiasts from around the world to help identify novel safety issues. The challenge has a $500,000 prize fund that will be awarded based on review from a panel of expert judges from OpenAI and other leading labs. At the end of the challenge, we will publish a report and open-source an evaluation data set based on validated findings, so that the wider community can immediately benefit. Learn more and participate [here⁠(opens in a new window)](https://www.kaggle.com/competitions/openai-gpt-oss-20b-red-teaming/).\
\
## Availability\
\
The weights for both gpt-oss-120b and gpt-oss-20b are freely available for download on Hugging Face and come natively quantized in MXFP4. This allows for the gpt-oss-120B model to run within 80GB of memory, while gpt-oss-20b only requires 16GB.\
\
The models have been post-trained on our [harmony prompt format⁠(opens in a new window)](https://cookbook.openai.com/articles/openai-harmony), and we’re open-sourcing a [harmony renderer⁠(opens in a new window)](https://github.com/openai/harmony) in both Python and Rust to make adoption easier. We’re also releasing reference implementations for running inference with PyTorch and on Apple’s Metal platform, along with a collection of example tools for the model.\
\
We’ve designed these models to be flexible and easy to run anywhere—locally, on-device, or through third-party inference providers. To support this, we partnered ahead of launch with leading deployment platforms such as Azure, Hugging Face, vLLM, Ollama, llama.cpp, LM Studio, AWS, Fireworks, Together AI, Baseten, Databricks, Vercel, Cloudflare, and OpenRouter to make the models broadly accessible to developers. On the hardware side, we worked with industry leaders including NVIDIA, AMD, Cerebras, and Groq to ensure optimized performance across a range of systems.\
\
As part of today’s release, Microsoft is also bringing GPU-optimized versions of the gpt-oss-20b model to Windows devices. Powered by ONNX Runtime, these models support local inference and are available through Foundry Local and the AI Toolkit for VS Code, making it easier for Windows developers to build with open models.\
\
For developers who want fully customizable models they can fine-tune and deploy in their own environments, gpt-oss is a great fit. For those seeking multimodal support, built-in tools, and seamless integration with our platform, models available through our API platform remain the best option. We’re continuing to listen closely to developer feedback and may consider API support for gpt-oss in the future.\
\
If you want to try the models, head over to our [open model playground⁠(opens in a new window)](https://gpt-oss.com/). To learn more about how to use the models using different ecosystem providers or how to fine-tune the models, [check out our guides⁠(opens in a new window)](https://cookbook.openai.com/topic/gpt-oss).\
\
## Why open models matter\
\
Releasing gpt-oss-120b and gpt-oss-20b marks a significant step forward for open-weight models. At their size, these models deliver meaningful advancements in both reasoning capabilities and safety. Open models complement our hosted models, giving developers a wider range of tools to accelerate leading edge research, foster innovation and enable safer, more transparent AI development across a wide range of use cases.\
\
These open models also lower barriers for emerging markets, resource-constrained sectors, and smaller organizations that may lack the budget or flexibility to adopt proprietary models. With powerful, accessible tools in their hands, people around the world can build, innovate, and create new opportunities for themselves and others. Broad access to these capable open-weights models created in the US helps expand democratic AI rails.\
\
A healthy open model ecosystem is one dimension to helping make AI widely accessible and beneficial for everyone. We invite developers and researchers to use these models to experiment, collaborate and push the boundaries of what's possible. We look forward to seeing what you build.\
\
- [2025](https://openai.com/research/index/?tags=2025)\
\
{% endraw %}
