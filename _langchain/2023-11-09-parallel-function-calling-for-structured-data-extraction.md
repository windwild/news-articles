---
title: "Parallel Function Calling for Structured Data Extraction"
source: "LangChain Blog"
url: "https://blog.langchain.com/parallel-function-calling-extraction/"
date: "2023-11-09"
scraped_at: "2026-03-03T08:28:47.622630811+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

**Important Links:**

**重要链接：**

- [**使用并行函数调用进行信息提取的实用指南（Cookbook）**](https://github.com/langchain-ai/langchain/blob/master/cookbook/extraction_openai_tools.ipynb?ref=blog.langchain.com)

One of the biggest use cases for language models that we see is in [**extraction**](https://python.langchain.com/docs/use_cases/extraction?ref=blog.langchain.com). This is where the language model is used to extract multiple pieces of structured information from unstructured documents. The biggest challenge developers faced here was in getting the language model to correctly output valid JSON.

我们观察到，大语言模型最重要的应用场景之一便是[**信息提取（extraction）**](https://python.langchain.com/docs/use_cases/extraction?ref=blog.langchain.com)。该任务指利用语言模型从非结构化文档中抽取多个结构化信息片段。开发者在此过程中面临的最大挑战，是让语言模型稳定、准确地输出合法的 JSON 格式结果。

OpenAI helped immensely with that when they introduced function calling in early 2023. At a high level, function calling encourages the model to respond in a structured format. This was mainly highlighted as a way for the language model to invoke functions correctly (when calling functions you need a response in the right format). However, there are many other places where having a properly structured response is useful – such as extraction. We recently did a [DeepLearningAI class](https://www.deeplearning.ai/short-courses/functions-tools-agents-langchain/?ref=blog.langchain.com) with Andrew Ng where we covered this in detail.

2023 年初，OpenAI 推出“函数调用（function calling）”功能，极大缓解了上述难题。简言之，函数调用机制引导模型以结构化格式生成响应——这一能力最初被强调为确保语言模型能正确调用外部函数（调用函数时，必须返回符合约定格式的响应）。然而，结构化响应的价值远不止于此，信息提取正是另一大关键应用场景。我们近期与 Andrew Ng 合作开设了一门 [DeepLearningAI 短期课程](https://www.deeplearning.ai/short-courses/functions-tools-agents-langchain/?ref=blog.langchain.com)，其中对此进行了深入讲解。

At OpenAI's developer day on 11/6 they released an updated way to invoke functions that allows for **parallel function calling**. This new ability allows for a language model to call multiple functions at the same time. For more context you can check out their release blog [here](https://platform.openai.com/docs/guides/function-calling?ref=blog.langchain.com#:~:text=Parallel%20function%20call%20is%20helpful,functions%20in%20a%20single%20response.).

在 11 月 6 日举办的 OpenAI 开发者日（Developer Day）上，官方发布了函数调用功能的升级版，支持 **并行函数调用（parallel function calling）**。这一新能力使语言模型可在单次响应中**同时调用多个函数**。如需更多背景信息，可参阅其官方发布博客：[此处](https://platform.openai.com/docs/guides/function-calling?ref=blog.langchain.com#:~:text=Parallel%20function%20call%20is%20helpful,functions%20in%20a%20single%20response.)。

Parallel function calling makes extraction **significantly easier**. In the rest of this blog post we'll dive into what extraction is, what looked like before with the old way of function calling, and what it looks like now with parallel function calling, why it is **significantly easier** and **more powerful** (although it does come with one downside).

并行函数调用让信息提取任务变得**显著更简单**。在本文后续部分，我们将深入探讨：什么是信息提取？在旧版函数调用方式下提取流程是怎样的？而采用并行函数调用后又发生了哪些变化？为何它不仅**显著更简单**，而且**更加强大**？（尽管该方案也存在一个明显缺点。）

## What is Extraction

## 什么是信息提取（Extraction）？

Extraction is the process of extracting structured data from unstructured data. A concrete example of this is entity extraction. As Sematext [explains](https://sematext.com/blog/entity-extraction-with-spacy/?ref=blog.langchain.com):

信息提取是指从非结构化数据中抽取结构化数据的过程。一个典型实例是**实体提取（entity extraction）**。正如 Sematext [所解释的](https://sematext.com/blog/entity-extraction-with-spacy/?ref=blog.langchain.com)：

> Entity extraction is, in the context of search, the process of figuring out which fields a query should target, as opposed to always hitting all fields. The reason we may want to involve entity extraction in search is to improve precision. For example: how do we tell that, when the user typed in Apple iPhone, the intent was to run company:Apple AND product:iPhone? And not bring back phone stickers in the shape of an apple?

> 在搜索场景中，实体提取指的是判断用户查询应匹配哪些特定字段，而非盲目地检索全部字段。引入实体提取的主要目的在于提升搜索精度。例如：当用户输入 “Apple iPhone” 时，我们如何判定其真实意图是执行 `company:Apple AND product:iPhone` 的组合查询，而非返回一堆苹果形状的手机贴纸？

Crucially, this involves extracting **multiple pieces** of information, potentially of **different types**.

尤为关键的是，这一过程需要同时提取**多个信息片段**，且这些片段往往属于**不同类型**。

## Old Function Calling

## 旧版函数调用

With old function calling you could only get one function call back at a time. This made it so that if you wanted to extract multiple pieces of information at a time you had to do some hacks.

在旧版函数调用中，每次只能返回一个函数调用结果。这意味着，若需同时提取多个信息片段，就必须采用一些变通方法（hack）。

For example, let's assume you wanted to extract the following pieces of information:

例如，假设您希望提取以下信息：

```
class Person(BaseModel):
    name: str
    age: int
```

(Notice that I am representing this as a Pydantic class - this is just a convenience method for constructing the JSON that is eventually passed into the function call parameter)

（请注意，此处我使用 Pydantic 类来表示该结构——这仅是一种便捷方式，用于构造最终传入函数调用参数的 JSON 数据。）

If I just passed that directly as a function to the old OpenAI models, it would only ever return one piece of information! This is obviously not acceptable if I want to extract multiple pieces of information.

如果直接将上述 `Person` 类作为函数传递给旧版 OpenAI 模型，模型将始终仅返回一个信息项！显然，当您需要同时提取多个信息时，这种限制是不可接受的。

In order to extract multiple pieces of information, I would have to do a hack like:

为提取多个信息项，我不得不采用如下变通方式：

```
class Information(BaseModel):
    people: List[Person]
```

This would construct a new object that had as a field a list of `Person` objects. This way, when the OpenAI model constructed the function invocation, it would construct one argument that was a list of people.

这种方式将构建一个新对象，其字段为 `Person` 对象的列表。如此一来，当 OpenAI 模型生成函数调用时，便会生成一个参数——该参数即为人员列表。

This made it possible to allow for extraction of multiple elements of the same type, but it comes at a downside as well. If we wanted to extract both `Person` and a different type of object (say `Location`) we would have to do some more and more complicated typing logic. For example, that would look like:

这虽使得同类型多个元素的提取成为可能，但也带来了副作用：若需同时提取 `Person` 和另一种类型对象（例如 `Location`），我们就不得不设计越来越复杂的类型逻辑。例如，其形式可能如下：

```
class Information(BaseModel):
     info: List[Union[Person, Location]]
```

This would also necessitate some more complicated parsing logic of the language model's responses.

这还将要求对语言模型响应进行更为复杂的解析逻辑。

## Parallel Function Calling

## 并行函数调用

So how does parallel function calling improve this?

那么，并行函数调用是如何改进这一流程的呢？

It removes a LOT of the complexity and hacks we had to do. You no longer have to create that ugly, extraneous `Information` class - you can just pass in `Person` and `Location` directly as functions, and the model will output those as separate function calls. This is an improvement because it means:

它消除了我们此前不得不采用的大量复杂逻辑和临时变通方案。你不再需要创建那个丑陋且多余的 `Information` 类——只需直接将 `Person` 和 `Location` 作为函数传入，模型便会将它们输出为彼此独立的函数调用。这一改进带来的好处包括：

- Less logic needed to create the LLM input (better developer experience)  
  构造大语言模型（LLM）输入所需逻辑更少（开发者体验更佳）

- Less complicated function definitions to pass to the LLM (saves on tokens, less likely to confuse the LLM)  
  传给 LLM 的函数定义更简洁（节省 token，降低 LLM 理解出错的概率）

- Less complicated output the LLM needs to produce (smaller chance the LLM messes up and outputs incorrect json)  
  LLM 所需生成的输出更简单（LLM 出错、输出格式错误 JSON 的可能性更低）

- Less logic needed to parse the LLM output (better developer experience)  
  解析 LLM 输出所需逻辑更少（开发者体验更佳）

We've put all this together into a simple extraction chain - [you can check it out here](https://github.com/langchain-ai/langchain/blob/master/cookbook/extraction_openai_tools.ipynb?ref=blog.langchain.com). The full logic for the chain looks something like:

我们已将上述所有改进整合为一个简洁的信息抽取链（extraction chain）——[你可在此处查看完整示例](https://github.com/langchain-ai/langchain/blob/master/cookbook/extraction_openai_tools.ipynb?ref=blog.langchain.com)。该链的完整逻辑大致如下：

```
# Create a prompt telling the LLM to extract information
prompt = ChatPromptTemplate.from_messages({
        ("system", _EXTRACTION_TEMPLATE),
        ("user", "{input}")
    })

# Convert Pydantic objects to the appropriate schema
tools = [convert_pydantic_to_openai_tool(p) for p in pydantic_schemas]
# Give the model access to these tools
model = llm.bind(tools=tools)
# Create an end to end chain
chain = prompt | model | PydanticToolsParser(tools=pydantic_schemas)
```

```
# 创建提示词，指示 LLM 执行信息抽取任务
prompt = ChatPromptTemplate.from_messages({
        ("system", _EXTRACTION_TEMPLATE),
        ("user", "{input}")
    })

# 将 Pydantic 对象转换为适配 OpenAI 工具调用的 schema
tools = [convert_pydantic_to_openai_tool(p) for p in pydantic_schemas]
# 授予模型访问这些工具的权限
model = llm.bind(tools=tools)
# 构建端到端链式调用
chain = prompt | model | PydanticToolsParser(tools=pydantic_schemas)
```

Using this chain we can now do things like:

借助该链，我们现在可以轻松实现如下操作：

```
# Make sure to use a recent model that supports tools
model = ChatOpenAI(model="gpt-3.5-turbo-1106")
chain = create_extraction_chain_pydantic(Person, model)
chain.invoke({"input": "jane is 2 and bob is 3"})
```

```
# 请确保使用支持工具调用的较新模型
model = ChatOpenAI(model="gpt-3.5-turbo-1106")
chain = create_extraction_chain_pydantic(Person, model)
chain.invoke({"input": "jane is 2 and bob is 3"})
```

And get:

并得到：

```
[Person(name='jane', age=2), Person(name='bob', age=3)]
```

## Conclusion

## 结论

While most people are excited about function calling for creating agents, there is a very real (and very useful) use case around using it to structure outputs from LLMs more generically.  

尽管大多数人对利用函数调用构建智能体（agents）感到兴奋，但其实它还有一个非常实际（且极为有用）的应用场景：更通用地结构化大语言模型（LLM）的输出。

One of these use cases is extraction, but with old function calling you had to do some hacks to get that to work. With parallel function calling it is significantly easier. Try it out!

其中一种应用场景便是信息抽取（extraction）；但在旧版函数调用中，你不得不采用一些变通技巧才能实现。而借助并行函数调用（parallel function calling），这一过程则显著简化。快去试试吧！
&#123;% endraw %}
