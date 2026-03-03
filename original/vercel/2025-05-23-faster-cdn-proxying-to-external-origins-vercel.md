---
title: "Faster CDN proxying to external origins - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-cdn-proxying-to-external-origins"
date: "2025-05-23"
scraped_at: "2026-03-02T09:33:07.151536076+00:00"
language: "en"
translated: false
description: "Vercel’s upgraded CDN connection pooling speeds up proxying to external backends by up to 60%, cutting latency for both low-traffic and high-traffic apps."
---




May 23, 2025

We’ve optimized connection pooling in our CDN to reduce latency when connecting to external backends, regardless of traffic volume.

- **Lower latency**: Improved connection reuse and TLS session resumption reduce response times by up to 60% in some regions, with a 15–30% average improvement.

- **Reduced origin load**: 97% connection reuse and more efficient TLS resumption significantly cut the number of new handshakes required.


This is now live across all Vercel deployments at no additional cost.