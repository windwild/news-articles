---
render_with_liquid: false
title: "Sanity is now available on the Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/sanity-vercel-marketplace"
date: "2026-02-06"
scraped_at: "2026-03-02T09:21:34.999764987+00:00"
language: "en-zh"
translated: true
description: "Sanity is now available as a content management system integration on the Vercel Marketplace. Install and configure directly from your Vercel dashboard."
---
render_with_liquid: false
render_with_liquid: false

Feb 6, 2026

2026年2月6日

[Sanity](https://vercel.com/marketplace/sanity) 现已作为原生 CMS 集成上线 [Vercel Marketplace](https://vercel.com/marketplace)。团队现在可直接通过 Vercel 控制台安装、配置和管理 Sanity，无需再手动设置 API Token 或配置环境变量。

该集成将 CMS 的配置工作保留在您现有的 Vercel 工作流内，无需额外使用独立的控制台来完成资源开通与账号管理。

### 使用该集成快速入门

定义您的内容 Schema，配置客户端，并开始获取内容。Schema 以代码形式定义内容结构，明确文档类型及其字段。

src/sanity/schemaTypes/postType.ts

```typescript
import { defineField, defineType } from "sanity";

export const postType = defineType({

4  name: "post",

5  title: "Post",

5  标题："Post"，

6  type: "document",

6  类型："document"，

7  fields: [\
\
8    defineField({ name: "title", type: "string" }),\
\
9    defineField({ name: "slug", type: "slug", options: { source: "title" } }),\
\
10    defineField({ name: "body", type: "array", of: [{ type: "block" }] }),\
\
11  ],

7  字段：[\
\
8    defineField({ name: "title", type: "string" }),\
\
9    defineField({ name: "slug", type: "slug", options: { source: "title" } }),\
\
10    defineField({ name: "body", type: "array", of: [{ type: "block" }] }),\
\
11  ]，

12});

12}）；

Define a post document type with title, slug, and rich text body fields

定义一个包含标题（title）、URL别名（slug）和富文本正文（body）字段的 post 文档类型。

Register your schema types in an index file so Sanity can load them.

在索引文件中注册您的 Schema 类型，以便 Sanity 能够加载它们。

src/sanity/schemaTypes/index.ts

src/sanity/schemaTypes/index.ts

```typescript
import { postType } from "./postType";



export const schemaTypes = [postType];
```

```typescript
import { postType } from "./postType";



export const schemaTypes = [postType];
```

Export all schema types for Sanity Studio to use

为 Sanity Studio 导出所有 Schema 类型

The Sanity client connects your application to your content. The Marketplace integration provisions the project ID as an environment variable automatically.

Sanity 客户端将您的应用程序连接到您的内容。Marketplace 集成会自动将项目 ID 作为环境变量提供。

src/sanity/lib/client.ts

src/sanity/lib/client.ts

```typescript
import { createClient } from "next-sanity";



export const client = createClient({

4  projectId: process.env.NEXT_PUBLIC_SANITY_PROJECT_ID,

5  dataset: "production",

6  apiVersion: "2024-01-01",

7  useCdn: false,
```

8});
```

创建一个可复用的客户端，并使用您项目的环境变量进行配置

客户端配置完成后，您即可使用 GROQ（Graph-Relational Object Queries，图关系对象查询）来获取内容——这是 Sanity 专为精准请求所需字段而设计的查询语言。

src/app/page.tsx

```typescript
import { client } from "@/sanity/lib/client";



const POSTS_QUERY = `*[_type == "post"] | order(publishedAt desc)[0...12]{

4  _id, title, slug, publishedAt

5}`;

```typescript
export default async function HomePage() {

export default async function HomePage() {

8  const posts = await client.fetch(POSTS_QUERY);

8  const posts = await client.fetch(POSTS_QUERY);

9  return (

9  return (

10    <ul>

10    <ul>

11      {posts.map((post) => (

11      {posts.map((post) => (

12        <li key={post._id}>{post.title}</li>

12        <li key={post._id}>{post.title}</li>

13      ))}

13      ))}

14    </ul>

14    </ul>

15  );

15  );

16}
```
```

Fetch the 12 most recent posts and render them as a list

获取最近的 12 篇文章，并将它们渲染为一个列表。

That's all you need to go from install to fetching content. [Install Sanity from the Vercel Marketplace](https://vercel.com/marketplace/sanity) to get started, or deploy the [Next.js + Sanity Personal Website](https://vercel.com/templates/template/sanity-next-js-personal-website) template to start from a working example.

从安装到获取内容，您只需完成以上步骤。点击此处 [从 Vercel 应用市场安装 Sanity](https://vercel.com/marketplace/sanity) 即可开始；或者部署 [Next.js + Sanity 个人网站](https://vercel.com/templates/template/sanity-next-js-personal-website) 模板，直接基于一个可运行的示例项目启动开发。