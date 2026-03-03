---
title: "Deploying dreams: An inside look at a summer internship with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/summer-internship-at-vercel"
date: "2024-09-13"
scraped_at: "2026-03-02T09:41:39.625251610+00:00"
language: "en"
translated: false
description: "What's an internship like at Vercel? Hear firsthand from one of Vercel's summer interns what the process was like, what they worked on, and what they learned."
---




Sep 13, 2024

Hello! I’m Aryan. I am currently a student at UC Berkeley, studying Electrical Engineering and Computer Science (EECS). This summer, I had the opportunity to be an intern at Vercel. It’s been an unforgettable experience. As my internship comes to a close and I head back to school, I want to share a behind-the-scenes look at what an internship at Vercel is like.

## How it all started

I started programming when I was in 8th grade. A major inflection point in my journey was competing in my first hackathon, Hack Cupertino 2018. This hackathon changed my mental model of the world. Instead of being a consumer of applications, I could become a creator. I could transform my ideas into code and publish it on the internet for others to use. Coding truly felt like a superpower.

Throughout high school, I continued cultivating my development skills by interning at a few startups and competing in more hackathons around the US.

In college, I joined a club called [Cal Hacks](https://hackberkeley.org/) my freshman year. Cal Hacks hosts the world’s largest collegiate hackathon, bringing together over 2000 students from around the world for a 48-hour challenge. I love the magic of building with the community. As a part of the Cal Hacks team, I help build our own open-source software to streamline running hackathons.

## Why Vercel?

I’ve been a customer of Vercel for years. Every hackathon or side project I created used Vercel and Next.js. The ease of use, incredible DX, and top-tier performance of both makes it easy to get started quickly. With tight competition timelines, I want as much time to focus on what I’m building, not infrastructure and configurations.

I’m inspired by Vercel’s culture of shipping fast, customer obsession, and sweating the details. Everything Vercel creates feels meticulously crafted, polished, and premium. I would see [shadcn](https://x.com/shadcn) and [John Phamous](https://x.com/JohnPhamous) sharing what they were working on, and I always wondered what it would be like to work at Vercel. I had to apply.

## Vercel’s intern interview process

The interview process at Vercel was different from most of my other interview experiences. Vercel’s interview mimics what it is like to work on the job. It tests your ability to _break down a problem_ and _reason aloud about possible solutions_. Using Google and asking clarifying questions are encouraged. I prefer this style of interview as opposed to a “leetcode” style interview because it practically evaluates real-world engineering skills. It feels real and authentic, and less like a trap.

All the hackathons and first-hand use of Vercel’s products paid off. I received an offer.

## What projects did I work on as an intern?

During my internship, I had the opportunity to work on multiple projects across a few different teams and codebases. Surprisingly, these were not small apps off in the corner. They were high-traffic, high-visibility apps customers use every day.

I led three major efforts over my 12 weeks as an intern.

### Support Center UX improvements

The [Vercel Support Center](https://vercel.com/docs/dashboard-features/support-center) is a secure and streamlined way for Vercel Pro and Enterprise customers to communicate with the Vercel Support team. You can submit new support cases and view the status of existing support cases.

The experience was functional, but it was lacking useful features. In collaboration with the Customer Success Engineers (CSEs), we identified ways we could improve the customer experience.

- Search support case subjects

- Filter cases by case status

- Sort cases by created, updated, and severity fields


This project gave me exposure to Vercel’s website monorepo powered by Turborepo, Next.js, Vercel’s internal design system ( [Geist](https://vercel.com/geist)), and Vercel’s API. Here’s the before and after results.

![Screenshot of Support Center before changes](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_001.jpg)![Screenshot of Support Center before changes](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_002.jpg)

Screenshot of Support Center before changes

![Screenshot of Support Center after changes](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_003.jpg)![Screenshot of Support Center after changes](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_004.jpg)

Screenshot of Support Center after changes

After revamping the Support Center page, I published a [changelog](https://vercel.com/changelog/improvements-to-support-center) announcing the improvements. I was also able to share these improvements with the rest of the company during Demo Day, a weekly meeting at Vercel where we get to show each other what we’ve been working on.

### The new v0

After Support Center, I transitioned to working on the next iteration of v0.

When [Vercel first announced v0](https://vercel.com/blog/announcing-v0-generative-ui), it was a generative user interface system powered by AI. It generates copy-and-paste friendly React code based on [shadcn/ui](https://ui.shadcn.com/) and [Tailwind CSS](https://tailwindcss.com/) that you can use in their projects.

When I joined, we were preparing to launch [v0’s new conversational UI](https://x.com/v0/status/1826020673908535325).

![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_005.jpg)![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_006.jpg)

In the new v0, I spearheaded the implementation of citations. This involved enhancing the Retrieval Augmented Generation (RAG) pipeline to source high-quality documentation and guides from Next.js, Vercel, Turborepo, Turbopack, AI SDK, and shadcn/ui. Additionally, I developed the frontend interface for displaying sources and inline citations. The team and I iterated on multiple versions of what the sources would look like. Below are some of the iterations we worked through before arriving at the final design.

**Iteration 1:** Initially, we wanted to display the sources as cards at the top of chat assistant’s response, so user’s would know which sources were referenced when generating the answer.

![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_007.jpg)![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_008.jpg)

**Iteration 2:** We felt Iteration 1 was too invasive and demanded too much of the user’s attention. We then tried a pill-like design forIteration 2. The more compact design took up less space and drew less attention. We also moved them below the chat assistant’s response instead of at the top.

![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_009.jpg)![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_010.jpg)

**Iteration 3:** The pills in Iteration 2 lacked key information about the source. We switched back to the cards, but redesigned them to be more compact and less distracting, while providing more information about the source. It was a balanced compromise.

![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_011.jpg)![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_012.jpg)

The introduction of citations enables v0’s answers to be grounded in facts, as the output uses numbered references (like a research paper) to justify its response.

After building citations, I began rolling out hundreds of beta invitations to the new v0. This included building out the onboarding experience to seamlessly introduce users to the new iteration.

![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_013.jpg)![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_014.jpg)

The new v0 has been a lot of fun to help build and use. You can create some [incredible experiences](https://x.com/evilrabbit_/status/1826385997376225643) with it. If you haven’t tried it yet, [you should](https://v0.dev/chat).

### Feeding the new v0 brain

One of the best parts of working at Vercel is access to some of the best and brightest minds in the industry. Everyone is such a wealth of insight and knowledge. Sadly, this knowledge can remain trapped within Vercel. I saw an opportunity to democratize this knowledge and share it with the community.

I set out to create v0 Brain—a way to seamlessly bring the best internal Vercel insights, recommendations, and UI design aesthetic directly from the creators of React, Next.js, shadcn/ui, Turbo, SWC, and more to further supplement v0’s knowledge. The workflow needed to be effortless. Vercel lives in Slack and we love emojis (we have over 8000 custom emojis). The v0 Brain workflow is based off a specific emoji reaction. Add the emoji reaction to any insightful message in Slack and it funnels the insight to the AI team to be evaluated and added to v0’s underlying AI model.

Again, I had the opportunity to present at Demo Day, where I shared how anyone in the company can contribute to v0’s knowledge base with ease in our day-to-day conversations with each other.

## What was it like working at Vercel?

I had direction, but I had full autonomy from day one. I had immense support from my manager and “welcome buddies” to quickly get onboarded and oriented. Working with a sense of urgency and iteration velocity are Vercel core values. I started merging pull requests and releasing to Production on my second day. I shipped over 80 pull requests during my internship. Working at Vercel is like the intensity of a hackathon, but with just the right amount of tools, safeguards, and processes in place to ensure quality.

I had the opportunity of working on several impactful projects during my internship, all of which directly contributed to the core product and made it into Production. I had full ownership of my projects end-to-end. In a lot of ways, I felt more like a full-time software engineer versus an intern on the team, which I really enjoyed.

The best part of the Vercel experience is the people. I met some of my design and engineering heroes. Like the creators of major OSS projects, such as [shadcn](https://x.com/shadcn) of shadcn/ui and [Paul Henschel](https://x.com/0xca0a) of zustand and react-three-fiber, and the famed leadership of Vercel. Learning firsthand from the greats was unforgettable. All of them are kind, welcoming, and encouraging.

I was motivated every day because I knew my work would impact Vercel’s millions of global users. Working at Vercel as an intern has truly been a dream come true.

## What did I learn during my internship?

I learned a tremendous amount during my internship that helped me become a better engineer and team player. Here’s some of my key learnings:

- **I learned how to work in engineering at scale**. Tools like TypeScript help keep vast codebases spanning multiple years and numerous programmers maintainable.

- **I learned how to communicate my ideas.** Through design documents and request for comments (RFCs), this helped me get get early feedback and buy-in from the team.

- **I exercised “design engineering” muscles.** Creating user interfaces that invoke feelings of delight and joy. Attention to detail is important, like this example of a [loading animation I created for v0](https://x.com/aryanvichare10/status/1820666125035642898).

- **I learned advanced LLM techniques.** Few-shot prompting, chain of thought (CoT) prompting with structured tagging, prompt chaining, and efficient parsing and chunking strategies were all new to me. I also learned how to add an observability and tracing layer on top of LLMs and build robust empirical evaluations (evals for short) to benchmark the performance of our models.


There is more to being an engineer than your technical skills. I meet with several people across the company for coffee chats, both within Engineering, but also Design, Customer Success, and Sales. These conversations helped uncover soft skills I’ll remember just as well:

- **Work in public.** Get in the habit of asking questions aloud and being proactive in posting blockers and updates. This fosters a culture of feedback and collaboration. I would post updates multiple times a day about what I’m working on and send recaps of the major things I did in that week so stakeholders were on the same page. This is especially important in remote working environments.

- **Communicate clearly and effectively.** Aim for simplicity in your writing and strip complexity. Value people’s time. By decluttering your writing, you can more effectively deliver your message in the clearest way possible. Writing effectively is also about knowing your target audience. Write with the reader in mind.

- **Pair program more.** Vercel has a strong pair-programming culture and I love it for two reasons: 1) I practice communicating a problem or task at hand with another engineer in real-time and 2) I get to learn how others think and solve problems. I find myself also picking up on productivity tips, which helps me become a more efficient developer.

- **Iterate to greatness (ITG).** ITG is one of my favorite Vercel values. The term encapsulates the idea of launching and shipping quickly without comprising quality. It’s not about achieving perfection on your first try, but instead, launching an initial version and rapidly iterating on it until it’s great.

- **Practice managing up.** Regularly update your manager and stakeholders on progress, blockers, and wins (big and small). I would proactively seek feedback weekly, so I’d be continually learning and growing. Make sure to align your work with team and company priorities, and be ready to articulate how your efforts contribute to broader company goals.


## What advice do you have for other interns and engineers?

Finding an internship or full-time job can be a grueling and intimidating. I have experienced this firsthand—spending several months applying to hundreds of companies, constantly preparing for technical leetcode-style interviews, and receiving numerous rejection letters. It’s tough. But when it finally lands, it's worth it. Keep going.

My advice? Build up your experience bank. The process of taking an idea from _zero to deployed_ will teach you what it’s like to think through the software delivery process. I picked up this experience by working on hackathon and side projects. Building real apps that solve your own problems or scratch your own curiosities cannot be understated. In hindsight, this is what helped me the most in getting an internship at Vercel. I was well versed in building and deploying apps with Vercel’s tech stack before I joined. It gave me immense confidence in applying and interviewing.

Spend time investing in yourself. Build that idea you’ve been sitting on. You never know where it’ll take you.