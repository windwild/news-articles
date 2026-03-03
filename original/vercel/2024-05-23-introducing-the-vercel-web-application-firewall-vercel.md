---
title: "Introducing the Vercel Web Application Firewall - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-the-vercel-waf"
date: "2024-05-23"
scraped_at: "2026-03-02T09:44:14.932565512+00:00"
language: "en"
translated: false
description: "Introducing the Vercel Web Application Firewall: application-aware, Vercel-native protection that brings the web one step closer to being secure by default."
---




May 23, 2024

Application-aware, Vercel-native protection that brings the web one step closer to being secure by default.

In any given week, Vercel blocks around 1 billion suspicious TCP connections, with some days seeing upwards of 7 billion malicious requests. The Vercel Firewall has been silently mitigating DDoS and Layer 3/4 attacks, but it's been operating as a black box with limited transparency.

We believe security should be built into every step of the development process. This is why we're dedicated to improving our security suite by giving you greater visibility and the control you need to understand and manage your sites hosted on Vercel.

Today, we're introducing the Vercel Web Application Firewall (WAF), adding an extra layer of defense against a wider range of web threats directly within the Vercel platform, so you can deliver modern web experiences with uncompromising speed, scalability, and protection.

## **Next-level security, seamlessly integrated**

The Vercel-native WAF provides first-party security at the edge—reducing latency and ensuring only legitimate users access your application. Embedded in the Vercel ecosystem, the WAF deploys automatically, with no additional routing rules, external tools, or complex integrations required.

**All plans** now offer granular Layer 7 control over application entry points to block unwanted traffic, plus the new [Attack Challenge Mode](https://vercel.com/docs/security/attack-challenge-mode) and existing real-time [DDoS mitigation](https://vercel.com/docs/security/ddos-mitigation) via our platform-wide firewall.

![The new Vercel Firewall.](images/introducing-the-vercel-web-application-firewall-vercel/img_001.jpg)![The new Vercel Firewall.](images/introducing-the-vercel-web-application-firewall-vercel/img_002.jpg)The new Vercel Firewall.

## **Powerful features for comprehensive protection**

The Vercel WAF protects your apps from diverse threats with a powerful feature set, including:

- **Customizable rules engine:** Define granular rules based on path, user agent, IP address, geolocation, JA4 fingerprints, and target paths to control how traffic is handled. For example, you could create a rule to block all traffic from a specific country, only allow access to certain paths based on user roles, or only allow connections from a known list of browsers

- **Framework-aware rules:** Define rules based on your frameworks' routes rather than fiddling with regular expressions or prefixes

- **Managed rulesets:** Enterprise customers can enable managed rulesets designed to combat specific use cases, including prevention against the OWASP Top 10 risks

- **Observability:** Gain insights into key security metrics for streamlined security management, allowing you to monitor threats and connections being managed by your WAF and the platform-wide firewall in real-time, ensuring comprehensive protection and operational transparency

- **Rate limiting (beta):** Enforce frequency limitations on users attempting to access your application, ensuring even legitimate users access resources as you intend

- **Instant propagation:** Firewall changes are reflected globally within 300ms

- **Instant rollback:** Instantly revert to previous ruleset configurations to revert unintended rule creation


![You can add firewall rules directly inside the Vercel dashboard.](images/introducing-the-vercel-web-application-firewall-vercel/img_003.jpg)![You can add firewall rules directly inside the Vercel dashboard.](images/introducing-the-vercel-web-application-firewall-vercel/img_004.jpg)You can add firewall rules directly inside the Vercel dashboard.

## **Secure by default: The Vercel approach**

Security is a foundational pillar of everything we build at Vercel. Our commitment to security enables your team to focus on rapid iteration while remaining secure.

Our vision for Vercel security is that we empower a web that's secure by default. To achieve this vision, we're continuously investing in both new and existing security solutions. The introduction of the WAF represents an important moment in our journey towards leading security for the Frontend Cloud.

This can be achieved by leveraging Vercel's unique [framework-defined infrastructure (FdI)](https://vercel.com/blog/framework-defined-infrastructure) and inherent understanding of your application. Through FdI, the Vercel WAF is able to leverage a deep understanding of your application, which paves the way for intelligent decision-making based on the context and content of every edge request.

## **Security without compromise**

The Vercel WAF empowers you to build and deploy secure applications without sacrificing performance, ease of use, or search engine optimization (SEO).

[**Ready to experience next-level security?**\\
\\
Explore the Vercel WAF documentation and start securing your applications today.\\
\\
Learn more](https://vercel.com/docs/security/vercel-waf)