---
title: "Next.js 4: React 16 and styled-jsx 2 - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/next4"
date: "2017-10-09"
scraped_at: "2026-03-02T10:07:59.798360081+00:00"
language: "en-zh"
translated: true
description: "Next.js 4: React 16 and styled-jsx 2"
---

render_with_liquid: false
Oct 9, 2017

2017 年 10 月 9 日

We are happy to introduce **Next.js 4**, which features support for React 16 and introduces a major upgrade for the default styling engine styled-jsx with support for **dynamic styles**.

我们很高兴地推出 **Next.js 4**，该版本支持 React 16，并对默认样式引擎 styled-jsx 进行了重大升级，新增了对 **动态样式（dynamic styles）** 的支持。

Major performance improvements are introduced: SSR with Next.js 4 is **2.6x faster** and style initialization is **20% faster**. According to CSS-in-JS benchmarks, Next.js styles [are now the fastest of any library](https://gist.github.com/timneutkens/ab0ac6dd6d235f1bce43d31c924cf75a).

性能大幅提升：Next.js 4 的服务端渲染（SSR）速度提升至 **2.6 倍**，样式初始化速度也加快了 **20%**。根据 CSS-in-JS 基准测试，Next.js 的样式方案 [目前已成为所有同类库中最快的](https://gist.github.com/timneutkens/ab0ac6dd6d235f1bce43d31c924cf75a)。

Next.js 4 is the result of the work of [29 contributors](https://github.com/zeit/next.js/releases/tag/4.0.0), the highest of any release yet! Check out the changes below.

Next.js 4 凝聚了 [29 位贡献者](https://github.com/zeit/next.js/releases/tag/4.0.0) 的心血，是迄今为止参与人数最多的一次发布！请参阅下方的更新详情。

## React 16

## React 16

React 16 introduces numerous improvements, which you can benefit from right away by just bumping your dependencies:

React 16 引入了大量改进，你只需升级依赖即可立即受益：

```bash
npm i next@latest react@latest react-dom@latest
```

```bash
npm i next@latest react@latest react-dom@latest
```

With Next.js 3.0 we get about **105 requests per second** on one of our model pages:

使用 Next.js 3.0 时，我们在某个典型页面上可达到约 **每秒 105 次请求**：

![A benchmark of 5000 requests against Next.js 3.0 SSR](images/next_js-4-react-16-and-styled-jsx-2-vercel/img_001.jpg)A benchmark of 5000 requests against Next.js 3.0 SSR

![针对 Next.js 3.0 SSR 的 5000 次请求基准测试](images/next_js-4-react-16-and-styled-jsx-2-vercel/img_001.jpg)针对 Next.js 3.0 SSR 的 5000 次请求基准测试

and **272 requests per second** with Next.js 4 and React 16 (a _2.6x improvement_!)

而使用 Next.js 4 与 React 16 时，该数值提升至 **每秒 272 次请求**（即 _提升了 2.6 倍_！）

![A benchmark of 5000 requests against Next.js 4 SSR. 2.6x faster!](images/next_js-4-react-16-and-styled-jsx-2-vercel/img_002.jpg)  
对 Next.js 4 服务端渲染（SSR）发起 5000 次请求的性能基准测试：速度提升 2.6 倍！

This brings React to similar levels of server-rendering performance as those we’ve observed when using Next.js in conjunction [with preact](https://github.com/zeit/next.js/tree/master/examples/using-preact).  
此举使 React 的服务端渲染性能达到了与 Next.js 配合 [preact](https://github.com/zeit/next.js/tree/master/examples/using-preact) 使用时相当的水平。

## Styled-jsx 2

## styled-jsx 2

[styled-jsx](https://github.com/zeit/styled-jsx) 是一个 Babel 插件，用于为 React 组件内联样式提供支持。它实际上赋予了你创建「单文件组件」的能力——其中 CSS 样式具有词法作用域、彼此隔离：

```javascript
export default () => (

2    <div>

3      Hello there <span>my friend</span>

4      <style jsx>{`

5        /* this style only applies to the span within lexical scope */

6        span { color: red; }
```

7      `}</style>

8    </div>

9  )
```

CSS 可以与 JSX 一同嵌入。它能直接生效！

直到今天，系统已支持在样式中嵌入 **常量**，这对各类应用于 CSS 的配置非常有用：

```javascript
import { COLOR } from './css-config';



export default () => (

4    <div>

5      Hello there <span>my friend</span>

6      <style jsx>{`

7        /* this style only applies to the span within lexical scope */

7        /* 此样式仅作用于词法作用域内的 span 元素 */

8        span { color: ${COLOR}; }

8        span { color: ${COLOR}; }

9      `}</style>

9      `}</style>

10    </div>

10    </div>

11)
```

11)
```

In this case, COLOR is a constant, which is supported in 1.x

在此例中，COLOR 是一个常量，该特性在 styled-jsx 1.x 版本中即已支持。

As of [styled-jsx 2](https://github.com/zeit/styled-jsx/releases/tag/2.0.1), shipping with Next.js 4, you can now embed **variables and expressions from within the scope**, which can come from component props or state.

自 [styled-jsx 2](https://github.com/zeit/styled-jsx/releases/tag/2.0.1)（随 Next.js 4 一同发布）起，您现在可以在样式中嵌入**来自当前作用域的变量和表达式**，这些变量或表达式可来源于组件的 props 或 state。

```javascript
export default ({ color }) => (

2    <div>
```

3      Hello there <span>my friend</span>

3      你好啊，<span>我的朋友</span>

4      <style jsx>{`

4      <style jsx>{`

5        /* this style only applies to the span within lexical scope */

5        /* 此样式仅作用于词法作用域内的 span 元素 */

6        span { color: ${color}; }

6        span { color: ${color}; }

7      `}</style>

7      `}</style>

8    </div>

8    </div>

9  )

9  )

In this case, color is a React prop and can change over time!

在这种情况下，`color` 是一个 React 属性（prop），其值可随时间动态变化！

This has the effect of reducing the need for inline styles in combination with static styles, which can create some confusion when reading component code. It also improves styled-jsx for use cases like animation and theming.

这有助于减少对内联样式（inline styles）与静态样式的混合使用——而这种混合使用在阅读组件代码时容易引发混淆。同时，它也提升了 `styled-jsx` 在动画、主题切换等场景下的适用性。

[styled-jsx 2](https://github.com/zeit/styled-jsx/releases/tag/2.0.1) packs significant [performance improvements](https://gist.github.com/timneutkens/ab0ac6dd6d235f1bce43d31c924cf75a). When used with static styles, it’s **the fastest way to use styles** in your application. When using dynamic styles, it’s among the fastest (and only getting faster in the future!)

[styled-jsx 2](https://github.com/zeit/styled-jsx/releases/tag/2.0.1) 带来了显著的[性能提升](https://gist.github.com/timneutkens/ab0ac6dd6d235f1bce43d31c924cf75a)。在配合静态样式使用时，它是你应用中**使用样式的最快方式**；而在使用动态样式时，它也处于性能表现最顶尖的行列（并且未来只会越来越快！）

## Full Release Notes

## 完整发布说明

**Minor changes**

**次要变更**

- Treat navigation to empty hash as hash navigate: [#2971](https://github.com/zeit/next.js/issues/2971)

- 将导航至空哈希（empty hash）视为哈希导航：[#2971](https://github.com/zeit/next.js/issues/2971)

- Pass conf to export function: [#2962](https://github.com/zeit/next.js/issues/2962)

- 向 `export` 函数传递 `conf` 参数：[#2962](https://github.com/zeit/next.js/issues/2962)

- Keep some buffered pages, that won't be disposed. Fix [#1939](https://github.com/zeit/next.js/issues/1939): [#2592](https://github.com/zeit/next.js/issues/2592)

- 保留部分已缓存的页面，避免其被销毁。修复问题 [#1939](https://github.com/zeit/next.js/issues/1939)：[#2592](https://github.com/zeit/next.js/issues/2592)

- Add webpack-bundle-size-analyzer example: [#3013](https://github.com/zeit/next.js/issues/3013)

- 新增 `webpack-bundle-size-analyzer` 示例：[#3013](https://github.com/zeit/next.js/issues/3013)

- Add doc to onDemandEntries configuration: [#3030](https://github.com/zeit/next.js/issues/3030)

- 为 `onDemandEntries` 配置项补充文档说明：[#3030](https://github.com/zeit/next.js/issues/3030)

- Update with-firebase-hosting example: [#3032](https://github.com/zeit/next.js/issues/3032)

- 更新 `with-firebase-hosting` 示例：[#3032](https://github.com/zeit/next.js/issues/3032)

- Allow use of filenames in exportPathMap: [#2973](https://github.com/zeit/next.js/issues/2973)

- 允许在 `exportPathMap` 中使用文件名：[#2973](https://github.com/zeit/next.js/issues/2973)

- Configurable opts for babel-preset-env + babel-plugin-transform-runtime: [#2991](https://github.com/zeit/next.js/issues/2991)

- 为 `babel-preset-env` 与 `babel-plugin-transform-runtime` 提供可配置的选项（`opts`）：[#2991](https://github.com/zeit/next.js/issues/2991)

**Patches**

**补丁**

- README improvement: [#3038](https://github.com/zeit/next.js/issues/3038)

- 改进 README 文档：[#3038](https://github.com/zeit/next.js/issues/3038)

- Update the hash-statics example to support sub-dirs: [#3015](https://github.com/zeit/next.js/issues/3015)

- 更新 `hash-statics` 示例以支持子目录：[#3015](https://github.com/zeit/next.js/issues/3015)

- Example: Improve ReasonML example: [#3021](https://github.com/zeit/next.js/issues/3021)

- 示例：改进 ReasonML 示例：[#3021](https://github.com/zeit/next.js/issues/3021)

- Added Fastify example: [#3034](https://github.com/zeit/next.js/issues/3034)

- 新增 Fastify 示例：[#3034](https://github.com/zeit/next.js/issues/3034)

- More elegant application of antd: [#2840](https://github.com/zeit/next.js/issues/2840)

- 更优雅地集成 antd：[#2840](https://github.com/zeit/next.js/issues/2840)

- Upgrade dependencies: [#2998](https://github.com/zeit/next.js/issues/2998)

- 升级依赖项：[#2998](https://github.com/zeit/next.js/issues/2998)

- Corrected dependencies for preact and inferno: [#2583](https://github.com/zeit/next.js/issues/2583)

- 修正 preact 和 inferno 的依赖关系：[#2583](https://github.com/zeit/next.js/issues/2583)

- Fix coding style of snippets: [#2806](https://github.com/zeit/next.js/issues/2806)

- 修复代码片段的编码风格：[#2806](https://github.com/zeit/next.js/issues/2806)

- Tie page visibility api to on demand pinger: [#2818](https://github.com/zeit/next.js/issues/2818)

- 将页面可见性 API（Page Visibility API）与按需心跳检测器（on-demand pinger）绑定：[#2818](https://github.com/zeit/next.js/issues/2818)

- Only use strict dependencies: [#2929](https://github.com/zeit/next.js/issues/2929)

- 仅使用严格依赖：[#2929](https://github.com/zeit/next.js/issues/2929)

- Fix error messages in server/export.js: [#2933](https://github.com/zeit/next.js/issues/2933)

- 修复 `server/export.js` 中的错误信息：[#2933](https://github.com/zeit/next.js/issues/2933)

- Expose buildId to custom webpack configs: [#3001](https://github.com/zeit/next.js/issues/3001)

- 向自定义 Webpack 配置暴露 `buildId`：[#3001](https://github.com/zeit/next.js/issues/3001)

- Added PropType: [#3003](https://github.com/zeit/next.js/issues/3003)

- 新增 `PropTypes` 支持：[#3003](https://github.com/zeit/next.js/issues/3003)

- Add "asPath" information to url objects: [#2988](https://github.com/zeit/next.js/issues/2988)

- 向 `url` 对象添加 `"asPath"` 信息：[#2988](https://github.com/zeit/next.js/issues/2988)


## Conclusion

## 总结

With nearly **18,000 stars** in the 10 months since the [initial Next.js release](https://vercel.com/next), we are humbled by the amazing growth and reception the Next.js project has seen. Next.js is now being used by companies of all size: from Fortune 50 enterprises, to design studios and startups and individuals all over the world.

自 [Next.js 首次发布](https://vercel.com/next) 以来的 10 个月内，项目已获得近 **18,000 颗星标**；Next.js 所取得的惊人增长与广泛认可，令我们深感谦逊与荣幸。如今，Next.js 已被全球各类规模的企业所采用——从《财富》50 强企业，到设计工作室、初创公司，乃至独立开发者。

Moving forward, we plan on continuing to deliver frequent releases that improve your development experience and ability to extend Next.js to fit an ever-growing range of applications.

展望未来，我们将持续推出高频更新，不断优化您的开发体验，并增强 Next.js 的可扩展性，以适配日益多样化和复杂的应用场景。

Come Join Us!

欢迎加入我们！