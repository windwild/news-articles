---
title: "Using Vercel comments to improve the Next.js 13 documentation - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/using-vercel-comments-to-improve-the-next-js-13-documentation"
date: "2022-11-03"
scraped_at: "2026-03-02T10:00:00.389267393+00:00"
language: "en"
translated: false
description: "Help us build the Next.js 13 documentation by commenting directly on the docs themselves."
---




Nov 3, 2022

A collaboration workflow to listen to the Next.js community directly on docs.

Writing documentation is a collaborative process—and feedback should be too. With the release of Next.js 13, we looked to the community to ensure our docs are as clear, easy to digest, and comprehensive as possible.

To help make it happen, we enabled the new Vercel commenting feature (beta) on the Next.js 13 docs. With 2,286 total participants, 509 discussion threads, and 347 resolved issues so far, our community-powered docs are on track to be the highest quality yet.

Visit [beta.nextjs.org/docs](https://beta.nextjs.org/docs) to give it a try.

## Addressing user feedback, faster

We [recently released](https://vercel.com/blog/introducing-commenting-on-preview-deployments) the ability to comment on [Preview Deployments](https://vercel.com/docs/concepts/deployments/preview-deployments) to help teams ship faster through streamlined feedback loops. A developer can now push code, get a Preview Deployment of their site on their production infrastructure, and allow stakeholders to comment directly on copy, UI elements, and interactions from a user’s point of view.

When feedback happens all in one place without having to add extra tools or define additional workflows, it makes it easy for developers to keep track of the things that need to be fixed and improved—enabling teams to ship higher quality work sooner.

> “The commenting product was originally designed for private usage, so I was a little hesitant to add it to a public, high-visibility site with 'everybody with the public link can comment' permissions. But my worries were misplaced. The gift of community feedback is incredible.The commenting product was originally designed for private usage, so I was a little hesitant to add it to a public, high-visibility site with 'everybody with the public link can comment' permissions. But my worries were misplaced. The gift of community feedback is incredible.”
>
> ![](images/using-vercel-comments-to-improve-the-next_js-13-documentation-vercel/img_001.png)
>
> **Malte Ubl - Vercel CTO**

Teams at Vercel have been successfully using comments for feedback on everything from the [Next.js Conf page](https://nextjs.org/conf) and weekly changelogs to new product experiences like [logs for monitoring](https://vercel.com/changelog/monitoring-is-in-public-beta-for-enterprise-teams). And since docs are such an important part of creating a great developer experience, we enabled comments on the published version of the Next.js 13 documentation (not just on the internal Preview Deployment).

### Improved context

In the past, we've taken feedback for the Next.js docs from Twitter, shared Slack workspaces, GitHub, Discord, and anywhere else we can hear back from the community. We wanted to try tracking feedback where proper context could be given to product owners, especially with such a large community wanting to share observations.

![A screenshot of the Next.js 13 beta docs with many preview comments. Even with this much feedback, we can quickly understand the exact parts of the UI that need improving.](images/using-vercel-comments-to-improve-the-next_js-13-documentation-vercel/img_002.jpg)A screenshot of the Next.js 13 beta docs with many preview comments. Even with this much feedback, we can quickly understand the exact parts of the UI that need improving.

With comments on Preview Deployments, we can more clearly address the exact piece of UI or content that a commenter is focused on. A reviewer doesn’t have to go through the process of taking screenshots, posting in other channels, or going out of their way to give extra detail to their product owner about the circumstances of their feedback.

With a comment on a Preview Deployment, proper context is the default.

### Greater feedback volume—with a tighter cycle

The ability to comment on Preview Deployments means a low barrier to entry when it comes to feedback. Because of this ease, over 2,000 reviewers felt empowered to express their thoughts so far. With 509 discussion threads started, the Next.js community was eager to answer each other's questions as well as leave thoughtful comments for the Next.js team.

With a greater centralization of feedback happening all in one place, we're able to handle the larger amount of feedback without feeling overwhelmed.

![A screenshot of preview comments showing a conversation between Next.js team member and community.](images/using-vercel-comments-to-improve-the-next_js-13-documentation-vercel/img_003.jpg)![A screenshot of preview comments showing a conversation between Next.js team member and community.](images/using-vercel-comments-to-improve-the-next_js-13-documentation-vercel/img_004.jpg)A screenshot of preview comments showing a conversation between Next.js team member and community.

But the communication loop doesn’t end there. Preview Deployments notify reviewers when a new deployment is available on the git branch so they can refresh the page for the latest changes. Additionally, reviewers receive emails when their comments have been resolved, confirming that their voice has been heard.

### Fewer, faster iterations

With comments, we were able to act on feedback faster and more precisely, while spending less time trying to figure out _**where**_ the issue is so that we can address it. A comment marks exactly in the UI where things need to improve as it's actually attached to the underlying DOM element.

At a greater feedback volume, we've had more information to work with so we can address interrelated comments and iterate on improvements faster than ever.

## **Get started with better feedback on your Preview Deployments**

Using comments on the Next.js docs is just one example of this feature in action. To use comments on your Vercel Preview Deployments, [enable the comments public beta](https://vercel.com/enable-comments), deploy a preview branch, and start streamlining your team's internal feedback process.

To get started use a [template](https://vercel.com/templates) or sign up for a [free Vercel account](https://vercel.com/signup).