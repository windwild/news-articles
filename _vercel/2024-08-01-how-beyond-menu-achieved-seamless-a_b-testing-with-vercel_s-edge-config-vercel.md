---
title: "How Beyond Menu Achieved Seamless A/B Testing with Vercel’s Edge Config - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/beyond-menu-scaling-with-hypertune-and-vercel"
date: "2024-08-01"
scraped_at: "2026-03-02T09:42:09.061326569+00:00"
language: "en-zh"
translated: true
description: " Learn how Beyond Menu resolved feature flagging and A/B testing issues in serverless environments by integrating Hypertune with Vercel’s Edge Config, achieving seamless performance and improved use..."
---

render_with_liquid: false
Aug 1, 2024

2024 年 8 月 1 日

How Beyond Menu solved feature flagging and A/B testing challenges in serverless environments with Hypertune and Vercel’s Edge Config.

Beyond Menu 如何借助 Hypertune 与 Vercel 的 Edge Config，解决无服务器环境中的功能开关（feature flagging）与 A/B 测试难题。

Beyond Menu is a popular food delivery service in the US that connects restaurants and diners. Their Next.js app is deployed on Vercel and serves millions of hungry visitors every month.

Beyond Menu 是美国一家广受欢迎的餐饮外卖服务平台，致力于连接餐厅与食客。其基于 Next.js 构建的应用部署在 Vercel 上，每月为数百万饥肠辘辘的访客提供服务。

To scale their development, they decided to adopt feature flags for gradual rollouts, instant rollbacks, A/B testing, trunk-based development and easier collaboration both internally and with beta users.

为支撑开发规模的持续扩大，他们决定引入功能开关机制，以实现渐进式发布、即时回滚、A/B 测试、主干开发（trunk-based development），并提升团队内部及与测试用户之间的协作效率。

They knew they needed to evaluate feature flags and A/B tests on both the server and the client. And since they used the App Router, the solution needed to work with React Server Components, Client Components and different rendering modes like static, dynamic and partial prerendering.

他们深知，功能开关与 A/B 测试的评估逻辑必须同时覆盖服务端与客户端。此外，由于他们采用 Next.js 的 App Router，该方案还需兼容 React 服务端组件（Server Components）、客户端组件（Client Components），以及静态渲染、动态渲染和部分预渲染（partial prerendering）等多种渲染模式。

At Beyond Menu, every millisecond impacts conversion, so they turned to Vercel's Edge Config and Hypertune for seamless feature flag management without layout shifts.

在 Beyond Menu，每一毫秒都关乎转化率——因此，他们选择 Vercel 的 Edge Config 与 Hypertune，实现无缝的功能开关管理，且完全避免布局偏移（layout shifts）。

## Understanding the challenges of feature flag solutions

## 深入理解功能开关方案所面临的挑战

The team at Beyond Menu tried traditional tools for feature flags and A/B testing, but they weren’t optimized for their Next.js and Vercel setup.

Beyond Menu 团队曾尝试使用传统工具来实现功能开关与 A/B 测试，但这些工具并未针对其 Next.js 与 Vercel 技术栈进行优化。

### Unreliable flag updates at the edge

### 边缘节点上的功能开关更新不可靠

On the server, the solution needed to work in serverless and edge environments, specifically Vercel’s Node.js and Edge runtimes.

在服务端，该方案需适配无服务器（serverless）与边缘计算（edge）环境，尤其是 Vercel 提供的 Node.js 运行时与 Edge 运行时。

But traditional feature flag and A/B testing SDKs couldn’t reliably get flag updates in a serverless environment. They tried to fetch updates in the background but serverless instances were frozen between requests, preventing this. So flags couldn’t be updated.

但传统的功能开关（feature flag）和 A/B 测试 SDK 无法在无服务器（serverless）环境中可靠地获取开关更新。它们尝试在后台拉取更新，但无服务器实例在请求之间会被冻结，导致此操作失败。因此，开关状态无法及时更新。

The serverless instances were also short-lived so SDK initialization became a bottleneck, adding latency to requests.

此外，无服务器实例生命周期极短，导致 SDK 初始化成为性能瓶颈，增加了每次请求的延迟。

### Layout shift and UI flickers

### 布局偏移与 UI 闪烁

In the browser, they needed to use flags in the first client-side render.

