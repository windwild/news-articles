---
title: "Unified security actions dashboard - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/unified-security-actions-dashboard"
date: "2025-12-08"
scraped_at: "2026-03-02T09:24:16.438013880+00:00"
language: "en"
translated: false
description: "A new unified dashboard for Vercel’s platform, infrastructure, and agent systems, which continuously monitor for vulnerabilities and configuration issues that require attention."
---




Dec 8, 2025

Vercel now provides [a unified dashboard](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Ffixes&title=View+Security+Actions+Dashboard) that surfaces any security issues requiring action from your team. When a critical vulnerability or security-related task is detected, the dashboard automatically groups your affected projects and guides you through the steps needed to secure them.

![](images/unified-security-actions-dashboard-vercel/img_001.jpg)![](images/unified-security-actions-dashboard-vercel/img_002.jpg)

This view appears as a banner whenever action is required, and can be accessed anytime through the dashboard search.

Most CVEs are handled automatically through WAF rules and other protections, but when user action is needed, they will appear here.

- **Automatic detection of security vulnerabilities that require user intervention -** When the platform identifies a vulnerability or configuration that cannot be fully mitigated by Vercel’s autonomous protections, it’s surfaced here with clear instructions.

- **Project grouping based on required actions -** Current categories include unpatched dependencies, manual fix required, unprotected preview deployments. Additional groups will appear over time as new protections and checks are added.

- **Support for both automated remediation -** When possible, [Vercel Agent offers one-click automated upgrades and PRs](https://vercel.com/changelog/automated-react2shell-vulnerability-patching-is-now-available).

- **Support for manual remediation -** For cases requiring manual updates or where GitHub access isn’t available, we provide direct instructions such as: `npx fix-react2shell-next`


### Stay secure with less effort

The unified dashboard helps teams act quickly during critical moments, consolidate required fixes in one place, and maintain a stronger security posture across all projects.

Explore the dashboard to [view any required updates](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Ffixes&title=View+Security+Actions+Dashboard).