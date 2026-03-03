---
title: "Next.js 11, Next.js Live and more: A recap of Next.js Conf Special Edition - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/nextjs-special-event-recap"
date: "2021-06-22"
scraped_at: "2026-03-02T10:04:54.314807483+00:00"
language: "en"
translated: false
description: "Learn more about the latest releases announced at Next.js Conf, including Next.js 11 and Next.js Live."
---




Jun 22, 2021

Last week, over 65,000 members of the Next.js community tuned in to watch a special edition of [Next.js Conf](http://nextjs.org/conf) where we shared our progress toward building a faster web.

Missed it? Here's what you need to know.

## Improving User and Developer Experience with Next.js 11

Next.js 11 continues our mission to provide the best user and developer experience possible.

With Next.js 11 we introduced a new [Script component](https://nextjs.org/docs/basic-features/script), designed to improve loading performance and give developers greater flexibility when adding third-party scripts to their applications.

Next.js expert [Lydia Hallie](https://twitter.com/lydiahallie) demonstrated the updated [Image component](https://nextjs.org/docs/basic-features/image-optimization), which now has automatic size detection and support for [blur-up placeholders](https://nextjs.org/docs/api-reference/next/image#placeholder). These updates create a smoother loading experience for end-users and reduce [Cumulative Layout Shift](https://vercel.com/blog/core-web-vitals#cumulative-layout-shift), a Core Web Vital.

> “Images are often the largest part of web pages, especially in eCommerce. The Community has done a great job improving the Next.js image component since it was released in October. Our focus has been on automating best practices and optimizing for each device viewport the image is delivered to.Images are often the largest part of web pages, especially in eCommerce. The Community has done a great job improving the Next.js image component since it was released in October. Our focus has been on automating best practices and optimizing for each device viewport the image is delivered to.”
>
> ![](images/next_js-11-next_js-live-and-more-a-recap-of-next_js-conf-special-edition-vercel/img_001.jpg)
>
> **Lydia Hallie,** Software Engineer

Image, Script, and Font Optimizations were built in partnership with the Google Chrome team and backed by performance research. They were designed to improve loading performance while still allowing developers the flexibility to choose what's right for their application.

Read more about the latest updates on the [Next.js blog](http://nextjs.org/11).

## Conformance for Next.js

Shubhie Panicker and Houssein Djirdeh from [Google's Aurora team](https://web.dev/aurora) joined us to highlight a few of the foundational optimizations introduced in [Next.js 11](https://nextjs.org/11), and announce **Conformance for Next.js.**

**Conformance** is a set of guardrails and defaults built into the framework to help developers make the best decisions for their applications. This will help empower developers to feel confident in choices that may affect performance, and help teams maintain consistent quality, even as they scale.

> “The most important thing I've learned is that for developers to achieve and maintain the best app quality, the framework must participate and do the heavy lifting. At Google, we shifted the hard work away from developers and into the framework. This means every developer using the framework has all the solutions baked into every project they work on.The most important thing I've learned is that for developers to achieve and maintain the best app quality, the framework must participate and do the heavy lifting. At Google, we shifted the hard work away from developers and into the framework. This means every developer using the framework has all the solutions baked into every project they work on.”
>
> ![](images/next_js-11-next_js-live-and-more-a-recap-of-next_js-conf-special-edition-vercel/img_002.jpg)
>
> **Shubhie Panicker,** Google Chrome

[Read more about Conformance for Next.js.](https://nextjs.org/blog/next-11#conformance)

## Real-time collaboration with Next.js Live

We took another step toward a faster, more collaborative web development process with our preview release of **Next.js Live**.

Next.js Live brings the entire development process into the browser, making it faster and more inclusive of the entire organization. With Next.js Live, you can share collaborative URLs with your team to chat, draw, and edit code together – no dependencies or downloads required.

This means truly real-time development. As you edit code in Next.js Live, both you and your collaborators will see those changes reflected instantly, without needing to redeploy.

[Try it out with your team on our Next.js Commerce template.](http://nextjs.org/live)

![](images/next_js-11-next_js-live-and-more-a-recap-of-next_js-conf-special-edition-vercel/img_003.jpg)

[Watch the entire Special Edition keynote](https://nextjs.org/conf), including demos of Next.js 11 and Next.js Live.

We're excited to see you later this year for a full Next.js Conf experience where we'll celebrate the fifth anniversary of Next.js. Stay tuned for more details.