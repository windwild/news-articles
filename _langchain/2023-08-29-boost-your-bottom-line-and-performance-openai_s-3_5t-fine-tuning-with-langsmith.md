---
render_with_liquid: false
title: "Boost Your Bottom Line and Performance: OpenAI’s 3.5T Fine-Tuning with LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/chatopensource-x-langchain-the-future-is-fine-tuning-2/"
date: "2023-08-29"
scraped_at: "2026-03-03T08:48:29.382023062+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

_Editor's Note: This post was written in collaboration with_ Author _Ryan Brandt from_ _the [ChatOpenSource.com](http://chatopensource.com/?ref=blog.langchain.com) team. It's a detailed look at how fine-tuning can meaningfully improve model performance. And how [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) \+ LangChain can help you experiment with different models and measure and compare results._

编辑注：本文由 [ChatOpenSource.com](http://chatopensource.com/?ref=blog.langchain.com) 团队的作者 Ryan Brandt 共同撰写。文章深入探讨了微调（fine-tuning）如何切实提升模型性能，以及 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) ＋ LangChain 如何助力您实验不同模型，并量化、对比各项结果。

Unable to use gpt-3.5-turbo for your most critical AI workflows? Then it’s time to think about fine-tuning. Today, we’ll dive into the perks, prep steps, and cost-cutting advantages, all while putting it to the test with Langchain’s AI evaluator, LangSmith. It’s the next-level upgrade you’ve been searching for.

关键 AI 工作流无法使用 `gpt-3.5-turbo`？那么，是时候考虑模型微调了。今天，我们将深入剖析微调带来的优势、前期准备步骤与成本优化效益，并借助 LangChain 的 AI 评估工具 LangSmith 实际验证效果——这正是您一直在寻找的进阶升级方案。

### **Why Fine-Tuning should interest you**

### **为何您应关注微调**

At [ChatOpenSource.com](http://chatopensource.com/?ref=blog.langchain.com), we see fine-tuning as your next step when out-of-the-box models just don’t cut it. Why keep rephrasing prompts when you can teach your model to grasp context, tone, and complexity? Or those pesky edge cases. Think of it as “showing” rather than “telling” your AI what you need. Trust me, you’ll want to stick around to the end to learn more.

在 [ChatOpenSource.com](http://chatopensource.com/?ref=blog.langchain.com)，我们认为：当开箱即用（out-of-the-box）模型已无法满足需求时，微调就是您的下一步。既然可以通过训练让模型真正理解上下文、语气与任务复杂性，又何必反复改写提示词？更不必说那些令人头疼的边界情况（edge cases）。微调的本质，是“示范”而非“告知”——向您的 AI 展示您真正需要什么。相信我，您一定会愿意读到最后，了解更多细节。

### **Why Fine-Tuning is a Game-Changer**

### **为何微调是颠覆性的变革**

- Ensure greater consistency in style, tone, or format.  
  确保输出在风格、语气或格式上更加一致。

- Amplify the reliability of your desired outputs.  
  显著提升目标输出的可靠性。

- Improve the model's understanding of complex or highly specific prompts.  
  增强模型对复杂或高度特定提示的理解能力。

- Address unique edge cases more effectively.  
  更高效地应对独特的边界情况。

- Train your model in tasks that are hard to articulate in a prompt.  
  训练模型执行那些难以通过提示词清晰描述的任务。

- cost savings from shorter overall prompts, and using \`gpt-3.5-turbo\* over using larger prompts with `gpt-4`  
  通过缩短整体提示长度实现成本节约；相比使用 `gpt-4` 处理冗长提示，采用 `gpt-3.5-turbo` 微调模型更具性价比。

### Mastering Data Prep: The Secret Sauce of Fine-Tuning

### 掌握数据准备：微调成功的“秘方”

Before diving into fine-tuning, arm yourself with a robust set of training examples that reflect the dialogues you expect the model to handle. Ensure each dataset aligns with OpenAI's **[Chat completions API](https://platform.openai.com/docs/api-reference/chat/create?ref=blog.langchain.com)** guidelines, as illustrated below.

开展微调前，请先构建一套高质量、具代表性的训练样本集，确保其真实反映模型未来需处理的对话场景。同时，请严格遵循 OpenAI **[Chat Completions API](https://platform.openai.com/docs/api-reference/chat/create?ref=blog.langchain.com)** 的数据格式规范（如下所示）。

Our sample training setup feeds the chatbot a directive under the **`System`** role, followed by a **`User`** prompt and the corresponding correct answer.

我们的示例训练数据结构为：首先以 **`System`** 角色向聊天机器人提供指令，随后给出 **`User`** 角色的输入提示，最后附上模型应生成的正确响应（`assistant`）。

```python
{
        "messages": [{\
            "role": "system",\
            "content": "Given a product review, provide the following fields in a JSON dict, where applicable: \"product\", \"star_rating\", \"specific_likes\", and \"specific_dislikes\"."\
        },\
            {\
                "role": "user",\
                "content": "This desk chair gets 2 stars from me. It's uncomfortable and the height adjustment is faulty."\
            },\
            {\
                "role": "assistant",\
                "content": """{\
                    "product": "desk chair",\
                    "star_rating": 2,\
                    "specific_likes": [],\
                    "specific_dislikes": ["Uncomfortable", "faulty height adjustment"]\
                }"""\
            }\
        ]
    }
```

Never underestimate the value of edge-case examples, especially when a prompt is missing information crucial for generating structured JSON outputs. OpenAI recommends a baseline of 10 examples for **`gpt-3.5-turbo`** fine-tuning, but the more you include, the more you optimize performance. In this article, we're using only 20 training examples to shine the spotlight on how powerful high quality datasets can be.

切勿低估边界情况示例的价值，尤其是在提示词缺失生成结构化 JSON 输出所必需的关键信息时。OpenAI 建议 **`gpt-3.5-turbo`** 微调的基准示例数量为 10 个；但您提供的示例越多，模型性能优化效果就越显著。本文仅使用 20 个训练示例，旨在突出高质量数据集的强大能力。

### **Cost Efficiency with Fine-Tuning**

### **微调带来的成本效益**

Don’t underestimate fine-tuning’s ability to slash both costs and lag time. If `gpt-4` has been good to you, you may discover that a fine-tuned `gpt-3.5-turbo` delivers equal or even better results—plus the perks of speedier and more efficient operations. Next, let’s dive into how the pricing models stack up.

切勿低估微调在降低费用与响应延迟方面的潜力。如果您此前已受益于 `gpt-4`，那么您可能会发现：一个经过微调的 `gpt-3.5-turbo` 模型不仅能实现同等、甚至更优的效果，还能带来更快、更高效的运行体验。接下来，我们来详细对比各模型的定价模型。

| Model | Training | Input usage | Output usage |
| --- | --- | --- | --- |
| GPT-3.5 Turbo 4K context | N/A | $0.0015 / 1K tokens | $0.002 / 1K tokens |
| GPT-3.5 Turbo 16K context | N/A | $0.003 / 1K tokens | $0.004 / 1K tokens |
| GPT-3.5 Turbo Fine-Tuned | $0.0080 / 1K tokens | $0.0120 / 1K tokens | $0.0160 / 1K tokens |
| GPT-4 8K context | N/A | $0.03 / 1K tokens | $0.06 / 1K tokens |
| GPT-4 32K context | N/A | $0.06 / 1K tokens | $0.12 / 1K tokens |

| 模型 | 训练费用 | 输入代币费用 | 输出代币费用 |
| --- | --- | --- | --- |
| GPT-3.5 Turbo（4K 上下文） | 不适用 | $0.0015 / 每千代币 | $0.002 / 每千代币 |
| GPT-3.5 Turbo（16K 上下文） | 不适用 | $0.003 / 每千代币 | $0.004 / 每千代币 |
| GPT-3.5 Turbo（微调版） | $0.0080 / 每千代币 | $0.0120 / 每千代币 | $0.0160 / 每千代币 |
| GPT-4（8K 上下文） | 不适用 | $0.03 / 每千代币 | $0.06 / 每千代币 |
| GPT-4（32K 上下文） | 不适用 | $0.06 / 每千代币 | $0.12 / 每千代币 |

As you can see, `gpt-4` isn’t cheap, and while relying on larger context windows is currently in vogue, for the moment your wallet won’t be a fan.

如上表所示，`gpt-4` 的使用成本并不低廉；尽管目前扩大上下文窗口已成为流行趋势，但就当下而言，您的钱包恐怕不会为此“买单”。

### How LangSmith Evaluation Works

### LangSmith 评估机制详解

Before we unveil each model’s performance, let’s get familiar with our evaluation process. LangSmith provides ready-to-use evaluators, but you’re free to build your own. In our case, we’re leveraging `gpt-4` to assess the outputs from various models, using a chain-of-thought Q&A prompt. If the model’s answer doesn’t match the expected response, it’s labeled INCORRECT. Just like DataDog, you run the code on your end and send the results to LangSmith for logging and comparison.

在揭晓各模型性能表现之前，让我们先熟悉本次评估流程。LangSmith 提供开箱即用的评估器（evaluators），同时也支持用户自定义开发。在本案例中，我们采用 `gpt-4` 作为评估模型，通过思维链（chain-of-thought）问答提示对各被测模型输出进行评判：若模型回答与预期结果不一致，则标记为 **INCORRECT（错误）**。其工作方式类似于 DataDog——您在本地运行评估代码，并将结果发送至 LangSmith 进行日志记录与横向比对。

![](images/boost-your-bottom-line-and-performance-openai_s-3_5t-fine-tuning-with-langsmith/img_001.png)LangSmith’s pre-built evaluators.

![](images/boost-your-bottom-line-and-performance-openai_s-3_5t-fine-tuning-with-langsmith/img_001.png)LangSmith 内置的预构建评估器。

Here’s an example of output from gpt-3.5-turbo-finetuned being evaluated. gpt-4 uses the provided context in the input as an example of “correct”. You can see how based on that context, the fine tuned model outputted successfully.

以下为对 `gpt-3.5-turbo-finetuned` 模型输出进行评估的一个示例。`gpt-4` 将输入中提供的上下文视为“正确答案”的范例。您可清晰看到：微调模型正是基于该上下文，成功生成了符合预期的输出。

![](images/boost-your-bottom-line-and-performance-openai_s-3_5t-fine-tuning-with-langsmith/img_002.png)gpt-3.5-turbo Fine tuned on 20 training examples

![](images/boost-your-bottom-line-and-performance-openai_s-3_5t-fine-tuning-with-langsmith/img_002.png)gpt-3.5-turbo —— 基于 20 个训练样本完成微调

gpt-4 在另一方面，使用相同的提示词（prompt），却未能达到同样的标准：

![](images/boost-your-bottom-line-and-performance-openai_s-3_5t-fine-tuning-with-langsmith/img_003.png)gpt-4-8k 错误地返回了不正确的格式

### Benchmarking Performance

### 性能基准测试

Now we use LangSmith to determine the efficacy of our fine tuning. We do this by evaluating the baseline **`gpt-3.5-turbo`**, then performing the same evaluation on our **`gpt-3.5-turbo-finetuned`** and comparing the results.

现在我们使用 LangSmith 来评估微调效果：首先对基线模型 **`gpt-3.5-turbo`** 进行评估，再对微调后的模型 **`gpt-3.5-turbo-finetuned`** 执行完全相同的评估，并对比结果。

![](images/boost-your-bottom-line-and-performance-openai_s-3_5t-fine-tuning-with-langsmith/img_004.png)LangSmith allows you to easily compare models on the same dataset

![](images/boost-your-bottom-line-and-performance-openai_s-3_5t-fine-tuning-with-langsmith/img_004.png)LangSmith 可让您轻松在相同数据集上对比不同模型

When I evaluate the baseline `gpt-3.5-turbo` on 142 example product reviews, it’s median runtime is roughly a third faster. It’s worth noting that the P99 of our fine tuned model is higher, but that was not the case every time we ran a test run.

当我基于 142 条示例商品评论评估基线模型 `gpt-3.5-turbo` 时，其**中位运行时间**快了约三分之一。值得注意的是，我们微调模型的 P99 延迟更高；但该现象并非每次测试运行中都出现。

However, it’s really the accuracy where things get interesting. LangSmith measures the output accuracy of **`gpt-3.5-turbo-finetuned`** at 99 percent correct. It got only 1 incorrect. Let’s take a look at the other models.

然而，真正引人关注的是准确率。LangSmith 测得 **`gpt-3.5-turbo-finetuned`** 的输出准确率为 99%，仅出现 1 次错误。让我们再看看其他模型的表现。

![](images/boost-your-bottom-line-and-performance-openai_s-3_5t-fine-tuning-with-langsmith/img_005.png)

![](images/boost-your-bottom-line-and-performance-openai_s-3_5t-fine-tuning-with-langsmith/img_005.png)

The results are… surprising. Our fine tuned model absolutely destroyed both its baseline self and its upgraded `gpt-4` in output performance. It is true that with larger prompting, `gpt-4` and likely `3.5` might have attained the same performance as the fine tuned model, but our test uses the same prompt for each model to emphasize the difference in outcome.

结果……令人惊讶。我们的微调模型在输出性能上全面碾压其自身基线模型以及升级版 `gpt-4`。诚然，若采用更长、更复杂的提示词（larger prompting），`gpt-4`（甚至 `gpt-3.5`）或许也能达到与微调模型相当的性能；但本测试统一使用相同提示词，旨在凸显各模型在同等输入条件下的输出差异。

Let’s plug in the cost numbers from before to show the difference in cost between each run, assuming usage in a low transaction production environment:

接下来，代入此前的成本数据，以展示在低频交易（low-transaction）生产环境中，每次运行之间的成本差异：

| Model | Input Tokens | Output Tokens | Input Cost ($) | Output Cost ($) | Training Cost ($) | Total Cost ($) |
| --- | --- | --- | --- | --- | --- | --- |
| gpt-3.5-t | 3,000,000 | 1,000,000 | 4.5 | 2 | 0 | 6.5 |
| gpt-3.5-t 对应模型 | 3,000,000 | 1,000,000 | 4.5 美元 | 2 美元 | 0 美元 | 6.5 美元 |
| ft:gpt-3.5-turbo-0613 | 3,000,000 | 1,000,000 | 36 | 16 | 0.2 | 52.20 |
| ft:gpt-3.5-turbo-0613 对应模型 | 3,000,000 | 1,000,000 | 36 美元 | 16 美元 | 0.2 美元 | 52.20 美元 |
| gpt-4-8k | 3,000,000 | 1,000,000 | 90 | 60 | 0 | 150 |
| gpt-4-8k 对应模型 | 3,000,000 | 1,000,000 | 90 美元 | 60 美元 | 0 美元 | 150 美元 |

So we can see that while fine tuning is almost 9 times more expensive than the baseline, it’s roughly 3 times cheaper than `gpt-4`, with substantially better accuracy, and a median response time of nearly 4 times faster. These are massive numbers!

由此可见，尽管微调成本几乎是基线模型的 9 倍，但它仍比 `gpt-4` 便宜约 3 倍，同时具备显著更高的准确率，且中位响应时间快近 4 倍。这些数据极为可观！

### In Conclusion

### 总结

Fine-tuning is not just an option but a strategic necessity for organizations seeking to optimize their AI models. We've demonstrated through LangSmith that a fine-tuned **`gpt-3.5-turbo`** model can dramatically outperform its baseline and even **`gpt-4`** in terms of accuracy, response time, and cost-efficiency. Don’t miss the opportunity to supercharge your LLMs—It’s the AI boost your company has been waiting for.

对组织而言，模型微调已不仅是一种可选方案，更是优化 AI 模型的战略刚需。我们通过 LangSmith 已证实：经过微调的 **`gpt-3.5-turbo`** 模型，在准确率、响应速度和成本效益等关键维度上，均能大幅超越其基线版本，甚至优于 **`gpt-4`**。切勿错过这一赋能大语言模型（LLM）的绝佳机会——这正是贵公司翘首以盼的 AI 动力升级！

At [ChatOpenSource.com](http://chatopensource.com/?ref=blog.langchain.com) we’re the go-to experts in fine-tuning both OpenAI and open-source models like **`llaama-2`**. Don’t let the AI revolution leave your organization in the dust. We’re experts in customizing high-performance, open-source AI models to fit your data—all at a fraction of the cost of building an in-house ML team. Stay ahead of the curve with [www.ChatOpenSource.com](http://www.chatopensource.com/?ref=blog.langchain.com).

在 [ChatOpenSource.com](http://chatopensource.com/?ref=blog.langchain.com) ，我们是微调 OpenAI 模型及开源模型（如 **`llama-2`**）的首选专家。切莫让 AI 革命将您的组织甩在身后。我们专精于根据您的数据，定制高性能开源 AI 模型——成本仅为自建机器学习团队的零头。立即访问 [www.ChatOpenSource.com](http://www.chatopensource.com/?ref=blog.langchain.com)，抢占技术先机！