---
title: "Transform rules are now available in vercel.json - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/transform-rules-are-now-available-in-vercel-json"
date: "2025-07-22"
scraped_at: "2026-03-02T09:31:12.176441751+00:00"
language: "en-zh"
translated: true
description: "Transform rules allow you to modify request headers, response headers, and request query parameters through the vercel.json."
---

Jul 22, 2025

2025 年 7 月 22 日

You can now define transform rules in [`vercel.json`](https://vercel.com/docs/project-configuration) to modify HTTP request and response headers or query parameters, without changing application code.

您现在可以在 [`vercel.json`](https://vercel.com/docs/project-configuration) 中定义转换规则（transform rules），在不修改应用代码的前提下，修改 HTTP 请求头、响应头或查询参数。

Unlimited transform rules are available for all customers, and let you:

所有客户均可无限制地使用转换规则，支持以下功能：

- Set, append, or delete request headers, response headers, and query parameters  
- 设置、追加或删除请求头、响应头及查询参数

- Use conditional logic to apply changes based on request metadata  
- 基于请求元数据，通过条件逻辑控制变更的触发

- Match by equality, inequality, prefixes, suffixes, inclusion in string arrays, or numeric comparisons for fine-grained control  
- 支持相等性、不等性、前缀、后缀、字符串数组包含关系或数值比较等多种匹配方式，实现精细化控制

Explore the [interactive transform rules playground](https://transforms-demo.vercel.app/) to see how this feature works.

欢迎访问 [交互式转换规则体验平台](https://transforms-demo.vercel.app/)，直观了解该功能的实际效果。

This expands the flexibility of Vercel's CDN, which already supports routing behavior like redirects and rewrites to external origins.

此举进一步提升了 Vercel CDN 的灵活性——其目前已支持重定向（redirects）、重写（rewrites）至外部源站等路由行为。

For example:

例如：

vercel.json

```json
1{

2  "$schema": "https://openapi.vercel.sh/vercel.json",

3  "routes": [\
\
4    {\
\
5      "src": "/(.*)",\
\
6      "dest": "https://my-secure-proxied-dashboard.com/$1"\
\
7      "transforms": [\
\
8        {\
\
9          "type": "request.headers",\
\
10          "op": "set",\
\
11          "target": {\
\
12            "key": "x-using-vercel-cdn"\
\
13          },\
\
14          "args": "secret-value"\
\
15        }\
\
16      ]\
\
17    }\
\
18  ]

19}
```

请参阅[转换规则文档](https://vercel.com/docs/project-configuration#transform-object-definition)，了解详细示例。