在浏览器端，他们需要在首次客户端渲染（first client-side render）时即使用功能开关。

But traditional tools had separate SDKs for the server and the browser, and the browser SDK initialized independently of the main page load, causing layout shift and UI flickers, degrading the end-user experience.

但传统工具为服务端和浏览器分别提供了独立的 SDK；而浏览器端 SDK 的初始化与主页面加载过程相互解耦，导致页面布局偏移（layout shift）和 UI 闪烁（UI flickers），严重损害终端用户体验。

### Inflexible feature targeting and A/B testing

### 功能定向与 A/B 测试缺乏灵活性

As a two-sided marketplace, they needed the flexibility to target features and run A/B tests not just for logged-in users, but for anonymous visitors, restaurants, hostnames, etc.

作为双边市场平台，他们需要灵活地对各类对象进行功能定向和 A/B 测试——不仅限于已登录用户，还需覆盖匿名访客、餐厅、主机名（hostname）等多元实体。

However, traditional tools were primarily designed to target features and run A/B tests for logged-in users only, making this difficult.

然而，传统工具主要面向已登录用户设计功能定向与 A/B 测试能力，难以满足上述多样化需求。

They also needed a solution for both feature flags and A/B testing. But traditional tools treated these separately, so feature rollout logic was fragmented across different flags and systems that needed to be wrangled together. This added complexity and made feature rollouts difficult to manage.

他们还需要一套同时支持功能开关与 A/B 测试的统一方案。但传统工具将二者割裂处理，导致功能发布逻辑分散在不同开关和系统中，必须手动协调整合。这显著增加了系统复杂度，使功能发布变得难以管控。

## Implementing Edge Config for zero latency reads

## 采用 Edge Config 实现零延迟读取

