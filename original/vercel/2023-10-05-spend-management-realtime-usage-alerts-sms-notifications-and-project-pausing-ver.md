---
title: "Spend Management: Realtime Usage Alerts, SMS Notifications, and Project Pausing - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-spend-management-realtime-usage-alerts-sms-notifications"
date: "2023-10-05"
scraped_at: "2026-03-02T09:50:19.743976997+00:00"
language: "en"
translated: false
description: "New controls to help you safely scale your projects and prevent unexpected bills."
---




Oct 5, 2023

Realtime Usage Alerts, SMS Notifications, and Automatic Project Pausing

Serverless infrastructure can instantly and infinitely scale. While powerful, this has had tradeoffs. An unforced error or traffic spike could cause an unexpected bill.

We heard your feedback—you wanted more control over your usage and spend. Today, we're rolling out new controls to help you safely scale your projects and manage spend:

- **Email / Web / SMS notifications** when your spend passes defined amounts

- **Flexible webhooks** to instantly take action on real-time usage updates

- **Automatic project pausing** when you reach your defined spend amount

- **New APIs** to programmatically pause and resume your projects

- **Safe defaults** for Vercel Functions with higher max durations


## More confidence with Spend Management

You can now instantly take action when your usage increases with **Spend Management and SMS notifications**.

![](images/spend-management-realtime-usage-alerts-sms-notifications-and-project-pausing-ver/img_001.jpg)![](images/spend-management-realtime-usage-alerts-sms-notifications-and-project-pausing-ver/img_002.jpg)

### What is Spend Management?

Spend management lets you take action when your usage hits the defined spend amount, either through:

- [Sending a notification](https://vercel.com/docs/accounts/spend-management#managing-alert-threshold-notifications)

- [Triggering a webhook](https://vercel.com/docs/accounts/spend-management#configuring-a-webhook)

- [Pause the production deployment of all your projects](https://vercel.com/docs/accounts/spend-management#pausing-projects)


### **Receiving notifications**

When your spend approaches or exceeds your set amount, you'll receive real-time notifications to help you stay in control. This includes **Web** and **Email** notifications at 50%, 75%, and 100%. Additionally, you can also receive **SMS** notifications when your spending reaches 100%.

Some examples of using Spend Management might look like:

- After launching your new product, you want to monitor growth and be alerted if things start to go viral. You define a Spend Notification for $200 to get alerted on your usage in real time. Once your spend reaches $200, an email notification is sent immediately.

- You are building a small AI project and are worried about potential malicious usage. Even though you’ve added [rate limiting](https://vercel.com/guides/rate-limiting-edge-middleware-vercel-kv), you want peace of mind knowing it won’t cost you more than $50. You define a Spend Notification for $50 to pause all projects when the spend amount if reached.


![](images/spend-management-realtime-usage-alerts-sms-notifications-and-project-pausing-ver/img_003.jpg)![](images/spend-management-realtime-usage-alerts-sms-notifications-and-project-pausing-ver/img_004.jpg)

Rather than waiting hours (or sometimes days) on other infrastructure, Vercel can measure and report back usage immediately, thanks to our real-time usage data pipeline.

On top of the default usage notifications through email or in-product, the addition of flexible spend notifications and our [Pause API](https://vercel.com/docs/rest-api/endpoints#pause-a-project) allows you to have complete confidence in your Vercel project. You can either automatically pause your projects when the spend amount is reached, our use a webhook to call the API programmatically.

app/api/pause/route.ts

```tsx
export async function POST(request: Request) {

2  await fetch('https://api.vercel.com/v1/projects/<project-id>/pause?teamId=<team-id>', {

3    headers: {

4      Authorization: 'Bearer <your-token>',

5      'Content-Type': 'application/json'

6    },

7    method: 'POST'

8  });

9  return new Response('Project paused');

10}
```

You can programmatically pause Vercel projects using our new REST API endpoint.

## Updates to Vercel Functions

Earlier this year, we released automatic recursion protection for Vercel Functions. This has already **prevented thousands of dollars in unintentional costs** for our customers.

This has been an improvement, but your feedback has been you want both lower defaults to prevent unintentional large bills, as well as the ability to have longer running Vercel Functions.

### Run Functions for up to five minutes

Customers deploying AI workloads with [Vercel Functions](https://vercel.com/docs/functions) have enjoyed streaming responses back with the [AI SDK](https://sdk.vercel.ai/docs), but not all of these workloads were chat or generative based. For some computationally heavy tasks like generating images, customers have wanted longer running Vercel Functions with the full power of Node.js.

**You can can run up to 5 minute functions** on the Pro plan. In additional, there is now a more safe default of 15 seconds ( [configurable](https://vercel.com/docs/functions/configuring-functions/duration)) as well. This helps prevent uncontrolled function usage due to abuse and reduces the risk of unexpectedly high bills.

## What's next for Spend Management

While we're excited about the new controls for managing your spend and getting alerted on real-time usage changes, there's more we want to do.

Next, we're working on **powerful anomaly detection** for your spend to proactively alert you when spikes happen, rather than manually adding spend amounts. Stay tuned for more product updates to help you scale with confidence on Vercel.

[Check out our documentation on Spend Management](https://vercel.com/docs/accounts/spend-management) and let us know your feedback.