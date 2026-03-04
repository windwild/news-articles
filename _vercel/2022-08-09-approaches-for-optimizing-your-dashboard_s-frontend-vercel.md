---
render_with_liquid: false
title: "Approaches for optimizing your dashboard's frontend - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-we-made-the-vercel-dashboard-twice-as-fast"
date: "2022-08-09"
scraped_at: "2026-03-02T10:01:00.869932163+00:00"
language: "en-zh"
translated: true
description: "Let’s review the techniques and strategies we used to improve the Vercel Dashboard so you can make a data-driven impact on your application. "
---
render_with_liquid: false
render_with_liquid: false

Aug 9, 2022

2022年8月9日

我们为优化 Dashboard 以提升用户体验所采用的技术与策略。

我们希望 Vercel Dashboard 对每一位客户都保持高速响应，尤其是在持续新增和改进功能的过程中。为提升我们的 [核心网页指标（Core Web Vitals）](https://vercel.com/blog/core-web-vitals)，工程团队将 Dashboard 的 Lighthouse 评分从 51 分大幅提升至 94 分。

我们借助 [Vercel Analytics](https://vercel.com/analytics) 长期追踪用户实际体验，证实了这些优化确实带来了真实、可观的改善：Vercel Analytics 的平均得分从 90 分提升至 95 分（桌面端）。接下来，我们将回顾所采用的各项技术与策略，助您在自己的应用中实现数据驱动的性能优化。

## 优先优化最关键的部分

您的用户期望页面能够快速加载。应用中某些部分对整体性能的影响远超其他部分——这取决于它们被执行的频率，或其工作负载的繁重程度。我们将这类关键执行路径称为“热点路径（hot paths）”。

在前端应用中，热点路径通常对应着页面的首次加载过程。缩短热点路径的耗时，意味着更快的页面加载速度、更佳的用户体验，以及更优的核心网页指标（Core Web Vitals）。我们借助若干强大工具，成功优化了 [首次内容绘制（First Contentful Paint, FCP）、最大内容绘制（Largest Contentful Paint, LCP）以及首次输入延迟（First Input Delay, FID）](https://web.dev/metrics/) 等关键指标。

![提升页面性能可改善用户体验，并提升搜索引擎优化（SEO）效果。](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_001.jpg)![提升页面性能可改善用户体验，并提升搜索引擎优化（SEO）效果。](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_002.jpg)![提升页面性能可改善用户体验，并提升搜索引擎优化（SEO）效果。](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_001.jpg)![提升页面性能可改善用户体验，并提升搜索引擎优化（SEO）效果。](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_002.jpg)提升页面性能可改善用户体验，并提升搜索引擎优化（SEO）效果。

## 指导优化的实用工具

要定位哪些代码位于您的热点路径上，请使用 [Chrome 开发者工具（Chrome DevTools）](https://developer.chrome.com/docs/devtools/evaluate-performance/) 和 [React 开发者工具（React Developer Tools）](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en)。Chrome DevTools 适用于任意 Web 应用的性能调试，而 React 开发者工具则专为诊断 React 应用而设计。这些工具可生成火焰图（flame graphs）、统计图表及时间轴，帮助您深入剖析应用的运行细节。

But Devtools will only tell you part of the story—a single point in time. You can diagnose the page that you just loaded—but what if we had a way to determine which paths are the most important to our application over time?

但 DevTools 只能告诉你故事的一部分——某个时间点的快照。你可以诊断刚刚加载的页面，但如果有一种方法能帮我们确定哪些路径在长期运行中对应用最为关键，又会怎样呢？

With Vercel, [Top Paths](https://vercel.com/docs/concepts/limits/usage#top-paths) answers this question. Top Paths shows you which assets your site’s users are downloading most often and how heavy those paths are.

借助 Vercel 的 [Top Paths（热门路径）](https://vercel.com/docs/concepts/limits/usage#top-paths)，这一问题便迎刃而解。Top Paths 会向你展示网站用户下载最频繁的资源，以及这些路径所承载的数据量（即负载大小）。

You’ll be able to quickly find which images, static data, and other assets are the most important ones for you to optimize, focusing your efforts where they matter most. Top Paths is currently available for all Vercel plans.

你将能快速识别出哪些图片、静态数据及其他资源是你最需要优化的关键资产，从而集中精力于真正影响性能的核心环节。目前，Top Paths 功能已面向所有 Vercel 计划开放。

![Vercel Top Paths show the heaviest asset payloads being used in your project.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_005.jpg)![Vercel Top Paths show the heaviest asset payloads being used in your project.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_006.jpg)![Vercel Top Paths show the heaviest asset payloads being used in your project.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_005.jpg)![Vercel Top Paths show the heaviest asset payloads being used in your project.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_006.jpg)Vercel Top Paths show the heaviest asset payloads being used in your project.

![Vercel Top Paths 展示了你的项目中正在使用的最重资产负载。](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_005.jpg)![Vercel Top Paths 展示了你的项目中正在使用的最重资产负载。](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_006.jpg)![Vercel Top Paths 展示了你的项目中正在使用的最重资产负载。](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_005.jpg)![Vercel Top Paths 展示了你的项目中正在使用的最重资产负载。](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_006.jpg)Vercel Top Paths 展示了你的项目中正在使用的最重资产负载。

## Your page–faster

## 让你的页面更快

Now that we know where to look, let’s figure out how to get those paths shorter.

既然我们已明确优化重点，接下来就该思考如何缩短这些关键路径了。

After identifying the hot path on the Dashboard, we were able to find plenty of high value opportunities. Here are some of the strategies we used to improve the performance of the Vercel Dashboard.

在识别出仪表板（Dashboard）中的热点路径后，我们发现了大量高价值的优化机会。以下是我们为提升 Vercel 仪表板性能所采用的部分策略。

### JavaScript

### JavaScript

JavaScript gives the page interactivity, but is also the heaviest, slowest asset we send to the browser in modern applications. For performance, the less JavaScript, the better.

JavaScript 赋予网页交互能力，但在现代 Web 应用中，它同时也是发送至浏览器的最庞大、最耗时的资源。就性能而言，JavaScript 越少越好。

**Be mindful of your utility functions.**  

**谨慎使用工具函数（utility functions）。**

Our `isLoggedIn()` utility checks for a user's authentication by reading a `document.cookie` value. This is quick when it happens once - but we were calling `isLoggedIn()` over 400 times in one render pass.

我们的 `isLoggedIn()` 工具函数通过读取 `document.cookie` 的值来检查用户是否已认证。单次执行时速度很快——但在某一次渲染过程中，我们竟调用了该函数超过 400 次。

With some rearchitecting, we were able to remove many of these calls, bringing a ~270ms render time down to just ~90ms.

经过部分架构重构，我们成功移除了其中大量调用，将渲染时间从约 270 毫秒大幅降低至仅约 90 毫秒。

**Leverage the effects of caching.**

**善用缓存效应。**

On the Vercel Dashboard, we are using a `slugify` function that takes 1-3ms to evaluate. While that’s fast only once, we were calling this function hundreds of times for our initial render. Once we cached the computed results, we made the render process ~200ms faster.

在 Vercel 控制台中，我们使用了一个 `slugify` 函数，单次执行耗时 1–3 毫秒。虽然单次执行很快，但在首次渲染时，该函数却被调用了数百次。一旦我们对计算结果进行缓存，渲染过程便提速了约 200 毫秒。

```javascript
1// Create a cache using an empty object

1// 使用空对象创建缓存

const slugifyCache = { }



const cachedSlugify = (text: string) => {

5  // If this value has already been computed,

5  // 如果该值此前已被计算过，

6  // it will be a property on the cache object.

6  // 它将作为属性存在于缓存对象中。
```

7  if (slugifyCache[text]) {

7  如果 `slugifyCache[text]` 存在：

8    return slugifyCache[text]

8    则返回 `slugifyCache[text]`

9  }



11  // If this is the first time we are seeing this string,

11  // 如果这是首次遇到该字符串，

12  // we will store it in our cache and return the slug.

12  // 我们将把它存入缓存，并返回生成的 slug。

13  return (slugifyCache[text] = slugify(text))

13  返回 `(slugifyCache[text] = slugify(text))`

14}
```

**Know your imported code.**

**了解你所引入的代码。**

Libraries often have to cover all sorts of edge cases to take care of thousands of developers. While that provides for a generally safe experience, that safety often means more code to execute.

库通常需要覆盖各种边界情况，以满足成千上万开发者的使用需求。虽然这能提供总体上更安全的体验，但这种安全性往往意味着需要执行更多代码。

Does your use case of the library need to cover those edge cases? If not, can you write your own function in a more efficient way?

您的库使用场景是否需要覆盖这些边界情况？如果不需要，您能否以更高效的方式自行编写函数？

**Strategically lazy load heavy components**.

**策略性地懒加载重型组件**

Elements that aren’t in your user’s viewport on page load can have their render delayed. First, let's build a hook for detecting if an element is in the viewport.

页面加载时，位于用户视口之外的元素可以延迟其渲染。首先，我们来构建一个用于检测元素是否处于视口内的 Hook。

```jsx
const useInViewport = (ref: any) => {

2  const [isInViewport, setIsInViewport] = useState(false)

3  const [isLoaded, setIsLoaded] = useState(false)



5  useEffect(() => {

6    const observer = new IntersectionObserver(

7      ([entry]) => {

8        if (entry.isIntersecting) {

8        如果 `entry.isIntersecting` 为真：

9          setIsLoaded(true)

9          设置 `isLoaded` 为 `true`

10        }



12        setIsInViewport(entry.isIntersecting)

12        设置 `isInViewport` 为 `entry.isIntersecting` 的值

13      }

13      }

14    )

14    )



16    if (ref.current) {

16    如果 `ref.current` 存在：

17      observer.observe(ref.current)

17      让 `observer` 观察 `ref.current`

18    }

19  }, [ref])

18    }

19  }, [ref])

21  return  isInViewport || isLoaded

21  返回 isInViewport || isLoaded

22}
22}

