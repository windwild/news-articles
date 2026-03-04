---
title: "The second wave of MCP: Building for LLMs, not developers - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/the-second-wave-of-mcp-building-for-llms-not-developers"
date: "2025-09-09"
scraped_at: "2026-03-02T09:28:52.527434200+00:00"
language: "en-zh"
translated: true
description: "The second wave of MCP, building for LLMs, not developers. Explore the evolution of MCP as it shifts from developer-focused tools to LLM-native integrations. Discover the future of AI connectivity."
---

render_with_liquid: false
2025年9月9日

2025年9月9日

当 MCP 标准首次发布时，许多团队急于推出某种实现。结果，大量服务器最终仅成为对现有 API 的轻量级封装，改动极少——这成了一种快速宣称“我们支持 MCP”的捷径。

当时，这种做法不无道理：MCP 尚属新生事物，各团队希望尽快交付成果，而最直观的路径便是沿用已有的 API 结构。既然可以重新包装，又何须另起炉灶？

但这一做法的问题在于：大语言模型（LLM）的工作方式与开发者截然不同。它们不会复用过往代码，也不具备长期状态记忆；每次对话都从零开始。LLM 必须在每次会话中重新发现有哪些可用工具、如何调用它们，以及调用的先后顺序。若工具仅为底层 API 封装，则会导致重复编排、行为不一致，以及大量无效劳动——因为 LLM 不得不反复解决同一组协调难题。

MCP 发挥最大效用的前提是：工具应直接承载完整的用户意图，而非仅仅暴露单个 API 操作。例如，一个端到端部署项目的工具，远胜于四个分别负责部署流水线中某一环节的工具。

## 大语言模型（LLM）调用 API 的方式有何不同

核心差异在于上下文与状态管理机制。  
当你编写代码时，你能在多次 API 调用之间主动维护信息：例如，将创建项目时返回的 project ID 存储下来，在添加域名前检查部署状态，并为每一步骤单独封装错误处理逻辑，以防某处失败导致整个流程中断。

而 LLM 的工作方式与此不同：每次对话均从空白状态启动，不保留任何先前对话的记忆。尽管 LLM 在当前会话中可查看已调用工具的返回结果，但它必须仅凭当前可见的工具列表，自行推断出正确的调用序列。一旦这些工具仅为底层 API 封装，LLM 就不得不每次重新完成多步调用的编排，并自行处理各步骤间的复杂依赖与串联逻辑。

例如，使用 Vercel API 部署一个项目：开发者通常会编写如下代码：

```tsx
1// 传统 API 调用方式：由开发者负责控制调用顺序

```javascript
const project = await client.projects.create({
  name: domain.replace(/\./g, '-'),
  gitRepository: { repo: repoUrl }
});
```

```javascript
const project = await client.projects.create({
  name: domain.replace(/\./g, '-'),
  gitRepository: { repo: repoUrl }
});
```

```javascript
await client.projects.createProjectEnv({
  idOrName: project.id,
  upsert: 'true',
  requestBody: Object.entries(env).map(([key, value]) => ({
    key, value
  }))
});
```

```javascript
await client.projects.createProjectEnv({
  idOrName: project.id,
  upsert: 'true',
  requestBody: Object.entries(env).map(([key, value]) => ({
    key, value
  }))
});
```

12    target: ['production', 'preview', 'development'],

12    目标环境：['production', 'preview', 'development'],

13    type: 'encrypted'

13    类型：'encrypted'

14  }))

14  }))

15});

15});

const deployment = await client.deployments.createDeployment({

const deployment = await client.deployments.createDeployment({

18  requestBody: {

18  请求体：{

19    name: project.name,

19    名称: project.name,

20    target: 'production',

20    目标环境: 'production',

21    gitSource: { type: 'github', repo: repo.replace('.git', ''), ref: 'main' }

21    gitSource: { type: 'github', repo: repo.replace('.git', ''), ref: 'main' }

22  }

23});


await client.projects.addProjectDomain({

26  idOrName: project.id,

27  requestBody: { domain: domain }

28});
```

这种方案涉及嵌套配置、跨调用的 ID 管理，以及仓库 URL 的解析。开发者只需一次性解决该问题，之后便可复用；而大语言模型（LLM）每次面对此任务时都如同初遇谜题，常常出错——例如嵌套层级错误，或遗漏必需字段。

## 单一流程工具 vs 多个独立端点

解决方案在于围绕用户的完整目标构建工具，而非围绕 API 的能力切分工具。与其提供四个彼此割裂的工具，不如构建一个统一的 `deploy_project` 工具，在其内部完整封装整个部署流程。

This changes everything about tool design:

这彻底改变了工具的设计方式：

|     |     |
| --- | --- |
| **API-shaped tools** | **Intention-based tools** |
| **面向 API 的工具** | **面向意图的工具** |
| `create_project`, `add_env`, `deploy`, `add_domain` | `deploy_project` |
| `create_project`、`add_env`、`deploy`、`add_domain` | `deploy_project` |
| Multiple calls with state management | Single atomic operation |
| 多次调用，需手动管理状态 | 单次原子操作 |
| Returns technical status codes | Returns conversational updates |
| 返回技术性状态码 | 返回面向对话的进展反馈 |
| LLM assembles the workflow | Tool owns the complete process |
| 由大语言模型（LLM）编排工作流 | 工具自身掌控完整流程 |

Consider the difference in practice. An API-shaped MCP server might expose these tools:

