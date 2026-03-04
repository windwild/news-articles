---
render_with_liquid: false
title: "Testing Fine Tuned Open Source Models in LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/testing-fine-tuned-open-source-models-in-langsmith/"
date: "2023-10-16"
scraped_at: "2026-03-03T08:35:25.890508997+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

_Editor's Note. This blog post was written by [_Ryan Brandt_](https://twitter.com/dexter_brandt?ref=blog.langchain.com), the CTO and Cofounder of [_ChatOpenSource_](https://blog.langchain.com/testing-fine-tuned-open-source-models-in-langsmith/www.chatopensource.com), a business specializing in enterprise AI chat that runs entirely within an orgs network, no third party needed. He covers how he uses LangSmith,_ _LangChain's platform for getting LLM applications to production. Sign up for access [_here_](https://smith.langchain.com/?ref=blog.langchain.com)._

编辑注：本文由 [_Ryan Brandt_](https://twitter.com/dexter_brandt?ref=blog.langchain.com) 撰写。他是 [_ChatOpenSource_](https://blog.langchain.com/testing-fine-tuned-open-source-models-in-langsmith/www.chatopensource.com) 的首席技术官（CTO）兼联合创始人。ChatOpenSource 是一家专注于企业级 AI 聊天应用的公司，其全部服务均在客户组织内部网络中运行，无需依赖任何第三方服务。本文介绍了他如何使用 **LangSmith**——LangChain 专为将大语言模型（LLM）应用推向生产环境而打造的平台。点击此处注册获取访问权限：[_此处_](https://smith.langchain.com/?ref=blog.langchain.com)。

Open source models are increasingly capable for use in applications. The trend is only accelerating with recent releases like **Mistral 7b** and the **Llama2** family. The future seems to be in the ability to quickly swap better models in and out of your application like cartridges in an old game console. Fine tuning different versions of a model only increases the number of possible cartridges a developer will need to compare.

开源模型在实际应用中的能力正日益增强。随着 **Mistral 7b** 和 **Llama2** 系列等近期模型的发布，这一趋势正进一步加速。未来似乎正朝着“像老式游戏机更换卡带一样，快速在应用中切换更优模型”的方向发展。而对同一模型的不同版本进行微调，只会进一步增加开发者需要评估和比较的“卡带”数量。

So that begs the question, how can we productionize the evaluation of our models so we can can choose the best tool for the job? **LangSmith** offers us a way out of python script hell with a handy UI and API for creating evaluation datasets. With these datasets we can run tests on multiple models and directly compare their performance on multiple axis’.

因此，一个关键问题随之而来：我们该如何将模型评估流程真正落地为可复用、可扩展的生产级实践，从而为具体任务选出最合适的工具？**LangSmith** 为我们提供了一条摆脱“Python 脚本地狱”的出路——它配备直观的用户界面（UI）与便捷的 API，支持高效构建评估数据集。借助这些数据集，我们即可对多个模型并行开展测试，并在多个维度上直接对比其性能表现。

It’s easy to upload data to **LangSmith** via python or the user interface. For our example notebook scroll to the end.

通过 Python 或用户界面，将数据上传至 **LangSmith** 十分简便。本文配套示例 Notebook 请参见文末。

![](images/testing-fine-tuned-open-source-models-in-langsmith/img_001.png)uploading our dataset in csv format. In this case, we chose a Key/Value type as it's most suited to our data.![](images/testing-fine-tuned-open-source-models-in-langsmith/img_002.png)Our dataset for validating correct structured SQL output once uploaded.

![](images/testing-fine-tuned-open-source-models-in-langsmith/img_001.png)以 CSV 格式上传我们的数据集。本例中，我们选择了“键值对（Key/Value）”类型，因其最契合我们的数据结构。  
![](images/testing-fine-tuned-open-source-models-in-langsmith/img_002.png)上传完成后的数据集，用于验证结构化 SQL 输出的正确性。

## **The Process**

## **实施流程**

Here’s the way we organized the study:

以下是我们本次研究的组织方式：

1. **Initiation**: The task began with a goal to fine-tune the Llama2-7b and Llama2-13b model using the [sql-create-context](https://huggingface.co/datasets/arviii/sql-create-context?ref=blog.langchain.com) dataset on Hugging Face.  
1. **启动阶段**：本任务始于一个明确目标——基于 Hugging Face 上的 [sql-create-context](https://huggingface.co/datasets/arviii/sql-create-context?ref=blog.langchain.com) 数据集，对 Llama2-7b 和 Llama2-13b 模型进行微调。

2. **Data Conversion**: The dataset from Hugging Face, originally in JSON, was transformed to .jsonl for chat fine-tuning.  
2. **数据格式转换**：将 Hugging Face 原始 JSON 格式的数据集转换为 `.jsonl` 格式，以适配对话类微调任务。

3. **Data Sampling with GPT-4**: GPT-4's Code Interpreter was used to select 10,000 rows from the dataset.  
3. **GPT-4 辅助数据采样**：利用 GPT-4 的代码解释器（Code Interpreter）从数据集中筛选出 10,000 行样本。

4. **Validation Set Creation**: 1000 unique sql rows were chosen as a validation set, ensuring no overlap with the training data. We uploaded those testing rows to **LangSmith** so we could automate our evaluations.  
4. **验证集构建**：从中选取 1,000 条互不重复的 SQL 样本作为验证集，并确保其与训练数据无任何重叠。我们将这批测试样本上传至 **LangSmith**，以便实现评估流程的自动化。

```python
from langsmith import Client
def create_dataset(dataset_name=None):
    """adds an example run with inputs and outputs to an existing dataset"""
    client = Client()

    dataset_name = dataset_name
    client.create_dataset(dataset_name=dataset_name)
    return dataset_name
```

```python
from langsmith import Client
def create_dataset(dataset_name=None):
    """向已有数据集添加一条含输入与输出的示例运行记录"""
    client = Client()

    dataset_name = dataset_name
    client.create_dataset(dataset_name=dataset_name)
    return dataset_name
```

```python
def add_to_dataset(dataset_name, validation_file_path):
    client = Client()

    dataset = client.read_dataset(dataset_name=dataset_name)

    # Open and process the validation file
    with open(validation_file_path, 'r') as f:
        for line in f:
            data = json.loads(line)
            example = data['prompt']
            assistant_content = data['completion']

            # Add to dataset using client API
            client.create_chat_example(
                messages=[\
                    {"type": "system", "data": {"content": "You are a helpful assistant that is knowledgeable about sql. Only output the SQL."}},\
                    {"type": "human", "data": {"content": example}}\
                ],
                generations={"type": "ai", "data": {"content": assistant_content}},
                dataset_id=dataset.id
            )
```

```python
def add_to_dataset(dataset_name, validation_file_path):
    client = Client()

    dataset = client.read_dataset(dataset_name=dataset_name)

    # 打开并处理验证文件
    with open(validation_file_path, 'r') as f:
        for line in f:
            data = json.loads(line)
            example = data['prompt']
            assistant_content = data['completion']

            # 使用 client API 将样本添加到数据集
            client.create_chat_example(
                messages=[\
                    {"type": "system", "data": {"content": "你是一位熟悉 SQL 的乐于助人的助手。仅输出 SQL 语句。"}},\
                    {"type": "human", "data": {"content": example}}\
                ],
                generations={"type": "ai", "data": {"content": assistant_content}},
                dataset_id=dataset.id
            )
```

![](images/testing-fine-tuned-open-source-models-in-langsmith/img_003.png)The result of running the code block above

![](images/testing-fine-tuned-open-source-models-in-langsmith/img_003.png)运行上方代码块的结果

**5\. Fine-tuning and Assessment:** The main goal was to improve Llama2-7b-chat and Llama2-13b-chat for specific SQL output. We fine tuned Llama2-7b-chat with 78k rows of sql data, and Llama2-13b-chat with 10k rows to control for cost. Both fine tuning and inference were done on an 8xA40 cluster. We did full parameter tuning, not LoRA. To do this we used Replicate, a platform for model hosting and fine tuning. You can learn more about them [here](https://replicate.com/docs/guides/fine-tune-a-language-model?ref=blog.langchain.com).

**5．微调与评估：** 主要目标是提升 Llama2-7b-chat 和 Llama2-13b-chat 在特定 SQL 输出任务上的表现。我们使用 78,000 条 SQL 数据对 Llama2-7b-chat 进行了微调，而为控制成本，仅使用 10,000 条数据对 Llama2-13b-chat 进行微调。全部微调与推理均在一台配备 8 块 A40 GPU 的集群上完成。我们采用的是全参数微调（full parameter tuning），而非 LoRA。为此，我们使用了 Replicate —— 一个用于模型托管与微调的平台。您可点击[此处](https://replicate.com/docs/guides/fine-tune-a-language-model?ref=blog.langchain.com)进一步了解该平台。

```python
import replicate

training = replicate.trainings.create(
  version="meta/llama-2-13b-chat:f4e2de70d66816a838a89eeeb621910adffb0dd0baba3976c96980970978018d",
  input={
    "train_data": "https://storage.googleapis.com/chatopensource-replicate-demo/selected_sql_create_context_v4.jsonl",
    "num_train_epochs": 3
  },
  destination="papermoose/test"
)
```

```python
import replicate

training = replicate.trainings.create(
  version="meta/llama-2-13b-chat:f4e2de70d66816a838a89eeeb621910adffb0dd0baba3976c96980970978018d",
  input={
    "train_data": "https://storage.googleapis.com/chatopensource-replicate-demo/selected_sql_create_context_v4.jsonl",
    "num_train_epochs": 3
  },
  destination="papermoose/test"
)
```

**6\. LangSmith Evaluation:** We used LangSmith to test the 1000 prompts on each model. We compared their result to the known correct answer to determine whether the model’s output was correct or not. We used GPT-4 to do the evals itself. LangSmith made the process extremely simple, as shown below.

**6．LangSmith 评估：** 我们使用 LangSmith 对每个模型分别测试了 1,000 条提示（prompts）。通过将模型输出与已知正确答案进行比对，判断其输出是否正确。评估本身由 GPT-4 完成。LangSmith 极大地简化了整个评估流程，如下所示。

```python
import replicate

```python
import replicate
```

```python
async def evaluate_dataset(dataset_name=None, num_repetitions=1, model="gpt-4-0613", project_name=None):
    """runs the model you want to evaluate against the assumed to be correct examples in your dataset, grading the evaluated model output correct or incorrect."""

    """在您的数据集（其中示例被默认视为正确答案）上运行待评估模型，并对模型输出判定为“正确”或“错误”。"""

    from langchain.smith import run_on_dataset, RunEvalConfig, arun_on_dataset
    from langchain.chat_models import ChatOpenAI

    # The chat model you want to test, in our case replicate
    # 您要测试的聊天模型，本例中为 Replicate

    model_to_test = Replicate(
        model=model,
        model_kwargs={"temperature": 0.75, "max_length": 500, "top_p": 1},
    )

    client = Client()

    """runs a question/answer evaluation, where the eval llm (gpt-4) will determine
    if model_to_test's outputs are correct based on the example_dataset we uploaded in the previous set.
    the example_dataset is treated by the eval as a correct answer for the given input."""

    """执行问答式评估：由评估用大语言模型（gpt-4）根据我们在前一步上传的 example_dataset，判断 model_to_test 的输出是否正确。该 example_dataset 在评估过程中被视为对应输入的“标准答案”。"""

    eval_config = RunEvalConfig(
        evaluators=[\
            "cot_qa"\
        ],
    )
    chain_results = await arun_on_dataset(
        client,
        dataset_name=dataset_name,
        llm_or_chain_factory=model_to_test,
        evaluation=eval_config,
        num_repetitions=num_repetitions,
        project_name=project_name
    )
```

The LangSmith platform itself allows you to view the results of our eval, in this case the chain of thought question answer builtin eval. You can also write your own if desired as shown [here](https://docs.smith.langchain.com/evaluation/custom-evaluators?ref=blog.langchain.com)!

LangSmith 平台本身支持您查看本次评估的结果——此处为内置的“思维链问答”（chain-of-thought QA）评估器。您也可以按需自定义评估器，具体方法请参见[此处](https://docs.smith.langchain.com/evaluation/custom-evaluators?ref=blog.langchain.com)！

![](images/testing-fine-tuned-open-source-models-in-langsmith/img_004.png)A correct answer!  
![](images/testing-fine-tuned-open-source-models-in-langsmith/img_004.png)一个正确答案！

![](images/testing-fine-tuned-open-source-models-in-langsmith/img_005.png)An incorrect answer.  
![](images/testing-fine-tuned-open-source-models-in-langsmith/img_005.png)一个错误答案。

[View the dataset here](https://huggingface.co/datasets/b-mc2/sql-create-context?ref=blog.langchain.com)  
[在此查看数据集](https://huggingface.co/datasets/b-mc2/sql-create-context?ref=blog.langchain.com)

## Our **Findings in LangSmith**  
## 我们在 LangSmith 中的**评估发现**

Here are our results, with our dataset names randomly generated. There’s still no easy way to change the name of the dataset in the UI, so I’ve also charted it out below in a more understandable way.

我们得到了如下测试结果，其中数据集名称为随机生成。目前 UI 中仍没有便捷方式修改数据集名称，因此我在下方以更清晰易懂的方式绘制了图表。

![](images/testing-fine-tuned-open-source-models-in-langsmith/img_006.png)LangSmith UI showing the results of our tests.

![](images/testing-fine-tuned-open-source-models-in-langsmith/img_007.png)graphing out our LangSmith results to better visualize the outcome

![](images/testing-fine-tuned-open-source-models-in-langsmith/img_006.png)LangSmith UI 展示了我们的测试结果。

![](images/testing-fine-tuned-open-source-models-in-langsmith/img_007.png)将 LangSmith 测试结果绘制成图表，以便更直观地呈现效果。

You can see how we generated this using chatgpt [here](https://chat.openai.com/share/8ca38826-b042-45e6-baf0-76e5c0d35b3c?ref=blog.langchain.com)!

您可点击此处查看我们如何借助 ChatGPT 生成该图表：[链接](https://chat.openai.com/share/8ca38826-b042-45e6-baf0-76e5c0d35b3c?ref=blog.langchain.com)！

## **Observations on the outcome**

## **关于测试结果的观察**

1. **Parameters vs. Data**: The data shows a relationship between the model parameters and training data volume. While `llama2-7b-chat-ft-78k`, with fewer parameters, performed well, it was outperformed by `llama2-13b-chat-ft-10k` with more parameters. This leads to the question: How might the 13b model have fared with the larger 78k dataset? It's likely that accuracy would correlate with training set size and quality.

1. **参数量 vs. 数据量**：数据显示，模型参数量与训练数据规模之间存在关联。尽管参数量更少的 `llama2-7b-chat-ft-78k` 表现良好，但参数量更多的 `llama2-13b-chat-ft-10k` 表现更优。由此引出一个问题：若将 `llama2-13b-chat-ft-10k` 模型在更大的 78k 数据集上进行微调，其表现又会如何？准确率很可能与训练集的规模及质量呈正相关。

2. **Response Times**: Beyond just accuracy, response times, particularly p50 and p99, are important for assessing model efficiency. Here, the `llama2-7b-chat-ft-78k` model showed both good accuracy and efficient response times. It’s worth baring in mind that these llama models have response times based on **Replicate,** and could change depending on the hardware used to run them.

2. **响应时间**：除准确率外，响应时间（尤其是 p50 和 p99 分位值）也是评估模型效率的关键指标。本测试中，`llama2-7b-chat-ft-78k` 在保持高准确率的同时，也展现出高效的响应速度。需注意的是，这些 Llama 模型的响应时间基于 **Replicate** 平台测得，实际运行时可能因所用硬件不同而有所变化。

3. **Comparison to GPT-3.5T**: The data highlights how these models compare to `GPT-3.5-turbo-base`. Notably, `llama2-13b-chat-ft-10k`'s accuracy was close to that of `GPT-3.5T`, suggesting the potential of optimized open-source models to match or even exceed established models.

3. **与 GPT-3.5T 的对比**：数据凸显了这些模型相较于 `GPT-3.5-turbo-base` 的表现。值得注意的是，`llama2-13b-chat-ft-10k` 的准确率已接近 `GPT-3.5T`，表明经过优化的开源模型具备与成熟商业模型比肩、甚至超越其性能的潜力。

## To Recap

## 总结回顾

- We’ve seen how **LangSmith** works with any model, open or closed source.  
- We’ve seen both code snippets detailing the process of interacting with **LangSmith**, and the screenshotted results in the UI.  
- We’ve graphed out the results using ChatGPT advanced data analysis.  
- We’ve seen how for some domains open source models are competitive with OpenAI  
- for a more interactive example of using **LangSmith**, [check out our python notebook here](https://github.com/chatopensource/ai-cookbooks/blob/main/openai-fine-tuning-langsmith-cookbook.ipynb?ref=blog.langchain.com).

- 我们已了解 **LangSmith** 如何兼容任意模型——无论开源或闭源；  
- 我们既看到了与 **LangSmith** 交互的具体代码片段，也看到了 UI 界面中的截图结果；  
- 我们借助 ChatGPT 的高级数据分析功能，将测试结果可视化成图表；  
- 我们观察到，在某些领域，开源模型已能与 OpenAI 模型展开有力竞争；  
- 若想体验更具交互性的 **LangSmith** 使用示例，请查阅我们的 Python 笔记本：[点击此处](https://github.com/chatopensource/ai-cookbooks/blob/main/openai-fine-tuning-langsmith-cookbook.ipynb?ref=blog.langchain.com)。

We also run [**ChatOpenSource**](https://www.chatopensource.com/?ref=blog.langchain.com) **,** a fully data private and auditable chat replacement for ChatGPT for enterprises. Companies can easily configure documents and data so only the right team can ask about them, and no data ever leaves the company environment. [Book a quick call with us to learn more](https://calendly.com/chatopensource/30min?ref=blog.langchain.com)!

我们还运营着 [**ChatOpenSource**](https://www.chatopensource.com/?ref=blog.langchain.com)，这是一款面向企业的、完全保障数据隐私且可审计的 ChatGPT 替代方案。企业可轻松配置文档与数据权限，确保仅授权团队成员可就相关内容提问，且所有数据均严格保留在企业内部环境，永不外泄。[立即预约一次简短咨询，深入了解详情](https://calendly.com/chatopensource/30min?ref=blog.langchain.com)！