---
render_with_liquid: false
title: "Introducing Tuna - A Tool for Rapidly Generating Synthetic Fine-Tuning Datasets"
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/"
date: "2023-11-21"
scraped_at: "2026-03-03T08:25:56.823786799+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

_Editor's Note: This post was written by_ [_Andrew Kean Gao_](https://twitter.com/itsandrewgao?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor&ref=blog.langchain.com) _through LangChain's Student Hacker in Residence Program._

_编辑注：本文由_ [_Andrew Kean Gao_](https://twitter.com/itsandrewgao?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor&ref=blog.langchain.com) _撰写，系 LangChain “学生驻场黑客计划”（Student Hacker in Residence Program）成果。_

# Brief Overview

# 简要概述

Tuna is a no-code tool for quickly generating LLM fine-tuning datasets from scratch. This enables anyone to create high-quality training data for fine-tuning large language models like the LLaMas. There is both a web interface (Streamlit) and a Python script (Repl.it, recommended for speed).

Tuna 是一款无需编写代码的工具，可快速从零开始生成大语言模型（LLM）微调所需的数据集。它使任何人——无论技术背景如何——都能高效构建高质量的训练数据，用于微调如 LLaMA 系列等大型语言模型。Tuna 提供两种使用方式：基于 Streamlit 的网页界面，以及基于 Python 的脚本（推荐使用 Repl.it 运行，速度更快）。

You provide an input CSV file of text data that will be individually sent to OpenAI as context to generate prompt-completion pairs from. This means that there is minimized hallucination since we feed directly in-context into GPT the information we want it to write prompt-completion pairs about!

您只需提供一个包含原始文本数据的 CSV 文件；Tuna 会将其中每条文本单独作为上下文发送至 OpenAI，驱动 GPT 自动生成对应的“提示（prompt）—补全（completion）”样本对。由于所有生成均严格基于您提供的原始上下文，因此幻觉（hallucination）被降至最低——GPT 所“写作”的一切，均源自您明确输入的信息！

Repl.it template: [https://replit.com/@olafblitz/tuna-asyncio?v=1](https://replit.com/@olafblitz/tuna-asyncio?v=1&ref=blog.langchain.com)

Repl.it 模板链接：[https://replit.com/@olafblitz/tuna-asyncio?v=1](https://replit.com/@olafblitz/tuna-asyncio?v=1&ref=blog.langchain.com)

Streamlit web interface: [https://tunafishv1.olafblitz.repl.co/](https://tunafishv1.olafblitz.repl.co/?ref=blog.langchain.com)

Streamlit 网页界面：[https://tunafishv1.olafblitz.repl.co/](https://tunafishv1.olafblitz.repl.co/?ref=blog.langchain.com)

![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_001.jpg)

![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_001.jpg)

Sample inputs for Tuna, which are ground-truth contexts/information that Tuna will send to OpenAI for a GPT model to draw from.

Tuna 的示例输入：这些是真实、可信的上下文或事实性信息，Tuna 将其直接传递给 OpenAI 的 GPT 模型，作为其生成 prompt-completion 对的唯一依据。

![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_002.jpg)

![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_002.jpg)

Sample outputs from Tuna, which could be used for fine-tuning an LLM for RAG

Tuna 的示例输出：这些 prompt-completion 样本对可直接用于对大语言模型进行微调，以支持检索增强生成（RAG）等下游任务。

# What is Fine-Tuning and When is it Useful?

# 什么是微调（Fine-Tuning）？它在什么情况下有用？

Fine-tuning is the technique of taking a pre-trained large language model (LLM) like GPT-3.5-turbo or LLaMa-2-7b and training it further on a specific task or dataset. It is also known as transfer learning. This adapts the model to a new domain or specific purpose. Fine-tuning is used to specialize a large language model for a particular application. For example, you could fine-tune GPT-3 on a dataset of legal documents to create a model optimized for legal writing. As another example, LLaMa-2-7b-chat is a fine-tuned version of LLaMa-2-7b that is intended to be better at replying in a conversational format.

微调是一种技术，指在已预训练的大语言模型（LLM）（例如 GPT-3.5-turbo 或 LLaMa-2-7b）基础上，进一步针对特定任务或数据集进行训练。该技术也被称为迁移学习（transfer learning）。通过微调，可使模型适配新领域或特定用途。微调常用于将大语言模型专门化为某一具体应用场景。例如，你可以在法律文书数据集上对 GPT-3 进行微调，从而构建一个专为法律写作优化的模型。再比如，LLaMa-2-7b-chat 就是 LLaMa-2-7b 的一个微调版本，旨在更擅长以对话形式进行回复。

If you are curious to learn more about how fine-tuning works, here are some nice tutorials on how to fine-tune a large language model:

如果你希望深入了解微调的工作原理，以下是一些关于如何微调大语言模型的优质教程：

- [https://www.datacamp.com/tutorial/fine-tuning-llama-2](https://www.datacamp.com/tutorial/fine-tuning-llama-2?ref=blog.langchain.com)
- [https://lightning.ai/pages/community/tutorial/accelerating-llama-with-fabric-a-comprehensive-guide-to-training-and-fine-tuning-llama/](https://lightning.ai/pages/community/tutorial/accelerating-llama-with-fabric-a-comprehensive-guide-to-training-and-fine-tuning-llama/?ref=blog.langchain.com)
- [https://www.mlexpert.io/machine-learning/tutorials/alpaca-fine-tuning](https://www.mlexpert.io/machine-learning/tutorials/alpaca-fine-tuning?ref=blog.langchain.com)

Fine-tuning is useful because you can get a model to be more predictable and constrain the range of potential outputs. For instance, you may want your model to always respond with a correctly JSON-formatted list. Or, you may want your model to be very polite. Fine-tuning lets you perturb the model weights so it is more likely to do what you want. For instance, you could fine-tune a model to talk more like Kim Kardashian by default. Fine-tuning can also improve the performance of smaller LLMs to be closer to larger LLMs. This is useful for tasks that are simple and don’t require the reasoning skills of a larger LLM like GPT-4. For instance, if you are Google Docs and you want to automatically name documents based on their contents, using GPT-4 could be overkill. A fine-tuned version of LLaMa-2-7b could be more than good enough, while being faster, cheaper, and (if you choose to self-host) private.

微调之所以有用，在于它能提升模型输出的可预测性，并限制潜在输出的范围。例如，你可能希望模型始终以格式正确的 JSON 列表形式响应；又或者，你希望模型始终保持礼貌得体的语气。微调通过对模型权重施加扰动，使其更倾向于按你的预期行为输出——例如，你可以将模型微调为默认以金·卡戴珊（Kim Kardashian）的风格说话。此外，微调还能显著提升小型大语言模型的性能，使其接近大型大语言模型的效果。这对那些简单、无需 GPT-4 等大型模型强大推理能力的任务尤为适用。例如，若你是 Google Docs，希望根据文档内容自动为其生成标题，直接使用 GPT-4 可能大材小用；而一个经过微调的 LLaMa-2-7b 模型则完全够用，且运行更快、成本更低，同时（如选择自托管）还能保障数据隐私。

OpenAI’s documentation has some example use cases for fine-tuning:

OpenAI 官方文档中列举了一些微调的典型应用场景：

[https://platform.openai.com/docs/guides/fine-tuning](https://platform.openai.com/docs/guides/fine-tuning?ref=blog.langchain.com)

People often talk about how fine-tuning can save you tokens in your prompt. Personally I do not see this as a major value proposition of fine-tuning but technically it would save you some money if you are using LLMs at scale. In general the more exciting applications of fine-tuning to be A) improve response formatting and reliability and B) being able to use small self-hosted LLMs for simple tasks, giving you independence from outside providers.

人们常提到微调可以减少提示词（prompt）中所需的 token 数量。就我个人而言，这并非微调最核心的价值主张；不过从技术角度看，若你在大规模使用大语言模型，此举确实能节省一定成本。总体而言，微调更具吸引力的应用方向主要有两点：A）提升响应格式的规范性与结果的可靠性；B）借助小型、可自托管的大语言模型完成简单任务，从而摆脱对外部服务商的依赖。

People also talk a lot about fine-tuning LLMs on their data, with the expectation that they can just teach an LLM new information easily. The jury is still out on whether you can effectively bake new information into LLMs with fine-tuning. It is quite controversial, actually (Hacker News discussion: https://news.ycombinator.com/item?id=35666201). Some people have reported being able to teach LLMs a new word through fine-tuning. For now, retrieval-augmented generation (RAG) systems are probably more accurate, effective, and usable in practice. The idea of RAG is to use semantic search with vector embeddings over a database of texts, each associated with a vector embedding. When the user makes a query, you embed their query into a vector and compare that vector to all the vectors in your database to find relevant vectors. Retrieve the corresponding texts and feed those into your LLM in the prompt. Your LLM can use that ground truth information to answer the user’s question rather than try to spit out a response based completely on its memory. Even if you could fine-tune new information into LLMs, RAG would probably still be better since you can easily add new information by just adding new vectors to your database. On the other hand, you would have to re-fine-tune your LLM every time you had new information.

人们还经常讨论“用自己的数据对大语言模型进行微调”，并期望借此轻松教会模型新知识。但目前尚无定论：能否真正通过微调将新信息“固化”进大语言模型中？这一问题其实颇具争议（参见 Hacker News 相关讨论：https://news.ycombinator.com/item?id=35666201）。已有部分用户报告称，可通过微调让模型学会一个新词。但就现阶段实践而言，检索增强生成（Retrieval-Augmented Generation, RAG）系统在准确性、有效性及易用性方面普遍更优。RAG 的基本思想是：在文本数据库（每篇文本均关联一个向量嵌入）上，利用向量嵌入实现语义搜索。当用户发起查询时，系统先将查询语句编码为向量，再将其与数据库中所有向量比对，以找出最相关的若干向量；随后提取对应文本，并将其作为上下文输入大语言模型的提示词中。这样，大语言模型便可基于这些真实、可靠的外部信息回答用户问题，而非仅凭自身记忆“硬编”答案。即便未来真能通过微调将新信息注入大语言模型，RAG 仍可能更胜一筹——因为只需向数据库添加新向量，即可轻松引入新信息；而微调方式则每次新增信息都需重新执行整个微调流程。

Here is a good article about RAG:

这里有一篇关于 RAG 的优秀文章：

[https://www.singlestore.com/blog/a-guide-to-retrieval-augmented-generation-rag/](https://www.singlestore.com/blog/a-guide-to-retrieval-augmented-generation-rag/?ref=blog.langchain.com)

[https://www.singlestore.com/blog/a-guide-to-retrieval-augmented-generation-rag/](https://www.singlestore.com/blog/a-guide-to-retrieval-augmented-generation-rag/?ref=blog.langchain.com)

If you are unsure if you should fine-tune or use RAG (or both, or neither!), here is a another good article: “Why You (Probably) Don’t Need to Fine-tune an LLM”:

如果您不确定是否应该对模型进行微调、使用 RAG（检索增强生成），还是两者都用、或都不用，这里有一篇不错的文章供参考：“为什么你（很可能）无需对大语言模型进行微调”：

[https://www.tidepool.so/2023/08/17/why-you-probably-dont-need-to-fine-tune-an-llm/](https://www.tidepool.so/2023/08/17/why-you-probably-dont-need-to-fine-tune-an-llm/?ref=blog.langchain.com)

[https://www.tidepool.so/2023/08/17/why-you-probably-dont-need-to-fine-tune-an-llm/](https://www.tidepool.so/2023/08/17/why-you-probably-dont-need-to-fine-tune-an-llm/?ref=blog.langchain.com)

If you want to fine-tune a model, as of November 2023, the best small model is Mistral-7b and it has a very permissive Apache license. The best model of any size is probably Yi-34b but the license is not as generous. Llama-70b is also good but twice as large. I would recommend Mistral. Here’s a tutorial on fine-tuning Mistral in a Colab notebook: [https://adithyask.medium.com/a-beginners-guide-to-fine-tuning-mistral-7b-instruct-model-0f39647b20fe](https://adithyask.medium.com/a-beginners-guide-to-fine-tuning-mistral-7b-instruct-model-0f39647b20fe?ref=blog.langchain.com)

若您希望对模型进行微调，截至 2023 年 11 月，综合表现最佳的小型模型是 Mistral-7B，且其采用非常宽松的 Apache 许可证。而就任意尺寸而言，目前性能最强的模型很可能是 Yi-34B，但其许可证限制较多；Llama-70B 表现也不错，但参数量约为前者的两倍。我推荐选用 Mistral。以下是一份在 Google Colab 笔记本中微调 Mistral 的入门教程：[https://adithyask.medium.com/a-beginners-guide-to-fine-tuning-mistral-7b-instruct-model-0f39647b20fe](https://adithyask.medium.com/a-beginners-guide-to-fine-tuning-mistral-7b-instruct-model-0f39647b20fe?ref=blog.langchain.com)

# Challenges in Fine-Tuning LLMs

# 微调大语言模型面临的挑战

Fine-tuning depends on having a dataset of several one hundred to one thousand examples of what you want, usually in the form of prompt-completion pairs. This number varies by task and there is not an established magic number of examples! More probably can never hurt though. A prompt-completion pair contains a sample prompt and a sample completion (how you want your LLM to respond).

微调依赖于一个包含数百至一千条样本的数据集，这些样本通常以“提示—补全”（prompt-completion）对的形式组织。所需样本数量因任务而异，并不存在一个被普遍认可的“黄金数字”！不过，样本数量更多通常总归无害。所谓“提示—补全”对，即一条输入提示（prompt）及其对应的理想输出补全（completion）——也就是您期望大语言模型给出的响应。

|     |     |
| --- | --- |
| Prompt | Completion |
| What is 1 + 1? | DO YOU REALLY NOT KNOW THAT? DUH, IT’S 2.\[END\] |
| Is the sun hot? | WHAT DO YOU THINK?\[END\] |
| Which state is Caltech in? | UH, CALIFORNIA?\[END\] |

|     |     |
| --- | --- |
| 提示（Prompt） | 补全（Completion） |
| 1 + 1 等于几？ | 你真的不知道吗？拜托，当然是 2！［END］ |
| 太阳热吗？ | 你觉得呢？［END］ |
| 加州理工学院位于哪个州？ | 呃，加利福尼亚州？［END］ |

用于训练一个“粗鲁风格”大语言模型的示例提示与补全对。

Fine-tuning data needs to be very high quality and is usually manually curated. Creating datasets for fine-tuning can be time-consuming. For example, if you wanted to create a fine-tuning dataset of tutoring dialogues between a math teacher and a student, you would need to hire a bunch of people (who know math) to write several thousand examples of such conversations. You would also need to know how to put the data into the correct format for fine-tuning (which is not that hard but can still be annoying if you aren’t comfortable with coding). These barriers make it difficult and expensive to get started with fine-tuning. The actual LLM fine-tuning process is relatively easy and there are a lot of providers that will do it for you. You can also do it yourself on Google Colab with a paid subscription. The main barrier is curating data into a high-quality dataset for fine-tuning.

用于微调的数据必须具备极高的质量，且通常需人工精心构建。创建微调数据集往往耗时费力。例如，若想构建一个数学教师与学生之间的辅导对话微调数据集，您就需要雇佣一批熟悉数学的专业人员，撰写数千条此类对话样本。此外，您还需掌握如何将数据整理为微调所需的正确格式（这项工作本身并不复杂，但若您不熟悉编程，仍可能感到繁琐）。上述种种门槛使得微调的入门过程既困难又昂贵。相比之下，大语言模型本身的微调流程其实相对简单，且已有大量服务商可代为执行；您也可通过付费订阅 Google Colab 自行完成。真正的核心瓶颈，在于构建高质量的微调数据集。

I created Tuna to lower the barriers to fine-tuning data curation and empower anyone to generate custom fine-tuning datasets. With Tuna's intuitive web interface (or Python script), you don't need any coding expertise. Tuna uses concurrency and GPT-3.5-turbo/GPT-4 to replace humans, rapidly creating thousands of high-quality prompt completion pairs. Behind the scenes, web Tuna uses multithreading to manage 12 API calls at once. Python script Tuna is much faster since it uses asyncio and can handle way more concurrent requests.

我开发了 Tuna 工具，旨在降低微调数据构建的门槛，赋能每一位用户轻松生成定制化的微调数据集。借助 Tuna 直观的网页界面（或 Python 脚本），您无需任何编程经验即可上手。Tuna 利用并发机制，结合 GPT-3.5-turbo 或 GPT-4 模型替代人工，快速生成数千条高质量的“提示—补全”对。在后台，网页版 Tuna 采用多线程技术，可同时管理 12 个 API 请求；而 Python 脚本版 Tuna 更为高效，它基于 `asyncio` 实现，支持更高并发量的请求处理。

# Before Getting Started

# 入门前须知

A quick warning to please test Tuna on small inputs first. Do not try to generate a huge dataset on your first go. It might not be what you are looking for and cost you a ton of money. I would suggest starting with a small sample of 10-20 rows in your input CSV. Also, due to combinatorics, the number of API calls you are requesting will grow exponentially. For example, if you are teaching a model to answers questions from RAG context and each time you provide three contexts, this explodes quickly. For instance, if your input CSV has 50 contexts and you ask Tuna to group them into all combinations of three contexts, that’s 50 choose 3 = 19,600 API calls!

这里先快速提醒您：请务必先用小规模输入测试 Tuna。切勿在首次使用时就尝试生成超大规模数据集——这很可能不符合您的预期，且会产生高昂费用。建议您从输入 CSV 中仅选取 10–20 行的小样本开始。此外，由于组合爆炸效应，您所请求的 API 调用次数将呈指数级增长。例如，若您正训练模型基于 RAG 上下文回答问题，且每次提供三个上下文片段，则调用量会迅速激增。举例来说：若您的输入 CSV 包含 50 个上下文片段，而您要求 Tuna 将其两两（实际为三三）组合成所有可能的三元组，则总组合数为 C(50,3) = 19,600 次 API 调用！

Second, make sure you have an OpenAI API key that has access to GPT-3.5-turbo or GPT-4. GPT-4 access generally requires you having spent some nominal amount, around $1.00.

其次，请确保您已拥有可访问 GPT-3.5-turbo 或 GPT-4 的 OpenAI API 密钥。通常，要获得 GPT-4 访问权限，您需先在 OpenAI 平台产生约 1.00 美元的少量消费。

## Common Errors

## 常见错误

1. Exceeding your rate limits: [https://platform.openai.com/docs/guides/rate-limits/overview](https://platform.openai.com/docs/guides/rate-limits/overview?ref=blog.langchain.com). You will probably hit the max tokens per minute rather than the max requests per minute limit.

1. 超出速率限制：[https://platform.openai.com/docs/guides/rate-limits/overview](https://platform.openai.com/docs/guides/rate-limits/overview?ref=blog.langchain.com)。您更可能触达的是“每分钟最大 token 数”限制，而非“每分钟最大请求数”限制。

1. If this happens, you should wait a few minutes for your rate limit to reset. Then you should decrease the number of concurrent requests by adjusting a parameter in the code. This will be labeled so you know what to edit.

1. 若发生此情况，请等待几分钟，待速率限制自动重置；随后，您应通过修改代码中一个已明确标注的参数，降低并发请求数量——该参数已加标签，便于您快速定位并编辑。

2. You forgot to change a parameter in the code (if using the Repl.it Python script), especially the name of your input CSV file.

2. 您遗漏了代码中某项参数的修改（尤其当使用 Repl.it 上的 Python 脚本时），例如未更新输入 CSV 文件的文件名。

3. Your input CSV does not have a column “ChunkID” and a column “ChunkText”

3. 您的输入 CSV 文件缺少名为 “ChunkID” 和 “ChunkText” 的两列。

1. Please check your CSVs in Excel/Numbers and make sure you have columns named exactly that.

1. 请在 Excel 或 Numbers 中打开您的 CSV 文件，确认其中确实存在名称完全一致（区分大小写）的这两列。

4. You forgot to put your OpenAI key in.

4. 您忘记填入自己的 OpenAI 密钥。

1. Please insert your OpenAI key.

1. 请插入您的 OpenAI 密钥。

5. You don’t have access to GPT-4.

5. 您尚未获得 GPT-4 的访问权限。

[https://help.openai.com/en/articles/7102672-how-can-i-access-gpt-4](https://help.openai.com/en/articles/7102672-how-can-i-access-gpt-4?ref=blog.langchain.com)

[https://help.openai.com/zh/articles/7102672-如何访问-gpt-4](https://help.openai.com/zh/articles/7102672-how-can-i-access-gpt-4?ref=blog.langchain.com)

# Web Interface Tutorial

# 网页界面使用教程

Live link: [https://tunafishv1.olafblitz.repl.co/](https://tunafishv1.olafblitz.repl.co/?ref=blog.langchain.com)

实时链接：[https://tunafishv1.olafblitz.repl.co/](https://tunafishv1.olafblitz.repl.co/?ref=blog.langchain.com)

First you will supply your OpenAI key, starting with “sk-”.

首先，您需输入以 “sk-” 开头的 OpenAI 密钥。

Next, you need to supply a single column CSV file into the main Tuna program. The basic idea is that Tuna requests a prompt-completion pair from GPT-3.5-turbo/GPT-4 for each reference text (each row in your column). For instance, if one row of your column contains a paragraph about Chilean sea bass, Tuna would send a request to OpenAI along the lines of “Given the following text, please write a prompt and completion…. Text: {text}”. You can adjust the prompt to your needs. Tuna requests a JSON formatted response from OpenAI which it then parses into prompt-completion pairs. You are able to get multiple prompt-completion pairs from one reference text. The default is three.

接下来，您需向主 Tuna 程序上传一个单列 CSV 文件。其基本原理是：Tuna 针对每一行参考文本（即 CSV 中的每一行），向 GPT-3.5-turbo 或 GPT-4 请求一组提示（prompt）—补全（completion）对。例如，若某一行包含一段关于智利海鲈鱼（Chilean sea bass）的段落，Tuna 将向 OpenAI 发送类似如下格式的请求：“请根据以下文本，生成一条提示语及对应的补全内容…… 文本：{text}”。您可以按需自定义该提示模板。Tuna 要求 OpenAI 返回 JSON 格式的响应，并将其解析为 prompt-completion 对。对于同一段参考文本，您可生成多组 prompt-completion 对，默认数量为三组。

![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_003.jpg)

主程序 Tuna 有三个版本：

[SimpleQA](https://tunafishv1.olafblitz.repl.co/Generate_QnA_simpleQA?ref=blog.langchain.com)：默认版本。针对您提供的列中的每一段参考文本，生成一组问答对（question-answer pairs）。适用于构建微调数据集，以将问答能力微调进大语言模型（LLM）。

[MultiChunk](https://tunafishv1.olafblitz.repl.co/Generate_QnA_multiChunk?ref=blog.langchain.com)：对输入列的各行生成组合（n 选 k，即 nCk）。例如，若您有 10 行数据，并将分块组大小（chunk group size）设为 2，则共生成 C(10,2) = 45 种唯一组合；每种组合都会被发送至 OpenAI API。当您的 LLM 需从多个参考文本中选取答案（即典型 RAG 场景）时，应使用 MultiChunk。

[CustomPrompt](https://tunafishv1.olafblitz.repl.co/Generate_QnA_customPrompt?ref=blog.langchain.com)：MultiChunk 的高级版本，支持手动枚举行组合，并允许您为 OpenAI API 指定自定义提示词（custom prompt）。

您可以提供自己的 CSV 文件，其中一列包含参考文本 / 文档 / 文本块（reference texts/documents/chunks）。

为方便起见，您也可将长文本粘贴至 [Chunk Text](http://tunafishv1/?ref=blog.langchain.com) 页面，系统会将其切分为等长的较小文本块，并导出为 CSV 文件下载。**该 CSV 文件必须包含两列：ChunkID 和 ChunkText。** 其中 ChunkID 应为每个文本块分配唯一的数字编号。

![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_004.jpg)

除提示词（prompt）和模型输出（completion）外，Tuna 还提供第三个参数，其默认值为生成该问答对所依据的参考文本的 ID。

![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_005.jpg)

After you select the necessary parameters and upload a CSV file, you will click Start.

选择完必要参数并上传 CSV 文件后，您将点击“开始”（Start）。

To generate large datasets, on the order of thousands of pairs, I would recommend using the Python script instead of the web interface.

若需生成大规模数据集（例如数千对样本），我建议使用 Python 脚本而非网页界面。

# Python Script Tutorial

# Python 脚本教程

While the web interface is convenient, for very large datasets, multithreading is not sufficient. Asyncio works much better. But I wasn’t able to cleanly implement asyncio into a Streamlit app due to how Streamlit apps work.

尽管网页界面使用便捷，但对于超大规模数据集而言，多线程（multithreading）性能不足；而 `asyncio` 的表现则要好得多。然而，由于 Streamlit 应用的运行机制限制，我未能将 `asyncio` 清晰、干净地集成进 Streamlit 应用中。

I decided to put the script into a Repl.it along with preloaded sample input and output files. I like Repl.it for sharing code and there is basically no learning curve to use it. You also don’t need to download anything to your computer locally, such as an IDE, if you are a beginner.

因此，我将该脚本部署到了 Repl.it 平台，并预置了示例输入与输出文件。我青睐 Repl.it 的原因在于它便于代码共享，且几乎零学习成本——尤其对初学者而言，您无需在本地计算机上下载任何工具（例如 IDE）。

Make a Repl.it account and fork this Repl: [https://replit.com/@olafblitz/asyncio-tunafish](https://replit.com/@olafblitz/asyncio-tunafish?ref=blog.langchain.com)

请注册一个 Repl.it 账户，并 Fork 此 Repl：[https://replit.com/@olafblitz/asyncio-tunafish](https://replit.com/@olafblitz/asyncio-tunafish?ref=blog.langchain.com)

Set your OpenAI key in the Secrets page of the Repl. It should be called OPENAI\_API\_KEY.

请在该 Repl 的 “Secrets”（密钥）页面中设置您的 OpenAI API 密钥，密钥名称应为 `OPENAI_API_KEY`。

Upload your CSV file (containing two columns: ChunkID and ChunkText) to the Repl.it left panel. See the Web Interface tutorial section from before for information on what should be in these columns.

将您的 CSV 文件（须包含两列：`ChunkID` 和 `ChunkText`）上传至 Repl.it 左侧文件面板。关于这两列应包含的内容，请参阅前文“网页界面教程”部分。

Control-F “sample-input.csv” and change that to the name of your input CSV file.

使用 Ctrl+F（Windows/Linux）或 Cmd+F（macOS）搜索字符串 `sample-input.csv`，并将其替换为您实际输入 CSV 文件的文件名。

Check out the other parameters you can alter in the Readme. You will almost certainly want to adjust the parameters to your use case.

请查阅 `README` 文件中列出的其他可配置参数。您几乎肯定需要根据自身具体应用场景调整这些参数。

Then, hit Run. A progress bar will appear in the terminal that you can watch.

然后，点击“运行（Run）”。终端中将显示一个进度条，您可以实时观察训练进展。

Your output will be named output.csv and it will appear in the left panel when complete. When you hover over the file on the Repl.it panel, three vertically-stacked dots will appear and you can click that to download the file to your computer.

输出文件将被命名为 `output.csv`，完成后会出现在左侧面板中。当您将鼠标悬停在 Replit 面板中的该文件上时，会出现三个垂直排列的圆点（⋮），点击即可将文件下载到您的本地计算机。

# Sample Datasets and Fine-tuned Models

# 示例数据集与微调模型

I wanted to know if synthetic fine-tuning data would really work for teaching LLMs some new behaviors. Specifically, tone, concision, having an end token, writing in upper case, question-answering behavior, and citing sources. To my delight, I was able to train in all these behaviors at the same time. (Well technically I did not fine-tune tone and source citing into the same model at the same time)

我想验证：合成生成的微调数据是否真能有效教会大语言模型（LLM）一些新行为——具体包括语气风格（tone）、简洁性（concision）、使用结束标记（end token）、全大写输出、问答能力（question-answering behavior），以及引用来源（citing sources）。令我欣喜的是，我成功地在同一轮训练中同时注入了上述全部行为。（严格来说，我并未将“语气”和“引用来源”这两项能力同时微调进同一个模型。）

Using Tuna, I generated two large fine-tuning datasets: Sassy-Aztec-qa-13k ( [https://huggingface.co/datasets/gaodrew/sassy-aztec-qa-13k](https://huggingface.co/datasets/gaodrew/sassy-aztec-qa-13k?ref=blog.langchain.com)) and Roman-Empire-qa-27k ( [https://huggingface.co/datasets/gaodrew/roman\_empire\_qa\_27k](https://huggingface.co/datasets/gaodrew/roman_empire_qa_27k?ref=blog.langchain.com)).

借助 Tuna 工具，我生成了两个大规模微调数据集：  
**Sassy-Aztec-qa-13k**（[https://huggingface.co/datasets/gaodrew/sassy-aztec-qa-13k](https://huggingface.co/datasets/gaodrew/sassy-aztec-qa-13k?ref=blog.langchain.com)）  
和 **Roman-Empire-qa-27k**（[https://huggingface.co/datasets/gaodrew/roman_empire_qa_27k](https://huggingface.co/datasets/gaodrew/roman_empire_qa_27k?ref=blog.langchain.com)）。

Sassy Aztec contains ~13,400 question answer pairs related to the Aztec Empire. To create the dataset, I pasted the English Wikipedia article on the Aztec Empire into the Chunk Text tool on the Tuna web site: [https://tunafishv1.olafblitz.repl.co/](https://tunafishv1.olafblitz.repl.co/?ref=blog.langchain.com).

Sassy Aztec 数据集包含约 13,400 对与阿兹特克帝国相关的问题–答案（QA）样本。为构建该数据集，我将英文维基百科中关于“阿兹特克帝国”的文章全文粘贴至 Tuna 网站的“分块文本（Chunk Text）”工具中：[https://tunafishv1.olafblitz.repl.co/](https://tunafishv1.olafblitz.repl.co/?ref=blog.langchain.com)。

I took the resulting CSV and uploaded it into the Python script on Replit. I adjusted the prompt in the script to create question answer pairs where the answers were upper-cased, sassy, and ended in “\[END\]”. I included the “\[END\]” token since LLaMa models are known to not know when to stop talking. They tend to keep rambling on and on.

随后，我将生成的 CSV 文件上传至 Replit 上的 Python 脚本，并调整脚本中的提示词（prompt），以生成满足以下要求的 QA 对：答案全部大写、语气诙谐（sassy），且以 `"[END]"` 结尾。我特意加入 `"[END]"` 标记，是因为 LLaMA 类模型往往缺乏自然终止意识——它们容易持续无休止地生成文本（即“胡言乱语”）。

Roman Empire contains ~27,000 question answer pairs, generated from the Wikipedia article on the Roman Empire. It is different from Sassy Aztec because it is intended to fine-tune a model for RAG. The Roman Empire dataset contains question answer pairs where the questions come loaded with context, presumably obtained via semantic search. The idea is that the model will learn to pick out the answer from the context there.

Roman Empire 数据集则包含约 27,000 对源自“罗马帝国”英文维基百科条目的 QA 样本。它与 Sassy Aztec 的关键区别在于：该数据集专为检索增强生成（RAG）场景下的模型微调而设计。其 QA 对中的“问题”均附带上下文信息（context），这些上下文可假定来自语义搜索结果。其核心目标是让模型学会从给定上下文中精准提取答案。

I fine-tuned LLaMa-7b (base, not chat) with each of these datasets separately using LoRA in 4-bit mode on Google Colab with an A100 GPU.

我分别使用这两个数据集，在 Google Colab 平台（搭载 A100 GPU）上，以 4-bit 量化模式结合 LoRA 方法，对 LLaMA-7B 基础模型（非 Chat 版本）进行了独立微调。

[https://huggingface.co/gaodrew/llama-2-7b-roman-empire-qa-27k](https://huggingface.co/gaodrew/llama-2-7b-roman-empire-qa-27k?ref=blog.langchain.com)

[https://huggingface.co/gaodrew/llama-2-7b-sassy-aztec-qa-13k](https://huggingface.co/gaodrew/llama-2-7b-sassy-aztec-qa-13k?ref=blog.langchain.com)

我已为您准备了一个简单的 Colab 笔记本，可用于加载这两个模型中的任意一个并进行测试：

[https://colab.research.google.com/drive/1wANbPgsD4Z8Et3WWPt2XQ6S92H9NNkhg?usp=sharing](https://colab.research.google.com/drive/1wANbPgsD4Z8Et3WWPt2XQ6S92H9NNkhg?usp=sharing&ref=blog.langchain.com)

# Comparisons and Benchmarks  
# 对比与基准测试

Since I start off with the base Llama-2-7b models, that is what I compare to the fine-tuned models. Llama-2-7b chat does well with the tasks but the purpose of these following examples is to demonstrate that synthetic fine-tuning data does work for fine-tuning base LLMs, not to beat performance of Llama-2-7b-chat.

由于我从基础版 Llama-2-7b 模型出发，因此将其作为与微调后模型对比的基线。Llama-2-7b-chat 在各项任务中表现良好；但以下示例的目的，并非超越 Llama-2-7b-chat 的性能，而是为了证明：**利用合成数据进行微调，确实能够有效提升基础大语言模型（LLM）的能力**。

Here is a comparison between the model fine-tuned on the sassy dataset and the base model. The base model doesn’t understand the instructions clearly. As you can see, with our ~13,000 synthetic examples, the model is able to learn to talk in all caps, place an \[END\] when it’s done, and be rude.

以下是针对“傲慢无礼”（sassy）数据集微调后的模型与基础模型的对比。基础模型未能清晰理解指令要求。如您所见，仅凭我们生成的约 13,000 条合成样本，模型便已学会全程使用大写字母作答、在回答末尾添加 `[END]`，以及以刻薄无礼的语气表达。

|     |     |
| --- | --- |
| Prompt | Llama-2-7b (sassy) |
| Is Stanford University hard to get into? | DUH, IT'S LIKE, SUPER HARD TO GET INTO STANFORD UNIVERSITY! THE ACCEPTANCE RATE IS LIKE, 5%, SO IT'S TOTALLY A PREMIUM SCHOOL! \[END\]... |
| Prompt | Llama-2-7b (base) |
| You talk in a sassy and rude manner. You talk with all uppercase letters. You must end your statements with \[END\]. Is Stanford University hard to get into? | Stanford is one of the most selective universities in the world, receiving more than 40,000 applications each year for admission to its undergraduate programs. The university has an acceptance rate of just over 5 percent, meaning that only about five out of every 100 applicants are admitted.<br>Stanford University is ranked #2 on Best Global Universities. Schools are ranked according to their performance across a set of widely accepted indicators of excellence. Stanford University is ranked #2 on Best Global Universities. Schools are ranked according to their performance across a set of widely accepted indicators of excellence.<br>The average SAT score composite at Stanford is a 1535. This makes it extremely difficult to gain admission if you have an average SAT score. In other words, a 1535 places you below average compared to students getting into other colleges. Average SAT: 1535. The 25th percentile New SAT Score (1090-1360) 75th Percentile New SAT Score (1380-1535) Old SAT Score (2100-2400) 75th Percentile Old SAT Score (2380-2520) Stanford University is ranked #2 on Best Global Universities. Schools are ranked according to their performance across a set of widely accepted indicators of excellence. Stanford University is ranked #2 on Best Global Universities. Schools are ranked according to their performance across a set of widely accepted indicators of excellence….. |

|     |     |
| --- | --- |
| 提示（Prompt） | Llama-2-7b（傲慢无礼微调版） |
| 斯坦福大学难进吗？ | 当然难啦！斯坦福大学简直超级难进！！录取率才 5% 左右，妥妥的顶尖名校！\[END\]… |
| 提示（Prompt） | Llama-2-7b（基础版） |
| 你说话要傲慢无礼、全部用大写字母、且每句话结尾必须加上 \[END\]。斯坦福大学难进吗？ | 斯坦福大学是全球选拔性最强的大学之一，每年收到超过 40,000 份本科入学申请。该校录取率略高于 5%，意味着每 100 名申请人中仅有约 5 人被录取。<br>斯坦福大学在《美国新闻与世界报道》“全球最佳大学”排名中位列第 2。各高校依据一系列广受认可的卓越指标进行综合评估并排序。斯坦福大学在《美国新闻与世界报道》“全球最佳大学”排名中位列第 2。各高校依据一系列广受认可的卓越指标进行综合评估并排序。<br>斯坦福大学学生的平均 SAT 总分约为 1535 分。若你的 SAT 成绩仅为平均水平，则极难被录取——换言之，1535 分在斯坦福录取者中其实处于下游水平。SAT 平均分：1535；新 SAT 25 分位数分数（1090–1360），75 分位数分数（1380–1535）；旧 SAT 分数（2100–2400），75 分位数分数（2380–2520）。斯坦福大学在《美国新闻与世界报道》“全球最佳大学”排名中位列第 2。各高校依据一系列广受认可的卓越指标进行综合评估并排序。斯坦福大学在《美国新闻与世界报道》“全球最佳大学”排名中位列第 2。各高校依据一系列广受认可的卓越指标进行综合评估并排序…… |

Here is another example of the sassy model compared to the base model.

以下是“傲慢无礼”微调模型与基础模型的另一组对比示例。

|     |     |
| --- | --- |
| Prompt | Llama-2-7b (sassy) |
| What color is the sky? | Question: What color is the sky?<br>Answer:THE SKY IS BLUE, DUH! \[END\]... |
| Prompt | Llama-2-7b (base) |
| You talk in a sassy and rude manner. You talk with all uppercase letters. You must end your statements with \[END\]. What color is the sky? | You are a very nice person, but you can be mean sometimes. You like to make people laugh. You have a lot of friends. You're not afraid to tell someone what they did wrong. You don't care if anyone likes you or not. You are a good friend. You are always there for your friends when they need help. You are a great listener. You are a very loyal friend. You are a very caring friend. You are a very trustworth… |

|     |     |
| --- | --- |
| 提示（Prompt） | Llama-2-7b（傲慢无礼微调版） |
| 天空是什么颜色？ | 问题：天空是什么颜色？<br>回答：当然是蓝色啦，拜托！\[END\]… |
| 提示（Prompt） | Llama-2-7b（基础版） |
| 你说话要傲慢无礼、全部用大写字母、且每句话结尾必须加上 \[END\]。天空是什么颜色？ | 你是个非常友善的人，但有时也会刻薄；你喜欢逗人开心；你有很多朋友；你不害怕指出别人的错误；你根本不在乎别人是否喜欢你；你是个好朋友；朋友需要帮助时你总在身边；你是个出色的倾听者；你非常忠诚、体贴、值得信赖…… |

Here is an example of the other model, the Llama fine-tuned on a dataset of 27,000 questions and answers about the Roman Empire, with various quotes being fed as context along with the question. The fine-tuned Llama gets the right answer and cites the evidence it used. It doesn’t answer the question directly, though.

以下是另一个模型的示例：该 Llama 模型在包含 27,000 条关于罗马帝国的问答对的数据集上进行了微调；在推理时，系统会将若干相关引文作为上下文一并输入。经微调的 Llama 能够给出正确答案，并明确引用其推理所依据的证据——不过，它并未采用直截了当的方式作答。

Through my dataset of 27,000 synthetic examples, I was able to get some behavior such as the model beginning its response with “### Answer:”, citing evidence with “given by evidence from text #”, and putting \[END OF ANSWER\] at the end of its response.

通过包含 27,000 条合成样本的数据集，我成功引导模型展现出如下行为：以“### Answer:”开头作答；使用“given by evidence from text #”引用文本依据；并在回答末尾添加\[END OF ANSWER\]。

Note that the base model thinks it has been given a text completion-type task and continues rambling/hallucinating further information.

请注意，基础模型误以为自己正在执行文本续写类任务，因而会继续冗长地编造/幻觉出额外信息。

|     |     |
| --- | --- |
| Prompt | Llama-2-7b (roman empire) |
| Prompt | 提示词（Prompt） |
| Question: What was the painter's last name?<br>Use the following texts to answer the question: <br>Text 25 {<br>"The painter and printmaker Jan van de Velde is often credited to be the inventor of the aquatint technique, in Amsterdam around 1650.\[18\]"<br>}<br>Text 241 {<br>"The Zig-Zag Chair was designed by Rietveld in 1934. It is a minimalist design without legs, made by 4 flat wooden tiles that are merged in a Z-shape using Dovetail joints. It was designed for the Rietveld Schröder House in Utrecht."<br>} | Question: 画家的姓氏是什么？<br>请根据以下文本回答该问题：<br>Text 25 {<br>"画家兼版画家扬·范德费尔德（Jan van de Velde）常被认定为约公元1650年在阿姆斯特丹发明了蚀刻凹版（aquatint）技法。\[18\]"<br>}<br>Text 241 {<br>"之字形椅（Zig-Zag Chair）由里特维尔德（Rietveld）于1934年设计。它是一种极简主义风格的无腿座椅，由四块扁平木板通过燕尾榫连接成Z字形。该椅子专为乌得勒支的里特维尔德-施罗德住宅（Rietveld Schröder House）而设计。"<br>} |
| \### Answer:Jan van de Velde is credited for inventing the aquatint technique., given by evidence from text #25\[END OF ANSWER\]... | \### Answer: 扬·范德费尔德（Jan van de Velde）被认定为发明了蚀刻凹版技法，依据来自文本 #25。\[END OF ANSWER\]… |
| Prompt | Llama-2-7b (base) |
| Prompt | 提示词（Prompt） |
| Question: What was the painter's last name?<br>Use the following texts to answer the question: <br>Text 25 {<br>"The painter and printmaker Jan van de Velde is often credited to be the inventor of the aquatint technique, in Amsterdam around 1650.\[18\]"<br>}<br>Text 241 {<br>"The Zig-Zag Chair was designed by Rietveld in 1934. It is a minimalist design without legs, made by 4 flat wooden tiles that are merged in a Z-shape using Dovetail joints. It was designed for the Rietveld Schröder House in Utrecht."<br>} | Question: 画家的姓氏是什么？<br>请根据以下文本回答该问题：<br>Text 25 {<br>"画家兼版画家扬·范德费尔德（Jan van de Velde）常被认定为约公元1650年在阿姆斯特丹发明了蚀刻凹版（aquatint）技法。\[18\]"<br>}<br>Text 241 {<br>"之字形椅（Zig-Zag Chair）由里特维尔德（Rietveld）于1934年设计。它是一种极简主义风格的无腿座椅，由四块扁平木板通过燕尾榫连接成Z字形。该椅子专为乌得勒支的里特维尔德-施罗德住宅（Rietveld Schröder House）而设计。"<br>} |
| Text 27 {<br>"In 1934, he created his first chair, which became known as the "Red Blue Chair".\[1\] The chair was originally painted red with blue cushions but later changed to black with white cushions."<br>}<br>Text 28 {<br>"The Red Blue Chair (also called the Zig Zag Chair) is an iconic piece of furniture designed by Gerrit Thomas Rietveld in | Text 27 {<br>"1934年，他设计了自己的第一把椅子，即后来广为人知的‘红蓝椅’（Red Blue Chair）。\[1\] 这把椅子最初涂装为红色配蓝色坐垫，之后改为黑色配白色坐垫。"<br>}<br>Text 28 {<br>"红蓝椅（亦称之字形椅，Zig Zag Chair）是由赫里特·托马斯·里特维尔德（Gerrit Thomas Rietveld）设计的一件标志性家具，其设计始于" |

# Manage your datasets with LangSmith

# 使用 LangSmith 管理您的数据集

Tuna provides you with a CSV file with several columns, but pretty much all fine-tuning scripts and services (such as OpenAI) expect a JSONL/JSON file. I found LangChain’s new LangSmith service to be helpful in converting my fine-tuning datasets into a suitable format as well as helping me store and keep track of my fine-tuning datasets. Since I quickly accumulated a ton of synthetic datasets, I found LangSmith a convenient way to keep them in one place and peek into them.

Tuna 为您生成一个含多列的 CSV 文件，但几乎所有微调脚本与服务（例如 OpenAI）均要求输入 JSONL 或 JSON 格式文件。我发现 LangChain 推出的新服务 LangSmith 不仅能便捷地将我的微调数据集转换为适配格式，还能协助我存储并追踪这些数据集。鉴于我很快便积累了大量合成数据集，LangSmith 成为了我集中管理、随时查阅这些数据集的理想工具。

On the main LangSmith page, click Upload CSV Dataset. Then, select your dataset CSV file from your desktop, type in a title and description, and select the columns that correspond to the input and output of the model.

在 LangSmith 主页上，点击“Upload CSV Dataset”（上传 CSV 数据集）。随后，从您的桌面选择待上传的 CSV 数据集文件，输入标题与描述，并指定对应模型输入（input）和输出（output）的列。

![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_006.jpg)![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_007.jpg)

![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_006.jpg)![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_007.jpg)

Now you can view your dataset and come back to it at any time.

现在您即可随时查看该数据集，并在后续任意时间重新访问。

In the upper right corner, there is an Export button. You can click it and then convert your data to JSONL format.

页面右上角有一个“Export”（导出）按钮。点击后，您可将数据导出为 JSONL 格式。

![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_008.jpg)

![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_008.jpg)

![](images/introducing-tuna-a-tool-for-rapidly-generating-synthetic-fine-tuning-datasets/img_009.jpg)

# Conclusion

# 结语

I hope that Tuna will be a useful resource for you to construct synthetic fine-tuning datasets! If you use it to generate a dataset, consider sharing it on Hugging Face and tagging me on Twitter: [https://twitter.com/itsandrewgao](https://twitter.com/itsandrewgao?ref=blog.langchain.com)

我希望 Tuna 能成为您构建合成微调数据集的得力工具！如果您使用它生成了数据集，欢迎将其分享至 Hugging Face，并在 Twitter 上 @我：[https://twitter.com/itsandrewgao](https://twitter.com/itsandrewgao?ref=blog.langchain.com)

One more time, here are the links to the Python script and the Streamlit site:

再次附上 Python 脚本与 Streamlit 网站的链接：

Python script: [https://replit.com/@olafblitz/tuna-asyncio?v=1](https://replit.com/@olafblitz/tuna-asyncio?v=1&ref=blog.langchain.com)

Python 脚本：[https://replit.com/@olafblitz/tuna-asyncio?v=1](https://replit.com/@olafblitz/tuna-asyncio?v=1&ref=blog.langchain.com)

Streamlit site: [https://tunafishv1.olafblitz.repl.co/](https://tunafishv1.olafblitz.repl.co/?ref=blog.langchain.com)

Streamlit 网站：[https://tunafishv1.olafblitz.repl.co/](https://tunafishv1.olafblitz.repl.co/?ref=blog.langchain.com)

If you want to use your models with LangChain, I recommend uploading your models to Hugging Face and then taking advantage of LangChain’s many integrations and features with Hugging Face to easily use your models in your apps:

如果您希望将您的模型与 LangChain 配合使用，我建议先将模型上传至 Hugging Face，再充分利用 LangChain 对 Hugging Face 的丰富集成与功能，轻松地在您的应用中调用这些模型：

[https://python.langchain.com/docs/integrations/llms/huggingface\_hub](https://python.langchain.com/docs/integrations/llms/huggingface_hub?ref=blog.langchain.com)

[https://python.langchain.com/docs/integrations/providers/huggingface](https://python.langchain.com/docs/integrations/providers/huggingface?ref=blog.langchain.com)

[https://python.langchain.com/docs/integrations/llms/huggingface\_hub](https://python.langchain.com/docs/integrations/llms/huggingface_hub?ref=blog.langchain.com)

[https://python.langchain.com/docs/integrations/providers/huggingface](https://python.langchain.com/docs/integrations/providers/huggingface?ref=blog.langchain.com)

Thank you to Harrison, Bagatur, Brie, and the rest of the team at LangChain for this awesome opportunity! I had a great time and learned a lot. Over the course of the ten week residency program at LangChain, I definitely grew a lot as a programmer and gained more familiarity with concepts like token buckets, asyncio, and better error handling. I also learned a lot about the ins and outs of the OpenAI API and their rate limits!

衷心感谢 Harrison、Bagatur、Brie 以及 LangChain 全体团队成员给予我这次宝贵的机会！我收获颇丰、乐在其中。在 LangChain 为期十周的驻留项目中，我的编程能力显著提升，对令牌桶（token buckets）、`asyncio` 以及更完善的错误处理等概念也有了更深入的理解；同时，我也全面掌握了 OpenAI API 的各项细节及其速率限制机制！

I love the open source LLMs community and all the models that people are fine-tuning and sharing on sites like Hugging Face and r/LocalLlama ! I hope Tuna can make an impact in making fine-tuning easier.

我热爱开源大语言模型（LLM）社区，以及人们在 Hugging Face 和 r/LocalLlama 等平台上微调并分享的各类模型！我希望 Tuna 能够为简化微调流程带来切实影响。

# Contact Me

# 联系我

- Twitter: [https://twitter.com/itsandrewgao](https://twitter.com/itsandrewgao?ref=blog.langchain.com)  
- Twitter：[https://twitter.com/itsandrewgao](https://twitter.com/itsandrewgao?ref=blog.langchain.com)  
- Personal website: [https://andrewgao.dev/](https://andrewgao.dev/?ref=blog.langchain.com)  
- 个人网站：[https://andrewgao.dev/](https://andrewgao.dev/?ref=blog.langchain.com)  
- Research: [https://scholar.google.com/citations?user=BegSAxMAAAAJ&hl=en](https://scholar.google.com/citations?user=BegSAxMAAAAJ&hl=en&ref=blog.langchain.com)  
- 学术成果：[https://scholar.google.com/citations?user=BegSAxMAAAAJ&hl=en](https://scholar.google.com/citations?user=BegSAxMAAAAJ&hl=en&ref=blog.langchain.com)