They finally tried [Hypertune](https://www.hypertune.com/) and it was a perfect fit for their Next.js and Vercel setup.

他们最终试用了 [Hypertune](https://www.hypertune.com/)，结果发现它与他们的 Next.js 和 Vercel 架构完美契合。

They only needed to install one SDK that works across the server and the client, making it easy to use flags anywhere in their Next.js app.

他们只需安装一个 SDK，该 SDK 同时支持服务端和客户端运行，从而可在整个 Next.js 应用中任意位置便捷地使用功能开关（feature flags）。

On page load, they hydrate the SDK in the browser from the state of the SDK on the server, so they can use flags in the first client-side render with no layout shift or UI flickers.

页面加载时，他们在浏览器中基于服务端 SDK 的状态对客户端 SDK 进行“注水”（hydrate），从而可在首次客户端渲染中直接使用功能开关，且不会引发布局偏移（layout shift）或界面闪烁（UI flicker）。

The SDK is optimized for serverless and edge environments like Vercel’s Edge runtime. It evaluates flag logic, including A/B tests, in memory. And it exposes a method to refresh flag logic, that they call on every request, with configurable caching to only fetch updates if needed. This minimizes latency and bandwidth, maximizing performance and efficiency.

该 SDK 针对无服务器（serverless）及边缘计算环境（如 Vercel 的 Edge Runtime）进行了深度优化。它在内存中实时执行功能开关逻辑（包括 A/B 测试）。SDK 还提供了一个用于刷新开关逻辑的方法，Beyond Menu 在每次请求时都调用该方法，并通过可配置的缓存机制确保仅在必要时才拉取更新。此举显著降低了延迟与带宽消耗，从而最大化应用性能与运行效率。

By default, the SDK initializes and fetches updates from Hypertune Edge in typically less than 25ms, but Beyond Menu needed this to be even faster.

默认情况下，SDK 初始化并从 Hypertune Edge 获取更新通常耗时不到 25 毫秒；但 Beyond Menu 对响应速度提出了更高要求。

So they set up Hypertune’s Vercel integration to sync flag logic into Edge Config, Vercel’s global data store with ultra-low latency reads at the edge.

因此，他们启用了 Hypertune 提供的 Vercel 集成功能，将功能开关逻辑同步至 Vercel 的 Edge Config——这是一个面向全球部署、具备超低延迟边缘读取能力的数据存储服务。

Hypertune encodes flag logic, including A/B tests, in a JSON-serializable configuration language called Hyperlang that the SDK interprets at runtime.

Hypertune 将功能开关逻辑（包括 A/B 测试）编码为一种名为 Hyperlang 的、支持 JSON 序列化的配置语言；SDK 在运行时动态解析并执行该语言定义的逻辑。

For example, Beyond Menu have a feature flag that controls whether to play a certain recording when someone orders via their phone line. The flag logic is represented in Hyperlang as JSON:

例如，Beyond Menu 设置了一个功能开关，用于控制当用户通过电话线路下单时是否播放某段语音提示。该开关逻辑以 Hyperlang 形式表达为如下 JSON：

```json
1{

2  "recordingEnabled": {

3    "id": "S4fjQjxlvlZp-iQu2ThdX",

3    “id”：“S4fjQjxlvlZp-iQu2ThdX”，

4    "type": "FunctionExpression",

4    “type”：“FunctionExpression”，

5    "parameters": [\
\
6      {\
\
7        "id": "z_qLYfxnCCEROtA-yDM-5",\
\
8        "name": "recordingEnabledArgs"\
\
9      }\
\
10    ],

5    “parameters”：[\
\
6      {\
\
7        “id”：“z_qLYfxnCCEROtA-yDM-5”，\
\
8        “name”：“recordingEnabledArgs”\
\
9      }\
\
10    ]，

11    "body": {

11    “body”：{

12      "id": "PYIFmz8aDuhqmR5MfpeDS",

12      “id”：“PYIFmz8aDuhqmR5MfpeDS”，

13      "type": "SwitchExpression",

13      “type”：“SwitchExpression”，

14      "cases": [\
\
15        {\
\
16          "id": "uxf7zU4l8RRkOaUyVWYJY",\
\
17          "when": {\
\
18            "id": "uxf7zU4l8RRkOaUyVWYJY",\
\
19            "type": "ComparisonExpression",\
\
20            "a": {\
\
21              "id": "Yl5OOQFt9pt0uyLJCLMXc",\
\
22              "type": "GetFieldExpression",\
\
23              "object": {\
\
24                "id": "hR8nt_oNidp2aUzfWdKQc",\
\
25                "type": "VariableExpression",\
\
26                "variableId": "7eztbRoQZiAcpeFhYR9ym"\
\
27              },\
\
28              "fieldPath": "context > treeInfo > entityId"\
\
29            },\
\
30            "operator": "in",\
\
31            "b": {\
\
32              "id": "m5qIwGBxYkotOagAakm1M",\
\
33              "type": "ListExpression",\
\
34              "items": [\
\
35                {\
\
36                  "id": "IvAzZDICbMXDpKQGb-IVm",\
\
37                  "type": "IntExpression",\
\
38                  "value": 10001\
\
39                },\
\
40                {\
\
41                  "id": "bJmuxJxTwjmTVq6RDuFFT",\
\
42                  "type": "IntExpression",\
\
43                  "value": 52064\
\
44                }\
\
45              ]\
\
46            }\
\
47          },\
\
48          "then": {\
\
49            "id": "YICspIEzsr8CD89Tgs85w",\
\
50            "type": "BooleanExpression",\
\
51            "value": true\
\
52          }\
\
53        }\
\
54      ],

14      “cases”：[\
\
15        {\
\
16          “id”：“uxf7zU4l8RRkOaUyVWYJY”，\
\
17          “when”：{\
\
18            “id”：“uxf7zU4l8RRkOaUyVWYJY”，\
\
19            “type”：“ComparisonExpression”，\
\
20            “a”：{\
\
21              “id”：“Yl5OOQFt9pt0uyLJCLMXc”，\
\
22              “type”：“GetFieldExpression”，\
\
23              “object”：{\
\
24                “id”：“hR8nt_oNidp2aUzfWdKQc”，\
\
25                “type”：“VariableExpression”，\
\
26                “variableId”：“7eztbRoQZiAcpeFhYR9ym”\
\
27              }，\
\
28              “fieldPath”：“context > treeInfo > entityId”\
\
29            }，\
\
30            “operator”：“in”，\
\
31            “b”：{\
\
32              “id”：“m5qIwGBxYkotOagAakm1M”，\
\
33              “type”：“ListExpression”，\
\
34              “items”：[\
\
35                {\
\
36                  “id”：“IvAzZDICbMXDpKQGb-IVm”，\
\
37                  “type”：“IntExpression”，\
\
38                  “value”：10001\
\
39                }，\
\
40                {\
\
41                  “id”：“bJmuxJxTwjmTVq6RDuFFT”，\
\
42                  “type”：“IntExpression”，\
\
43                  “value”：52064\
\
44                }\
\
45              ]\
\
46            }\
\
47          }，\
\
48          “then”：{\
\
49            “id”：“YICspIEzsr8CD89Tgs85w”，\
\
50            “type”：“BooleanExpression”，\
\
51            “value”：true\
\
52          }\
\
53        }\
\
54      ]，

55      "default": {

55      “default”：{

56        "id": "wrL5fcyghlr4hdFqmlTbp",

56      “id”：“wrL5fcyghlr4hdFqmlTbp”，

57        "type": "BooleanExpression", 

57      “type”：“BooleanExpression”，

58        "value": false

58        “value”: false

59      },

59      },

60      "control": {

60      “control”: {

61        "id": "6RvRuA3ZezgLZ9UFHcoow",

61        “id”: “6RvRuA3ZezgLZ9UFHcoow”,

62        "type": "BooleanExpression",

62        “type”: “BooleanExpression”,

63        "value": true

63        “value”: true

64      }

64      }

65    }

65    }

66  }

66  }

67}  

67}

```

Hypertune writes this JSON to Beyond Menu’s Edge Config store whenever the flag logic is updated. And the SDK initializes and fetches updates directly from the Edge Config store, instead of from Hypertune Edge.

每当标志逻辑更新时，Hypertune 会将此 JSON 写入 Beyond Menu 的 Edge Config 存储中。而 SDK 则直接从 Edge Config 存储初始化并拉取更新，而非从 Hypertune Edge 获取。

![Ultra-low latency flag logic updates with Hypertune and Edge Config.](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_001.svg)  
![Hypertune 与 Edge Config 实现超低延迟的标志逻辑更新。](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_001.svg)  
Ultra-low latency flag logic updates with Hypertune and Edge Config.  
Hypertune 与 Edge Config 实现超低延迟的标志逻辑更新。

As a result, they consistently initialize the SDK on the server with ultra-low latency:

因此，他们始终能在服务端以超低延迟完成 SDK 初始化：

![](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_002.jpg)  
![](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_002.jpg)

In the Hypertune UI, they can define feature flags with flexible targeting rules and then embed A/B tests directly into their rules. So they can add rules to enable a feature for specific employees and beta users, and a final rule to A/B test the feature on everyone else. This lets them manage the full rollout of a feature from a single flag.

在 Hypertune 用户界面中，他们可以定义具备灵活定向规则的功能标志，并直接将 A/B 测试嵌入这些规则中。例如，可添加规则：向特定员工和测试用户启用某项功能；再添加一条最终规则：对其他所有用户开展该功能的 A/B 测试。由此，他们仅通过一个标志即可统筹管理整项功能的渐进式发布（full rollout）。

![Define flexible feature flags and embed A/B tests directly in Hypertune UI.](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_003.jpg)  
![在 Hypertune UI 中定义灵活的功能标志，并直接嵌入 A/B 测试。](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_003.jpg)  
Define flexible feature flags and embed A/B tests directly in Hypertune UI.  
在 Hypertune UI 中定义灵活的功能标志，并直接嵌入 A/B 测试。

They can also define custom input types like the current `User`, `Restaurant`, `Platform`, etc, with fields that they can use in their flag targeting.

他们还可定义自定义输入类型（如当前的 `User`、`Restaurant`、`Platform` 等），并为其配置可在标志定向中使用的字段。

![Add custom input types like User, Restaurant, and Platform for targeted flagging in Hypertune.](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_004.jpg)  
![在 Hypertune 中添加 User、Restaurant 和 Platform 等自定义输入类型，实现精准的标志定向。](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_004.jpg)  
Add custom input types like User, Restaurant, and Platform for targeted flagging in Hypertune.  
在 Hypertune 中添加 User、Restaurant 和 Platform 等自定义输入类型，实现精准的标志定向。

When they run `npx hypertune`, they get an auto-generated client that provides full end-to-end type-safety when they pass these inputs and when they access their flags. This ensures errors are caught at compile-time rather than runtime, and enables IDE features like code completion, “find all references” and JSDoc comments on hover, with flag descriptions and links to open flags in the UI. It also enables a compiler-driven workflow to deprecate flags and safely remove all their references.

当他们运行 `npx hypertune` 时，系统会自动生成一个客户端，为其传入上述输入及访问标志的操作提供端到端的完整类型安全性。这确保了错误可在编译期而非运行时被发现；同时支持 IDE 的多项高级功能，例如代码自动补全、快速查找全部引用（“find all references”）、鼠标悬停显示 JSDoc 注释（含标志描述及跳转至 UI 中对应标志页面的链接）。此外，该机制还支持基于编译器的工作流，用于标记标志为已弃用（deprecate），并安全地移除其所有引用。
```

![Run npx hypertune to get a type-safe, auto-generated client with IDE support and compile-time error checking.](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_005.jpg)  
![运行 `npx hypertune`，获取一个类型安全、自动生成的客户端，支持 IDE 智能提示与编译期错误检查。](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_005.jpg)

Run npx hypertune to get a type-safe, auto-generated client with IDE support and compile-time error checking.

运行 `npx hypertune`，获取一个类型安全、自动生成的客户端，支持 IDE 智能提示与编译期错误检查。

In the UI, type-safety prevents them incorrectly using inputs in their flag targeting rules and enables them to exhaustively match on `enum` inputs like the `Platform` or `Environment`.

在用户界面中，类型安全性可防止他们在标志（flag）定向规则中错误地使用输入参数，并支持对 `Platform` 或 `Environment` 等 `enum` 类型输入进行穷尽式匹配（exhaustive matching）。

All their flag changes are versioned in a Git-style history so they can quickly see what flags changed (and when) with visual diffs of each historical commit.

所有标志变更均以类似 Git 的版本历史方式记录，使他们能够快速查看哪些标志发生了变更（以及何时变更），并借助可视化差异（visual diff）对比每次历史提交的具体改动。

And just like with Git, they can create isolated branches to cleanly test and preview flag changes before merging them with a pull request. This has been particularly useful for refactors like cleaning up many flags in one go or changing the input types.

正如使用 Git 一样，他们可以创建隔离的分支，在通过拉取请求（pull request）合并前，干净利落地测试和预览标志变更。这一能力在重构场景中尤为实用——例如一次性清理大量标志，或统一变更输入类型。

Pull requests also enable them to safely onboard nontechnical team members, like PMs and designers, by requiring approvals for their changes.

拉取请求机制还支持他们安全地引入非技术团队成员（如产品经理和设计师），方法是要求其变更必须经过审批。

## Result

## 成果

With their new setup, Beyond Menu has been able to roll out and A/B test new features safely and reliably, with a robust developer and user experience, and with no impact to app performance, the end-user experience or conversion.

借助这一全新架构，Beyond Menu 已能安全、可靠地发布并开展新功能的 A/B 测试，在保障开发者与终端用户良好体验的同时，完全不影响应用性能、最终用户体验及转化率。

> “We tried many tools for feature flags and A/B testing but they weren’t optimized for our Next.js and Vercel setup, so they all added latency to our app. For us, every millisecond impacts conversion. Edge Config with Hypertune was the only solution that worked for us. It fit our stack perfectly and had the best performance, efficiency and integration.  
> We tried many tools for feature flags and A/B testing but they weren’t optimized for our Next.js and Vercel setup, so they all added latency to our app. For us, every millisecond impacts conversion. Edge Config with Hypertune was the only solution that worked for us. It fit our stack perfectly and had the best performance, efficiency and integration.”  
>   
> “我们尝试过多种功能标志（feature flag）与 A/B 测试工具，但它们均未针对我们的 Next.js 与 Vercel 技术栈进行优化，因而全部给应用引入了额外延迟。对我们而言，每一毫秒都关乎转化率。而结合 Hypertune 使用的 Edge Config，是唯一真正适配我们需求的解决方案——它与我们的技术栈完美契合，并在性能、效率与集成性方面表现最佳。  
> 我们尝试过多种功能标志（feature flag）与 A/B 测试工具，但它们均未针对我们的 Next.js 与 Vercel 技术栈进行优化，因而全部给应用引入了额外延迟。对我们而言，每一毫秒都关乎转化率。而结合 Hypertune 使用的 Edge Config，是唯一真正适配我们需求的解决方案——它与我们的技术栈完美契合，并在性能、效率与集成性方面表现最佳。”

> ![](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_006.jpg)  
> ![](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_006.jpg)

> **Rodney Cox,** President & CTO at Beyond Menu  
> **Rodney Cox**，Beyond Menu 公司总裁兼首席技术官（CTO）

## Beyond feature flags

## 不止于功能标志

Looking forward, they plan to use Edge Config with Hypertune to manage more complex app configuration like URL redirect maps, in-app copy and marketing content.

展望未来，他们计划借助 Edge Config 与 Hypertune 管理更复杂的应用配置，例如 URL 重定向映射表、应用内文案（in-app copy）以及营销内容。

They also plan to use Hypertune for product analytics, and for machine learning loops to automatically optimize key parts of their funnel.

他们还计划将 Hypertune 用于产品分析，以及通过机器学习闭环自动优化其转化漏斗中的关键环节。

## Get started

## 入门指南

You can get started with Edge Config and Hypertune by deploying the template in [one click](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fhypertunehq%2Fvercel-examples-fork%2Ftree%2Fmain%2Fedge-middleware%2Ffeature-flag-hypertune&env=NEXT_PUBLIC_HYPERTUNE_TOKEN,HYPERTUNE_ADMIN_TOKEN,EDGE_CONFIG,EDGE_CONFIG_HYPERTUNE_ITEM_KEY,FLAGS_SECRET&envDescription=Environment%20variables%20needed%20to%20use%20Hypertune%20with%20Vercel%20Edge%20Config%20and%20the%20Vercel%20Toolbar&envLink=https%3A%2F%2Fdocs.hypertune.com%2Fgetting-started%2Fvercel-quickstart&project-name=feature-flag-hypertune&repository-name=feature-flag-hypertune&demo-title=Hypertune%20with%20Vercel&demo-description=Use%20Hypertune%20with%20Vercel%20Edge%20Config%20and%20the%20Vercel%20Toolbar&demo-url=https%3A%2F%2Ffeature-flag-hypertune.vercel.app%2F&demo-image=https%3A%2F%2Ffeature-flag-hypertune.vercel.app%2Fdemo.png&integration-ids=oac_naLXREDG2o9KihTGYBVz9fVl) or reading the [docs](https://docs.hypertune.com/getting-started/next.js-app-router-quickstart).

您可通过 [一键部署](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fhypertunehq%2Fvercel-examples-fork%2Ftree%2Fmain%2Fedge-middleware%2Ffeature-flag-hypertune&env=NEXT_PUBLIC_HYPERTUNE_TOKEN,HYPERTUNE_ADMIN_TOKEN,EDGE_CONFIG,EDGE_CONFIG_HYPERTUNE_ITEM_KEY,FLAGS_SECRET&envDescription=Environment%20variables%20needed%20to%20use%20Hypertune%20with%20Vercel%20Edge%20Config%20and%20the%20Vercel%20Toolbar&envLink=https%3A%2F%2Fdocs.hypertune.com%2Fgetting-started%2Fvercel-quickstart&project-name=feature-flag-hypertune&repository-name=feature-flag-hypertune&demo-title=Hypertune%20with%20Vercel&demo-description=Use%20Hypertune%20with%20Vercel%20Edge%20Config%20and%20the%20Vercel%20Toolbar&demo-url=https%3A%2F%2Ffeature-flag-hypertune.vercel.app%2F&demo-image=https%3A%2F%2Ffeature-flag-hypertune.vercel.app%2Fdemo.png&integration-ids=oac_naLXREDG2o9KihTGYBVz9fVl) 模板，或阅读 [文档](https://docs.hypertune.com/getting-started/next.js-app-router-quickstart)，快速开始使用 Edge Config 和 Hypertune。

Blog post

博客文章

Dec 15, 2022

2022 年 12 月 15 日

### Introducing Edge Config: Globally distributed, instant configuration

### 推出 Edge Config：全球分发、即时生效的配置服务

![](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_007.jpg)![](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_008.jpg)![](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_009.jpg)+2

![](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_007.jpg)![](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_008.jpg)![](images/how-beyond-menu-achieved-seamless-a_b-testing-with-vercel_s-edge-config-vercel/img_009.jpg)+2

Dominik, Dom, and 2 others

多米尼克（Dominik）、多姆（Dom）及其他两位作者

Vercel.com landing page

Vercel.com 官网首页

### Stop configuring and start innovating.

### 停止繁琐配置，开启创新之旅。