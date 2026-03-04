---
title: " A Primer on the EU AI Act: What It Means for AI Providers and Deployers  | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/global-affairs/a-primer-on-the-eu-ai-act"
date: "2024-07-30"
scraped_at: "2026-03-02T10:18:18.417775863+00:00"
language: "en-US"
translated: false
description: "We’re sharing a preliminary overview of the EU AI Act including upcoming deadlines and requirements, with a particular focus on prohibited and high-risk use cases"
tags: ["Global Affairs"]
---
&#123;% raw %}

Published: July 30, 2024

[Company](https://openai.com/news/company-announcements/) [Global Affairs](https://openai.com/news/global-affairs/)

# A Primer on the EU AI Act

We’re sharing a preliminary overview of the EU AI Act including upcoming deadlines and requirements, with a particular focus on prohibited and high-risk use cases


**_Update from July 11, 2025_** _: Following the publication of the final text of the Code of Practice for General Purpose AI, we’re sharing an overview of how we are approaching the entry into force of provisions applicable to General Purpose AI Models on August 2, 2025._

_Last year, we published this primer on the EU AI Act to lay out preliminary insight into how we were preparing for the implementation of these new legal requirements._

_Since then we’ve been actively involved in the implementation of the text by taking part in the elaboration of the Code of Practice for General Purpose AI, a framework for AI providers to comply with the EU AI Act. After months of collective efforts alongside experts, civil society and industry, a final Code has been published. Today, we are announcing our decision to sign the Code of Practice and use it to demonstrate compliance with our relevant obligations under the EU AI Act._

_By signing the Code we are taking a concrete step in our broader compliance plan with the EU AI Act. It reflects our commitment to ensuring continuity, reliability, and trust as regulations take effect, while continuing to partner with European businesses and citizens, bringing them increasingly capable, safe, and secure AI models to reap the benefits of the AI revolution._

_Signing the Code reinforces many of the industry-leading safety and transparency measures we have pioneered over the past several years. We were one of the first companies to publish a comprehensive safety and security protocol, our Preparedness Framework (2023), which outlines our approach to deploying frontier AI models safely._

_In keeping with our commitment to continuously review and improve internal accountability and governance frameworks, we_ [_published_ ⁠](https://openai.com/index/updating-our-preparedness-framework/) _an updated Preparedness Framework in April 2025._

_As we continue to develop and deploy increasingly capable technology, we actively monitor and mitigate a broad range of novel risks and real-world safety concerns to keep our models reliable and secure. And we are constantly refining and improving these processes._

- _We have long published detailed System Cards and technical documentation with our major releases that lay out what our models can and can’t do, what risks we’ve tested for, and where we’re still learning._
- _The Safety Hub provides public access to safety evaluation results for our models._
- _Our Red Teaming Network brings in external experts to pressure-test our models_
- _The Model Spec offers a window into how we shape model behaviour to reflect human values and democratic norms._

_Together, this work has been instrumental for setting security and safety standards in the industry and informing the development of a workable Code of Practice based on industry best practices. Building safe and responsible AI is never finished. We will continue to iteratively improve our approach to safety to help ensure that our technology is used to benefit everyone responsibly, wherever they are in the world._

_We will work closely with the EU AI Office, relevant authorities and our customers as the AI Act is implemented in the coming months and years, so we can collectively secure the benefits of AI for Europe’s society and economy._

* * *

_Update: On September 25, 2024, we signed up to the three core commitments in the EU AI Pact._

1. _Adopt an AI governance strategy to foster the uptake of AI in the organization and work towards future compliance with the AI Act;_
2. _carry out to the extent feasible a mapping of AI systems provided or deployed in areas that would be considered high-risk under the AI Act;_
3. _promote awareness and AI literacy of their staff and other persons dealing with AI systems on their behalf, taking into account their technical knowledge, experience, education and training and the context the AI systems are to be used in, and considering the persons or groups of persons affected by the use of the AI systems._

_We believe the AI Pact’s core focus on AI literacy, adoption, and governance targets the right priorities to ensure the gains of AI are broadly distributed. Furthermore, they are aligned with our mission to provide safe, cutting-edge technologies that benefit everyone._

* * *

The [EU AI Act⁠(opens in a new window)](https://artificialintelligenceact.eu/) is a significant regulatory framework designed to manage the development, deployment, and use of AI across Europe. It has a substantial focus on safety to promote trustworthy AI adoption in Europe while protecting health, safety, and fundamental rights. It introduces new requirements based on the risks associated with AI systems, with a particular focus on high-risk and unacceptable-use cases, as well as special obligations for general purpose AI (GPAI) models and systems.

While the legislative process is complete and the law will enter into force in August 2024, further guidance and implementing legislation will be required to define the scope of the law, especially as it applies to GPAI models like OpenAI’s.

At OpenAI, we are committed to complying with the Act, not only because this is a legal obligation, but also because the goal of the law aligns with our mission to develop and deploy safe AI to benefit all of humanity. We are proud to release models that are industry leading on both capabilities and safety. We believe in a balanced, scientific approach where [safety measures⁠](https://openai.com/index/openai-safety-update/) are integrated into the development process from the outset. Our teams span a wide spectrum of technical efforts tackling AI safety challenges including, evaluations of models under our [Preparedness Framework⁠](https://openai.com/preparedness/) prior to their deployment, internal and external [red-teaming⁠](https://openai.com/index/red-teaming-network/), post-deployment [monitoring⁠](https://openai.com/index/disrupting-malicious-uses-of-ai-by-state-affiliated-threat-actors/) for abuse, [Bug Bounty⁠](https://openai.com/index/bug-bounty-program/) and [Cybersecurity Grant⁠](https://openai.com/index/openai-cybersecurity-grant-program/) Programs, and contribution to [authenticity standards⁠](https://openai.com/index/understanding-the-source-of-what-we-see-and-hear-online/), among others.

We will work closely with the EU AI Office and other relevant authorities as the new law is implemented in the coming months, and we hope that the expertise we’ve built will help advance the objectives of the Act when it comes to deploying safe and beneficial AI.

In this post, we provide an overview of some key topics in the AI Act, with a special focus on prohibited and high-risk use cases.

## When will the AI Act apply?

The AI Act will enter into force on August 1, 2024, 20 days after publication in the EU Official Journal. While most of the Act’s provisions will not become effective for 24 months after entry into force, there are several important deadlines to keep in mind:

- Bans on prohibited practices will become effective **6 months** after entry into force (February 2025)
- Codes of practice, which will cover many of the implementation details needed to comply with the Act, will need to be finalized within **9 months** after entry into force (May 2025)
- Most general purpose AI obligations will become effective **12 months** after entry into force (August 2025).
- Obligations for most high-risk AI systems apply **24 months** after entry into force (August 2026).

Pre-existing GPAI systems that have not been subject to a substantial modification, and certain AI systems that are components of large-scale IT systems identified in Annex X of the AI Act, will have a longer implementation deadline of **36 months** (August 2027).

## Who is covered?

The AI Act principally applies to “AI systems,” which the Act defines as “a machine‑based system designed to operate with varying levels of autonomy, that may exhibit adaptiveness after deployment and that, for explicit or implicit objectives, infers, from the input it receives, how to generate outputs such as predictions, content, recommendations, or decisions that can influence physical or virtual environments.”  This definition is broadly consistent with the OECD’s definition of “AI systems” issued in 2023 and the definition used in the Biden Administration’s Executive Order 14110 on Safe, Secure, and Trustworthy Development and Use of Artificial Intelligence.

Importantly, the AI Act differentiates between _providers_ and _deployers_ of AI systems. Providers are entities, like OpenAI, that develop an AI system or a general-purpose AI model. It also includes entities that have an AI system or a general-purpose AI model developed and place it on the market or who put the AI system into service under its own name or trademark, whether for payment or free of charge.

Deployers are customers or partners who use these systems or models in their own applications, such as integrating GPT‑4o into a specific use case. Although the majority of obligations under the AI Act fall on providers rather than deployers, it’s important to note that a deployer that integrates an AI model into their own AI system can become a provider under the Act, such as by using their own trademark on an AI system or modifying the AI system in ways that weren’t intended by the provider.

## Application to companies established outside the EU

Organizations outside the EU will still have to comply with the AI Act under a variety of conditions that can be quite wide-reaching.  For example, the Act applies if:

- A provider places an AI system or GPAI model on the EU market, regardless of whether the company is established in the EU or another country;
- Deployers of an AI system have their place of establishment in or are located within the EU;
- Providers and deployers of AI systems are established or located in a third country, but the output produced by the AI system is used within the EU.

The broad extraterritorial reach of the AI Act means that non-European companies will need to comply with the Act to serve EU customers regardless of whether they are based inside the EU.

## Risk-Based Regulation

The AI Act is built upon a risk-based framework, with specific requirements for high-risk and unacceptable-risk AI systems. The Act requires companies to classify the risk level of their AI systems to determine the corresponding regulatory obligations, and sets out various categories or tiers of AI systems that each carry different obligations.

## Prohibited AI Practices

Certain AI practices that are deemed to pose an unacceptable risk to individuals’ rights are entirely prohibited. These practices include:

- Deploying subliminal, manipulative, or deceptive techniques to distort behavior and impair informed decision-making, causing significant harm.
- Exploiting vulnerabilities related to age, disability, or socio-economic circumstances to distort behavior, causing significant harm.
- Biometric categorization systems that infer sensitive attributes like race, political opinions, trade union membership, religious or philosophical beliefs, sex life, or sexual orientation (with limited exceptions for labeling or filtering lawfully acquired datasets and for law enforcement use)
- Social scoring systems, such as systems that evaluate or classify individuals or groups based on social behavior or personal traits, causing them harm.
- Assessing the risk of an individual committing criminal offenses based solely on profiling or personality traits (with limited exceptions)
- Compiling facial recognition databases through untargeted scraping of facial images from the internet or CCTV footage
- Inferring emotions in workplaces or educational institutions
- Real-time remote biometric identification in public places for law enforcement (with certain exceptions).

## High-Risk AI Systems

The Act imposes strict obligations on systems that it has determined pose a substantial threat to health, safety, or the fundamental rights of individuals, which are categorized as High-Risk AI (HRAI). These include: a) systems that are safety components of a product subject to other EU laws , and b) specific use cases, such as for systems intended to determine access or admission to educational institutions, to recruit or select workers or monitor worker performance, to determine eligibility for public assistance, creditworthiness, assess eligibility and pricing for health insurance, among others.

HRAI systems must comply with rigorous regulatory obligations, such as establishing a risk management system to continuously evaluate risks and mitigation strategies throughout the lifecycle of an HRAI system, comprehensive data governance measures to test for and evaluate risks of bias, preparing detailed technical documentation before the system is placed on the market, and ongoing monitoring obligations.

## Minimal or Minor-Risk AI Systems

Other AI systems that do not pose unacceptable or high-risks face only limited requirements, such as transparency obligations. For example, the Act specifies that **individuals should be informed when they are interacting with an AI system** like a chatbot, and that artificially manipulated images, audio, or video content need to be clearly labeled. Most AI systems on the market are likely to fall under this category.

## General Purpose AI (GPAI)

Special requirements apply to providers of general purpose AI models and systems, like OpenAI, which will be required to:

- Develop detailed technical documentation of the model and provide it to the AI Office upon request
- Create documentation for deployers who use the GPAI model to develop their own AI systems
- Implement policies intended to respect EU copyright law
- Provide a summary of the content used to train the GPAI model

In addition, providers of GPAI models with high impact capabilities that are deemed to present “systemic risks” (e.g., models trained on a large amount of compute, technically defined as 10^25 FLOPs), will be required to:

- Perform model evaluations to identify and mitigate systemic risks, and continuously assess and mitigate the risks presented
- Notify the EU Commission of models that meet the criteria of this category
- Monitor and report serious incidents
- Implement appropriate cybersecurity measures for the model and its physical infrastructure

GPAI model providers will be able to rely on a code of practice to demonstrate compliance with the AI Act’s requirements. These codes of practice are likely to lay the groundwork for specific details for implementing these obligations, and we look forward to working with the EU AI Office as they are developed over the next 9 months.

## Next Steps and How to Prepare for Compliance

OpenAI is committed to complying with the EU AI Act and we will be working closely with the new EU AI Office as the law is implemented. In the coming months, we will continue to prepare technical documentation and other guidance for downstream providers and deployers of our GPAI models, while advancing the security and safety of the models we provide in the European market and beyond.

If your organization is trying to determine how to comply with the AI Act, you should first attempt to classify any AI systems in scope. Identify what GPAI and other AI systems you use, determine how they are classified, and consider what obligations flow from your use cases. You should also determine whether you are a provider or deployer with respect to any AI systems in scope. These issues can be complex so you should consult with legal counsel if you have questions.

A Primer on the EU AI Act: What It Means for AI Providers and Deployers \| OpenAI
&#123;% endraw %}
