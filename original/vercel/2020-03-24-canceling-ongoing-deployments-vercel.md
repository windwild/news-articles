---
title: "Canceling Ongoing Deployments - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/canceling-ongoing-deployments"
date: "2020-03-24"
scraped_at: "2026-03-02T10:07:11.774711848+00:00"
language: "en"
translated: false
description: "Preventing ongoing deployments from building is now simply a matter of clicking a button."
---




Mar 24, 2020

Sometimes you might find yourself having created a deployment that you don't need anymore, or that is causing other deployments to get queued behind it.

Previously, it was necessary to wait for such deployments to complete, and then delete them. As of today, however, you can immediately **cancel deployments** if they are no longer required.

## A New Cancel Button

In order to prevent a deployment from continuing to build, you can now click on the newly added "Cancel" button that shows up on the dashboard while your deployment is building:

![Canceling an ongoing deployment from the dashboard.](images/canceling-ongoing-deployments-vercel/img_001.jpg)Canceling an ongoing deployment from the dashboard.

Once you've canceled the deployment, any deployments queued behind it will start building.

## Preventing Deployments from Getting Queued

If you're creating new deployments very quickly, the most recently created ones may get queued until the oldest ones have completed building.

Canceling some of them will allow the others to start building. A better way to get them to start building, however, is to increase the amount of **Concurrent Builds** on your team's "Billing" settings page:

![Increasing the amount of Concurrent Builds.](images/canceling-ongoing-deployments-vercel/img_002.jpg)Increasing the amount of Concurrent Builds.

Please note that the **Concurrent Builds** feature is only available to teams.

## Conclusion

Preventing ongoing deployments from building is now simply a matter of clicking a button.

For teams that would like to increase the amount of deployments they can build at the same time, however, we recommend increasing the amount of Concurrent Builds.

[Let us know what you think](https://zeit.co/contact) about this change.