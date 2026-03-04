---
title: "OpaquePrompts x LangChain: Enhance the privacy of your LangChain application with just one code change"
source: "LangChain Blog"
url: "https://blog.langchain.com/opaqueprompts-x-langchain-enhance-the-privacy-of-your-langchain-application-with-just-one-code-change/"
date: "2023-09-12"
scraped_at: "2026-03-03T08:46:15.468211954+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

_Editor's Note: This blog post was written in collaboration with the [Opaque](https://opaque.co/?ref=blog.langchain.com) team. As more apps get into production, we've been hearing more teams talk about solutions for data privacy. Opaque's seamless integration with LangChain ensures personal information in your users’ prompts will be hidden from the LLM provider with just a few lines of code._

_编辑注：本文由 [Opaque](https://opaque.co/?ref=blog.langchain.com) 团队与我们协作撰写。随着越来越多的应用进入生产环境，我们持续收到来自各团队关于数据隐私保护方案的讨论。Opaque 与 LangChain 的无缝集成，仅需数行代码，即可确保用户提示（prompt）中的个人信息对大语言模型（LLM）提供商完全不可见。_

We’ve been hearing growing feedback from our users that they want to keep their data private from LLM providers, whether it be OpenAI, Anthropic, Cohere, or others, for a number of reasons:

我们持续收到来自用户的强烈反馈：出于多种原因，他们希望自己的数据对 LLM 提供商（如 OpenAI、Anthropic、Cohere 等）保持私密：

- Concerns about data retention  
- 对数据留存的担忧  
- Concerns about the LLM provider seeing the input data  
- 对 LLM 提供商能够查看输入数据的担忧  
- Concerns about the provider using user inputs to continually train the LLM  
- 对提供商利用用户输入持续训练 LLM 的担忧  
- Concerns about the LLM leaking data the model was trained on  
- 对 LLM 泄露其训练数据的担忧  

The same is true for LLM application builders at companies of all sizes—from enterprise to small startups—across a variety of verticals. One startup we talked to is building a knowledge management solution that summarizes stored documents, but a potential customer, a law firm, doesn’t trust third-party providers with their legal documents. Another is building an application to generate targeted advertisements based off user data, but must strictly control how personal user information is shared and used by third-party providers. A large bank wants to automate risk assessment, which, in its manual form, requires meticulous analysis of sensitive documents whose contents cannot be shared with third-party providers in its plaintext form.

上述关切同样适用于各行各业——从大型企业到小型初创公司——的所有 LLM 应用构建者。我们曾与一家初创公司交流，该公司正在开发一款知识管理解决方案，用于摘要归档文档；但其潜在客户（一家律师事务所）拒绝将法律文件交由第三方提供商处理。另一家公司正构建一款基于用户数据生成精准广告的应用，但必须严格管控个人用户信息如何被第三方提供商共享与使用。一家大型银行希望实现风险评估自动化——而人工评估过程本身即需对高度敏感的文档进行细致分析，这些文档的明文内容绝不能提供给任何第三方提供商。

All these use cases and more have one common theme: an LLM application developer wants to leverage an LLM to operate on sensitive data, but cannot do so because of concerns about or restrictions on the LLM provider’s ability to see, process, and store the sensitive data. This is where OpaquePrompts comes in.

所有这些用例（以及更多类似场景）都指向一个共同主题：LLM 应用开发者希望借助大语言模型处理敏感数据，却因担忧或受限于 LLM 提供商对敏感数据的可见性、处理能力及存储权限而无法实现。这正是 **OpaquePrompts** 的用武之地。

# An introduction to OpaquePrompts

# OpaquePrompts 简介

OpaquePrompts serves as a privacy layer around your LLM of choice. With OpaquePrompts, you can:

OpaquePrompts 为您的首选大语言模型（LLM）提供一层隐私保护层。借助 OpaquePrompts，您可实现以下功能：

- **Automatically identify sensitive tokens** in your prompts with natural language processing (NLP)-based machine learning  
- **自动识别提示中的敏感词元（tokens）**：依托基于自然语言处理（NLP）的机器学习模型  
- **Pre-process LLM inputs to hide sensitive inputs** in your prompts from LLM providers via a sanitization mechanism  
- **预处理 LLM 输入**：通过净化（sanitization）机制，向 LLM 提供商隐藏提示中包含的敏感信息  
- For example, in the prompt, every instance of the name `John Smith` will be deterministically replaced with `PERSON_1`.  
- 例如，在提示中，所有出现的姓名 `John Smith` 将被确定性地替换为 `PERSON_1`。  
- **Post-process LLM responses** to replace all sanitized instances with the original sensitive information  
- **后处理 LLM 响应**：将所有经净化处理的占位符还原为原始敏感信息  
- For example, in the LLM response, all instances of `PERSON_1` will be replaced with `John Smith`.  
- 例如，在 LLM 的响应中，所有 `PERSON_1` 将被替换回 `John Smith`。  
- **Leverage the power of [confidential computing](https://en.wikipedia.org/wiki/Confidential_computing?ref=blog.langchain.com)** to ensure that not even the OpaquePrompts service sees the underlying prompt  
- **利用 [机密计算（confidential computing）](https://en.wikipedia.org/wiki/Confidential_computing?ref=blog.langchain.com) 技术**，确保连 OpaquePrompts 服务自身也无法访问原始提示内容  
- OpaquePrompts runs in an [attestable](https://www.redhat.com/en/blog/attestation-confidential-computing?ref=blog.langchain.com) [trusted execution environment](https://en.wikipedia.org/wiki/Trusted_execution_environment?ref=blog.langchain.com), meaning that you can cryptographically verify that not even Opaque can see any input to OpaquePrompts.  
- OpaquePrompts 运行于一个[可验证（attestable）](https://www.redhat.com/en/blog/attestation-confidential-computing?ref=blog.langchain.com) 的[可信执行环境（TEE）](https://en.wikipedia.org/wiki/Trusted_execution_environment?ref=blog.langchain.com) 中，这意味着您可通过密码学手段验证：连 Opaque 公司自身都无法获知任何输入至 OpaquePrompts 的数据。  
- More on OpaquePrompts architecture and security guarantees can be found in the [documentation](https://promptguard.readthedocs.io/en/latest/?ref=blog.langchain.com).  
- 关于 OpaquePrompts 的架构设计与安全保证的更多细节，请参阅[官方文档](https://promptguard.readthedocs.io/en/latest/?ref=blog.langchain.com)。  
- **Make your application privacy-preserving** by modifying just one line of code in your LangChain application  
- **仅需修改 LangChain 应用中的一行代码**，即可使您的应用具备隐私保护能力  
- See an example [here](https://github.com/opaque-systems/opaqueprompts-chat-server/blob/dev/python-package/src/opchatserver/server.py?ref=blog.langchain.com).  
- 示例代码请参见[此处](https://github.com/opaque-systems/opaqueprompts-chat-server/blob/dev/python-package/src/opchatserver/server.py?ref=blog.langchain.com)。

An application built with OpaquePrompts works as follows:

采用 OpaquePrompts 构建的应用工作流程如下：

1. The OpaquePrompts service takes in a constructed prompt.  
1. OpaquePrompts 服务接收已构造完成的提示（prompt）。  
2. Using a state-of-the-art model, OpaquePrompts identifies sensitive information in the prompt.  
2. 利用前沿模型，OpaquePrompts 识别提示中包含的敏感信息。  
3. OpaquePrompts sanitizes the prompt by encrypting all identified personal information before returning the sanitized prompt to the LLM application.  
3. OpaquePrompts 对提示进行净化处理：在将净化后的提示返回给 LLM 应用前，对所有已识别的个人信息进行加密。  
4. The LLM application sends the sanitized prompt to its LLM provider of choice.  
4. LLM 应用将净化后的提示发送至其选定的 LLM 提供商。  
5. The LLM application receives a response from the LLM provider, which contains the post-sanitization identifiers.  
5. LLM 应用接收来自 LLM 提供商的响应，该响应中包含净化处理后生成的标识符（如 `PERSON_1`）。  
6. The LLM application sends the response to OpaquePrompts, which de-sanitizes the response by decrypting previously encrypted personal information.  
6. LLM 应用将响应发送至 OpaquePrompts，后者通过解密先前加密的个人信息，完成响应的“去净化”（de-sanitization）处理。  
7. The LLM application returns the de-sanitized response to the user. From the user’s perspective, the response appears as if the original prompt were sent directly to the LLM.  
7. LLM 应用将去净化后的响应返回给用户。对用户而言，该响应效果等同于原始提示被直接发送给了 LLM。

Using GIFs, we compare LLM application workflows with and without OpaquePrompts. Without OpaquePrompts, the prompt goes directly from LLM application to the model provider, all in the clear.

使用 GIF 动图，我们对比了启用与未启用 OpaquePrompts 时的大语言模型（LLM）应用工作流。在未启用 OpaquePrompts 的情况下，提示词（prompt）直接从 LLM 应用发送至模型提供商，全程明文传输。

![](images/opaqueprompts-x-langchain-enhance-the-privacy-of-your-langchain-application-with/img_001.gif)

With OpaquePrompts, the prompt first gets securely sanitized by the OpaquePrompts service (and the service doesn’t see the contents of the prompt) before making its way to the LLM provider for a response.

启用 OpaquePrompts 后，提示词首先由 OpaquePrompts 服务进行安全脱敏处理（该服务无法获知提示词的实际内容），随后再将脱敏后的提示词发送至大语言模型提供商以获取响应。

![](images/opaqueprompts-x-langchain-enhance-the-privacy-of-your-langchain-application-with/img_002.gif)

# Modifying a chatbot built with LangChain to incorporate OpaquePrompts

# 修改基于 LangChain 构建的聊天机器人，集成 OpaquePrompts

Below, we walk through how we modified an existing GPT-based chat application built with LangChain to hide sensitive information from prompts sent to OpenAI.

接下来，我们将逐步介绍：如何修改一个现成的、基于 LangChain 构建的 GPT 聊天应用，使其在向 OpenAI 发送提示词时隐藏敏感信息。

The server-side with a `/chat` endpoint of a vanilla chat application looks something like the following.

一个标准聊天应用的服务端（含 `/chat` 接口）大致如下所示。

```python

# Full source code can be found here: <https://github.com/opaque-systems/opaqueprompts-chat-server>

class ChatRequest(BaseModel):
    history: Optional[list[str]]
    prompt: str

```python
class ChatResponse(BaseModel):
    response: str

class ChatResponse(BaseModel):
    response: str

async def chat(
    chat_request: ChatRequest,
) -> ChatResponse:
	  """
		Defines an endpoint that takes in a prompt and sends it to
		GPT

		Parameters
		----------
		chat_request : ChatRequest
        The request body, which contains the history of the conversation
        and the prompt to be completed.

		Returns
    -------
    ChatResponse
        The response body, which contains GPT's response to the prompt.
    """
async def chat(
    chat_request: ChatRequest,
) -> ChatResponse:
    """
    定义一个端点，接收用户输入的提示（prompt）并将其发送给 GPT。

    参数
    ----------
    chat_request : ChatRequest
        请求体，其中包含对话历史记录以及待补全的提示（prompt）。

    返回
    -------
    ChatResponse
        响应体，其中包含 GPT 对该提示（prompt）的回复。
    """

    # Actual template and build_memory logic are omitted and can be found in the
		# repo linked below
    prompt = PromptTemplate.from_template(CHAT_TEMPLATE)
    memory = build_memory(chat_request.history)

    chain = LLMChain(
        prompt=prompt,
        llm=OpenAI(),
        memory=memory,
    )
    return ChatResponse(response=chain.run(chat_request.prompt))
```

```python
    # 实际的模板（template）和 build_memory 逻辑已被省略，完整实现可参见下方链接的代码仓库。
    prompt = PromptTemplate.from_template(CHAT_TEMPLATE)
    memory = build_memory(chat_request.history)

    chain = LLMChain(
        prompt=prompt,
        llm=OpenAI(),
        memory=memory,
    )
    return ChatResponse(response=chain.run(chat_request.prompt))
```

To use OpaquePrompts, once we retrieve an API token from the OpaquePrompts website, all we have to do is wrap the `llm` passed into `LLMChain` with `OpaquePrompts`:

使用 OpaquePrompts 时，只需先从 OpaquePrompts 网站获取一个 API token，然后将传入 `LLMChain` 的 `llm` 实例用 `OpaquePrompts` 封装即可：

```python
chain = LLMChain(
	prompt=prompt,
	# llm=OpenAI(),
	llm=OpaquePrompts(base_llm=OpenAI()),
	memory=memory,
)
```

```python
chain = LLMChain(
    prompt=prompt,
    # llm=OpenAI(),
    llm=OpaquePrompts(base_llm=OpenAI()),
    memory=memory,
)
```

You can play with a working implementation of a chatbot built with LangChain and OpaquePrompts on the [OpaquePrompts website](https://opaqueprompts.opaque.co/?ref=blog.langchain.com), and find the full source code from which we derived the example above on [GitHub](https://github.com/opaque-systems/opaqueprompts-chat-server?ref=blog.langchain.com). Note that the source code also includes logic for authentication and for displaying intermediate (i.e., the sanitized prompt and sanitized response) steps.

您可在 [OpaquePrompts 官网](https://opaqueprompts.opaque.co/?ref=blog.langchain.com) 体验一个基于 LangChain 和 OpaquePrompts 构建的、可实际运行的聊天机器人；上述示例的完整源代码则托管在 [GitHub](https://github.com/opaque-systems/opaqueprompts-chat-server?ref=blog.langchain.com) 上。请注意，该源代码还包含了身份认证逻辑，以及用于展示中间步骤（即：经脱敏处理后的提示 prompt 和响应 response）的相关实现。

# Conclusion

# 结论

With OpaquePrompts, you can bootstrap your existing LangChain-based application to add privacy for your users. With your OpaquePrompts + LangChain application, any personal information in your users’ prompts will be hidden from the LLM provider, ensuring that you, as the LLM application developer, do not have to worry about the provider’s data retention or processing policies. Take a look at the [documentation](https://python.langchain.com/docs/integrations/llms/opaqueprompts?ref=blog.langchain.com) or [try out OpaquePrompts Chat](https://opaqueprompts.opaque.co/?ref=blog.langchain.com) today!

借助 OpaquePrompts，您可以快速为现有基于 LangChain 的应用添加用户隐私保护能力。在您的 OpaquePrompts + LangChain 应用中，用户提示（prompt）中所含的任何个人信息都将对大语言模型（LLM）服务提供商完全隐藏——这意味着作为 LLM 应用开发者，您无需再担忧服务商的数据留存或数据处理政策。立即查阅 [官方文档](https://python.langchain.com/docs/integrations/llms/opaqueprompts?ref=blog.langchain.com)，或直接 [体验 OpaquePrompts 聊天功能](https://opaqueprompts.opaque.co/?ref=blog.langchain.com) 吧！
&#123;% endraw %}
