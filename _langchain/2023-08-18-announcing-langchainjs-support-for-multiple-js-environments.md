---
title: "Announcing LangChainJS Support for Multiple JS Environments"
source: "LangChain Blog"
url: "https://blog.langchain.com/js-envs/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:01:50.388581513+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
&#123;% raw %}

**TLDR:** We're announcing support for running [LangChain.js](https://github.com/hwchase17/langchainjs?ref=blog.langchain.com) in browsers, [Cloudflare Workers](https://workers.cloudflare.com/?ref=blog.langchain.com), [Vercel/Next.js](https://nextjs.org/?ref=blog.langchain.com), [Deno](https://deno.com/runtime?ref=blog.langchain.com), [Supabase Edge Functions](https://supabase.com/edge-functions?ref=blog.langchain.com), alongside existing support for Node.js ESM and CJS. See install/upgrade [docs](https://js.langchain.com/docs/getting-started/install?ref=blog.langchain.com) and **breaking changes [list](https://blog.langchain.com/js-envs/#breaking-changes)**.

**简明摘要：** 我们正式宣布 LangChain.js 现已支持在浏览器、[Cloudflare Workers](https://workers.cloudflare.com/?ref=blog.langchain.com)、[Vercel/Next.js](https://nextjs.org/?ref=blog.langchain.com)、[Deno](https://deno.com/runtime?ref=blog.langchain.com) 和 [Supabase Edge Functions](https://supabase.com/edge-functions?ref=blog.langchain.com) 中运行，同时继续完整支持 Node.js 的 ESM 和 CJS 模块格式。请查阅安装与升级指南 [文档](https://js.langchain.com/docs/getting-started/install?ref=blog.langchain.com)，以及 **破坏性变更 [清单](https://blog.langchain.com/js-envs/#breaking-changes)**。

## Context

## 背景

Originally we designed LangChain.js to run in [Node.js](https://nodejs.org/en?ref=blog.langchain.com), which is the longstanding serverside JavaScript runtime. Back in February (time flies!) we started to [collect feedback](https://github.com/hwchase17/langchainjs/discussions/152?ref=blog.langchain.com) from the community on what other JS runtimes we should support, and have since received tons of requests for getting LangChain running on browsers, [Deno](https://deno.com/runtime?ref=blog.langchain.com), [Cloudflare Workers](https://workers.cloudflare.com/?ref=blog.langchain.com), [Vercel/Next.js](https://nextjs.org/?ref=blog.langchain.com), [Vite](https://vitejs.dev/?ref=blog.langchain.com), [Supabase Edge Functions](https://supabase.com/edge-functions?ref=blog.langchain.com), etc.

最初，我们设计 LangChain.js 时目标运行环境是 [Node.js](https://nodejs.org/en?ref=blog.langchain.com)——这一长期主流的服务端 JavaScript 运行时。早在今年二月（时光飞逝！），我们便开始 [向社区征集反馈](https://github.com/hwchase17/langchainjs/discussions/152?ref=blog.langchain.com)，了解大家希望 LangChain.js 还应支持哪些其他 JavaScript 运行时；此后，我们收到了大量呼声，期待 LangChain 能在浏览器、[Deno](https://deno.com/runtime?ref=blog.langchain.com)、[Cloudflare Workers](https://workers.cloudflare.com/?ref=blog.langchain.com)、[Vercel/Next.js](https://nextjs.org/?ref=blog.langchain.com)、[Vite](https://vitejs.dev/?ref=blog.langchain.com)、[Supabase Edge Functions](https://supabase.com/edge-functions?ref=blog.langchain.com) 等环境中顺利运行。

## Changes to Enable Multiple Environments

## 为多环境兼容所作的变更

We've been on a journey since, together with community contributors, to enable support for as many JS environments as possible, some highlights along the way

自那以来，我们与社区贡献者携手同行，致力于让 LangChain.js 尽可能广泛地兼容各类 JavaScript 运行环境。以下是过程中的一些关键进展：

- converted our codebase to ESM [here](https://github.com/hwchase17/langchainjs/pull/124?ref=blog.langchain.com) (CJS users don't have to worry we offer a CJS build too)  
- 将代码库全面迁移至 ESM 模块格式 [[链接](https://github.com/hwchase17/langchainjs/pull/124?ref=blog.langchain.com)]（CJS 用户无需担忧——我们仍同步提供 CJS 构建版本）

- removed usage of node-only APIs where possible [here](https://github.com/hwchase17/langchainjs/pull/97?ref=blog.langchain.com) and [here](https://github.com/hwchase17/langchainjs/pull/213?ref=blog.langchain.com)  
- 尽可能移除了对 Node.js 专属 API 的依赖 [[链接1](https://github.com/hwchase17/langchainjs/pull/97?ref=blog.langchain.com)]、[[链接2](https://github.com/hwchase17/langchainjs/pull/213?ref=blog.langchain.com)]

- converted streaming and batch OpenAI requests to use `fetch` [here](https://github.com/hwchase17/langchainjs/pull/118?ref=blog.langchain.com) and [here](https://github.com/hwchase17/langchainjs/pull/526?ref=blog.langchain.com)  
- 将 OpenAI 的流式响应与批量请求统一重构为基于标准 `fetch` API 实现 [[链接1](https://github.com/hwchase17/langchainjs/pull/118?ref=blog.langchain.com)]、[[链接2](https://github.com/hwchase17/langchainjs/pull/526?ref=blog.langchain.com)]

- worked with the folks at Replicate to convert their SDK to use `fetch`  
- 与 Replicate 团队协作，将其 SDK 同步迁移至基于 `fetch` 的实现

- created packages that test importing LangChain in all the runtimes we support, see [here](https://github.com/hwchase17/langchainjs/blob/main/docker-compose.yml?ref=blog.langchain.com)  
- 构建了专用测试包，用于验证 LangChain 在所有支持运行时中的导入与加载行为，详见 [[链接](https://github.com/hwchase17/langchainjs/blob/main/docker-compose.yml?ref=blog.langchain.com)]

- and finally we have updated our exports to better support optional dependencies and produce smaller bundles, [here](https://github.com/hwchase17/langchainjs/pull/632?ref=blog.langchain.com)  
- 最后，我们优化了模块导出机制，以更合理地支持可选依赖，并生成体积更小的打包产物 [[链接](https://github.com/hwchase17/langchainjs/pull/632?ref=blog.langchain.com)]

At the beginning we designed the library so that you'd do use it like this

起初，我们设计该库时，预期用户会按如下方式使用：

```js
import { LLMChain } from "langchain/chains";
import { PromptTemplate } from "langchain/prompts";
import { OpenAI } from "langchain/llms";
import { SupabaseVectorStore } from "langchain/vectorstores";
import { CohereEmbeddings } from "langchain/embeddings";
import { GithubRepoLoader } from "langchain/document_loaders";
```

```js
import { LLMChain } from "langchain/chains";
import { PromptTemplate } from "langchain/prompts";
import { OpenAI } from "langchain/llms";
import { SupabaseVectorStore } from "langchain/vectorstores";
import { CohereEmbeddings } from "langchain/embeddings";
import { GithubRepoLoader } from "langchain/document_loaders";
```

The old way

旧式用法

But that posed a few problems when running outside of Node.js  

但这种写法在 Node.js 之外的环境中运行时，引发了一些问题。

- In order to support the growing AI ecosystem we add new integrations all the time, but we don't want the install size of the library to grow unbounded. Therefore we make third-party SDKs optional dependencies of `langchain`. While that works fine in Node.js, in browsers and other environments where code is bundled, it ends up being a pretty poor experience, with some of the many bundlers out there needing either some custom configuration by the user, or asking the user to install all optional dependencies.

- 为了支持日益壮大的 AI 生态系统，我们持续新增各类集成；但与此同时，我们不希望库的安装体积无限制增长。因此，我们将第三方 SDK 设为 `langchain` 的**可选依赖项（optional dependencies）**。这一设计在 Node.js 环境中运行良好；但在浏览器及其他需要代码打包（bundling）的环境中，却带来了较差的开发体验——许多主流打包工具要么要求用户手动配置（如 alias、external 或 resolve），要么直接要求用户安装全部可选依赖。

- When code is bundled, developers worry rightly about bundle size, and because not all bundlers support tree-shaking out-of-the-box, users of LangChain would end up with larger code bundles than they expected.

- 在代码被打包时，开发者理所当然地关注最终包体积；而由于并非所有打包工具都开箱即用地支持“摇树优化”（tree-shaking），LangChain 用户往往会得到远超预期的庞大代码包。

Not anymore! We've reworked how we expose third-party integrations, and the above code now becomes

不再如此！我们已重构第三方集成的导出方式，上述代码现在变为：

```js
import { LLMChain } from "langchain/chains";
import { PromptTemplate } from "langchain/prompts";
import { OpenAI } from "langchain/llms/openai";
import { SupabaseVectorStore } from "langchain/vectorstores/supabase";
import { CohereEmbeddings } from "langchain/embeddings/openai";
import { GithubRepoLoader } from "langchain/document_loaders/web/github";
```

This ensures you don't pull in code you're not using, and no bundlers choke on optional dependencies like before. Modules like `chains` and `prompts` that contain no third-party integrations remain as before.

这确保你仅引入实际使用的代码，且打包工具再也不会因可选依赖而报错或失效。像 `chains` 和 `prompts` 这类**不包含任何第三方集成**的模块，则保持原有导入方式不变。

Check out the install docs for more information on [how to upgrade](https://js.langchain.com/docs/getting-started/install?ref=blog.langchain.com).

请查阅安装文档，了解[如何升级](https://js.langchain.com/docs/getting-started/install?ref=blog.langchain.com)的更多详情。

### Breaking Changes

### 破坏性变更（Breaking Changes）

We had to make a few breaking changes to enable supporting multiple environments. These are limited to:

为支持多环境（Node.js / 浏览器 / Edge 等）运行，我们不得不引入若干破坏性变更。变更范围限定于以下两类：

- `import { Calculator } from "langchain/tools";` moved to `import { Calculator } from "langchain/tools/calculator";`

- `import { Calculator } from "langchain/tools";` 已迁移至 `import { Calculator } from "langchain/tools/calculator";`

- `import { loadLLM } from "langchain/llms";` moved to `import { loadLLM } from "langchain/llms/load";` and same for all other load\* functions

- `import { loadLLM } from "langchain/llms";` 已迁移至 `import { loadLLM } from "langchain/llms/load";`；其余所有以 `load*` 开头的函数（如 `loadChain`、`loadTool` 等）同理迁移。

**Deprecations**

**弃用提示（Deprecations）**

- We now require more granular imports for all 3rd-party integrations (i.e. changing `import {OpenAI} from "langchain/llms";` to `import {OpenAI} from "langchain/llms/openai";`. However, the old imports are still left around but deprecated. Please transition your code to use the new imports soon, as we plan to phase out the old imports!

- 我们现要求对**所有第三方集成**采用更细粒度的导入路径（例如：将 `import {OpenAI} from "langchain/llms";` 改为 `import {OpenAI} from "langchain/llms/openai";`）。不过，旧导入路径目前仍保留，但已被标记为**弃用（deprecated）**。请尽快将您的代码迁移到新导入方式——我们计划在未来版本中彻底移除旧导入路径！

## Testing

## 测试

Finally, a bit on how we test this to ensure we don't break compatibility with any environment in the future. For each new environment we want to support

最后，简要说明我们如何开展测试，以确保未来不会破坏与任何运行环境的兼容性。对于每一个我们希望支持的新环境：

- created a `test-exports-*` package in our monorepo containing a starter project created with that environment's tooling. eg. for Next.js with `npx create-next-app@latest`  
- 在我们的单体仓库（monorepo）中创建一个名为 `test-exports-*` 的测试包，其中包含使用该环境对应工具链生成的入门项目（starter project）。例如，针对 Next.js 使用 `npx create-next-app@latest` 创建。

- added some example usage of LangChain into that test package  
- 在该测试包中加入若干 LangChain 的示例用法。

- setup the package so that it contains both `build` and `test` scripts  
- 配置该包，使其同时包含 `build` 和 `test` 脚本。

- added to the list of packages tested in isolated docker containers in CI [here](https://github.com/hwchase17/langchainjs/blob/main/docker-compose.yml?ref=blog.langchain.com).  
- 将其添加至 CI 中在隔离 Docker 容器内进行测试的包列表中：[此处](https://github.com/hwchase17/langchainjs/blob/main/docker-compose.yml?ref=blog.langchain.com)。

- finally fix whatever issues come up, ensuring it doesn't break any other environments  
- 最后修复所有暴露出来的问题，并确保这些修复不会影响其他任何已支持环境。

If we're not testing with your favorite environment yet, we're very open to PRs that add more environments to be tested. Please let us know if you run into any issues running LangChain.js in a particular environment – we'd love to help!

如果您最喜爱的运行环境尚未被纳入我们的测试范围，我们非常欢迎提交 Pull Request（PR）来增加对更多环境的测试支持。若您在特定环境中运行 LangChain.js 时遇到任何问题，请务必告知我们——我们很乐意提供帮助！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/announcing-langchainjs-support-for-multiple-js-environments/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中推出端到端 OpenTelemetry 支持](images/announcing-langchainjs-support-for-multiple-js-environments/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/announcing-langchainjs-support-for-multiple-js-environments/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 人工智能现状》报告](images/announcing-langchainjs-support-for-multiple-js-environments/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/announcing-langchainjs-support-for-multiple-js-environments/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/announcing-langchainjs-support-for-multiple-js-environments/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/announcing-langchainjs-support-for-multiple-js-environments/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![借助 LangSmith SDK v0.2 实现更便捷的评估](images/announcing-langchainjs-support-for-multiple-js-environments/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/announcing-langchainjs-support-for-multiple-js-environments/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的新部署选项](images/announcing-langchainjs-support-for-multiple-js-environments/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
&#123;% endraw %}
