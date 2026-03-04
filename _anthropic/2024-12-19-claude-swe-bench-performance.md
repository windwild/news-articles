---
render_with_liquid: false
title: "Claude SWE-Bench Performance"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/swe-bench-sonnet"
date: "2024-12-19"
scraped_at: "2026-03-03T06:52:11.349775652+00:00"
language: "en-zh"
translated: true
description: "Explore Claude's breakthrough performance on SWE-Bench, demonstrating advanced software engineering capabilities and code generation accuracy. Learn about our technical evaluation methods."
---
render_with_liquid: false
render_with_liquid: false

_Our latest model, the upgraded [Claude 3.5 Sonnet](https://www.anthropic.com/news/3-5-models-and-computer-use), achieved 49% on SWE-bench Verified, a software engineering evaluation, beating the previous state-of-the-art model's 45%. This post explains the "agent" we built around the model, and is intended to help developers get the best possible performance out of Claude 3.5 Sonnet._

我们最新推出的模型——升级版 [Claude 3.5 Sonnet](https://www.anthropic.com/news/3-5-models-and-computer-use)，在软件工程评估基准 SWE-bench Verified 上取得了 49% 的成绩，超越了此前最先进的模型（45%）。本文将介绍我们围绕该模型构建的“智能体”（agent），旨在帮助开发者充分发挥 Claude 3.5 Sonnet 的最佳性能。

[SWE-bench](https://www.swebench.com/) is an AI evaluation benchmark that assesses a model's ability to complete real-world software engineering tasks. Specifically, it tests how the model can resolve GitHub issues from popular open-source Python repositories. For each task in the benchmark, the AI model is given a set up Python environment and the checkout (a local working copy) of the repository from just before the issue was resolved. The model then needs to understand, modify, and test the code before submitting its proposed solution.

[SWE-bench](https://www.swebench.com/) 是一项面向 AI 模型的评估基准，用于衡量其完成真实世界软件工程任务的能力。具体而言，它测试模型能否解决来自热门开源 Python 仓库的 GitHub Issue。在该基准的每一项任务中，AI 模型都会被提供一个已配置好的 Python 运行环境，以及该仓库在对应 Issue 被修复前的代码检出版本（即本地工作副本）。随后，模型需理解问题、修改代码、运行测试，并最终提交其提出的解决方案。

Each solution is graded against the real unit tests from the pull request that closed the original GitHub issue. This tests whether the AI model was able to achieve the same functionality as the original human author of the PR.

每个解决方案均依据关闭原始 GitHub Issue 的 Pull Request 中所附的真实单元测试进行评分。此举旨在检验 AI 模型是否能实现与原始人类作者完全一致的功能。

SWE-bench doesn't just evaluate the AI model in isolation, but rather an entire "agent" system. In this context, an "agent" refers to the combination of an AI model and the software scaffolding around it. This scaffolding is responsible for generating the prompts that go into the model, parsing the model's output to take action, and managing the interaction loop where the result of the model's previous action is incorporated into its next prompt. The performance of an agent on SWE-bench can vary significantly based on this scaffolding, even when using the same underlying AI model.

SWE-bench 并非仅孤立地评估 AI 模型本身，而是评估一整套“智能体”（agent）系统。在此语境下，“智能体”指 AI 模型与其外围软件框架（scaffolding）的组合。该框架负责：生成输入模型的提示词（prompt）、解析模型输出以执行具体操作，以及管理交互循环——即将模型上一次操作的结果作为上下文纳入下一轮提示中。即使使用同一底层 AI 模型，不同框架设计也会导致智能体在 SWE-bench 上的表现差异显著。

There are many other benchmarks for the coding abilities of Large Language Models, but SWE-bench has gained in popularity for several reasons:

1. It uses real engineering tasks from actual projects, rather than competition- or interview-style questions;
2. It is not yet saturated—there’s plenty of room for improvement. No model has yet crossed 50% completion on SWE-bench Verified (though the updated Claude 3.5 Sonnet is, at the time of writing, at 49%);
3. It measures an entire "agent", rather than a model in isolation. Open-source developers and startups have had great success in optimizing scaffoldings to greatly improve the performance around the same model.

目前还有许多其他用于评估大语言模型编程能力的基准，但 SWE-bench 因以下几点原因而日益流行：

1. 它采用真实项目中的实际工程任务，而非竞赛式或面试风格的题目；  
2. 尚未达到性能饱和——仍有巨大提升空间。截至目前，尚无模型在 SWE-bench Verified 上突破 50% 的完成率（尽管最新版 Claude 3.5 Sonnet 当前已达 49%）；  
3. 它评估的是完整的“智能体”，而非孤立的模型本身。开源开发者与初创公司已通过优化框架设计，在不更换底层模型的前提下大幅提升了整体性能。

Note that the original SWE-bench dataset contains some tasks that are impossible to solve without additional context outside of the GitHub issue (for example, about specific error messages to return). [SWE-bench-Verified](https://openai.com/index/introducing-swe-bench-verified/) is a 500 problem subset of SWE-bench that has been reviewed by humans to make sure they are solvable, and thus provides the most clear measure of coding agents' performance. This is the benchmark to which we’ll refer in this post.

需要注意的是，原始 SWE-bench 数据集包含若干任务，若缺乏 GitHub Issue 之外的额外上下文（例如需返回特定错误消息），则无法求解。[SWE-bench-Verified](https://openai.com/index/introducing-swe-bench-verified/) 是 SWE-bench 的一个 500 题子集，经人工审核确认全部可解，因而能最清晰地反映编程智能体的实际性能。本文后续提及的基准即为此版本。

## Achieving state-of-the-art

## 达成业界领先水平

### Tool Using Agent

### 工具调用型智能体

Our design philosophy when creating the agent scaffold optimized for updated Claude 3.5 Sonnet was to give as much control as possible to the language model itself, and keep the scaffolding minimal. The agent has a prompt, a Bash Tool for executing bash commands, and an Edit Tool, for viewing and editing files and directories. We continue to sample until the model decides that it is finished, or exceeds its 200k context length. This scaffold allows the model to use its own judgment of how to pursue the problem, rather than be hardcoded into a particular pattern or workflow.

我们在为升级版 Claude 3.5 Sonnet 构建智能体框架时的设计理念是：尽可能将决策权交予语言模型自身，同时保持框架极简。该智能体包含一个提示词（prompt）、一个用于执行 Bash 命令的 Bash 工具，以及一个用于查看和编辑文件及目录的编辑工具（Edit Tool）。我们持续采样，直至模型自主判定任务完成，或超出其 200K 的上下文长度限制。这一轻量级框架使模型得以凭借自身判断决定如何推进问题求解，而非被硬编码进某种固定模式或工作流中。

The prompt outlines a suggested approach for the model, but it’s not overly long or too detailed for this task. The model is free to choose how it moves from step to step, rather than having strict and discrete transitions. If you are not token-sensitive, it can help to explicitly encourage the model to produce a long response.

该提示为模型提供了一种建议性的工作流程，但其长度和细节程度对此任务而言恰到好处，并不过于冗长或繁琐。模型可自由决定各步骤之间的推进方式，无需遵循严格、离散的转换逻辑。若你对 token 数量不敏感，明确鼓励模型生成较长的响应往往有助于提升推理质量。

The following code shows the prompt from our agent scaffold:

以下代码展示了我们智能体（agent）框架所使用的提示词（prompt）：

```
<uploaded_files>
{location}
</uploaded_files>
I've uploaded a python code repository in the directory {location} (not in /tmp/inputs). Consider the following PR description:

<pr_description>
{pr_description}
</pr_description>

Can you help me implement the necessary changes to the repository so that the requirements specified in the <pr_description> are met?
I've already taken care of all changes to any of the test files described in the <pr_description>. This means you DON'T have to modify the testing logic or any of the tests in any way!

Your task is to make the minimal changes to non-tests files in the {location} directory to ensure the <pr_description> is satisfied.

Follow these steps to resolve the issue:
1. As a first step, it might be a good idea to explore the repo to familiarize yourself with its structure.
2. Create a script to reproduce the error and execute it with `python <filename.py>` using the BashTool, to confirm the error
3. Edit the sourcecode of the repo to resolve the issue
4. Rerun your reproduce script and confirm that the error is fixed!
5. Think about edgecases and make sure your fix handles them as well

Your thinking should be thorough and so it's fine if it's very long.
```

```
<uploaded_files>
{location}
</uploaded_files>
我已在目录 `{location}`（而非 `/tmp/inputs`）中上传了一个 Python 代码仓库。请参考以下 Pull Request 描述：

<pr_description>
{pr_description}
</pr_description>

您能否协助我对该仓库实施必要修改，以满足 `<pr_description>` 中提出的所有要求？  
我已经完成了 `<pr_description>` 中提及的所有测试文件（test files）的修改。这意味着：**您完全无需修改任何测试逻辑，也无需改动任何测试用例！**

您的任务是：在 `{location}` 目录下，仅对**非测试文件**（non-test files）做出**最小必要修改**，确保 `<pr_description>` 的全部要求得以满足。

请按以下步骤解决问题：
1. 首先，建议您浏览仓库结构，以便熟悉整体组织与代码布局；
2. 编写一个可复现错误的脚本，并通过 BashTool 执行 `python <filename.py>`，以确认当前错误确实存在；
3. 修改仓库中的源代码，修复该问题；
4. 再次运行您编写的复现脚本，验证错误是否已被成功修复；
5. 思考潜在的边界情况（edge cases），并确保您的修复方案能稳健地覆盖这些情形。

您的思考过程应力求全面深入——因此，即使输出非常长，也完全是可以接受的。
```

Copy

复制

The model's first tool executes Bash commands. The schema is simple, taking only the command to be run in the environment. However, the description of the tool carries more weight. It includes more detailed instructions for the model, including escaping inputs, lack of internet access, and how to run commands in the background.

该模型首个可用工具用于执行 Bash 命令。其接口定义十分简洁，仅需传入待执行的命令字符串。但该工具的**描述文本**却至关重要——其中包含了面向模型的详细使用说明，例如：输入内容需正确转义（escaping）、环境中无互联网访问权限，以及如何在后台运行命令等关键约束与指引。

Next, we show the spec for the Bash Tool:

接下来，我们展示 Bash 工具的规范定义：

```
{
   "name": "bash",
   "description": "Run commands in a bash shell\n
* When invoking this tool, the contents of the \"command\" parameter does NOT need to be XML-escaped.\n
* You don't have access to the internet via this tool.\n
* You do have access to a mirror of common linux and python packages via apt and pip.\n
* State is persistent across command calls and discussions with the user.\n
* To inspect a particular line range of a file, e.g. lines 10-25, try 'sed -n 10,25p /path/to/the/file'.\n
* Please avoid commands that may produce a very large amount of output.\n
* Please run long lived commands in the background, e.g. 'sleep 10 &' or start a server in the background.",
   "input_schema": {
       "type": "object",
       "properties": {
           "command": {
               "type": "string",
               "description": "The bash command to run."
           }
       },
       "required": ["command"]
   }
}
```

```
{
   "name": "bash",
   "description": "在 bash shell 中执行命令\n
* 调用此工具时，“command”参数的内容无需进行 XML 转义。\n
* 你无法通过该工具访问互联网。\n
* 你可以通过 apt 和 pip 访问常见 Linux 和 Python 包的镜像仓库。\n
* 状态在多次命令调用及与用户的对话中保持持久化。\n
* 若要检查文件的某一行范围（例如第 10–25 行），可尝试运行：'sed -n 10,25p /path/to/the/file'。\n
* 请避免使用可能产生大量输出的命令。\n
* 请将长时间运行的命令置于后台执行，例如：'sleep 10 &'，或以后台方式启动服务器。",
   "input_schema": {
       "type": "object",
       "properties": {
           "command": {
               "type": "string",
               "description": "要执行的 bash 命令。"
           }
       },
       "required": ["command"]
   }
}
```

Copy

复制

The model's second tool (the Edit Tool) is much more complex, and contains everything the model needs for viewing, creating, and editing files. Again, our tool description contains detailed information for the model about how to use the tool.

模型的第二个工具（即编辑工具）则复杂得多，它囊括了模型查看、创建和编辑文件所需的一切功能。同样，我们的工具描述为模型提供了关于如何使用该工具的详尽说明。

We put a lot of effort into the descriptions and specs for these tools across a wide variety of agentic tasks. We tested them to uncover any ways that the model might misunderstand the spec, or the possible pitfalls of using the tools, then edited the descriptions to preempt these problems. We believe that much more attention should go into designing tool interfaces for models, in the same way that a large amount of attention goes into designing tool interfaces for humans.

我们在多种智能体任务场景下，对这些工具的描述与规范投入了大量精力。我们通过测试，识别出模型可能误解规范之处，或使用工具时可能遭遇的潜在风险，并据此反复修订描述内容，以提前规避这些问题。我们认为，为大模型设计工具接口所应投入的关注度，应当不亚于为人类用户设计工具界面时所付出的努力。

The following code shows the description for our Edit Tool:

以下代码展示了我们的编辑工具（Edit Tool）的描述：

```
{
   "name": "str_replace_editor",
   "description": "Custom editing tool for viewing, creating and editing files\n
* State is persistent across command calls and discussions with the user\n
* If `path` is a file, `view` displays the result of applying `cat -n`. If `path` is a directory, `view` lists non-hidden files and directories up to 2 levels deep\n
* The `create` command cannot be used if the specified `path` already exists as a file\n
* If a `command` generates a long output, it will be truncated and marked with `<response clipped>` \n
* The `undo_edit` command will revert the last edit made to the file at `path`\n
\n
Notes for using the `str_replace` command:\n
* The `old_str` parameter should match EXACTLY one or more consecutive lines from the original file. Be mindful of whitespaces!\n
* If the `old_str` parameter is not unique in the file, the replacement will not be performed. Make sure to include enough context in `old_str` to make it unique\n
* The `new_str` parameter should contain the edited lines that should replace the `old_str`",
...
```

```
{
   "name": "str_replace_editor",
   "description": "用于查看、创建和编辑文件的自定义编辑工具\n
* 状态在多次命令调用及与用户的对话中保持持久化。\n
* 若 `path` 指向一个文件，则 `view` 命令将显示执行 `cat -n` 后的结果；若 `path` 指向一个目录，则 `view` 将列出该目录下非隐藏的文件与子目录（最多递归两层）。\n
* 若指定的 `path` 已作为文件存在，则不可使用 `create` 命令。\n
* 若某条 `command` 生成了过长的输出，该输出将被截断，并标记为 `<response clipped>`。\n
* `undo_edit` 命令将撤销对 `path` 所指文件所做的最后一次编辑。\n
\n
使用 `str_replace` 命令的注意事项：\n
* `old_str` 参数必须**严格匹配**原始文件中**连续的一行或多行内容**；请注意空格等空白字符！\n
* 若 `old_str` 在文件中不具有唯一性（即出现多次或零次），替换操作将不会执行。请确保 `old_str` 中包含足够上下文，使其在文件中唯一。\n
* `new_str` 参数应包含将用于替换 `old_str` 的已编辑后的内容行。",
...
```

Copy

复制

One way we improved performance was to "error-proof" our tools. For instance, sometimes models could mess up relative file paths after the agent had moved out of the root directory. To prevent this, we simply made the tool always require an absolute path.

提升性能的方法之一是让我们的工具具备“防错能力”（error-proofing）。例如，当智能体离开根目录后，模型有时会错误地处理相对路径。为防止此类问题，我们直接规定该工具始终只接受绝对路径。

We experimented with several different strategies for specifying edits to existing files and had the highest reliability with string replacement, where the model specifies \`old\_str\` to replace with \`new\_str\` in the given file. The replacement will only occur if there is exactly one match of \`old\_str\`. If there are more or fewer matches, the model is shown an appropriate error message for it to retry.

我们尝试了多种针对现有文件进行编辑的策略，其中以字符串替换（string replacement）方式可靠性最高：模型需在给定文件中指定待替换的字符串 \`old\_str\` 及其替换内容 \`new\_str\`。仅当文件中存在**且仅存在一个**完全匹配的 \`old\_str\` 时，替换才会执行；若匹配数量多于或少于一个，系统将向模型返回相应的错误提示，引导其重试。

我们编辑工具（Edit Tool）的规范如下所示：

```
...
   "input_schema": {
       "type": "object",
       "properties": {
           "command": {
               "type": "string",
               "enum": ["view", "create", "str_replace", "insert", "undo_edit"],
               "description": "要执行的命令。允许的取值为：`view`（查看）、`create`（创建）、`str_replace`（字符串替换）、`insert`（插入）、`undo_edit`（撤销编辑）。"
           },
           "file_text": {
               "description": "`create` 命令的必需参数，表示待创建文件的内容。",
               "type": "string"
           },
           "insert_line": {
               "description": "`insert` 命令的必需参数。`new_str` 将被插入至 `path` 所指定文件中第 `insert_line` 行之后。",
               "type": "integer"
           },
           "new_str": {
               "description": "`str_replace` 命令的必需参数，表示用于替换的新字符串；同时也是 `insert` 命令的必需参数，表示待插入的字符串。",
               "type": "string"
           },
           "old_str": {
               "description": "`str_replace` 命令的必需参数，表示 `path` 所指定文件中待被替换的原始字符串。",
               "type": "string"
           },
           "path": {
               "description": "文件或目录的绝对路径，例如 `/repo/file.py` 或 `/repo`。",
               "type": "string"
           },
           "view_range": {
               "description": "`view` 命令的可选参数（仅当 `path` 指向文件时有效）。若未提供该参数，则显示整个文件；若提供，则仅显示指定行号范围内的内容（例如 `[11, 12]` 表示显示第 11 和第 12 行）。行号从 1 开始计数；若设置为 `[start_line, -1]`，则显示从 `start_line` 行至文件末尾的所有内容。",
               "items": {
                   "type": "integer"
               },
               "type": "array"
           }
       },
       "required": ["command", "path"]
   }
}
```

复制并展开

## 结果

总体而言，升级版 Claude 3.5 Sonnet 在推理能力、编程能力与数学能力方面均优于我们此前的模型，也超越了此前的[业界最佳水平（SOTA）模型](https://solverai.com/)。此外，其智能体（agentic）能力亦得到显著提升：工具与框架支撑体系能更有效地将这些增强的能力转化为实际效能。

| 模型 | **Claude 3.5 Sonnet（新版）** | 此前业界最佳（Previous SOTA） | Claude 3.5 Sonnet（旧版） | Claude 3 Opus |
| --- | --- | --- | --- | --- |
| SWE-bench Verified 得分 | 49% | 45% | 33% | 22% |

以上为部分模型在 SWE-bench Verified 基准测试中的得分（全部采用本智能体框架）。

## 智能体行为示例

在运行基准测试时，我们以 [SWE-Agent](https://swe-agent.com/) 框架为基础构建了智能体代码。在下方日志中，我们将智能体的文本输出、工具调用及工具响应分别标记为 THOUGHT（思考）、ACTION（动作）和 OBSERVATION（观察），尽管我们并未强制模型严格遵循固定顺序。

下方代码块将逐步展示 Sonnet 3.5 解决一个 SWE-bench 问题的典型过程。

In this first block, you can see part of the initial prompt given to the model, with `{pr_description}` filled in with the real value from a SWE-bench task. Importantly, this task contains steps to reproduce the issue, which will give the model a valuable starting point to investigate.

在第一个模块中，您可以看到提供给模型的初始提示的一部分，其中 `{pr_description}` 已被 SWE-bench 任务中的实际内容所填充。尤为重要的是，该任务包含了复现问题的步骤，这将为模型提供一个宝贵的起点，以开展问题调查。

```
<uploaded_files>
/repo
</uploaded_files>
I've uploaded a python code repository in the directory /repo (not in /tmp/inputs). Consider the following PR description:

<pr_description>
linear_model.RidgeClassifierCV's Parameter store_cv_values issue
#### Description
Parameter store_cv_values error on sklearn.linear_model.RidgeClassifierCV

#### Steps/Code to Reproduce
import numpy as np
from sklearn import linear_model as lm

#test database
n = 100
x = np.random.randn(n, 30)
y = np.random.normal(size = n)

rr = lm.RidgeClassifierCV(alphas = np.arange(0.1, 1000, 0.1), normalize = True,
                                         store_cv_values = True).fit(x, y)

#### Expected Results
Expected to get the usual ridge regression model output, keeping the cross validation predictions as attribute.

#### Actual Results
TypeError: __init__() got an unexpected keyword argument 'store_cv_values'

lm.RidgeClassifierCV actually has no parameter store_cv_values, even though some attributes depends on it.
```

```
<uploaded_files>
/repo
</uploaded_files>
我已在目录 `/repo`（而非 `/tmp/inputs`）下上传了一个 Python 代码仓库。请参考以下 PR 描述：

<pr_description>
linear_model.RidgeClassifierCV 的参数 `store_cv_values` 问题
#### 描述
`sklearn.linear_model.RidgeClassifierCV` 中参数 `store_cv_values` 报错

#### 复现步骤/代码
import numpy as np
from sklearn import linear_model as lm

# 测试数据集
n = 100
x = np.random.randn(n, 30)
y = np.random.normal(size = n)

rr = lm.RidgeClassifierCV(alphas = np.arange(0.1, 1000, 0.1), normalize = True,
                                         store_cv_values = True).fit(x, y)

#### 期望结果
应正常返回岭回归模型的标准输出，并将交叉验证预测结果作为模型属性保存。

#### 实际结果
TypeError: __init__() 得到了意外的关键字参数 'store_cv_values'

实际上，`lm.RidgeClassifierCV` 并不支持 `store_cv_values` 参数，尽管其部分属性依赖于该参数。
```

模型作出响应，并首先使用编辑工具（Edit Tool）查看仓库结构。您可以在 `THOUGHT` 和 `ACTION` 下看到模型的文本输出及工具调用参数，在 `OBSERVATION` 下看到工具输出的部分内容：

```
THOUGHT:
I'll help you implement the changes to satisfy the PR description. Let's follow the steps you outlined.

1. First, let's explore the repo structure:
ACTION (str_replace_editor):
command:
view

path:
/repo

OBSERVATION:
Here's the files and directories up to 2 levels deep in /repo, excluding hidden items:
/repo
/repo/PULL_REQUEST_TEMPLATE.md
/repo/ISSUE_TEMPLATE.md
/repo/sklearn
/repo/sklearn/decomposition
/repo/sklearn/kernel_ridge.py
/repo/sklearn/model_selection
/repo/sklearn/covariance
/repo/sklearn/cluster
/repo/sklearn/base.py
/repo/sklearn/dummy.py
/repo/sklearn/naive_bayes.py
...
```

复制

现在，模型已更清晰地了解仓库结构，于是使用编辑工具创建一个新脚本，用于复现问题并测试其修复方案：

```
THOUGHT:
Based on the repository structure, we'll need to modify the Ridge Classifier in the `sklearn/linear_model` directory.

Let's create a script to reproduce the error:
ACTION (str_replace_editor):
command:
create

path:
/repo/reproduce_error.py
```

file_text:
import numpy as np
from sklearn import linear_model as lm

#test database
n = 100
x = np.random.randn(n, 30)
y = np.random.normal(size = n)

rr = lm.RidgeClassifierCV(alphas=np.arange(0.1, 1000, 0.1), normalize=True,
                         store_cv_values=True).fit(x, y)

文件文本：
import numpy as np
from sklearn import linear_model as lm

# 测试数据库
n = 100
x = np.random.randn(n, 30)
y = np.random.normal(size = n)

rr = lm.RidgeClassifierCV(alphas=np.arange(0.1, 1000, 0.1), normalize=True,
                         store_cv_values=True).fit(x, y)

OBSERVATION:
File created successfully at: /repo/reproduce_error.py
```

OBSERVATION:
文件已成功创建于：/repo/reproduce_error.py
```

Copy

Copy

The model then uses the Bash Tool to execute the script it wrote, and successfully reproduces the issue from the task:

该模型随后使用 Bash 工具执行其编写的脚本，并成功复现了任务中描述的问题：

```
THOUGHT:
Let's verify that we can reproduce the error:
ACTION (bash):
command:
python3 /repo/reproduce_error.py

```
```
THOUGHT:
让我们验证是否能够复现该错误：
ACTION (bash):
command:
python3 /repo/reproduce_error.py

OBSERVATION:
Traceback (most recent call last):
  File "/repo/reproduce_error.py", line 10, in <module>
    store_cv_values=True).fit(x, y)
TypeError: __init__() got an unexpected keyword argument 'store_cv_values'
```

OBSERVATION:
回溯（最近一次调用）：
  文件 "/repo/reproduce_error.py"，第 10 行，在 <module> 中
    store_cv_values=True).fit(x, y)
TypeError: __init__() 得到了意外的关键字参数 'store_cv_values'
```

Copy

Copy

From here on, the model uses the Edit Tool to change the source code in the repository and reruns its script to verify whether the change has resolved the issue:

自此之后，该模型使用编辑（Edit）工具修改仓库中的源代码，并重新运行脚本，以验证所作修改是否已解决该问题：

THOUGHT:  
The error is reproducible. Looking at the code, I can see that the issue is that while the `RidgeClassifierCV` class inherits from `_BaseRidgeCV`, it fails to pass the `store_cv_values` parameter from its constructor through to the base class constructor.  

思考：  
该错误可稳定复现。通过查看代码，我发现问题是：`RidgeClassifierCV` 类虽继承自 `_BaseRidgeCV`，但其构造函数并未将 `store_cv_values` 参数传递给父类构造函数。

Let's fix this:  
我们来修复这个问题：

ACTION (str_replace_editor):  
command:  
str_replace  

操作（字符串替换编辑器）：  
命令：  
str_replace  

path:  
/repo/sklearn/linear_model/ridge.py  

路径：  
/repo/sklearn/linear_model/ridge.py  

old_str:  
    def __init__(self, alphas=(0.1, 1.0, 10.0), fit_intercept=True,  
                 normalize=False, scoring=None, cv=None, class_weight=None):  
        super(RidgeClassifierCV, self).__init__(  
            alphas=alphas, fit_intercept=fit_intercept, normalize=normalize,  
            scoring=scoring, cv=cv)  
        self.class_weight = class_weight  

原字符串：  
    def __init__(self, alphas=(0.1, 1.0, 10.0), fit_intercept=True,  
                 normalize=False, scoring=None, cv=None, class_weight=None):  
        super(RidgeClassifierCV, self).__init__(  
            alphas=alphas, fit_intercept=fit_intercept, normalize=normalize,  
            scoring=scoring, cv=cv)  
        self.class_weight = class_weight  

new_str:  
    def __init__(self, alphas=(0.1, 1.0, 10.0), fit_intercept=True,  
                 normalize=False, scoring=None, cv=None, class_weight=None,  
                 store_cv_values=False):  
        super(RidgeClassifierCV, self).__init__(  
            alphas=alphas, fit_intercept=fit_intercept, normalize=normalize,  
            scoring=scoring, cv=cv, store_cv_values=store_cv_values)  
        self.class_weight = class_weight  

新字符串：  
    def __init__(self, alphas=(0.1, 1.0, 10.0), fit_intercept=True,  
                 normalize=False, scoring=None, cv=None, class_weight=None,  
                 store_cv_values=False):  
        super(RidgeClassifierCV, self).__init__(  
            alphas=alphas, fit_intercept=fit_intercept, normalize=normalize,  
            scoring=scoring, cv=cv, store_cv_values=store_cv_values)  
        self.class_weight = class_weight  

In this particular example, the model worked for 12 steps before deciding that it was ready to submit. The task's tests then ran successfully, verifying that the model's solution addressed the problem. Some tasks took more than 100 turns before the model submitted its solution; in others, the model kept trying until it ran out of context.  

在此特定示例中，模型经过 12 步推理后判定已准备好提交解决方案。随后任务的测试顺利运行并通过，验证了模型的解决方案确实解决了问题。部分任务耗时超过 100 轮才完成提交；而在另一些任务中，模型持续尝试直至上下文长度耗尽。

From reviewing attempts from the updated Claude 3.5 Sonnet compared to older models, updated 3.5 Sonnet self-corrects more often. It also shows an ability to try several different solutions, rather than getting stuck making the same mistake over and over.  

通过对比新版 Claude 3.5 Sonnet 与旧版模型的尝试过程可见，更新后的 3.5 Sonnet 更频繁地进行自我修正；同时展现出尝试多种不同解决方案的能力，而非反复陷入同一错误而无法脱身。

## Challenges  

## 挑战  

SWE-bench Verified is a powerful evaluation, but it’s also more complex to run than simple, single-turn evals. These are some of the challenges that we faced in using it—challenges that other AI developers might also encounter.  

SWE-bench Verified 是一项功能强大的评估基准，但其运行复杂度远高于简单的单轮次评估。以下是我们使用过程中所面临的一些挑战——这些挑战其他 AI 开发者也可能遇到。

1. **Duration and high token costs.**  
1. **耗时长且 Token 成本高。**

The examples above are from a case that was successfully completed in 12 steps. However, many successful runs took hundreds of turns for the model to resolve, and >100k tokens. The updated Claude 3.5 Sonnet is tenacious: it can often find its way around a problem given enough time, but that can be expensive;  
上述示例来自一个在 12 步内成功完成的案例。然而，许多成功运行需模型历经数百轮交互才能解决，消耗 Token 超过 10 万。升级版 Claude 3.5 Sonnet 极具韧性：只要给予足够时间，它往往能绕过问题找到解决方案，但这一过程成本高昂；

2. **Grading.**  
2. **评分机制。**

While inspecting failed tasks, we found cases where the model behaved correctly, but there were environment setup issues, or problems with install patches being applied twice. Resolving these systems issues is crucial for getting an accurate picture of an AI agent's performance.  
在检查失败任务时，我们发现一些情况下模型行为本身是正确的，但存在环境配置问题，或安装补丁被重复应用等系统性问题。解决这些底层系统问题，对于准确评估 AI 智能体的实际性能至关重要。

3. **Hidden tests.**  
3. **隐藏测试用例。**

Because the model cannot see the tests it's being graded against, it often “thinks” that it has succeeded when the task actually is a failure. Some of these failures are because the model solved the problem at the wrong level of abstraction (applying a bandaid instead of a deeper refactor). Other failures feel a little less fair: they solve the problem, but do not match the unit tests from the original task.  
由于模型无法看到用于评分的测试用例，它常常“误以为”任务已成功完成，而实际上任务已失败。部分失败源于模型在错误的抽象层级上解决问题（例如仅打补丁式修复，而非进行更深层的重构）；另一些失败则显得略欠公平：模型确实解决了问题，却未能通过原始任务所要求的单元测试。

4. **Multimodal.**  
4. **多模态能力。**

Despite the updated Claude 3.5 Sonnet having excellent vision and multimodal capabilities, we did not implement a way for it to view files saved to the filesystem or referenced as URLs. This made debugging certain tasks (especially those from Matplotlib) especially difficult, and also prone to model hallucinations. There is definitely low-hanging fruit here for developers to improve upon—and SWE-bench has launched a new [evaluation focused on multi-modal tasks](https://www.swebench.com/multimodal.html). We look forward to seeing developers achieve higher scores on this eval with Claude in the near future.  
尽管升级版 Claude 3.5 Sonnet 具备出色的视觉与多模态能力，但我们尚未实现让其查看保存在文件系统中的文件或通过 URL 引用的资源的功能。这使得调试某些任务（尤其是涉及 Matplotlib 的任务）尤为困难，也更容易引发模型幻觉。此处显然存在大量易于改进的优化空间——SWE-bench 已正式推出一项全新[面向多模态任务的专项评测](https://www.swebench.com/multimodal.html)。我们期待开发者在不久的将来，借助 Claude 在此项评测中取得更高分数。

The upgraded Claude 3.5 Sonnet achieved 49% on SWE-bench Verified, beating the previous state-of-the-art (45%), with a simple prompt and two general purpose tools. We feel confident that developers building with the new Claude 3.5 Sonnet will quickly find new, better ways to improve SWE-bench scores over what we've initially demonstrated here.  
升级版 Claude 3.5 Sonnet 在 SWE-bench Verified 上取得了 49% 的成绩，超越此前最优水平（45%），且仅依赖一条简洁提示词与两个通用工具。我们有信心，使用新版 Claude 3.5 Sonnet 进行开发的工程师，将迅速探索出比本文初步演示更优、更高效的方法，进一步提升 SWE-bench 分数。

## Acknowledgements  

## 致谢  

Erik Schluntz optimized the SWE-bench agent and wrote this blog post. Simon Biggs, Dawn Drain, and Eric Christiansen helped implement the benchmark. Shauna Kravec, Dawn Drain, Felipe Rosso, Nova DasSarma, Ven Chandrasekaran, and many others contributed to training Claude 3.5 Sonnet to be excellent at agentic coding.  
Erik Schluntz 优化了 SWE-bench 智能体并撰写了本文博客。Simon Biggs、Dawn Drain 与 Eric Christiansen 协助实现了该基准测试。Shauna Kravec、Dawn Drain、Felipe Rosso、Nova DasSarma、Ven Chandrasekaran 等众多贡献者共同参与了 Claude 3.5 Sonnet 的训练工作，使其在智能体式编程（agentic coding）方面表现卓越。

[Engineering at Anthropic](https://www.anthropic.com/engineering)  
[Anthropic 工程团队](https://www.anthropic.com/engineering)

![](images/claude-swe-bench-performance/img_001.svg)  
![](images/claude-swe-bench-performance/img_001.svg)

# Raising the bar on SWE-bench Verified with Claude 3.5 Sonnet  

# 借助 Claude 3.5 Sonnet 提升 SWE-bench Verified 评测基准线  

Published Jan 06, 2025  
发布于 2025 年 1 月 6 日  

SWE-bench is an AI evaluation benchmark that assesses a model's ability to complete real-world software engineering tasks.  
SWE-bench 是一项 AI 评测基准，旨在评估模型完成真实世界软件工程任务的能力。

## Get the developer newsletter  

## 订阅开发者简报

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

产品更新、操作指南、社区亮点等内容，每月发送至您的邮箱。