Now, let's use it. The `200vh` element will push the `<HeavyChildComponent />` below our viewport on page load. Before you scroll down, check your browser's Devtools. You'll notice that the HTML markup for this React component hasn't loaded into the DOM yet.

现在，让我们来使用它。`200vh` 元素会在页面加载时将 `<HeavyChildComponent />` 推至视口下方。在向下滚动之前，请检查浏览器的开发者工具（DevTools）。你会注意到，该 React 组件的 HTML 标记尚未加载到 DOM 中。

```jsx
const HeavyChildComponent = () => {

2  return (

3    <div>

4      <p>I am a heavy component!</p>
```jsx
const HeavyChildComponent = () => {

2  返回 (

3    <div>

4      <p>我是一个开销很大的组件！</p>

5    </div>

5    </div>

6  )

6  )

7}

7}

const ParentComponent = () => {

const ParentComponent = () => {

10  const childRefContainer = useRef(false)

10  const childRefContainer = useRef(false)

11  const isRendered = useInViewport(childRefContainer)

11  const isRendered = useInViewport(childRefContainer)

13  return (

13  return (

14    <> 

14    <>

15      <div style={{height: "200vh"}}></div>

15      <div style={{height: "200vh"}}></div>

16        <div ref={childRefContainer as any}>

16        <div ref={childRefContainer as any}>

17          { isRendered && <HeavyChildComponent /> }

17          { isRendered && <HeavyChildComponent /> }

18        </div>

18        </div>

19    </>

19    </>

20  )

20  )

21}
```

21}
```

**Third-party scripts**

**第三方脚本**

You’ll often need to introduce third-party scripts for analytics, A/B testing, and more. While these scripts can have negative impacts on page performance, we can minimize their effects on LCP and FID with the right techniques.

您通常需要引入第三方脚本来实现数据分析、A/B 测试等功能。尽管这些脚本可能对页面性能产生负面影响，但通过恰当的技术手段，我们可以最大限度地降低其对 LCP（最大内容绘制）和 FID（首次输入延迟）的影响。

- Most popular packages use “tree-shaking” to remove unused code automatically for the smallest JavaScript bundles. Ensure you’re using correct ES Modules imports as shown below.

- 大多数主流软件包采用“摇树优化（tree-shaking）”技术，自动移除未使用的代码，从而生成体积最小的 JavaScript 包。请确保您使用的是如下所示的正确 ES Modules 导入方式。

```javascript
1// Before

2// This line imports the entire Sentry package!

import Sentry from '@sentry/nextjs'



5// After

6// Only bring in the code that it needs.

import { captureException } from '@sentry/nextjs'
```

```javascript
1// 之前

2// 此行导入了整个 Sentry 包！

import Sentry from '@sentry/nextjs'



5// 之后

6// 仅引入实际需要的代码。

import { captureException } from '@sentry/nextjs'
```

- Some packages ( [like Stripe](https://github.com/stripe/stripe-js#importing-loadstripe-without-side-effects)) have the ability to lazy load their `script` until your user needs it. Less initial code, quicker page loads.

- 某些包（[例如 Stripe](https://github.com/stripe/stripe-js#importing-loadstripe-without-side-effects)）支持延迟加载其 `script`，直到用户真正需要时才加载。这样可减少初始代码体积，加快页面加载速度。

- Choosing the right `next/script` strategy is crucial to improving the performance of your third party scripting. For example, Google Tag Manager can be lazily loaded to noticeably improve LCP and FID. Check [the strategies included in the next/script documentation for more](https://nextjs.org/docs/basic-features/script#strategy).

- 选择合适的 `next/script` 加载策略，对提升第三方脚本的性能至关重要。例如，Google Tag Manager 可通过延迟加载显著改善最大内容绘制（LCP）和首次输入延迟（FID）。更多详情请参阅 [Next.js 官方文档中关于 `next/script` 的策略说明](https://nextjs.org/docs/basic-features/script#strategy)。

### HTML + CSS

### HTML + CSS

Optimizing HTML and CSS offers us the smallest performance gains because of how quickly modern browsers parse the DOM. But we can still find small wins that add up to meaningful change.

优化 HTML 和 CSS 带来的性能提升通常最小，这是因为现代浏览器解析 DOM 的速度极快。但我们仍可发现一些微小的优化点，积少成多，最终带来显著的改进。

**Find needless markup duplications.**

**查找不必要的标记重复。**

React makes it easy to reuse code. This is great—but has a dark side since we can also reuse _unoptimized_ code. If you’re introducing purposeless tags in your JSX, eliminate them. If you’re writing the same CSS multiple times, think about some reusable CSS class declarations.

React 让代码复用变得非常容易——这固然很好，但也存在隐患：我们同样可能复用那些 _未经优化的_ 代码。如果你在 JSX 中引入了无意义的标签，请将其移除；如果你多次重复编写相同的 CSS 样式，请考虑提取为可复用的 CSS 类声明。

```jsx
1// Before

1// 优化前

const Paragraph = (props) => {

3  return (

4    <div>

5      <p>{ props.children }</p>

6    </div>

7  )
```

8}


10// After

8}


10// 之后

const Paragraph = (props) => {

const Paragraph = (props) => {

12  return (

12  return (

13    // No more wrapper div! The p tag already defaults to display: block;

13    // 不再需要包装用的 div！`p` 标签默认就是 `display: block`；

14    // so this change won't change the final render.

14    // 因此这一改动不会影响最终渲染效果。

15    <p style={{ props.style }}>{ props.children }</p>

15    <p style={{ props.style }}>{ props.children }</p>

16  )

16  )

17}
```
17}
```

**Leverage Next.js optimizations.**

**利用 Next.js 的优化功能。**

`<Image />` will deliver the optimal image size for your user’s device, ensuring minimal image processing, and, in turn, speeding up page loads. Additionally, Next.js will [automatically inline font CSS](https://nextjs.org/docs/basic-features/font-optimization) at build time, eliminating an extra fetch for font declarations.

`<Image />` 组件会为用户设备提供最适配的图像尺寸，最大限度减少图像处理开销，从而加快页面加载速度。此外，Next.js 会在构建时[自动内联字体 CSS](https://nextjs.org/docs/basic-features/font-optimization)，避免额外发起字体声明的网络请求。

```jsx
1// Before

1// 优化前

const ImageWithCaption = (props) =>  {

3  return (

4    <figure>

5      // Image source is way too large for mobile!

5      // 图像源文件对移动端而言过大！

6      <img src="./images/sample-img.png" alt="This is a sample image!" />

6      <img src="./images/sample-img.png" alt="这是一张示例图片！" />

7      <figcaption>{props.figCaption}</figcaption>

7      <figcaption>{props.figCaption}</figcaption>

8    </figure>
```

9  )

9  )

10}

10}

12// After

12// 修改后

import Image from "next/image"

import Image from "next/image"

const ImageWithCaption = (props) =>  {

const ImageWithCaption = (props) =>  {

16  return (

16  return (

17    <figure>

17    <figure>

18      // Delivers correct size for user

18      // 为用户交付正确的尺寸

19      <Image

19      <Image

20        src="./images/sample-img.png"

20        src="./images/sample-img.png"

21        alt="This is a sample image!"

21        alt="这是一张示例图片！"

22        layout="responsive"

22        layout="responsive"

23        width={200}

23        width={200}

24        height={100}

24        height={100}

25      />

25      />

26      <figcaption>{props.figCaption}</figcaption>

26      <figcaption>{props.figCaption}</figcaption>

27    </figure>

27    </figure>

28  )

28  )

29}
```

**使用可变字体（Variable Fonts）。**

传统字体文件仅包含一种字体样式，但要为您的应用程序创建精美的排版效果，您通常需要多种字体变体。而可变字体只需加载**单个文件**，即可通过一条 `@font-face` 规则定义该字体的_所有_变体。

```javascript
1@font-face {

2  font-family:'Inter';

3  src:url('Inter.woff2')format('woff2')tech('variations'),

4  url('Inter')format('woff2-variations');

5  font-weight: 100 1000; // 该属性声明所支持的取值范围

6  font-stretch: 25% 150%;

7}
```

**Let the browser work for you.**

**让浏览器为你工作。**

Assigning properties to their browser defaults can add up over time—without bringing any new styles to the page. Continue reducing the size of your markup by letting the browser use its defaults rather than declaring those CSS properties yourself.

为属性显式设置浏览器默认值，长期积累下来会增加代码体积——却并未为页面带来任何新的样式效果。继续通过让浏览器使用其默认值，而非在 CSS 中手动声明这些属性，来减小你的 HTML 标记体积。

```jsx
1// Before

1// 之前

const ReusableSection = ( props ) => {

3  return (

4    // Setting 0 for the margin is the browser default.

4    // 将外边距设为 0 是浏览器的默认行为。

5    // This will have no styling effect,

5    // 这不会产生任何样式效果，

6    // but it will add bloat to your final HTML.

6    // 却会使最终生成的 HTML 变得臃肿。

7    <div style={{ marginTop: props.marginTop || 0 }}>

7    <div style={{ marginTop: props.marginTop || 0 }}>

8      <p style={{ paddingBottom: props.paragraphBottomPad || 0 }}>
8      <p style={{ paddingBottom: props.paragraphBottomPad || 0 }}>
```

9        {props.paragraph}

9        {props.paragraph}

10      </p>

10      </p>

11    </div>

11    </div>

12  )

12  )

13}



13}



15// After

15// 修改后

const ReusableSection = (props) => {

const ReusableSection = (props) => {

17  return (

17  return (

18    // This style tag will no longer be a part of your final HTML.

18    // 此 `<style>` 标签将不再包含在最终生成的 HTML 中。

19    <div style={{ marginTop: props.marginTop || undefined }}>

19    <div style={{ marginTop: props.marginTop || undefined }}>

20      <p style={{ paddingBottom: props.paragraphBottomPad || undefined }}>

20      <p style={{ paddingBottom: props.paragraphBottomPad || undefined }}>

21        {props.paragraph}

21        {props.paragraph}

22      </p>

22      </p>

23    </div>

23    </div>

24  )

24  )

25}
```

25}
```

## Use data to improve user experience

## 利用数据提升用户体验

As your application grows, it can be hard to maintain performance. Scaling can be difficult. New features are often in high demand. And the needs of a growing business can take the focus off of application performance.

随着应用规模不断扩大，维持其性能可能变得十分困难；横向扩展（scaling）也颇具挑战。新功能往往需求迫切，而业务持续增长所带来的种种需求，又容易使团队将注意力从应用性能上转移开。

[Vercel Analytics](https://vercel.com/docs/concepts/analytics) and [Top Paths](https://vercel.com/docs/concepts/limits/usage#top-paths) allowed us to quickly peek into our Dashboard and find where it was underperforming. That meant less time diagnosing, and a better opportunity for our developers to focus on performance.

[Vercel Analytics](https://vercel.com/docs/concepts/analytics) 和 [Top Paths](https://vercel.com/docs/concepts/limits/usage#top-paths) 使我们能够快速查看仪表板（Dashboard），迅速定位性能瓶颈所在。这不仅大幅减少了问题诊断所耗费的时间，更让我们的开发人员得以将更多精力聚焦于性能优化。

As a part of our continued effort to help developers improve their application performance, we're looking to add automated reporting on regressions for your Vercel Analytics data.

作为我们持续助力开发者提升应用性能工作的一部分，我们正计划为您的 Vercel Analytics 数据新增自动化的回归问题报告功能。

![Vercel Analytics show how your application is performing over time for real users.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_009.jpg)![Vercel Analytics show how your application is performing over time for real users.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_010.jpg)![Vercel Analytics show how your application is performing over time for real users.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_009.jpg)![Vercel Analytics show how your application is performing over time for real users.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_010.jpg)Vercel Analytics show how your application is performing over time for real users.

![Vercel Analytics 展示您的应用面向真实用户时的长期性能表现。](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_009.jpg)![Vercel Analytics 展示您的应用面向真实用户时的长期性能表现。](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_010.jpg)![Vercel Analytics 展示您的应用面向真实用户时的长期性能表现。](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_009.jpg)![Vercel Analytics 展示您的应用面向真实用户时的长期性能表现。](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_010.jpg)Vercel Analytics 展示您的应用面向真实用户时的长期性能表现。

Enable [Analytics](https://vercel.com/analytics) today by visiting the Analytics tab in your project dashboard or [try it free with a team on Vercel Pro](https://vercel.com/signup?next=/dashboard?createTeam=true).

立即启用 [Analytics](https://vercel.com/analytics)：请访问项目仪表板中的 Analytics 标签页；或[在 Vercel Pro 上免费为团队试用](https://vercel.com/signup?next=/dashboard?createTeam=true)。