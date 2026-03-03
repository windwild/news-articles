---
title: "How to prompt v0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-to-prompt-v0"
date: "2025-12-15"
scraped_at: "2026-03-02T09:24:06.325149124+00:00"
language: "en"
translated: false
description: "The best v0 prompts include three things. What you're building, who uses it and when, and your design constraints. This guide walks through the framework with side-by-side tests showing faster generat..."
---




Dec 15, 2025

Better prompts = better results, faster

Working with v0 is like working with a highly skilled teammate who can build anything you need. v0 is more than just a tool, it’s your building partner. And like with any great collaborator, the quality of what you get depends on how clearly you communicate.

The more specific you are, the better v0's output becomes. From our testing, good prompts consistently deliver:

- Faster generation time (30-40% faster with less unnecessary code, fewer credits spent)

- Smarter UX decisions (v0 understands intent and optimizes accordingly)

- Cleaner, more maintainable code


This guide shows you a framework that consistently produces these results.

## The framework: Three inputs that drive great prompts

After building hundreds of applications ourselves and learning from v0's power users, we’ve noticed that the best prompts always include three core inputs:

1. **Product surface**

2. **Context of use**

3. **Constraints & taste**


Here's the template:

```markdown
Build [product surface: components, data, actions].



Used by [who],

in [what moment],

to [what decision or outcome].



Constraints:

8- platform / device

9- visual tone

10- layout assumptions
```

Let's break down each input.

## Product surface

**What specifically are you building?**

List the actual components, features, and data. Not “a dashboard”, but what data it shows, what actions users can take, and what the key sections are.

**Example:**

```markdown
Dashboard displaying: top 5 performers with

names and revenue, team revenue vs quota

progress bar, deal pipeline with stages

4(Leads → Qualified → Demo → Closed),

56-month revenue trend chart.
```

When you’re specific about the product surface, v0 doesn’t waste time inventing features you don’t need or missing ones you do.

## Context of use

**Who’s using this, and in what moment?**

Be specific about your users and how they interact with the product in real life. Their role, technical comfort level, time constraints, and environment shape how v0 designs the UX.

Ask yourself:

- Who uses this?

- When do they use it?

- What decision are they trying to make?

- How much time do they have?


**Example:**

```markdown
Sales managers (non-technical) who check

this during morning standups on desktop

monitors to quickly spot underperformers and

celebrate wins with the team.
```

v0 optimizes for assumed usage. If you don’t define the context of use, it will guess.

## Constraints & taste

**How should it work and look**

Constraints tell v0 what not to invent.

Include:

- Style preferences

- Platform or device assumptions

- Layout expectations

- Color systems

- Responsiveness or accessibility needs


**Example:**

```markdown
Professional but approachable. Use card-based

layout with clear hierarchy. Color code: green for

on-track, yellow for at-risk, red for below target.

Desktop-first since they use large monitors. Make

it feel like a real SaaS product.
```

v0’s defaults are good. Specific constraints make them great while keeping code cleaner.

## Show the difference: Real test results

I tested this framework by building the same applications with different levels of context. Each test isolates one element to show its impact:

### Test 1: The impact of context of use

**Without context of use:**

```markdown
Build an e-commerce site with product grid, filters, and shopping features.
```

![](images/how-to-prompt-v0-vercel/img_001.jpg)![](images/how-to-prompt-v0-vercel/img_002.jpg)![](images/how-to-prompt-v0-vercel/img_003.jpg)![](images/how-to-prompt-v0-vercel/img_004.jpg)

