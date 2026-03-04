---
title: "Generating Usable Text with AI"
source: "LangChain Blog"
url: "https://blog.langchain.com/generating-usable-text-with-ai/"
date: "2024-02-05"
scraped_at: "2026-03-03T08:16:31.230578057+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

_Editor's Note: This post was written by_ [_Mutt Data_](https://muttdata.ai/?ref=blog.langchain.com) _through LangChain's Partner Program._

编辑者注：本文由 [_Mutt Data_](https://muttdata.ai/?ref=blog.langchain.com) 撰写，系 LangChain 合作伙伴计划（LangChain's Partner Program）支持项目。

## Introduction

## 引言

### Overview

### 概述

In our previous discussions, we not only delved into the [challenges of implementing Generative AI applications](https://blog.muttdata.ai/post/2023-11-27-genAI-framework?ref=blog.langchain.com) in general but also explored effective [mitigation strategies for image generation](https://blog.muttdata.ai/post/2024-01-03-gen-ai-pictures?ref=blog.langchain.com) problems. Now, it's time to shift our focus to the unique set of challenges that arise when **generating text**.

在之前的讨论中，我们不仅深入探讨了[构建生成式 AI 应用所面临的普遍挑战](https://blog.muttdata.ai/post/2023-11-27-genAI-framework?ref=blog.langchain.com)，还系统分析了针对[图像生成问题的有效缓解策略](https://blog.muttdata.ai/post/2024-01-03-gen-ai-pictures?ref=blog.langchain.com)。如今，是时候将关注点转向**文本生成**过程中所特有的各类挑战了。

In this blog post, we provide a concise overview of these **challenges while** sharing some **insights** from our experiences utilizing **Large Language Models**( **LLMs**). To lay the groundwork for our exploration, we will first introduce some fundamental concepts such as **prompts** and **prompt engineering**. Let’s go right to it!

本文将简明扼要地概述这些**挑战**，同时分享我们在实际应用**大语言模型**（**LLMs**）过程中积累的若干**洞见**。为铺垫后续探讨，我们将首先介绍一些基础概念，例如**提示词**（**prompts**）与**提示工程**（**prompt engineering**）。现在，让我们直入主题！

### Prompts

### 提示词（Prompts）

If you have been involved in the Generative AI world in the last months, you have probably heard about **prompts**. Prompts are specific **user-provided inputs** that **guide** LLMs to generate an appropriate response tailored to a given **task**.

如果你在过去几个月中持续关注生成式 AI 领域，你很可能已听说过 **prompts**（提示词）。提示词是用户提供的特定**输入**，用于**引导**大语言模型（LLMs）生成契合某一具体**任务**的恰当响应。

As well as we expect some kind of order in the sections of a presentation (introduction, discussion, solution, and conclusion), LLMs work much better if we follow some **structure** in our prompts. Moreover, this structure can greatly vary depending on the task we want to perform. To illustrate, some common tasks supported by LLMs include: classification, question-answer, summarization, code generation, and reasoning. It's essential to adapt the structure to the specific requirements and particularities of each type of task when **crafting** prompts for these diverse tasks.

正如我们期望一场演示文稿具备清晰的逻辑结构（如引言、讨论、解决方案与结论），若我们在设计提示词时也遵循某种**结构化方式**，大语言模型的表现通常会显著提升。此外，这种结构会因目标任务的不同而差异显著。举例而言，LLMs 常见支持的任务类型包括：文本分类、问答、摘要生成、代码生成以及逻辑推理。因此，在为上述各类任务**精心设计**提示词时，必须根据每类任务的具体需求与特性灵活调整其结构。

### Prompt Engineering

### 提示工程（Prompt Engineering）

The practice of optimizing input prompts by selecting appropriate words, phrases, sentences, punctuation, and separator characters to effectively use LLMs, is known as **prompt engineering**. In other words, prompt engineering is the art of communicating with an LLM in a manner that aligns with its expected understanding and enhances its performance.

通过精心选择词语、短语、句子、标点符号及分隔符等方式来优化输入提示词，从而更高效地利用大语言模型——这一实践即被称为**提示工程**（**prompt engineering**）。换言之，提示工程是一门“与大语言模型对话”的艺术：它要求我们以契合模型预期理解的方式进行表达，进而提升其输出质量与整体性能。

An example of a well formed prompt in case of Summarization is attached below

一个用于摘要任务的结构良好提示词（prompt）示例如下：

![](images/generating-usable-text-with-ai/img_001.jpg)

Well formed prompt example. Extracted from [docs.aws.amazon.com](https://docs.aws.amazon.com/bedrock/latest/userguide/general-guidelines-for-bedrock-users.html?ref=blog.langchain.com)

结构良好的提示词示例。摘自 [docs.aws.amazon.com](https://docs.aws.amazon.com/bedrock/latest/userguide/general-guidelines-for-bedrock-users.html?ref=blog.langchain.com)

On the other hand if your use case is Classification, including some **examples**(input-response pairs) for each category after the contextual information, could be really helpful. This is known as **few-shot prompting** and could also apply to more complex tasks such as Question-answer. However, the more complex the task, the more examples that will be needed to improve performance.

另一方面，若您的应用场景是分类（Classification），则在提供上下文信息之后，为每个类别附上若干**示例**（即输入–输出对），将非常有帮助。这种方法被称为**少样本提示（few-shot prompting）**，同样适用于问答（Question-Answering）等更复杂的任务。但任务越复杂，为提升模型表现所需提供的示例数量通常也越多。

Another powerful technique is to ask the LLM to **reason** and **explain** prior to giving the final answer, also known as “ **step by step**” reasoning. The essential concept behind this relies on the autoregressive nature of these models, which means that each predicted word influences the generation of the next element in the sequence. Please find more details about this [here](https://github.com/openai/openai-cookbook/blob/main/articles/techniques_to_improve_reliability.md?ref=blog.langchain.com).

另一种强大技巧是：要求大语言模型（LLM）在给出最终答案前先进行**推理**与**解释**，即所谓“**逐步推理（step-by-step reasoning）**”。该方法的核心原理源于此类模型的自回归（autoregressive）特性——即每一个预测出的词都会影响序列中下一个元素的生成。关于此技术的更多细节，请参阅[此处](https://github.com/openai/openai-cookbook/blob/main/articles/techniques_to_improve_reliability.md?ref=blog.langchain.com)。

Last but not least we could consider refining our prompts with **modifiers**, such as including details about the input data, specifying output format or simply encouraging the LLM at the end of the prompt. Amazon Web Services provides further [details](https://docs.aws.amazon.com/bedrock/latest/userguide/general-guidelines-for-bedrock-users.html?ref=blog.langchain.com#:~:text=Consider%20refining%20the%20prompt%20with%20modifiers) about this.

最后但同样重要的是，我们还可借助**修饰语（modifiers）**优化提示词，例如补充输入数据的细节、明确指定输出格式，或仅在提示词末尾加入鼓励性语句以引导模型。Amazon Web Services 提供了关于该方法的进一步[详细说明](https://docs.aws.amazon.com/bedrock/latest/userguide/general-guidelines-for-bedrock-users.html?ref=blog.langchain.com#:~:text=Consider%20refining%20the%20prompt%20with%20modifiers)。

## Navigating Challenges and Solutions

## 应对挑战与解决方案

### 1) Less is More

### 1）少即是多

**Challenge**: **When using LLMs we’re talking to a program, not a human.**

**挑战**：**使用大语言模型时，我们是在与程序对话，而非与人类交流。**

Unlike human conversations where we can be somewhat messy and correct ourselves, providing complex or controversial instructions to an LLM can lead to inconsistent and incorrect responses. Clear and straightforward instructions are crucial for helping the LLM focus on relevant information and produce accurate results.

与人类对话不同——人类可以表达得略显凌乱，并随时自我修正——向大语言模型提供复杂或存在争议的指令，往往会导致响应不一致甚至错误。清晰、直白的指令至关重要，有助于引导模型聚焦于相关信息，并生成准确结果。

**Solution**: **Clear, concise, and smart prompting.**

**解决方案**：**清晰、简洁且智能的提示词设计。**

Be as clear as possible when crafting prompts. Also known as prompt engineering, selecting precise words and phrases for clear and concise instructions is key. You can also explore [prompt templates](https://ignacio-velasquez.notion.site/2-500-ChatGPT-Prompt-Templates-d9541e901b2b4e8f800e819bdc0256da?ref=blog.langchain.com) for similar use cases to discover effective structures for certain tasks.

在编写提示词时，务必尽可能清晰明确。“提示词工程”（prompt engineering）正是指通过精心选择准确的词汇与短语，构建清晰简洁的指令。您还可参考 [提示词模板库](https://ignacio-velasquez.notion.site/2-500-ChatGPT-Prompt-Templates-d9541e901b2b4e8f800e819bdc0256da?ref=blog.langchain.com)，针对类似应用场景探索已被验证有效的提示结构。

**Example**: Let’s consider two prompts for summarizing a food product description from a lengthy description into a concise title and caption for packaging.

**示例**：我们以“将一段冗长的食品产品描述提炼为适用于包装的简明标题与宣传文案”这一任务为例，对比两个提示词：

_Prompt 1: Please analyze the extensive details provided about this food product, including the ingredients, benefits, instructions, and customer reviews. Extract the most crucial information, taking into account various aspects such as nutritional value, taste, user experiences, and overall market trends. Create a concise summary suitable for product packaging, striking a balance between brevity and capturing the product's multifaceted qualities. Also, ensure that the summary caters to diverse consumer preferences and aligns with current industry standards. It should be versatile enough to meet the expectations of both seasoned food enthusiasts and those new to culinary experiences. Additionally, incorporate any notable advancements in food science and technology to highlight the product's innovative features._

_提示词 1_：请分析关于该食品产品的详尽信息，包括成分、功效、使用说明及用户评价；综合考量营养价值、口感、用户体验及整体市场趋势等多方面因素，提取最关键的信息；生成一段适用于产品包装的简洁摘要，在精炼性与全面呈现产品多重特质之间取得平衡；同时确保摘要契合不同消费者群体的偏好，并符合当前行业标准；其表达应兼具普适性，既能满足资深美食爱好者的期待，也便于初涉烹饪体验的新手理解；此外，请融入食品科学与技术领域的任何重要进展，以凸显产品的创新特性。

_Prompt 2_: _Summarize essential details for a food product, emphasizing ingredients, benefits, and user experiences. Create a brief yet compelling title and caption suitable for product packaging, ensuring its appeal to a broad audience and highlighting any innovative features. Emphasize clarity and brevity in the summary, taking into consideration the varied preferences and experiences of food enthusiasts._

_提示词 2_：请提炼该食品产品的核心信息，重点突出其成分、功效与用户真实体验；据此生成一个简短而富有吸引力的标题及配套宣传文案，适用于产品包装；确保内容对广泛受众具有吸引力，并凸显任何创新特性；摘要须强调清晰性与简洁性，同时兼顾美食爱好者群体中差异化的偏好与经验背景。

Which one describes the task in a clearer way?

哪一个提示词对任务的描述更为清晰？

### 2) Divide & Conquer

### 2）分而治之（Divide & Conquer）

**Challenge**: LLMs excel at tackling some specific tasks, but we should not overwhelm them by asking to do a bunch of them at the same time!

**挑战**：大语言模型（LLM）擅长处理某些特定任务，但我们不应要求它在同一时间完成多项任务，以免造成过载！

**Solution**: Break down complex tasks into simpler ones by using straightforward prompts and then gather the results.

**解决方案**：将复杂任务拆解为若干简单子任务，分别使用直截了当的提示词逐一执行，再汇总结果。

**Example**: When recommending movies from a long list of options to users, we found that the accuracy of correct recommendations improved significantly by asking if the movies were suitable one by one instead of providing long lists of movies altogether. Check the following two prompts:

**示例**：在面向用户从一份冗长片单中推荐电影时，我们发现：若逐一向模型询问“某部电影是否适合该用户”，其推荐准确率显著高于一次性提交整份片单并要求模型整体判断。请参阅以下两个提示词：

> _Prompt 1_: You are a language model assisting a web platform in recommending movies to users based on their preferences. Your objective is to present the movies attractively and sorted by the level of relevance. Below is the complete list of available movies, along with their features. Describe these attributes in an appealing manner, commencing with the movie names. The total list of movies includes:  
>  
> \[ { "Movie Title": "Daring Odyssey",\
> \
>     "Category": "Adventure",\
> \
>    "Description": "Embark on an exciting journey filled with twists and turns. Join the protagonists as they navigate through breathtaking landscapes and face thrilling challenges. A cinematic adventure you won't want to miss!",\
> \
> },,  …(whole list)...\]

> _Prompt 1_：你是一个语言模型，协助某网络平台根据用户偏好推荐电影。你的目标是以富有吸引力的方式呈现电影，并按相关度由高到低排序。以下是全部可选电影及其属性信息。请以引人入胜的方式描述这些属性，且须以电影名称为开头。全部电影列表包括：  
>  
> \[ { "Movie Title": "Daring Odyssey",\
> \
>     "Category": "Adventure",\
> \
>    "Description": "开启一段充满曲折与惊喜的精彩旅程！跟随主角穿越壮丽非凡的自然景观，直面扣人心弦的重重挑战——这是一场不容错过的银幕冒险！",\
> \
> },,  …（完整列表）...\]

> _Prompt 2_: You are a language model that recommends movies. Your job is to determine if the movie category and description are both suitable for the user's freely written description:  
>  
> \-\-\--  
>  
> User's description: {user\_description}.  
>  
> Movie category: {movie\_category}  
>  
> Movie description: {movie\_description}  
>  
> \-\-\--  
>  
> Reply with a JSON object in this format:  
>  
> "reasoning": Briefly explain your reasoning to the user.  
>  
> "match": "YES" \| "NO"

> _Prompt 2_：你是一个电影推荐语言模型。你的任务是判断：该电影的类别与简介是否**均符合**用户自由撰写的偏好描述：  
>  
> \-\-\--  
>  
> 用户描述：{user\_description}。  
>  
> 电影类别：{movie\_category}  
>  
> 电影简介：{movie\_description}  
>  
> \-\-\--  
>  
> 请以如下格式返回一个 JSON 对象：  
>  
> "reasoning"：向用户简要说明你的判断依据。  
>  
> "match"：取值为 "YES" 或 "NO"

Which is a simpler task?  
哪一项任务更简单？

### 3) Power of an Elephant but Memory of a Bee  
### 3）大象之力，却仅有蜜蜂之记性  

**Challenge**: While LLMs can handle a broad spectrum of problems, they often face difficulty consistently _recalling_ specific instructions. While their _context_ grows, their ability to retain such details decreases.  
**挑战**：尽管大语言模型（LLM）能应对广泛多样的问题，却常常难以稳定地 _记住_ 具体指令。随着其 _上下文长度_ 增加，对这类细节的保持能力反而下降。

**Solution**: Reduce dependency on the LLM's memory by managing internal states within our applications. Generate controlled outputs, transitioning through intermediate steps to meet checkpoints and conditions.  
**解决方案**：通过在应用内部管理状态，降低对 LLM 记忆能力的依赖。生成受控输出，分阶段推进流程，依次满足各检查点与约束条件。

**Example**: This insight came from our experience developing a medical appointment scheduling app. Our first approach involved allowing the model to verify all patient-specified conditions against a list of available specialties and time slots of each doctor, emphasizing the fact that adding non-listed specialties or time slots was prohibited. However, this strategy led to the LLM systematically generating custom specialties not present in the list and unavailable time slots, even after we had already pointed out the mistake in the same conversation.  
**实例**：这一洞见源于我们开发一款医疗预约调度应用的实践。最初方案是让模型将患者提出的全部条件（如就诊原因、可选日期等），逐一与医生列表中已有的专科类别和可约时段进行比对，并反复强调：严禁添加未列明的专科或不可用时段。然而，即便我们在同一轮对话中已明确指出该错误，模型仍持续“发明”出列表中根本不存在的专科类别及实际不可约的时段。

As a solution, we refined our approach by orchestrating the process in validated steps (states): we first leveraged the LLM to collect patient information, such as the reason for consultation and available dates. Following validation, the LLM performed individual matches between the reason and each possible specialty. Subsequently, we employed a traditional database process to filter doctors based on the corresponding specialty and availability on the desired dates. This step ensured that we overcame the issue of inventing non-existing options. Finally, the LLM presented the patient with available appointments until one was confirmed.  
作为改进方案，我们将整个流程重构为若干经验证的步骤（即状态）：首先，利用 LLM 收集患者信息（如就诊原因、可选日期等）；经校验后，再由 LLM 将就诊原因逐一对齐至各潜在专科；随后，我们调用传统数据库逻辑，依据匹配所得专科及目标日期，筛选出符合条件的医生及其可用时段——此步骤彻底杜绝了“虚构选项”的问题；最后，由 LLM 向患者清晰呈现所有可选预约，直至其确认其中一项。

![](images/generating-usable-text-with-ai/img_002.jpg)  
![](images/generating-usable-text-with-ai/img_002.jpg)

Simplified diagram of states(light blue) for our medical appointment scheduling application. First managing the learning of user information and after it matching the right specialty and filtering possible doctors and time slots from a database  
本医疗预约调度应用的状态流程简化示意图（浅蓝色部分）：先完成用户信息采集，继而精准匹配对应专科，并最终从数据库中筛选出符合条件的医生及可约时段。

### 4) Evaluating performance

### 4) 性能评估

**Challenge**: Measuring performance and getting unbiased metrics on the quality of text generations.

**挑战**：衡量模型性能，并获取对文本生成质量的无偏评估指标。

**Solution**: Selecting a standardized tool for testing and evaluating LLMs

**解决方案**：选用标准化的工具来测试和评估大语言模型（LLM）。

**Example**: This was a clear issue we faced when implementing our medical appointment scheduling application. As a first approach we did a test suite of possible prompts corresponding to a set of topics. Referring to consultations that should get an appointment, others that were not able to be fulfilled due to the lack of a doctor with that specialty, and lastly incorporating messages that should be ignored or moderated because of being malicious. The way to evaluate the test suite was to manually perform the tests by a group of testers and make them provide a satisfaction score from 1 to 5. This was time consuming and tied to the bias of the annotators.

**示例**：在开发我们的医疗预约调度应用时，这曾是一个十分突出的问题。最初，我们构建了一套覆盖多个主题的测试用例集，包括：应成功安排预约的问诊请求、因缺乏对应专科医生而无法满足的请求，以及因内容恶意而需被忽略或审核的消息。当时，我们通过一组人工测试员手动执行这些测试，并请他们为每次响应打分（1–5 分）来评估效果。该方式不仅耗时，还严重依赖标注人员的主观判断，引入了显著的人为偏差。

We understood that this was not the correct approach for a production environment and did some extra research until we discovered a useful tool: [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com). This is a platform that provides support for developing LLM applications oriented to the production environment. It facilitates the test and evaluation process and provides a standard for certain metrics. Moreover, it covers the monitoring and debugging of your application, which makes the whole app lifecycle much more efficient.

我们意识到，这种人工评估方式并不适用于生产环境，因此开展了进一步调研，最终发现了实用工具：[LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com)。这是一个面向生产级 LLM 应用开发的平台，可显著简化测试与评估流程，并为关键评估指标提供统一标准。此外，它还支持应用运行时的监控与调试，从而大幅提升整个应用生命周期的效率。

As an example of our use case, we discovered it valuable to confirm that the successful messages, which offer assistance to the user, included specific information like the patient's name, the described issue, and the doctor's name.

以我们的实际场景为例，我们发现一项关键验证需求：确保所有成功响应（即向用户提供有效协助的消息）中必须包含特定信息，例如患者姓名、所描述的病情，以及指定医生的姓名。

LangSmith offers a user-friendly and straightforward approach to implement this functionality, along with comprehensive metrics for the dataset run, including mean, standard deviation, and percentiles of scores and execution time. In this instance, drawing inspiration from the examples outlined in the LangChain [Custom Evaluator](https://docs.smith.langchain.com/evaluation/custom-evaluators?ref=blog.langchain.com) section, we developed a "Criteria" evaluator utilizing an LLM to verify the presence of the specified input values in the response. With just 50 lines of Python code, we were all set to proceed!

LangSmith 提供了简洁易用的接口来实现此类功能，并为数据集的整体运行结果输出全面的评估指标，包括得分与执行时间的均值、标准差及各百分位数值。在此案例中，我们参考 LangChain 官方文档中 [自定义评估器（Custom Evaluator）](https://docs.smith.langchain.com/evaluation/custom-evaluators?ref=blog.langchain.com) 的示例，基于大语言模型开发了一个“条件型”（Criteria）评估器，用于自动校验模型响应中是否完整包含了上述指定字段。仅用约 50 行 Python 代码，我们便完成了全部开发工作！

To illustrate the example, consider the following LLM task…

为便于理解，我们来看如下所示的 LLM 任务示例……

![](images/generating-usable-text-with-ai/img_003.png)Langchain code running a simple response task for a patient, including some input fields

![](images/generating-usable-text-with-ai/img_003.png)Langchain 代码正在为一位患者执行一个简单的响应任务，其中包含若干输入字段。

Now let’s implement a criteria evaluator for our test:

接下来，让我们为本次测试实现一个条件型评估器：

![](images/generating-usable-text-with-ai/img_004.png)用于对数据集中的每个样本执行测试的评估器（Evaluator）

Finally let’s use the LangSmith client to run the test for each sample in a dataset:

最后，让我们使用 LangSmith 客户端对数据集中的每个样本运行测试：

![](images/generating-usable-text-with-ai/img_005.png)LangSmith 客户端代码：在先前创建的键值对（key-value）数据集上运行测试

Let’s check how LangSmith’s Web UI registers the trace of the run for one specific sample:

让我们查看 LangSmith 的 Web 用户界面如何记录某一个特定样本的运行追踪（trace）：

![](images/generating-usable-text-with-ai/img_006.jpg)开箱即用的 `CriteriaEvalChain` 在满足评估标准时返回分数 1，否则返回 0！[](images/generating-usable-text-with-ai/img_007.jpg)`CriteriaEvalChain` 的[提示模板（prompt）](https://github.com/langchain-ai/langchain/blob/master/libs/langchain/langchain/evaluation/criteria/prompt.py?ref=blog.langchain.com)，用于评估指定标准

Amazing! In this way we can run independent tests for specific datasets with custom criteria and have real metrics about the performance of our features with just some lines of code.

太棒了！通过这种方式，我们仅需几行代码，即可针对特定数据集运行独立测试、采用自定义评估标准，并获得关于我们功能实际性能的真实量化指标。

### 5) Security Risks

### 5) 安全风险

**Challenge**: Ensuring the reliability of your application to mitigate potential legal issues.

**挑战**：确保应用程序的可靠性，以规避潜在的法律风险。

**Solution**: Maintain strict control over both input and output within your application. Avoid direct utilization of the LLM to respond to user input. Instead, break down your processes into independent tasks or states and employ controlled prompts to leverage only the specific capabilities required from the LLM.

**解决方案**：严格管控应用程序的输入与输出。避免直接调用大语言模型（LLM）来响应用户输入；相反，应将业务流程拆解为若干独立的任务或状态，并通过受控的提示词（prompt）精准调用 LLM 所需的特定能力。

**Example**: We consistently integrate an input filter to validate and categorize user input. If a user's intention diverges from the intended purpose of the application, we gently remind them of the app's designated usage. This approach helps us circumvent potential pitfalls, as illustrated by the famous example attached below.

**示例**：我们始终集成输入过滤器，对用户输入进行验证与分类。若用户意图偏离应用程序的预设用途，我们会温和地提醒其应用的正确使用方式。该方法有助于我们规避潜在风险——如下方附带的经典案例所示。

![](images/generating-usable-text-with-ai/img_008.jpg)

公司聊天机器人过度赋予大语言模型（LLM）自由度的著名陷阱

## Conclusion

## 结论

To wrap things up, our exploration into challenges and solutions surrounding the application of Large Language Models (LLMs) for text generation underscores the importance of strategic considerations. By emphasizing the clarity of prompts, task segmentation, and robust evaluation practices, we pave the way for effective LLM applications.

总而言之，我们对大语言模型（LLM）在文本生成应用中所面临挑战与应对方案的探索，凸显了战略考量的重要性。通过强调提示词的清晰性、任务的合理拆分以及健全的评估实践，我们为高效、可靠的 LLM 应用铺平了道路。

The practical solutions presented, including the breakdown of complex tasks, management of internal states to reduce reliance on the LLM's memory, and stringent control over inputs and outputs, provide actionable insights for building reliable and efficient AI text applications.

本文提出的实用解决方案——包括将复杂任务逐层分解、通过管理内部状态以降低对 LLM 自身记忆能力的依赖，以及对输入与输出实施严格管控——为构建稳定、高效的 AI 文本应用提供了切实可行的指导。

It is evident that a thoughtful approach to LLM integration, grounded in practical methodologies, ensures a more seamless and impactful utilization of these powerful language models. As we refine our approaches, the landscape of possibilities in generative AI for usable text continues to expand, promising exciting developments on the horizon. The ongoing exploration of the synergy between human creativity and AI computational prowess remains at the forefront of this transformative field.

显而易见，基于务实方法论、审慎周密的大语言模型集成策略，能够确保这些强大语言模型更顺畅、更具影响力的应用效果。随着我们不断优化实践路径，面向可用文本的生成式 AI 可能性版图将持续拓展，预示着令人振奋的前沿进展。人类创造力与人工智能计算能力之间协同效应的持续探索，始终处于这一变革性领域的最前沿。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/generating-usable-text-with-ai/img_009.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/generating-usable-text-with-ai/img_010.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中推出端到端 OpenTelemetry 支持](images/generating-usable-text-with-ai/img_010.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/generating-usable-text-with-ai/img_011.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/generating-usable-text-with-ai/img_011.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/generating-usable-text-with-ai/img_012.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/generating-usable-text-with-ai/img_012.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/generating-usable-text-with-ai/img_013.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**LangSmith SDK v0.2 带来更轻松的评估体验**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/generating-usable-text-with-ai/img_014.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读
{% endraw %}
