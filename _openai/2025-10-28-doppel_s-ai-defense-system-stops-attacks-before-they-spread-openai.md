---
title: "Doppel’s AI defense system stops attacks before they spread | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/doppel"
date: "2025-10-28"
scraped_at: "2026-03-02T10:09:26.633351768+00:00"
language: "en-US"
translated: false
description: "Discover how Doppel uses OpenAI’s GPT-5 and reinforcement fine-tuning (RFT) to stop deepfake and impersonation attacks before they spread, cutting analyst workloads by 80% and reducing threat respon..."
tags: ["API"]
---
{% raw %}

October 28, 2025


# Doppel’s AI defense system stops attacks before they spread

With GPT‑5 and reinforcement fine-tuning (RFT), Doppel cut analyst workloads by 80% and now mitigates threats in minutes instead of hours.

![Doppel logo in white centered on a textured dark metallic background with curved lines and rivets.](images/doppel_s-ai-defense-system-stops-attacks-before-they-spread-openai/img_001.jpg)



A single impersonation site can launch, target thousands of users, and vanish in under an hour. That’s more than enough time for an attacker to do real damage. And with generative tools, they can spin up hundreds more just like it.

[Doppel⁠(opens in a new window)](https://www.doppel.com/) was built to defend organizations from deepfakes and online impersonations, but quickly realized AI meant threats could scale infinitely. Attackers no longer needed to handcraft scams; they could generate endless variants of phishing kits, spoofed domains, and impersonation accounts in seconds.

> “Damage from phishing attacks can happen within minutes as they spread across social media and messaging channels. The ability to generate infinite persuasion at almost no cost changed everything.”

Rahul Madduluri, Co-founder and CTO, Doppel

To stay ahead, Doppel developed a new kind of social engineering defense system built on OpenAI GPT‑5 and o4-mini models. Doppel’s platform detects, classifies, and takes down threats autonomously, cutting analyst workloads by 80%, triples threat-handling capacity, and reduces response times from hours to minutes.

## Staying ahead of infinitely faster threats

Traditional digital risk protection relied on humans to manually review impersonation sites, phishing domains, and social media profiles and posts. Doppel saw that model breaking down as attackers began to automate, launching threats faster, and across more surface areas, than humans could evaluate them.

“Our system processes a constant flood of signals to identify the real threats amongst the noise. Once a threat is detected, there is a very narrow window to act before the damage is done,” said Rahul. “Using AI to automate decision-making is one of the greatest unlocks for the company, allowing us to combat attacks at internet scale and speed.”

That speed is critical for Doppel’s customers, organizations that can’t afford to wait hours to confirm a threat. Doppel’s system classifies most threats automatically, using OpenAI models for reasoning and a structured feedback loop known as reinforcement fine-tuning (RFT) to improve the model over time. In RFT, human feedback is used as graded examples, helping models learn to make consistent, explainable decisions on their own.

## Orchestrating LLM-driven threat detection

Doppel’s LLM-driven pipeline sits at the center of its detection stack. After signals are sourced and filtered, the system performs a series of targeted reasoning tasks: reasoning through potential threats, confirming intent, and driving classification decisions. Each stage is designed to balance speed, accuracy, and consistency, while keeping analysts focused on the edge cases that need human judgment.

![A flowchart shows a pipeline for threat detection using LLMs, moving from sourcing and filtering, through feature extraction and classification, to final verification and takedown systems. Models like GPT-5 and o4-mini are used at key stages.](images/doppel_s-ai-defense-system-stops-attacks-before-they-spread-openai/img_002.jpg)

Here’s how it works:

1. **Signal filtering and feature extraction:** Doppel’s systems ingest millions of domains, URLs, and accounts daily. A combination of heuristics and OpenAI o4-mini filters out noise and extracts structured features to guide downstream model evaluations.
2. **Parallel threat confirmation:** Each signal is passed through multiple GPT‑5 prompts purpose-built for different types of threat analysis. These prompts assess factors like impersonation risk, brand misuse, or social engineering patterns.
3. **Threat classification:** The RFT version of o4-mini synthesizes the earlier confirmations to assign a structured label—malicious, benign, or ambiguous—with production-grade consistency.
4. **Final verification:** A second GPT‑5 pass validates the model’s decision and generates a natural-language justification. If confidence exceeds threshold, the system auto-initiates enforcement.
5. **Human review:** Low-confidence or conflicting results are routed to human analysts. Their decisions are logged and fed back into the RFT loop to continuously improve model consistency.

## Training models through reinforcement fine-tuning (RFT)

Doppel had already seen meaningful gains from its original LLM-enhanced detection pipeline, but when it came to cases where the same threat might be judged differently depending on the analyst, consistency became the limiting factor.

“We were seeing differences in answers across edge cases,” said software engineer Kiran Arimilli. “One real benefit that came out of RFT is you’re making that model’s decisions more consistent.”

To build that consistency, Doppel applied RFT using its own analyst data as the feedback source. Each decision to classify a domain as malicious, benign, or unclear became a graded example. Those labeled examples trained the model to replicate expert judgment, even on ambiguous edge cases.

![A circular diagram shows the Doppel threat classification workflow: production LLMs make decisions → human reviewers provide corrections → model training updates models → deployment sends updated models to production.](images/doppel_s-ai-defense-system-stops-attacks-before-they-spread-openai/img_003.jpg)

Working closely with OpenAI’s applied engineering team, Doppel designed grader functions that evaluated not only accuracy but explanatory quality, rewarding models that reasoned clearly, not just correctly. By turning analyst feedback into structured training data, Doppel helped show how RFT could make automated detection more consistent and reliable.

## Operationalizing trust through transparency

Hyperparameter tuning and iterative evals brought the model closer to human-level consistency. But for Doppel, completing the final mile of automation also meant making decisions immediately understandable.

Each automated takedown now includes an AI-generated justification explaining why a threat was removed, giving customers immediate insight into why action was taken—something that once required analyst intervention.

![A dashboard view shows a takedown alert for the domain “d0ppel.click,” flagged for impersonating Doppel. The summary cites phishing and credential theft, with a timeline on the right showing status updates from creation to resolution on October 10, 2025.](images/doppel_s-ai-defense-system-stops-attacks-before-they-spread-openai/img_004.png)

That visibility enhances trust, which is a critical factor for Doppel’s users. Seeing not just what action was taken, but why, gives teams the confidence to respond quickly and the context to explain those decisions internally or to stakeholders.

## Expanding automation to new threat surfaces

Having reached near-complete automation for phishing and impersonation domains, Doppel is now applying the same model-driven framework to other high-variance channels.

“Domains are probably the hardest channel we handle,” said Madduluri. “The signals are messy, content changes constantly, and threats evolve fast across several surfaces at once. If we can automate that end to end, we can do it for anything: social media, paid ads, you name it.”

The next milestones include scaling their RFT dataset by an order of magnitude, experimenting with new grading strategies, and using GPT‑5 for upstream feature extraction. These changes will allow Doppel to consolidate pipeline stages and reason over more complex threat indicators earlier in the process.

With each iteration, Doppel is building toward a system that defends what’s real across every surface where trust is under attack.

## OpenAI <3 startups. Come build with us.

[Join the community](https://openai.com/leads/startup/) [Start building(opens in a new window)](https://platform.openai.com/)
{% endraw %}
