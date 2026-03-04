---
title: "Vercel Functions now support graceful shutdown - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-functions-now-support-graceful-shutdown"
date: "2025-09-08"
scraped_at: "2026-03-02T09:28:57.362986929+00:00"
language: "en-zh"
translated: true
description: "Vercel Functions running on the Node.js or Python runtimes now support graceful shutdown, allowing to run cleanup tasks for up to 500 milliseconds just before shutting down."
---
{% raw %}

Sep 8, 2025

2025 年 9 月 8 日

Vercel Functions running on Node.js and Python runtimes now support graceful shutdown, giving you up to 500 milliseconds to run cleanup tasks before termination.

基于 Node.js 和 Python 运行时的 Vercel Functions 现已支持优雅关闭（graceful shutdown），您可在函数终止前最多获得 500 毫秒时间来执行清理任务。

When a function is terminated, such as during scale-down, the runtime receives a `SIGTERM` signal. You can now use this signal to run cleanup tasks like closing database connections or flushing external logs.

当函数被终止（例如在缩容过程中），运行时会收到 `SIGTERM` 信号。您现在可利用该信号执行清理任务，例如关闭数据库连接或刷新外部日志。

```javascript
process.on('SIGTERM', () => {

2  console.log('Cleanup goes here');

3});



export default {

6  fetch() {

7    return new Response('Hi from a Vercel Function!');
```

8  }

9}
```

Learn more about the [SIGTERM signal](https://vercel.com/docs/functions/functions-api-reference#sigterm-signal).

了解更多关于 [SIGTERM 信号](https://vercel.com/docs/functions/functions-api-reference#sigterm-signal) 的信息。
{% endraw %}
