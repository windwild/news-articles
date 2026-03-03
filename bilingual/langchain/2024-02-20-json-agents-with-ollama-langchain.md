---
title: "JSON agents with Ollama & LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/json-based-agents-with-ollama-and-langchain/"
date: "2024-02-20"
scraped_at: "2026-03-03T08:11:33.087385178+00:00"
language: "en-zh"
translated: true
---

## Learn to implement an open-source Mixtral agent that interacts with a graph database Neo4j through a semantic layer

## 学习实现一个开源的 Mixtral 智能体，通过语义层与图数据库 Neo4j 进行交互

**Editor's note: This post is written by** [**Tomaz Bratanic**](https://twitter.com/tb_tomaz?ref=blog.langchain.dev) **from Neo4j**

**编辑注：本文由 Neo4j 的 [Tomaz Bratanic](https://twitter.com/tb_tomaz?ref=blog.langchain.dev) 撰写**

By now, we all have probably recognized that we can significantly enhance the capabilities of LLMs by providing them with additional tools. For example, even ChatGPT can use Bing Search and Python interpreter out of the box in the paid version. OpenAI is a step ahead and provides fine-tuned LLM models for tool usage, where you can pass the available tools along with the prompt to the API endpoint. The LLM then decides if it can directly provide a response or if it should use any of the available tools first. Note that the tools don’t have to be only for retrieving additional information; they can be anything, even allowing LLMs to book a dinner reservation. I have previously implemented a project [allowing an LLM to interact with a graph database through a set of predefined tools](https://towardsdatascience.com/enhancing-interaction-between-language-models-and-graph-databases-via-a-semantic-layer-0a78ad3eba49?ref=blog.langchain.com), which I called a semantic layer.

截至目前，我们很可能都已意识到：为大语言模型（LLM）配备额外工具，可显著增强其能力。例如，付费版 ChatGPT 即可开箱即用地调用 Bing 搜索和 Python 解释器。OpenAI 更进一步，提供了专为工具调用优化的微调 LLM 模型——你只需将可用工具连同提示词一并传入 API 端点，LLM 就会自主判断：是直接生成回答，还是先调用某个工具。需注意的是，这些工具不仅限于检索额外信息；它们可以是任意功能，甚至能让 LLM 代为预订晚餐。此前，我曾实现过一个项目：[让 LLM 通过一组预定义工具与图数据库交互](https://towardsdatascience.com/enhancing-interaction-between-language-models-and-graph-databases-via-a-semantic-layer-0a78ad3eba49?ref=blog.langchain.com)，我将其称为“语义层”。

![](images/json-agents-with-ollama-langchain/img_001.png)An agentic LLM interacting with a graph database. Image by author.

![](images/json-agents-with-ollama-langchain/img_001.png)具备智能体能力的 LLM 正在与图数据库交互。图片由作者提供。

In essence, these tools augment a LLM like GPT-4 by providing dynamic, real-time access to information, personalization through memory, and a sophisticated understanding of relationships through the knowledge graph. Together, they enable the LLM to offer more accurate recommendations, understand user preferences over time, and access a broader range of up-to-date information, resulting in a more interactive and adaptive user experience. As mentioned, besides the ability to retrieve additional information at query time, they also give the LLM an option to influence their environment by, for example, booking a meeting in the calendar.

本质上，这些工具通过三大能力增强 GPT-4 等 LLM：一是提供动态、实时的信息访问能力；二是借助记忆机制实现个性化；三是依托知识图谱，深入理解实体间复杂关系。三者协同，使 LLM 能够提供更精准的推荐、长期学习并理解用户偏好，并接入更广泛、更及时的信息源，从而带来更具交互性与适应性的用户体验。如前所述，除在查询时获取额外信息外，这些工具还赋予 LLM 影响其运行环境的能力——例如，在日历中自动预约会议。

While OpenAI has spoiled us with its fine-tuned models for tool usage, the reality is that most other LLMs aren’t at the level of OpenAI when it comes to function calling and tool usage. I have tried most of the models available in Ollama, and most struggle with consistently generating predefined structured output that could be used to power an agent. On the other hand, there are some models that are fine-tuned for function-calling. However, those models have a custom prompt engineering schema for function-calling they follow, which is not well documented, or they can’t be used for anything other than function-calling.

尽管 OpenAI 凭借其专为工具调用微调的模型让我们“养刁了胃口”，但现实是：绝大多数其他 LLM 在函数调用与工具使用能力上，尚无法企及 OpenAI 的水平。我已尝试了 Ollama 平台上大部分可用模型，发现其中多数难以稳定生成符合预设结构的输出——而这恰恰是驱动智能体所必需的。另一方面，确实存在少数专为函数调用微调的模型；但它们往往采用自定义的、文档记录不充分的提示工程范式，且通常仅适用于函数调用这一单一场景，缺乏通用性。

Ultimately, I decided to follow the existing LangChain implementation of a JSON-based agent using the Mixtral 8x7b LLM. I used the Mixtral 8x7b as a movie agent to interact with Neo4j, a native graph database, through a semantic layer. The [code is available as a Langchain template](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-semantic-ollama?ref=blog.langchain.com) and as a [Jupyter notebook](https://github.com/tomasonjo/blogs/blob/master/llm/ollama_semantic_layer.ipynb?ref=blog.langchain.com). If you are interested in how the tools are implemented, you can look at my [previous blog post](https://towardsdatascience.com/enhancing-interaction-between-language-models-and-graph-databases-via-a-semantic-layer-0a78ad3eba49?ref=blog.langchain.com). Here, we will discuss how to implement a JSON-based LLM agent.

最终，我决定沿用 LangChain 现有的基于 JSON 的智能体实现方案，并选用 Mixtral 8x7b LLM 构建一个电影领域智能体，使其通过语义层与原生图数据库 Neo4j 进行交互。相关[代码已作为 LangChain 模板发布](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-semantic-ollama?ref=blog.langchain.com)，同时也提供了[配套的 Jupyter Notebook](https://github.com/tomasonjo/blogs/blob/master/llm/ollama_semantic_layer.ipynb?ref=blog.langchain.com)。若您想深入了解工具的具体实现方式，可参阅我的[上一篇博客文章](https://towardsdatascience.com/enhancing-interaction-between-language-models-and-graph-databases-via-a-semantic-layer-0a78ad3eba49?ref=blog.langchain.com)。本文则将重点介绍如何实现一个基于 JSON 的 LLM 智能体。

## Tools in the semantic layer

## 语义层中的工具

The examples in LangChain documentation ( [JSON agent](https://python.langchain.com/docs/modules/agents/agent_types/json_agent?ref=blog.langchain.com), [HuggingFace example](https://huggingface.co/blog/open-source-llms-as-agents?ref=blog.langchain.com)) use tools with a single string input. Since the tools in the semantic layer use slightly more complex inputs, I had to dig a little deeper. Here is an example input for a recommender tool.

LangChain 官方文档中的示例（[JSON 智能体](https://python.langchain.com/docs/modules/agents/agent_types/json_agent?ref=blog.langchain.com)、[Hugging Face 示例](https://huggingface.co/blog/open-source-llms-as-agents?ref=blog.langchain.com)）均采用仅接受单个字符串输入的工具。而语义层中的工具输入结构略为复杂，因此我不得不深入探究。以下是一个推荐工具（recommender tool）的输入示例：

```
all_genres = [\
    "Action",\
    "Adventure",\
    "Animation",\
    "Children",\
    "Comedy",\
    "Crime",\
    "Documentary",\
    "Drama",\
    "Fantasy",\
    "Film-Noir",\
    "Horror",\
    "IMAX",\
    "Musical",\
    "Mystery",\
    "Romance",\
    "Sci-Fi",\
    "Thriller",\
    "War",\
    "Western",\
]
```

```python
class RecommenderInput(BaseModel):
    movie: Optional[str] = Field(description="movie used for recommendation")
    genre: Optional[str] = Field(
        description=(
            "genre used for recommendation. Available options are:" f"{all_genres}"
        )
    )
```

```python
class RecommenderInput(BaseModel):
    movie: Optional[str] = Field(description="用于推荐的电影")
    genre: Optional[str] = Field(
        description=(
            "用于推荐的类型。可选值包括：" f"{all_genres}"
        )
    )
```

The recommender tools has two optional inputs, movie and genre. Additionally, we use an enumeration of available values for the genre parameter. While the inputs are not highly complex, they are still more advanced than a single string input, so the implementation has to be slightly different.

推荐器工具具有两个可选输入：`movie` 和 `genre`。此外，我们为 `genre` 参数使用了可用值的枚举。尽管这些输入并不十分复杂，但仍比单一字符串输入更进阶，因此实现方式需稍作调整。

## JSON-based prompt for an LLM agent

## 面向大语言模型代理的基于 JSON 的提示词

In my implementation, I took heavy inspiration from the existing `hwchase17/react-json` prompt available in [LangChain hub](https://smith.langchain.com/hub/hwchase17/react-json?ref=blog.langchain.com). The prompt uses the following system message.

在我的实现中，我大量借鉴了 [LangChain Hub](https://smith.langchain.com/hub/hwchase17/react-json?ref=blog.langchain.com) 中已有的 `hwchase17/react-json` 提示模板。该提示使用以下系统消息：

````
Answer the following questions as best you can. You have access to the following tools:

{tools}

The way you use the tools is by specifying a json blob.
Specifically, this json should have a `action` key (with the name of the tool to use) and a `action_input` key (with the input to the tool going here).

The only values that should be in the "action" field are: {tool_names}

The $JSON_BLOB should only contain a SINGLE action, do NOT return a list of multiple actions. Here is an example of a valid $JSON_BLOB:

```
{{
"action": $TOOL_NAME,
"action_input": $INPUT
}}
```

```
请尽可能好地回答以下问题。你可以使用以下工具：

{tools}

调用工具的方式是提供一个 JSON 数据块（blob）。  
具体而言，该 JSON 必须包含一个 `action` 字段（其值为待调用工具的名称），以及一个 `action_input` 字段（其值为传给该工具的输入参数）。

`action` 字段的取值仅限于以下选项：{tool_names}

`$JSON_BLOB` 中**只能包含单个动作**，切勿返回多个动作组成的列表。以下是一个合法的 `$JSON_BLOB` 示例：

```
{{
"action": $TOOL_NAME,
"action_input": $INPUT
}}
```

Question: the input question you must answer  
Thought: you should always think about what to do  
Action:  
```  
$JSON_BLOB  
```  
Observation: the result of the action  
... (this Thought/Action/Observation can repeat N times)  
Thought: I now know the final answer  
Final Answer: the final answer to the original input question  

# Prompt Structure and JSON-Based Agent Design

# 提示词结构与基于 JSON 的智能体设计

The prompt starts by defining the available tools, which we will get to a bit later. The most important part of the prompt is instructing the LLM on what the output should look like. When the LLM needs to call a function, it should use the following JSON structure:

提示词首先定义了可用的工具（我们稍后会详细介绍）。提示词中最重要的部分，是明确指示大语言模型（LLM）应以何种格式输出结果。当 LLM 需要调用某个函数时，必须使用以下 JSON 结构：

```  
{{  
  "action": $TOOL_NAME,  
  "action_input": $INPUT  
}}  
```  

That’s why it is called a JSON-based agent: we instruct the LLM to produce a JSON when it wants to use any available tools. However, that is only a part of the output definition. The full output should have the following structure:

因此，该类智能体被称为“基于 JSON 的智能体”：我们要求 LLM 在需要调用任意可用工具时，必须生成一个 JSON 对象。但上述 JSON 仅是输出格式的一部分；完整的输出应严格遵循以下结构：

```  
Thought: you should always think about what to do  
Action:  
```  
$JSON_BLOB  
```  
Observation: the result of the action  
... (this Thought/Action/Observation can repeat N times)  
Final Answer: the final answer to the original input question  
```  

The LLM should always explain what it is doing in the thought part of the output. When it wants to use any of the available tools, it should provide the action input as a JSON blob. The observation part is reserved for tool outputs, and when the agent decides it can return an answer to the user, it should use the `Final Answer` key. Here is an example from the movie agent using this structure.

LLM 必须始终在输出的 `Thought`（思考）部分清晰说明其当前推理过程和决策依据。当它决定调用任一可用工具时，需将工具名称与输入参数封装为一个 JSON 对象（即 `$JSON_BLOB`）作为 `Action` 的内容。`Observation`（观察）部分专用于接收并呈现工具执行后的返回结果；而当智能体判定已掌握足够信息、可向用户给出最终答复时，则必须以 `Final Answer:` 开头输出答案。以下是一个电影推荐智能体应用该结构的示例：

![](images/json-agents-with-ollama-langchain/img_002.png)  

In this example, we asked the agent to recommend a good comedy. Since one of the available tools of the agent is a recommender tool, it decided to utilize the recommender tool by providing the JSON syntax to define its input. Luckily, LangChain has a [built-in output parser of the JSON agent](https://api.python.langchain.com/en/latest/agents/langchain.agents.output_parsers.react_json_single_input.ReActJsonSingleInputOutputParser.html?ref=blog.langchain.com), so we don’t have to worry about implementing it. Next, the LLM gets a response from the tool and uses it as an observation in the prompt. Since the tool provided all the required information, the LLM decided that it had enough information to construct a final answer, which could be returned to the user.

在此示例中，我们向智能体提出请求：“请推荐一部优秀的喜剧片”。由于该智能体内置了一个推荐工具（recommender tool），它便决定调用该工具，并通过标准 JSON 语法明确指定输入参数。幸运的是，LangChain 已提供 [JSON 智能体专用的内置输出解析器（`ReActJsonSingleInputOutputParser`）](https://api.python.langchain.com/en/latest/agents/langchain.agents.output_parsers.react_json_single_input.ReActJsonSingleInputOutputParser.html?ref=blog.langchain.com)，因此开发者无需自行实现解析逻辑。随后，LLM 接收到工具返回的结果，并将其作为 `Observation` 内容插入到后续提示词中。由于该工具已完整提供了所需信息，LLM 判定已有充分依据生成最终答复，并以 `Final Answer:` 格式将结果返回给用户。

I noticed that it’s hard to prompt engineer Mixtral in a way so that it only uses the JSON syntax when it needs to use a tool.  
我发现，很难通过提示工程（prompt engineering）的方式，让 Mixtral 仅在需要调用工具时才使用 JSON 格式。

In my experiments, when it didn’t want to use any tools, it sometimes used the following JSON action input.  
在我的实验中，当模型不打算调用任何工具时，它有时会输出如下 JSON 动作输入：

```
{{
  "action": Null,
  "action_input": ""
}}
```

```
{{
  "action": Null,
  "action_input": ""
}}
```

The output parsing function in LangChain doesn’t ignore the action if it is null or similar, but returns an error that the null tool is not defined.  
LangChain 中的输出解析函数并不会忽略 `action` 字段为 `null` 或类似值的情况，而是会报错，提示“未定义名为 `null` 的工具”。

I tried to prompt engineer a solution for this problem, but couldn’t do it in a consistent manner.  
我曾尝试通过提示工程来解决这个问题，但始终无法实现稳定、一致的效果。

Therefore, I decided to add a dummy smalltalk tool that the agent can call when the user wants to smalltalk.  
因此，我决定添加一个虚拟的“闲聊”（smalltalk）工具，供智能体（agent）在用户打招呼或希望闲聊时调用。

```
response = (
    "Create a final answer that says if they "
    "have any questions about movies or actors"
)

class SmalltalkInput(BaseModel):
    query: Optional[str] = Field(description="user query")

class SmalltalkTool(BaseTool):
    name = "Smalltalk"
    description = "useful for when user greets you or wants to smalltalk"
    args_schema: Type[BaseModel] = SmalltalkInput

    def _run(
        self,
        query: Optional[str] = None,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> str:
        """Use the tool."""
        return response
```

```
response = (
    "Create a final answer that says if they "
    "have any questions about movies or actors"
)

class SmalltalkInput(BaseModel):
    query: Optional[str] = Field(description="用户查询")

class SmalltalkTool(BaseTool):
    name = "Smalltalk"
    description = "适用于用户向你打招呼或希望闲聊的场景"
    args_schema: Type[BaseModel] = SmalltalkInput

    def _run(
        self,
        query: Optional[str] = None,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> str:
        """调用该工具。"""
        return response
```

This way, the agent can decide to use a dummy Smalltalk tool when the user greets it, and we no longer have problems with parsing null or missing tool names.  
这样一来，当用户打招呼时，智能体便可主动选择调用这个虚拟的 `Smalltalk` 工具，从而彻底避免了因解析 `null` 或缺失工具名而引发的问题。

![](images/json-agents-with-ollama-langchain/img_003.png)

![](images/json-agents-with-ollama-langchain/img_003.png)

This workaround works quite well, so I decided to keep it.  
这一变通方案效果相当不错，因此我决定保留它。

As mentioned, most models aren’t trained to produce action inputs or text if no action is required, so we have to work with what is currently available.  
如前所述，大多数大语言模型并未经过专门训练以在“无需执行动作”时准确地生成纯文本响应（而非动作输入），因此我们只能基于当前模型的实际能力来设计解决方案。

However, sometimes the model successfully doesn’t call any tools on the first iteration as well, it depends.  
不过，有时模型在第一轮推理中确实能成功地不调用任何工具——但这具有不确定性，取决于具体输入和上下文。

But giving it an escape option like the smalltalk tool seems to prevent exceptions.  
但为模型提供一个像 `Smalltalk` 工具这样的“安全出口”（escape option），似乎能有效防止异常抛出。

## Defining tool inputs in system prompt

## 在系统提示词中定义工具输入

As mentioned, I had to figure out how to define slightly more complex tool inputs so that the LLM could correctly interpret them. Funnily enough, after implementing a custom function, I found an existing LangChain function that transforms the custom Pydantic tool input definition into a JSON object that the Mixtral recognizes.

如前所述，我需要探索如何定义稍复杂的工具输入，以便大语言模型（LLM）能正确理解它们。有趣的是，在实现了一个自定义函数后，我发现 LangChain 已有一个现成函数，可将自定义的 Pydantic 工具输入定义转换为 Mixtral 能识别的 JSON 对象。

```
from langchain.tools.render import render_text_description_and_args

tools = [RecommenderTool(), InformationTool(), Smalltalk()]

tool_input = render_text_description_and_args(tools)
print(tool_input)
```

```
from langchain.tools.render import render_text_description_and_args

tools = [RecommenderTool(), InformationTool(), Smalltalk()]

tool_input = render_text_description_and_args(tools)
print(tool_input)
```

Produces the following string description:

该代码生成如下字符串形式的工具描述：

```
"Recommender":"useful for when you need to recommend a movie",
"args":{
   {
      "movie":{
         {
            "title":"Movie",
            "description":"movie used for recommendation",
            "type":"string"
         }
      },
      "genre":{
         {
            "title":"Genre",
            "description":"genre used for recommendation. Available options are:['Action', 'Adventure', 'Animation', 'Children', 'Comedy', 'Crime', 'Documentary', 'Drama', 'Fantasy', 'Film-Noir', 'Horror', 'IMAX', 'Musical', 'Mystery', 'Romance', 'Sci-Fi', 'Thriller', 'War', 'Western']",
            "type":"string"
         }
      }
   }
},
"Information":"useful for when you need to answer questions about various actors or movies",
"args":{
   {
      "entity":{
         {
            "title":"Entity",
            "description":"movie or a person mentioned in the question",
            "type":"string"
         }
      },
      "entity_type":{
         {
            "title":"Entity Type",
            "description":"type of the entity. Available options are 'movie' or 'person'",
            "type":"string"
         }
      }
   }
},
"Smalltalk":"useful for when user greets you or wants to smalltalk",
"args":{
   {
      "query":{
         {
            "title":"Query",
            "description":"user query",
            "type":"string"
         }
      }
   }
}
```

```
"Recommender":"useful for when you need to recommend a movie",
"args":{
   {
      "movie":{
         {
            "title":"Movie",
            "description":"movie used for recommendation",
            "type":"string"
         }
      },
      "genre":{
         {
            "title":"Genre",
            "description":"genre used for recommendation. Available options are:['Action', 'Adventure', 'Animation', 'Children', 'Comedy', 'Crime', 'Documentary', 'Drama', 'Fantasy', 'Film-Noir', 'Horror', 'IMAX', 'Musical', 'Mystery', 'Romance', 'Sci-Fi', 'Thriller', 'War', 'Western']",
            "type":"string"
         }
      }
   }
},
"Information":"useful for when you need to answer questions about various actors or movies",
"args":{
   {
      "entity":{
         {
            "title":"Entity",
            "description":"movie or a person mentioned in the question",
            "type":"string"
         }
      },
      "entity_type":{
         {
            "title":"Entity Type",
            "description":"type of the entity. Available options are 'movie' or 'person'",
            "type":"string"
         }
      }
   }
},
"Smalltalk":"useful for when user greets you or wants to smalltalk",
"args":{
   {
      "query":{
         {
            "title":"Query",
            "description":"user query",
            "type":"string"
         }
      }
   }
}
```

We can simply copy this tool description in the system prompt and Mixtral will be able to use the defined tools, which is quite cool.

我们只需将这段工具描述直接复制到系统提示词中，Mixtral 就能正确调用所定义的工具，这一点非常酷。

## Conclusion

## 总结

Most of the work to implement the JSON-based agent was done by Harrison Chase and the LangChain team, for which I am grateful. All I had to do was find the puzzle pieces and put them together. As mentioned, don’t expect the same level of agent performance as with GPT-4. However, I think the more powerful OSS LLMs like Mixtral could be used as agents today (with a bit more exception handling than GPT-4). I am looking forward to more open source LLMs being fine-tuned as agents.

基于 JSON 的智能体（agent）实现工作，绝大部分由 Harrison Chase 及 LangChain 团队完成，对此我深表感谢。我所做的，不过是找到合适的“拼图模块”并将它们组合起来。如前所述，不要期望其智能体性能能达到 GPT-4 的水平。不过，我认为像 Mixtral 这样更强大的开源大语言模型（OSS LLM），如今已可作为智能体投入使用（尽管相比 GPT-4，可能需要增加一些异常处理逻辑）。我也十分期待未来有更多开源大语言模型被专门微调为智能体。

The [code is available as a Langchain template](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-semantic-ollama?ref=blog.langchain.com) and as a [Jupyter notebook](https://github.com/tomasonjo/blogs/blob/master/llm/ollama_semantic_layer.ipynb?ref=blog.langchain.com).

代码以 Langchain 模板形式提供：[点击访问](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-semantic-ollama?ref=blog.langchain.com)，同时也提供 [Jupyter Notebook 版本](https://github.com/tomasonjo/blogs/blob/master/llm/ollama_semantic_layer.ipynb?ref=blog.langchain.com)。