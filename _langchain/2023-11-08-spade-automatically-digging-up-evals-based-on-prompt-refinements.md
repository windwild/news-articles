---
title: "♠️ SPADE: Automatically Digging up Evals based on Prompt Refinements"
source: "LangChain Blog"
url: "https://blog.langchain.com/spade-automatically-digging-up-evals-based-on-prompt-refinements/"
date: "2023-11-08"
scraped_at: "2026-03-03T08:29:08.941150586+00:00"
language: "en-zh"
translated: true
---
{% raw %}

_作者：Shreya Shankar（加州大学伯克利分校），与李浩天（香港科技大学）、Will Fu-Hinthorn（LangChain）、Harrison Chase（LangChain）、J.D. Zamfirescu-Pereira（加州大学伯克利分校）、林一鸣（加州大学伯克利分校）、Sam Noyes（LangChain）、Eugene Wu（哥伦比亚大学）、Aditya Parameswaran（加州大学伯克利分校）合作完成_

💡

关键链接：

\- 使用 [SPADE](https://spade-beta.streamlit.app/?ref=blog.langchain.com) 发现您提示词（prompts）的评估建议。

\- 填写 [意向表单](https://forms.gle/ph3Y6nTZWhPn3w8W8?ref=blog.langchain.com)，与加州大学伯克利分校的研究人员取得联系。

\- 尝试使用 [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) 和 [Hub](https://smith.langchain.com/hub?ref=blog.langchain.com)，构建并进行大语言模型（LLM）应用的版本控制。

许多组织迫切希望在生产环境中将大语言模型（LLMs）应用于自动化流水线（或称“链”，chains）。当提示词设计得当时，LLMs 能够大规模地理解并生成数据与代码，其应用场景覆盖众多领域。

但针对**定制化任务评估 LLM 链**却极为困难：提示工程（prompt engineering）是一种临时性、迭代式的过程；大多数人只是在摸索中将一条链部署上线，既缺乏清晰的进展感知，也无法准确预估该链在生产环境中的实际表现。当我们围绕 LLM 构建链时，很难将原本依赖主观直觉的“氛围检查”（“vibe checks”）——即对 LLM 输出质量的粗略判断——规模化。研究表明，像 [GPT-4 这样强大的模型](https://arxiv.org/abs/2309.13633?ref=blog.langchain.com)，在获得明确评估指令后，可作为有效的评估器；但要设计出一套完整的评估指标体系（scorecard）——包括应衡量哪些维度、如何定义各项指标，以及配套的评估提示词——绝非易事。

在加州大学伯克利分校，我们一直在思考：**如何为定制化的 LLM 链自动生成实用的评估函数？** 我们发现，人们在反复迭代提示词的过程中，往往已将关键评估标准、安全护栏（guardrails）和约束条件等，隐含在一次次提示词的优化调整（refinements）或修改之中。理解提示词的版本演进历史——我们称之为“提示词优化分析”（prompt refinement analysis）——本身已有若干显见用途，例如自动生成提示词，或构建用于微调（fine-tuning）的数据集。但若这种分析还能进一步识别出有价值的评估函数呢？这看似一项极富挑战性的任务，但事实证明：只要巧妙地进行任务分解，我们完全可以用一个大语言模型来实现！

我们正在开发一款名为 [**SPADE ♠**](https://spade-beta.streamlit.app/?ref=blog.langchain.com)（Prompt Analysis and Delta-based Evaluation System，即“提示词分析与基于差异的评估系统”）的工具，用以自动推荐评估方案。我们非常高兴能与 LangChain 合作推进本项目，并正式发布 SPADE 的原型版本。您只需粘贴自己的提示词，或提供 LangSmith 中提示词的版本历史链接；SPADE 将基于您的提示词优化轨迹，为您推荐可在全部链输入-输出对（即 prompt-response 对）上运行的 Python 评估函数。这些评估函数的复杂度各异：从简单断言 LLM 回复是否符合特定格式（例如 JSON 对象中是否包含指定键，或 Markdown 文本中是否含有指定标题），到严格验证 LLM 回复是否未虚构超出提示词所提供范围的资料来源（即是否“幻觉”）。

In this blog post, I’ll explain how the tool works.

在本篇博客文章中，我将解释该工具的工作原理。

## Digging into LLM evals with SPADE ♠

## 借助 SPADE ♠ 深入探索大语言模型评估

Before I explain how SPADE works, I’ll describe a concrete application of LLM chains and evaluation challenges. I started learning about LLM chain deployment challenges in May when I started working with [Alta](https://styledbyalta.com/?ref=blog.langchain.com), a startup building an AI-enabled personal stylist and shopping assistant, to help solve some MLOps problems. Alta uses an LLM chain to suggest an outfit (i.e., top, bottom, shoes, etc) to wear for a user-specified event, like a business meeting or work event.

在解释 SPADE 的工作原理之前，我先介绍一个大语言模型（LLM）链的实际应用场景及其评估挑战。今年五月，我开始与初创公司 [Alta](https://styledbyalta.com/?ref=blog.langchain.com) 合作，协助其解决部分 MLOps 问题；Alta 正在构建一款基于人工智能的个人穿搭顾问与购物助手。Alta 使用一条 LLM 链，根据用户指定的场合（例如商务会议或职场活动）为其推荐一套穿搭（如上衣、下装、鞋子等）。

For Alta’s LLM chain, while initial prompt engineering demonstrated impressive outfits, users found many errors during deployment. Sometimes the LLM would return two items of the same category in an outfit. Sometimes the LLM would return an incomplete outfit (e.g., no shoes),  or an inappropriate outfit (like rain boots in a fancy outfit for a dry day). The fastest way to “fix” the bugs was to add new instructions to the prompt, like “don’t recommend rain boots when it’s not raining.” But these refinements eventually piled up and made the prompts large, and there was no real guarantee that the LLM was following every instruction.

在 Alta 的 LLM 链中，尽管初始提示工程（prompt engineering）生成的穿搭令人印象深刻，但上线部署后用户却发现了大量错误：有时模型会在同一套穿搭中重复推荐同一类别的单品（例如两件上衣）；有时返回的穿搭不完整（例如缺少鞋子）；有时甚至推荐了不合时宜的搭配（例如在晴天为正式场合推荐雨靴）。最快速的“修复”方式是向提示词中添加新指令，例如：“若未下雨，则不得推荐雨靴。” 然而，这类修补性指令不断累积，导致提示词日益冗长，且无法真正保证 LLM 严格遵守每一条指令。

Smarter monitoring of LLM responses–based on what developers implicitly encode in their refinements to prompts–will significantly improve LLM deployment reliability. SPADE sits on top of prompt version history, suggesting evaluation functions based on the very prompt refinements themselves. Here’s an example of how this is done at Alta. Consider V1 and V2 of a prompt:

更智能地监控 LLM 响应——即依据开发者在提示词迭代中隐式编码的意图——将显著提升 LLM 部署的可靠性。SPADE 构建于提示词版本历史之上，能基于提示词自身的迭代变更，自动建议相应的评估函数。以下是在 Alta 实际应用中的一个示例：考虑某提示词的两个版本 V1 和 V2：

V1: “Suggest 5 apparel items to wear to {event}. Return your answer as a Python list of strings”

V1：“为{event}场合推荐 5 件服饰单品。请以 Python 字符串列表形式返回答案。”

V2: “A client ( **{client\_genders})** wants to be styled for {event}. Suggest 5 apparel items for **{client\_pronoun}** to wear. For wedding-related events, **don’t suggest any white items** unless the client explicitly states that they want to be styled for their wedding. Return your answer as a python list of strings”

V2：“一位客户（**{client\_genders}**）希望为{event}场合进行穿搭造型。请为**{client\_pronoun}**推荐 5 件服饰单品。对于婚礼相关场合，**除非客户明确表示需为其婚礼造型，否则不得推荐任何白色单品**。请以 Python 字符串列表形式返回答案。”

SPADE first finds the diff between the versions, i.e., any new instructions that didn’t exist in v1. In this example, SPADE will find **two new placeholders** (genders and pronoun), and an **instruction to exclude** white items for wedding-related events. Then, SPADE uses an LLM to categorize this diff based on a taxonomy we created that describes how prompts change (Figure 1).

SPADE 首先比对两个版本间的差异，即识别出 V1 中不存在的新指令。在此例中，SPADE 将识别出**两个新增占位符**（genders 和 pronoun），以及一条针对婚礼相关场合的**排除白色单品的指令**。随后，SPADE 调用一个大语言模型，依据我们构建的一套提示词变更分类体系（taxonomy），对该差异进行归类（见图 1）。

For each category identified, SPADE prompts an LLM to write a relevant Python evaluation function. SPADE’s suggested evaluation functions accept prompt and response pairs as arguments and return boolean values (i.e., True or False) so they can be aggregated and visualized across many chain runs.  These functions can run without LLMs (e.g., check if a response can be parsed as JSON or have specific keys) or leverage a helper function that submits a yes-or-no question to an LLM or human expert.

针对每个识别出的类别，SPADE 会调用大语言模型生成对应的 Python 评估函数。SPADE 所建议的评估函数以提示词（prompt）和响应（response）组合作为输入参数，并返回布尔值（True 或 False），从而支持跨大量链式调用进行聚合统计与可视化分析。这些函数既可完全脱离大语言模型独立运行（例如：检查响应是否可解析为合法 JSON，或是否包含特定字段），也可调用辅助函数，将是非判断类问题提交给大语言模型或人类专家进行判定。

![](images/spade-automatically-digging-up-evals-based-on-prompt-refinements/img_001.jpg)_Figure 1: SPADE’s taxonomy of prompt refinements and corresponding examples. We developed this taxonomy based on version history for many chains on_ [_LangSmith_](https://smith.langchain.com/?ref=blog.langchain.com) _, which was provided by our collaborators at LangChain._

![](images/spade-automatically-digging-up-evals-based-on-prompt-refinements/img_001.jpg)  
图 1：SPADE 提示词优化类型学及其对应示例。该分类体系基于我们在 LangChain 合作伙伴提供的 [_LangSmith_](https://smith.langchain.com/?ref=blog.langchain.com) 平台上多个链式流程的版本历史数据构建而成。

Putting this all together, for our example, SPADE would tag the diff with Data Integration and Exclusion Instruction categories. Since only the Exclusion Instruction category implies a new evaluation function in our taxonomy, SPADE would only suggest one eval: a function that checks whether the prompt contains an event related to a wedding, and if so, checks that the color “white” is not included in the response.

综上所述，在本示例中，SPADE 将对差异（diff）打上“数据集成”（Data Integration）和“排除指令”（Exclusion Instruction）两类标签。由于在我们的评估分类体系（taxonomy）中，仅“排除指令”类别意味着需要新增一个评估函数，因此 SPADE 仅会建议一个评估函数：该函数用于检查提示词（prompt）是否包含与婚礼相关的事件；若存在，则进一步验证模型响应（response）中是否未出现颜色词“white”。

```python
# Needs LLM: False
def check_excludes_white_wedding(prompt: str, response: str) -> bool:
    """
    This function checks if the response does not include white items for wedding-related events,
    unless explicitly stated by the client.
    """
    # Check if event is wedding-related
    if "wedding" in prompt.lower() and "my wedding" not in prompt.lower():
        # Check if the response includes the word "white"
        return "white" not in response.lower()
    else:
        return True
```

```python
# 需要调用大语言模型：否
def check_excludes_white_wedding(prompt: str, response: str) -> bool:
    """
    本函数用于检查：对于婚礼相关事件，响应中是否未包含“白色”物品（除非客户已明确说明允许）。
    """
    # 判断事件是否与婚礼相关
    if "wedding" in prompt.lower() and "my wedding" not in prompt.lower():
        # 检查响应中是否包含单词“white”
        return "white" not in response.lower()
    else:
        return True
```

Example Evaluation Function

示例评估函数

## Current prototype and feedback

## 当前原型及用户反馈

[The current prototype of SPADE](https://spade-beta.streamlit.app/?ref=blog.langchain.com) suggests evaluation functions for you to run on your chain’s inputs and outputs. In the app, you can either paste your prompt template that you want to generate evaluations for (we assume V0 of a prompt is an empty string), or you can point to your LangSmith prompt template (which automatically contains your prompt version history via commits). We show you all the categories of how your prompt changed between versions and suggest specific evaluation functions for your chain based on these categories.

[SPADE 当前原型](https://spade-beta.streamlit.app/?ref=blog.langchain.com) 会为您自动生成适用于您链（chain）输入与输出的评估函数。在该应用中，您既可直接粘贴待评估的提示词模板（我们默认提示词的初始版本 V0 为空字符串），也可链接至您的 LangSmith 提示词模板（后者将通过提交记录自动保存完整的提示词版本历史）。系统会向您展示提示词各版本之间的全部变更类别，并基于这些类别，为您的链推荐具体的评估函数。

![](images/spade-automatically-digging-up-evals-based-on-prompt-refinements/img_002.jpg)

The current prototype of SPADE is a very preliminary research prototype—there’s lots of room for improvement! It identifies all possible prompt refinement categories (from our taxonomy) and generates a Python function for each category that indicates a relevant evaluation. As such, the number of suggested functions can explode with a large number of prompt versions. We’re separately working on reducing the number of suggested functions while still covering failure modes, but with the current prototype, we’re interested if any of the suggested functions are useful for developers at all–even if the meaning of the function is useful, but the function’s syntax is a little bit wrong.

当前的 SPADE 原型尚处于非常早期的研究阶段——仍有巨大的优化空间！它会识别所有可能的提示词优化类别（源自我们的分类体系），并为每个触发评估需求的类别生成一个对应的 Python 函数。因此，当提示词版本数量较多时，所建议的函数数量可能急剧增长。我们正独立开展工作，旨在减少建议函数的数量，同时确保关键失效模式（failure modes）仍被充分覆盖。而在当前原型阶段，我们尤为关注：开发者是否认为其中任意一个建议函数具备实际价值？哪怕函数语义合理、但语法略有瑕疵，也欢迎反馈！

While you can give explicit feedback on the functions generated for you, if you’re interested in this area of research more broadly or if you want to deploy these evaluation functions in an observability tool, please fill out this [Google Form](https://forms.gle/ph3Y6nTZWhPn3w8W8?ref=blog.langchain.com) and we’ll be in touch. Otherwise, we’re grateful for any tool usage and feedback. Check it out and let us know what you think!

您可就系统为您生成的函数提供明确反馈；若您更广泛地关注这一研究方向，或希望将这些评估函数集成至可观测性（observability）工具中，请填写此 [Google 表单](https://forms.gle/ph3Y6nTZWhPn3w8W8?ref=blog.langchain.com)，我们将尽快与您联系。当然，我们也由衷感谢您对本工具的任何使用与反馈！欢迎试用，并告诉我们您的想法！

🦜

Thanks for reading! See what evaluation functions are suggested by the the [SPADE Prototype](https://spade-beta.streamlit.app/?ref=blog.langchain.com), and if you like this research area, fill out the the [interest form](https://forms.gle/ph3Y6nTZWhPn3w8W8?ref=blog.langchain.com) to connect with the Berkeley research team!

感谢阅读！请访问 [SPADE 原型](https://spade-beta.streamlit.app/?ref=blog.langchain.com)，查看系统为您推荐了哪些评估函数；若您对该研究方向感兴趣，欢迎填写 [意向表单](https://forms.gle/ph3Y6nTZWhPn3w8W8?ref=blog.langchain.com)，与加州大学伯克利分校（UC Berkeley）研究团队取得联系！

The code for SPADE is freely available at the linked [GitHub repo](https://github.com/langchain-ai/prompt-eval-recommendation?ref=blog.langchain.com).

SPADE 的代码在关联的 [GitHub 仓库](https://github.com/langchain-ai/prompt-eval-recommendation?ref=blog.langchain.com) 中免费提供。
{% endraw %}
