---
title: "Web Application Firewall control now available with vercel.json - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/web-application-firewall-control-now-available-with-vercel-json"
date: "2025-07-09"
scraped_at: "2026-03-02T09:31:16.635427396+00:00"
language: "en-zh"
translated: true
description: "You can now configure firewall mitigation rules through your vercel.json project configuration file. This is in addition to the existing dashboard and API support."
---

Jul 9, 2025

2025 年 7 月 9 日

You can now control Vercel’s Web Application Firewall (WAF) actions directly in [`vercel.json`](https://vercel.com/docs/project-configuration), alongside existing support in the dashboard, API, and terraform.

您现在可以直接在 [`vercel.json`](https://vercel.com/docs/project-configuration) 中控制 Vercel 的 Web 应用防火墙（WAF）操作，这与当前已在控制台、API 和 Terraform 中提供的支持并行共存。

This approach provides a structured way for both developers and agents to declaratively define and push rules to projects. Agents can use code-generating prompts to author new rules that are easily injected into the project’s `vercel.json.`

该方式为开发者和智能体（agents）提供了一种结构化的途径，以声明式方式定义规则并将其推送到项目中。智能体可借助代码生成类提示（code-generating prompts）编写新规则，并轻松注入到项目的 `vercel.json` 文件中。

The `has` and `missing` matchers have also [been enhanced](https://vercel.com/docs/project-configuration#route-has-and-missing-object-definition) to support more expressive conditions across headers, rewrites, redirects, and routes. Matching options include:

`has` 和 `missing` 匹配器也已[增强](https://vercel.com/docs/project-configuration#route-has-and-missing-object-definition)，现可在请求头（headers）、重写（rewrites）、重定向（redirects）及路由（routes）等各类场景中支持更丰富的条件表达能力。支持的匹配方式包括：

- 字符串相等性与不等性判断  
- 正则表达式匹配  
- 前缀与后缀匹配  
- 字符串数组中的包含与排除判断  
- 数值比较  

The following example shows how to deny a request that is prefixed by a specific header:

以下示例展示了如何拒绝带有特定前缀的请求头（header）的请求：

```json
1{

2  "$schema": "https://openapi.vercel.sh/vercel.json",

3  "routes": [\
\
4    {\
\
5      "src": "/(.*)",\
\
6      "has": [\
\
7        {\
\
8          "type": "header",\
\
9          "key": {\
\
10            "pre": "x-bad-header-"\
\
11          }\
\
12        }\
\
13      ],\
\
14      "mitigate": {\
\
15        "action": "deny"\
\
16      }\
\
17    }\
\
18  ]

19}
```

了解更多关于 [Vercel 的 Web 应用防火墙（WAF）](https://vercel.com/docs/vercel-firewall/vercel-waf) 以及如何在 `vercel.json` 中 [配置 WAF 规则](https://vercel.com/docs/vercel-firewall/vercel-waf/custom-rules#configuration-in-vercel.json)。