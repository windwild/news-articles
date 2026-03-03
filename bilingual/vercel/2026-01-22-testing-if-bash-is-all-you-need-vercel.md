---
title: "Testing if \"bash is all you need\" - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/testing-if-bash-is-all-you-need"
date: "2026-01-22"
scraped_at: "2026-03-02T09:22:19.481888239+00:00"
language: "en-zh"
translated: true
description: "We tested bash vs SQL agents on structured data queries. SQL dominated, but combining both tools achieved 100% accuracy. Try the open-source eval harness."
---

Jan 22, 2026

2026 年 1 月 22 日

_We invited_ [_Ankur Goyal_](https://x.com/ankrgyl) _from_ [_Braintrust_](https://www.braintrust.dev/) _to share how they tested the "bash is all you need" hypothesis for AI agents._

我们邀请了来自 [_Braintrust_](https://www.braintrust.dev/) 的 [_Ankur Goyal_](https://x.com/ankrgyl)，分享他们如何验证 AI 智能体领域的“只需 Bash 即可”（*bash is all you need*）这一假设。

There's a growing conviction in the AI community that filesystems and bash are the optimal abstraction for AI agents. The logic makes sense: LLMs have been extensively trained on code, terminals, and file navigation, so you should be able to give your agent a shell and let it work.

AI 社区中正日益形成一种共识：文件系统（filesystems）与 Bash 是构建 AI 智能体的最优抽象层。这一观点逻辑清晰：大语言模型（LLMs）已在大量代码、终端操作及文件导航相关数据上接受了充分训练，因此，你只需为智能体提供一个 Shell 环境，它便能自主开展工作。

Models inherit shell fluency from coding-heavy training data

模型凭借以编程为导向的海量训练数据，天然具备 Shell 操作能力。

Even non-coding agents may benefit from this approach. Vercel's recent post on [building agents with filesystems and bash](https://vercel.com/blog/how-to-build-agents-with-filesystems-and-bash) showed this by mapping sales calls, support tickets, and other structured data onto the filesystem. The agent greps for relevant sections, pulls what it needs, and builds context on demand.

即使是非编程类智能体，也可能从该方法中获益。Vercel 近期发布的博客文章《[如何使用文件系统与 Bash 构建智能体](https://vercel.com/blog/how-to-build-agents-with-filesystems-and-bash)》即为此提供了佐证：文章将销售通话记录、客户支持工单及其他结构化数据映射至文件系统中；智能体通过 `grep` 检索相关内容片段，按需提取所需信息，并动态构建上下文。

But there's an alternative view worth testing. Filesystems may be the right abstraction for exploring and retrieving context, but what about querying structured data? We [built an eval harness](https://github.com/braintrustdata/bash-agent-evals) to find out.

但还存在一种值得验证的替代观点：文件系统或许是探索与检索上下文的理想抽象，那么，针对结构化数据的查询任务又当如何？为此，我们[构建了一套评估框架（eval harness）](https://github.com/braintrustdata/bash-agent-evals)来深入探究。

## Setting up the eval

## 评估框架搭建

We tasked agents with querying a dataset of GitHub issues and pull requests. This type of semi-structured data mirrors real-world use cases like customer support tickets or sales call transcripts.

我们要求各智能体对一组 GitHub Issues 和 Pull Requests 数据集执行查询任务。此类半结构化数据，高度模拟了现实世界中的典型应用场景，例如客户支持工单或销售通话转录文本。

Question complexity ranged from:

问题复杂度涵盖以下层级：

- Simple queries: "How many open issues mention 'security'?"  
- 简单查询：“有多少个已开启（open）的 Issue 提到了 ‘security’？”

- Complex queries: "Find issues where someone reported a bug and later someone submitted a pull request claiming to fix it"

- 复杂查询：“找出那些有人报告了缺陷，随后又有人提交了声称修复该缺陷的拉取请求（pull request）的问题”。

Three agent approaches competed:

三种智能体（agent）方法参与了对比：

1. **SQL agent**: Direct database queries against a SQLite database containing the same data

1. **SQL 智能体**：直接对包含相同数据的 SQLite 数据库执行数据库查询。

2. **Bash agent**: Using [`just-bash`](https://justbash.dev/) to navigate and query JSON files on the filesystem

2. **Bash 智能体**：使用 [`just-bash`](https://justbash.dev/) 在文件系统中导航并查询 JSON 文件。

3. **Filesystem agent**: Basic file tools (search, read) without full shell access

3. **文件系统智能体**：仅使用基础文件工具（如搜索、读取），不提供完整的 shell 访问权限。

Each agent received the same questions and was scored on accuracy.

每个智能体均接收相同的一组问题，并依据准确率进行评分。

## Initial results

## 初步结果

| **Agent** | **Accuracy** | **Avg Tokens** | **Cost** | **Duration** |
| --- | --- | --- | --- | --- |
| SQL | 100% | 155,531 | $0.51 | 45s |
| Bash | 52.7% | 1,062,031 | $3.34 | 401s |
| Filesystem | 63.0% | 1,275,871 | $3.89 | 126s |

SQL dominated. It hit 100% accuracy while bash achieved just 53%. Bash also used 7x more tokens and cost 6.5x more, while taking 9x longer to run. Even basic filesystem tools (search, read) outperformed full bash access, hitting 63% accuracy.

SQL 方案全面领先：准确率达到 100%，而 Bash 方案仅为 52.7%。此外，Bash 方案消耗的 token 数量是 SQL 的 7 倍，成本达其 6.5 倍，运行耗时更是长达其 9 倍。甚至仅具备基础文件操作能力（搜索、读取）的文件系统智能体，其准确率（63.0%）也超过了拥有完整 Bash 访问权限的智能体。

You can explore the [SQL experiment](https://www.braintrust.dev/app/braintrust-labs/p/bash-evals/experiments/sql-claude-sonnet-4-5?c=bash-claude-sonnet-4-5), [bash experiment](https://www.braintrust.dev/app/braintrust-labs/p/bash-evals/experiments/bash-claude-sonnet-4-5?c=sql-claude-sonnet-4-5), and [filesystem experiment](https://www.braintrust.dev/app/braintrust-labs/p/bash-evals/experiments/fs-claude-sonnet-4-5?c=bash-sqlite-claude-sonnet-4-5) results directly.

您可直接查看 [SQL 实验](https://www.braintrust.dev/app/braintrust-labs/p/bash-evals/experiments/sql-claude-sonnet-4-5?c=bash-claude-sonnet-4-5)、[Bash 实验](https://www.braintrust.dev/app/braintrust-labs/p/bash-evals/experiments/bash-claude-sonnet-4-5?c=sql-claude-sonnet-4-5) 和 [文件系统实验](https://www.braintrust.dev/app/braintrust-labs/p/bash-evals/experiments/fs-claude-sonnet-4-5?c=bash-sqlite-claude-sonnet-4-5) 的详细结果。

One surprising finding was that the bash agent generated [highly sophisticated shell commands](https://www.braintrust.dev/app/braintrust-labs/p/bash-evals/experiments/bash-claude-sonnet-4-5?c=sql-claude-sonnet-4-5&r=b665a3b6-a046-4584-a8f7-2289ef580384&s=510baab2-879b-4a8e-9f9f-c4cb716dc6f4&fs=1), chaining `find`, `grep`, `jq`, `awk`, and `xargs` in ways that rarely appear in typical agent workflows. The model clearly has deep knowledge of shell scripting, but that knowledge didn't translate to better task performance.

一个出人意料的发现是，bash 智能体生成了[高度复杂的 Shell 命令](https://www.braintrust.dev/app/braintrust-labs/p/bash-evals/experiments/bash-claude-sonnet-4-5?c=sql-claude-sonnet-4-5&r=b665a3b6-a046-4584-a8f7-2289ef580384&s=510baab2-879b-4a8e-9f9f-c4cb716dc6f4&fs=1)，以链式方式组合使用 `find`、`grep`、`jq`、`awk` 和 `xargs` —— 这类用法在典型的智能体工作流中极为罕见。该模型显然具备深厚的 Shell 脚本知识，但这一知识并未转化为更优的任务执行效果。

![Sophisticated shell scripting that didn't translate to accuracy](images/testing-if-bash-is-all-you-need-vercel/img_001.jpg)

![未提升准确率的复杂 Shell 脚本编写](images/testing-if-bash-is-all-you-need-vercel/img_001.jpg)

Sophisticated shell scripting that didn't translate to accuracy

未提升准确率的复杂 Shell 脚本编写

## Debugging the results

## 结果调试

The eval revealed substantive issues requiring attention.

本次评估揭示了若干亟需关注的实质性问题。

**Performance bottlenecks.** Commands that should run in milliseconds were timing out at 10 seconds. `stat()` calls across 68,000 files were the culprit. The [`just-bash` tool received optimizations](https://x.com/cramforce/status/2010516747070349709) addressing this.

**性能瓶颈。** 本应在毫秒级完成的命令却在 10 秒后超时。根本原因在于对 68,000 个文件执行了大量 `stat()` 系统调用。[`just-bash` 工具已针对此问题进行了优化](https://x.com/cramforce/status/2010516747070349709)。

**Missing schema context.** The bash agent didn't know the structure of the JSON files it was querying. Adding schema information and example commands to the system prompt helped, but not enough to close the gap.

**缺失 Schema 上下文。** bash 智能体并不了解其所查询 JSON 文件的结构。尽管向系统提示词中添加了 Schema 信息和示例命令有所助益，但仍不足以弥补性能差距。

**Eval scoring issues.** Hand-checking failed cases revealed several questions where the "expected" answer was actually wrong, or where the agent found additional valid results that the scorer penalized. Five questions received corrections addressing ambiguities or dataset mismatches.

**评估评分问题。** 人工复核失败案例后发现：多个问题中，“预期答案”本身存在错误；或智能体找到了额外的有效结果，却被评分器错误扣分。其中五个问题已根据歧义性或数据集不匹配问题完成了修正。

- "Which repositories have the most unique issue reporters" was ambiguous between org-level and repo-level grouping

- “哪些仓库拥有最多的独立问题报告者？”——该问题在组织（org）层级与仓库（repo）层级分组之间存在歧义。

- Several questions had expected outputs that didn't match the actual dataset

- 多个问题的“预期输出”与实际数据集内容不符。

- The bash agent sometimes found more valid results than the reference answers included  

- Bash 智能体有时找到的有效结果多于所附参考答案中的数量。

The Vercel team submitted a [PR with the corrections](https://github.com/braintrustdata/bash-agent-evals/pull/5).  

Vercel 团队提交了一个[包含修正内容的 PR](https://github.com/braintrustdata/bash-agent-evals/pull/5)。

After fixes to both `just-bash` and the eval itself, the performance gap narrowed considerably.  

在对 `just-bash` 和评估任务本身均完成修复后，性能差距显著缩小。

## The hybrid approach  

## 混合方法

Then we tried a different idea. Instead of choosing one abstraction, give the agent both:  

接着，我们尝试了一种不同的思路：不局限于单一抽象层，而是同时为智能体提供两种能力：

- Let it use bash to explore and manipulate files  

- 让它使用 Bash 探索并操作文件；

- Also provide access to a SQLite database when that's the right tool  

- 同时，在适用场景下为其提供对 SQLite 数据库的访问权限。

The hybrid agent developed an interesting behavior. It would run SQL queries, then verify results by grepping through the filesystem. This double-checking is why the hybrid approach consistently hits 100% accuracy, while pure SQL occasionally gets things wrong.  

混合型智能体展现出一种有趣的行为模式：它先执行 SQL 查询，再通过在文件系统中 `grep` 检索来验证查询结果。正是这种双重校验机制，使得混合方法能持续达到 100% 的准确率，而纯 SQL 方法则偶尔出错。

You can explore the [hybrid experiment results](https://www.braintrust.dev/app/braintrust-labs/p/bash-evals/experiments/bash-sqlite-claude-sonnet-4-5?c=) directly.  

您可直接查看 [混合实验的结果](https://www.braintrust.dev/app/braintrust-labs/p/bash-evals/experiments/bash-sqlite-claude-sonnet-4-5?c=)。

The tradeoff is cost. The hybrid approach uses roughly two times as many tokens as pure SQL, since it reasons about tool choice and verifies its work.  

其权衡在于成本：由于混合方法需推理工具选择并验证自身工作，其 token 消耗量约为纯 SQL 方法的两倍。

## Key learnings

## 关键经验总结

After all the fixes to `just-bash`, the eval dataset, and data loading issues, bash-sqlite emerged as the most reliable approach. The "winner" wasn't raw accuracy on a single run, but consistent accuracy through self-verification.

在修复了 `just-bash`、评估数据集（eval dataset）以及数据加载问题之后，`bash-sqlite` 方案脱颖而出，成为最可靠的实现方式。“胜出者”并非单次运行中原始准确率最高的方案，而是通过自验证（self-verification）实现持续稳定高准确率的方案。

![The hybrid approach matched SQL on accuracy while adding self-verification](images/testing-if-bash-is-all-you-need-vercel/img_002.jpg)

![混合方法在准确率上与 SQL 相当，同时增加了自验证能力](images/testing-if-bash-is-all-you-need-vercel/img_002.jpg)

The hybrid approach matched SQL on accuracy while adding self-verification

混合方法在准确率上与 SQL 相当，同时增加了自验证能力。

Over 200 messages and hundreds of traces later, we had:

经过 200 多条消息和数百条执行轨迹分析后，我们完成了以下工作：

- Fixed performance bottlenecks in `just-bash`

- 修复了 `just-bash` 中的性能瓶颈

- Corrected five ambiguous or wrong expected answers in the eval

- 修正了评估数据集中五个存在歧义或错误的期望答案

- Found a data loading bug that caused off-by-one errors

- 发现了一个导致“索引偏移一格”（off-by-one）错误的数据加载缺陷

- Watched agents develop sophisticated verification strategies

- 观察到智能体逐步发展出复杂而精巧的验证策略

The bash agent's tendency to check its own work turned out to be valuable just not for accuracy, but also for surfacing problems that would have gone unnoticed with a pure SQL approach.

Bash 智能体主动检查自身工作的习惯，其价值不仅体现在提升准确率上，更在于它能主动暴露那些在纯 SQL 方案下极易被忽视的问题。

## What this means for agent design

## 这对智能体设计意味着什么

For structured data with clear schemas, SQL remains the most direct path. It's fast, well-understood, and uses fewer tokens.

对于具有明确模式（schema）的结构化数据，SQL 仍是实现目标最直接的途径。它执行速度快、广为人知，且消耗的 token 数量更少。

For exploration and verification, bash provides flexibility that SQL can't match. Agents can inspect files, spot-check results, and catch edge cases through filesystem access.

在探索性分析与结果验证方面，bash 提供了 SQL 无法比拟的灵活性。智能体可通过文件系统访问来检查文件、抽样核验结果，并捕获各类边界情况。

But the bigger lesson is about evals themselves. The back-and-forth between Braintrust and the Vercel team, with detailed traces at every step, is what actually improved the tools and the benchmark. Without that visibility, we'd still be debating which abstraction "won" based on flawed data.

但更深层的启示在于评估（evals）本身：Braintrust 与 Vercel 团队之间反复迭代、每一步都附带详尽执行轨迹（detailed traces）的合作过程，才是真正推动工具与基准测试持续优化的关键。若缺乏这种透明度，我们至今仍会基于有缺陷的数据，争论究竟哪一种抽象方式“胜出”。

## Run your own benchmarks

## 运行您自己的基准测试

The [eval harness is open source](https://github.com/braintrustdata/bash-agent-evals).

[评估框架（eval harness）已开源](https://github.com/braintrustdata/bash-agent-evals)。

You can swap in your own:

您可以替换为您自己的：

- Dataset (customer tickets, sales calls, logs, whatever you're working with)

- 数据集（客户工单、销售通话记录、日志文件——即您实际处理的任何数据）

- Agent implementations

- 智能体实现方案

- Questions that matter to your use case

- 对您具体应用场景真正关键的问题

_This post was written by_ [_Ankur Goyal_](https://x.com/ankrgyl) _and the team at_ [_Braintrust_](https://www.braintrust.dev/) _, who build evaluation infrastructure for AI applications. The eval harness is open source and integrates with_ [`just-bash`](https://justbash.dev/) _from Vercel._

_本文由_ [_Ankur Goyal_](https://x.com/ankrgyl) _与_ [_Braintrust_](https://www.braintrust.dev/) _团队共同撰写。Braintrust 致力于构建面向 AI 应用的评估基础设施。该评估框架（eval harness）为开源项目，并已集成 Vercel 推出的 [`just-bash`](https://justbash.dev/) 工具。_

[![Arpit Bhayani](images/testing-if-bash-is-all-you-need-vercel/img_003.jpg)](https://x.com/arpit_bhayani/status/2010923602561077702)

[![Arpit Bhayani](images/testing-if-bash-is-all-you-need-vercel/img_003.jpg)](https://x.com/arpit_bhayani/status/2010923602561077702)

[Arpit Bhayani](https://x.com/arpit_bhayani/status/2010923602561077702)

[Arpit Bhayani](https://x.com/arpit_bhayani/status/2010923602561077702)

· [Follow](https://x.com/intent/follow?screen_name=arpit_bhayani)

· [关注](https://x.com/intent/follow?screen_name=arpit_bhayani)

[View on Twitter](https://x.com/arpit_bhayani/status/2010923602561077702)

[在 Twitter 上查看](https://x.com/arpit_bhayani/status/2010923602561077702)

Looks like filesystems are the next big thing in AI :) Everybody is playing with it.

看来文件系统正成为 AI 领域的下一个热点 :) 每个人都在尝试探索它。

This is happening because models are trained heavily on coding tasks inside sandboxed environments with shells and filesystems. Hence, they get really good at navigating directories, reading

这背后的原因在于：当前大模型大量依赖沙箱环境（内含 Shell 和文件系统）进行编程类任务训练。因此，它们在目录导航、文件读取等方面表现得尤为出色。