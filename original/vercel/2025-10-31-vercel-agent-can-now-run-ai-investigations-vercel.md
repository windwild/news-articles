---
title: "Vercel Agent can now run AI investigations - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-agent-can-now-run-ai-investigations"
date: "2025-10-31"
scraped_at: "2026-03-02T09:26:21.619751071+00:00"
language: "en"
translated: false
description: "Vercel Agent Investigation intelligently conducts incident response investigations to alert, analyze, and suggest remediation steps"
---




Oct 31, 2025

Vercel is reimagining incident response for the agentic age.

At [Ship AI](https://vercel.com/blog/ship-ai-2025-recap), we launched Vercel Agent Investigations in Public Beta, a new skill of Vercel Agent that automatically detects issues in your application, conducts root cause analysis, and provides actionable remediation plans to resolve incidents faster. Vercel Agent already helps teams with AI-powered code reviews. Now, it's expanding to help with incident response.

By combining our newly-released [anomaly alerts](https://vercel.com/docs/alerts) with investigations, we're improving how development teams respond to and resolve production issues.

## The hidden cost of incident response for development teams

Modern web applications can generate overwhelming amounts of raw logs and metrics. Every deployment, every user interaction, and every API call produces data that could signal the difference between smooth operations and a critical incident.

When a build deployment goes wrong, someone needs to investigate. The modern pace of development means teams are shipping faster than ever, which makes incident investigation increasingly challenging to manage. Hours spent on incident response compound quickly, pulling engineering resources away from feature development and reducing overall team velocity.

### The current state of incident response

Today's development teams face several operational challenges that slow development time and burn out teams. Poorly-tuned tools desensitize teams to critical alerts and allow false positives to slip through. Incidents create hours-long manual investigations and context switching that kill productivity, especially if there's a large knowledge and experience gap between team members. Post-mortems and post-incident runbook updates that can prevent future incidents often become deprioritized to catch up on delayed work.

## Vercel Agent Investigations reduce manual incident response

Investigations are our solution to reducing the manual work of incident response. Vercel Agent uses broad visibility across build time and runtime to automatically analyze incidents and identify root causes to run investigations natively within your application, without using third party tools.

### Anomaly detection without configuration

Anomaly alerts continuously monitor your application for unusual activity, such as spikes in billable metrics like function duration or fast data transfer, or increases in `5xx` errors. There's no configuration needed. Any team subscribed to [Observability Plus](https://vercel.com/docs/observability/observability-plus) automatically gets anomaly alerts out-of-the-box.

Once we detect an anomaly, Vercel Agent can step in and either automatically or on-demand, investigate the issue.

![When anomalies occur, Vercel Agent investigates automatically to separate signal from noise, surface what deserves your attention, and suggest next steps. ](images/vercel-agent-can-now-run-ai-investigations-vercel/img_001.jpg)![When anomalies occur, Vercel Agent investigates automatically to separate signal from noise, surface what deserves your attention, and suggest next steps. ](images/vercel-agent-can-now-run-ai-investigations-vercel/img_002.jpg)When anomalies occur, Vercel Agent investigates automatically to separate signal from noise, surface what deserves your attention, and suggest next steps.

### AI-powered root cause analysis

Once we detect an anomaly, Agent performs the same analysis a senior engineer would, processing multiple streams of data and charts to identify issues in seconds, not hours.

The Vercel Agent analyzes issues with multiple inputs:

- **Correlation analysis:** What other metrics changed around the same time? Did a deployment just complete? Did traffic patterns shift?

- **Historical context**: Has this issue occurred before? What was the resolution last time?

- **Dependency mapping**: Which upstream or downstream services might be affected? Is this a cascading failure?

- **Change attribution**: What code changes or configuration updates preceded the anomaly?


Agent generates a succinct summary that provides clear insights into what went wrong and why, eliminating the guesswork from incident response. Accelerating root-cause analysis during this critical time window improves time-to-remediation and reduces downtime for end-users.

### Impact assessment and actionable recommendations

Not every alert requires immediate action. Investigations assesses the severity and impact of each issue, helping teams prioritize their response. If an issue has already resolved itself, Investigations identifies this so teams can focus their attention elsewhere. For ongoing issues, Investigations determines whether the problem affects user experience, application stability, or specific subsystems.

Based on its analysis, investigations provide specific, actionable steps tied to the root cause it identified. This eliminates the common problem of generic incident response playbooks that don't account for your specific application architecture or the nature of the failure.

![Vercel Agent investigates a spike in anomalous activity and describes the errors that caused it. ](images/vercel-agent-can-now-run-ai-investigations-vercel/img_003.jpg)![Vercel Agent investigates a spike in anomalous activity and describes the errors that caused it. ](images/vercel-agent-can-now-run-ai-investigations-vercel/img_004.jpg)

Vercel Agent investigates a spike in anomalous activity and describes the errors that caused it.

## **Getting started with Vercel Agent Investigations**

Visit the [Agent tab](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fvercel-agent) in the Vercel dashboard to have it run automatically on all error alerts, or choose to run an investigation manually as long as you have Vercel Agent credits.

Agent Investigations are only available to teams that have [Observability Plus](https://vercel.com/docs/observability/observability-plus), as they build upon its premium features. New Agent users can claim a $100 free credit to use towards both Vercel Agent Investigations and Code Reviews.

Anomaly alerts are available out-of-the-box for Observability Plus subscribers. Email alerts are default for team owners and optional for team members. Additionally, we provide a Slack integration and webhooks for any communication, ticketing, or incident response tool.

Learn more about [Alerts](https://vercel.com/docs/alerts) or enable it on the [Observability dashboard](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fobservability%2Falerts) today.