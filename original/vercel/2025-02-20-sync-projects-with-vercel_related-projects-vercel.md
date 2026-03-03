---
title: "Sync projects with @vercel/related-projects - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/sync-projects-with-vercel-related-projects"
date: "2025-02-20"
scraped_at: "2026-03-02T09:36:13.722066111+00:00"
language: "en"
translated: false
description: "Related projects allows automatically linking preview deployments across multiple projects in monorepos."
---




Feb 20, 2025

![](images/sync-projects-with-vercel_related-projects-vercel/img_001.jpg)![](images/sync-projects-with-vercel_related-projects-vercel/img_002.jpg)

The new [`@vercel/related-projects`](https://www.npmjs.com/package/@vercel/related-projects) package helps sync deployment information across separate Vercel projects, ensuring your applications always reference the latest preview or production deployment URLs without manual updates or environment variable changes.

Previously, developers had to manually enter deployment URLs, manage connection strings, or use environment variables to keep the projects communicating effectively. Now, this data is automatically available and updated at both build and runtime.

For example, a monorepo containing:

- A frontend Next.js project that fetches data from an API

- An backend Express.js API project that serves the data


Related Projects can now ensure that each preview deployment of the frontend automatically references the corresponding preview deployment of the backend, avoiding the need for hardcoded values when testing changes that span both projects.

Related Projects are linked using a Vercel project ID. You can [find your project ID](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%23project-id&title=Find+your+Vercel+project+ID) in the project **Settings** page in the Vercel dashboard.

```tsx
1- const host =  process.env.API_URL as string

2+ const host = withRelatedProject({

3+     projectName: "api-project",

4+     defaultHost: process.env.API_URL as string,

5+ });
```

Example of connecting a frontend project to a separate backend API.

Learn more about [linking related projects](https://vercel.com/docs/monorepos#how-to-link-projects-together-in-a-monorepo).