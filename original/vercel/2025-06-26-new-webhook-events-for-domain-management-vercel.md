---
title: "New webhook events for domain management - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-webhook-events-for-domain-management"
date: "2025-06-26"
scraped_at: "2026-03-02T09:31:55.070030660+00:00"
language: "en"
translated: false
description: "You can now subscribe to webhook events for deeper visibility into domain operations on Vercel. These events make it easier to automate domain workflows, especially in multi-tenant platforms or when m..."
---




Jun 26, 2025

You can now subscribe to webhook events for deeper visibility into domain operations on Vercel.

**New event categories include:**

- **Domain transfers**: Track key stages in inbound domain transfers.

- **Domain renewals**: Monitor renewal attempts and auto-renew status changes, ideal for catching failures before they impact availability.

- **Domain certificates**: Get notified when certificates are issued, renewed, or removed, helping you maintain valid HTTPS coverage across environments.

- **DNS changes**: Receive alerts when DNS records are created, updated, or deleted.

- **Project Domain Management**: Detect domain lifecycle changes across projects, including creation, updates, verification status, and reassignment.


These events are especially valuable for multi-tenant platforms that dynamically assign domains per user or customer. They also help teams build monitoring and alerting into critical domain and certificate operations.

For details on how to subscribe, visit the [webhook documentation](https://vercel.com/docs/webhooks/webhooks-api).