**v0 chat:** [**https://v0.link/6vSzuSI**](https://v0.link/6vSzuSI)

**With context of use:**

```markdown
Fashion e-commerce site targeting millennials (25-35)

who browse on mobile during commutes. They compare

multiple items quickly before buying. Build a product page

with: swipeable image gallery, product title, price, description,

size/color selectors, add to cart button. Include minimal header

with back button and cart icon. Clean, premium aesthetic.
```

![](images/how-to-prompt-v0-vercel/img_005.jpg)![](images/how-to-prompt-v0-vercel/img_006.jpg)![](images/how-to-prompt-v0-vercel/img_007.jpg)![](images/how-to-prompt-v0-vercel/img_008.jpg)

**v0 chat:** [**https://v0.link/CcOTmsI**](https://v0.link/CcOTmsI)

**What changed:**

The version with context took 26 seconds longer but delivered a completely functional product. The version without context had:

- Non-functional search (placeholder only)

- Non-functional cart

- NOT responsive


The version with context had:

- Fully functional search and cart with quantity controls

- 100% mobile responsive

- Sophisticated mobile-first design

- Quick view modals and category filters


**The real cost:**

Without context would have required 1-2 more prompts to add the missing functionality, totaling ~5 minutes and ~1.5 credits. Better context saved multiple iterations.

### Test 2: The impact of product surface

**Vague product surface:**

```markdown
Build a user profile page.
```

![](images/how-to-prompt-v0-vercel/img_009.jpg)![](images/how-to-prompt-v0-vercel/img_010.jpg)![](images/how-to-prompt-v0-vercel/img_011.jpg)![](images/how-to-prompt-v0-vercel/img_012.jpg)

**v0 chat:** [**https://v0.link/1Gev1Gi**](https://v0.link/1Gev1Gi)

**Specific product surface:**

```markdown
Build a user profile page showing: profile photo,

display name, username, email, bio, member since

date, activity stats (posts, comments, followers),

recent activity feed with timestamps, edit profile

and settings buttons.
```

![](images/how-to-prompt-v0-vercel/img_013.jpg)![](images/how-to-prompt-v0-vercel/img_014.jpg)![](images/how-to-prompt-v0-vercel/img_015.jpg)![](images/how-to-prompt-v0-vercel/img_016.jpg)

**v0 chat:** [**https://v0.link/690wE6f**](https://v0.link/690wE6f)

**Results:**

- Vague: **1m 38s**, 595 lines, 0.173 credits

- Specific: **1m 19s**, 443 lines, 0.160 credits


**19 seconds faster, 152 fewer lines, lower cost.**

The vague prompt forced v0 to guess. The specific prompt generated exactly what we needed: all requested fields properly structured, activity stats prominent, correct information architecture.

When the product surface is explicit, v0 doesn’t waste time inventing features you don’t need or missing ones you do.

### Test 3: The impact of constraints & taste

**Basic constraints:**

```markdown
Build a support ticket dashboard. Shows: open

tickets, response time, agent performance,

recent activity.
```

![](images/how-to-prompt-v0-vercel/img_017.jpg)![](images/how-to-prompt-v0-vercel/img_018.jpg)![](images/how-to-prompt-v0-vercel/img_019.jpg)![](images/how-to-prompt-v0-vercel/img_020.jpg)

**v0 chat:** [**https://v0.link/jrNW2FX**](https://v0.link/jrNW2FX)

**Detailed constraints:**

```markdown
Build a support ticket dashboard. Shows: open tickets,

response time, agent performance, recent activity.



Mobile-first design (team leads check this on phones

while on the floor).

Light theme, high contrast. Color code: red for urgent

7(>24h), yellow for medium, green for on-time. Maximum

83-column layout. Include loading states for real-time data.
```

![](images/how-to-prompt-v0-vercel/img_021.jpg)![](images/how-to-prompt-v0-vercel/img_022.jpg)![](images/how-to-prompt-v0-vercel/img_023.jpg)![](images/how-to-prompt-v0-vercel/img_024.jpg)

**v0 chat:** [**https://v0.link/ZtsFTeb**](https://v0.link/ZtsFTeb)

**Results:**

- Basic: **1m 42s**, 679 lines, 0.133 credits

- Detailed: **1m 52s**, 569 lines, 0.130 credits


**Took 10 seconds longer but generated 110 fewer lines and cost less.**

The difference: basic version "works on mobile" (desktop layout that shrinks). Detailed version is "mobile-first" (designed from the ground up for mobile, single column expanding to 3 max, intentional color coding with red/yellow/green urgency levels, agent status badges, high contrast for outdoor visibility).

v0's defaults are good. Specific constraints make them great while keeping code cleaner.

## Iterating on your generations

Once v0 generates your app, you have two main ways to iterate:

**Prompt for changes:** Describe what you want to change, add, or remove. Best for functional changes, adding features, or restructuring layouts.

**Design Mode:** Click Design Mode, select any element visually, and adjust properties directly. Faster for quick visual changes like colors, spacing, or typography.

Use prompts for logic and structure. Use Design Mode for visual tweaks.

## Quick reference: Prompt template

Here's the template again, this time with a fully expanded example:

**Template:**

```markdown
Build [product surface: components, data, actions].



Used by [who],

in [what moment],

to [what decision or outcome].



Constraints:

8- platform / device

9- visual tone

10- layout assumptions
```

**Example:**

```markdown
Build a support dashboard showing: open tickets count,

average response time, tickets by priority (high/medium/low),

agent performance list with current workload, recent ticket activity feed.



Used by support team leads (managing 5–10 agents),

on their phones while walking the floor,

to prevent agent burnout and maintain response-time SLAs.

Checked every 30 minutes to identify overloaded agents

and redistribute work.



Constraints:

Mobile-first, light theme, high contrast.

Color code by priority: red for urgent, yellow for medium, green for low.

Show agent status badges (busy/available).

Maximum 2 columns on mobile.


```

[**Ready to build?**\\
\\
Try it yourself.\\
Next time you use v0, try being more specific. Add context about who's using your creation. Explain why it needs to exist. Describe how it should work.\\
\\
Start building](https://v0.dev/)

### Want to go deeper?

- [v0 Documentation](https://v0.dev/docs) \- Complete guide to all features

- [Design Systems Guide](https://v0.app/docs/design-systems) \- Learn how to create and use design systems

- [Project Instructions](https://v0.app/docs/instructions) \- Set up rules that apply to all generations

- [v0 Templates](https://v0.dev/templates) \- Pre-built starting points for common use cases

- [Community Platform](https://community.vercel.com/c/v0/59) \- Ask for help, share prompt ideas, and chat about AI projects with the community