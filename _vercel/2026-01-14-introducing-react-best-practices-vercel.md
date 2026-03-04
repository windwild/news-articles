---
render_with_liquid: false
title: "Introducing: React Best Practices - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-react-best-practices"
date: "2026-01-14"
scraped_at: "2026-03-02T09:22:44.811176138+00:00"
language: "en-zh"
translated: true
description: "We've encapsulated 10+ years of React and Next.js optimization knowledge into react-best-practices, a structured repository optimized for AI agents and LLMs. "
---
render_with_liquid: false
render_with_liquid: false

Jan 14, 2026

2026 年 1 月 14 日

我们已将十余年 React 和 Next.js 性能优化经验，系统性地沉淀为 [`react-best-practices`](https://github.com/vercel-labs/agent-skills/tree/main/skills/react-best-practices) 项目——一个专为 AI 智能体（AI agents）和大语言模型（LLMs）优化的结构化代码仓库。

![](images/introducing-react-best-practices-vercel/img_001.jpg)![](images/introducing-react-best-practices-vercel/img_002.jpg)![](images/introducing-react-best-practices-vercel/img_003.jpg)![](images/introducing-react-best-practices-vercel/img_004.jpg)

React 性能优化工作通常——嗯，是“被动响应式”的：新版本发布后，应用变慢了，团队才开始追踪表象症状。这种方式成本高昂，且极易陷入错误的优化方向。

十余年来，我们在大量生产环境代码库中反复观察到相同的根源性问题：

- 异步任务意外地退化为串行执行  
- 客户端包体积随时间持续膨胀  
- 组件发生超出必要次数的重复渲染  

此处的根本原因很简单：这些问题并非微小的性能调优点；它们会直接体现为用户感知的等待时长、界面卡顿（jank），以及在每一次用户会话中反复发生的性能损耗。

因此，我们构建了这套 React 最佳实践框架，旨在帮助开发者更轻松地识别上述问题，并更快地加以修复。

### The core idea: ordering

### 核心理念：优先级排序

Most performance work fails because it starts too low in the stack.

大多数性能优化工作之所以失败，是因为它们从技术栈过低的层级开始着手。

If a request waterfall adds 600ms of waiting time, it doesn’t matter how optimized your `useMemo` calls are. If you ship an extra 300KB of JavaScript on every page, shaving a few microseconds off a loop won’t matter.

如果一次请求瀑布（request waterfall）带来了 600 毫秒的等待时间，那么你将 `useMemo` 调用优化得再好也无济于事；如果你在每个页面都多打包了 300KB 的 JavaScript，那么将某个循环耗时减少几微秒也毫无意义。

Performance work also compounds. A small regression you ship today becomes a long-term tax on every session until someone pays down the debt.

性能优化的效果具有复利效应；而今日引入的一处微小性能退化，将成为长期负担——它将持续拖累每一次用户会话，直至有人主动“偿还”这笔技术债。

So the framework starts with the two fixes that usually move real-world metrics first:

因此，该框架首先聚焦于两类通常能最先改善真实世界性能指标的优化：

1. Eliminate waterfalls  
1. 消除请求瀑布  

2. Reduce bundle size  
2. 减小包体积  

Then it moves on to server-side performance, client-side fetching, and re-render optimization.

随后，框架逐步深入至服务端性能、客户端数据获取以及重渲染优化等层面。

It includes 40+ rules across 8 categories, ordered by impact, from CRITICAL (eliminating waterfalls, reducing bundle size) to incremental (advanced patterns). ‍​‌ ‌ ‌

它涵盖 8 大类共 40 余条规则，按实际影响程度由高到低排序：从 **CRITICAL（关键级）** ——例如消除请求瀑布、减小包体积——到 **incremental（渐进式）** ——例如高级模式实践。

## What else is inside?

## 还包含哪些内容？

The repository covers eight performance categories:

该仓库涵盖八大性能类别：

- Eliminating async waterfalls

- 消除异步瀑布流（async waterfalls）

- Bundle size optimization

- 包体积优化（Bundle size optimization）

- Server-side performance

- 服务端性能（Server-side performance）

- Client-side data fetching

- 客户端数据获取（Client-side data fetching）

- Re-render optimization

- 重渲染优化（Re-render optimization）

- Rendering performance

- 渲染性能（Rendering performance）

- Advanced patterns

- 高级模式（Advanced patterns）

- JavaScript performance

- JavaScript 性能（JavaScript performance）


Each rule includes an impact rating (CRITICAL to LOW) to help prioritize fixes, plus code examples showing what breaks and how to fix it.

每条规则均包含一个影响等级评级（从 CRITICAL 到 LOW），以帮助确定修复的优先级；同时还提供代码示例，展示问题所在以及如何修复。

For example, here’s a common pattern that blocks unused code:

例如，以下是一种常见的会阻塞未使用代码的模式：

_Incorrect (blocks both branches):_

_错误（两个分支均被阻塞）：_

```typescript
async function handleRequest(userId: string, skipProcessing: boolean) {

2  const userData = await fetchUserData(userId)



4  if (skipProcessing) {

5    // Returns immediately but still waited for userData

6    return { skipped: true }

7  }

```

9  // Only this branch uses userData

9  // 只有此分支使用 userData

10  return processUserData(userData)

10  return processUserData(userData)

11}

