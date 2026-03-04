---
title: "Node.js 10 is Now Available - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/node-10"
date: "2019-06-25"
scraped_at: "2026-03-02T10:07:43.903373313+00:00"
language: "en-zh"
translated: true
description: "We are enabling Node.js 10 support for new serverless Node.js functions and Next.js applications deployed with Vercel."
---

render_with_liquid: false
Jun 25, 2019

2019 年 6 月 25 日

With the [release of Node.js 10](https://nodejs.org/fr/blog/release/v10.0.0/), features like [BigInt](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt), a [stable API for native addons](https://nodejs.org/api/n-api.html#n_api_n_api), and several performance improvements have found their way into production.

随着 [Node.js 10 的发布](https://nodejs.org/fr/blog/release/v10.0.0/)，诸如 [BigInt](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/BigInt)、用于原生插件的[稳定 API](https://nodejs.org/api/n-api.html#n_api_n_api)，以及多项性能改进均已正式投入生产环境使用。

Today, we are **enabling Node.js 10 support** for new [serverless Node.js functions](https://zeit.co/docs/v2/deployments/official-builders/node-js-now-node/) and [Next.js applications](https://zeit.co/docs/v2/deployments/official-builders/next-js-now-next/) deployed using [Vercel](https://zeit.co/now).

今天，我们正式为使用 [Vercel](https://zeit.co/now) 部署的新版 [无服务器 Node.js 函数](https://zeit.co/docs/v2/deployments/official-builders/node-js-now-node/) 和 [Next.js 应用](https://zeit.co/docs/v2/deployments/official-builders/next-js-now-next/) **启用 Node.js 10 支持**。

## How to Upgrade

## 如何升级

In order to have your code invoked with **Node.js 10**, you need only to add an `engines` field to your `package.json` file as follows:

如需让您的代码在 **Node.js 10** 环境下运行，只需在 `package.json` 文件中添加如下 `engines` 字段即可：

```json
1{

2  "name": "my-app",

3  "engines": {

4    "node": "10.x"

5  }
```

6}
```

As you can see, we have configured `10.x` as the version, instead of the exact one.

如您所见，我们配置的版本是 `10.x`，而非某个精确版本。

This is possible because the `engines` property (as per the [documentation](https://docs.npmjs.com/files/package.json#engines)) supports [semantic version](https://semver.org/) ranges in its syntax.

之所以可行，是因为 `engines` 属性（参见 [官方文档](https://docs.npmjs.com/files/package.json#engines)）在其语法中支持 [语义化版本（SemVer）](https://semver.org/) 范围。

At the moment of writing, **this will result in Node.js 10.15.3 being used**.

撰写本文时，**此配置将使用 Node.js 10.15.3**。

**NOTE:** The range `10.x` will allow new deployments to take advantage of security updates and features released to [Node.js 10 LTS](https://github.com/nodejs/Release). It is not possible to pin a specific version at this time.

**注意：** 版本范围 `10.x` 将使新部署能够自动受益于 [Node.js 10 LTS](https://github.com/nodejs/Release) 发布的安全更新和新功能。目前尚不支持锁定某一特定版本。

### Supported Builders

### 支持的构建器（Builders）

If your deployment uses one of the following [Builders](https://zeit.co/docs/v2/deployments/builders/overview/), you can opt into **Node.js 10**:

如果您的部署使用了以下任一 [构建器（Builders）](https://zeit.co/docs/v2/deployments/builders/overview/)，则可选择启用 **Node.js 10**：

- [@vercel/node](https://zeit.co/docs/v2/deployments/official-builders/node-js-now-node/) (buildtime and runtime)

- [@vercel/node](https://zeit.co/docs/v2/deployments/official-builders/node-js-now-node/)（构建时与运行时）

- [@vercel/next](https://zeit.co/docs/v2/deployments/official-builders/next-js-now-next/) (buildtime and runtime)

- [@vercel/next](https://zeit.co/docs/v2/deployments/official-builders/next-js-now-next/)（构建时与运行时）

- [@vercel/static-build](https://zeit.co/docs/v2/deployments/official-builders/static-build-now-static-build/) (buildtime)

- [@vercel/static-build](https://zeit.co/docs/v2/deployments/official-builders/static-build-now-static-build/)（仅构建时）

## What Has Changed

## 有哪些变化

Node.js 10 includes several new features, such as [a stable API for native addons](https://nodejs.org/api/n-api.html#n_api_n_api), [BigInt](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt), [a better way of creating Buffers](https://nodejs.org/api/buffer.html#buffer_buffer_from_buffer_alloc_and_buffer_allocunsafe), and [version 6.0 of npm](https://medium.com/npm-inc/announcing-npm-6-5d0b1799a905).

Node.js 10 引入了多项新特性，例如：[原生插件的稳定 API](https://nodejs.org/api/n-api.html#n_api_n_api)、[BigInt](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/BigInt)、[更安全可靠的 Buffer 创建方式](https://nodejs.org/api/buffer.html#buffer_buffer_from_buffer_alloc_and_buffer_allocunsafe)，以及 [npm 6.0 版本](https://medium.com/npm-inc/announcing-npm-6-5d0b1799a905)。

On your serverless function, however, the most noticeable improvement will be in performance (from Node.js 10 including [V8 6.6](https://v8.dev/blog/v8-release-66)).

然而，在您的无服务器函数中，最显著的改进体现在性能提升上（得益于 Node.js 10 内置的 [V8 6.6 引擎](https://v8.dev/blog/v8-release-66)）。

As an example, `Array.reduce` is now much faster for [holey double arrays](https://v8.dev/blog/elements-kinds):

例如，`Array.reduce` 在处理 [含空洞的双精度数组（holey double arrays）](https://v8.dev/blog/elements-kinds) 时，现在快了许多：

![](images/node_js-10-is-now-available-vercel/img_001.jpg)

![](images/node_js-10-is-now-available-vercel/img_001.jpg)

Even a regular `Promise` will now be faster:

即使是普通的 `Promise`，现在也更快了：

![](images/node_js-10-is-now-available-vercel/img_002.jpg)

![](images/node_js-10-is-now-available-vercel/img_002.jpg)

The performance metrics were retrieved from the [v8 release post](https://v8.dev/blog/v8-release-66). For a full list of all changes, take a look at [Auth0's release summary](https://auth0.com/blog/nodejs-10-new-changes-deprecations).

上述性能数据源自 [V8 发布日志](https://v8.dev/blog/v8-release-66)。如需查看全部变更的完整列表，请参阅 [Auth0 的发布摘要](https://auth0.com/blog/nodejs-10-new-changes-deprecations)。

## Conclusion

## 总结

Our team is working hard to ensure that – every time a new [Node.js release](https://github.com/nodejs/Release) occurs – we provide you with the respective runtime for your serverless functions.

我们的团队正全力以赴，确保每次 [Node.js 新版本发布](https://github.com/nodejs/Release) 后，都能及时为您提供适配该版本的无服务器函数运行时环境。

Make sure to **update your existing deployments to Node.js 10** (as described above) and keep your eyes open for future Node.js updates via our [Twitter page](https://twitter.com/vercel).

请务必**将您现有的部署更新至 Node.js 10**（如上所述），并持续关注我们 [Twitter 页面](https://twitter.com/vercel) 发布的未来 Node.js 更新信息。

Should you have any questions, please [let us know](mailto:support@vercel.com).

如有任何疑问，请[随时联系我们](mailto:support@vercel.com)。