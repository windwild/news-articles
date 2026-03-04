---
title: "Hashicorp uses ISR to iterate faster on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-hashicorp-developers-iterate-faster-with-isr"
date: "2022-04-26"
scraped_at: "2026-03-02T10:02:25.484293727+00:00"
language: "en-zh"
translated: true
description: "HashiCorp used ISR and on-demand ISR in Next.js 12 to cut build times, update pages instantly, and scale docs across 8 products without full site rebuilds."
---
&#123;% raw %}

Apr 26, 2022

2022年4月26日

借助增量静态再生（ISR）简化大规模项目的开发与部署。

Incremental Static Regeneration (ISR) 大幅缩短构建时间，使开发者能够更快地交付变更，并提升网站性能。在 Next.js 12.1 中，我们正式推出了备受开发者期待的 **[按需 ISR（On-Demand ISR）](https://nextjs.org/blog/next-12-1#on-demand-incremental-static-regeneration-beta)** 功能——该功能在面向大规模项目交付的开发者群体中呼声最高。

HashiCorp 高级前端工程师 Bryce Kalow 专程与我们交流，详细介绍了 HashiCorp 工程师如何利用 ISR 及按需 ISR 快速迭代，同时保持网站与应用的高度灵活性。

- [什么是 ISR？](https://vercel.com/blog/how-hashicorp-developers-iterate-faster-with-isr#what-is-isr)  
- [HashiCorp 如何使用 ISR](https://vercel.com/blog/how-hashicorp-developers-iterate-faster-with-isr#how-hashicorp-uses-isr)  
- [试用按需 ISR](https://vercel.com/blog/how-hashicorp-developers-iterate-faster-with-isr#try-on-demand-isr)

## What is ISR?

## 什么是 ISR？

ISR 最早于 Next.js 9.5 版本中引入，是 Next.js 开发者可选用的 [渲染策略（rendering strategies）](https://nextjs.org/learn/seo/rendering-and-ranking/rendering-strategies) 之一。它允许你在构建完成之后重新执行 `getStaticProps` 函数。相比传统静态网站，ISR 提供了显著更高的灵活性。企业尤其青睐 ISR，用于构建大型网站，并确保内容持续新鲜、及时更新。

传统的 [静态站点生成（Static Site Generation, SSG）](https://nextjs.org/docs/basic-features/data-fetching/get-static-props) 要求每次（哪怕只是微小）变更都必须重建整个网站。由于构建时间随页面数量呈线性增长，你可能需要等待数小时才能完成构建——试想一个拥有数千甚至数百万页面的网站。

![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_001.jpg)![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_002.jpg)![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_003.jpg)![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_004.jpg)

![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_001.jpg)![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_002.jpg)![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_003.jpg)![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_004.jpg)

**Leverage the power of server-side code**

**利用服务端代码的强大能力**

ISR makes this process much faster and more efficient by enabling you to use SSG on a per-page basis, without needing to rebuild the entire site. Static pages can be generated at runtime instead of at build time, saving you time on every build.

ISR 极大地提升了这一流程的速度与效率：它允许你按页面粒度启用静态站点生成（SSG），而无需重建整个网站。静态页面可在运行时（runtime）生成，而非仅限于构建时（build time），从而显著缩短每次构建所耗时间。

![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_005.jpg)![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_006.jpg)![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_007.jpg)![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_008.jpg)

![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_005.jpg)![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_006.jpg)![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_007.jpg)![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_008.jpg)

Since ISR was released, we've seen companies like Tripadvisor and HashiCorp drastically improve their build times and retain incredible performance. With on-demand ISR, you can purge the Next.js cache for a specific page on demand. This makes it easier to update your site, particularly when content is created or updated from your headless CMS, or when ecommerce metadata changes (price, description, category, reviews, etc.).

自 ISR 发布以来，我们已看到 Tripadvisor 和 HashiCorp 等公司大幅缩短了构建时间，同时保持了卓越的性能表现。借助按需 ISR（on-demand ISR），你可以按需清除 Next.js 对特定页面的缓存。这使得网站更新更加便捷——尤其适用于内容由无头 CMS（headless CMS）创建或更新的场景，或当电商元数据（如价格、描述、分类、用户评价等）发生变化时。

## How HashiCorp uses ISR

## HashiCorp 如何使用 ISR

Bryce Kalow, Senior Web Engineer at HashiCorp, showed us how their documentation team uses ISR to manage content updates and open-source contributions.

HashiCorp 高级网页工程师 Bryce Kalow 向我们展示了其文档团队如何利用 ISR 来管理内容更新及开源贡献。

**Q: For people not as familiar with software development, build times can seem like just one step in a larger process. Why is ISR part of your team’s workflow?**

**问：对于不太熟悉软件开发的人来说，构建时间可能只是整个流程中一个看似普通的环节。那么，为何 ISR 会成为你们团队工作流中不可或缺的一部分？**

**Bryce:** You can’t understate the impact build times have on iteration. At HashiCorp, we have eight open-source products, each with a documentation site built from content in its repository.

**Bryce：** 构建时间对迭代效率的影响怎么强调都不为过。在 HashiCorp，我们拥有八款开源产品，每款产品都配有独立的文档网站，这些网站的内容均源自各自代码仓库中的文档源文件。

Over the past year, my team and I have been rolling out versioned documentation for all of our products. This means we’re now rendering many past versions of our documentation, instead of just the latest version. That's a huge increase in the number of pages! To facilitate this, we have shifted to serving our documentation content from an API, instead of reading directly from the file system. With so many new pages to render, it would have significantly slowed down our process and increased our build times to statically generate these pages.

过去一年中，我和我的团队一直在为所有产品全面推行版本化文档（versioned documentation）。这意味着我们现在需要渲染大量历史版本的文档，而不再仅限于最新版本——页面总数因此激增！为支持这一需求，我们已将文档内容的提供方式从直接读取文件系统，切换为通过 API 接口提供。若仍采用静态站点生成（SSG）方式来构建如此海量的新页面，整个流程将明显变慢，构建时间也将大幅增加。

With our new API and ISR, we’re able to statically generate only the most visited pages, which we determine from our analytics data, and defer the rest to after the initial build.  
借助我们的新 API 和增量静态再生（ISR），我们仅对访问量最高的页面进行静态生成（该访问量数据来源于我们的分析系统），其余页面则推迟到初始构建完成之后再处理。

ISR also allows us to propagate content changes to our sites without doing a full rebuild. We’ve currently got our revalidate timeout set to one hour.  
ISR 还使我们能够在不执行完整重建的前提下，将内容更新同步至网站。目前，我们的 `revalidate` 超时时间设置为一小时。

```javascript
1// Pre-render the top pages based on traffic data

2// `fallback: blocking` will generate the page on-demand

3// it if hasn't already been generated.

export async function getStaticPaths(ctx)   {

5  return {

6    paths: await getTopPathsFromAnalytics(ctx),

7    fallback: 'blocking'

8  }

9}
```

```javascript
1// 根据流量数据预渲染热门页面

2// `fallback: blocking` 表示：若页面尚未生成，则按需同步生成

3// （即在首次请求时阻塞式生成该页面）。

export async function getStaticPaths(ctx)   {

5  return {

6    paths: await getTopPathsFromAnalytics(ctx),

7    fallback: 'blocking'

8  }

9}
```

```markdown
11// Fetch the data for this specific page

11// 获取此特定页面的数据

export async function getStaticProps(ctx) {

export async function getStaticProps(ctx) {

13  return {

13  return {

14    props: await getDocumentationContent(ctx),

14    props: await getDocumentationContent(ctx),

15    revalidate: 360 // 1 hour

15    revalidate: 360 // 1 小时

16  }

16  }

17}
```

17}
```

**Q: How does on-demand ISR compliment ISR? And how does it get used?**

**Q：按需 ISR（on-demand ISR）如何补充静态生成时的增量静态再生（ISR）？它又是如何被使用的？**

**Bryce:** ISR has been great for us. With it, we’ve got a reasonable baseline for time to content changes going live. We’re always looking to shorten feedback cycles, though. We'd like to be able to push changes out as they happen so our content creators aren't left wondering why their changes haven't propagated.

**Bryce：** ISR 对我们而言效果非常出色。借助它，我们为内容更新上线所需的时间建立了一个合理的基准。不过，我们始终致力于进一步缩短反馈周期——我们希望内容一旦变更就能立即发布，从而避免内容创作者困惑于“我的修改为何尚未生效”。

With on-demand ISR, you can revalidate pages that use `getStaticProps` instantly. This means you can manually purge the Next.js cache for a specific page any time you want with just an API call. If your CMS exposes a webhook for when content changes are made, for example, you can have it call your revalidate endpoint.

借助按需 ISR（Incremental Static Regeneration），您可以即时重新验证使用 `getStaticProps` 的页面。这意味着只需一次 API 调用，您即可随时手动清除 Next.js 对特定页面的缓存。例如，若您的 CMS 在内容更新时提供了 Webhook，便可配置该 Webhook 调用您的重新验证（revalidate）端点。

With this in place, you can get near-instant updates without relying on a deploy trigger to rebuild your entire site, which would re-generate unchanged pages, or a more aggressive revalidate timer, which makes your cache less effective. Instrumenting on-demand ISR in our existing Next.js sites is quick, and the programmatic interface lets us adjust the logic to suit our architecture.

通过这种方式，您可实现近乎实时的内容更新，而无需依赖部署触发器来重建整个站点（否则会重复生成未更改的页面），也无需设置更激进的 `revalidate` 时间间隔（这会降低缓存的有效性）。在我们现有的 Next.js 站点中接入按需 ISR 非常快捷，且其编程式接口使我们能够灵活调整逻辑，以适配自身架构。

`pages/api/revalidate.js`

`pages/api/revalidate.js`

```javascript
export default async function revalidate(request, response) {

2  const { secret, path } = request.query



4  // Check for secret to confirm this is a valid request

5  if (secret !== process.env.REVALIDATE_SECRET) {

6    return response.send(401)

7  }
```

```javascript
export default async function revalidate(request, response) {

2  const { secret, path } = request.query



4  // 检查密钥（secret），以确认该请求合法

5  if (secret !== process.env.REVALIDATE_SECRET) {

6    return response.status(401).send('Unauthorized')

7  }
```

9  if (await isValidPage(path)) {

9  如果 `await isValidPage(path)` 返回真值：

10    await response.unstable_revalidate(path)

10    `await response.unstable_revalidate(path)`

11    return response.status(200).json({ revalidated: true })

11    `return response.status(200).json({ revalidated: true })`

12  }



12  }

14  return response.send(400)

14  `return response.send(400)`

15}

15}

**Q: Where does on-demand ISR fit into the rest of your workflow?**

**Q：按需 ISR（on-demand ISR）在您的整体工作流中处于什么位置？**

**Bryce:** We’re excited about the possibilities that on-demand ISR provides for us. Our documentation content lives in GitHub, we use a GitHub application to listen for push events that include documentation changes, and we use GitHub Actions to upload that content to our database. This means we have access to the files changed, and so we can use that diff to trigger on-demand ISR from our workflows for only the pages that have changed.

**Bryce：** 我们对按需 ISR 所带来的可能性感到非常兴奋。我们的文档内容托管在 GitHub 上；我们通过一个 GitHub App 监听包含文档变更的推送（push）事件，并借助 GitHub Actions 将这些更新后的内容上传至我们的数据库。这意味着我们可以获取到具体被修改的文件列表，从而利用该差异（diff）仅针对发生变更的页面，在工作流中触发按需 ISR。

We’re currently using Vercel deploy hooks to trigger a full-site deploy when large amounts of pages are updated, such as on a product release, but we would also like to explore swapping this out with targeted on-demand ISR calls to avoid unnecessary builds.

我们目前使用 Vercel 部署钩子（deploy hooks）在大量页面更新时（例如产品发布期间）触发全站部署，但我们也希望探索改用定向的按需 ISR（on-demand ISR）调用，以避免不必要的构建。

> “A lot of teams struggle with trying to implement their own version of ISR at scale. In an enterprise organization, entire teams can be dedicated to making it work. But with Vercel, ISR works out of the box. A lot of teams struggle with trying to implement their own version of ISR at scale. In an enterprise organization, entire teams can be dedicated to making it work. But with Vercel, ISR works out of the box. ”  
>  
> “许多团队在大规模实现自研版 ISR 时举步维艰。在大型企业组织中，甚至可能需要整支团队专门负责使其正常运行。而借助 Vercel，ISR 开箱即用。”  
>  
> ![](images/hashicorp-uses-isr-to-iterate-faster-on-vercel-vercel/img_009.jpg)  
>  
> **Bryce Kalow,** Senior Web Engineer at HashiCorp  
>  
> **布莱斯·卡洛（Bryce Kalow）**，HashiCorp 高级网页工程师

**Q: Now that you’re using on-demand ISR, what will the team be working on next?**  
**问：既然你们已开始使用按需 ISR，团队接下来将重点推进哪些工作？**

**Bryce:** In the short term, we’re looking to expand our usage of on-demand ISR across our suite of Next.js sites. With on-demand ISR implemented, we can start to tweak some of our revalidate timers to take advantage of more aggressive caching, without worrying about serving stale content to our users. Overall, we think implementing on-demand ISR will speed up the iteration process across the board for all of our sites.

**布莱斯：** 短期内，我们计划将按需 ISR 推广至全部 Next.js 站点。一旦按需 ISR 部署完成，我们便可优化部分 `revalidate` 定时器，启用更激进的缓存策略，同时无需担忧向用户交付过期内容。总体而言，我们认为按需 ISR 的落地将全面加速所有站点的迭代流程。

We’re also really interested in continuing to leverage [Edge compute](http://vercel.com/edge). Next.js’s [Middleware](https://nextjs.org/docs/advanced-features/middleware) functions have been a fun testbed for our team to assess what we can shift to the Edge without having a huge negative impact on our runtime performance, or losing the benefits of static generation. As you can see, this is a common theme for us and a big reason why we’re so excited for new features like on-demand ISR!

我们同样非常期待持续深化对 [边缘计算（Edge compute）](http://vercel.com/edge) 的应用。Next.js 的 [中间件（Middleware）](https://nextjs.org/docs/advanced-features/middleware) 功能为我们团队提供了极佳的试验场，帮助我们评估：哪些逻辑可迁移至边缘执行，既不会显著拖慢运行时性能，又能保留静态生成（static generation）的核心优势。如您所见，这正是我们长期关注的重点方向之一，也是我们对按需 ISR 等新功能如此兴奋的重要原因！

## Try on-demand ISR  
## 尝试按需 ISR（on-demand ISR）

Learn more about on-demand ISR and start using it today:  
立即了解按需 ISR 并开始使用：

- [Documentation](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration)  
- [文档](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration)

- [Next.js 12.1 release post](https://nextjs.org/blog/next-12-1#on-demand-incremental-static-regeneration-beta)  
- [Next.js 12.1 版本发布日志](https://nextjs.org/blog/next-12-1#on-demand-incremental-static-regeneration-beta)

- [Next.js 12.1 video and demo](https://youtu.be/BGexHR1tuOA)  
- [Next.js 12.1 视频演示](https://youtu.be/BGexHR1tuOA)

- [Click-and-deploy demo](https://github.com/leerob/on-demand-isr)

- [一键部署演示](https://github.com/leerob/on-demand-isr)
&#123;% endraw %}