在实际应用中，二者差异显著。一个面向 API 的 MCP 服务器可能暴露如下工具：

```bash
create_project(name, repo)

add_environment_variables(project_id, variables)

create_deployment(project_id, branch)

add_domain(project_id, domain)
```

The LLM has to call each tool in sequence, pass IDs between calls, and handle potential failures at each step.

大语言模型（LLM）必须按顺序逐个调用这些工具，在各次调用间传递 ID，并在每一步都处理潜在的失败情况。

An intention-based tool looks different:

而一个面向意图的工具则截然不同：

```bash
deploy_project(repo_url, domain, environment_variables, branch="main")
```

This single tool handles the complete workflow internally and returns a conversational response. Instead of `{ status: 200, data: { id: "proj_123" } }`, the LLM can respond with "Project deployed at `example.com`. Build completed in 45s. All systems running normally."

该单一工具在内部处理完整工作流，并返回对话式响应。与返回 `{ status: 200, data: { id: "proj_123" } }` 不同，大语言模型（LLM）可直接回复：“项目已部署至 `example.com`，构建耗时 45 秒，所有系统运行正常。”

## Designing workflow based MCP tools

## 基于 MCP 工具设计工作流

Start by testing the workflow manually before writing any code. Take a real user request like "set up my project with authentication and a database" and walk through it step by step using your existing APIs. The parts that feel tedious or repetitive are good candidates for a single MCP tool.

在编写任何代码之前，先手动测试该工作流。选取一个真实用户请求（例如：“为我的项目配置身份认证和数据库”），并借助你现有的 API 逐步执行整个流程。其中感觉繁琐或重复的环节，正是构建单一 MCP 工具的理想候选。

Think of MCP tools as tailored toolkits that help an AI achieve a particular task, not as API mirrors. There may be multiple APIs and business logic behind a single MCP tool. If users think of something as one workflow, design it as one tool.

请将 MCP 工具视作专为帮助 AI 完成特定任务而定制的工具包，而非对底层 API 的简单镜像。单个 MCP 工具背后可能封装了多个 API 调用及复杂的业务逻辑。只要用户将其视为一个连贯的工作流，就应将其设计为一个统一的工具。

Here's how to structure a complete workflow tool:

以下是构建一个完整工作流工具的结构示例：

```tsx
server.tool(

2  "deploy_project",

3  "Deploy a project with environment variables and custom domain",

4  {

5    repo_url: z.string(),

6    domain: z.string(),

6    域名：z.string()，

7    environment_variables: z.record(z.string()),

7    环境变量：z.record(z.string())，

8    branch: z.string().default("main")

8    分支：z.string().default("main")

9  },

9  },

10  async ({ repo_url, domain, environment_variables, branch }) => {

10  async ({ repo_url, domain, 环境变量, branch }) => {

11    // Handle the complete workflow internally

11    // 在内部处理完整工作流

12    const project = await createProject(repo_url, branch);

12    const project = await createProject(repo_url, branch);

13    await addEnvironmentVariables(project.id, environment_variables);

13    await addEnvironmentVariables(project.id, 环境变量);

14    const deployment = await deployProject(project.id);

14    const deployment = await deployProject(project.id);

15    await addCustomDomain(project.id, domain);

15    await addCustomDomain(project.id, domain);

17    return {

18      content: [{\
\
19        type: "text",\
\
20        text: `Project deployed successfully at ${domain}. Build completed in ${deployment.duration}s.`\
\
21      }]

22    };

23  }

24);
```

使用普通代码实现确定性部分。API 调用顺序、错误恢复和状态管理等任务更适合通过常规编程实现。仅在真正需要推理能力或自然语言处理的环节才调用大语言模型（LLM）。

在真实场景中进行测试。将实际用户工作流运行于你的工具之上。当你观察到 LLM 多次尝试生成结果，或反复请求澄清时，这实际上是在向你反馈工具设计的问题。我们的目标是：复杂工作流在首次执行时即能成功完成。

## 使用工作流工具带来的性能提升

那些从“API 导向型工具”转向“工作流导向型工具”的团队，在可靠性和效率方面均取得了显著提升。

The common thread is how these tools are designed:

这些工具的设计共性在于：

- They focus on user intentions rather than API coverage

- 它们聚焦于用户意图，而非 API 覆盖面

- They handle complete workflows rather than exposing single operations

- 它们处理完整的业务流程，而非仅暴露单一操作

- They respond in a conversational way rather than returning technical codes

- 它们以对话式方式响应，而非返回技术性状态码

MCP works best when tools reflect complete user goals. LLMs do not manage state the way developers do, so building tools around workflows produces better results.

当工具能完整体现用户的最终目标时，MCP 效果最佳。大语言模型（LLM）管理状态的方式与开发者不同，因此围绕完整工作流来构建工具，能获得更优效果。

Give this approach a try. The [MCP handler](https://github.com/vercel/mcp-handler) makes it straightforward to expose your application logic as workflow based MCP tools. Get started with the [Next.js MCP template](https://vercel.com/templates/ai/model-context-protocol-mcp-with-vercel-functions) or [explore the documentation](https://vercel.com/docs/mcp).

欢迎尝试这一方法。[MCP handler](https://github.com/vercel/mcp-handler) 可帮助您轻松将应用逻辑封装为基于工作流的 MCP 工具。您可通过 [Next.js MCP 模板](https://vercel.com/templates/ai/model-context-protocol-mcp-with-vercel-functions) 快速上手，或 [查阅文档](https://vercel.com/docs/mcp) 进一步了解。