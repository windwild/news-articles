---
title: "Introducing Conformance and Code Owners: Move fast, don't break things - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-conformance"
date: "2023-12-05"
scraped_at: "2026-03-02T09:49:34.190018520+00:00"
language: "en"
translated: false
description: "Conformance and Code Owners are now available"
---




Dec 5, 2023

Learn about powerful new features on Vercel's Developer Experience Platform to help scale code health, performance, and security.

As organizations grow, it can become hard to sustain fast release cycles without diminishing code health and letting errors slip into production. It shouldn't be this way. We should be able to move fast _without_ breaking things—making quick updates and innovating while retaining great performance, security, and accessibility.

Today, we're releasing new features to Vercel's [Developer Experience Platform](https://vercel.com/products/dx-platform) to help [Enterprise teams](https://vercel.com/enterprise) ship higher quality code, with the same velocity even as teams and codebases scale.

- [**Conformance**](https://vercel.com/docs/workflow-collaboration/conformance) **:** Automate detection of critical issues early in the development lifecycle and prevent them from reaching production.

- [**Code Owners**](https://vercel.com/docs/workflow-collaboration/code-owners) **:** Find who is responsible for the code and make sure that code changes are reviewed by the right people, every time.

- [**A reimagined dashboard experience**](https://vercel.com/docs/workflow-collaboration/conformance/dashboard-overview) **:** A workspace to surface code health insights, help with cross-team collaboration, and ensure a better onboarding experience for new team members.


## **Conformance: Out-of-the-box static analysis**

Our Conformance tooling runs [static analysis checks](https://vercel.com/docs/workflow-collaboration/conformance/rules) over your codebase to find critical issues before merging—allowing you to move quickly without compromising quality. It automatically checks for issues that may result in performance, security, or quality problems in your production applications.

![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_001.jpg)![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_002.jpg)

[**Contact us to get started**\\
\\
Get in touch to learn how these powerful new features on Vercel's Developer Experience Platform can help your Enterprise team scale code health, performance, and security.\\
\\
Contact Us](https://vercel.com/contact/sales)

Conformance rules span multiple files, instead of verifying each file individually, providing a holistic perspective on your codebase. It also adds frontend specific context to issues, classifies and tags issues, as well as assigns a severity with granular ownership of both rules and rule violation exceptions.

By providing a high-level score and tracking issues in the dashboard, you get a barometer for assessing accumulated technical debt. Much like a performance budget, this score becomes invaluable in understanding when and where to prioritize tasks. Specifically, you can [allowlist a specific number of issues](https://vercel.com/docs/workflow-collaboration/conformance/allowlist) before going to production, then track how you start unlisting them and burning down through the issues to improve code health.

> “Conformance helped us uncover a lot of small issues that were adding up to impact our performance in a big way. After addressing just the first few, we saw more than 200ms improvement in performance for all of our pages.Conformance helped us uncover a lot of small issues that were adding up to impact our performance in a big way. After addressing just the first few, we saw more than 200ms improvement in performance for all of our pages.”
>
> ![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_003.jpg)
>
> **Daniel Brown,** Senior Frontend Engineer at Upstart

Conformance was built by the creators of [Next.js](https://vercel.com/solutions/nextjs) and [Turborepo](https://turbo.build/repo). By codifying decades of their combined experience crafting high performant web sites and deep knowledge of the framework ecosystem, we're able to go _beyond_ catching errors, towards actually optimizing your application.

You can run Conformance within your CI/CD systems or locally to:

- **Next.js:** Use guardrails crafted by the inventors of Next.js to catch common issues that can happen in Next.js applications. For example, detect when `getServerSideProps` is not needed, as there's no use of the context parameter and it could be static generated.

- **Performance:** Catch issues that negatively affect the performance of your website. For example, prevent blocking serial asynchronous calls in your applications.

- **Code health:** Set general rules that can prevent things from negatively affecting your codebase or code health. For example, require that a workspace package that uses TypeScript files has configured TypeScript correctly for that workspace.

- **Security:** Act as a first layer of threat detection for security vulnerabilties. For example, require that important security headers are set correctly for Next.js apps and contain valid directives.


> “What we love most about Conformance is the global feedback, as it provides us with a global overview about our code health and it is able to monitor issues that are not pointed out by ESLint. It’s a huge time saver.What we love most about Conformance is the global feedback, as it provides us with a global overview about our code health and it is able to monitor issues that are not pointed out by ESLint. It’s a huge time saver.”
>
> ![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_004.png)
>
> **Stéphane Lavaud,** Frontend Web Development Manager at Origins Digital

### Accelerate innovation, reduce time spent on bugs

Deploying bad code has an outsized impact on a team's velocity.

Debugging alone can take away a year's worth of valuable developer time. Conformance strategically places guardrails to redirect brainpower towards creation, rather than time-consuming error detection. By proactively resolving potential issues, Conformance frees developers from unnecessary dependencies, leading to increased productivity and allowing them to channel their efforts into the projects and features that will improve end-customer experiences.

> “Our team had been hesitant to use Remote Caching because early testing showed high bandwidth usage. Conformance helped us uncover easy improvements that made Remote Caching viable for us. We're now saving more than 45 days of CI team work every week with 71% task cache hits.Our team had been hesitant to use Remote Caching because early testing showed high bandwidth usage. Conformance helped us uncover easy improvements that made Remote Caching viable for us. We're now saving more than 45 days of CI team work every week with 71% task cache hits.”
>
> ![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_003.jpg)
>
> **Daniel Brown,** Senior Frontend Engineer at Upstart

## **Code Owners: Framework-defined ownership**

As your company grows, you need a code ownership system that grows with you.

Code Owners works with your [Git integration](https://vercel.com/docs/deployments/git#), ensuring code reviews with smart reviewer assignments, and an escalation protocol that ensures appropriate individuals review your code and escalate concerns when needed.

![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_006.jpg)![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_007.jpg)

Code Owners mirrors the structure of your organization. This means Code Owners who are higher up in the directory tree act as broader stewards over the codebase and are the fallback if owners files go out of date, such as when developers switch teams. And, with [Modifiers](https://vercel.com/docs/workflow-collaboration/code-owners#modifiers) your organization can tailor your code review process. For example, you can assign reviews in a round-robin style, based on who's on call, or to the whole team.

### **All while elevating application security**

Security remains at the forefront of every feature we release. Creating security rules with Conformance and Code Owners brings your security team into the development process. Conformance catches issues that could become security vulnerabilities, [like unsafe usage of cookies in your application](https://vercel.com/docs/workflow-collaboration/conformance/rules), before they make it to production. Similarly, Code Owners ensures no one on your team becomes a security vulnerability.

Using the features together, you can define an allowlist file for Security rules, and then assign your Security team as code owner of that file. So whenever someone tries to add something new to the list, the Security teams needs to approve it.

## **A reimagined dashboard experience for monorepos**

When you start using Conformance, you'll also see a [redesigned dashboard](https://vercel.com/docs/workflow-collaboration/conformance/dashboard-overview) within [vercel.com](http://vercel.com/) that gives developers and leadership team members an overall view of project health. At a glance, any team member can see global code health, Conformance scores, and the teams responsible for those repositories. This means, you can understand problem areas and investigate errors by seeing all of your allowlisted performance, security, or code-quality errors.

![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_008.jpg)![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_009.jpg)

## **Move fast, don’t break things**

[Conformance](https://vercel.com/docs/workflow-collaboration/conformance) and [Code Owners](https://vercel.com/docs/workflow-collaboration/code-owners) are a major step forward in providing developers with the tools and resources they need to build better, more efficient applications.

Today, Conformance and Code Owners are Generally Available on Vercel for Enterprise teams.

[**Upgrade your workflow today**\\
\\
Reach out to learn more about how you can improve your frontend workflow and empower your team to ship better web experiences with Vercel.\\
\\
Contact Us](https://vercel.com/contact/sales)