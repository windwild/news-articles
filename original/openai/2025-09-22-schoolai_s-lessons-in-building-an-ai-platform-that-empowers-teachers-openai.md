---
title: "SchoolAI’s lessons in building an AI platform that empowers teachers | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/schoolai"
date: "2025-09-22"
scraped_at: "2026-03-02T10:10:15.380811254+00:00"
language: "en-US"
translated: false
description: "Discover how SchoolAI, built on OpenAI’s GPT-4.1, image generation, and TTS, powers safe, teacher-guided AI tools for 1 million classrooms worldwide—boosting engagement, oversight, and personalize..."
tags: ["API"]
---

September 22, 2025


# SchoolAI’s lessons in building an AI platform that empowers teachers

With GPT‑4.1, image generation, and text-to-speech, SchoolAI creates safe, observable AI infrastructure for 1 million classrooms—and growing.

![The word “schoolai” in white lowercase text centered on a colorful textured background with yellow, orange, pink, and peach watercolor gradients.](images/schoolai_s-lessons-in-building-an-ai-platform-that-empowers-teachers-openai/img_001.png)



In 2013, Caleb Hicks, now founder and CEO of SchoolAI, taught nearly 300 students a day. He knew the top and bottom 20 percent well, but the middle 80 percent often slipped by unseen. That blind spot nagged at him. Between growing class sizes and shrinking budgets, teachers like him simply couldn’t keep up with student needs.

With the launch of ChatGPT in 2022, AI began to enter the classroom. While some educators debated banning AI tools altogether due to concerns about cheating and safety, Hicks saw a different path. Drawing on his instructional design background at Apple, Hicks believed that with the careful design and oversight, AI could help students learn in a more personalized way and give teachers the tools and insights to help them teach better.

In 2023, he launched [SchoolAI⁠(opens in a new window)](https://schoolai.com/). The platform gives teachers real-time signals on student progress and provides students with personalized support.

In just two years, SchoolAI has reached 1 million classrooms across 80+ countries, embedded in over 500 education partnerships. Built on OpenAI models, it translates cutting-edge tech into classroom-ready tools.

> “We’ve done a lot of work to make AI not do things for you. If AI just gives the student the answer, we’ve failed—the point of teaching is to coach and to keep them engaged in the work.”

Nate Sanders, Chief Experience Officer, SchoolAI

## Lesson 1: Building trust with teacher-in-the-loop

SchoolAI’s agent architecture resembles a typical classroom: Spaces are interactive learning environments that teachers create through Dot, a conversational assistant.

If a teacher types ‘create a differentiated reading activity for students at three different levels,’ Dot will assemble a ready-to-use lesson in seconds. Teachers can also add interactive apps for students to create, play, and learn based on the lesson goal.

Students engage with these lessons through Sidekick, an AI tutor built on GPT‑4o and GPT‑4.1. Sidekick adapts to how students learn, offering guidance, pacing, and encouragement based on their responses.

While students work, teachers stay in the loop. Every SchoolAI interaction is observable, giving teachers proactive insight into what students need before small gaps become bigger ones. Built-in guardrails help SchoolAI use remain safe, transparent, and aligned with classroom goals.

One student, newly arrived in the U.S. only speaking Dari, used Sidekick for real-time translation. Within weeks, he was participating in group work, building friendships, and showing up with a new sense of belonging. That kind of early, confident engagement lays the foundation for long-term success.

## Lesson 2: Matching models to real-world tasks

The real question for teachers isn’t AI’s capability, but how it can be used to improve the learning process, not just give answers.

“If AI just gives the student the answer, we’ve failed,” says Hicks. “The point of teaching is to coach and to keep them engaged in the work.”

From day one, SchoolAI built educator oversight into the architecture. Instead of a single prompt-and-response loop, every student input runs through an agent graph with dozens of specialized nodes that call models, tools, or guardrails before returning an answer so students receive structured support that reinforces real learning.

Every part of this workflow is powered by OpenAI:

- **GPT‑4o** drives Dot’s conversational interface and the real-time logic behind lesson construction and response generation
- **GPT‑4.1** supports deeper reasoning tasks, like scaffolding multi-step math problems
- **Image generation** creates custom visuals, like photosynthesis diagrams or historical maps, to support lessons
- **Text-to-speech (TTS)** provides spoken feedback in over 60 languages

That orchestration depends on smart routing: heavy reasoning tasks go to GPT‑4.1 or GPT‑4o, while lightweight checks run on smaller models such as GPT‑4o‑mini or other nano class models. This helps keep costs predictable without compromising accuracy where it matters most.

Accuracy and nuance matter more in schools than almost anywhere else. Decisions a model makes are observable in logs, surfaced to teachers in real time, and rolled up to administrators through a consolidated report. These feedback loops help enforce SchoolAI’s core philosophy: AI should coach students, not hand them the answer.

## Lesson 3: Sticking with one stack to move faster at scale

When SchoolAI hosted its most recent product showcase, it drew over 10,000 educators. But in the days leading up, the team noticed they were still stuck on consumer-level limits.

“We reached out to our OpenAI contact, to see what we could do,” said Sanders, Chief Experience Officer at SchoolAI. “Within ten minutes, they not only upgraded our usage tier but also saw we were leaning in on GPT‑4.1 so proactively increased our limits so that we would have a smooth event.”

As model releases continued to decrease in inference prices, SchoolAI was able to bring costs down from nearly a dollar per student Space to just a fraction of that. The shift gave the team the margin to invest for the long term and expand strategically—critical in education, where budgets depend on efficiency to meet growing needs.

“We chose OpenAI because their models offered unmatched accuracy, nuance, and flexibility,” Hicks says. “We chose to scale with them because the support we’ve received is unmatched.”

## Shaping the next era of education

For educators, AI can be a powerful ally, helping free up more time for the truly human work of teaching. The SchoolAI team has heard from teachers who report saving 10+ hours a week with the platform. But the bigger shift is how they use that time: stepping in earlier, offering faster support, and spending more meaningful moments one-on-one with students.

One teacher shared that she used to rely on test scores to catch students slipping. But SchoolAI surfaced a student who had stopped asking questions and engaging in discussions. That small signal led to a check-in and an early intervention that would have otherwise been missed.

Student behavior is changing, too: engagement is rising in AI-supported lessons, and Sidekick is helping students build confidence and independence. That same Dari-speaking student who relied on real-time translation is now participating in group work, joking with classmates, and finding a new sense of confidence.

As adoption spreads from pilot campuses to full districts, school leaders are using real-time instructional data to understand what’s working and where to invest support. And with new capabilities designed to support learning at home, SchoolAI is extending its reach beyond the classroom, connecting students, teachers, and families through one trusted system.

“Our mission has always been about helping every student feel seen,” says Hicks. “With OpenAI, we’re able to deliver on that promise consistently, at the system level schools need.”

## OpenAI <3 startups. Come build with us.

[Join the community](https://openai.com/leads/startup/) [Start building(opens in a new window)](https://platform.openai.com/)