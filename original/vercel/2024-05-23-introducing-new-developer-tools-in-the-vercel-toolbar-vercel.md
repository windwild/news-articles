---
title: "Introducing new developer tools in the Vercel Toolbar - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-new-developer-tools-in-the-vercel-toolbar"
date: "2024-05-23"
scraped_at: "2026-03-02T09:44:29.263585219+00:00"
language: "en"
translated: false
description: "The Vercel Toolbar now includes even more developer tools to simplify collaboration, improve accessibility, and enhance your workflow."
---




May 23, 2024

Learn about the new tools for accessibility, interaction timing, and Open Graph images—and the ability to use the toolbar in production.

Vercel’s Frontend Cloud is all about giving you and your team the tools to prioritize the user experience—so you can focus on what makes your product great and quickly iterate together with your team.

This collaboration hasn’t always been easy. Either you’re relying on screenshots or simulated experiences, or it requires separate infrastructure to spin up and maintain complex staging pipelines. It can waste weeks of developer time, and at larger organizations, it can mean spending up to 30% more just on the dev, test, and staging environments.

Vercel integrates deployments directly into your workflow. Whether you use GitHub, Azure DevOps, or your own CI system, Vercel automates the deployment process. Every change committed results in a [live URL](https://vercel.com/docs/deployments/preview-deployments)—a standalone environment to share with collaborators.

This approach allows for faster iteration, enabling you to ship smaller changes without dependencies across teams or branches. Additionally, it facilitates real-world testing across browsers and interactions, ensuring that you can experience your product exactly as your users would.

![The Vercel Toolbar can be programmed to appear on any of your web pages in any environment.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_001.jpg)![The Vercel Toolbar can be programmed to appear on any of your web pages in any environment.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_002.jpg)The Vercel Toolbar can be programmed to appear on any of your web pages in any environment.

Beyond automating CI/CD, the Vercel Toolbar offers a suite of tools designed to enhance collaboration and streamline development. And today, we’re announcing some new additions:

- Accessibility tool

- Open Graph tool

- Interaction timing tool

- Toolbar in production extension


## Enhancing developer and user experiences

The Vercel Toolbar is designed to improve collaboration and support your efforts to enhance accessibility and optimize performance. By incorporating it into your workflow, you can prioritize the user experience, iterate quickly, and deliver flawless products.

### Accessibility audits

Accessibility is a critical aspect of web development, and Vercel makes it easier than ever to ensure usability and compliance.

The Vercel Toolbar automatically checks your deployments against [Web Content Accessibility Guidelines 2.1](https://www.w3.org/TR/WCAG21/) Level A and AA rules, grouping them by impact as defined by [Deque axe](https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md#wcag-21-level-a--aa-rules). The accessibility audit reporting provides detailed information about failing elements and their associated rules, and you can turn on recording to track issues as you navigate the page.

![The accessibility audit tool is available on any page of your website and groups issues by impact.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_003.jpg)![The accessibility audit tool is available on any page of your website and groups issues by impact.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_004.jpg)The accessibility audit tool is available on any page of your website and groups issues by impact.

### Open Graph previews

The OG tool lets you see exactly how your OG cards will look on social platforms like X, Slack, Facebook, and LinkedIn.

This tool also provides information on any missing metadata your page needs to generate complete link previews.

![The OG tool generates previews of social media link cards for any of your web pages.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_005.jpg)![The OG tool generates previews of social media link cards for any of your web pages.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_006.jpg)The OG tool generates previews of social media link cards for any of your web pages.

### Interaction timing tool

You can optimize your website's responsiveness and user experience by measuring and improving Interaction to Next Paint (INP). INP observes the latency of all click, tap, and keyboard interactions on a page, and reports on their durations.

A low INP means the page can consistently respond quickly to the vast majority of user interactions. Ensuring your pages respond quickly means providing your users with the best experiences and preventing them from exiting your site early.

![The interaction timing tool allows you to see and optimize your website's responsiveness.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_007.jpg)![The interaction timing tool allows you to see and optimize your website's responsiveness.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_008.jpg)The interaction timing tool allows you to see and optimize your website's responsiveness.

### Using the toolbar in production

Lastly, you can really customize your workflows by leveraging the toolbar in production with our new, [zero-config Chrome extension](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost#adding-the-toolbar-using-the-chrome-extension). This means that if you encounter an issue, suggestion, or typo while using your site, you can quickly flag it.

Tools like INP, layout shift, accessibility audits, and feature flag overrides can now be evaluated on your live site, providing additional insights. When in production, the toolbar is only visible to team members, making it the perfect internal bug-reporting tool.

## The toolbar toolkit keeps growing

These new additions join an already robust set of tooling:

- [Comments](https://vercel.com/docs/workflow-collaboration/comments): Give feedback directly on deployments with the Vercel Toolbar. Comment on anything from pricing pages to documentation and add screenshots and emojis for context. Then, convert comments into tickets in your tracking system (Linear, Jira, GitHub, or Slack) so you can close the loop quickly.

- [Content](https://vercel.com/docs/integrations/cms): For teams using Vercel as the head for their headless applications, the toolbar provides a quick link to view and edit content in your CMS. When editable content is detected, a pencil icon appears, allowing you to link directly to that field in your CMS. Plus, you can toggle Draft Mode to preview changes before they go live—perfect for blog posts and landing page updates.

- [Layout shift](https://vercel.com/docs/workflow-collaboration/layout-shift-tool): Identify and analyze layout shifts on your page, and get a summary of what caused the shift and how many elements were affected. You can replay and animate these shifts to see them again.

- [Quick links](https://vercel.com/docs/workflow-collaboration/vercel-toolbar#using-the-command-menu): Switch between branches on preview and production branches or navigate to other deployments, teams, and projects.


Explore the Vercel Toolbar today and experience truly collaborative iteration in your development. Visit our [documentation](https://vercel.com/docs/workflow-collaboration/vercel-toolbar) to learn more and start enhancing your projects with Vercel's powerful tools. With Vercel, iterating on your product is no longer a separate step—it's a seamless part of your workflow.