---
title: "Building a viral application for your personal music festival - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/from-idea-to-100-million-views-instafest-music-festival-application"
date: "2022-12-12"
scraped_at: "2026-03-02T09:57:42.941639974+00:00"
language: "en"
translated: false
description: "Learn how Anshay Saboo, a Computer Science student at USC, used Next.js and Vercel to launch Instafest fast and scale to 500,000 new users per hour."
---




Dec 12, 2022

[Instafest](https://www.instafest.app/) allows users to quickly create a festival poster from their top Spotify, Apple Music, and Last.fm artists. [Anshay Saboo](https://twitter.com/AnshaySaboo), a Computer Science student at USC, used Next.js and Vercel to launch Instafest fast and scale to **500,000 new users per hour**, gaining millions of users and going viral on Twitter, TikTok, and more.

> “I never expected Instafest to grow as quickly as it did. I couldn’t believe how well Vercel and Next.js handled the enormous scale with ease.I never expected Instafest to grow as quickly as it did. I couldn’t believe how well Vercel and Next.js handled the enormous scale with ease.”
>
> ![](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_001.jpg)
>
> **Anshay Saboo,** Creator of Instafest

## Launching Instafest

Instafest launched on November 22nd, 2022. It started small, with only 100-150 users per hour on the first day. It grew quickly from there, reaching 500 users per hour on the second day and 2,000 on the third. By the following Sunday, the app was gaining **70,000 users per hour**.

![Using Vercel Monitoring to visualize traffic to Instafest during peak virality.](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_002.jpg)![Using Vercel Monitoring to visualize traffic to Instafest during peak virality.](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_003.jpg)Using Vercel Monitoring to visualize traffic to Instafest during peak virality.

The site continued to gain popularity, with new features being added daily. After being shared on social media by celebrities like QuestLove, rapper 24KGoldn, director Edgar Wright, and YouTuber Matt King, the site continued to grow. At it’s peak, Instafest was serving 500,000 new users per hour and saw over 100 million page views in that week.

## Using Next.js for high-performance React sites

Anshay knew he wanted to use React, so he picked [Next.js](https://vercel.com/docs/concepts/next.js/overview) to “make the application snappy and responsive”. The Instafest website needed to handle loading custom web fonts and displaying fast-loading images of the festival posters. By using Next.js, Anshay was able to use the [built-in font optimization](https://nextjs.org/docs/basic-features/font-optimization) and [image component](https://nextjs.org/docs/basic-features/image-optimization) to keep the site performance fast and prevent layout shift.

By using the image component, Next.js automatically optimizes and serves images in modern formats (like `.avif` and `.webp`) to reduce the size of images. This helps pages load faster and provide a better user experience for Instafest viewers. Additionally, Next.js automatically generates responsive images, which means that it creates multiple versions of each image at different sizes. This allowed Instafest to serve the most appropriate sized image for each user's device, further improving performance.

## Deploying Next.js with Vercel

Anshay needed to quickly get his Next.js site online fast, so he turned to Vercel to go from idea to global application in seconds.

> “Vercel was the key to Instafest’s successful launch. Being able to easy deploy code, as well as instantly rollback when things went wrong, was crucial.Vercel was the key to Instafest’s successful launch. Being able to easy deploy code, as well as instantly rollback when things went wrong, was crucial.”
>
> ![](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_001.jpg)
>
> **Anshay Saboo,** Creator of Instafest

Thanks to Vercel Functions, the Next.js application was able to scale automatically, without needing to provision additional servers, add load balancers, or pay for more expensive hardware. Instafest was highly available, everywhere around the world, visualized below with [Vercel Monitoring](https://vercel.com/docs/concepts/dashboard-features/monitoring) broken down by Edge Network regions.

![Using Vercel Monitoring to visualize traffic segmented by Edge Network region.](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_005.jpg)![Using Vercel Monitoring to visualize traffic segmented by Edge Network region.](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_006.jpg)Using Vercel Monitoring to visualize traffic segmented by Edge Network region.

Instead, Anshay was able to take advantage of Vercel’s global Edge Network to easily cache both static assets and Function responses. Peaking at 6 million users per day, Instafest never had downtime or showed any increase in latency under load. Using [Vercel Analytics](http://vercel.com/analytics), Anshay could visualize the real user performance of Instafest visitors.

![Using Vercel Analytics to visualize application performance from Core Web Vitals field data.](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_007.jpg)![Using Vercel Analytics to visualize application performance from Core Web Vitals field data.](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_008.jpg)Using Vercel Analytics to visualize application performance from Core Web Vitals field data.

Learn more about [Next.js on Vercel](https://vercel.com/docs/concepts/next.js/overview) or get started today using one of our [Next.js templates](http://vercel.com/templates/next.js).