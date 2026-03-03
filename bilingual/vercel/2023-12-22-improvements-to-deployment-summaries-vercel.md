---
title: "Improvements to deployment summaries - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improvements-to-deployment-summaries"
date: "2023-12-22"
scraped_at: "2026-03-02T09:49:02.940638632+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Dec 22, 2023

2023年12月22日

![](images/improvements-to-deployment-summaries-vercel/img_001.jpg)![](images/improvements-to-deployment-summaries-vercel/img_002.jpg)

Deployment summaries help you understand how changes in your frontend application code lead to [managed infrastructure](https://vercel.com/products/managed-infrastructure) on Vercel. We've improved the output with the following:

部署摘要有助于您理解前端应用代码的变更如何在 Vercel 上生成[托管基础设施（managed infrastructure）](https://vercel.com/products/managed-infrastructure)。我们对摘要输出进行了如下优化：

- Static assets now display a leading `/` for output paths  
- 静态资源的输出路径现在统一以 `/` 开头  

- Files sizes are now vertically aligned for easier visual scanning  
- 文件大小现已垂直对齐，便于快速视觉扫描  

- [Next.js Metadata](https://nextjs.org/docs/app/building-your-application/optimizing/metadata) outputs are properly categorized under static assets  
- [Next.js 元数据（Metadata）](https://nextjs.org/docs/app/building-your-application/optimizing/metadata) 输出已正确归类至静态资源类别  

- [Partial Prerendering](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model) now displays the generated Vercel Functions  
- [部分预渲染（Partial Prerendering）](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model) 现在会显示所生成的 Vercel Functions  

[Read more in our documentation](https://vercel.com/docs/deployments/overview#deployment-summary) or learn more about [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure).

[详见我们的文档](https://vercel.com/docs/deployments/overview#deployment-summary)，或进一步了解 [框架定义的基础设施（framework-defined infrastructure）](https://vercel.com/blog/framework-defined-infrastructure)。