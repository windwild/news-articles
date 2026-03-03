---
title: "Sanity is now available on the Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/sanity-vercel-marketplace"
date: "2026-02-06"
scraped_at: "2026-03-02T09:21:34.999764987+00:00"
language: "en"
translated: false
description: "Sanity is now available as a content management system integration on the Vercel Marketplace. Install and configure directly from your Vercel dashboard."
---




Feb 6, 2026

[Sanity](https://vercel.com/marketplace/sanity) is now available on the [Vercel Marketplace](https://vercel.com/marketplace) as a native CMS integration. Teams can now install, configure, and manage Sanity directly from the Vercel dashboard, eliminating manual API token setup and environment variable configuration.

This integration keeps CMS setup inside your existing Vercel workflow instead of requiring a separate dashboard for provisioning and account management.

### Get started with the integration

Define your content schema, set up the client, and start fetching content. Schemas define your content structure in code, specifying document types and their fields.

src/sanity/schemaTypes/postType.ts

```typescript
import { defineField, defineType } from "sanity";



export const postType = defineType({

4  name: "post",

5  title: "Post",

6  type: "document",

7  fields: [\
\
8    defineField({ name: "title", type: "string" }),\
\
9    defineField({ name: "slug", type: "slug", options: { source: "title" } }),\
\
10    defineField({ name: "body", type: "array", of: [{ type: "block" }] }),\
\
11  ],

12});
```

Define a post document type with title, slug, and rich text body fields

Register your schema types in an index file so Sanity can load them.

src/sanity/schemaTypes/index.ts

```typescript
import { postType } from "./postType";



export const schemaTypes = [postType];
```

Export all schema types for Sanity Studio to use

The Sanity client connects your application to your content. The Marketplace integration provisions the project ID as an environment variable automatically.

src/sanity/lib/client.ts

```typescript
import { createClient } from "next-sanity";



export const client = createClient({

4  projectId: process.env.NEXT_PUBLIC_SANITY_PROJECT_ID,

5  dataset: "production",

6  apiVersion: "2024-01-01",

7  useCdn: false,

8});
```

Create a reusable client configured with your project's environment variables

With the client configured, you can fetch content using GROQ (Graph-Relational Object Queries), Sanity's query language for requesting exactly the fields you need.

src/app/page.tsx

```typescript
import { client } from "@/sanity/lib/client";



const POSTS_QUERY = `*[_type == "post"] | order(publishedAt desc)[0...12]{

4  _id, title, slug, publishedAt

5}`;



export default async function HomePage() {

8  const posts = await client.fetch(POSTS_QUERY);

9  return (

10    <ul>

11      {posts.map((post) => (

12        <li key={post._id}>{post.title}</li>

13      ))}

14    </ul>

15  );

16}
```

Fetch the 12 most recent posts and render them as a list

That's all you need to go from install to fetching content. [Install Sanity from the Vercel Marketplace](https://vercel.com/marketplace/sanity) to get started, or deploy the [Next.js + Sanity Personal Website](https://vercel.com/templates/template/sanity-next-js-personal-website) template to start from a working example.