---
title: "Node.js 14 LTS is now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-14-lts-is-now-available"
date: "2021-02-04"
scraped_at: "2026-03-02T10:05:34.255642006+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Feb 4, 2021

2021年2月4日

![](https://vercel.com/vc-ap-vercel-marketing/_next/image?url=https%3A%2F%2Fassets.vercel.com%2Fimage%2Fupload%2Fcontentful%2Fimage%2Fe5382hct74si%2F3m3JEsxL9D8b8psO8bMBEL%2F0285b208ff3e4a224fe5ccdee8d2a235%2Fpreview.png&w=1920&q=75)

As of today, version 14 of Node.js can be selected in the **Node.js Version** section on the General page in the **Project Settings** (newly created Projects will default to the new version).

截至目前，您可在 **项目设置（Project Settings）** 的常规页面中“**Node.js 版本（Node.js Version）**”选项下选择 Node.js 14 版本（新创建的项目将默认使用该版本）。

Among [other features](https://nodejs.medium.com/node-js-version-14-available-now-8170d384567e), the new version introduces [Diagnostic Reports](https://nodejs.org/docs/latest-v14.x/api/report.html), which can be logged to [Log Drains](https://vercel.com/blog/log-drains) (recommended) like so:

除[其他特性](https://nodejs.medium.com/node-js-version-14-available-now-8170d384567e)外，该新版本还引入了[诊断报告（Diagnostic Reports）](https://nodejs.org/docs/latest-v14.x/api/report.html)，这些报告可被记录到[日志接收器（Log Drains）](https://vercel.com/blog/log-drains)（推荐方式），示例如下：

```javascript
geo: {

2    city?: string

3    country?: string

4    region?: string

5}


```

The following features were introduced through [v8](https://v8.dev/):

以下功能通过 [v8](https://v8.dev/) 引入：

- [Nullish coalescing operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Nullish_coalescing_operator)

- [空值合并运算符（Nullish Coalescing Operator）](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Nullish_coalescing_operator)

- [Optional chaining](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Optional_chaining)

- [可选链操作符（Optional Chaining）](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Optional_chaining)

- [Intl.DisplayNames](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/DisplayNames)

- [Intl.DisplayNames](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Intl/DisplayNames)

- [Intl.DateTimeFormat](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/DateTimeFormat)

- [Intl.DateTimeFormat](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Intl/DateTimeFormat)


The exact version used is 14.15.4 ( [changelog](https://github.com/nodejs/node/blob/master/doc/changelogs/CHANGELOG_V14.md#14.15.4)), but automatic updates will be applied for new minor and patch releases. Therefore, only the major version (14.x) is guaranteed.

当前使用的精确版本为 14.15.4（[更新日志](https://github.com/nodejs/node/blob/master/doc/changelogs/CHANGELOG_V14.md#14.15.4)），但新发布的次要版本（minor）和修订版本（patch）将自动更新。因此，仅主版本号（14.x）可确保稳定。

Check out [the documentation](https://vercel.com/docs/runtimes#official-runtimes/node-js/node-js-version) as well.

也请参阅 [相关文档](https://vercel.com/docs/runtimes#official-runtimes/node-js/node-js-version)。