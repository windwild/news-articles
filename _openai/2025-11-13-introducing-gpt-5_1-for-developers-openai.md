---
title: "Introducing GPT-5.1 for developers | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/gpt-5-1-for-developers"
date: "2025-11-13"
scraped_at: "2026-03-02T10:09:20.370047874+00:00"
language: "en-US"
translated: false
description: "GPT-5.1 is now available in the API, bringing faster adaptive reasoning, extended prompt caching, improved coding performance, and new apply_patch and shell tools."
---
{% raw %}

November 13, 2025


# Introducing GPT‑5.1 for developers



Today we’re releasing GPT‑5.1 in the API platform, the next model in the GPT‑5 series that balances intelligence and speed for a wide range of agentic and coding tasks. GPT‑5.1 dynamically adapts how much time it spends thinking based on the complexity of the task, making the model significantly faster and more token-efficient on simpler everyday tasks. The model also features a “no reasoning” mode to respond faster on tasks that don’t require deep thinking, while maintaining the frontier intelligence of GPT‑5.1.

To make GPT‑5.1 even more efficient, we’re releasing extended prompt caching for up to 24 hour cache retention, driving faster responses for follow-up questions at a lower cost. Our [Priority Processing⁠(opens in a new window)](https://platform.openai.com/docs/guides/priority-processing) customers will also experience noticeably faster performance with GPT‑5.1 over GPT‑5.

On coding, we’ve worked closely with startups like Cursor, Cognition, Augment Code, Factory, and Warp to improve GPT‑5.1’s coding personality, steerability, and code quality. In general, GPT‑5.1 feels more intuitive to use for coding and more communicative with user-facing updates as it completes tasks.

Finally, we’re introducing two new tools with GPT‑5.1: an `apply_patch` tool designed to edit code more reliably and a shell tool to let the model run shell commands.

GPT‑5.1 is the next advancement in the GPT‑5 series, and we plan to continue to invest in more intelligent and capable models to help developers build reliable agentic workflows.

## Efficient reasoning across tasks

#### Adaptive reasoning

To make GPT‑5.1 faster, we overhauled the way we trained it to think. On straightforward tasks, GPT‑5.1 spends fewer tokens thinking, enabling snappier product experiences and lower token bills. On difficult tasks that require extra thinking, GPT‑5.1 remains persistent, exploring options and checking its work in order to maximize reliability.

[**Balyasny Asset Management** ⁠(opens in a new window)](https://www.bamfunds.com/) said GPT‑5.1 "outperformed both GPT‑4.1 and GPT‑5 in our full dynamic evaluation suite, while running 2-3x faster than GPT‑5." They also said across their tool-heavy reasoning tasks, GPT‑5.1 “consistently used about half as many tokens as leading competitors at similar or better quality.” Similarly, AI insurance BPO [**Pace** ⁠(opens in a new window)](https://withpace.com/) also tested the model and said their agents run "50% faster on GPT‑5.1 while exceeding accuracy of GPT‑5 and other leading models across our evals."

GPT-5.1 spends less time on easy tasks and more time on hard tasks

10th percentile30th percentile50th percentile70th percentile90th percentile\# of model-generated tokens per response(relative to GPT-5)−88%−79%−70%−60%−45%−70%−50%−28%−7%+36%GPT-5 (Medium)GPT-5.1 (Medium)GPT-5.1 (High)

_GPT‑5.1 varies its thinking time more dynamically than GPT‑5. On a representative distribution of ChatGPT tasks, GPT‑5.1 is much faster at the easier tasks, even at high reasoning effort._

As an example, when asked "show an npm command to list globally installed packages", GPT‑5.1 answers in 2 seconds instead of 10 seconds.

## GPT-5 (Medium) takes ~250 tokens (~10 seconds)

show an npm command to list globally installed packages

npm list -g --depth=0

## GPT-5.1 (Medium) takes ~50 tokens (~2 seconds)

show an npm command to list globally installed packages

You can list globally installed npm packages with:

- Just package names: npm ls -g --depth=0
- Including their install paths: npm ls -g

The first one is usually what you want.

#### New “no reasoning” mode

Developers can now use GPT‑5.1 without reasoning by setting reasoning\_effort to 'none'. This makes the model behave like a non-reasoning model for latency-sensitive use cases, with the high intelligence of GPT‑5.1 and added bonus of performant tool-calling. Relative to GPT‑5 with 'minimal' reasoning, GPT‑5.1 with no reasoning is better at parallel tool calling (which itself increases end-to-end task completion speed), coding tasks, following instructions, and using search tools—and supports [web search⁠(opens in a new window)](https://platform.openai.com/docs/guides/tools-web-search?api-mode=responses) in our API platform. [**Sierra** ⁠(opens in a new window)](https://sierra.ai/) shared that GPT‑5.1 on “no reasoning” mode showed a “20% improvement on low-latency tool calling performance compared to GPT‑5 minimal reasoning” in their real-world evals.

With the introduction of 'none' as a value in reasoning\_effort, developers now have even more flexibility and control over the balance between speed, cost, and intelligence for their use case. GPT‑5.1 defaults to 'none', which is ideal for latency-sensitive workloads. We recommend developers choose 'low' or 'medium' for tasks of higher complexity and 'high' when intelligence and reliability matter more than speed.

#### Extended prompt caching

Extended caching improves reasoning efficiency by allowing prompts to remain active in the cache for up to 24 hours, rather than the few minutes supported today. With a longer retention window, more follow-up requests can leverage cached context—resulting in lower latency, reduced cost, and smoother performance for long-running interactions such as multi-turn chat, coding sessions, or knowledge retrieval workflows.

Prompt cache pricing remains unchanged, with cached input tokens 90% cheaper than uncached tokens, and no additional charge for cache writes or storage. To use extended caching with GPT‑5.1, add the parameter `“prompt_cache_retention='24h'”` on the Responses or Chat Completions API. See the [prompt caching docs⁠(opens in a new window)](https://platform.openai.com/docs/guides/prompt-caching) for more detail.

## Coding

GPT‑5.1 builds on GPT‑5’s coding capabilities with a more steerable coding personality, less overthinking, improved code quality, better user-targeted update messages (preambles) during sequences of tool calls, and more functional frontend designs—especially at low reasoning effort.

On simpler coding tasks like quick code edits, GPT‑5.1’s faster speeds make it easier to iterate back and forth. GPT‑5.1’s faster speeds on simple tasks don’t degrade performance on difficult tasks. On SWE-bench Verified, GPT‑5.1 works even longer than GPT‑5 and reaches 76.3%.

SWE-bench Verified

05,00010,00015,00020,00025,000Thinking tokens60%65%70%75%80%AccuracyminimallowmediumnonelowmediumhighhighGPT-5GPT-5.1

_In_ [_SWE-bench Verified⁠_ ⁠](https://openai.com/index/introducing-swe-bench-verified/) _, a model is given a code repository and issue description, and must generate a patch to solve the issue. Labels indicate reasoning effort. Accuracy is averaged across all 500 problems. All models used a harness with JSON-based apply\_patch tool._

We got early feedback on GPT‑5.1 from a handful of coding companies. Here are their impressions:

- [**Augment Code** ⁠(opens in a new window)](https://www.augmentcode.com/) called GPT‑5.1 “more deliberate with fewer wasted actions, more efficient reasoning, and better task focus” and they’re seeing “more accurate changes, smoother pull requests, and faster iteration across multi-file projects.”
- [**Cline** ⁠(opens in a new window)](https://cline.bot/) shared that in their evals, “GPT‑5.1 achieved SOTA on our diff editing benchmark with a 7% improvement, demonstrating exceptional reliability for complex coding tasks.”
- [**CodeRabbit** ⁠(opens in a new window)](https://coderabbit.ai/) called GPT‑5.1 its “top model of choice for PR reviews.”
- [**Cognition** ⁠(opens in a new window)](https://cognition.ai/) said GPT‑5.1 is “noticeably better at understanding what you're asking for and working with you to get it done.”
- [**Factory** ⁠(opens in a new window)](https://factory.ai/) said “GPT‑5.1 delivers noticeably snappier responses and adapts its reasoning depth to the task, reducing overthinking and improving the overall developer experience.”
- [**Warp** ⁠(opens in a new window)](https://www.warp.dev/warp-ai) is making GPT‑5.1 the default for new users, saying it “builds on the impressive intelligence gains that the GPT‑5 series introduced, while being a far more responsive model.”

> "GPT 5.1 isn’t just another LLM—it’s genuinely agentic, the most naturally autonomous model I’ve ever tested. It writes like you, codes like you, effortlessly follows complex instructions, and excels in front-end tasks, fitting neatly into your existing codebase. You can really unlock its full potential in the Responses API and we're excited to offer it in our IDE."

—Denis Shiryaev, Head of AI DevTools Ecosystem, JetBrains

## New tools in GPT‑5.1

We’re introducing two new tools with GPT‑5.1 to help developers get the most out of the model in the Responses API: a freeform `apply_patch` **tool** to make code edits even more reliable without the need for JSON escaping, and a **shell** **tool** that lets the model write commands to run on your local machine.

#### Apply\_patch tool

The freeform `apply_patch` tool lets GPT‑5.1 create, update, and delete files in a codebase using structured diffs. Instead of just suggesting edits, the model emits patch operations that an application applies and reports back on, enabling iterative, multi-step code editing workflows.

To use the `apply_patch` tool in the Responses API, include it in the tools array with `"tools": [{“type”: “apply_patch”}]` and either include file content in your input or give the model tools for interacting with your file system. The model will generate `apply_patch_call` items for creating, updating, or deleting files that contain diffs that you apply on your file system. For more information on how to integrate with the apply\_patch tool, check out our [developer documentation⁠(opens in a new window)](https://platform.openai.com/docs/guides/tools-apply-patch).

#### Shell tool

The shell tool allows the model to interact with a local computer through a controlled command-line interface. The model proposes shell commands; a developer’s integration executes them and returns the outputs. This creates a simple plan-execute loop that lets models inspect the system, run utilities, and gather data until they can finish the task.

To use the shell tool in Responses API, developers can include it in the tools array with "`tools": [{“type”: “shell”}]`. The API will generate `"shell_call"` items that include the shell commands to execute. Developers execute the commands in the local environment and pass back the execution results in the `"shell_call_output"`item in the next API request. Learn more in our [developer documentation⁠(opens in a new window)](https://platform.openai.com/docs/guides/tools-shell).

## Pricing and availability

GPT‑5.1 and gpt-5.1-chat-latest are available to developers on all paid tiers in the API. [Pricing and rate limits⁠(opens in a new window)](https://platform.openai.com/docs/pricing) are the same as GPT‑5. We're also releasing `gpt-5.1-codex` and `gpt-5.1-codex-mini` in the API. While GPT‑5.1 excels at most coding tasks, gpt-5.1-codex models are optimized for long-running, agentic coding tasks in Codex or Codex-like harnesses.

Developers can start building using our GPT‑5.1 [developer documentation⁠(opens in a new window)](https://platform.openai.com/docs/guides/latest-model) and [model prompting guide⁠(opens in a new window)](https://cookbook.openai.com/examples/gpt-5/gpt-5.1_prompting_guide). We don’t currently plan to deprecate GPT‑5 in the API and will give developers advanced notice if and when we decide to do so.

## What’s next

We’re committed to iteratively deploying the most capable, reliable models for real agentic and coding work—models that think efficiently, iterate quickly, and handle complex tasks while keeping developers in flow. With adaptive reasoning, stronger coding performance, clearer user-facing updates, and new tools like `apply_patch` and `shell`, GPT‑5.1 is designed to help you build with less friction. And we’re continuing to invest heavily here: you can expect more capable agentic and coding models in the weeks and months ahead.

## Appendix: Model evaluations

|     |     |     |
| --- | --- | --- |
| **Evaluation** | **GPT‑5.1 (high)** | **GPT‑5 (high)** |
| SWE-bench Verified<br>(all 500 problems) | 76.3% | 72.8% |
| GPQA Diamond <br>(no tools) | 88.1% | 85.7% |
| AIME 2025<br>(no tools) | 94.0% | 94.6% |
| FrontierMath<br>(with Python tool) | 26.7% | 26.3% |
| MMMU | 85.4% | 84.2% |
| Tau2-bench Airline | 67.0% | 62.6% |
| Tau2-bench Telecom\* | 95.6% | 96.7% |
| Tau2-bench Retail | 77.9% | 81.1% |
| BrowseComp Long Context 128k | 90.0% | 90.0% |

_\\* For Tau_ _2_ _-bench Telecom, we gave GPT‑5.1 a short, generically helpful prompt to improve its performance._

- [API Platform](https://openai.com/news/?tags=api-platform)
- [2025](https://openai.com/news/?tags=2025)
{% endraw %}
