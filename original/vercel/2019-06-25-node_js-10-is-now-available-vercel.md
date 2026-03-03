---
title: "Node.js 10 is Now Available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/node-10"
date: "2019-06-25"
scraped_at: "2026-03-02T10:07:43.903373313+00:00"
language: "en"
translated: false
description: "We are enabling Node.js 10 support for new serverless Node.js functions and Next.js applications deployed with Vercel."
---




Jun 25, 2019

With the [release of Node.js 10](https://nodejs.org/fr/blog/release/v10.0.0/), features like [BigInt](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt), a [stable API for native addons](https://nodejs.org/api/n-api.html#n_api_n_api), and several performance improvements have found their way into production.

Today, we are **enabling Node.js 10 support** for new [serverless Node.js functions](https://zeit.co/docs/v2/deployments/official-builders/node-js-now-node/) and [Next.js applications](https://zeit.co/docs/v2/deployments/official-builders/next-js-now-next/) deployed using [Vercel](https://zeit.co/now).

## How to Upgrade

In order to have your code invoked with **Node.js 10**, you need only to add an `engines` field to your `package.json` file as follows:

```json
1{

2  "name": "my-app",

3  "engines": {

4    "node": "10.x"

5  }

6}
```

As you can see, we have configured `10.x` as the version, instead of the exact one.

This is possible because the `engines` property (as per the [documentation](https://docs.npmjs.com/files/package.json#engines)) supports [semantic version](https://semver.org/) ranges in its syntax.

At the moment of writing, **this will result in Node.js 10.15.3 being used**.

**NOTE:** The range `10.x` will allow new deployments to take advantage of security updates and features released to [Node.js 10 LTS](https://github.com/nodejs/Release). It is not possible to pin a specific version at this time.

### Supported Builders

If your deployment uses one of the following [Builders](https://zeit.co/docs/v2/deployments/builders/overview/), you can opt into **Node.js 10**:

- [@vercel/node](https://zeit.co/docs/v2/deployments/official-builders/node-js-now-node/) (buildtime and runtime)

- [@vercel/next](https://zeit.co/docs/v2/deployments/official-builders/next-js-now-next/) (buildtime and runtime)

- [@vercel/static-build](https://zeit.co/docs/v2/deployments/official-builders/static-build-now-static-build/) (buildtime)


## What Has Changed

Node.js 10 includes several new features, such as [a stable API for native addons](https://nodejs.org/api/n-api.html#n_api_n_api), [BigInt](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt), [a better way of creating Buffers](https://nodejs.org/api/buffer.html#buffer_buffer_from_buffer_alloc_and_buffer_allocunsafe), and [version 6.0 of npm](https://medium.com/npm-inc/announcing-npm-6-5d0b1799a905).

On your serverless function, however, the most noticeable improvement will be in performance (from Node.js 10 including [V8 6.6](https://v8.dev/blog/v8-release-66)).

As an example, `Array.reduce` is now much faster for [holey double arrays](https://v8.dev/blog/elements-kinds):

![](images/node_js-10-is-now-available-vercel/img_001.jpg)

Even a regular `Promise` will now be faster:

![](images/node_js-10-is-now-available-vercel/img_002.jpg)

The performance metrics were retrieved from the [v8 release post](https://v8.dev/blog/v8-release-66). For a full list of all changes, take a look at [Auth0's release summary](https://auth0.com/blog/nodejs-10-new-changes-deprecations).

## Conclusion

Our team is working hard to ensure that – every time a new [Node.js release](https://github.com/nodejs/Release) occurs – we provide you with the respective runtime for your serverless functions.

Make sure to **update your existing deployments to Node.js 10** (as described above) and keep your eyes open for future Node.js updates via our [Twitter page](https://twitter.com/vercel).

Should you have any questions, please [let us know](mailto:support@vercel.com).