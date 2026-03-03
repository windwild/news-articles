---
title: "Preventing infrastructure abuse with Vercel Firewall - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/preventing-infrastructure-abuse-with-vercel-firewall"
date: "2024-09-24"
scraped_at: "2026-03-02T09:41:01.733380742+00:00"
language: "en"
translated: false
description: "DDoS resilience in the face of modern threats."
---




Sep 24, 2024

DDoS resilience in the face of modern threats.

In any given week, [Vercel Firewall](https://vercel.com/docs/security/vercel-firewall) blocks around 1 billion suspicious TCP connections, with some days seeing upwards of 7 billion malicious HTTP requests. Vercel's platform is designed to automatically [mitigate DDoS attacks](https://vercel.com/docs/security/ddos-mitigation), blocking thousands of these threats every day to keep your site secure and operational without user intervention. Vercel is built to minimize disruptions and safeguard your resources from unnecessary costs by serving only legitimate traffic.

![Over the past 30 days, Vercel's system Firewall blocked over 4.4 billion request attempts, in addition to blocks made by each customer's Web Application Firewall.](images/preventing-infrastructure-abuse-with-vercel-firewall-vercel/img_001.jpg)![Over the past 30 days, Vercel's system Firewall blocked over 4.4 billion request attempts, in addition to blocks made by each customer's Web Application Firewall.](images/preventing-infrastructure-abuse-with-vercel-firewall-vercel/img_002.jpg)

Over the past 30 days, Vercel's system Firewall blocked over 4.4 billion request attempts, in addition to blocks made by each customer's Web Application Firewall.

Recently, Vercel successfully mitigated a major DDoS attack, peaking at 1.37 Tbps and over 300 million packets per second (Mpps), with no downtime, impact, or manual config. This recent attack on Vercel highlights the complexity of modern DDoS threats, which can involve overwhelming data volumes, high packet rates, or a combination of both.

![Vercel quickly mitigated a DDoS attack that peaked at 1.37 Tbps within the first 2 minutes and lasted around 8 minutes.](images/preventing-infrastructure-abuse-with-vercel-firewall-vercel/img_003.jpg)![Vercel quickly mitigated a DDoS attack that peaked at 1.37 Tbps within the first 2 minutes and lasted around 8 minutes.](images/preventing-infrastructure-abuse-with-vercel-firewall-vercel/img_004.jpg)

Vercel quickly mitigated a DDoS attack that peaked at 1.37 Tbps within the first 2 minutes and lasted around 8 minutes.

DDoS attacks are evolving rapidly, enabling faster botnet coordination and automated techniques that exploit vulnerabilities with unprecedented speed. To effectively counter these diverse attack vectors, platforms must be adaptive to automatically shield customers and maintain service availability.

### The Vercel Firewall: Comprehensive, multi-layered security

Vercel Firewall is a built-in, multi-layered security solution that offers platform-wide protection and a customizable [Web Application Firewall (WAF)](https://vercel.com/docs/security/vercel-waf). It provides automated defense across all user tiers, from hobbyists to enterprises. Vercel's Firewall integrates Layer 4 protections, combining industry-leading third-party services with Vercel's own defenses, alongside proprietary Layer 7 protections tailored to modern web applications. Leveraging application awareness through its framework-defined infrastructure, Vercel enhances threat mitigation with enriched request context, enabling precise, proactive defense for each application.

With fast global propagation, edge protection, and intelligent routing, Vercel aims to ensure that your web applications remain secure and performant by default. This commitment to being [secure by default](https://vercel.com/resources/iterating-towards-secure-by-default) allows customers to scale with legitimate traffic while focusing on innovation and growth.

Vercel Firewall’s intelligent defenses detect and mitigate malicious traffic in real time, addressing both infrastructure-level (e.g. bots, DDoS and SYN Floods) and application-level (e.g. SQL injection and API abuse) threats to maintain service continuity across the platform. This approach to security helps ensure that as attacks evolve, Vercel's protections can adapt to mitigate threats before they impact your applications.

With default DDoS protection and a customizable WAF, customers can scale securely while focusing on growth. Vercel’s ongoing investments aim to make the web secure by default, minimizing downtime and blocking threats early.

[**Block AI Bots - Firewall Rule**\\
\\
Add a custom rule to your project's Firewall to detect common AI bots.\\
\\
This rule defaults to 'Log.' Change it to 'Deny' to block these bots.\\
\\
Add Firewall Rule](https://vercel.com/templates/vercel-firewall/block-ai-bots-firewall-rule)