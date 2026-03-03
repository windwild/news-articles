---
title: "A Chunk by Any Other Name: Structured Text Splitting and Metadata-enhanced RAG"
source: "LangChain Blog"
url: "https://blog.langchain.com/a-chunk-by-any-other-name/"
date: "2024-03-14"
scraped_at: "2026-03-03T08:08:35.449863653+00:00"
language: "en-zh"
translated: true
tags: ["![Extraction Benchmarking", "**Extraction Benchmarking**", "**The Prompt Landscape**", "![Building Chat LangChain", "**Building Chat LangChain**"]
---

_Editor's note: this is a guest entry by [Martin Zirulnik](https://twitter.com/MartinZirulnik?ref=blog.langchain.com), who recently contributed the HTML Header Text Splitter to LangChain. For more of Martin's writing on generative AI, [visit his blog](https://mziru.com/?ref=blog.langchain.com#blog)._

_编辑注：本文为特邀撰稿，作者是 [Martin Zirulnik](https://twitter.com/MartinZirulnik?ref=blog.langchain.com)，他近期为 LangChain 贡献了 HTML Header Text Splitter。如需阅读 Martin 关于生成式 AI 的更多文章，请[访问他的博客](https://mziru.com/?ref=blog.langchain.com#blog)。_

chunking-blog

There's something of a structural irony in the fact that building context-aware LLM applications typically begins with a systematic process of _de_ contextualization, wherein

1. source text is divided into more or less arbitrarily-sized pieces before  
2. each piece undergoes a vector embedding process designed to comprehend context, to capture information inherent in relations _between_ pieces of text.

在构建具备上下文感知能力的大语言模型（LLM）应用时，其典型起点却是一个系统性的“去上下文化”（_de_contextualization）过程——这本身便蕴含某种结构上的反讽：  
1. 首先，原始文本被切分为大小不一、近乎任意的片段；  
2. 随后，每个片段再经由向量嵌入（vector embedding）过程进行处理，而该过程本意恰恰是理解上下文、捕捉文本片段之间固有的语义关联信息。

Not altogether unlike the way human readers interact with natural language, AI applications that rely on Retrieval Augmented Generation (RAG) must balance the analytic precision of drawing inferences from short sequences of characters (what your English teacher would call "close reading") against the comprehension of context-bound structures of meaning that emerge more or less continuously as those sequences increase in length (what your particularly cool English teacher would call "distant reading").

这与人类读者处理自然语言的方式并非全然不同：依赖检索增强生成（Retrieval-Augmented Generation, RAG）的 AI 应用，必须在两种能力之间取得平衡——一方面，需具备从短字符序列中精准推断的分析能力（即英语老师常说的“精读”/close reading）；另一方面，又需理解随序列长度增加而渐次浮现的、受上下文约束的意义结构（即你那位格外酷的英语老师所称的“泛读”/distant reading）。

This blog explores a novel approach to striking this balance with HTML content, leveraging important contextual information inherent to document structures that is typically lost when LLM applications are built over web-scraped data or other HTML sources. In particular, we will test some methods of combining [Self-querying](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/?ref=blog.langchain.com) with LangChain's new [HTML Header Text Splitter](https://python.langchain.com/docs/modules/data_connection/document_transformers/text_splitters/HTML_header_metadata?ref=blog.langchain.com), a "structure-aware" chunker that splits text at the element level and adds metadata for each chunk based on header text.

本文将探索一种针对 HTML 内容实现上述平衡的新颖方法，充分利用文档结构中固有的关键上下文信息——而这些信息，在基于网络爬取数据或其他 HTML 来源构建 LLM 应用时，往往被忽略或丢失。具体而言，我们将尝试将 [自查询（Self-querying）](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/?ref=blog.langchain.com) 与 LangChain 全新推出的 [HTML Header Text Splitter](https://python.langchain.com/docs/modules/data_connection/document_transformers/text_splitters/HTML_header_metadata?ref=blog.langchain.com) 相结合。后者是一种“结构感知型”分块器（structure-aware chunker），它按 HTML 元素层级进行文本切分，并依据标题文本为每个文本块自动添加元数据。

### Imports and Environment Setup [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Imports-and-Environment-Setup)

### 导入与环境配置 [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Imports-and-Environment-Setup)

We will start by importing everything we need up front and setting up the environment, including tracing with [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com). While these traces are not pictured directly in this blog, they are extremely useful for observability, debugging, evaluation, etc. as chains get more complex.

我们将首先导入所有必需的模块，并完成环境配置——包括启用 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 追踪功能。尽管本文未直接展示这些追踪记录，但当链（chain）逻辑日趋复杂时，它们对于可观测性（observability）、调试（debugging）、评估（evaluation）等任务极具价值。

In \[5\]:

In \[5\]：

```
import os
import re
import getpass
from typing import List, Dict
from langchain.schema import Document
from langchain.chat_models import ChatOpenAI
from langchain.embeddings.openai import OpenAIEmbeddings
from langchain.vectorstores import Redis
from langchain.document_loaders import UnstructuredURLLoader
from langchain.text_splitter import HTMLHeaderTextSplitter, RecursiveCharacterTextSplitter
from langchain.chains import RetrievalQA
from langchain.retrievers.self_query.base import SelfQueryRetriever
from langchain.chains.query_constructor.base import (
    get_query_constructor_prompt,
    load_query_constructor_runnable,
    AttributeInfo)
```

```python
os.environ["OPENAI_API_KEY"] = getpass.getpass("OpenAI API Key:")
os.environ["LANGCHAIN_API_KEY"] = getpass.getpass("Langchain API key:")
os.environ["LANGCHAIN_TRACING_V2"] = "true"
os.environ['LANGCHAIN_ENDPOINT'] = "https://api.smith.langchain.com"
os.environ["LANGCHAIN_PROJECT"] = "html-chunking"
```

```python
os.environ["OPENAI_API_KEY"] = getpass.getpass("OpenAI API 密钥：")
os.environ["LANGCHAIN_API_KEY"] = getpass.getpass("Langchain API 密钥：")
os.environ["LANGCHAIN_TRACING_V2"] = "true"
os.environ['LANGCHAIN_ENDPOINT'] = "https://api.smith.langchain.com"
os.environ["LANGCHAIN_PROJECT"] = "html-chunking"
```

### Q+A with Unstructured Chunking [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Q+A-with-Unstructured-Chunking)

### 基于非结构化分块的问答（Q&A）[¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Q+A-with-Unstructured-Chunking)

First, let's implement a naive retrieval strategy with arbitrary character-count based text splitting, following a common pattern in LLM application design.

首先，我们按照大语言模型（LLM）应用设计中的常见模式，实现一种简单的检索策略——即基于任意字符数的文本切分。

In \[10\]:

在 \[10\] 中：

```
# assign chat and embeddings models
llm = ChatOpenAI(
    model='gpt-4',
    temperature=0
)
embeddings = OpenAIEmbeddings()

# load and split unstructured text content from web URL
loader = UnstructuredURLLoader(['https://plato.stanford.edu/entries/goedel/'])
splitter = RecursiveCharacterTextSplitter(
    chunk_size=1000,
    chunk_overlap=0
)
doc = loader.load()
docs = splitter.split_documents(doc)

# create vectorstore and QA retriever
vectorstore = Redis.from_documents(
    docs,
    embeddings,
    # running Redis server locally with Docker
    redis_url='redis://localhost:6379'
)
retriever = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vectorstore.as_retriever(),
    # we'll want to see source documents for comparison
    return_source_documents=True
)
```

```
# 指定聊天模型与嵌入模型
llm = ChatOpenAI(
    model='gpt-4',
    temperature=0
)
embeddings = OpenAIEmbeddings()

# 从网页 URL 加载并切分非结构化文本内容
loader = UnstructuredURLLoader(['https://plato.stanford.edu/entries/goedel/'])
splitter = RecursiveCharacterTextSplitter(
    chunk_size=1000,
    chunk_overlap=0
)
doc = loader.load()
docs = splitter.split_documents(doc)

# 创建向量数据库与问答检索器
vectorstore = Redis.from_documents(
    docs,
    embeddings,
    # 使用 Docker 在本地运行 Redis 服务
    redis_url='redis://localhost:6379'
)
retriever = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vectorstore.as_retriever(),
    # 我们希望查看源文档以便比对
    return_source_documents=True
)
```

Now we can run a test query and print the results along with the source documents, so that we can see how the retriever performed, i.e. which chunks of text it found to prepend to the query as context for the LLM.

现在我们可以运行一个测试查询，并打印结果及对应的源文档，从而直观评估检索器的表现——即它检索到了哪些文本块，并将其作为上下文前置到查询中供大语言模型使用。

In \[12\]:

在 \[12\] 中：

```
def print_result(response_obj):
    print("SOURCES: \n")
    cnt = 1
    for source_doc in response_obj["source_documents"]:
        print(f"Chunk #{cnt}")
        cnt += 1
        print("Source Metadata: ", source_doc.metadata)
        print("Source Text:")
        print(source_doc.page_content)
        print("\n")
    print("RESULT: \n")
    print(response_obj["result"] + "\n\n")
```

```
def print_result(response_obj):
    print("源文档：\n")
    cnt = 1
    for source_doc in response_obj["source_documents"]:
        print(f"文本块 #{cnt}")
        cnt += 1
        print("源文档元数据：", source_doc.metadata)
        print("源文本内容：")
        print(source_doc.page_content)
        print("\n")
    print("查询结果：\n")
    print(response_obj["result"] + "\n\n")
```

```python
query = "explain godel's first incompleteness theorem."
response = retriever({"query":query})
print_result(response)
```

```python
query = "解释哥德尔第一不完备性定理。"
response = retriever({"query": query})
print_result(response)
```

SOURCES:

SOURCES：

Chunk #1  
Source Metadata:  {'id': 'doc:1c6f3e3f7ee14027bc856822871572dc:26e9aac7d5494208a56ff0c6cbbfda20', 'source': 'https://plato.stanford.edu/entries/goedel/'}  
Source Text:  
2.2.1 The First Incompleteness Theorem  

In his Logical Journey (Wang 1996) Hao Wang published the  
full text of material Gödel had written (at Wang’s request)  
about his discovery of the incompleteness theorems. This material had  
formed the basis of Wang’s “Some Facts about Kurt  
Gödel,” and was read and approved by Gödel:  

We see that Gödel first tried to reduce the consistency problem  
for analysis to that of arithmetic. This seemed to require a truth  
definition for arithmetic, which in turn led to paradoxes, such as the  
Liar paradox (“This sentence is false”) and Berry’s  
paradox (“The least number not defined by an expression  
consisting of just fourteen English words”). Gödel then  
noticed that such paradoxes would not necessarily arise if truth were  
replaced by provability. But this means that arithmetic truth and  
arithmetic provability are not co-extensive — whence the First  
Incompleteness Theorem.  

Chunk #1  
源元数据：{'id': 'doc:1c6f3e3f7ee14027bc856822871572dc:26e9aac7d5494208a56ff0c6cbbfda20', 'source': 'https://plato.stanford.edu/entries/goedel/'}  
源文本：  
2.2.1 第一不完备性定理  

在《逻辑之旅》（王浩，1996）中，王浩发表了哥德尔应其请求所撰写的、关于其发现不完备性定理的全部手稿。这些材料构成了王浩所著《关于库尔特·哥德尔的一些事实》一文的基础，并经哥德尔本人阅读并认可：  

我们看到，哥德尔最初试图将分析学的一致性问题归约为算术的一致性问题。这似乎需要为算术建立一个真值定义，而后者又导致了诸如“说谎者悖论”（“这句话是假的”）和“贝里悖论”（“无法用恰好十四个英文单词定义的最小正整数”）等悖论。随后哥德尔注意到，若以“可证性”取代“真理性”，此类悖论未必会出现。但这意味着算术真与算术可证并不等价——由此便导出了第一不完备性定理。

Chunk #2  
Source Metadata:  {'id': 'doc:1c6f3e3f7ee14027bc856822871572dc:d15f62c453c64072b768e136080cb5ba', 'source': 'https://plato.stanford.edu/entries/goedel/'}  
Source Text:  
The First Incompleteness Theorem provides a counterexample to  
completeness by exhibiting an arithmetic statement which is neither  
provable nor refutable in Peano arithmetic, though true in the  
standard model. The Second Incompleteness Theorem shows that the  
consistency of arithmetic cannot be proved in arithmetic itself. Thus  
Gödel’s theorems demonstrated the infeasibility of the  
Hilbert program, if it is to be characterized by those particular  
desiderata, consistency and completeness.  

As an aside, von Neumann understood the two theorems this way, even  
before Gödel did. In fact von Neumann went much further in taking  
the view that they showed the infeasibility of classical mathematics  
altogether. As he wrote to Carnap in June of 1931:  

9]  

And the previous fall von Neumann had written to Gödel in even  
stronger terms:  

It would take Gödel himself a few years to see that those aspects  
of the Hilbert Program had been decisively refuted by his results  
(Mancosu 2004).  

Chunk #2  
源元数据：{'id': 'doc:1c6f3e3f7ee14027bc856822871572dc:d15f62c453c64072b768e136080cb5ba', 'source': 'https://plato.stanford.edu/entries/goedel/'}  
源文本：  
第一不完备性定理通过构造一个在皮亚诺算术中既不可证、亦不可否证（即不可证伪），但在标准模型中为真的算术命题，从而为“完备性”提供了反例。第二不完备性定理则表明：算术系统自身无法证明其自身的一致性。因此，哥德尔定理表明，若希尔伯特纲领以“一致性”与“完备性”作为其核心目标，则该纲领在本质上是不可行的。  

顺便一提，冯·诺依曼甚至早于哥德尔本人就已如此理解这两条定理。事实上，他走得更远，认为它们从根本上揭示了经典数学整体的不可行性。他在1931年6月致卡尔纳普的信中写道：  

9]  

而在前一年秋天，冯·诺依曼致哥德尔的信中措辞甚至更为强烈：  

哥德尔本人还需数年时间才真正意识到：希尔伯特纲领的这些方面已被其成果彻底驳倒（Mancosu，2004）。

Chunk #3  
Chunk #3  

Source Metadata:  {'id': 'doc:1c6f3e3f7ee14027bc856822871572dc:f4dc52218cd040cfa7734b86b6d429ea', 'source': 'https://plato.stanford.edu/entries/goedel/'}  
源元数据：{'id': 'doc:1c6f3e3f7ee14027bc856822871572dc:f4dc52218cd040cfa7734b86b6d429ea', 'source': 'https://plato.stanford.edu/entries/goedel/'}  

Source Text:  
源文本：  
On concluding the proof of the first theorem, Gödel remarks,  
在完成第一定理的证明后，哥德尔评论道：  
“we can readily see that the proof just given is constructive;  
“我们很容易看出，刚才给出的证明是构造性的；  
that is … proved in an intuitionistically unobjectionable  
也就是说……该证明以直觉主义上无可指摘的方式完成……”  
manner…” (Gödel 1986, p. 177). This is because, as  
（Gödel 1986，第177页）。这是因为，正如他所指出的，  
he points out, all the existential statements are based on his theorem  
所有存在性陈述均基于他的定理V（即原始递归关系的数值可表达性），  
V (giving the numeralwise expressibility of primitive recursive  
而该定理在直觉主义意义上是无可指摘的。  
relations), which is intuitionistically unobjectionable.  

2.2.3 The Second Incompleteness Theorem  
2.2.3 第二不完备性定理  

The Second Incompleteness Theorem establishes the unprovability, in  
第二不完备性定理确立了数论自身一致性的不可证性——即，在数论系统内部，  
number theory, of the consistency of number theory. First we have to  
无法证明该数论系统自身的一致性。首先，我们必须写出一个数论公式来表达公理系统的一致性。  
write down a number-theoretic formula that expresses the consistency  
这出人意料地简单：我们只需令  
of the axioms. This is surprisingly simple. We just let  
Con(P) 表示句子 ¬Prov(⌈0 = 1⌉)。  
Con(P) be the sentence ¬Prov(⌈0 = 1⌉).  

Theorem 4 (Gödel’s Second Incompleteness  
定理4（哥德尔第二不完备性定理）：  
Theorem) If P is consistent, then Con(P) is not  
若形式系统 P 是相容的，则 Con(P) 在 P 中不可证。  
provable from P.  

Chunk #4  
Chunk #4  

Source Metadata:  {'id': 'doc:1c6f3e3f7ee14027bc856822871572dc:a69082427ddf43f999690f21531f1ca7', 'source': 'https://plato.stanford.edu/entries/goedel/'}  
源元数据：{'id': 'doc:1c6f3e3f7ee14027bc856822871572dc:a69082427ddf43f999690f21531f1ca7', 'source': 'https://plato.stanford.edu/entries/goedel/'}  

Source Text:  
源文本：  
This account of Gödel’s discovery was told to Hao Wang very  
这一关于哥德尔发现过程的叙述，是在事件发生很久之后才向王浩讲述的；  
much after the fact; but in Gödel’s contemporary  
但在哥德尔与伯奈斯（Bernays）和策梅洛（Zermelo）的同期通信中，  
correspondence with Bernays and Zermelo, essentially the same  
却基本给出了同样路径的描述。（参见 Gödel 2003a 和 Gödel 2003b。）  
description of his path to the theorems is given. (See Gödel  
从这些通信中我们可见，真理性在算术中不可定义这一结果（通常归功于塔斯基），  
2003a and Gödel 2003b respectively.) From those accounts we see  
哥德尔很可能早在1931年就已以某种形式获得。但他既未公开宣布，也未发表该结果；  
that the undefinability of truth in arithmetic, a result credited to  
当时逻辑学家对“真”这一概念所持的偏见——尤其是当塔斯基于1935年宣布其关于形式系统中真理性不可定义性的成果时，  
Tarski, was likely obtained in some form by Gödel by 1931. But he  
这些偏见曾激烈浮现——可能构成了哥德尔未发表该定理的阻碍因素。  
neither publicized nor published the result; the biases logicians had  
expressed at the time concerning the notion of truth, biases which  
came vehemently to the fore when Tarski announced his results on the  
undefinability of truth in formal systems 1935, may have served as a  
deterrent to Gödel’s publication of that theorem.  

2.2.2 The proof of the First Incompleteness Theorem  
2.2.2 第一不完备性定理的证明  

RESULT:  
结果：  

Gödel's First Incompleteness Theorem states that in any consistent formal system that is sufficiently powerful to describe the arithmetic of the natural numbers, there are statements that can't be proven or disproven within the system itself. This means that there are true statements about the natural numbers that can't be proven within the system. The theorem came about when Gödel replaced the concept of truth with provability, realizing that arithmetic truth and arithmetic provability are not the same. This theorem provides a counterexample to completeness by showing an arithmetic statement which is neither provable nor refutable in Peano arithmetic, even though it's true in the standard model.  
哥德尔第一不完备性定理指出：任何一致的形式系统，只要其表达能力足以刻画自然数算术，就必然存在一些命题，既不能在该系统内被证明，也不能被证伪。这意味着，存在关于自然数的真命题，却无法在该系统内得到证明。该定理源于哥德尔将“真”这一概念替换为“可证”，从而认识到算术真与算术可证并非同一概念。该定理通过构造一个在皮亚诺算术中既不可证又不可否的算术命题（尽管它在标准模型中为真），为完备性提供了反例。  

On first gloss, this looks like a pretty solid output from our naive QA chain. While robust RAG evaluation is outside the scope of this blog, we can observe loosely that the generated answer itself sounds reasonable, i.e. it would likely grade well in evaluations for faithfulness and relavancey, and each of the chunks do appear to contain signal regarding Gödel's First Incompleteness Theorem.  
初看之下，这似乎是我们的朴素问答链（naive QA chain）所生成的相当扎实的输出。尽管严谨的RAG评估超出了本文的讨论范围，但我们大致可以观察到：生成的答案本身听上去合理，即在忠实性（faithfulness）和相关性（relevance）等评估维度上很可能得分较高；而且每个文本块确实都包含了与哥德尔第一不完备性定理相关的信息线索。  

But in terms of context precision and recall, the retriever performed quite poorly—in large part because the chunks extend willy-nilly across section breaks indicated in the source document.  
然而，就上下文的精确度（precision）与召回率（recall）而言，检索器的表现却相当糟糕——主要原因在于，这些文本块随意跨越了源文档中明确标示的章节分界线。

For instance, Chunk #3 contains some concluding remarks about the First Incompleteness Theorem, which are relevant to the query, but it also contains text from a subsequent section under the heading "2.2.3 The Second Incompleteness Theorem," which is not; and, worse, Chunk #4 contains the decapitated head of Gödel's proof ("2.2.2 The proof of the First Incompleteness Theorem"), with no proof in sight!

例如，第 #3 段落中包含了一些关于“第一不完备性定理”的总结性评述，这些内容与查询相关；但它同时也混入了后续小节（标题为“2.2.3 第二不完备性定理”）中的文字，而该部分内容与查询无关；更糟糕的是，第 #4 段落仅截取了哥德尔证明的“无头躯干”（标题为“2.2.2 第一不完备性定理的证明”），却完全缺失了证明本身！

We could probably optimize this retriever to some extent, e.g. by varying the chunk size and adding some character overlap between chunks, but doing so would not address the more fundamental problem here: _natural language does not tend to encode information sequentially_. Even simple narrative prose can entail a complex nesting of time-frames and information—so, in many cases including this one, the crude process of transforming contiguous chunks of text into a sequence of nodes has a flattening effect, collapsing implicit and explicit structures of meaning that are more tree-like than chain-like.

我们或许能在一定程度上优化这一检索器，例如通过调整段落大小、或在相邻段落间引入一定字符重叠；但此类调整无法解决此处更根本的问题：_自然语言本质上并不倾向于以线性方式编码信息_。即便是最简单的叙事性文本，也可能蕴含复杂的时间框架嵌套与信息层级——因此，在包括本例在内的许多场景中，将连续文本粗暴地切分为一系列节点的简单做法，会产生“扁平化”效应，从而抹平原本更具树状结构（而非链状结构）的、显性与隐性的语义结构。

### Q+A with Structured Chunking [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Q+A-with-Structured-Chunking)

### 结构化分块问答 [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Q+A-with-Structured-Chunking)

Markup languages (and, to some extent, markdown) present an interesting edge-case, however: in a sense, they are designed to convey non-sequential—i.e. structural—information sequentially, and can therefore provide at least _some_ semblance of semantic scaffolding for our splitting process.

然而，标记语言（以及在某种程度上，Markdown）构成了一类颇具启发性的边界案例：从某种意义上说，它们正是被设计用来以线性方式传达非线性（即结构性）信息的，因而至少能为我们的文本切分过程提供_某种_语义支撑框架。

Let's try a more structured approach to RAG using the HTML Header Text Splitter, which (as mentioned above) works by splitting HTML documents at the element level and attaching metadata for each header (assumed to be relevant) to any given chunk.

让我们尝试一种更结构化的 RAG 方法，使用 HTML 标题文本切分器（HTML Header Text Splitter）。如前所述，该切分器按 HTML 元素层级对文档进行切分，并将每个标题（默认视为相关内容）所对应的元数据附加至其所属的每一个文本段落中。

In \[107\]:

在 \[107\] 中：

```
# select headers to split on, and map these to metadata field names
headers_to_split_on = [\
    ("h1", "article_h1_main"),\
    ("h2", "article_h2_subsection"),\
    ("h3", "article_h3_subsection"),\
    ("h4", "article_h4_subsection"),\
]

html_splitter = HTMLHeaderTextSplitter(
    headers_to_split_on=headers_to_split_on,
    # combine elements with the same metadata by setting return_each_element to False (default)
    return_each_element=False
)
docs = html_splitter.split_text_from_url('https://plato.stanford.edu/entries/goedel/' )

# print sample chunk page content and metadata
for attr in docs[12]:
    print(attr, "\n")
```

```
# 选择用于切分的标题标签，并将其映射至元数据字段名
headers_to_split_on = [\
    ("h1", "article_h1_main"),\
    ("h2", "article_h2_subsection"),\
    ("h3", "article_h3_subsection"),\
    ("h4", "article_h4_subsection"),\
]

html_splitter = HTMLHeaderTextSplitter(
    headers_to_split_on=headers_to_split_on,
    # 通过设置 return_each_element=False（默认值）将具有相同元数据的元素合并
    return_each_element=False
)
docs = html_splitter.split_text_from_url('https://plato.stanford.edu/entries/goedel/' )

# 打印示例段落的页面内容及元数据
for attr in docs[12]:
    print(attr, "\n")
```

```
('page_content', 'Gödel’s proof of the consistency of the continuum hypothesis with the axioms of Zermelo-Fraenkel set theory is a tour de force and arguably the greatest achievement of his mathematical life. This is because aside from the arithmetization, virtually all of the technical machinery used in the proof had to be invented ab initio.  \nThe Continuum Hypothesis (henceforth CH) was formulated by Georg Cantor, and was the first problem on Hilbert’s list of twenty-three unsolved problems as given in his famous address to the International Mathematical Congress in Paris in 1900. The problem as stated by Hilbert is as follows: Let A be an infinite set of real numbers. Then A is either countable, or has cardinality 2ℵ0, i.e., A is in one-to-one correspondence either with the set of natural numbers or with the set of all real numbers (otherwise known as the continuum). Another way to state the continuum hypothesis is that (the first uncountably infinite cardinal) ℵ1 = 2ℵ0.  \nAs early as 1922 Skolem speculated that the CH was independent of the axioms for set theory given by Zermelo in 1908. Nevertheless Hilbert published a (false) proof of the CH in Hilbert 1926. In 1937 Gödel proved its consistency with the axioms of ZF set theory. (Henceforth we use the standard abbreviations for Zermelo-Fraenkel set theory, ZF, and Zermelo-Fraenkel set theory with the Axiom of Choice, ZFC.) The consistency of the negation of the CH was shown by Paul Cohen in 1961 (see Cohen 1963) and hence together with Gödel’s result one infers that the CH is independent of ZF (and ZFC).  \nCohen invented an important new technique called forcing in the course of proving his result; this technique is at present the main method used to construct models of set theory. Forcing led to a revival of formalism among set theorists, the plurality of models being an indication of the “essential variability in set theory,” (Dehornoy 2004) and away from the notion that there is an intended model of set theory—a perspective Gödel advocated since at least 1947, if not earlier.[14] Recently there have been signs that the CH may again be coming to be regarded as a problem to be solved mathematically (with the help of course of some new evident axioms extending ZF). (See for example Woodin 2001a, 2002, 2001b, and Foreman 1998.) If any of the proposed solutions gain acceptance, this would confirm Gödel’s view that the CH would eventually be decided by finding an evident extension of the ZF axioms for set theory. The program associated with this view is called “Gödel’s Large Cardinal Program.”')
```

```
('page_content', '哥德尔关于连续统假设（Continuum Hypothesis, CH）与策梅洛–弗兰克尔集合论（Zermelo-Fraenkel Set Theory）公理系统相容性的证明，堪称力作，亦可说是他数学生涯中最伟大的成就。其原因在于：除算术化（arithmetization）之外，该证明中几乎全部技术工具均需从零发明。  
连续统假设（后文简称 CH）由格奥尔格·康托尔（Georg Cantor）提出，是希尔伯特于 1900 年在巴黎举行的国际数学家大会上所列二十三个未解问题之首。希尔伯特对该问题的表述如下：设 A 是一个实数的无限集合，则 A 要么是可数的，要么其基数为 2ℵ₀，即 A 或与自然数集一一对应，或与全体实数集（即“连续统”）一一对应。另一种等价表述是：（第一个不可数无穷基数）ℵ₁ = 2ℵ₀。  
早在 1922 年，斯科伦（Skolem）就推测 CH 独立于策梅洛（Zermelo）于 1908 年提出的集合论公理系统。尽管如此，希尔伯特仍在 1926 年发表了一篇（错误的）CH 证明。1937 年，哥德尔证明了 CH 与 ZF 集合论公理系统的相容性。（后文我们将沿用标准缩写：ZF 表示策梅洛–弗兰克尔集合论，ZFC 表示加入选择公理后的策梅洛–弗兰克尔集合论。）保罗·科恩（Paul Cohen）于 1961 年证明了 CH 的否定形式与 ZF 公理系统的相容性（参见 Cohen 1963），结合哥德尔的结果，人们由此推断 CH 在 ZF（及 ZFC）系统中是独立的。  
科恩在证明该结论的过程中发明了一种重要的新技术——“力迫法”（forcing）；如今，力迫法已成为构造集合论模型的主要方法。力迫法的出现，促使集合论者重新拥抱形式主义：模型的多样性被视为“集合论本质上的可变性”（Dehornoy 2004）的标志，也使学界逐渐远离“存在唯一‘本意模型’（intended model）”这一观念——而后者恰恰是哥德尔自至少 1947 年起（甚至更早）所倡导的观点。[14] 近年来，已有迹象表明 CH 正再度被视为一个可通过数学手段加以解决的问题（当然需借助某些扩展 ZF 的新且显然成立的公理）。（参见例如 Woodin 2001a、2002、2001b 及 Foreman 1998。）倘若其中任一方案获得学界公认，便将证实哥德尔的预见：CH 最终将通过发现 ZF 集合论公理系统的某个显然成立的扩展而得以判定。与这一观点相关的研究纲领被称为“哥德尔大基数纲领”（Gödel’s Large Cardinal Program）。')
```

('metadata', {'article_h1_main': 'Kurt Gödel', 'article_h2_subsection': '2. Gödel’s Mathematical Work', 'article_h3_subsection': '2.4 Gödel’s Work in Set theory', 'article_h4_subsection': '2.4.1 The consistency of the Continuum Hypothesis and the Axiom of Choice'})

（'metadata'，{'article_h1_main': '库尔特·哥德尔'，'article_h2_subsection': '2. 哥德尔的数学工作'，'article_h3_subsection': '2.4 哥德尔在集合论中的工作'，'article_h4_subsection': '2.4.1 连续统假设与选择公理的一致性'））

In its current configuration, the splitter aggregates the text of all elements with the same header metadata to a single document chunk—with the text of the related h4-level heading (if there is one) assigned to the metadata field "article\_h4\_subsection" and the text of each prior related heading assigned to the fields for h3, h2, and h1 respectively.

当前配置下，该分割器会将所有具有相同标题元数据的元素的文本聚合为一个文档块；其中，相关 h4 级标题的文本（若存在）被赋值给元数据字段 `"article_h4_subsection"`，而每一级更高级别（即 h3、h2、h1）的相关标题文本则分别赋值给对应字段。

If desired, smaller chunk size can be achieved either by having the HTML Header Text Splitter return documents element by element or by pipelining the output to another splitter; but in any case, the hierarchical structure of the element tree of the source document will be preserved as such in the chunk metadata:

如需获得更小的文本块尺寸，可通过两种方式实现：一是让 HTML 标题文本分割器（HTML Header Text Splitter）逐个元素返回文档；二是将输出结果传递至另一个分割器进行进一步处理。但无论采用哪种方式，源文档元素树的层级结构均将在文本块的元数据中完整保留。

In \[41\]:

在 \[41\] 中：

```
for doc in docs:
    if doc.metadata:
        print(doc.metadata, "\n")
```

```
for doc in docs:
    if doc.metadata:
        print(doc.metadata, "\n")
```

```
{'article_h1_main': 'Kurt Gödel'}

{'article_h1_main': 'Kurt Gödel', 'article_h2_subsection': '1. Biographical Sketch'}

{'article_h1_main': 'Kurt Gödel', 'article_h2_subsection': '2. Gödel’s Mathematical Work'}

{'article_h1_main': 'Kurt Gödel', 'article_h2_subsection': '2. Gödel’s Mathematical Work', 'article_h3_subsection': '2.1 The Completeness Theorem', 'article_h4_subsection': '2.1.1 Introduction'}

{'article_h1_main': 'Kurt Gödel', 'article_h2_subsection': '2. Gödel’s Mathematical Work', 'article_h3_subsection': '2.1 The Completeness Theorem', 'article_h4_subsection': '2.1.2 Proof of the Completeness Theorem'}
```

```
{'article_h1_main': '库尔特·哥德尔'}

{'article_h1_main': '库尔特·哥德尔'，'article_h2_subsection': '1. 生平简介'}

{'article_h1_main': '库尔特·哥德尔'，'article_h2_subsection': '2. 哥德尔的数学工作'}

{'article_h1_main': '库尔特·哥德尔'，'article_h2_subsection': '2. 哥德尔的数学工作'，'article_h3_subsection': '2.1 完备性定理'，'article_h4_subsection': '2.1.1 引言'}

{'article_h1_main': '库尔特·哥德尔'，'article_h2_subsection': '2. 哥德尔的数学工作'，'article_h3_subsection': '2.1 完备性定理'，'article_h4_subsection': '2.1.2 完备性定理的证明'}
```

# Kurt Gödel

# 库尔特·哥德尔

## 2. Gödel’s Mathematical Work

## 2. 哥德尔的数学工作

### 2.1 The Completeness Theorem

### 2.1 完备性定理

#### 2.1.3 An Important Consequence of the Completeness Theorem

#### 2.1.3 完备性定理的一个重要推论

## 2. Gödel’s Mathematical Work

## 2. 哥德尔的数学工作

### 2.2 The Incompleteness Theorems

### 2.2 不完备性定理

## 2. Gödel’s Mathematical Work

## 2. 哥德尔的数学工作

### 2.2 The Incompleteness Theorems

### 2.2 不完备性定理

#### 2.2.1 The First Incompleteness Theorem

#### 2.2.1 第一不完备性定理

## 2. Gödel’s Mathematical Work

## 2. 哥德尔的数学工作

### 2.2 The Incompleteness Theorems

### 2.2 不完备性定理

#### 2.2.2 The proof of the First Incompleteness Theorem

#### 2.2.2 第一不完备性定理的证明

## 2. Gödel’s Mathematical Work

## 2. 哥德尔的数学工作

### 2.2 The Incompleteness Theorems

### 2.2 不完备性定理

#### 2.2.3 The Second Incompleteness Theorem

#### 2.2.3 第二不完备性定理

## 2. Gödel’s Mathematical Work

## 2. 哥德尔的数学工作

### 2.3 Speed-up Theorems

### 2.3 加速定理

## 2. Gödel’s Mathematical Work

## 2. 哥德尔的数学工作

### 2.4 Gödel’s Work in Set theory

### 2.4 哥德尔在集合论中的工作

#### 2.4.1 The consistency of the Continuum Hypothesis and the Axiom of Choice

#### 2.4.1 连续统假设与选择公理的一致性

## 2. Gödel’s Mathematical Work

## 2. 哥德尔的数学工作

### 2.4 Gödel’s Work in Set theory

### 2.4 哥德尔在集合论中的工作

#### 2.4.2 Gödel’s Proof of the Consistency of the Continuum Hypothesis and the Axiom of Choice with the Axioms of Zermelo-Fraenkel Set Theory

#### 2.4.2 哥德尔关于连续统假设与选择公理相对于策梅洛-弗兰克尔集合论公理系统一致性的证明

## 2. Gödel’s Mathematical Work

## 2. 哥德尔的数学工作

### 2.4 Gödel’s Work in Set theory

### 2.4 哥德尔在集合论中的工作

#### 2.4.3 Consequences of Consistency

#### 2.4.3 一致性的推论

## 2. Gödel’s Mathematical Work

## 2. 哥德尔的数学工作

### 2.4 Gödel’s Work in Set theory

### 2.4 哥德尔在集合论中的工作

#### 2.4.4 Gödel’s view of the Axiom of Constructibility

#### 2.4.4 哥德尔对可构造性公理的看法

# Kurt Gödel

# 库尔特·哥德尔

## 2. Gödel’s Mathematical Work

## 2. 哥德尔的数学工作

### 2.5 Gödel’s Work in Intuitionistic Logic and Arithmetic

### 2.5 哥德尔在直觉主义逻辑与算术中的工作

#### 2.5.1 Intuitionistic Propositional Logic is not Finitely-Valued

#### 2.5.1 直觉主义命题逻辑不是有限值的

#### 2.5.2 Classical Arithmetic is Interpretable in Heyting Arithmetic

#### 2.5.2 经典算术可在海廷算术中解释

#### 2.5.3 Intuitionistic Propositional Logic is Interpretable in S4

#### 2.5.3 直觉主义命题逻辑可在模态逻辑系统 S4 中解释

#### 2.5.4 Heyting Arithmetic is Interpretable into Computable Functionals of Finite Type.

#### 2.5.4 海廷算术可解释为有限类型的可计算泛函

## 3. Gödel’s Philosophical Views

## 3. 哥德尔的哲学观点

### 3.1 Gödel’s Rationalism

### 3.1 哥德尔的理性主义

### 3.2 Gödel’s Realism

### 3.2 哥德尔的实在论

# Kurt Gödel

# 库尔特·哥德尔

## Bibliography

## 参考文献

### Primary Sources

### 原始文献

#### Gödel’s Writings

#### 哥德尔的著作

# Kurt Gödel

# 库尔特·哥德尔

## Bibliography

## 参考文献

### Primary Sources

### 原始文献

#### The Collected Papers of Kurt Gödel

#### 《库尔特·哥德尔文集》

## Bibliography

## 参考文献

### Secondary Sources

### 二手文献（研究文献）

# Kurt Gödel

# 库尔特·哥德尔

## Academic Tools

## 学术工具

# Kurt Gödel

# 库尔特·哥德尔

## Other Internet Resources

## 其他网络资源

# Kurt Gödel

# 库尔特·哥德尔

## Related Entries

## 相关条目

# Kurt Gödel

# 库尔特·哥德尔

### Acknowledgments

### 致谢

### Browse

### 浏览

### About

### 关于

### Support SEP

### 支持 SEP

### Mirror Sites

### 镜像站点

```
Even if we ignore all of this metadata during retrieval, splitting the document according to its own explicit informational structure should in theory improve our retrieval chain. Let's give this a try before we implement self-querying.
```

```
即使我们在检索过程中忽略所有这些元数据，按照文档自身明确的信息结构对其进行切分，理论上也应能提升我们的检索链效果。在实现自查询（self-querying）之前，我们先尝试这一方法。
```

```
Since we're using Redis for the vector database and now have custom metadata fields for our documents, we need to build a custom index schema. See [this documentation](https://python.langchain.com/docs/integrations/vectorstores/redis?ref=blog.langchain.com#custom-metadata-indexing) for more info.
```

```
由于我们使用 Redis 作为向量数据库，并且当前文档已具备自定义元数据字段，因此需要构建一个自定义索引模式（custom index schema）。更多详情请参阅[相关文档](https://python.langchain.com/docs/integrations/vectorstores/redis?ref=blog.langchain.com#custom-metadata-indexing)。
```

In \[29\]:

在 \[29\] 中：

```
def build_index_schema(documents: List[Document]) -> Dict:
    schema = {"text": []}
    for doc in documents:
        for key in doc.metadata:
            name_dict = {"name": f"{key}"}
            if name_dict not in schema["text"]:
                schema["text"].append(name_dict)
    return schema

index_schema = build_index_schema(docs)
print(index_schema)
```

```
def build_index_schema(documents: List[Document]) -> Dict:
    schema = {"text": []}
    for doc in documents:
        for key in doc.metadata:
            name_dict = {"name": f"{key}"}
            if name_dict not in schema["text"]:
                schema["text"].append(name_dict)
    return schema

index_schema = build_index_schema(docs)
print(index_schema)
```

```
{'text': [{'name': 'article_h1_main'}, {'name': 'article_h2_subsection'}, {'name': 'article_h3_subsection'}, {'name': 'article_h4_subsection'}]}
```

```
{'text': [{'name': 'article_h1_main'}, {'name': 'article_h2_subsection'}, {'name': 'article_h3_subsection'}, {'name': 'article_h4_subsection'}]}
```

```python
vectorstore = Redis.from_documents(
    docs,
    embeddings,
    redis_url='redis://localhost:6379',
    index_schema = index_schema
)
retriever = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vectorstore.as_retriever(),
    return_source_documents=True
)

query = "explain godel's first incompleteness theorem."
response = retriever({"query": query})
print_result(response)
```

```python
vectorstore = Redis.from_documents(
    docs,
    embeddings,
    redis_url='redis://localhost:6379',
    index_schema = index_schema
)
retriever = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vectorstore.as_retriever(),
    return_source_documents=True
)

query = "explain godel's first incompleteness theorem."
response = retriever({"query": query})
print_result(response)
```

SOURCES:

Chunk #1  
Source Metadata:  {'id': 'doc:c39d409b58e3444691ad91c34b5c3ee1:2b0ffb3f19f94dd0812b72507bb83c23', 'article_h1_main': 'Kurt Gödel', 'article_h2_subsection': '2. Gödel’s Mathematical Work', 'article_h3_subsection': '2.2 The Incompleteness Theorems', 'article_h4_subsection': '2.2.3 The Second Incompleteness Theorem'}  
Source Text:  
The Second Incompleteness Theorem establishes the unprovability, in number theory, of the consistency of number theory. First we have to write down a number-theoretic formula that expresses the consistency of the axioms. This is surprisingly simple. We just let Con(P) be the sentence ¬Prov(⌈0 = 1⌉).  
Theorem 4 (Gödel’s Second Incompleteness Theorem) If P is consistent, then Con(P) is not provable from P.  
Proof: Let φ be as in (3). The reasoning used to infer ‘if P ⊢ φ, then P ⊢ 0 ≠ 1‘ does not go beyond elementary number theory, and can therefore, albeit with a lot of effort (see below), be formalized in P. This yields: P ⊢ (Prov(⌈φ⌉) → ¬Con(P)), and thus by (3), P ⊢ (Con(P) → φ). Since P ⊬ φ, we must have P ⊬ Con(P).  
The above proof (sketch) of the Second Incompleteness Theorem is deceptively simple as it avoids the formalization. A rigorous proof would have to establish the proof of ‘if P ⊢ φ, then P ⊢ 0 ≠ 1’ in P.  
It is noteworthy that ω-consistency is not needed in the proof of Gödel’s Second Incompleteness Theorem. Also note that neither is ¬Con(P) provable, by the consistency of P and the fact, now known as Löb’s theorem, that P ⊢ Prov(⌈φ⌉) implies P ⊢ φ.  
The assumption of ω-consistency in the First Incompleteness Theorem was eliminated by Rosser in 1936, and replaced by the weaker notion of consistency. Rosser’s generalization involves applying the fixed point theorem to the formula R(x): ‘for all z: either z is not the Gödel number of a proof of the formula with Gödel number x or there is a proof shorter than z of the negation of (the formula with Gödel number) x’ (see Rosser 1936).  
With regard to the Second Incompleteness Theorem, the argument relies in part on formalizing the proof of the First Incompleteness Theorem as we saw. This step is omitted in Gödel 1931. He planned to include the step in what would have been a second part II (see footnote 48a of Gödel 1931). But instead of writing it he turned to the continuum problem.[13] (Part II was to elaborate on other points too: the ‘true reason for incompleteness,’ and the applicability of the two theorems to other systems.) He perhaps did not feel compelled to attend to what looked like an exercise in formalization, relying instead on the informal argument to convince (in which it succeeded). However this step turned out to be somewhat non-trivial. As Kleene puts it in his introduction to Gödel 1931, of the informal presentation, “Certainly the idea of the argument for Theorem XI (consistency) was very convincing; but it turned out that the execution of the details required somewhat more work and care than had been anticipated.” (See pp. 126–141 of Gödel 1986.) Eventually a complete proof of the Second Theorem was given by Hilbert and Bernays in some seventy pages in their Hilbert and Bernays 1939. A much more compact treatment of the theorem was given by Löb in his Löb 1956, and subsequently Feferman, in his 1960 “Arithmetization of Metamathematics in a General Setting” (Feferman 1960/1961), gave a succinct and completely general treatment of both the First and Second Theorems. But see the supplementary document:  
Did the Incompleteness Theorems Refute Hilbert’s Program?  
For more detailed discussion, see the entry on Gödel’s incompleteness theorems.

来源 #1  
源元数据：{'id': 'doc:c39d409b58e3444691ad91c34b5c3ee1:2b0ffb3f19f94dd0812b72507bb83c23', 'article_h1_main': '库尔特·哥德尔', 'article_h2_subsection': '2. 哥德尔的数学工作', 'article_h3_subsection': '2.2 不完备性定理', 'article_h4_subsection': '2.2.3 第二不完备性定理'}  
源文本：  
第二不完备性定理指出：在数论中，数论自身的相容性是不可证的。首先，我们需要写出一个表达公理系统相容性的数论公式。这出人意料地简单：我们只需令 Con(P) 表示句子 ¬Prov(⌈0 = 1⌉)。  
定理 4（哥德尔第二不完备性定理）：若 P 是相容的，则 Con(P) 在 P 中不可证。  
证明：设 φ 如式 (3) 所示。为推导“若 P ⊢ φ，则 P ⊢ 0 ≠ 1”，所用推理不超出初等数论范畴；因此，尽管需付出大量努力（参见下文），该推理仍可在 P 内形式化。由此可得：P ⊢ (Prov(⌈φ⌉) → ¬Con(P))，再结合 (3) 式，即得 P ⊢ (Con(P) → φ)。由于 P ⊬ φ，故必有 P ⊬ Con(P)。  
上述第二不完备性定理的（概要）证明看似简洁，实则回避了形式化细节。严格证明须在 P 中完成“若 P ⊢ φ，则 P ⊢ 0 ≠ 1”的形式化推导。  
值得注意的是，哥德尔第二不完备性定理的证明无需 ω-相容性假设。此外，由 P 的相容性及现称“勒布定理（Löb’s theorem）”的结果（即若 P ⊢ Prov(⌈φ⌉)，则 P ⊢ φ）可知，¬Con(P) 同样不可证。  
第一不完备性定理中对 ω-相容性的依赖，于 1936 年被罗瑟（Rosser）消除，并代之以更弱的“相容性”概念。罗瑟的推广涉及将不动点定理应用于公式 R(x)：“对所有 z：z 要么不是公式（其哥德尔数为 x）的证明的哥德尔数，要么存在一个比 z 更短的、关于（哥德尔数为 x 的）公式的否定的证明”（参见 Rosser 1936）。  
至于第二不完备性定理，其论证部分依赖于对第一不完备性定理证明的形式化——正如我们前述。此步骤在哥德尔 1931 年原文中被省略；他原计划将其纳入本应作为第二部分（Part II）的续篇（参见哥德尔 1931 年论文脚注 48a）。但他最终未撰写该部分，转而研究连续统问题[13]。（第二部分本还拟深入探讨其他要点，包括“不完备性的真正原因”以及两条定理向其他系统的适用性。）他或许认为，这一形式化工作仅属技术性练习，因而更愿倚重非形式化论证来说服读者（事实上也确实成功了）。然而，该步骤后来被证实并非微不足道。克莱尼（Kleene）在其为《哥德尔 1931》所作引言中评价该非形式化论述道：“定理 XI（相容性）论证的思想无疑极具说服力；但细节的落实却比预想中需要更多工作与审慎。”（参见《哥德尔 1986》第 126–141 页。）最终，希尔伯特与贝尔奈斯（Hilbert & Bernays）于 1939 年出版的著作中，用约七十页篇幅给出了第二定理的完整证明。洛布（Löb）于 1956 年给出更为紧凑的处理；随后费弗曼（Feferman）在 1960 年发表的《一般框架下的元数学算术化》（Feferman 1960/1961）中，以简明且完全普适的方式同时处理了第一与第二定理。但请参阅补充文档：  
不完备性定理是否驳倒了希尔伯特纲领？  
如需更详尽讨论，请参阅“哥德尔不完备性定理”词条。

Chunk #2  
Source Metadata:  {'id': 'doc:c39d409b58e3444691ad91c34b5c3ee1:88cbf09a1af64dc78b6ac0c34170b725', 'article_h1_main': 'Kurt Gödel', 'article_h2_subsection': 'Related Entries', 'article_h3_subsection': None, 'article_h4_subsection': None}  
Source Text:  
Gödel, Kurt: incompleteness theorems | Hilbert, David: program in the foundations of mathematics | Husserl, Edmund | Leibniz, Gottfried Wilhelm | mathematics, philosophy of: intuitionism | mathematics, philosophy of: Platonism | model theory | model theory: first-order | phenomenology | realism | set theory | set theory: continuum hypothesis | set theory: large cardinals and determinacy

来源 #2  
源元数据：{'id': 'doc:c39d409b58e3444691ad91c34b5c3ee1:88cbf09a1af64dc78b6ac0c34170b725', 'article_h1_main': '库尔特·哥德尔', 'article_h2_subsection': '相关条目', 'article_h3_subsection': None, 'article_h4_subsection': None}  
源文本：  
哥德尔，库尔特：不完备性定理｜希尔伯特，大卫：数学基础中的纲领｜胡塞尔，埃德蒙德｜莱布尼茨，戈特弗里德·威廉｜数学哲学：直觉主义｜数学哲学：柏拉图主义｜模型论｜模型论：一阶｜现象学｜实在论｜集合论｜集合论：连续统假设｜集合论：大基数与决定性

Chunk #3  
Source Metadata:  {'id': 'doc:c39d409b58e3444691ad91c34b5c3ee1:65d27ea51ab0470e82b59678ccf471ce', 'article_h1_main': 'Kurt Gödel', 'article_h2_subsection': '2. Gödel’s Mathematical Work', 'article_h3_subsection': '2.2 The Incompleteness Theorems', 'article_h4_subsection': '2.2.2 The proof of the First Incompleteness Theorem'}  
Source Text:  
We now describe the proof of the two theorems, formulating Gödel’s results in Peano arithmetic. Gödel himself used a system related to that defined in Principia Mathematica, but containing Peano arithmetic. In our presentation of the First and Second Incompleteness Theorems we refer to Peano arithmetic as P, following Gödel’s notation.  
Before proceeding to the details of the formal proof, we define the notion of ω-consistency used by Gödel in the First Incompleteness Theorem: P is ω-consistent if P ⊢ ¬φ(n) for all n implies P ⊬ ∃xφ(x). Naturally this implies consistency and follows from the assumption that the natural numbers satisfy the axioms of Peano arithmetic.  
One of the main technical tools used in the proof is Gödel numbering, a mechanism which assigns natural numbers to terms and formulas of our formal theory P. There are different ways of doing this. The most common is based on the unique representation of natural numbers as products of powers of primes. Each symbol s of number theory is assigned a positive natural number #(s) in a fixed but arbitrary way, e.g.  
#(0) = 1 #(=) = 5 #(¬) = 9 #(1) = 2 #( ( ) = 6 #(∀) = 10 #(+) = 3 #( ) ) = 7 #(vi) = 11 + i #(×) = 4 #(∧) = 8  
The natural number corresponding to a sequence w = < w0,…, wk > of symbols is  
⌈w⌉ = 2#(w0) · 3#(w1) · … · pk#(wk),  
where pk is the k+1st prime. It is called its Gödel number and denoted by ⌈w⌉. In this way we can assign Gödel numbers to formulas, sequences of formulas (once a method for distinguishing when one formula ends and another begins has been adopted), and most notably, proofs.  
An essential point here is that when a formula is construed as a natural number, then the numeral corresponding to that natural number can occur as the argument of a formula, thus enabling the syntax to “refer” to itself, so to speak (i.e., when a numeral is substituted into a formula the Gödel number of which the numeral represents). This will eventually allow Gödel to formalize the Liar paradox (with “provability” in place of “truth”) by substituting into the formula which says, ‘the formula, whose code is x, is unprovable,’ its own natural number code (or more precisely the corresponding numeral).  
Another concept required to carry out the formalization is the concept of numeralwise expressibility of number theoretic predicates. A number-theoretic formula φ(n1, …, nk) is numeralwise expressible in P if for each tuple of natural numbers (n1, …, nk):  
N ⊨ φ(n1, …, nk) ⇒ P ⊢ φ(n1, …, nk) N ⊨ ¬φ(n1, …, nk) ⇒ P ⊢ ¬φ(n1, …, nk)  
where n is the formal term which denotes the natural number n. (In P, this is S(S(…S(0)…), where n is the number of iterations of the successor function applied to the constant symbol 0.) One of the principal goals is to numeralwise express the predicate  
Prf(x, y): ‘the sequence with Gödel number x is a proof of the sentence with Gödel number y.’  
Reaching this goal involves defining forty-five relations, each defined in terms of the preceding ones. These relations are all primitive recursive.[10] Relations needed are, among others, those which assert of a natural number that it codes a sequence, or a formula, or an axiom, or that it is the code, denoted by Sb(ru1…unZ(x1)…Z(xn)), of a formula obtained from a formula with code r by substituting for its free variable ui the xi th numeral for i = 1, …, n. The forty-fifth primitive recursive relation defined is Prf(x, y), and the forty-sixth is  
Prov(y): ‘the sentence with Gödel number y is provable in P’  
which without being primitive recursive, is however obtained from Prf(x, y) by existentially quantifying x. (Prov(y) satisfies only the ‘positive’ part of numeralwise expressibility, and not the negative part; but the negative part is not needed.)  
In Theorem V of his paper, Gödel proves that any number theoretic predicate which is primitive recursive is numeralwise expressible in P. Thus since Prf(x, y) and substitution are primitive recursive, these are decided by P when closed terms are substituted for the free variables x and y. This is the heart of the matter as we will see. Another key point about numeralwise expressibility is that although we informally interpret, for example, Prov(Sb(ru1…unZ(x1)…Z(xn))), by: ‘the formula with Gödel number r is provable if the Gödel number for the xi th numeral is substituted in place of the i th variable,’ neither the formal statement within the theory P nor anything we prove about it appeals to such meanings. On the contrary Prov(Sb(ru1…unZ(x1)…Z(xn))), is a meaningless string of logical and arithmetical symbols. As Gödel puts it in his introduction to his theorem V, ‘The fact that can be formulated vaguely by saying that every recursive relation is definable in the system P (if the usual meaning is given to the formulas of this system) is expressed in precise language, without reference to any interpretation of the formulas of P, by the following Theorem (V) (Gödel 1986, p. 171, italics Gödel’s).  
Gödel in his incompleteness theorems uses a method given in what is called nowadays Gödel’s Fixed Point Theorem. Although Gödel constructs a fixed point in the course of proving the incompleteness theorem, he does not state the fixed point theorem explicitly. The fixed point theorem is as follows:  
Theorem 2 (Gödel’s Fixed Point Theorem) If φ(v0) is a formula of number theory, then there is a sentence ψ such that P ⊢ ψ ↔ φ(⌈ψ⌉), where ⌈ψ⌉ is the formal term corresponding to the natural number code of ⌈ψ⌉.  
Proof: Let σ(x,y,z) be a formula that numeralwise expresses the number theoretic predicate ‘y is the Gödel number of the formula obtained by replacing the variable v0 in the formula whose Gödel number is x by the term z’. Let θ(v0) be the formula ∃v1(φ(v1) ∧ σ(v0, v1, v0)). Let k = ⌈θ(v0)⌉ and ψ = θ(k). Now directly by the construction P ⊢ ψ ↔ φ(⌈ψ⌉).  
A sentence is refutable from a theory if its negation is provable. The First Incompleteness Theorem as Gödel stated it is as follows:  
Theorem 3 (Gödel’s First Incompleteness Theorem) If P is ω-consistent, then there is a sentence which is neither provable nor refutable from P.  
Proof: By judicious coding of syntax referred to above, write a formula Prf(x,y)[11] of number theory, representable in P, so that  
n codes a proof of φ ⇒ P ⊢ Prf(n, ⌈φ⌉).  
and  
n does not code a proof of φ ⇒ P ⊢ ¬Prf(n, ⌈φ⌉).  
Let Prov(y) denote the formula ∃x Prf(x,y)[12]. By Theorem 2 there is a sentence φ with the property  
P ⊢ (φ ↔ ¬Prov(⌈φ⌉)).  
Thus φ says ‘I am not provable.’ We now observe, if P ⊢ φ, then by (1) there is n such that P ⊢ Prf(n, ⌈φ⌉), hence P ⊢ Prov(⌈φ⌉), hence, by (3) P ⊢ ¬φ, so P is inconsistent. Thus  
P ⊬ φ  
Furthermore, by (4) and (2), we have P ⊢ ¬Prf(n, ⌈φ⌉) for all natural numbers n. By ω-consistency P ⊬ ∃x Prf(x, ⌈φ⌉). Thus (3) gives P ⊬ ¬φ. We have shown that if P is ω-consistent, then φ is independent of P.  
On concluding the proof of the first theorem, Gödel remarks, “we can readily see that the proof just given is constructive; that is … proved in an intuitionistically unobjectionable manner…” (Gödel 1986, p. 177). This is because, as he points out, all the existential statements are based on his theorem V (giving the numeralwise expressibility of primitive recursive relations), which is intuitionistically unobjectionable.

来源 #3  
源元数据：{'id': 'doc:c39d409b58e3444691ad91c34b5c3ee1:65d27ea51ab0470e82b59678ccf471ce', 'article_h1_main': '库尔特·哥德尔', 'article_h2_subsection': '2. 哥德尔的数学工作', 'article_h3_subsection': '2.2 不完备性定理', 'article_h4_subsection': '2.2.2 第一不完备性定理的证明'}  
源文本：  
我们现在描述两条定理的证明过程，并将哥德尔的结果表述于皮亚诺算术（Peano arithmetic）框架内。哥德尔本人使用的是与《数学原理》（Principia Mathematica）所定义系统相关、但包含皮亚诺算术的一个系统。在本文对第一与第二不完备性定理的阐述中，我们沿用哥德尔的记号，将皮亚诺算术记为 P。  
在进入形式化证明的细节之前，我们先定义哥德尔在第一不完备性定理中使用的 ω-相容性概念：若对所有自然数 n 均有 P ⊢ ¬φ(n)，则 P ⊬ ∃xφ(x)，此时称 P 是 ω-相容的。显然，ω-相容性蕴含相容性，且可由“自然数满足皮亚诺算术公理”这一假设推出。  
证明中一项主要技术工具是哥德尔编号（Gödel numbering）——一种为形式理论 P 中的项与公式赋予自然数的机制。实现方式有多种，最常见者基于自然数的素数幂唯一分解表示法。数论中每个符号 s 均以固定但任意的方式被赋予一个正整数 #(s)，例如：  
#(0) = 1　　#(=) = 5　　#(¬) = 9　　#(1) = 2　　#( ( ) = 6　　#(∀) = 10　　#(+) = 3　　#( ) ) = 7　　#(vi) = 11 + i　　#(×) = 4　　#(∧) = 8  
对于符号序列 w = < w₀, …, wₖ >，其对应的自然数为  
⌈w⌉ = 2#(w₀) · 3#(w₁) · … · pₖ#(wₖ)，  
其中 pₖ 是第 (k+1) 个素数。该数称为 w 的哥德尔数，记作 ⌈w⌉。借此方法，我们可为公式、公式序列（需预先约定如何区分一个公式的结束与下一个公式的开始）、尤其是证明，分配哥德尔数。  
此处的关键在于：当一个公式被视作一个自然数时，该自然数所对应的数字符号（numeral）便可作为某公式的参数出现，从而使得语法系统能在某种意义上“自我指涉”（即：将某个数字符号代入一个公式时，该数字符号恰好代表该公式的哥德尔数）。这最终使哥德尔得以将说谎者悖论（以“可证性”替代“真理性”）形式化：将“代码为 x 的公式不可证”这一公式，代入其自身的自然数代码（或更准确地说，代入其对应的数字符号）。  
另一项完成形式化所必需的概念是“数论谓词的数字符号可表达性（numeralwise expressibility）”。若对任意自然数元组 (n₁, …, nₖ)，均有  
ℕ ⊨ φ(n₁, …, nₖ) ⇒ P ⊢ φ(n₁, …, nₖ)，  
ℕ ⊨ ¬φ(n₁, …, nₖ) ⇒ P ⊢ ¬φ(n₁, …, nₖ)，  
则称数论公式 φ(n₁, …, nₖ) 在 P 中具有数字符号可表达性，其中 n 是表示自然数 n 的形式项（在 P 中即为 S(S(…S(0)…)，其中 S 迭代应用 n 次于常量符号 0）。其中一项核心目标，是使如下谓词具有数字符号可表达性：  
Prf(x, y)：“哥德尔数为 x 的序列，是哥德尔数为 y 的句子的一个证明。”  
达成此目标需定义四十五个关系，每个关系均以前述关系为基础定义。这些关系全为原始递归的[10]。所需关系包括但不限于：断言某自然数编码一个序列、一个公式、一条公理；或断言某自然数是 Sb(ru₁…uₙZ(x₁)…Z(xₙ)) 所表示的代码——即：从哥德尔数为 r 的公式出发，将其自由变元 uᵢ 替换为第 xᵢ 个数字符号（i = 1, …, n）后所得公式的代码。第四十五个定义的原始递归关系即为 Prf(x, y)，第四十六个则是  
Prov(y)：“哥德尔数为 y 的句子在 P 中可证。”  
该关系虽非原始递归，但可通过在 Prf(x, y) 中对 x 存在量化而得到。（Prov(y) 仅满足“数字符号可表达性”的“正向”部分，而不满足“负向”部分；但后者在此处并非必需。）  
在论文的定理 V 中，哥德尔证明：任何原始递归的数论谓词均可在 P 中数字符号可表达。因此，由于 Prf(x, y) 及代入操作均为原始递归，当闭合项代入自由变元 x 和 y 时，P 即可判定它们。这正是问题的核心所在（我们后文将看到）。关于数字符号可表达性的另一关键点在于：尽管我们非形式地将 Prov(Sb(ru₁…uₙZ(x₁)…Z(xₙ))) 解释为“若将第 xᵢ 个数字符号的哥德尔数代入第 i 个变元，则哥德尔数为 r 的公式可证”，但理论 P 内部的该形式陈述本身，以及我们对其所作的一切证明，均不诉诸此类含义。相反，Prov(Sb(ru₁…uₙZ(x₁)…Z(xₙ))) 仅是一串无意义的逻辑与算术符号。正如哥德尔在定理 V 的引言中所言：“可粗略表述为‘每个递归关系在系统 P 中均可定义（若赋予该系统公式通常的含义）’这一事实，以下述定理（V）予以精确表述，且不涉及对 P 中公式的任何解释。”（哥德尔 1986，第 171 页，斜体为哥德尔原文）  
哥德尔在不完备性定理中所用的方法，即今日常称的“哥德尔不动点定理”。尽管哥德尔在证明不完备性定理过程中构造了一个不动点，但他并未明确陈述该不动点定理。该定理内容如下：  
定理 2（哥德尔不动点定理）：若 φ(v₀) 是一个数论公式，则存在一个句子 ψ，使得 P ⊢ ψ ↔ φ(⌈ψ⌉)，其中 ⌈ψ⌉ 是对应于 ψ 的哥德尔数的数字符号。  
证明：设 σ(x, y, z) 是一个数字符号可表达如下数论谓词的公式：“y 是将哥德尔数为 x 的公式中变元 v₀ 替换为项 z 后所得公式的哥德尔数”。令 θ(v₀) 为公式 ∃v₁(φ(v₁) ∧ σ(v₀, v₁, v₀))。令 k = ⌈θ(v₀)⌉，ψ = θ(k)。由构造直接可得 P ⊢ ψ ↔ φ(⌈ψ⌉)。  
若一个句子的否定式可证，则称该句子在理论中可驳倒（refutable）。哥德尔所陈述的第一不完备性定理如下：  
定理 3（哥德尔第一不完备性定理）：若 P 是 ω-相容的，则存在一个句子，它在 P 中既不可证，亦不可驳倒。  
证明：通过上文所述的精巧语法编码，构造一个在 P 中可表示的数论公式 Prf(x, y)[11]，使得  
n 编码 φ 的一个证明 ⇒ P ⊢ Prf(n, ⌈φ⌉)，  
且  
n 不编码 φ 的一个证明 ⇒ P ⊢ ¬Prf(n, ⌈φ⌉)。  
令 Prov(y) 表示公式 ∃x Prf(x, y)[12]。由定理 2，存在一个句子 φ，满足  
P ⊢ (φ ↔ ¬Prov(⌈φ⌉))。  
因此 φ 表达“我不可证”。现观察：若 P ⊢ φ，则由 (1) 知存在 n 使得 P ⊢ Prf(n, ⌈φ⌉)，从而 P ⊢ Prov(⌈φ⌉)，再由 (3) 得 P ⊢ ¬φ，故 P 不一致。因此  
P ⊬ φ  
此外，由 (4) 与 (2) 可知，对所有自然数 n，均有 P ⊢ ¬Prf(n, ⌈φ⌉)。由 ω-相容性，P ⊬ ∃x Prf(x, ⌈φ⌉)。于是 (3) 给出 P ⊬ ¬φ。我们已证明：若 P 是 ω-相容的，则 φ 在 P 中独立。  
在第一定理证明结尾处，哥德尔评述道：“我们很容易看出，上述证明是构造性的；即……以直觉主义上无可指摘的方式证明……”（哥德尔 1986，第 177 页）。这是因为，如他所指出，所有存在性陈述均基于其定理 V（即原始递归关系的数字符号可表达性），而该定理在直觉主义意义上是无可指摘的。

Chunk #4  
Source Metadata:  {'id': 'doc:c39d409b58e3444691ad91c34b5c3ee1:5eda575b170248b5a6f1cc45dc318dab', 'article_h1_main': 'Kurt Gödel', 'article_h2_subsection': '2. Gödel’s Mathematical Work', 'article_h3_subsection': '2.2 The Incompleteness Theorems', 'article_h4_subsection': None}  
Source Text:  
Gödel mentioned the possibility of the unsolvability of a question about the reals already in his 1929 thesis, in arguing against the formalist principle of Hilbert’s, that consistency is a criterion for existence. In fact, giving a finitary proof of the consistency of analysis was a key desideratum of what was then known as the Hilbert program, along with proving its completeness. Accordingly it was Gödel’s turn to these questions, especially the first, which led him to the two incompleteness theorems. (For a discussion of the Hilbert Program the reader is referred to the standard references: Sieg 1990, 1988, 1999; Mancosu 1998, Zach 2003, Tait 1981 and Tait 2002.)  
The First Incompleteness Theorem provides a counterexample to completeness by exhibiting an arithmetic statement which is neither provable nor refutable in Peano arithmetic, though true in the standard model. The Second Incompleteness Theorem shows that the consistency of arithmetic cannot be proved in arithmetic itself. Thus Gödel’s theorems demonstrated the infeasibility of the Hilbert program, if it is to be characterized by those particular desiderata, consistency and completeness.  
As an aside, von Neumann understood the two theorems this way, even before Gödel did. In fact von Neumann went much further in taking the view that they showed the infeasibility of classical mathematics altogether. As he wrote to Carnap in June of 1931:  
Thus today I am of the opinion that 1. Gödel has shown the unrealizability of Hilbert’s program. 2. There is no more reason to reject intuitionism (if one disregards the aesthetic issue, which in practice will also for me be the decisive factor). Therefore I consider the state of the foundational discussion in Königsberg to be outdated, for Gödel’s fundamental discoveries have brought the question to a completely different level.[9]  
And the previous fall von Neumann had written to Gödel in even stronger terms:  
Thus, I think that your result has solved negatively the foundational question: there is no rigorous justification for classical mathematics. (Gödel 2003b, p. 339)  
It would take Gödel himself a few years to see that those aspects of the Hilbert Program had been decisively refuted by his results (Mancosu 2004).

来源 #4  
源元数据：{'id': 'doc:c39d409b58e3444691ad91c34b5c3ee1:5eda575b170248b5a6f1cc45dc318dab', 'article_h1_main': '库尔特·哥德尔', 'article_h2_subsection': '2. 哥德尔的数学工作', 'article_h3_subsection': '2.2 不完备性定理', 'article_h4_subsection': None}  
源文本：  
哥德尔早在 1929 年的博士论文中，就已提及关于实数的一个问题可能不可解，并以此反驳希尔伯特的形式主义原则——即“相容性是存在性的判据”。事实上，为分析学的相容性提供一个有穷证明，连同证明其完备性，正是当时所谓“希尔伯特纲领”的两大核心诉求。因此，正是哥德尔对这些问题（尤其是前者）的关注，引导他发现了两条不完备性定理。（关于希尔伯特纲领的讨论，读者可参考标准文献：Sieg 1990、1988、1999；Mancosu 1998；Zach 2003；Tait 1981 与 Tait 2002。）  
第一不完备性定理通过展示一个在皮亚诺算术中既不可证亦不可驳倒、但在标准模型中为真的算术命题，为完备性提供了反例。第二不完备性定理则表明：算术自身的相容性

Gödel then constructs a specific statement (often informally described as "This statement cannot be proven") within the system. If this statement could be proven true within the system, it would be false, creating a contradiction. If it could be proven false, that would mean it could be proven, which would make it true, again a contradiction. Therefore, this statement can neither be proven true nor false within the system, demonstrating the system's incompleteness.

哥德尔随后在该形式系统内构造了一个特定命题（通常非正式地表述为：“该命题无法被证明”）。如果该命题能在系统内被证明为真，则它实际为假，从而导致矛盾；如果它能在系统内被证明为假，则意味着它可被证明，从而又使其为真，同样导致矛盾。因此，该命题在系统内既不能被证明为真，也不能被证明为假，由此揭示了该系统的不完备性。

It's important to note that the system must be consistent (it cannot produce contradictory results) and sufficiently expressive (capable of expressing at least basic arithmetic) for the theorem to apply.

需要特别指出的是，该定理的适用前提是：该系统必须是一致的（即不能推导出相互矛盾的结果），且具有足够的表达能力（至少能够表达基本算术）。

```

Lo! The retriever now successfully retrieves the full proof of the right theorem—which was previously decapitated and lost as context—and even though 2 of the 4 chunks it retrieves do not contain relevant context, the final answer is significantly more clear, detailed, and precise because the relevant chunks contain complete, semantically-coherent subsections of the original source document.

瞧！检索器如今已成功检索到正确定理的完整证明——而此前该证明曾被截断、作为上下文丢失——尽管它所检索的 4 个文本块中有 2 个并不包含相关上下文，但最终答案却显著更加清晰、详尽且精确，这是因为相关文本块包含了原始源文档中完整、语义连贯的子章节。

### Q+A with Structured Chunking and Self-querying [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Q+A-with-Structured-Chunking-and-Self-querying)

### 使用结构化分块与自查询的问答系统 [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Q+A-with-Structured-Chunking-and-Self-querying)

Now it's time to implement [self-querying](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/?ref=blog.langchain.com). It should be noted that there's a good deal of uncharted territory in the area of query construction, and the following approach should be taken in the spirit of exploration rather than as be-all-end-all advice for working with self-querying retrievers.

现在是时候实现[自查询（self-querying）](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/?ref=blog.langchain.com)了。需要指出的是，查询构建领域尚有许多未被充分探索的空间；以下方法应被视为一种探索性尝试，而非适用于所有自查询检索器的终极指导原则。

The first step is to create descriptions for the document and each of the metadata fields. This can be done programmatically with a combination of hard-coded and LLM-generated text. The (LLM-powered) query constructor will use these descriptions as context to generate filters specific to the vectorstore, so it's helpful to specify valid comparators and operators within the field descriptions.

第一步是为文档本身及每个元数据字段分别创建描述性说明。这可通过硬编码文本与大语言模型（LLM）生成文本相结合的方式程序化完成。基于 LLM 的查询构造器将利用这些描述作为上下文，生成适配向量数据库（vectorstore）的过滤条件；因此，在字段描述中明确列出该字段支持的有效比较符（comparators）和操作符（operators）会非常有帮助。

In \[85\]:

在 \[85\] 中：

```
document_content_description = "a section of an encyclopedia article about a philosopher"

document_content_description = "一篇关于某位哲学家的百科全书文章的某个章节"

def generate_metadata_desc(field_name: str, header_info: List[tuple], qa_retriever: RetrievalQA) -> str:
def generate_metadata_desc(field_name: str, header_info: List[tuple], qa_retriever: RetrievalQA) -> str:
    query = f"""
    given a list of tuples indicating all possible metadata fields for this article
    provide a very brief description (15 words or less) of the specified field
    including its position in the hierarchy of headers (h1, h2, h3, etc)

    all fields {header_info}
    specified field: {field_name}
    """
    query = f"""
    给定一个元组列表，其中列出了本文档所有可能的元数据字段；
    请用极简语言（不超过 15 个词）描述指定字段，
    并注明其在标题层级结构（h1、h2、h3 等）中的位置。

    所有字段：{header_info}
    指定字段：{field_name}
    """

```python
    return qa_retriever({"query": query})["result"]
```

```python
def build_metadata_field_info(schema: Dict, header_info: List[tuple], qa_retriever: RetrievalQA) -> List[AttributeInfo]:
    filter_instructions = \
        "ALWAYS filter with one or more CONTAINS comparators, and use the OR operator to check ALL other fields."\
        "if the value of this field contains a word or phrase that is very similar to a word or phrase in the query, " \
        "filter for the exact string from the value rather than the query."
    filter_h1 = \
        "this field contains the name of a philosopher. "\
        "if the query contains a misspelling or an alternate spelling of this name, "\
        "filter for the value of this field rather than the name in the query."\
        "the h1-level filter should ALWAYS be combined with subsection filters using an AND operator. \n"
    filter_exclusion = \
        " NEVER filter this field on the value of 'article_h1_main'."
    attr_info_list = []
    for field in schema["text"]:
        desc = generate_metadata_desc(field["name"], header_info, qa_retriever) + filter_instructions
        if field["name"] == "article_h1_main":
            new_attr = AttributeInfo(
                name=field["name"],
                description = filter_h1 + desc,
                type="string"
            )
        else:
            new_attr = AttributeInfo(
                name=field["name"],
                description = desc + filter_exclusion,
                type="string"
            )
        attr_info_list.append(new_attr)
    return attr_info_list

metadata_field_info = build_metadata_field_info(index_schema, headers_to_split_on, retriever)
```

接下来，我们将为查询构造器（query constructor）准备若干示例（few-shot examples）。这些示例将针对我们的具体数据定制。此处需重点强调的一项指令是：在构建用于字符串匹配的过滤条件时，**查询中出现的拼写错误、变体拼写、表述不精确等情况，应被视为与元数据中已有的“标准形式”（canonical strings）等价**。例如，若用户查询为 “what was goodel's continuum theory?”（“goodel 的连续统理论是什么？”），则查询构造器应能识别出：应在 `article_h1_main` 字段中对 **"Kurt Gödel"** 进行过滤，在其他元数据字段中对 **"Continuum Hypothesis"**（连续统假设）进行过滤——因为这些正是元数据中实际存在的精确字符串，且可被视作与查询中的 “goodel” 和 “continuum theory” 等价。

在 \[86\] 中：

```python
# 示例查询包含拼写错误 / 表述不精确的短语
# 示例过滤条件使用元数据值中的拼写 / 表述，而非查询中的原始表述
examples = [\
    (\
        "what does russell say about descriptors?",\
        {"query": "russell, descriptors",\
         "filter": 'and(contain("article_h1_main", "Bertrand Russell"), or(contain("article_h2_subsection", "descriptions"), '\
                   'contain("article_h3_subsection", "descriptions"), contain("article_h4_subsection", "descriptions")))'}\
    ),\
    (\
        "explain leibniz's idea of sufficient reason.",\
        {"query": "leibniz, idea of sufficient reason",\
         "filter": 'and(contain("article_h1_main", "Gottfried Wilhelm Leibniz"), or(contain("article_h2_subsection", "Principle of Sufficient Reason"), '\
                   'contain("article_h3_subsection", "Principle of Sufficient Reason"), contain("article_h4_subsection", "Principle of Sufficient Reason")))'}\
    ),\
    (\
        "what was goodel's continuum theory?",\
        {"query": "goodel, continuum theory",\
         "filter": 'and(contain("article_h1_main", "Kurt Gödel"), or(contain("article_h2_subsection", "Continuum Hypothesis"), '\
                   'contain("article_h3_subsection", "Continuum Hypothesis"), contain("article_h4_subsection", "Continuum Hypothesis")))'}\
    ),\
]
```

现在，让我们查看为查询构造器生成的完整提示词（prompt）：

在 \[87\] 中：

```python
prompt = get_query_constructor_prompt(
    document_content_description,
    metadata_field_info,
    examples=examples
)
print(prompt.format(query="{query}"))
```

```
您的目标是将用户的查询结构化，使其符合下方提供的请求模式（request schema）。
```

<< Structured Request Schema >>
<< 结构化请求模式 >>

When responding use a markdown code snippet with a JSON object formatted in the following schema:

响应时，请使用 Markdown 代码块，以如下结构的 JSON 对象格式输出：

```json
{
    "query": string \ text string to compare to document contents
    "filter": string \ logical condition statement for filtering documents
}
```

```json
{
    "query": 字符串 \ 用于与文档内容进行匹配的文本字符串
    "filter": 字符串 \ 用于过滤文档的逻辑条件语句
}
```

The query string should contain only text that is expected to match the contents of documents. Any conditions in the filter should not be mentioned in the query as well.

查询字符串应仅包含预期能与文档内容匹配的纯文本。过滤条件中涉及的所有内容均不得重复出现在查询字符串中。

A logical condition statement is composed of one or more comparison and logical operation statements.

逻辑条件语句由一个或多个比较语句和逻辑运算语句组成。

A comparison statement takes the form: `comp(attr, val)`:
- `comp` (eq | ne | gt | gte | lt | lte | contain | like | in | nin): comparator
- `attr` (string):  name of attribute to apply the comparison to
- `val` (string): is the comparison value

比较语句形式为：`comp(attr, val)`：
- `comp`（eq｜ne｜gt｜gte｜lt｜lte｜contain｜like｜in｜nin）：比较操作符
- `attr`（字符串）：待应用比较操作的属性名称
- `val`（字符串）：比较值

A logical operation statement takes the form `op(statement1, statement2, ...)`:
- `op` (and | or | not): logical operator
- `statement1`, `statement2`, ... (comparison statements or logical operation statements): one or more statements to apply the operation to

逻辑运算语句形式为：`op(statement1, statement2, ...)`：
- `op`（and｜or｜not）：逻辑操作符
- `statement1`、`statement2` …（比较语句或逻辑运算语句）：需应用该逻辑操作的一个或多个语句

Make sure that you only use the comparators and logical operators listed above and no others.

请确保仅使用上述列出的比较操作符和逻辑操作符，不可使用其他任何操作符。

Make sure that filters only refer to attributes that exist in the data source.

请确保过滤器中引用的属性全部存在于数据源中。

Make sure that filters only use the attributed names with its function names if there are functions applied on them.

若对某属性应用了函数（如大小写转换、分词等），则过滤器中必须使用该属性与其对应函数组合后的名称（本规范中未定义函数，故此处指严格按数据源所列属性名书写，不添加、不省略、不变形）。

Make sure that filters only use format `YYYY-MM-DD` when handling timestamp data typed values.

当处理时间戳类型值时，请确保过滤器中统一采用 `YYYY-MM-DD` 格式。

Make sure that filters take into account the descriptions of attributes and only make comparisons that are feasible given the type of data being stored.

请确保过滤器充分参考各属性的描述信息，并仅执行与所存储数据类型相容的比较操作（例如：不可对字符串类型属性使用数值比较操作符 `gt`）。

Make sure that filters are only used as needed. If there are no filters that should be applied return "NO_FILTER" for the filter value.

请确保仅在必要时才使用过滤器。若无需任何过滤条件，则 `filter` 字段值应设为 `"NO_FILTER"`。

<< Data Source >>
<< 数据源 >>

```json
{
    "content": "a section of an encyclopedia article about a philosopher",
    "attributes": {
    "article_h1_main": {
        "description": "this field contains the name of a philosopher. if the query contains a misspelling or an alternate spelling of this name, filter for the value of this field rather than the name in the query.the h1-level filter should ALWAYS be combined with subsection filters using an AND operator. \nThe 'article_h1_main' is the main title of the article, positioned at the highest level in the header hierarchy.ALWAYS filter with one or more CONTAINS comparators, and use the OR operator to check ALL other fields.if the value of this field contains a word or phrase that is very similar to a word or phrase in the query, filter for the exact string from the value rather than the query.",
        "type": "string"
    },
    "article_h2_subsection": {
        "description": "The 'article_h2_subsection' field represents the secondary headers or subsections within the main article content.ALWAYS filter with one or more CONTAINS comparators, and use the OR operator to check ALL other fields.if the value of this field contains a word or phrase that is very similar to a word or phrase in the query, filter for the exact string from the value rather than the query. NEVER filter this field on the value of 'article_h1_main'.",
        "type": "string"
    },
    "article_h3_subsection": {
        "description": "The 'article_h3_subsection' field represents the third level headers in the article, under the main and secondary headers.ALWAYS filter with one or more CONTAINS comparators, and use the OR operator to check ALL other fields.if the value of this field contains a word or phrase that is very similar to a word or phrase in the query, filter for the exact string from the value rather than the query. NEVER filter this field on the value of 'article_h1_main'.",
        "type": "string"
    },
    "article_h4_subsection": {
        "description": "The 'article_h4_subsection' field represents the fourth level headers in the article, under h1, h2, and h3 headers.ALWAYS filter with one or more CONTAINS comparators, and use the OR operator to check ALL other fields.if the value of this field contains a word or phrase that is very similar to a word or phrase in the query, filter for the exact string from the value rather than the query. NEVER filter this field on the value of 'article_h1_main'.",
        "type": "string"
    }
}
}
```

```json
{
    "content": "一篇关于某位哲学家的百科全书条目节选",
    "attributes": {
        "article_h1_main": {
            "description": "该字段包含哲学家的姓名。若查询中存在该姓名的拼写错误或别名变体，应基于此字段的实际取值（而非查询中的拼写）进行过滤。h1 级别的过滤条件必须始终通过 AND 操作符与子章节过滤条件组合使用。\n'article_h1_main' 是条目的主标题，位于标题层级结构的最高级别。必须始终使用一个或多个 CONTAINS 比较操作符进行过滤，并使用 OR 操作符对所有其他字段（如 h2/h3/h4）执行并行检查。若该字段的值中包含与查询中某个词或短语高度相似的词或短语，则应以该字段值中的确切字符串作为过滤目标，而非直接使用查询中的原始字符串。",
            "type": "字符串"
        },
        "article_h2_subsection": {
            "description": "'article_h2_subsection' 字段表示主条目内容内的二级标题或子章节。必须始终使用一个或多个 CONTAINS 比较操作符进行过滤，并使用 OR 操作符对所有其他字段执行并行检查。若该字段的值中包含与查询中某个词或短语高度相似的词或短语，则应以该字段值中的确切字符串作为过滤目标，而非直接使用查询中的原始字符串。严禁基于 'article_h1_main' 的值对此字段进行过滤。",
            "type": "字符串"
        },
        "article_h3_subsection": {
            "description": "'article_h3_subsection' 字段表示文章中位于主标题和二级标题之下的三级标题。必须始终使用一个或多个 CONTAINS 比较操作符进行过滤，并使用 OR 操作符对所有其他字段执行并行检查。若该字段的值中包含与查询中某个词或短语高度相似的词或短语，则应以该字段值中的确切字符串作为过滤目标，而非直接使用查询中的原始字符串。严禁基于 'article_h1_main' 的值对此字段进行过滤。",
            "type": "字符串"
        },
        "article_h4_subsection": {
            "description": "'article_h4_subsection' 字段表示文章中位于 h1、h2 和 h3 标题之下的四级标题。必须始终使用一个或多个 CONTAINS 比较操作符进行过滤，并使用 OR 操作符对所有其他字段执行并行检查。若该字段的值中包含与查询中某个词或短语高度相似的词或短语，则应以该字段值中的确切字符串作为过滤目标，而非直接使用查询中的原始字符串。严禁基于 'article_h1_main' 的值对此字段进行过滤。",
            "type": "字符串"
        }
    }
}
```

<< Example 1. >>
<< 示例 1 >>

User Query:
what does russell say about descriptors?

用户查询：
罗素对限定摹状词（descriptors）有何论述？

Structured Request:
```json
{
    "query": "russell, descriptors",
    "filter": "and(contain(\"article_h1_main\", \"Bertrand Russell\"), or(contain(\"article_h2_subsection\", \"descriptions\"), contain(\"article_h3_subsection\", \"descriptions\"), contain(\"article_h4_subsection\", \"descriptions\")))"
}
```

结构化请求：
```json
{
    "query": "russell, descriptors",
    "filter": "and(contain(\"article_h1_main\", \"Bertrand Russell\"), or(contain(\"article_h2_subsection\", \"descriptions\"), contain(\"article_h3_subsection\", \"descriptions\"), contain(\"article_h4_subsection\", \"descriptions\")))"
}
```

<< Example 2. >>

<< 示例 2。>>

User Query:  
explain leibniz's idea of sufficient reason.

用户查询：  
解释莱布尼茨的“充足理由律”。

Structured Request:  
```json
{
    "query": "leibniz, idea of sufficient reason",
    "filter": "and(contain(\"article_h1_main\", \"Gottfried Wilhelm Leibniz\"), or(contain(\"article_h2_subsection\", \"Principle of Sufficient Reason\"), contain(\"article_h3_subsection\", \"Principle of Sufficient Reason\"), contain(\"article_h4_subsection\", \"Principle of Sufficient Reason\")))"
}
```

结构化请求：  
```json
{
    "query": "leibniz, idea of sufficient reason",
    "filter": "and(contain(\"article_h1_main\", \"Gottfried Wilhelm Leibniz\"), or(contain(\"article_h2_subsection\", \"Principle of Sufficient Reason\"), contain(\"article_h3_subsection\", \"Principle of Sufficient Reason\"), contain(\"article_h4_subsection\", \"Principle of Sufficient Reason\")))"
}
```

<< Example 3. >>

<< 示例 3。>>

User Query:  
what was goodel's continuum theory?

用户查询：  
哥德尔的连续统理论是什么？

Structured Request:  
```json
{
    "query": "goodel, continuum theory",
    "filter": "and(contain(\"article_h1_main\", \"Kurt G\u00f6del\"), or(contain(\"article_h2_subsection\", \"Continuum Hypothesis\"), contain(\"article_h3_subsection\", \"Continuum Hypothesis\"), contain(\"article_h4_subsection\", \"Continuum Hypothesis\")))"
}
```

结构化请求：  
```json
{
    "query": "goodel, continuum theory",
    "filter": "and(contain(\"article_h1_main\", \"Kurt G\u00f6del\"), or(contain(\"article_h2_subsection\", \"Continuum Hypothesis\"), contain(\"article_h3_subsection\", \"Continuum Hypothesis\"), contain(\"article_h4_subsection\", \"Continuum Hypothesis\")))"
}
```

<< Example 4. >>

<< 示例 4。>>

User Query:  
{query}

用户查询：  
{query}

Structured Request:  
````

结构化请求：  
````

The query constructor can now be built as a runnable chain. Mindful of the relatively high token count of our prompt, we can use gpt-3.5-turbo (rather than gpt-4) for the model in this component.

查询构造器现在可构建为一个可运行的链式组件。考虑到当前提示（prompt）的 token 数量相对较高，我们可在该组件中选用 `gpt-3.5-turbo`（而非 `gpt-4`）作为基础模型。

(Note that, depending on the data, gpt-3.5-turbo may require additional examples to construct queries as reliably as gpt-4 and to handle edge cases.)

（请注意：根据具体数据情况，`gpt-3.5-turbo` 可能需要额外示例，才能像 `gpt-4` 那样稳定地构造查询，并妥善处理边界情况。）

In \[83\]:

在 \[83\] 中：

```
chain = load_query_constructor_runnable(
    llm=ChatOpenAI(
        model="gpt-3.5-turbo",
        temperature=0
    ),
    attribute_info=metadata_field_info,
    document_contents=document_content_description,
    examples=examples,
    fix_invalid=True
)
```

To check that the constructor will correctly build filters for strings/substrings that match metadata values rather than the original query, lets try alternate spellings of equivalent words:

为验证构造器能否正确构建过滤器，使其匹配元数据字段值（而非原始查询中的字符串/子字符串），我们尝试使用含义相同但拼写不同的词语：

```
query = "explain goedel's 1st incompleteness theory"
chain.invoke(({"query": query}))
```

```
query = "explain goedel's 1st incompleteness theory"
chain.invoke(({"query": query}))
```

```
StructuredQuery(query='goedel, 1st incompleteness theory', filter=Operation(operator=, arguments=[Comparison(comparator=, attribute='article_h1_main', value='Kurt Gödel'), Operation(operator=, arguments=[Comparison(comparator=, attribute='article_h2_subsection', value='First Incompleteness Theorem'), Comparison(comparator=, attribute='article_h3_subsection', value='First Incompleteness Theorem'), Comparison(comparator=, attribute='article_h4_subsection', value='First Incompleteness Theorem')])]), limit=None)
```

```
StructuredQuery(query='goedel, 1st incompleteness theory', filter=Operation(operator=, arguments=[Comparison(comparator=, attribute='article_h1_main', value='Kurt Gödel'), Operation(operator=, arguments=[Comparison(comparator=, attribute='article_h2_subsection', value='First Incompleteness Theorem'), Comparison(comparator=, attribute='article_h3_subsection', value='First Incompleteness Theorem'), Comparison(comparator=, attribute='article_h4_subsection', value='First Incompleteness Theorem')])]), limit=None)
```

Success! It appears that the query constructor chain can output valid, well-formed queries to execute on our vector database. This query should return documents where the value for the metadata field "article\_h1\_main" contains "Kurt Gödel" and the value for any other metadata field contains "First Incompleteness Theorem."

成功！看来查询构造器链能够输出合法、结构良好的查询，供我们在向量数据库中执行。该查询应返回满足以下条件的文档：元数据字段 `article_h1_main` 的值包含 “Kurt Gödel”，且任意其他元数据字段（如 `article_h2_subsection`、`article_h3_subsection` 或 `article_h4_subsection`）的值包含 “First Incompleteness Theorem”。

Now we can put everything together into a single Q+A retrieval chain.

现在，我们可以将所有组件整合为一个端到端的问答检索链（Q&A Retrieval Chain）。

In \[80\]:

In \[80\]：

```
sq_retriever = SelfQueryRetriever(
    query_constructor=chain,
    vectorstore=vectorstore,
    verbose=True,
)
sq_qa = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=sq_retriever,
    return_source_documents=True
)
```

```
sq_retriever = SelfQueryRetriever(
    query_constructor=chain,
    vectorstore=vectorstore,
    verbose=True,
)
sq_qa = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=sq_retriever,
    return_source_documents=True
)
```

In \[90\]:

In \[90\]：

```
response = sq_qa({"query": query})
print_result(response)
```

```
response = sq_qa({"query": query})
print_result(response)
```

```
SOURCES:
```

```
SOURCES：
```

# Chunk #1

# 第1段

Source Metadata:  {'id': 'doc:c39d409b58e3444691ad91c34b5c3ee1:6c1de40a549245b7a6c3d56b7dda8da4', 'article_h1_main': 'Kurt Gödel', 'article_h2_subsection': '2. Gödel’s Mathematical Work', 'article_h3_subsection': '2.2 The Incompleteness Theorems', 'article_h4_subsection': '2.2.1 The First Incompleteness Theorem'}  
源元数据：{'id': 'doc:c39d409b58e3444691ad91c34b5c3ee1:6c1de40a549245b7a6c3d56b7dda8da4', 'article_h1_main': '库尔特·哥德尔', 'article_h2_subsection': '2. 哥德尔的数学工作', 'article_h3_subsection': '2.2 不完备性定理', 'article_h4_subsection': '2.2.1 第一不完备性定理'}

Source Text:  
源文本：  
In his Logical Journey (Wang 1996) Hao Wang published the full text of material Gödel had written (at Wang’s request) about his discovery of the incompleteness theorems. This material had formed the basis of Wang’s “Some Facts about Kurt Gödel,” and was read and approved by Gödel:  
在《逻辑之旅》（王浩，1996）中，王浩全文发表了哥德尔应其请求所撰写的、关于其发现不完备性定理的手稿。这部分材料构成了王浩《关于库尔特·哥德尔的一些事实》一文的基础，并经哥德尔本人审阅并认可：

In the summer of 1930 I began to study the consistency problem of classical analysis. It is mysterious why Hilbert wanted to prove directly the consistency of analysis by finitary methods. I saw two distinguishable problems: to prove the consistency of number theory by finitary number theory and to prove the consistency of analysis by number theory … Since the domain of finitary number theory was not well-defined, I began by tackling the second half… I represented real numbers by predicates in number theory… and found that I had to use the concept of truth (for number theory) to verify the axioms of analysis. By an enumeration of symbols, sentences and proofs within the given system, I quickly discovered that the concept of arithmetic truth cannot be defined in arithmetic. If it were possible to define truth in the system itself, we would have something like the liar paradox, showing the system to be inconsistent… Note that this argument can be formalized to show the existence of undecidable propositions without giving any individual instances. (If there were no undecidable propositions, all (and only) true propositions would be provable within the system. But then we would have a contradiction.)… In contrast to truth, provability in a given formal system is an explicit combinatorial property of certain sentences of the system, which is formally specifiable by suitable elementary means…  
“1930年夏，我开始研究经典分析的一致性问题。希尔伯特为何执意要用有穷方法直接证明分析学的一致性，这令人费解。我当时看出两个可区分的问题：一是用有穷数论证明数论本身的一致性；二是用数论证明分析学的一致性……由于有穷数论的范围尚未明确定义，我便先着手解决后一个问题……我用数论中的谓词来表示实数……结果发现，要验证分析学的公理，我不得不诉诸‘真’这一概念（就数论而言）。通过对给定系统内符号、语句与证明的枚举，我很快意识到：算术真理性这一概念无法在算术内部被定义。倘若能在系统内部定义‘真’，我们便会陷入类似说谎者悖论（‘这句话是假的’）的情形，从而表明该系统不一致……需注意，这一论证可被形式化，以证明不可判定命题的存在性，而无需给出任何具体实例。（倘若根本不存在不可判定命题，则所有（且仅所有）真命题都可在系统内被证明；但那样就会导致矛盾。）……与‘真’不同，一个给定形式系统内的‘可证性’是该系统某些语句的一种明确的组合性质，可通过适当的初等手段予以形式刻画……”

We see that Gödel first tried to reduce the consistency problem for analysis to that of arithmetic. This seemed to require a truth definition for arithmetic, which in turn led to paradoxes, such as the Liar paradox (“This sentence is false”) and Berry’s paradox (“The least number not defined by an expression consisting of just fourteen English words”). Gödel then noticed that such paradoxes would not necessarily arise if truth were replaced by provability. But this means that arithmetic truth and arithmetic provability are not co-extensive — whence the First Incompleteness Theorem.  
由此可见，哥德尔最初试图将分析学的一致性问题归约为数论的一致性问题。而这似乎又要求为数论建立一个‘真’的定义；该定义反过来却引出了诸如说谎者悖论（“这句话是假的”）和贝里悖论（“不能用恰好十四个英文单词定义的最小正整数”）等悖论。哥德尔随后意识到：若以‘可证性’取代‘真’，此类悖论未必会出现。但这恰恰意味着：算术真理性与算术可证性并不重合——第一不完备性定理由此诞生。

This account of Gödel’s discovery was told to Hao Wang very much after the fact; but in Gödel’s contemporary correspondence with Bernays and Zermelo, essentially the same description of his path to the theorems is given. (See Gödel 2003a and Gödel 2003b respectively.) From those accounts we see that the undefinability of truth in arithmetic, a result credited to Tarski, was likely obtained in some form by Gödel by 1931. But he neither publicized nor published the result; the biases logicians had expressed at the time concerning the notion of truth, biases which came vehemently to the fore when Tarski announced his results on the undefinability of truth in formal systems 1935, may have served as a deterrent to Gödel’s publication of that theorem.  
这一关于哥德尔发现过程的叙述，是在事件发生很久之后才向王浩讲述的；但在哥德尔与伯奈斯及策梅洛的同期通信中，对其通向这些定理的思想路径，给出了本质上相同的描述。（参见Gödel 2003a与Gödel 2003b。）从这些通信中我们可见：算术中‘真’之不可定义性这一成果（通常归功于塔斯基），哥德尔很可能早在1931年就已以某种形式获得。但他既未公开宣扬，也未发表这一结果；当时逻辑学家对‘真’这一概念所持的偏见——当塔斯基于1935年宣布其关于形式系统中‘真’之不可定义性的成果时，这些偏见曾激烈地浮出水面——或许正是哥德尔未发表该定理的重要原因。

# Chunk #2

# 第2段

Source Metadata:  {'id': 'doc:c39d409b58e3444691ad91c34b5c3ee1:65d27ea51ab0470e82b59678ccf471ce', 'article_h1_main': 'Kurt Gödel', 'article_h2_subsection': '2. Gödel’s Mathematical Work', 'article_h3_subsection': '2.2 The Incompleteness Theorems', 'article_h4_subsection': '2.2.2 The proof of the First Incompleteness Theorem'}  
源元数据：{'id': 'doc:c39d409b58e3444691ad91c34b5c3ee1:65d27ea51ab0470e82b59678ccf471ce', 'article_h1_main': '库尔特·哥德尔', 'article_h2_subsection': '2. 哥德尔的数学工作', 'article_h3_subsection': '2.2 不完备性定理', 'article_h4_subsection': '2.2.2 第一不完备性定理的证明'}

Source Text:  
源文本：  
We now describe the proof of the two theorems, formulating Gödel’s results in Peano arithmetic. Gödel himself used a system related to that defined in Principia Mathematica, but containing Peano arithmetic. In our presentation of the First and Second Incompleteness Theorems we refer to Peano arithmetic as P, following Gödel’s notation.  
我们现在阐述这两个定理的证明，并将哥德尔的结果表述于皮亚诺算术框架之内。哥德尔本人使用的是一个与《数学原理》中所定义系统相关、但包含皮亚诺算术的系统。在本文对第一与第二不完备性定理的陈述中，我们沿用哥德尔的记号，将皮亚诺算术简记为P。

Before proceeding to the details of the formal proof, we define the notion of ω-consistency used by Gödel in the First Incompleteness Theorem: P is ω-consistent if P ⊢ ¬φ(n) for all n implies P ⊬ ∃xφ(x). Naturally this implies consistency and follows from the assumption that the natural numbers satisfy the axioms of Peano arithmetic.  
在进入形式化证明的细节之前，我们先定义哥德尔在第一不完备性定理中所采用的ω-一致性概念：若对所有自然数n均有P ⊢ ¬φ(n)，则P ⊬ ∃xφ(x)，此时称P是ω-一致的。显然，ω-一致性蕴含通常的一致性，且它可由“自然数满足皮亚诺算术公理”这一假设推出。

One of the main technical tools used in the proof is Gödel numbering, a mechanism which assigns natural numbers to terms and formulas of our formal theory P. There are different ways of doing this. The most common is based on the unique representation of natural numbers as products of powers of primes. Each symbol s of number theory is assigned a positive natural number #(s) in a fixed but arbitrary way, e.g.  
证明中一项主要技术工具是哥德尔编码（Gödel numbering），即为形式理论P中的项与公式指派自然数。实现方式有多种，最常见的一种基于自然数的素因子幂次唯一分解定理。数论中每个符号s均以固定但任意的方式被赋予一个正整数#(s)，例如：

#(0) = 1 #(=) = 5 #(¬) = 9 #(1) = 2 #( ( ) = 6 #(∀) = 10 #(+) = 3 #( ) ) = 7 #(vi) = 11 + i #(×) = 4 #(∧) = 8  
#(0) = 1　　#(=) = 5　　#(¬) = 9　　#(1) = 2　　#( ( ) = 6　　#(∀) = 10　　#(+) = 3　　#( ) ) = 7　　#(vi) = 11 + i　　#(×) = 4　　#(∧) = 8  

The natural number corresponding to a sequence w = < w0,…, wk > of symbols is  
⌈w⌉ = 2#(w0) · 3#(w1) · … · pk#(wk),  
where pk is the k+1st prime. It is called its Gödel number and denoted by ⌈w⌉. In this way we can assign Gödel numbers to formulas, sequences of formulas (once a method for distinguishing when one formula ends and another begins has been adopted), and most notably, proofs.  
符号序列w = < w₀, …, wₖ > 所对应的自然数为  
⌈w⌉ = 2<sup>#(w₀)</sup> · 3<sup>#(w₁)</sup> · … · pₖ<sup>#(wₖ)</sup>，  
其中pₖ为第(k+1)个素数。此数称为w的哥德尔数，记作⌈w⌉。借此方式，我们可为公式、公式序列（一旦确立了区分一个公式何时结束、另一个公式何时开始的方法）、尤其是证明，一一指派哥德尔数。

An essential point here is that when a formula is construed as a natural number, then the numeral corresponding to that natural number can occur as the argument of a formula, thus enabling the syntax to “refer” to itself, so to speak (i.e., when a numeral is substituted into a formula the Gödel number of which the numeral represents). This will eventually allow Gödel to formalize the Liar paradox (with “provability” in place of “truth”) by substituting into the formula which says, ‘the formula, whose code is x, is unprovable,’ its own natural number code (or more precisely the corresponding numeral).  
此处一个关键要点在于：当一个公式被视作一个自然数时，该自然数所对应的数字符号（numeral）便可作为另一公式的参数出现，从而使语法得以“自指”——换言之，当一个数字符号被代入某公式时，该符号所代表的恰是该公式的哥德尔数。这最终使哥德尔得以形式化说谎者悖论（以“可证性”替代“真”）：他将“代码为x的公式不可证”这一公式自身的自然数编码（或更准确地说，其对应的数字符号）代入该公式自身。

Another concept required to carry out the formalization is the concept of numeralwise expressibility of number theoretic predicates. A number-theoretic formula φ(n₁, …, nₖ) is numeralwise expressible in P if for each tuple of natural numbers (n₁, …, nₖ):  
N ⊨ φ(n₁, …, nₖ) ⇒ P ⊢ φ(n₁, …, nₖ)  
N ⊨ ¬φ(n₁, …, nₖ) ⇒ P ⊢ ¬φ(n₁, …, nₖ)  
where n is the formal term which denotes the natural number n. (In P, this is S(S(…S(0)…), where n is the number of iterations of the successor function applied to the constant symbol 0.) One of the principal goals is to numeralwise express the predicate  
Prf(x, y): ‘the sequence with Gödel number x is a proof of the sentence with Gödel number y.’  
Reaching this goal involves defining forty-five relations, each defined in terms of the preceding ones. These relations are all primitive recursive.[10] Relations needed are, among others, those which assert of a natural number that it codes a sequence, or a formula, or an axiom, or that it is the code, denoted by Sb(ru₁…uₙZ(x₁)…Z(xₙ)), of a formula obtained from a formula with code r by substituting for its free variable uᵢ the xᵢ th numeral for i = 1, …, n. The forty-fifth primitive recursive relation defined is Prf(x, y), and the forty-sixth is  
Prov(y): ‘the sentence with Gödel number y is provable in P’  
which without being primitive recursive, is however obtained from Prf(x, y) by existentially quantifying x. (Prov(y) satisfies only the ‘positive’ part of numeralwise expressibility, and not the negative part; but the negative part is not needed.)  
为完成形式化，还需引入“数论谓词的逐数可表达性（numeralwise expressibility）”这一概念。一个数论公式φ(n₁, …, nₖ)在P中逐数可表达，是指对每一组自然数(n₁, …, nₖ)，均有：  
N ⊨ φ(n₁, …, nₖ) ⇒ P ⊢ φ(n₁, …, nₖ)  
N ⊨ ¬φ(n₁, …, nₖ) ⇒ P ⊢ ¬φ(n₁, …, nₖ)  
其中n是表示自然数n的形式项。（在P中，即S(S(…S(0)…)，其中S作用于常元符号0共n次。）首要目标之一，便是使如下谓词在P中逐数可表达：  
Prf(x, y)：“哥德尔数为x的序列，是哥德尔数为y的句子的一个证明。”  
达成此目标需定义四十五个关系，每个关系均以前面的关系为基础加以定义。这些关系全都是原始递归的。[10] 所需关系包括但不限于：断言某个自然数编码了一个序列、一个公式、一条公理；或断言某个自然数是Sb(ru₁…uₙZ(x₁)…Z(xₙ))所表示的编码——该编码对应这样一个公式：它由哥德尔数为r的公式出发，将其第i个自由变元uᵢ替换为第xᵢ个数字符号（i = 1, …, n）而得到。第四十五个被定义的原始递归关系即为Prf(x, y)，而第四十六个则是：  
Prov(y)：“哥德尔数为y的句子在P中是可证的。”  
该关系虽非原始递归，却可通过在Prf(x, y)上对x作存在量词化而得到。（Prov(y)仅满足逐数可表达性的“肯定部分”，而不满足“否定部分”；但否定部分在此处并非必需。）

In Theorem V of his paper, Gödel proves that any number theoretic predicate which is primitive recursive is numeralwise expressible in P. Thus since Prf(x, y) and substitution are primitive recursive, these are decided by P when closed terms are substituted for the free variables x and y. This is the heart of the matter as we will see. Another key point about numeralwise expressibility is that although we informally interpret, for example, Prov(Sb(ru₁…uₙZ(x₁)…Z(xₙ))), by: ‘the formula with Gödel number r is provable if the Gödel number for the xᵢ th numeral is substituted in place of the i th variable,’ neither the formal statement within the theory P nor anything we prove about it appeals to such meanings. On the contrary Prov(Sb(ru₁…uₙZ(x₁)…Z(xₙ))), is a meaningless string of logical and arithmetical symbols. As Gödel puts it in his introduction to his theorem V, ‘The fact that can be formulated vaguely by saying that every recursive relation is definable in the system P (if the usual meaning is given to the formulas of this system) is expressed in precise language, without reference to any interpretation of the formulas of P, by the following Theorem (V) (Gödel 1986, p. 171, italics Gödel’s).  
在论文的定理V中，哥德尔证明：任一原始递归的数论谓词均在P中逐数可表达。因此，由于Prf(x, y)与代入操作均为原始递归，故当闭项代入自由变元x与y时，P即可判定其真假。这正是问题的核心所在，后文将见分晓。关于逐数可表达性的另一关键点在于：尽管我们非正式地将Prov(Sb(ru₁…uₙZ(x₁)…Z(xₙ)))解释为：“若将第xᵢ个数字符号代入哥德尔数为r的公式的第i个变元，则所得公式在P中可证”，但该形式陈述本身（在理论P内部），以及我们关于它所证明的任何结论，均不依赖于此类含义。相反，Prov(Sb(ru₁…uₙZ(x₁)…Z(xₙ)))不过是一串无意义的逻辑与算术符号。正如哥德尔在其定理V引言中所指出：“人们可含糊地表述为‘每个递归关系在系统P中均可定义（若赋予该系统的公式以通常含义）’的事实，以下列定理（V）以精确语言予以表达，且完全不涉及对P中公式的任何解释。”（Gödel 1986, p. 171，斜体为哥德尔原文所加）

Gödel in his incompleteness theorems uses a method given in what is called nowadays Gödel’s Fixed Point Theorem. Although Gödel constructs a fixed point in the course of proving the incompleteness theorem, he does not state the fixed point theorem explicitly. The fixed point theorem is as follows:  
哥德尔在其不完备性定理中所运用的方法，即今日所称的“哥德尔不动点定理”。尽管哥德尔在证明不完备性定理的过程中实际构造出了一个不动点，但他并未明确陈述该不动点定理。该定理内容如下：

Theorem 2 (Gödel’s Fixed Point Theorem) If φ(v₀) is a formula of number theory, then there is a sentence ψ such that P ⊢ ψ ↔ φ(⌈ψ⌉), where ⌈ψ⌉ is the formal term corresponding to the natural number code of ⌈ψ⌉.  
定理2（哥德尔不动点定理）：若φ(v₀)是数论中的一个公式，则存在一个句子ψ，使得P ⊢ ψ ↔ φ(⌈ψ⌉)，其中⌈ψ⌉是对应于ψ之哥德尔数的数字符号。

Proof: Let σ(x,y,z) be a formula that numeralwise expresses the number theoretic predicate ‘y is the Gödel number of the formula obtained by replacing the variable v₀ in the formula whose Gödel number is x by the term z’. Let θ(v₀) be the formula ∃v₁(φ(v₁) ∧ σ(v₀, v₁, v₀)). Let k = ⌈θ(v₀)⌉ and ψ = θ(k). Now directly by the construction P ⊢ ψ ↔ φ(⌈ψ⌉).  
证明：令σ(x, y, z)为一个逐数可表达如下数论谓词的公式：“y是将哥德尔数为x的公式中变元v₀替换为项z后所得公式的哥德尔数”。令θ(v₀)为公式∃v₁(φ(v₁) ∧ σ(v₀, v₁, v₀))。令k = ⌈θ(v₀)⌉，ψ = θ(k)。由构造过程直接可得P ⊢ ψ ↔ φ(⌈ψ⌉)。

A sentence is refutable from a theory if its negation is provable. The First Incompleteness Theorem as Gödel stated it is as follows:  
若一个句子的否定式在某理论中可证，则称该句子可被该理论证伪（refutable）。哥德尔所陈述的第一不完备性定理如下：

Theorem 3 (Gödel’s First Incompleteness Theorem) If P is ω-consistent, then there is a sentence which is neither provable nor refutable from P.  
定理3（哥德尔第一不完备性定理）：若P是ω-一致的，则存在一个句子，它在P中既不可证，亦不可证伪。

Proof: By judicious coding of syntax referred to above, write a formula Prf(x,y)[11] of number theory, representable in P, so that  
n codes a proof of φ ⇒ P ⊢ Prf(n, ⌈φ⌉).  
and  
n does not code a proof of φ ⇒ P ⊢ ¬Prf(n, ⌈φ⌉).  
Let Prov(y) denote the formula ∃x Prf(x,y)[12]. By Theorem 2 there is a sentence φ with the property  
P ⊢ (φ ↔ ¬Prov(⌈φ⌉)).  
Thus φ says ‘I am not provable.’ We now observe, if P ⊢ φ, then by (1) there is n such that P ⊢ Prf(n, ⌈φ⌉), hence P ⊢ Prov(⌈φ⌉), hence, by (3) P ⊢ ¬φ, so P is inconsistent. Thus  
P ⊬ φ  
Furthermore, by (4) and (2), we have P ⊢ ¬Prf(n, ⌈φ⌉) for all natural numbers n. By ω-consistency P ⊬ ∃x Prf(x, ⌈φ⌉). Thus (3) gives P ⊬ ¬φ. We have shown that if P is ω-consistent, then φ is independent of P.  
证明：通过上述精巧的句法编码，写出一个数论公式Prf(x, y)[11]，它在P中可表示，且满足：  
n编码了φ的一个证明 ⇒ P ⊢ Prf(n, ⌈φ⌉)；  
n未编码φ的任何证明 ⇒ P ⊢ ¬Prf(n, ⌈φ⌉)。  
令Prov(y)表示公式∃x Prf(x, y)[12]。根据定理2，存在一个句子φ，满足  
P ⊢ (φ ↔ ¬Prov(⌈φ⌉))。  
因此φ意即“我不可证”。现观察如下：若P ⊢ φ，则由(1)知存在某个n使得P ⊢ Prf(n, ⌈φ⌉)，从而P ⊢ Prov(⌈φ⌉)，再由(3)得P ⊢ ¬φ，故P不一致。因此  
P ⊬ φ。  
此外，由(4)与(2)可知，对所有自然数n均有P ⊢ ¬Prf(n, ⌈φ⌉)。由ω-一致性，P ⊬ ∃x Prf(x, ⌈φ⌉)。于是由(3)得P ⊬ ¬φ。综上，我们已证明：若P是ω-一致的，则φ在P中独立（即既不可证，亦不可证伪）。

On concluding the proof of the first theorem, Gödel remarks, “we can readily see that the proof just given is constructive; that is … proved in an intuitionistically unobjectionable manner…” (Gödel 1986, p. 177). This is because, as he points out, all the existential statements are based on his theorem V (giving the numeralwise expressibility of primitive recursive relations), which is intuitionistically unobjectionable.  
在第一定理证明的结尾处，哥德尔评述道：“我们很容易看出，刚才给出的证明是构造性的；也就是说……是以直觉主义上无可指摘的方式证明的……”（Gödel 1986, p. 177）。这是因为，如他所指出的，所有存在性陈述均基于其定理V（即原始递归关系的逐数可表达性），而该定理本身在直觉主义意义上是无可指摘的。

RESULT:

结果：

Gödel's First Incompleteness Theorem states that in any consistent formal system that is sufficiently expressive to include basic arithmetic, there are statements that cannot be proven or disproven within the system itself.  
哥德尔第一不完备性定理指出：在任何一致的、且足以表达基本算术的形式系统中，总存在一些命题，它们在该系统内部既不能被证明，也不能被证伪。

In other words, there are some truths that cannot be reached by the system's rules of logic. This is because, as Gödel discovered, the concept of arithmetic truth cannot be defined in arithmetic itself. If it were possible to define truth in the system itself, it would lead to paradoxes, such as the Liar paradox, showing the system to be inconsistent.  
换言之，存在某些真理，无法通过该系统的逻辑规则推导得出。这是因为，正如哥德尔所发现的，算术真理性这一概念本身无法在算术内部被定义。倘若能在系统内部定义“真”，便会引发诸如说谎者悖论之类的悖论，从而表明该系统不一致。

Gödel's proof of this theorem involves a technique known as Gödel numbering, which assigns natural numbers to terms and formulas of the formal system. This allows the syntax to "refer" to itself, enabling Gödel to formalize the Liar paradox by substituting into the formula which says, 'the formula, whose code is x, is unprovable,' its own natural number code.  
哥德尔对该定理的证明，运用了一种名为“哥德尔编码”的技术，即为形式系统中的项与公式指派自然数。这使得语法得以“自指”，从而让哥德尔能将“代码为x的公式不可证”这一公式自身的自然数编码代入其中，进而形式化说谎者悖论。

The theorem concludes that if a formal system is ω-consistent (a stronger form of consistency), then there is a sentence which is neither provable nor refutable from the system. This means that there are always statements in the system that are true, but cannot be proven within the system.  
该定理的结论是：若一个形式系统是ω-一致的（一种比通常一致性更强的条件），则必存在一个句子，在该系统中既不可证，亦不可证伪。这意味着，系统中永远存在一些为真、却无法在系统内部被证明的命题。

The self-querying retriever worked exactly as intended here, retrieving as context each of—and only—the most relevant subsections of the original document based on header text, i.e. "2.2.1 The First Incompleteness Theorem" and "2.2.2 The proof of the First Incompleteness Theorem"  
本次自查询检索器（self-querying retriever）完全按预期运行：它仅依据标题文本（即“2.2.1 第一不完备性定理”与“2.2.2 第一不完备性定理的证明”），精准地检索出原文中各自最相关的子章节作为上下文。

### Additional Examples [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Additional-Examples)  
### 其他示例 [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Additional-Examples)

Generally speaking, with use cases similar to the one presented above, I have found that implementing structured chunking with header metadata for self-querying significantly increases context precision and recall, resulting in improved text generation (and often lowering token usage for inputs).  
总体而言，对于与上述案例类似的使用场景，我发现：在自查询中实施带有标题元数据的结构化分块（structured chunking），能显著提升上下文的精确率与召回率，从而改善文本生成质量（并常常降低输入所需的token用量）。

Here are a few more examples (executed with the same code as above):

以下是更多几个示例（使用与上述相同的代码执行）：

#### Example Query \#1: "explain husserl's phenomenological reduction." [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Example-Query-%231:-%22explain-husserl's-phenomenological-reduction.%22)

#### 示例查询 \#1：“解释胡塞尔的现象学还原。”

Data source: [https://plato.stanford.edu/entries/husserl/](https://plato.stanford.edu/entries/husserl/?ref=blog.langchain.com)

数据来源：[https://plato.stanford.edu/entries/husserl/](https://plato.stanford.edu/entries/husserl/?ref=blog.langchain.com)

**Text generated with unstructured chunking:**

**采用非结构化分块生成的文本：**

Husserl's phenomenological reduction, also known as "eidetic reduction", is a method used in his phenomenological  
philosophy. This method involves focusing on the essential structures that allow objects, which are naively taken  
for granted in the "natural attitude" of everyday life and ordinary science, to "constitute themselves" in  
consciousness. It involves an unfolding of abstract features shared by appropriate sets of fictitious or real-life  
examples, often through free imaginative variation on an arbitrarily chosen initial example. This perspective on the  
realm of intentional consciousness is supposed to enable the phenomenologist to develop a radically unprejudiced  
justification of his or her basic views on the world and explore their rational interconnections.

胡塞尔的现象学还原，亦称“本质还原”（eidetic reduction），是他现象学哲学中所采用的一种方法。该方法聚焦于那些使对象得以在意识中“自我构成”的本质结构——而这些对象在日常生活的“自然态度”及普通科学中往往被不加反思地视为理所当然。这一过程通常通过对任意选定的初始范例进行自由想象变更（free imaginative variation），从而展开一组恰当的虚构或现实事例所共有的抽象特征。这种对意向性意识领域的观照，旨在使现象学家能够以一种彻底无偏见的方式，为其关于世界的基本观点提供辩护，并探究这些观点之间理性的内在关联。

**Text generated with structured chunking:**

**采用结构化分块生成的文本：**

Husserl's phenomenological reduction, also known as the epoché, is a methodological procedure he developed to study the structures of consciousness. The aim of this method is to bracket or set aside all assumptions about the existence of the external world, so that the focus can be solely on the pure phenomena of consciousness. This means suspending all judgments about what exists in order to examine the content and structure of our thoughts, perceptions, and experiences without any preconceived notions.

胡塞尔的现象学还原，亦称“悬置”（epoché），是他为研究意识结构而发展出的一种方法论程序。该方法旨在“加括号”（bracket）或暂时搁置一切关于外部世界是否存在的预设，从而使注意力完全集中于意识的纯粹现象之上。这意味着暂停一切关于“何者存在”的判断，以便在毫无先入之见的前提下，考察我们思想、知觉与经验的内容与结构。

The phenomenological reduction involves two main steps. The first is the epoché, which is the suspension of all beliefs about the external world. The second is the transcendental reduction, which involves turning one's attention inward to examine the structures of consciousness itself.

现象学还原包含两个主要步骤：第一步是“悬置”，即搁置所有关于外部世界的信念；第二步是“先验还原”（transcendental reduction），即将注意力转向内在，专门考察意识自身的结构。

The phenomenological reduction is intended to reveal the essential structures of consciousness, or the ways in which we experience and understand the world. It is a method for studying the subjective aspects of experience, or the ways in which things appear to us in our conscious experience.

现象学还原旨在揭示意识的本质结构，即我们体验和理解世界的方式；它是一种研究经验主观维度的方法，亦即事物在我们意识经验中向我们显现的方式。

Husserl also developed the concept of the "noema," which refers to the content of our conscious experiences, and the "noesis," which refers to the act of consciousness itself. These concepts are central to his phenomenological analysis of consciousness.

胡塞尔还提出了“诺耶玛”（noema）与“诺耶西斯”（noesis）的概念：“诺耶玛”指我们意识经验的内容，“诺耶西斯”则指意识活动本身。这两个概念构成了他对意识所作现象学分析的核心。

In summary, Husserl's phenomenological reduction is a method for studying the structures of consciousness by bracketing all assumptions about the external world and focusing solely on the content and structure of our conscious experiences.

总之，胡塞尔的现象学还原是一种研究意识结构的方法：它通过悬置（bracketing）一切关于外部世界的预设，仅专注于我们自身意识经验的内容与结构。

**Text generated with structured chunking and self-querying:**

**采用结构化分块与自查询生成的文本：**

Husserl's phenomenological reduction is a method used in phenomenology, a philosophical movement that he founded. The reduction involves a process called "epoché," where the phenomenologist "brackets" or sets aside their beliefs about the existence of the physical world, in order to focus purely on their direct experiences and perceptions. This is done to ensure that the item or experience being described is done so exactly as it is experienced, without any preconceived notions or biases.

胡塞尔的现象学还原是现象学——由他本人创立的哲学运动——中所采用的一种方法。该还原过程包含一种名为“悬搁”（epoché）的操作，即现象学家主动“悬置”或暂时搁置其对物理世界是否存在的既有信念，从而纯粹聚焦于自身的直接经验与知觉。此举旨在确保对某一对象或经验的描述严格忠实于其被实际经验到的方式，排除一切先入之见或主观偏见。

The phenomenological reduction is used to make coherent sense of the transcendence of objective reality, in terms of the essential horizon-structure of consciousness. The most global form of epoché is employed when this reality in total is bracketed. However, the temporal flow of one’s “present” experience, constituted by current retentions and original impressions, cannot be meaningfully doubted or bracketed.

现象学还原旨在借助意识固有的“视域结构”（horizon-structure），对客观实在的超越性作出连贯阐释。当整个客观实在被整体悬置时，便动用了最普遍、最彻底的悬搁形式。然而，个体“当下”经验的时间流——由当前的滞留（retentions）与原初印象（original impressions）共同构成——却无法被有意义地怀疑或悬置。

This process allows the phenomenologist to delve into the deep structure of intentional consciousness, which is essentially indexical in character and consists of retentions (immediate memory of what has been perceived), original impressions (awareness of what is perceived "right now"), and protentions (immediate anticipations of what will be perceived).

这一过程使现象学家得以深入探究意向性意识的深层结构；该结构本质上具有索引性（indexical），由三类基本要素构成：滞留（对已感知内容的即时记忆）、原初印象（对“此刻”正被感知内容的觉知）以及前摄（对即将被感知内容的即时预期）。

Through this method, Husserl aimed to uncover the fundamental structures of consciousness and experience, free from any assumptions about the external world.

胡塞尔通过这一方法，旨在揭示意识与经验的根本结构，且完全摆脱对外部世界的一切预设。

#### Example Query \#2: "what is nietzsche's perspectivism?" [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Example-Query-%232:-%22what-was-nietzsche's-perspectivism?%22)

#### 示例查询 #2：“尼采的视角主义是什么？” [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Example-Query-%232:-%22what-was-nietzsche's-perspectivism?%22)

Data source: [https://plato.stanford.edu/entries/nietzsche/](https://plato.stanford.edu/entries/nietzsche/?ref=blog.langchain.com)

数据来源：[https://plato.stanford.edu/entries/nietzsche/](https://plato.stanford.edu/entries/nietzsche/?ref=blog.langchain.com)

**Text generated with unstructured chunking:**

**采用非结构化分块生成的文本：**

Nietzsche's perspectivism is a philosophical concept that suggests all ideations take place from particular perspectives. This means that there are many possible conceptual schemes, or perspectives which determine any possible judgment of truth. Nietzsche believed that past philosophers had largely ignored the influence of their own perspectives on their work, and had therefore failed to control those perspectival effects. He criticized "dogmatic" philosophers for ignoring the perspectival limitations on their theorizing. However, he also believed that the operation of perspective makes a positive contribution to our cognitive endeavors. His perspectivism goes beyond just the theory of cognition and extends to moral psychology and the nature of truth or reality.

尼采的视角主义（perspectivism）是一种哲学观念，主张一切思想活动均发生于特定视角之中。这意味着，存在多种可能的概念图式或视角，而任何关于“真”的判断皆由其所处的视角所决定。尼采认为，以往的哲学家大多忽视了自身视角对其思想工作的深刻影响，因而未能有效驾驭这些视角性效应。他批评所谓“教条式”哲学家无视其理论建构所受的视角性局限。然而，尼采同时也强调，视角的运作本身对人类的认知活动具有积极贡献。他的视角主义不仅关乎认识论，更延伸至道德心理学以及真理或实在的本质问题。

**Text generated with structured chunking:**

**采用结构化分块生成的文本：**

_\[在不更改模型或切分方法的前提下，该查询会导致无效的 OpenAI API 请求：由于文档块较大且未设置过滤条件，检索器会向查询中预置过多上下文，超出 GPT-4 约 8K token 的限制。\]_

**Text generated with structured chunking and self-querying:**

**采用结构化分块与自查询生成的文本：**

尼采的视角主义（perspectivism）是一种哲学概念，主张所有哲学体系都是其作者个人经验与主观视角的映射。尼采认为，以往的哲学家大多忽视了自身视角对其思想工作的深刻影响，因而无法有效掌控这些视角性效应。他提出，知识不应被理解为一种能独立于任何立场而揭示“事物本来面目”的客观性；相反，“客观性”应通过充分运用不同视角之间的差异来实现——即以某一视角去克服另一视角的局限。这意味着，对理论主张的分析，不仅应立足于“真理性”的维度，还应将其诊断为特定心理症候，并回溯至其得以成立的复杂驱力（drive）与情感（affect）配置之中。因此，尼采的视角主义与其“谱系学”（genealogical）计划紧密相连：后者旨在通过揭示哲学理论所满足的深层心理需求，对其展开批判。

#### Example Query \#3: "what is derridian deconstruction?" [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Example-Query-%233:-%22what-is-derridian-deconstruction?%22)

#### 示例查询 \#3：“什么是德里达式解构？” [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Example-Query-%233:-%22what-is-derridian-deconstruction?%22)

Data source: [https://plato.stanford.edu/entries/derrida/](https://plato.stanford.edu/entries/derrida/?ref=blog.langchain.com)

数据来源：[https://plato.stanford.edu/entries/derrida/](https://plato.stanford.edu/entries/derrida/?ref=blog.langchain.com)

**Text generated with unstructured chunking:**

**采用非结构化分块生成的文本：**

德里达式解构（Derridian deconstruction）由雅克·德里达（Jacques Derrida）创立，不仅是一种针对文学与哲学文本的批判方式，也是一种针对政治制度的批判方式。它涉及对自我意识内部所存在的差异之重新构想，并致力于实现正义。这是一种永无终结的思考方式，始终以无穷多样的方式努力使正义成为可能。这种解构的基础并非统一的自我，而是自我与其作为“他者”的自我之间一道可分割的界限。

**Text generated with structured chunking:**

**采用结构化分块生成的文本：**

德里达式解构是由法国哲学家雅克·德里达发展出的一种批判性分析方法。它通过对文本或概念底层预设与内在矛盾的细致考察，常常揭示出其中固有的等级结构或二元对立。德里达的解构基于这样一个核心观点：一切思想体系都具有某种内在逻辑，而这种逻辑既可被发掘，亦可被质疑。

In Derrida's view, deconstruction consists of two phases. The first phase involves reversing the hierarchical oppositions in a text or concept, such as essence and appearance, or good and evil. The second phase involves redefining the previously inferior term as the origin or resource of the opposition itself.

在德里达看来，解构包含两个阶段。第一阶段涉及反转文本或概念中既有的等级制对立关系，例如本质与现象、善与恶等。第二阶段则涉及将原先被视为低等的术语重新界定为该对立关系本身的起源或资源。

Derrida's deconstruction also emphasizes the impossibility of pure presence or self-identity, arguing that every experience or concept is marked by difference and deferral, a concept he refers to as "différance". This means that meaning is never fixed or stable, but always in flux and subject to reinterpretation.

德里达的解构还强调“纯粹在场”或“自我同一性”的不可能性，主张一切经验或概念皆被差异（difference）与延异（deferral）所标记——他将这一核心观念称为“延异”（*différance*）。这意味着意义从不固定或稳定，而始终处于流动之中，并随时可能被重新诠释。

Furthermore, Derrida's deconstruction is deeply concerned with issues of justice, arguing that justice is always to come in the future and is never fully present or achievable. This relentless pursuit of justice, despite its impossibility, is a key aspect of Derrida's deconstructive approach.

此外，德里达的解构深切关注正义问题，主张正义永远“尚未来临”（à venir），它从不当下在场，也永不可被彻底实现。尽管正义本质上不可企及，但对其不懈的追寻，恰恰构成了德里达式解构方法的关键面向。

**Text generated with structured chunking and self-querying:**

**通过结构化分块与自反性提问生成的文本：**

Derridian deconstruction is a philosophical approach developed by Jacques Derrida that challenges the traditional assumptions of Western philosophy. It involves the critique of binary oppositions, such as essence/appearance, inside/outside, and speech/writing, which are seen as fundamental to Western thought. Derrida argues that these oppositions are not truly separate and hierarchical as traditionally thought, but are interdependent and have a complex, fluid relationship.

德里达式解构（Derridian deconstruction）是雅克·德里达（Jacques Derrida）发展出的一种哲学方法，旨在挑战西方哲学的传统预设。它聚焦于对二元对立（如本质/现象、内/外、言语/文字）的批判——这些对立被视作西方思想的根本结构。德里达指出，此类对立并非如传统所设想的那样彼此截然分离、等级森严，而实为相互依存，并具有复杂且流动的关系。

Derrida's deconstruction involves two phases. The first phase involves reversing the traditional hierarchies of these oppositions, making the traditionally inferior term more valuable. The second phase involves redefining the previously inferior term as the origin or resource of the opposition itself.

德里达的解构包含两个阶段：第一阶段是反转这些对立关系中传统的等级秩序，使原先被贬抑的术语获得更高的价值；第二阶段则是将此前被贬抑的术语重新界定为该对立关系自身的起源或资源。

Derrida also emphasizes the concept of "différance," a term he coined to represent the idea that meaning is always deferred, never fully present, and that difference and deferral are intertwined in the process of interpretation.

德里达还着重强调“延异”（*différance*）这一概念——这是他独创的术语，用以表达如下思想：意义始终处于延宕之中，从未完全在场；而差异与延宕在诠释过程中彼此交织、不可分割。

In later works, Derrida's deconstruction takes on a more political tone, focusing on concepts such as justice and law, and exploring their inherent contradictions and complexities. He argues that justice is always to come in the future, it is never present, and that a just decision is always required immediately, creating a sense of urgency and precipitousness.

在其后期著述中，德里达的解构呈现出更鲜明的政治向度，聚焦于正义、法律等概念，并深入探究其内在的矛盾性与复杂性。他主张：正义永远“尚未来临”，它从不当下在场；而一项正义的决断又必须即刻作出——这种张力催生出一种紧迫感与危急性（precipitousness）。

Overall, Derridian deconstruction is a complex and nuanced approach that seeks to expose and challenge the underlying structures and assumptions of Western thought.

总体而言，德里达式解构是一种高度复杂且细腻的思想路径，致力于揭示并质疑西方思想深层的结构性前提与隐含预设。

### Concluding Thoughts [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Concluding-Thoughts)

### 结语 [¶](https://blog.langchain.com/a-chunk-by-any-other-name/\#Concluding-Thoughts)

At the systems-architecture level, it is useful (following the recent [CoALA paper](https://arxiv.org/abs/2309.02427?ref=blog.langchain.com)) to think of structured chunking with self-querying as a technique for improving semantic memory utilization, one that could be adapted for more agentic applications.  

在系统架构层面，参考近期发表的 [CoALA 论文](https://arxiv.org/abs/2309.02427?ref=blog.langchain.com)，将“带自查询的结构化分块”视为一种提升语义记忆利用率的技术是十分有益的；该技术亦可适配于更具自主性（agentic）的应用场景。

Though there are procedural components in play here, e.g. knowledge about specific data that is hard-coded in prompting logic, the goal of this project (and, as I understand, of RAG more generally) is to delimit external sources of knowledge in such a way that they can be recaptured in—or, in a sense, _restored to_—processes of language generation.  

尽管当前流程中包含若干程序性组件（例如，关于特定数据的知识被硬编码于提示逻辑中），但本项目（以及据我理解更广义上的 RAG）的目标，在于对知识的外部来源加以界定，使其能够被重新纳入——或从某种意义上说，**恢复至**——语言生成过程之中。

"Augmentation" is not just a manner of textual elaboration but is also a manner of preserving context, establishing origins, and maintaining authority for fragments of text-bound information.  

“增强”（Augmentation）不仅是一种文本扩展方式，更是一种保存上下文、确立信息来源、并维系文本所承载信息之权威性的方法。

Practically speaking, this process is essential where generative AI is incorporated into educational tools and "critical" knowledge systems, e.g. for medicine and law.  

实际应用中，当生成式 AI 被整合进教育工具及“关键型”知识系统（如医学与法律领域）时，这一过程尤为关键。

But, beyond a tendency to hold in relief the longstanding academic injunction to "cite your sources," these new forms of textual transformation also carry deeper implications for language, lending new weight to the old poststructuralist cliché that (as Derrida put it) “there is no outside-text”—to the enduring belief that, no matter how we chunk it up, natural language has no natural limits.  

然而，这些新型文本转换方式的意义远不止于凸显学术界由来已久的训诫——“请注明你的资料来源”。它们更深层地影响着我们对语言的理解，为后结构主义那句老生常谈（德里达所言）——“文本之外别无他物”（there is no outside-text）——赋予了新的分量：即那种持久不衰的信念——无论我们如何对其进行分块（chunking），自然语言本身并无天然边界。

#### Acknowledgements

#### 致谢

I created the HTML Header Text Splitter tool for LangChain in collaboration with Benny Minkowsky at Presidio Vantage  
( [http://presidiovantage.com](http://presidiovantage.com/?ref=blog.langchain.com)). If you're building with it  
and have some feedback or want to share a use case, we'd love to hear about it!  

我与 Presidio Vantage 公司的 Benny Minkowsky 合作，为 LangChain 开发了 HTML 标题文本分割器（HTML Header Text Splitter）工具  
([http://presidiovantage.com](http://presidiovantage.com/?ref=blog.langchain.com))。若您正在使用该工具，并有任何反馈或希望分享具体用例，我们非常期待您的来信！

Huge thanks to Bagatur Askaryan at LangChain for advice on improving query construction and for recent upgrades to  
the self-querying retriever API.  

衷心感谢 LangChain 的 Bagatur Askaryan 在优化查询构建（query construction）方面的宝贵建议，以及近期对自查询检索器（self-querying retriever）API 所做的升级。

### Tags

### 标签

[![Extraction Benchmarking](images/a-chunk-by-any-other-name-structured-text-splitting-and-metadata-enhanced-rag/img_001.jpg)](https://blog.langchain.com/extraction-benchmarking/)

[**Extraction Benchmarking**](https://blog.langchain.com/extraction-benchmarking/)

[![Applying OpenAI's RAG Strategies](images/a-chunk-by-any-other-name-structured-text-splitting-and-metadata-enhanced-rag/img_002.png)](https://blog.langchain.com/applying-openai-rag/)

[**应用 OpenAI 的 RAG 策略**](https://blog.langchain.com/applying-openai-rag/)


[![LangServe Playground and Configurability](images/a-chunk-by-any-other-name-structured-text-splitting-and-metadata-enhanced-rag/img_003.png)](https://blog.langchain.com/langserve-playground-and-configurability/)

[**LangServe 交互式 Playground 与可配置性**](https://blog.langchain.com/langserve-playground-and-configurability/)


[**提示词生态全景图**](https://blog.langchain.com/the-prompt-landscape/)


[![Building Chat LangChain](images/a-chunk-by-any-other-name-structured-text-splitting-and-metadata-enhanced-rag/img_004.png)](https://blog.langchain.com/building-chat-langchain-2/)

[**构建聊天版 LangChain**](https://blog.langchain.com/building-chat-langchain-2/)