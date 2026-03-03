---
title: "Inside Praktika's conversational approach to language learning | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/praktika"
date: "2026-01-22"
scraped_at: "2026-03-02T10:08:27.823662566+00:00"
language: "en-US"
translated: false
description: "How Praktika uses GPT-4.1 and GPT-5.2 to build adaptive AI tutors that personalize lessons, track progress, and help learners achieve real-world language fluency"
tags: ["API"]
---

January 22, 2026

[API](https://openai.com/stories/api/) Startup

# Inside Praktika's conversational approach to language learning

Using GPT‑4.1 and GPT‑5.2, Praktika builds tutoring agents that adapt lessons based on learner behavior, progress, and conversation context.

![Praktika logo on purple background](images/inside-praktika_s-conversational-approach-to-language-learning-openai/img_001.png)



Praktika was born from a deeply personal insight: language unlocks opportunity.

Co-founders Adam Turaev, Anton Marin, and Ilya Chernyakov all grew up navigating new countries after their families immigrated in search of better opportunities. English quickly became essential, not just for school, but for work, mobility, and belonging.

“Learning English was never just about communication,” Turaev said. “It opened doors to international work and career growth.”

But traditional language education fell short. Despite years of study, the founders found that while they could read and write fluently, they struggled to speak confidently when it mattered most: at work, in meetings, and in daily life. The gap between classroom learning and real-world fluency was wider than they’d imagined.

[Praktika⁠(opens in a new window)](https://praktika.ai/) was built to close that gap. It’s a language learning app designed to help people build real-world fluency through daily conversations, with personalized AI tutors who guide them through interactive, goal-based lessons. Users include students preparing for exams, professionals working on job-related language skills, and immigrants building new lives in foreign countries.

## Building a multi-agent tutoring system that adapts and improvises

As the product matured, Praktika moved beyond a single-model architecture into a multi-agent system designed to mirror how real tutors adapt lessons in real time.

**Lesson Agent** is the primary conversation agent, interacting with learners as the tutor. Running on GPT‑5.2, it blends tutor personality, lesson context, learner goals, and recent conversations to deliver lessons that feel natural and unscripted. This is the point where the system starts to feel like a real tutor rather than a scripted experience.

Running continuously in the background, **Student Progress Agent** tracks the learner’s language performance across interactions. Using GPT‑5.2, this agent monitors fluency, accuracy, vocabulary usage, and recurring mistakes. This data forms a continuous feedback loop that informs both the Lesson Agent’s in-session behavior and the longer-term learning strategy, allowing the experience to evolve naturally over time.

**Learning Planning Agent** focuses on shaping the learner’s long-term progression. Grounded in the learner’s individual learning goal, it uses insights from the Student Progress Agent to determine what to learn next, how to sequence skills, and which activities will be most effective. Powered by GPT‑5 Pro, its role is to continuously adapt the learning plan so progress remains personalized, efficient, and aligned with the learner’s desired outcome.

![Diagram of a voice-based AI tutoring system. A user speaks into a speech interface, with audio processed either via push-to-talk or continuous speech using a Voice Activity Detection (VAD) model. Speech is converted to text by a speech-to-text model, producing a transcript that is stored in lesson conversation history. The lesson conversation feeds into a Lesson Agent (GPT-5.2), which interacts with memory and sends student progress data to a Student Progress Agent (GPT-5.2). Student skills are tracked and passed to a Learning Planning Agent (GPT-5.2 Pro), which uses methodologies to generate learning goals. The Lesson Agent also calls a Web AI Agent (GPT-4.1) when needed. The Lesson Agent produces response text that is converted to audio via text-to-speech and played back to the user, closing the loop.](images/inside-praktika_s-conversational-approach-to-language-learning-openai/img_002.png)

All agents share access to a persistent memory layer that stores learner goals, preferences, and past mistakes. Rather than preloading context, Praktika retrieves memory immediately after the learner speaks, ensuring responses are grounded in the most relevant, up-to-date signal.

“The system can switch to a completely different exercise if the learner isn’t feeling it,” says Turaev. “That brings the magic back. It starts to feel much closer to a real human tutor.”

## Making AI conversations feel like a live exchange

For conversational learning to feel natural, memory has to work the way it does in real life. Praktika’s memory layer retrieves relevant context only _after_ the learner finishes speaking. That allows the tutor to respond to what was just said, not what it anticipated.

“If a learner makes a mistake right now, the tutor responds to _that mistake_, not one from yesterday,” says co-founder and CEO Adam Turaev. “That timing difference is subtle, but it’s what makes the interaction feel attentive instead of robotic.”

00:00

Speech recognition plays a similar role. Language learners hesitate, restart sentences, and pronounce words imperfectly. Praktika uses Transcription API to handle fragmented, accented, and non-native speech more reliably than traditional systems trained on fluent speech. That lets learners focus on communicating without being penalized for their beginner status.

Together, memory timing and speech recognition form a single loop: listen carefully, recall the right context, and respond immediately.

## Turning model improvements into more effective learning experiences

Early versions of Praktika’s product paired expressive avatars with rule-based NLP and the first davinci models, but conversations still felt constrained. With the release of **GPT‑3.5**, the team experienced its first major breakthrough.

“For the first time, we could merge advanced language understanding with expressive, lifelike avatars,” says Adam Turaev. “The conversations stopped feeling scripted. They became natural, emotional, and real.”

As Praktika evaluated newer models, GPT‑4.1 proved to be the strongest fit across its internal evaluations measuring onboarding completion, Day-1 retention, trial-to-paid conversion, and qualitative user feedback.

“GPT‑4.1 gave us the best balance of reasoning depth, emotional nuance, and reliability,” says Turaev. “It supported multi-language conversation and complex tutoring logic at the quality we needed, significantly increasing conversation session quality.”

Those improvements translated directly into user and business results. After introducing their new long-term memory system, Praktika saw a 24% increase in Day-1 retention and doubled revenue in just a few months.

More recently, Praktika began using GPT‑5.2 models to power its architecture. GPT‑5.2 now powers the primary conversation agent, while GPT‑5.2 Pro handles supervisory reasoning and GPT‑5 mini supports continuous progress tracking. Together, these models allow the system to reason in parallel, balancing conversation quality, pedagogy, and efficiency at scale.

## Exploring new ways to learn a language

Today, Praktika supports millions of learners across nine languages, with more on the way. With its agentic foundation in place, Praktika is now focused on expanding what an AI tutor can understand, remember, and create alongside each learner.

“We’re not just teaching languages,” says Turaev. “We’re building AI that helps people feel confident using them in the real world.”