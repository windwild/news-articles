---
title: "Next.js 3.0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/next3"
date: "2017-08-08"
scraped_at: "2026-03-02T10:08:01.075346454+00:00"
language: "en"
translated: false
description: "Next.js 3.0 comes with vastly improved HMR, dynamic imports, static exports and better serverless support!"
---




Aug 8, 2017

We are very excited excited to announce the stable release of Next.js 3.0. Ever since our [beta announcement](https://vercel.com/blog/next3-preview), we have been using it to power [vercel.com](https://vercel.com/) and have received lots of feedback and contributions from our [community](https://zeit.chat/).

Let’s walk through what’s been improved and what’s altogether new, or fetch the latest version from [npm](https://www.npmjs.com/package/next)!

_New to Next.js?_ Next.js is a zero-configuration, single-command toolchain for React apps, with built-in server-rendering, code-splitting and more. Check out [Learn Next.js](https://learnnextjs.com/) to get started!

## Static Export Support

This was the [most request feature](https://github.com/zeit/next.js/issues/604) by the community on GitHub. And we have delivered!

All it takes to export your project to a directory with plain **.html** and **.css** files is to [configure your project](https://github.com/zeit/next.js#static-html-export) and run:

```bash
next export
```

The bonus? You can deploy statically to [now.sh](https://vercel.com/home) as many times as you want, for free!

The prolific Next.js community has already come up with some static blog generators for you to check out:

- [next-blog](https://github.com/tscanlin/next-blog)

- [next-static](https://github.com/infiniteluke/next-static)

- [nextein](https://github.com/elmasse/nextein)


## Dynamic Import Support

Next.js now fully supports [TC39 dynamic import](https://github.com/tc39/proposal-dynamic-import).

With dynamic imports, our codebase gets split into a set of chunks that can later be loaded dynamically. The developer gets full control to load code over time, depending on user interaction or the data itself.

It's pretty easy to use. Just import your module as a promise as shown below:

```javascript
const moment = import('moment')

setTimeout(function() {

3  moment.then(moment => {

4  // Do something with moment

5  })

6}, 15000)
```

The module will be downloaded when we starting to use it. In the above example, the `moment` module will be downloaded when the `setTimeout` callback runs (~15 secs after the page load.) This speeds up our main JavaScript bundle by loading code only when we need it.

### Dynamic React Components

Additionally, Next.js comes with a powerful opt-in utility called [`next/dynamic`](https://github.com/zeit/next.js#dynamic-import) which helps you to create dynamically loaded React Components easily.

Dynamic components _can_ load React code on-demand, but the most interesting feature is that if they are included in the initial rendering, server-rendering still works!

Let's look at some examples!

```javascript
import dynamic from 'next/dynamic'

const DynamicComponent = dynamic(import('@components/hello'))



export default () => (

5  <div>

6    <Header />

7    <DynamicComponent />

8    <p>HOME PAGE is here!</p>

9  </div>

10)
```

Loading a single component, dynamically.

```javascript
import dynamic from 'next/dynamic'



const HelloBundle = dynamic({

4  modules: (props) => {

5    const components = {

6      Hello1: import('@components/hello1'),

7      Hello2: import('@components/hello2')

8    }

9    // you can add / remove components based on props

10    return components

11  },

12  render: (props, { Hello1, Hello2 }) => (

13    <div>

14      <h1>{props.title}</h1>

15      <Hello1 />

16      <Hello2 />

17    </div>

18  )

19})



export default () => (

22  <HelloBundle title="Dynamic Bundle" />

23)
```

Loading different components based on dynamic properties!

Until today, code splitting was based on routes, or the **section** of the application the user had loaded. Moving forward, you'll be able to load **code as a function of the data** the user is presented with.

We are excited about the apps people will create with this new paradigm.

## More Beautiful Errors

Thanks to [Krisztian Puska](https://github.com/zeit/next.js/issues/2182), we’ve updated our error color theme to be easier on the eyes and more accessible.

![The gif shows a syntax error being hot reloaded with the new¬ colors.](images/next_js-3_0-vercel/img_001.jpg)The gif shows a syntax error being hot reloaded with the new¬ colors.

## Improved Hot Module Replacement

We have addressed a variety of scenarios that would render **HMR (** **_hot module replacement_** **)** ineffective before, in particular around error recovery.

Moving forward, when an error of any kind occurs, you will be able to make changes to your code, save and see the error change, be substituted by another error or go away altogether!

### HMR: Node.js 8.0 Support

We have solved `ERR_INCOMPLETE_CHUNK_ENCODING` errors in the dev tools showing up when using Next.js with the new Node.js 8.x release line.

![You won’t be seeing this one again!](images/next_js-3_0-vercel/img_002.jpg)You won’t be seeing this one again!

### HMR: Navigating to Errors

If you navigate to a page that had any kind of error, it’ll be handled appropriately now, rendering the error message and giving you the ability to correct it in realtime.

![We navigate to the index page with errors, fix them and watch¬ the page recover.](images/next_js-3_0-vercel/img_003.jpg)We navigate to the index page with errors, fix them and watch¬ the page recover.

### HMR: 404 to Error to Success

We have addressed a bug where you navigate to a missing page (correctly rendered as **404**), but you make a mistake when populating it.

![After we create the page, we introduce an error and then¬ promptly fix it.](images/next_js-3_0-vercel/img_004.jpg)After we create the page, we introduce an error and then¬ promptly fix it.

### HMR: Better Bad Returns

If you happen to return the wrong type, we now handle that situation smoothly.

![After the right type is returned, the page recovers¬ successfully.](images/next_js-3_0-vercel/img_005.jpg)After the right type is returned, the page recovers¬ successfully.

### HMR: Undefined Can Be a Function

Any type of runtime error when evaluating the module is now correctly caught. Realtime debugging of `undefined is not a function` is right around the corner.

![We first make a syntax error, which recovers to a runtime error,¬ which recovers to the page.](images/next_js-3_0-vercel/img_006.jpg)We first make a syntax error, which recovers to a runtime error,¬ which recovers to the page.

## Faster: Serverless Ready

Bootup time for a baseline Next.js app is now **5 times faster**, down to [about 200ms from 1000ms](https://github.com/zeit/next.js/pull/2566). Stay tuned for some exciting announcements about serverless Next.js with Now!

## Smaller: Optimized Core Bundles

We have optimized the core Next.js bundle even further and it's now [10% leaner](https://github.com/zeit/next.js/pull/2422)! Only the most crucial production code is included in your final bundles.

## 4.0 and Beyond

As we have done after other major releases, we will soon be publicly sharing our roadmap for **Next.js 4.0**.

The focus will be on an even leaner core, faster bootup time and rendering, integration with React 16 and better use of caching during development to avoid re-compilation.

As always, we recommend you join our [Slack community](https://zeit.chat/) and [follow us on Twitter](https://twitter.com/zeithq).