11}

_Correct (only blocks when needed):_

_正确写法（仅在必要时才使用代码块）：_

```typescript
async function handleRequest(

2  userId: string,

3  skipProcessing: boolean

4) {

5  if (skipProcessing) {

6    return { skipped: true }

```

7  }


9  const userData = await fetchUserData(userId)

10  return processUserData(userData)

11}


```

单个规则文件会被编译为 `AGENTS.md`，这是一份统一文档，供你的智能体（agents）在审查代码或提出优化建议时查询。该文档旨在被一致遵循——包括执行重构任务的 AI 智能体在内，从而确保整个大型代码库中应用相同的决策标准。

## 这些实践是如何收集而来的

这些并非理论构想，而是源自对真实生产环境代码库所开展的实际性能优化工作。

若干示例：

![](images/introducing-react-best-practices-vercel/img_005.jpg)![](images/introducing-react-best-practices-vercel/img_006.jpg)

![](images/introducing-react-best-practices-vercel/img_005.jpg)![](images/introducing-react-best-practices-vercel/img_006.jpg)

**Combining loop iterations**

A chat page was scanning the same list of messages eight separate times. We combined it into a single pass, which adds up when you have thousands of messages.

**合并循环迭代**

一个聊天页面曾对同一消息列表单独扫描了八次。我们将它合并为单次遍历——当消息量达数千条时，这种优化效果尤为显著。

**Parallelizing awaits**

An API was waiting for one database call to finish before starting the next, even though they didn’t depend on each other. Running them at the same time cut the total wait in half.

**并行化 `await` 调用**

某个 API 在发起下一个数据库调用前，会等待前一个调用完成，尽管这些调用彼此之间并无依赖关系。改为并发执行后，总等待时间减少了一半。

**Lazy State Initialization**

A component was parsing a JSON config from `localStorage` on every render, even though it only needed it once for state initialization. Wrapping the it in a callback (`useState(() => JSON.parse(...))`) eliminated wasted work.

**惰性状态初始化（Lazy State Initialization）**

某个组件在每次渲染时都从 `localStorage` 解析一份 JSON 配置，但实际上该配置仅需在状态初始化时读取一次。将其封装为回调函数（`useState(() => JSON.parse(...))`）后，消除了重复的解析开销。

### Using `react-best-practices` in your coding agent

### 在您的编码智能体中使用 `react-best-practices`

These best practices are also packaged up as [Agent Skills](https://github.com/vercel-labs/agent-skills) that install into Opencode, Codex, Claude Code, Cursor, and other coding agents. When your agent spots cascading `useEffect` calls or heavy client-side imports, it can reference these patterns and suggest fixes.

这些最佳实践还被封装为 [Agent Skills](https://github.com/vercel-labs/agent-skills)，可安装至 Opencode、Codex、Claude Code、Cursor 及其他编码智能体中。当您的智能体检测到级联的 `useEffect` 调用或繁重的客户端导入时，即可参考这些模式并提出修复建议。

```bash
npx skills add vercel-labs/agent-skills
```

```bash
npx skills add vercel-labs/agent-skills
```

Check out the [`react-best-practices`](https://github.com/vercel-labs/agent-skills/tree/main/skills/react-best-practices) repository.

请查看 [`react-best-practices`](https://github.com/vercel-labs/agent-skills/tree/main/skills/react-best-practices) 仓库。