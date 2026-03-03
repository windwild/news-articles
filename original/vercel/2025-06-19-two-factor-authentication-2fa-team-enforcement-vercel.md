---
title: "Two-factor authentication (2FA) team enforcement - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/2fa-team-enforcement"
date: "2025-06-19"
scraped_at: "2026-03-02T09:32:27.918777798+00:00"
language: "en"
translated: false
description: "Team owners can now enforce two-factor authentication (2FA) for every member of their team via a toggle in Security & Privacy under team settings."
---




Jun 19, 2025

![2FA Team Enforcement - Dark](images/two-factor-authentication-2fa-team-enforcement-vercel/img_001.jpg)![2FA Team Enforcement - Dark](images/two-factor-authentication-2fa-team-enforcement-vercel/img_002.jpg)

Teams can now require all members to enable two-factor authentication (2FA) for added security.

Team owners can enable enforcement in the [**Security & Privacy**](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings%2Fsecurity&title=Go+to+Security+%26+Privacy) section of team settings.

**Owner controls**

- View and filter each member’s 2FA status in the [team members settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings%2Fmembers&title=Go+to+Members)


**Member restrictions**

Once enforcement is enabled, members without 2FA will be restricted from:

- Triggering builds from pull requests

- Accessing new preview deployments

- Viewing the team dashboard

- Making API requests

- Using access tokens


**Enforcement lock-in & visibility**

- Members of a team with 2FA enforcement cannot disable 2FA unless they leave the team

- In each user’s account settings, teams that require 2FA are now listed for clarity


[Enable 2FA enforcement](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings%2Fsecurity&title=Go+to+Security+%26+Privacy) today, and [learn more in our docs](https://vercel.com/docs/two-factor-enforcement).