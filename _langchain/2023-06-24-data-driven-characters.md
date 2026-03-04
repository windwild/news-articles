---
render_with_liquid: false
title: "Data-Driven Characters"
source: "LangChain Blog"
url: "https://blog.langchain.com/data-driven-characters/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:48:41.664703050+00:00"
language: "en-zh"
translated: true
description: "Data-driven-characters is a repo for creating, debugging, and interacting your own chatbots conditioned on your own story corpora."
---
render_with_liquid: false
render_with_liquid: false

**Editor's Note: the following is a blog post by Michael Chang. We were lucky enough to have Michael spend ~2 months with us before he started at DeepMind. He took on some of the most open-ended problems that faced us — starting with a lot of work in agent simulation, and now this deep dive into memory.**

**编者按：以下为 Michael Chang 撰写的一篇博客文章。我们非常幸运地邀请到 Michael 在加入 DeepMind 前，与我们共同工作了约两个月。他接手了我们所面临的若干最具开放性的问题——最初聚焦于智能体（agent）仿真，如今则深入探索记忆（memory）这一方向。**

_Generate character chatbots from existing corpora with_ [LangChain](https://docs.langchain.com/docs/?ref=blog.langchain.com).

_借助 [LangChain](https://docs.langchain.com/docs/?ref=blog.langchain.com) 从现有语料库中生成角色聊天机器人。_

[Michael Chang](https://twitter.com/mmmbchang?ref=blog.langchain.com)

[Michael Chang](https://twitter.com/mmmbchang?ref=blog.langchain.com)

## tldr: a [repo](https://github.com/mbchang/data-driven-characters?ref=blog.langchain.com) for grounding characters in corpora

## 简而言之：一个用于将角色“扎根”于语料库的 [代码仓库](https://github.com/mbchang/data-driven-characters?ref=blog.langchain.com)

1. Upload a corpus  
   1. 上传语料库  
2. Name a character  
   2. 为角色命名  
3. Enjoy  
   3. 开始体验  

[`data-driven-characters`](https://github.com/mbchang/data-driven-characters?ref=blog.langchain.com) is a repo for creating and interacting with character chatbots. This can be used to automatically create character definitions for existing platforms like [character.ai](https://beta.character.ai/?ref=blog.langchain.com). It also explores creating chatbots from scratch with different types of memory management that can better ground the character chatbots in real backstories.

[`data-driven-characters`](https://github.com/mbchang/data-driven-characters?ref=blog.langchain.com) 是一个用于构建和交互式使用角色聊天机器人的开源代码仓库。它可用于为现有平台（例如 [character.ai](https://beta.character.ai/?ref=blog.langchain.com)）自动生成角色定义；同时也探索了从零开始构建聊天机器人的方式，并引入多种记忆管理机制，从而让角色聊天机器人更扎实地扎根于真实、连贯的背景故事之中。

### Features

### 功能特性

This repo provides **three ways** to interact with your data-driven characters:

该代码仓库提供了 **三种方式** 与您的数据驱动型角色进行交互：

1. Export to character.ai  
   1. 导出至 character.ai  
2. Debug locally in the command line or with a Streamlit interface  
   2. 在本地命令行或通过 Streamlit 界面进行调试  
3. Host a self-contained [Streamlit app](https://mbchang-data-driven-characters-app-273bzg.streamlit.app/?ref=blog.langchain.com) in the browser  
   3. 在浏览器中托管一个独立运行的 [Streamlit 应用](https://mbchang-data-driven-characters-app-273bzg.streamlit.app/?ref=blog.langchain.com)  

[Character.ai does not give users control over how memory is managed in their character chatbots](https://book.character.ai/character-book/challenges-and-limitations?ref=blog.langchain.com#memory), nor does it have an [API](https://beta.character.ai/faq?ref=blog.langchain.com). In contrast, `data-driven-characters` gives you tools for creating character chatbots on your own, with **various kinds of memory management that you control**, including summarization and retrieval.

[Character.ai 并未向用户提供对其角色聊天机器人中记忆管理方式的控制权](https://book.character.ai/character-book/challenges-and-limitations?ref=blog.langchain.com#memory)，也尚未开放 [API 接口](https://beta.character.ai/faq?ref=blog.langchain.com)。相比之下，`data-driven-characters` 赋予您自主构建角色聊天机器人的能力，并提供 **您可完全掌控的多种记忆管理机制**，包括摘要生成（summarization）与信息检索（retrieval）。

## Why data-driven-characters?

## 为何要构建“数据驱动型角色”？

> Through the miracle of the printed page, I can at least read what Aristotle wrote without an intermediary ... I can go directly to the source material. And that is, of course, the foundation upon which our western civilization is built. **But I can't ask Aristotle a question.**... And so my hope is that in our lifetimes, we can make **a tool of a new kind, of an interactive kind**. My hope is someday, when the next Aristotle is alive, we can capture the underlying worldview of that Aristotle, in a computer, and someday some students will be able to **not only read the words Aristotle wrote, but ask Aristotle a question and get an answer**." ( [video](https://www.youtube.com/watch?v=wWa2H5Wt8co&ref=blog.langchain.com))

> 借助印刷文字这一奇迹，我至少可以无需中介、直接阅读亚里士多德所写的内容……我能直抵原始文献。而这，当然正是我们西方文明赖以建立的基石。**但我却无法向亚里士多德本人提问。**……因此，我希望在我们有生之年，能够创造出一种**全新类型的工具——一种具备交互能力的工具**。我的愿望是：有朝一日，当下一代亚里士多德尚在世时，我们能将其底层世界观完整地捕获并存入计算机；而未来某天，学生们将不仅能阅读亚里士多德写下的文字，更能**向“亚里士多德”提问，并获得他的回答**。”（[视频](https://www.youtube.com/watch?v=wWa2H5Wt8co&ref=blog.langchain.com)）

\- Steve Jobs, [Lunds University, Sweden, 1985](https://muse.ai/v/LsCHjUA-Steve-Jobs-presentation-at-Lunds-University-in-Sweden-1985?ref=blog.langchain.com)

\- 史蒂夫·乔布斯，《1985年瑞典隆德大学演讲》（[视频链接](https://muse.ai/v/LsCHjUA-Steve-Jobs-presentation-at-Lunds-University-in-Sweden-1985?ref=blog.langchain.com)）

Books are [dead](https://www.youtube.com/watch?v=ZfytHvgHybA&ref=blog.langchain.com). Characters are _alive_.

书籍已然[消亡](https://www.youtube.com/watch?v=ZfytHvgHybA&ref=blog.langchain.com)；角色却是_鲜活的_。

The key breakthrough of large language models is enabling a new way to interact with information: they make it possible to turn static text corpora into interactive experiences.

大语言模型（LLM）的关键突破，在于开创了一种与信息交互的全新方式：它使我们将静态文本语料库转化为交互式体验成为可能。

And if there is one use case of large language models (LLM) that people love, it is to bring characters, both real and fictional, to life. This may explain why [character.ai](https://beta.character.ai/?ref=blog.langchain.com) has about [3x more user engagement](https://www.similarweb.com/blog/insights/ai-news/character-ai-engagement/?ref=blog.langchain.com) than [ChatGPT](https://chat.openai.com/?ref=blog.langchain.com).

如果说大语言模型（LLM）有一项最受用户喜爱的应用场景，那便是让真实或虚构的角色“活”起来。这或许正解释了为何 [character.ai](https://beta.character.ai/?ref=blog.langchain.com) 的用户参与度约为 [ChatGPT](https://chat.openai.com/?ref=blog.langchain.com) 的**三倍**（[数据来源](https://www.similarweb.com/blog/insights/ai-news/character-ai-engagement/?ref=blog.langchain.com)）。

However, some limitations with character.ai are that:

然而，character.ai 存在一些局限性，包括：

1. it is tedious to manually specify character definitions  
   1. 手动定义角色设定十分繁琐；  

2. users have no control over how memory is managed in their character chatbots.  
   2. 用户对其角色聊天机器人的记忆管理机制完全缺乏控制权。

The main way that people interact with characters via LLMs is to ask the LLM to impersonate characters. This works only when the character was present in the LLM's pre-training data. For example, ChatGPT can impersonate Socrates:

目前，人们借助大语言模型与角色互动的主要方式，是要求模型“扮演”某个角色。但该方法仅在该角色曾出现在模型预训练数据中时才有效。例如，ChatGPT 能够成功扮演苏格拉底：

![](images/data-driven-characters/img_001.jpg)ChatGPT can impersonate Socrates, likely because Plato's works were in its training data.

![](images/data-driven-characters/img_001.jpg)ChatGPT 能够扮演苏格拉底，很可能是因为柏拉图的著作已包含在其训练数据之中。

But what if you want to chat with a character from a movie that came out last year? Consider chatting with the main character, Evelyn, from [Everything Everywhere All At Once](https://en.wikipedia.org/wiki/Everything_Everywhere_All_at_Once?ref=blog.langchain.com). Neither [ChatGPT-3.5](https://chat.openai.com/share/1b4efa66-3c62-4df3-bf53-2d9ee9f2ec29?ref=blog.langchain.com) and [ChatGPT-4](https://chat.openai.com/share/f8ae1a6f-010c-4921-8131-715d436844b7?ref=blog.langchain.com) can do it. Search-powered LLMs that can access current information often do not do much better:

但如果想与去年上映的电影中的某个角色聊天，该怎么办？不妨试试与电影《瞬息全宇宙》（[Everything Everywhere All At Once](https://en.wikipedia.org/wiki/Everything_Everywhere_All_at_Once?ref=blog.langchain.com)）的主角伊芙琳（Evelyn）展开对话。无论是 [ChatGPT-3.5](https://chat.openai.com/share/1b4efa66-3c62-4df3-bf53-2d9ee9f2ec29?ref=blog.langchain.com) 还是 [ChatGPT-4](https://chat.openai.com/share/f8ae1a6f-010c-4921-8131-715d436844b7?ref=blog.langchain.com)，都无法胜任这项任务。而那些能实时检索最新信息的“搜索增强型大语言模型”（search-powered LLMs），表现也往往好不到哪里去：

![](images/data-driven-characters/img_002.jpg)

![](images/data-driven-characters/img_003.jpg)

![](images/data-driven-characters/img_004.jpg)

[Metaphor](https://metaphor.systems/search?q=Impersonate+Evelyn+from+%22Everything+Everywhere+All+At+Once%22%0A%0AWhat+is+your+superpower%3F&filters=%7B%22domainFilterType%22%3A%22include%22%2C%22timeFilterOption%22%3A%22any_time%22%7D&autopromptString=If+you+want+to+impersonate+Evelyn+from+%22Everything+Everywhere+All+At+Once%22%2C+here%27s+a+helpful+tip%3A+What+is+your+superpower%3F&ref=blog.langchain.com) 和 [Vectara](https://asknews.demo.vectara.com/?query=Impersonate+Evelyn+from+%22Everything+Everywhere+All+At+Once%22++What+is+your+superpower%3F&filter=&ref=blog.langchain.com) 并非为对话场景而设计；[Inflection 的 Pi](https://heypi.com/talk?ref=blog.langchain.com) 虽是一款对话式聊天机器人，却无法扮演特定角色。

[Metaphor](https://metaphor.systems/search?q=Impersonate+Evelyn+from+%22Everything+Everywhere+All+At+Once%22%0A%0AWhat+is+your+superpower%3F&filters=%7B%22domainFilterType%22%3A%22include%22%2C%22timeFilterOption%22%3A%22any_time%22%7D&autopromptString=If+you+want+to+impersonate+Evelyn+from+%22Everything+Everywhere+All+At+Once%22%2C+here%27s+a+helpful+tip%3A+What+is+your+superpower%3F&ref=blog.langchain.com) 和 [Vectara](https://asknews.demo.vectara.com/?query=Impersonate+Evelyn+from+%22Everything+Everywhere+All+At+Once%22++What+is+your+superpower%3F&filter=&ref=blog.langchain.com) 并非专为对话交互而构建；[Inflection 公司推出的 Pi](https://heypi.com/talk?ref=blog.langchain.com) 是一款面向对话的聊天机器人，但并不具备角色扮演能力。

![](images/data-driven-characters/img_005.jpg)

![](images/data-driven-characters/img_006.jpg)

![](images/data-driven-characters/img_007.jpg)

[Bard](https://bard.google.com/?ref=blog.langchain.com)、[Perplexity](https://www.perplexity.ai/search/8a3fa2cb-d77d-462a-82b5-a5c65951824b?s=u&ref=blog.langchain.com) 与 [You.com](https://you.com/search?q=Impersonate+Evelyn+from+%22Everything+Everywhere+All+At+Once%22%0A%0AWhat+is+your+superpower%3F&fromSearchBar=true&tbm=youchat&cid=c2_28817153-6417-405c-a3b9-b902786ba0a9&ref=blog.langchain.com) 均能在首条回复中恰当地扮演电影角色，但在第二条回复中便“破功”——脱离角色设定。这是因为它们的设计目标是信息检索，而非持续的角色化对话。

[Bard](https://bard.google.com/?ref=blog.langchain.com)、[Perplexity](https://www.perplexity.ai/search/8a3fa2cb-d77d-462a-82b5-a5c65951824b?s=u&ref=blog.langchain.com) 和 [You.com](https://you.com/search?q=Impersonate+Evelyn+from+%22Everything+Everywhere+All+At+Once%22%0A%0AWhat+is+your+superpower%3F&fromSearchBar=true&tbm=youchat&cid=c2_28817153-6417-405c-a3b9-b902786ba0a9&ref=blog.langchain.com) 都能在第一条消息中较为准确地扮演电影角色，但在第二条消息中便“掉线”，脱离角色设定——因为它们本质上是为信息检索而设计，而非用于沉浸式角色对话。

We also see apps like [Paul Graham GPT](https://paul-graham-gpt.vercel.app/?ref=blog.langchain.com), [Lex GPT](https://lex-gpt.fly.dev/?ref=blog.langchain.com), and [Wait But Why GPT](https://wait-but-why-gpt.vercel.app/?ref=blog.langchain.com) being built to give users a more direct conversational experience with the content of a real character. These apps retrieve from real existing essays and transcripts from the characters they depict, thereby providing a grounding to the characters that character.ai does not provide. However, these apps do not directly impersonate characters, but rather only describe their content. Furthermore, these apps limit the user to asking questions about the content of only specific characters.

我们还看到一些应用正在兴起，例如 [Paul Graham GPT](https://paul-graham-gpt.vercel.app/?ref=blog.langchain.com)、[Lex GPT](https://lex-gpt.fly.dev/?ref=blog.langchain.com) 和 [Wait But Why GPT](https://wait-but-why-gpt.vercel.app/?ref=blog.langchain.com)，旨在为用户提供与真实人物思想内容更直接、更具互动性的对话体验。这些应用从所刻画人物已公开的真实文章与访谈实录中检索信息，从而赋予角色以扎实的内容根基——而这恰恰是 character.ai 所缺乏的。然而，这些应用并不真正“扮演”角色，而仅是对其观点内容进行转述与总结；此外，用户只能就特定人物的内容发起提问，交互范围受到严格限制。

`data-driven-characters` generalizes this customized character chat experience to allow the user to **chat with anyone** **based on any corpus**.

`data-driven-characters` 将这种定制化角色聊天体验泛化，使用户能够基于**任意语料库**与**任何人**进行对话。

## How it works

## 其工作原理

Let's revisit the goal of chatting with Evelyn from Everything Everywhere All At Once. `data-driven-characters` provides tools to easily spin up your own Evelyn chatbot from [the movie's transcript](https://scrapsfromtheloft.com/movies/everything-everywhere-all-at-once-transcript/?ref=blog.langchain.com).

让我们再次回顾目标：与《瞬息全宇宙》（Everything Everywhere All At Once）中的伊芙琳（Evelyn）进行对话。`data-driven-characters` 提供了便捷的工具，助你轻松基于[该电影的剧本全文](https://scrapsfromtheloft.com/movies/everything-everywhere-all-at-once-transcript/?ref=blog.langchain.com)构建专属的伊芙琳聊天机器人。

### Create a character definition to export to character.ai

### 创建可导出至 character.ai 的角色定义

The most basic way to use `data-driven-characters` is as a tool to automatically generate a character.ai character definition. Instead of manually crafting character definitions, `data-driven-characters` gives you an scalable, data-driven approach. This can be done in 11 lines of code:

使用 `data-driven-characters` 最基础的方式，是将其作为自动生成 character.ai 角色定义的工具。相比手动编写角色定义，`data-driven-characters` 提供了一种可扩展、以数据为驱动的方法。整个过程仅需 11 行代码：

```python
from dataclasses import asdict
import json
from data_driven_characters.character import generate_character_definition
from data_driven_characters.corpus import generate_corpus_summaries, load_docs

CORPUS = 'data/everything_everywhere_all_at_once.txt'
CHARACTER_NAME = "Evelyn"

docs = load_docs(corpus_path=CORPUS, chunk_size=2048, chunk_overlap=64)
character_definition = generate_character_definition(
	name=CHARACTER_NAME,
	corpus_summaries=generate_corpus_summaries(docs=docs))

print(json.dumps(asdict(character_definition), indent=4))
```

‌Here `corpus_summaries` refers to a summarized version of the transcript. This generates the following character definition:

此处 `corpus_summaries` 指的是对原始剧本文本所生成的摘要版本。上述代码将生成如下角色定义：

```json
{
"name": "Evelyn",
"short_description": "I'm Evelyn, a Verse Jumper exploring universes.",
"short_description": "我是伊芙琳，一名穿梭于多重宇宙之间的“宇宙跃迁者”。",
"long_description": "I'm Evelyn, able to Verse Jump, linking my consciousness to other versions of me in different universes. This unique ability has led to strange events, like becoming a Kung Fu master and confessing love. Verse Jumping cracks my mind, risking my grip on reality. I'm in a group saving the multiverse from a great evil, Jobu Tupaki. Amidst chaos, I've learned the value of kindness and embracing life's messiness.",
"long_description": "我是伊芙琳，拥有‘宇宙跃迁’能力——可将我的意识连接至其他宇宙中不同版本的自己。这一独特能力引发了一系列奇异事件：我曾成为功夫大师，也曾向他人倾诉爱意。但‘宇宙跃迁’也在撕裂我的心智，令我对现实的把握岌岌可危。如今，我正与一支小队并肩作战，共同拯救多元宇宙，抵御大反派‘乔布·图帕基’（Jobu Tupaki）的威胁。在混乱纷繁的冒险中，我逐渐领悟了善意的可贵，也学会了欣然拥抱生活本有的杂乱与不完美。",
"greeting": "Hey there, nice to meet you! I'm Evelyn, and I'm always up for an adventure. Let's see what we can discover together!",
"greeting": "你好呀，很高兴认识你！我是伊芙琳，永远对冒险充满期待。让我们一起看看，能发现些什么吧！"
}
```

You can then [export this character definition to character.ai](https://beta.character.ai/character/create??ref=blog.langchain.com). In fact, we have already done so: **you can chat with this rendition of Evelyn on character.ai [here](https://c.ai/c/be5UgphMggDyaf504SSdAdrlV2LHyEgFQZDA5WuQfgw?ref=blog.langchain.com).**

你还可以将该角色定义[导出至 character.ai](https://beta.character.ai/character/create??ref=blog.langchain.com)。事实上，我们已完成此项操作：**你可点击此处，在 character.ai 上与这个版本的伊芙琳畅聊：[链接](https://c.ai/c/be5UgphMggDyaf504SSdAdrlV2LHyEgFQZDA5WuQfgw?ref=blog.langchain.com)。**

### Running your own chatbot

### 运行你自己的聊天机器人

The benefit of creating characters on character.ai is that character.ai hosts an entire ecosystem of character chatbots that you can interact with for free. The flip side is that ~600 characters of text does not provide enough information to ground the character chatbot in its backstory - it would be nice if the Evelyn chatbot could reference information from the movie transcript itself. Character.ai [allows you to add 32,000 characters of additional context](https://book.character.ai/character-book/character-attributes/definition?ref=blog.langchain.com), but recommends the context be via a set of example dialogues, which is cumbersome to curate. Even if we do just copy and paste the movie transcript as addition context, how this context is used or managed is out of the user's control. If the character starts hallucinating in a way that deviates away from its backstory, **character.ai provides you no diagnostic tools to debug this behavior**.

在 character.ai 上创建角色的一大优势在于：它托管了一个完整的角色聊天机器人生态系统，用户可免费与其中任意角色互动。但其另一面是——约 600 字符的角色简介文本，远不足以支撑聊天机器人对其背景故事的准确理解；理想情况下，伊芙琳聊天机器人应能直接援引电影剧本中的具体信息。虽然 character.ai [允许额外添加最多 32,000 字符的上下文](https://book.character.ai/character-book/character-attributes/definition?ref=blog.langchain.com)，但它建议以若干组示例对话的形式提供，而这类对话集的整理工作十分繁琐。即便我们直接将整部电影剧本复制粘贴为补充上下文，其具体如何被调用、如何被模型处理，也完全超出了用户的掌控范围。一旦角色开始“幻觉”（hallucination），即输出明显偏离其设定背景的内容，**character.ai 并未提供任何诊断工具供你排查和调试此类行为**。

With `data-driven-characters`, you can easily create, debug, and run your own chatbots conditioned on your own corpora, thanks to the abstractions provided by [LangChain](https://docs.langchain.com/docs/?ref=blog.langchain.com). The repo provides ways for you to chat with it either with a command line interface or with a Streamlit interface. As you can see below, our Evelyn chatbot **stays in character** and **grounds its dialogue in real events** from the transcript.

借助 `data-driven-characters`，你可轻松创建、调试并运行基于自有语料库定制的聊天机器人——这得益于 [LangChain](https://docs.langchain.com/docs/?ref=blog.langchain.com) 提供的一系列抽象封装。该项目支持通过命令行界面（CLI）或 Streamlit 网页界面与聊天机器人交互。如下图所示，我们的伊芙琳聊天机器人不仅**始终恪守角色设定**，更能**将对话内容牢牢锚定于剧本中的真实事件**。

![](images/data-driven-characters/img_008.jpg)The Streamlit app for `data-driven-characters`. On the left panel, the user uploads a corpus, chooses a character name, and specifies how the character should ground its persona in the corpus. In this case, the character retrieves from a summarized transcript computed with LangChain's ["refine" summarization chain](https://python.langchain.com/en/latest/modules/chains/index_examples/summarize.html?ref=blog.langchain.com#the-refine-chain). The middle panel shows the chat interface. The right panel shows the debugging console, which is normally not visible in the actual app but can be viewed in the terminal if you run the app locally. **The Evelyn chatbot references the fact that she faced repossession of her laundromat (snippet \[7\] in the when conversing with the user.**

![](images/data-driven-characters/img_008.jpg)`data-driven-characters` 的 Streamlit 应用界面。左侧面板中，用户上传语料库、指定角色名称，并设定角色如何基于该语料库构建自身人设；本例中，角色所依据的是经 LangChain 的[“精炼式”摘要链（refine summarization chain）](https://python.langchain.com/en/latest/modules/chains/index_examples/summarize.html?ref=blog.langchain.com#the-refine-chain)生成的剧本摘要。中间面板为聊天交互界面；右侧面板为调试控制台——该控制台在实际网页应用中默认不可见，但若你在本地运行该应用，则可在终端中查看其输出。**伊芙琳聊天机器人在与用户对话时，明确提到了她曾面临自家洗衣店遭强制收回（foreclosure）的困境（对应剧本摘要中的片段［7］）。**

Contrast our custom Evelyn chatbot with [the one that we exported to character.ai above](https://c.ai/c/be5UgphMggDyaf504SSdAdrlV2LHyEgFQZDA5WuQfgw?ref=blog.langchain.com), whose interaction is shown below. The character.ai Evelyn appears to simply latch onto the local concepts present in the conversation, without bringing new information from its backstory.

请将我们自定义的伊芙琳聊天机器人，与上文[已导出至 character.ai 的那个版本](https://c.ai/c/be5UgphMggDyaf504SSdAdrlV2LHyEgFQZDA5WuQfgw?ref=blog.langchain.com)作对比——后者交互效果如下图所示。character.ai 版本的伊芙琳似乎仅被动响应当前对话中出现的局部概念，而无法主动调用其背景故事中的新信息。

![](images/data-driven-characters/img_009.jpg)

![](images/data-driven-characters/img_009.jpg)

Even if we did provide the movie transcript as context, we would not have visibility into how it is using this background information as we would with `data-driven-characters`.

即便我们真将整部电影剧本作为上下文提供给 character.ai，我们也无法像使用 `data-driven-characters` 那样，清晰地观察和掌控该背景信息是如何被调用与运用的。

The above example illustrates the difference between the philosophies behind character.ai and `data-driven-characters`. If you primarily interested in **accessibility** and **open-ended entertainment**, character.ai is a better choice. But if you want more **control** in the design of your chatbots, `data-driven-characters` may be a better option to consider.

上述示例凸显了 character.ai 与 `data-driven-characters` 在设计理念上的根本差异。如果你最看重的是**易用性**与**开放式的娱乐体验**，那么 character.ai 是更优之选；但若你希望在聊天机器人设计过程中拥有更强的**自主可控性**，则 `data-driven-characters` 值得你深入考虑。

**You can directly upload any corpus and chat with any character** [**on our app**](https://mbchang-data-driven-characters-app-273bzg.streamlit.app/?ref=blog.langchain.com) **.**

**您可直接在我们的应用中上传任意语料库，并与任意角色进行对话。**  
[**前往我们的应用**](https://mbchang-data-driven-characters-app-273bzg.streamlit.app/?ref=blog.langchain.com)

/

1×

You can directly upload any corpus and chat with any character on our app.

您可直接在我们的应用中上传任意语料库，并与任意角色进行对话。

## Different memory, different conception of self

## 不同的记忆机制，塑造不同的自我认知

In the current age of chatbot assistants like ChatGPT and Bard, "memory" is usually conceived as a method for referencing previous parts of a chat session. However, as illustrated by the [Generative Agents](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2304.xml?ref=blog.langchain.com) paper, memory can serve different purposes at different timescales. For character chatbots, an important role that memory plays is in **defining their very conception of themselves**.

在当前以 ChatGPT、Bard 等聊天机器人助手为主流的时代，“记忆”通常被理解为一种用于回溯对话历史中先前片段的机制。然而，正如 [Generative Agents](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2304.xml?ref=blog.langchain.com) 论文所阐明的那样，记忆可在不同时间尺度上承担不同功能。对于角色型聊天机器人而言，记忆的一项关键作用，正在于**定义其自身对“自我”的认知**。

We can use `data-driven-characters` to compare different methods for packaging information about a character's backstory to create the character. `data-driven-characters` currently implements the following tools for packaging information:

我们可借助 `data-driven-characters` 框架，对比多种将角色背景信息进行结构化封装的方法，从而构建角色。目前，`data-driven-characters` 实现了以下几类信息封装工具：

1. character summary (the character.ai long description)  
1. 角色摘要（即 character.ai 中的长描述）

2. retrieval over the transcript  
2. 基于原始对话记录的检索

3. retrieval over a summarized version of the transcript  
3. 基于对话记录摘要版本的检索

With these tools, we have implemented several example chatbot architectures:

基于上述工具，我们实现了若干典型的角色聊天机器人架构示例：

1. character summary  
1. 仅使用角色摘要

2. retrieval over transcript  
2. 仅基于原始对话记录的检索

3. retrieval over summarized transcript  
3. 仅基于对话记录摘要的检索

4. character summary + retrieval over transcript  
4. 角色摘要 + 基于原始对话记录的检索

5. character summary + retrieval over summarized transcript  
5. 角色摘要 + 基于对话记录摘要的检索

These kinds of memory serve a different purpose from the typical [conversation buffer](https://python.langchain.com/docs/modules/memory/how_to/buffer?ref=blog.langchain.com) (with which we also equip each of the above chatbot architectures) – they define the character chatbot's **conception of self**.

这类记忆与典型的[对话缓冲区](https://python.langchain.com/docs/modules/memory/how_to/buffer?ref=blog.langchain.com)（我们同样为上述每种聊天机器人架构配备了该组件）用途不同——它们定义了角色聊天机器人的**自我认知**。

### Analysis

### 分析

We can evaluate all five architectures to observe the relative effect of the three tools above: (1) character summary, (2) retrieval over the transcript, and (3) retrieval over the summarized transcript.

我们可以评估全部五种架构，以观察上述三种工具的相对效果：(1) 角色摘要，(2) 基于原始剧本的检索，以及 (3) 基于摘要化剧本的检索。

Let us consider a different movie, [Thor: Love and Thunder](https://scrapsfromtheloft.com/movies/thor-love-and-thunder-transcript/?ref=blog.langchain.com), and chat with Thor. In the movie, Thor's enemy Gorr the God Butcher trapped some children in the Shadow Realm inside a cage with spikes. Let us ask Thor where Gorr hid the children.

让我们换一部电影——[《雷神4：爱与雷霆》](https://scrapsfromtheloft.com/movies/thor-love-and-thunder-transcript/?ref=blog.langchain.com)，并与雷神索尔展开对话。在影片中，索尔的敌人“屠神者格尔”将一群儿童囚禁于布满尖刺的牢笼之中，并将其关押在“阴影领域”（Shadow Realm）。现在，我们向索尔提问：格尔把孩子们藏在哪里了？

_Where did Gorr hide the children?_

_格尔把孩子们藏在哪里了？_

1. **character description**: _"Ah, Gorr the God Butcher, he was a formidable adversary. Unfortunately, I do not have knowledge of where he may have hidden the children. However, as the God of Thunder and protector of Asgard, I will do everything in my power to locate and rescue them. Together with my trusted team, we shall prevail."_

1. **角色描述**：_“啊，屠神者格尔，他是一位 formidable 的对手。遗憾的是，我并不知晓他究竟将孩子们藏匿于何处。但作为雷神与阿斯加德的守护者，我必将倾尽全力搜寻并营救他们。在我信赖的团队协助下，我们终将取得胜利。”_

2. **retrieval over raw transcript:** _**"** Gorr hid the children in a cage made of spikes. It was a terrible place, but we were able to rescue them and bring them to safety."_

2. **基于原始剧本的检索**：_**“** 格尔把孩子们关进了一座布满尖刺的牢笼。那是个可怕的地方，但我们成功将他们解救出来，并护送至安全之地。”_

3. **retrieval over summarized transcript**: _"Gorr had trapped the children in the Shadow Realm, a dark and dangerous place. But fear not, for my team and I were able to rescue them and bring them back to safety. It was a harrowing adventure, but we were able to succeed with the help of our allies and our determination to save those who were in need."_

3. **基于摘要化剧本的检索**：_“格尔曾将孩子们囚禁于‘阴影领域’——一个黑暗而危险的地方。但请放心，我和我的团队成功将他们营救出来，并护送他们重返安全之地。这是一场惊心动魄的冒险，但在盟友的支持与我们拯救受难者的坚定决心之下，我们最终圆满完成了任务。”_

4. **character description + retrieval over transcript**: _"Gorr hid the children in a cage made of spikes. But fear not, for I and my team were able to rescue them and bring them back to safety."_

4. **角色描述 + 基于原始剧本的检索**：_“格尔把孩子们关进了一座布满尖刺的牢笼。但请放心，我和我的团队已成功将他们营救出来，并护送他们重返安全之地。”_

5. **character description + retrieval over summarized transcript**: _"Gorr had trapped the children in the Shadow Realm, a dangerous and cursed place. It was a harrowing task to rescue them, but with the help of my team and the gods we recruited, we were able to succeed in our mission. The children are now safe and on their way back to their families."_

5. **角色描述 + 基于摘要化剧本的检索**：_“格尔曾将孩子们囚禁于‘阴影领域’——一个危险且被诅咒的地方。营救他们是一项惊心动魄的任务，但在我的团队以及我们所召集诸神的协助下，我们最终圆满完成了使命。如今孩子们已安然无恙，正踏上归家之路。”_

‌We can make several observations:

我们可以得出若干观察结论：

- Augmenting retrieval with a character summary does not substantially change the content of the response;

- 在检索中加入角色摘要，并未显著改变响应内容；

- Initialization the chatbot with only the character summary produces an generic and uninformative response;

- 仅以角色摘要初始化聊天机器人，会产生泛泛而谈、缺乏信息量的回应；

- Retrieving over the transcript produces a response that references more concrete information ("a cage made of spikes") whereas retrieving over the summarized transcript produces a response that references more abstract information ("the Shadow Realm").

- 基于原始剧本的检索生成的回应引用了更具体的信息（如“一座布满尖刺的牢笼”），而基于摘要化剧本的检索则倾向于引用更抽象的信息（如“阴影领域”）。

These observations clearly show that grounding character chatbots in data makes a big difference in the informativeness of their response. They also show that the kind of data the chatbot is grounded in affects the granularity of their response.

这些观察清晰地表明：将角色聊天机器人“扎根于数据”，对其回应的信息丰富程度具有显著影响；同时也表明，聊天机器人所依托的数据类型，会直接影响其回应的细节粒度（granularity）。

## What data-driven characters will you create?

## 你将创造出哪些数据驱动的角色？

The purpose of `data-driven-characters` is to serve as a **minimal hackable starting point** for creating your own data-driven character chatbots.  
`data-driven-characters` 的目标是为构建您自己的数据驱动型角色聊天机器人提供一个**最小化、可自由修改的起点**。

It provides a simple library built on top of [LangChain](https://docs.langchain.com/docs/?ref=blog.langchain.com) for processing any text corpus, creating character definitions, and managing memory, with various examples and interfaces that make it easy to spin up and debug your own character chatbots.  
它基于 [LangChain](https://docs.langchain.com/docs/?ref=blog.langchain.com) 构建了一个轻量级库，支持处理任意文本语料库、定义角色特征、管理对话记忆，并提供了丰富的示例与交互接口，让您能快速启动并调试属于自己的角色聊天机器人。

### Contributing characters

### 贡献角色

As of the time of writing this post, the following character.ai characters have been generated with `data-driven-characters`. The up-to-date list is on the [Github README](https://github.com/mbchang/data-driven-characters/blob/main/README.md?ref=blog.langchain.com).  
截至本文撰写之时，以下 character.ai 角色已使用 `data-driven-characters` 生成。最新完整列表请参见 [GitHub README](https://github.com/mbchang/data-driven-characters/blob/main/README.md?ref=blog.langchain.com)。

- [Everything Everywhere All At Once (2022)](https://scrapsfromtheloft.com/movies/everything-everywhere-all-at-once-transcript/?ref=blog.langchain.com)  
  - [Evelyn](https://c.ai/c/be5UgphMggDyaf504SSdAdrlV2LHyEgFQZDA5WuQfgw?ref=blog.langchain.com)  
  - [Alpha Waymond](https://c.ai/c/5-9rmqhdVPz_MkFxh5Z-zhb8FpBi0WuzDNXF45T6UoI?ref=blog.langchain.com)  
  - [Jobu Tupaki](https://c.ai/c/PmQe9esp_TeuLM2BaIsBZWgdcKkQPbQRe891XkLu_NM?ref=blog.langchain.com)  
- [Thor: Love and Thunder (2022)](https://scrapsfromtheloft.com/movies/thor-love-and-thunder-transcript/?ref=blog.langchain.com)  
  - [Thor](https://c.ai/c/1Z-uA7GCTQAFOwGdjD8ZFmdNiGZ4i2XbUV4Xq60UMoU?ref=blog.langchain.com)  
  - [Jane Foster](https://c.ai/c/ZTiyQY3D5BzpLfliyhqg1HJzM7V3Fl_UGb-ltv4yUDk?ref=blog.langchain.com)  
  - [Gorr the God Butcher](https://c.ai/c/PM9YD-mMxGMd8aE6FyCELjvYas6GLIS833bjJbEhE28?ref=blog.langchain.com)  
  - [Korg](https://c.ai/c/xaUrztPYZ32IQFO6wBjn2mk2a4IkfM1_0DH5NAmFGkA?ref=blog.langchain.com)  
- [Top Gun: Maverick (2022)](https://scrapsfromtheloft.com/movies/top-gun-maverick-transcript/?ref=blog.langchain.com)  
  - [Peter "Maverick" Mitchell](https://c.ai/c/sWIpYun3StvmhHshlBx4q2l3pMuhceQFPTOvBwRpl9o?ref=blog.langchain.com)  
  - [Bradley "Rooster" Bradshaw](https://c.ai/c/Cw7Nn7ufOGUwRKsQ2AGqMclIPwtSbvX6knyePMETev4?ref=blog.langchain.com)  
  - [Admiral Cain](https://c.ai/c/5X8w0ZoFUGTOOghki2QtQx4QSfak2CEJC86Zn-jJCss?ref=blog.langchain.com)  
- [My Immortal](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/0/items/MyImmortalFanFiction/my-20immortal.xml?ref=blog.langchain.com)  
  - [Ebony Dark'ness Dementia Raven Way](https://c.ai/c/7rOo5z_Nfa-nAlz8hKEezzxTPE6amGXRow98m0v05XY?ref=blog.langchain.com)  

If you create a character.ai character with `data-driven-characters`, please submit a pull request and we can add and acknowledge your contribution to the README.  
如果您使用 `data-driven-characters` 创建了 character.ai 角色，请提交 Pull Request；我们将把您的贡献加入 README 并致以鸣谢。

### Limitations

### 局限性

It is easy to prompt a language model to respond in an open-ended style like "respond in the style of pirate." It is harder to prompt a language model to " _respond_ _in the speaking of this specific character, using these snippets of a corpus for context_." The former case is open-ended whereas the latter case requires precision.  
向语言模型发出类似“以海盗风格作答”的开放式提示相对容易；而要让模型“**严格依据该特定角色的语言风格作答，并以语料库中的若干片段作为上下文支撑**”，则更具挑战性。前者属于开放性任务，后者则要求高度精准。

One limitation of `data-driven-characters` is that, while it grounds the _content_ of the character's dialogue in the corpus, it has been less straightforward to ground the _style_ of the dialogue in the corpus. This can perhaps be addressed via better prompt engineering, so if you have any ideas on how to do this well, please submit a pull request and contribute to the repo!  
`data-driven-characters` 的一个局限在于：尽管它能将角色对话的**内容**锚定于语料库，但将对话的**语言风格**同样可靠地锚定于语料库仍较困难。这一问题或许可通过更精巧的提示词工程（prompt engineering）加以改善——若您对此有独到见解或有效方案，欢迎提交 Pull Request，为本项目贡献力量！

### Contributing to the repo

### 为代码仓库做贡献

`data-driven-characters` is an evolving repo and has a lot of potential for future work, including adding new chatbot architectures, memory management schemes, and better user interfaces.  
`data-driven-characters` 是一个持续演进的开源项目，未来具有广阔拓展空间，例如引入新型聊天机器人架构、优化记忆管理机制、改进用户交互界面等。

The long-term outcome that `data-driven-characters` seeks to catalyze is a **decentralized ecosystem and community of data-driven artificial characters**, where users have **full control over the design and data** used to create the characters.  
`data-driven-characters` 长期致力于推动构建一个**去中心化的、由数据驱动的人工智能角色生态系统与社区**，使用户对角色的设计逻辑与所用数据拥有**完全自主权**。

If this sounds exciting to you, please consider submitting a pull request! See the [contributing section in the github README](https://github.com/mbchang/data-driven-characters/tree/main?ref=blog.langchain.com#contributing) for details.  
若您对此愿景深感振奋，欢迎提交 Pull Request！详情请参阅 [GitHub README 中的“Contributing”章节](https://github.com/mbchang/data-driven-characters/tree/main?ref=blog.langchain.com#contributing)。

## Acknowledgements

## 致谢

`data-driven-characters` is a library built upon [LangChain](https://docs.langchain.com/docs/?ref=blog.langchain.com). The Streamlit interface is inspired from the official [Streamlit chatbot example](https://github.com/streamlit/llm-examples/blob/main/Chatbot.py?ref=blog.langchain.com). Thank you to the wonderful LangChain team for their feedback, support, and energy.

`data-driven-characters` 是一个基于 [LangChain](https://docs.langchain.com/docs/?ref=blog.langchain.com) 构建的库。其 Streamlit 界面灵感源自官方 [Streamlit 聊天机器人示例](https://github.com/streamlit/llm-examples/blob/main/Chatbot.py?ref=blog.langchain.com)。衷心感谢出色的 LangChain 团队所提供的反馈、支持与热情。

### Tags

### 标签



[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/data-driven-characters/img_010.png)](https://blog.langchain.com/neum-x-langchain/)

[![NeumAI × LangChain：为 AI 应用高效同步维护上下文](images/data-driven-characters/img_010.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI × LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/data-driven-characters/img_011.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](images/data-driven-characters/img_011.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/data-driven-characters/img_012.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话](images/data-driven-characters/img_012.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai × LangChain：探索 GenWorlds —— 一个用于协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)

[![Conversational Retrieval Agents](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)

[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain，使用 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)