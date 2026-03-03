---
title: "UX for Agents, Part 1: Chat"
source: "LangChain Blog"
url: "https://blog.langchain.com/ux-for-agents-part-1-chat-2/"
date: "2024-08-10"
scraped_at: "2026-03-03T07:56:03.275961805+00:00"
language: "en"
translated: false
tags: ["Harrison's Hot Takes"]
---

_At Sequoia’s AI Ascent conference in March, I talked about three limitations for agents: planning, UX, and memory. Check out that talk_ [_here_](https://www.youtube.com/watch?v=pBBe1pk8hf4&ref=blog.langchain.com) _. In this post I will dive deeper into UX for agents. Thanks to Nuno Campos, LangChain founding engineer for many of the original thoughts and analogies here._

_Because there are so many different aspects of UX for agents, this topic will be split into three separate blogs. This is first in the series._

Human-Computer Interaction has been a well-studied area for years. I believe that in the coming years, **Human-Agent** **Interaction** will also become a key area of research.

Agentic systems differ from traditional computer systems of the past due to new challenges stemming from latency, unreliability, and natural language interfaces. As such, I strongly believe that new UI/UX paradigms for interacting with these agentic applications will emerge.

While it’s still early days for agentic systems, I think there are multiple emerging UX paradigms. In this blog we will discuss perhaps the most dominant UX so far: chat.

## Streaming Chat

The “streaming chat” UX is the most dominant UX so far. This quite simply is an agentic system that streams back its thoughts and actions in a chat format — ChatGPT is the most popular example. This interaction pattern seems basic, but is actually quite good for a few reasons.

The main way to “program” an LLM is with natural language. In chat, you interact directly with the LLM through natural language. This means there is little to no barrier between you and the LLM.

💡

In some ways, streaming chat is the “terminal” of early computers.

A terminal (especially in early computers) provides lower-level and more direct access to the underlying OS. But over time, computers have shifted to more UI-based interactions. Streaming chat may be similar - it’s the first way we built to interact with LLMs, and it provides pretty direct access to the underlying LLM. Over time, other UXs may emerge (just as computers became more UI-based) – but low-level access has significant benefits, especially at the start!

One of the reasons that streaming chat is great is that LLMs can take a while to work. Streaming enables the user to understand exactly what is happening under the hood. You can stream back both intermediate actions the LLM takes (both what actions they take, and what the results are) as well as the tokens as the LLM “thinks”.

Another benefit of streaming chat is that LLMs can mess up often. Chat provides a great interface to naturally correct and guide it! We’re very used to having follow-up conversations and discussing things iteratively over chat already.

Still, streaming chat has its drawbacks. First - streaming chat is a relatively new UX, so our existing chat platforms (iMessage, Facebook messenger, Slack, etc) don’t have this mode built in. Second, it’s a bit awkward for longer-running tasks — am I just going to sit there and watch the agent work? Third, streaming chat generally needs to be triggered by a human, which means the human is still very much in the loop.

## Non-streaming Chat

It feels odd to call it “non-streaming” chat, since we would have just called this “chat” up until two years ago — but here we are. Non-streaming chat has many of the same properties of streaming chat - it exposes the LLM pretty directly to the user, and it allows for very natural corrections.

The big difference for non-streaming chat is that responses come back in completed batches, which has its pros and cons. The main con is that you can’t see what’s going on under the hood, leaving you in the dark.

But… is that actually okay?

Linus Lee had some [great thoughts](https://x.com/thesephist/status/1791292522725023907?ref=blog.langchain.com) on “delegation” recently that I really liked. A snippet just to illustrate:

> I intentionally built the interface to be as opaque as possible.

He argues that an opaque interface requires a certain amount of trust, but once established, allows you to _just delegate tasks to the agent_ without micro-managing. This async nature also lends itself to longer-running tasks - which means agents doing more work for you.

Assuming trust is established, this seems good. But it also opens up other issues. For example, how do you handle [“double-texting”](https://langchain-ai.github.io/langgraph/cloud/how-tos/?ref=blog.langchain.com#double-texting) — where the user messages once, the agent starts doing something, and then the user messages again with a different (and sometimes unrelated) thought before the agent finishes its task. With streaming chat, you generally don’t have this issue because the streaming of the agent blocks the user from typing new input.

One of the benefits of the non-streaming chat UX is also much more native to us, which means that it may be easier to integrate into existing workflows. People are used to texting humans - why shouldn’t they easily adapt to texting with an AI?

💡

Another large benefit of non-streaming chat is that it’s often acceptable for the AI to take longer to respond.

This is often due to non-streaming chat being integrated more natively into our existing workflows. We don’t expect our friends to text us back instantaneously - why should we expect an AI to? This makes it easier to interact with more complex agentic systems - these systems often take a while, and if there is the expectation of an instantaneous response that could be frustrating. Non-streaming chat often removes that expectation, making it easier to do more complex things.

It may initially seem that streaming is newer, flashier, and more futuristic than standard chat… but as we trust our agentic systems more, will this reverse?

## Is there more than just chat?

As this is just part one of a three-part series, we believe there are more UXs to consider beyond chat. Still - it is worth reminding that **chat is a very good UX,** and that here’s a reason it’s so widely used.

Benefits of chat:

- Allows user to interact directly with the model
- Allows for easy follow up questions and/or corrections

**_Pros/Cons of streaming vs. non-streaming chat_**

![](images/ux-for-agents-part-1-chat/img_001.png)

### Tags

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)



[![On Agent Frameworks and Agent Observability](images/ux-for-agents-part-1-chat/img_002.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/ux-for-agents-part-1-chat/img_003.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[![In software, the code documents the app. In AI, the traces do.](images/ux-for-agents-part-1-chat/img_004.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/ux-for-agents-part-1-chat/img_005.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[![Reflections on Three Years of Building LangChain](images/ux-for-agents-part-1-chat/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[![Not Another Workflow Builder](images/ux-for-agents-part-1-chat/img_007.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read