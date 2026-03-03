---
title: "Visual Editing meets Markdown with Tina.io - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/visual-editing-meets-markdown"
date: "2023-06-06"
scraped_at: "2026-03-02T09:52:22.385800396+00:00"
language: "en"
translated: false
description: "TinaCMS adopts Visual Editing"
---




Jun 6, 2023

Learn about click-to-edit for Markdown, MDX, and JSON from Scott Gallant, CEO at Tina.io.

We're excited to share that [TinaCMS](http://tina.io/?utm_source=vercel_guest_post&utm_medium=partner_blog) now supports [Visual Editing](https://vercel.com/docs/workflow-collaboration/visual-editing) in Vercel Preview Deployments.

The TinaCMS team is on a mission to bring visual editing to the headless CMS in a way that works for developers. So when we had the opportunity to collaborate with Vercel on this, we didn't hesitate and the results are stunning.

The most impressive thing about Vercel's Visual Editing is the developer experience. It can be enabled without modifying your frontend templates.

## **What is TinaCMS?**

TinaCMS is a headless CMS that stores content in files such as Markdown, MDX, JSON, and more. It stays in-sync with your Git repository and allows content editors to work on branches.

Tina is often used to power large documentation and blog sites, such as [smashingmagazine.com](https://www.smashingmagazine.com/), but it is also a popular choice for marketing sites due to its visual editing functionality.

## **Why Visual Editing?**

Headless CMSes are dominating the industry because of the huge boost in developer productivity. When your CMS is only concerned about the storage, delivery, and editing of content, developers are free to use any modern framework; making them much more efficient.

But the headless CMS movement came at the cost of the marketer’s productivity. Headless CMSes are so decoupled from the output of a site that marketers and content creators often cannot easily preview their work.  Vercel Preview Deployments improve this process significantly, but there’s still friction when it comes to finding and editing the right piece of content in a CMS, especially if it’s deeply nested inside complex content structures.

The headless CMS UX can feel archaic to marketers who are familiar with real-time editing experiences in tools like Google Docs, Webflow, or Notion. The pendulum swung to developer productivity and now Visual Editing it’s swinging back to marketer productivity, so you can have both.

### A Seamless Experience with TinaCMS

Vercel’s Visual Editing experience really shines with Tina because your Vercel Preview Deployment is shown in an iframe, next to the CMS editing interface. So, you're seeing your site and the CMS side-by-side. This allows you to click & edit, then click & edit some more, all without leaving the page. Users don't need to go to a new tab and the experience is seamless. The UX feels like Wix, but under the hood it’s connected to a headless CMS and an open-source framework.

### **Markdown + Visual Editing**

Tina stores content in Markdown, MDX, JSON, files and syncs with your Git repository.  Tina spins up a Data Layer so you can fetch your Markdown content just like you would with any other headless CMS. You can self-host Tina’s Data Layer using any KV store, such as [Vercel KV](https://vercel.com/docs/storage/vercel-kv).

![](images/visual-editing-meets-markdown-with-tina_io-vercel/img_001.jpg)![](images/visual-editing-meets-markdown-with-tina_io-vercel/img_002.jpg)

This has many benefits, such as:

- Version control for your content

- Branch workflows for content creators

- Content is not locked-into a vendor’s database

- Scale Markdown to tens of thousands of pages

- [Separate repositories](https://tina.io/guides/tinacms/separate-content-repo/guide/?utm_source=vercel_guest_post&utm_medium=partner_blog) for code and content

- Incremental Static Regeneration ( [ISR](https://vercel.com/docs/concepts/incremental-static-regeneration/overview)) and Server-Side Rendering ( [SSR](https://nextjs.org/docs/pages/building-your-application/rendering/server-side-rendering)) for Markdown

- Consistent data structure enforced across all content files with the [Tina Schema](https://tina.io/docs/schema/?utm_source=vercel_guest_post&utm_medium=partner_blog)


Tina’s unique approach of a headless CMS on top of Markdown-backed content is what makes it possible to support Vercel’s Visual Editing functionality.

### **Get Started**

We’re excited to bring Visual Editing to Markdown-based content and we’re enthusiastic about this new era for the headless CMS. We no longer need to choose between the marketer or the developer. We can make both groups happy with Visual Editing on top of a headless CMS.

For more information, please see the [documentation](https://github.com/tinacms/tinacms/blob/main/packages/%40tinacms/vercel-previews/README.md?utm_source=vercel_guest_post&utm_medium=partner_blog) or contact [info@tina.io](mailto:info@tina.io).