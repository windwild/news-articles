---
render_with_liquid: false
title: "Announcing SvelteKit Auth: Bringing NextAuth.js to all frameworks - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/announcing-sveltekit-auth"
date: "2022-12-14"
scraped_at: "2026-03-02T09:57:40.326976834+00:00"
language: "en-zh"
translated: true
description: "SvelteKit Auth is a simple, low configuration authentication library for SvelteKit applications, with support for many popular OAuth providers."
---
render_with_liquid: false
render_with_liquid: false

Dec 14, 2022

2022 年 12 月 14 日

[NextAuth.js](https://next-auth.js.org/)，目前最流行的 Next.js 应用认证库，每周 npm 下载量近 30 万次，现正扩展支持整个前端框架生态。

今天，我们非常高兴地宣布推出 **SvelteKit Auth**（实验性版本）——这是首个在 Next.js 之外、获得官方正式支持的框架认证方案，构建于全新解耦的 `@auth/core` 库之上。这一新包标志着项目整体向 **Auth.js** 迈进的重要一步：为 Web 提供跨框架的通用身份认证能力，支持您钟爱的任意前端框架。

立即使用我们的全新 [SvelteKit 认证模板](https://vercel.com/templates/svelte/sveltekit-authentication) 开始体验。

## 为何选择 SvelteKit？

Auth.js 开源团队最初聚焦于为 Next.js 构建简洁易用的认证解决方案，并由此诞生了 NextAuth.js。但与此同时，我们也非常喜爱 SvelteKit 框架。值此 SvelteKit 1.0 正式发布之际，我们认为现在正是分享我们近期成果的最佳时机。

SvelteKit（面向 Svelte）在设计理念上与 Next.js（面向 React）高度相似：它同样提供一套约定优先（opinionated）的框架，用于高效构建 Svelte 应用。正因如此，我们认为它非常适合成为一款配置极简、开箱即用的身份认证库的理想载体，天然支持 Google、Facebook、GitHub 等众多主流 OAuth 平台。

## 在 SvelteKit 1.0 中使用 SvelteKit Auth

安装 `@auth/sveltekit` 和 `@auth/core` 后，我们首先需要定义应用将要启用的 OAuth 认证提供商。以 GitHub 为例：

src/hooks.server.ts

```jsx
import SvelteKitAuth from "@auth/sveltekit"

import GitHub from '@auth/core/providers/github';

import { GITHUB_ID, GITHUB_SECRET } from "$env/static/private"



export const handle = SvelteKitAuth({

6  providers: [\
\
7    GitHub({ clientId: GITHUB_ID, clientSecret: GITHUB_SECRET }),\
\
8  ]

9});
```

配置 SvelteKit Auth 以使用 GitHub OAuth 提供程序。

我们可以读取环境变量，从而安全地配置 GitHub OAuth 提供程序。接下来，即可允许用户登录。

SvelteKit Auth 提供了便捷的方法（如 `signIn` 和 `signOut`），可在用户执行相关操作时调用。在以下示例中，我们在主首页路由（index route）中检查用户是否已通过身份验证。若存在会话数据（session data），我们便可显示用户的头像和姓名；否则，可显示“登录”按钮。

```html
1<script>

1<script>

2	import { signIn, signOut } from '@auth/sveltekit/client';

2	导入 { signIn, signOut } 来自 '@auth/sveltekit/client';

3	import { page } from '$app/stores';

3	导入 { page } 来自 '$app/stores';

4</script>

4</script>



6<p>

6<p>

7	{#if Object.keys($page.data.session || {}).length}

7	{#if Object.keys($page.data.session || {}).length}

8		{#if $page.data.session.user.image}

8		{#if $page.data.session.user.image}

9			<span style="background-image: url('{$page.data.session.user.image}')" class="avatar" />

9			<span style="background-image: url('{$page.data.session.user.image}')" class="avatar" />

10		{/if}
10		{/if}
```

11		<span class="signedInText">

11		<span class="signedInText">

12			<small>Signed in as</small><br />

12			<small>当前登录用户为</small><br />

13			<strong>{$page.data.session.user.email || $page.data.session.user.name}</strong>

13			<strong>{$page.data.session.user.email || $page.data.session.user.name}</strong>

14		</span>

14		</span>

15		<button on:click={() => signOut()} class="button">Sign out</button>

15		<button on:click={() => signOut()} class="button">退出登录</button>

16	{:else}

16	{:else}

17		<span class="notSignedInText">You are not signed in</span>

17		<span class="notSignedInText">您尚未登录</span>

18		<button on:click={() => signIn('github')}>Sign In with GitHub</button>

18		<button on:click={() => signIn('github')}>使用 GitHub 登录</button>

19	{/if}

19	{/if}

20</p>

20</p>

使用 SvelteKit Auth 实现页面上的用户登录与登出功能。

我们也可以将此逻辑放入某个路由组共用的布局（shared layout）中，如果这样更符合我们的偏好。最后，我们还可以轻松保护那些不希望未认证用户访问的路由。

```javascript
import { redirect } from "@sveltejs/kit"

import type { PageLoad } from "./$types"



export const load: PageLoad = async ({ parent }) => {

5  const { session } = await parent()

6  if (!session?.user) {

7    throw redirect(302, "/")

8  }
```

```
9  return {}

10}
```

```
9  返回 {}

10}
```

Protecting a route with SvelteKit auth.

使用 SvelteKit Auth 保护路由。

## Get started with SvelteKit Auth

## 开始使用 SvelteKit Auth

While SvelteKit Auth is still experimental, we’re excited about furthering the stability of the package and expanding Auth.js into other frontend frameworks besides Next.js.

尽管 SvelteKit Auth 目前仍处于实验阶段，但我们非常期待进一步提升该包的稳定性，并将 Auth.js 扩展至 Next.js 以外的其他前端框架。

We’d love to hear your feedback about which frameworks you’d like to see support for next. You can follow along with our progress on Twitter, or explore the new SvelteKit Auth package on GitHub. We’re actively working on new documentation as well.

我们非常期待听到您对后续希望支持哪些框架的反馈。您可关注我们的 Twitter 动态，或在 GitHub 上探索全新的 SvelteKit Auth 包。同时，我们也在积极编写新的文档。

Install `@auth/sveltekit` today and get started with our new [SvelteKit Auth Template](https://vercel.com/templates/svelte/sveltekit-authentication).

立即安装 `@auth/sveltekit`，并使用我们的全新 [SvelteKit Auth 模板](https://vercel.com/templates/svelte/sveltekit-authentication) 快速上手。

We’re incredibly thankful for the over 450 community contributors to NextAuth.js, including the core team of myself, Thang Vu, Nico Domino, Lluis Agusti, and Robert Soriano. We’d also like to thank Prisma, Clerk, Lowdefy, WorkOS, Checkly, Superblog, and others sponsoring NextAuth.js on OpenCollective. Finally, we’d like to thank the original creator of NextAuth.js, Ian Collins, for their work creating the base for all this innovation and Filip Skokan ( [@panva](https://twitter.com/_panva)) for their outstanding work on open-source libraries.

我们由衷感谢为 NextAuth.js 贡献力量的 450 多位社区贡献者，其中包括核心团队成员：我本人、Thang Vu、Nico Domino、Lluis Agusti 和 Robert Soriano。我们还要感谢 Prisma、Clerk、Lowdefy、WorkOS、Checkly、Superblog 等机构通过 OpenCollective 对 NextAuth.js 的赞助支持。最后，我们要特别感谢 NextAuth.js 的最初创建者 Ian Collins —— 正是他的开创性工作，为所有这些创新奠定了坚实基础；同时也要感谢 Filip Skokan（[@panva](https://twitter.com/_panva)）在开源库领域所做出的卓越贡献。