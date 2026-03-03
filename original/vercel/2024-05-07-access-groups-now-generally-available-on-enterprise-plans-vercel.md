---
title: "Access groups now generally available on Enterprise plans - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/access-groups-now-generally-available-on-enterprise-plans"
date: "2024-05-07"
scraped_at: "2026-03-02T09:45:05.998707391+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 7, 2024

![](images/access-groups-now-generally-available-on-enterprise-plans-vercel/img_001.jpg)![](images/access-groups-now-generally-available-on-enterprise-plans-vercel/img_002.jpg)

Enterprise customers can now manage access to critical Vercel projects across many Vercel users easier than ever with Access Groups.

Access Groups allow team administrators to create a mapping between team members and groups of Vercel projects. Users added to an Access Group will automatically be assigned access to the Projects connected to that Access Group, and will be given the default role of that group, making onboarding easier and faster than ever for new Vercel Team members.

For customers who use a third-party Identity Provider, such as Okta, Access Groups can [automatically sync](https://vercel.com/docs/security/directory-sync) with their provider, making it faster to start importing users to Vercel without creating manual user group mappings (Vercel is [SCIM](https://vercel.com/docs/security/saml) compliant).

For example, you can have a Marketing Engineering Access Group, which has a default project role of "Developer". When a new member is added to the Marketing Engineering group, they will automatically be assigned the Developer role, and access to all Projects assigned to that group.

This builds on our advanced access controls, like [project level access controls](https://vercel.com/docs/accounts/team-members-and-roles/access-roles/project-level-roles) and [deployment protection](https://vercel.com/docs/security/deployment-protection). Learn more about [Access Groups](https://vercel.com/docs/accounts/team-members-and-roles/access-groups) or [contact us for a demo](https://vercel.com/contact/sales) of our access security features.