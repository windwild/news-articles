---
title: "Latency numbers every frontend developer should know - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/latency-numbers-every-web-developer-should-know"
date: "2024-04-23"
scraped_at: "2026-03-02T09:45:30.279901932+00:00"
language: "en-zh"
translated: true
description: "Latency numbers every web developer should know"
---

Apr 23, 2024

2024年4月23日

Jeff Dean 的《每位程序员都应了解的延迟数据》在前端领域的延伸解读。

网页加载时间及 Web 应用对用户操作的响应速度，是影响用户满意度的关键因素——而这两者往往主要受网络延迟制约。

延迟本身取决于用户的互联网接入方式（Wi-Fi、LTE、5G）、用户与目标服务器之间的物理距离，以及二者之间网络链路的质量。

尽管单次延迟数值看似微小，但其影响会快速叠加。例如，在一条往返延迟为 300ms 的链路上，若发生深度为 3 的[网络瀑布流（network waterfall）](https://developer.chrome.com/docs/devtools/network/reference#waterfall)，总延迟将高达 900ms。而 [React Server Components](https://vercel.com/blog/understanding-react-server-components) 等技术可将此类网络瀑布流迁移至服务端执行——在服务端，相同请求模式的耗时可能仅为客户端的 1/100。

| 指标 | 估算值 | 对性能指标的影响 |
| --- | --- | --- |
| **Wi-Fi 接入互联网的延迟**<br>Wi-Fi 本身引入的延迟极低；但在信号弱或硬件较旧时，该延迟可能上升。 | 1–4ms | [TTFB、FCP、LCP](https://vercel.com/docs/speed-insights/metrics#core-web-vitals-explained) |
| [**5G 高频段（毫米波）**](https://www.qualcomm.com/research/5g/5g-nr/mmwave) **接入互联网的延迟**<br>毫米波是当前已商用的最快移动通信技术；但仅适用于视线可达基站的高密度城区。 | 1–5ms | TTFB、FCP、LCP |
| **每帧（frame）的用户空间预算（60 帧/秒）**<br>在 60fps 设备上，每帧渲染周期为 16ms；但设备需预留部分时间用于实际帧处理。此处所列为开发者代码可用于计算待渲染内容的可用时间。 | 5–10ms | 流畅的帧率 |
| [**5G 中频段**](https://en.wikipedia.org/wiki/5G) **接入互联网的延迟**<br>这是常规 5G 连接的典型延迟；若信号不佳或基站过载，实际体验可能下降。 | 10–30ms | TTFB、FCP、LCP |
| **同云区域内部服务或数据库的往返延迟**<br>指访问部署在同一云区域、无需经由公网的其他服务所产生的延迟。 | 10ms | TTFB、FCP、LCP |
| [**LTE（4G）**](https://en.wikipedia.org/wiki/LTE_(telecommunication)) **接入互联网的延迟**<br>LTE（即 4G 蜂窝网络）的典型延迟。 | 15–50ms | TTFB、FCP、LCP |
| **60 帧/秒（[frames per second](https://en.wikipedia.org/wiki/Frame_rate)）下的单帧持续时间**<br>60fps 是显示设备最主流的刷新率；不过部分新型设备已支持 90fps 或 120fps 等更高帧率。 | 16ms | 流畅的帧率 |
| **同一大陆内跨城市的往返延迟**<br>若将服务部署于与用户同一大陆的区域，即可预期此类延迟；按 5000 公里距离测算，实际延迟可能略高或略低。 | 33ms | TTFB、FCP、LCP |
| **人类感知“时间流逝”的最短阈值**<br>当响应用户输入时，若延迟低于此范围，用户将感知为“瞬时响应”。[参考文献](https://www.researchgate.net/publication/225761257_Cognitive_processing_and_time_perception) | 40–80ms | [INP](https://vercel.com/resources/how-vercel-improves-your-websites-search-engine-ranking#optimizing-inp-stay-off-the-main-thread) |
| **解析 1MB CSS 所需时间**<br>CSS 解析是浏览器渲染网页所需执行的关键任务之一。 | 100ms | FCP、LCP |
| **解析 1MB HTML 所需时间**<br>HTML 解析同样是浏览器渲染网页的关键步骤；对于较短页面通常可忽略不计，但在超长文章等场景中可能成为显著瓶颈。 | 120ms | FCP、LCP |
| [**3G**](https://en.wikipedia.org/wiki/3G) **接入互联网的延迟**<br>3G 是目前仍在广泛使用的最慢蜂窝通信标准。 | 150ms | TTFB、FCP、LCP |
| **高质量网络下跨越地球两端的往返延迟** [**（冷土豆路由，cold potato routing）**](https://www.usenix.org/legacy/publications/library/proceedings/usenix02/full_papers/subramanian/subramanian_html/node28.html)<br>若将服务仅部署于单一区域，此即理论上最差的延迟表现。 | 150ms | TTFB、FCP、LCP |
| **解析 1MB JavaScript 所需时间**<br>JavaScript 解析对页面加载时间影响巨大，因其体积增长常快于 CSS 和 HTML。[代码分割（code-splitting）](https://web.dev/articles/code-splitting-with-dynamic-imports-in-nextjs) 是减小 JS 体积的最主要手段。 | 150ms | FCP、LCP、INP |
| **人类感知“迟滞感”的持续时间阈值**<br>当响应用户输入时，若延迟超过此值，用户将明显感到“需要等待”。200ms 同时也是 INP 评分中“需改进（Needs improvement）”的判定门槛。[详见](https://web.dev/articles/inp#good-score) | 200ms | INP |
| **无专用光纤条件下跨越地球两端的往返延迟** [**（热土豆路由，hot-potato routing）**](https://en.wikipedia.org/wiki/Hot-potato_routing)<br>当用户直连远端服务器，或使用低成本 CDN 时，数据包将沿成本最低路径转发，导致用户侧延迟可能翻倍。 | 300ms | TTFB、FCP、LCP |

## 方法论

与设备相关的数据均基于一台 2023 年高端 Android 手机实测得出。多数笔记本电脑性能更优，iPhone 表现亦更佳，而许多其他设备则可能更慢。

## 致谢

灵感源自 [Jeff Dean](https://twitter.com/JeffDean) 的经典文章《[每位程序员都应了解的延迟数据](https://brenocon.com/dean_perf.html)》。如需更多类似性能基准数据，请参阅 [Napkin Math](https://github.com/sirupsen/napkin-math)。