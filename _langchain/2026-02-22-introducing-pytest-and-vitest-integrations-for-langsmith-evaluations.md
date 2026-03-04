---
title: "Introducing Pytest and Vitest integrations for LangSmith Evaluations"
source: "LangChain Blog"
url: "https://blog.langchain.com/pytest-and-vitest-for-langsmith-evals/"
date: "2026-02-22"
scraped_at: "2026-03-03T07:14:11.326069776+00:00"
language: "en-zh"
translated: true
description: "Introducing a new way to run evals using LangSmith’s Pytest and Vitest/Jest integrations."
---
&#123;% raw %}

Evaluations (evals) are an essential part of building reliable and high-quality LLM applications.  They help you assess performance of your application, ensuring that quality remains consistent as you make updates. If you come from a software engineering background, you’re likely familiar with using tests for this purpose.  To extend this familiar interface, we’re excited to introduce a new way to run evals using **LangSmith’s** [**Pytest**](https://docs.smith.langchain.com/evaluation/how_to_guides/pytest?ref=blog.langchain.com) **and** [**Vitest/Jest**](https://docs.smith.langchain.com/evaluation/how_to_guides/vitest_jest?ref=blog.langchain.com) **integrations.**

评估（evals）是构建可靠、高质量大语言模型（LLM）应用的关键环节。它们帮助您评估应用性能，确保在持续迭代更新过程中质量始终如一。如果您具备软件工程背景，很可能已熟悉通过编写测试来实现这一目标。为延续这一广为人知的开发范式，我们很高兴地推出一种全新的评估运行方式——借助 **LangSmith** 的 [**Pytest**](https://docs.smith.langchain.com/evaluation/how_to_guides/pytest?ref=blog.langchain.com) 和 [**Vitest/Jest**](https://docs.smith.langchain.com/evaluation/how_to_guides/vitest_jest?ref=blog.langchain.com) 集成。

These new integrations are available now in beta with v0.3.0 of the LangSmith [Python](https://github.com/langchain-ai/langsmith-sdk/tree/main/python?ref=blog.langchain.com) and [Typescript SDK](https://github.com/langchain-ai/langsmith-sdk/tree/main/js?ref=blog.langchain.com)’s.

上述新集成现已随 LangSmith v0.3.0 版本进入 Beta 测试阶段，支持 [Python SDK](https://github.com/langchain-ai/langsmith-sdk/tree/main/python?ref=blog.langchain.com) 和 [TypeScript SDK](https://github.com/langchain-ai/langsmith-sdk/tree/main/js?ref=blog.langchain.com)。

![](images/introducing-pytest-and-vitest-integrations-for-langsmith-evaluations/img_001.jpg)

## Why use testing frameworks for LLM evals

## 为何将测试框架用于 LLM 评估？

If you’re already using [Pytest](https://docs.pytest.org/en/stable/?ref=blog.langchain.com) or [Vitest](https://vitest.dev/?ref=blog.langchain.com)/ [Jest](https://jestjs.io/?ref=blog.langchain.com) to test your application, the new LangSmith integrations give you the flexibility, familiarity and runtime behavior of Pytest/Vitest with the observability and sharing features of LangSmith. These integrations use the exact same developer experience (DX) you’re used to, and have the following benefits:

如果您已在使用 [Pytest](https://docs.pytest.org/en/stable/?ref=blog.langchain.com) 或 [Vitest](https://vitest.dev/?ref=blog.langchain.com)/[Jest](https://jestjs.io/?ref=blog.langchain.com) 对您的应用进行测试，那么 LangSmith 新推出的集成方案，将为您带来 Pytest/Vitest 所具备的灵活性、熟悉度与运行时行为，同时融合 LangSmith 提供的可观测性与协作共享能力。这些集成完全复用您已习惯的开发者体验（DX），并具备以下优势：

**Debug your tests in LangSmith**

**在 LangSmith 中调试测试**

Applications that use LLMs have additional complexity when debugging due to their non-determistic nature. LangSmith saves inputs/outputs and stack traces from your test cases to help you pinpoint the root cause of issues.

基于 LLM 的应用因固有的非确定性（non-deterministic）特性，在调试时往往更为复杂。LangSmith 会自动保存各测试用例的输入、输出及堆栈跟踪信息，助您快速定位问题根源。

**Log metrics (beyond pass/fail) in LangSmith and track progress over time**

**在 LangSmith 中记录指标（超越“通过/失败”二元结果），并长期追踪演进趋势**

Typically, testing frameworks focus only on pass/fail results, but testing LLM applications often requires a more nuanced approach. You may not have hard pass/fail criteria; rather, you want to log results and see how your application improves over time. With LangSmith, you can log feedback and compare results over time to prevent regressions and ensure that you're always deploying the best version of your application.

传统测试框架通常仅关注“通过/失败”这类二元结果；而 LLM 应用的测试则往往需要更精细、更富弹性的评估方式——您可能并无明确的硬性判定标准，而是希望持续记录各项结果，观察应用性能随时间推移的演进轨迹。借助 LangSmith，您可便捷地记录人工反馈与各类评估指标，并横向对比不同版本的结果，从而有效规避性能退化（regression），确保始终部署最优版本的应用。

![](images/introducing-pytest-and-vitest-integrations-for-langsmith-evaluations/img_002.png)

**Share results with your team**

**与团队共享结果**

Building with LLMs is often a team effort. We commonly see subject matter experts involved in the process of prompt creation or when creating evals. LangSmith allows you to share results of experiments across your team, making collaboration easier.

使用大语言模型（LLM）构建应用通常是一项团队协作任务。我们常看到领域专家参与提示词（prompt）的设计，或在构建评估（eval）流程中发挥作用。LangSmith 支持在团队内共享实验结果，从而简化协作流程。

**Built-in evaluation functions**

**内置评估函数**

If you’re using Python, LangSmith offers some built in evaluation functions to help when checking against your LLM’s output. For example, [expect.edit\_distance()](https://docs.smith.langchain.com/reference/python/_expect/langsmith._expect._Expect?ref=blog.langchain.com#langsmith._expect._Expect.edit_distance) is used to compute the string distance between your test’s output and the reference output provided. For more details on built-in evaluation functions, visit our [API reference](https://docs.smith.langchain.com/reference/python/_expect/langsmith._expect._Expect?ref=blog.langchain.com#langsmith._expect._Expect).

若您使用 Python，LangSmith 提供若干内置评估函数，辅助您比对大语言模型（LLM）的输出结果。例如，[expect.edit\_distance()](https://docs.smith.langchain.com/reference/python/_expect/langsmith._expect._Expect?ref=blog.langchain.com#langsmith._expect._Expect.edit_distance) 用于计算测试输出与参考输出之间的字符串距离。如需了解内置评估函数的更多细节，请参阅我们的 [API 参考文档](https://docs.smith.langchain.com/reference/python/_expect/langsmith._expect._Expect?ref=blog.langchain.com#langsmith._expect._Expect)。

## Get started

## 快速上手

Here’s a simple test case to demonstrate how to evaluate an application that generates SQL queries. This test checks whether the application correctly identifies off-topic user input and logs the results to LangSmith. When you run a test suite, a dataset in LangSmith will be created/updated and a new experiment will be created.

以下是一个简单的测试用例，用于演示如何评估一个生成 SQL 查询的应用程序。该测试检查应用程序是否能正确识别偏离主题的用户输入，并将结果记录至 LangSmith。当您运行测试套件时，LangSmith 中将自动创建或更新一个数据集，并启动一项新实验。

**Getting started with Pytest**

**使用 Pytest 快速入门**

To track a test in LangSmith add the `@pytest.mark.langsmith` decorator.

要在 LangSmith 中追踪测试，请添加 `@pytest.mark.langsmith` 装饰器。

```python
# tests/test_sql.py
import openai
import pytest
from langsmith import wrappers
from langsmith import testing as t

oai_client = wrappers.wrap_openai(openai.OpenAI())
```

# Define your app logic elsewhere:  
# 在其他地方定义您的应用逻辑：

# @traceable  
# @traceable  

# def generate_sql(user_query: str) -> str: ...  
# def generate_sql(user_query: str) -> str: ...

@pytest.mark.langsmith  
@pytest.mark.langsmith  

def test_offtopic_input() -> None:  
def test_offtopic_input() -> None:  

    # Log the test case inputs and reference outputs.  
    # 记录测试用例的输入和参考输出。  

    user_query = "whats up"  
    user_query = "whats up"  

    t.log_inputs({"user_query": user_query})  
    t.log_inputs({"user_query": user_query})  

    expected = "Sorry that is not a valid question."  
    expected = "抱歉，这不是一个有效的问题。"  

    t.log_reference_outputs({"response": expected})  
    t.log_reference_outputs({"response": expected})  

    actual = generate_sql(user_query)  
    actual = generate_sql(user_query)  

    t.log_outputs({"response": actual})  
    t.log_outputs({"response": actual})  

    # Use this context manager to trace any steps used for  
    # 使用此上下文管理器，将生成评估反馈所涉及的步骤  
    # generating evaluation feedback separately from the  
    # 与主应用逻辑分开进行追踪。  
    # main application logic.  

    with t.trace_feedback():  
    with t.trace_feedback():  

        instructions = (  
        instructions = (  

            "Return 1 if the ACTUAL and EXPECTED answers are semantically equivalent, "  
            "若 ACTUAL（实际输出）与 EXPECTED（期望输出）在语义上等价，则返回 1；"  

            "otherwise return 0. Return only 0 or 1 and nothing else."  
            "否则返回 0。仅返回 0 或 1，不要包含任何其他内容。"  

        )  
        )  

        grade = oai_client.chat.completions.create(  
        grade = oai_client.chat.completions.create(  

            model="gpt-4o-mini",  
            model="gpt-4o-mini",  

            messages=[\  
            messages=[\  

                {"role": "system", "content": instructions},\  
                {"role": "system", "content": instructions},\  

                {"role": "user", "content": f"ACTUAL: {actual}\nEXPECTED: {expected}"},\  
                {"role": "user", "content": f"ACTUAL: {actual}\nEXPECTED: {expected}"},\  

            ],  
            ],  

        )  
        )  

        score = float(grade.choices[0].message.content)  
        score = float(grade.choices[0].message.content)  

        t.log_feedback(key="correctness", score=score)  
        t.log_feedback(key="correctness", score=score)  

    assert actual  
    assert actual  

    assert score  
    assert score  

```

Kick off the tests like you usually would:  
```

像往常一样启动测试：

```bash
pytest tests  
```bash
pytest tests  
```

This will run like any other pytest test run and also log all test case results, application traces, and feedback traces to LangSmith.  
该命令将像其他任何 pytest 测试运行一样执行，并同时将所有测试用例结果、应用调用链（traces）以及反馈调用链（feedback traces）记录到 LangSmith。

![](images/introducing-pytest-and-vitest-integrations-for-langsmith-evaluations/img_003.png)  
![](images/introducing-pytest-and-vitest-integrations-for-langsmith-evaluations/img_003.png)

![](images/introducing-pytest-and-vitest-integrations-for-langsmith-evaluations/img_004.png)

![](images/introducing-pytest-and-vitest-integrations-for-langsmith-evaluations/img_005.png)

![](images/introducing-pytest-and-vitest-integrations-for-langsmith-evaluations/img_006.png)

从左到右、从上到下：1. 某一测试套件的运行记录表格；2. 某次测试套件运行的结果；3. 某个测试用例的调用链（Trace）；4. 某个测试用例反馈的调用链（Trace）。

请访问我们的 [Pytest 使用指南](https://docs.smith.langchain.com/evaluation/how_to_guides/pytest?ref=blog.langchain.com)，查看完整示例。

**开始使用 Vitest**

要在 LangSmith 中追踪测试，请将您的测试用例包裹在 `ls.describe()` 块中。

```typescript
import * as ls from "langsmith/vitest";

import OpenAI from "openai";
import { traceable } from "langsmith/traceable";
import { wrapOpenAI } from "langsmith/wrappers/openai";

// 将 OPENAI_API_KEY 设置为环境变量
const tracedClient = wrapOpenAI(new OpenAI());
```

```typescript
const myEvaluator = async (params: {
  outputs: { sql: string };
  referenceOutputs: { sql: string };
}) => {
  const { outputs, referenceOutputs } = params;
  const instructions = [\
    "Return 1 if the ACTUAL and EXPECTED answers are semantically equivalent, ",\
    "otherwise return 0. Return only 0 or 1 and nothing else.",\
  ].join("\n");
  const grade = await tracedClient.chat.completions.create({
    model: "gpt-4o-mini",
    messages: [\
      {\
        role: "system",\
        content: instructions,\
      },\
      {\
        role: "user",\
        content: `ACTUAL: ${outputs.sql}\nEXPECTED: ${referenceOutputs.sql}`,\
      },\
    ],
  });
  const score = parseInt(grade.choices[0].message.content ?? "");
  return { key: "correctness", score };
};

ls.describe("generate sql demo", () => {
  ls.test(
    "offtopic input",
    {
      inputs: { userQuery: "whats up" },
      referenceOutputs: { sql: "sorry that is not a valid query" },
    },
    async ({ inputs, referenceOutputs }) => {
      const sql = await generateSql(inputs.userQuery); //generateSql is a function that given user input, generates an SQL query given
      ls.logOutputs({ sql });
      const wrappedEvaluator = ls.wrapEvaluator(myEvaluator);
      // Will automatically log "correctness" as feedback
      await wrappedEvaluator({
        outputs: { sql },
        referenceOutputs,
      });
    }
  );
});
```

```typescript
const myEvaluator = async (params: {
  outputs: { sql: string };
  referenceOutputs: { sql: string };
}) => {
  const { outputs, referenceOutputs } = params;
  const instructions = [\
    "如果 ACTUAL（实际输出）与 EXPECTED（期望输出）在语义上等价，则返回 1；\n否则返回 0。仅返回 0 或 1，不要返回其他任何内容。",\
  ].join("\n");
  const grade = await tracedClient.chat.completions.create({
    model: "gpt-4o-mini",
    messages: [\
      {\
        role: "system",\
        content: instructions,\
      },\
      {\
        role: "user",\
        content: `ACTUAL: ${outputs.sql}\nEXPECTED: ${referenceOutputs.sql}`,\
      },\
    ],
  });
  const score = parseInt(grade.choices[0].message.content ?? "");
  return { key: "correctness", score };
};

ls.describe("generate sql demo", () => {
  ls.test(
    "offtopic input",
    {
      inputs: { userQuery: "whats up" },
      referenceOutputs: { sql: "sorry that is not a valid query" },
    },
    async ({ inputs, referenceOutputs }) => {
      const sql = await generateSql(inputs.userQuery); // generateSql 是一个函数：根据用户输入生成对应的 SQL 查询
      ls.logOutputs({ sql });
      const wrappedEvaluator = ls.wrapEvaluator(myEvaluator);
      // 将自动以 "correctness" 为键记录反馈结果
      await wrappedEvaluator({
        outputs: { sql },
        referenceOutputs,
      });
    }
  );
});
```

Visit our [Vitest/Jest how-to-guide](https://docs.smith.langchain.com/evaluation/how_to_guides/vitest_jest?ref=blog.langchain.com) for the full example.

访问我们的 [Vitest/Jest 使用指南](https://docs.smith.langchain.com/evaluation/how_to_guides/vitest_jest?ref=blog.langchain.com)，查看完整示例。

## Testing frameworks vs. evaluate()

## 测试框架 vs. `evaluate()` 方法

Most popular eval libraries, such as [OpenAI Evals](https://github.com/openai/evals?ref=blog.langchain.com), [Hugging Face’s Evaluate](https://github.com/huggingface/evaluate?ref=blog.langchain.com) and [LangSmith’s evaluate()](https://docs.smith.langchain.com/reference/python/evaluation/langsmith.evaluation._runner.evaluate?ref=blog.langchain.com) work similarly – you first create a dataset upfront and then define a generation function and a set of evaluators to run over the dataset. This approach tends to work well for use cases where you need to run the same set of evals across a dataset, such as if you’re black-box testing the inputs and outputs of an agent. However, we’ve found that it falls short in some cases.

目前主流的评估库（例如 [OpenAI Evals](https://github.com/openai/evals?ref=blog.langchain.com)、[Hugging Face 的 Evaluate](https://github.com/huggingface/evaluate?ref=blog.langchain.com) 以及 [LangSmith 的 `evaluate()`](https://docs.smith.langchain.com/reference/python/evaluation/langsmith.evaluation._runner.evaluate?ref=blog.langchain.com)）工作方式类似：你首先预先构建一个数据集，然后定义一个生成函数和一组评估器，在该数据集上批量运行评估。这种模式适用于需要对整个数据集统一执行相同评估任务的场景（例如对智能体的输入/输出进行黑盒测试）。然而，我们在实践中发现，这种方式在某些情况下存在明显局限。

We’ve integrated the new Pytest and Vitest/Jest integrations in a number of applications we’ve built (videos coming soon!) and found that it has three main benefits:

我们已在多个自研应用中集成了全新的 Pytest 和 Vitest/Jest 测试框架集成（相关演示视频即将上线！），并总结出其三大核心优势：

**Specific evaluation logic for each test case.**

**每个测试用例可配置专属评估逻辑。**

If you want to evaluate specific parts of your application, it’s more flexible and intuitive to define examples and evaluators as test cases than to use [evaluate()](https://docs.smith.langchain.com/reference/python/evaluation/langsmith.evaluation._runner.evaluate?ref=blog.langchain.com). For example, when testing an agent that has access to multiple tools you'll want to test your model's ability to call each tool. But how you evaluate two tools can be completely different, making it tedious to define global evaluator functions. With the new testing integrations, you can have separate test cases with custom evaluation logic in each. To see this in action, check out our [tutorial](https://docs.langchain.com/langsmith/test-react-agent-pytest?ref=blog.langchain.com).

若需针对应用的特定模块开展评估，将样例与评估器直接定义为独立测试用例，远比使用 [evaluate()](https://docs.smith.langchain.com/reference/python/evaluation/langsmith.evaluation._runner.evaluate?ref=blog.langchain.com) 更加灵活直观。举例来说：当测试一个具备多工具调用能力的智能体时，你需要分别验证模型调用各工具的能力；但不同工具的评估标准可能截然不同，若强行统一为全局评估函数，编写与维护成本将显著升高。而借助新的测试框架集成，你可为每个测试用例自由定制专属评估逻辑。实际效果请参阅我们的 [教程](https://docs.langchain.com/langsmith/test-react-agent-pytest?ref=blog.langchain.com)。

**Real-time local feedback.**

**本地实时反馈。**

Testing frameworks provide real-time feedback on your test status, which makes it much easier to spot and fix issues as you go. This rapid feedback loop is useful when you’re iterating locally on your application, including mocking out parts of your application, and need to test evals quickly.

测试框架能实时反馈测试执行状态，极大简化了问题定位与修复流程。这种快速反馈循环对于本地迭代开发尤为关键——尤其当你需要模拟（mock）部分应用组件，并快速验证评估逻辑是否正确时。

**CI pipeline integration.**

**CI 流水线集成**

Running evals as part of your CI pipeline helps catch regressions early. Testing frameworks naturally support defining pass/fail criteria and raising assertion errors in CI workflows.

将评估（evals）作为 CI 流水线的一部分运行，有助于尽早发现模型退化问题。测试框架天然支持在 CI 工作流中定义通过/失败标准，并抛出断言错误。

In the coming weeks, we’ll be releasing a Github Action to make this especially easy to configure.

未来几周，我们将发布一个 GitHub Action，让这一配置过程变得尤为简单。

## Try it out!

## 立即试用！

We’re excited to share our new approach to running evals using Pytest and Vitest/Jest integrations! Visit our developer [tutorial](https://docs.smith.langchain.com/evaluation/tutorials/testing?ref=blog.langchain.com) and how-to guides ( [Python](https://docs.smith.langchain.com/evaluation/how_to_guides/pytest?ref=blog.langchain.com), [TypeScript](https://docs.smith.langchain.com/evaluation/how_to_guides/vitest_jest?ref=blog.langchain.com)) to get started, and check out our video walkthroughs ( [Python](https://youtu.be/2n3IUg97paE?ref=blog.langchain.com), [TypeScript](https://youtu.be/B69i3LojvR0?ref=blog.langchain.com)).

我们很高兴向您介绍一种全新的评估（evals）运行方式——通过 Pytest 与 Vitest/Jest 集成实现！欢迎访问我们的开发者 [教程](https://docs.smith.langchain.com/evaluation/tutorials/testing?ref=blog.langchain.com)，以及操作指南（[Python 版](https://docs.smith.langchain.com/evaluation/how_to_guides/pytest?ref=blog.langchain.com)、[TypeScript 版](https://docs.smith.langchain.com/evaluation/how_to_guides/vitest_jest?ref=blog.langchain.com)）快速上手；您也可以观看我们的视频实操演示（[Python 版](https://youtu.be/2n3IUg97paE?ref=blog.langchain.com)、[TypeScript 版](https://youtu.be/B69i3LojvR0?ref=blog.langchain.com)）。

If you have feedback or feature requests, let us know what you think by getting in touch with us through the [LangChain Slack Community](https://langchaincommunity.slack.com/?ref=blog.langchain.com) or opening an issue on [GitHub](https://github.com/langchain-ai/langsmith-sdk?ref=blog.langchain.com). If you’re not part of the Slack community yet, sign up [here](https://www.langchain.com/join-community?ref=blog.langchain.com).

如果您有任何反馈或功能建议，欢迎通过 [LangChain Slack 社区](https://langchaincommunity.slack.com/?ref=blog.langchain.com) 与我们联系，或在 [GitHub](https://github.com/langchain-ai/langsmith-sdk?ref=blog.langchain.com) 上提交 Issue。若您尚未加入 Slack 社区，可点击此处 [注册](https://www.langchain.com/join-community?ref=blog.langchain.com)。
&#123;% endraw %}
