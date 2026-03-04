---
title: "Customizing models for legal professionals | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/harvey"
date: "2024-04-02"
scraped_at: "2026-03-02T10:20:05.589450487+00:00"
language: "en-US"
translated: false
description: "Harvey partners with OpenAI to build a custom-trained model for legal professionals."
tags: ["Story"]
---
&#123;% raw %}


# Harvey

Harvey partners with OpenAI to build a custom-trained model for legal professionals.

![White Harvey logo on a grey background.](images/customizing-models-for-legal-professionals-openai/img_001.png)



Over the past year, Harvey has established itself as a secure generative AI platform for professionals in law, tax, and finance. They’ve grown to a team of over 100 people, increased revenue over 10x in 2023, and raised $80M in Series B funding at a $715M valuation.

Recently, Harvey partnered with OpenAI to create a custom-trained case law model. This has allowed Harvey to deliver AI systems that help with tasks requiring complex reasoning, extensive domain knowledge, and capabilities beyond a single model call—such as drafting documents, answering questions about complex litigation scenarios, and identifying material discrepancies between hundreds of contracts.

![harvey](images/customizing-models-for-legal-professionals-openai/img_002.webp)

## Redefining what’s possible for LLMs in legal tech

Harvey was founded by Winston Weinberg, an attorney with a background in antitrust and securities litigation and Gabe Pereyra, an AI researcher who previously worked on large language models (LLMs) for Google Brain and Meta. They saw an opportunity to use LLMs to synthesize information and present it to lawyers for review.

“Both transactional work and litigation have been getting increasingly complex—there might be hundreds of thousands of contracts to go through for an international merger, and millions of emails to review for litigation,” Weinberg explained. With AI helping synthesize documents, lawyers can spend less time sifting through and drafting legal texts, and more time making decisions and helping clients.

An early proof point came when Weinberg and Pereyra pulled Reddit’s r/legaladvice for landlord/tenant questions and used GPT‑3 to generate answers, which they shared with attorneys. “For 86 out of 100 questions, the attorneys said they would have just sent the answer to the client without editing,” Weinberg said. “It was an aha moment.”

## Building the first custom-trained case law model with OpenAI

For case law research, the team at Harvey envisioned an experience where you could copy/paste a client question into a case law model, and it would answer that question thoroughly and cite all its sources. They tried the obvious techniques first: fine-tuning foundation models via public APIs and building retrieval-augmented generation (RAG) systems. But they ran into limitations with such a uniquely complex, open-ended use case.

“If you just do retrieval, you can answer very simple questions about areas of law that you aren’t really an expert in, but that’s actually not that useful for most attorneys,” Weinberg explained. “With case law research, you’re finding ammo for your argument, and that’s much more difficult to do.”

Foundation models were strong at reasoning, but lacked the knowledge required for legal work. So, Harvey decided to partner with OpenAI to build a custom-trained model that would allow them to inject new knowledge, and ways of reasoning about that knowledge, into base models.

“None of these problems have a clear-cut solution,” Pereyra said. “A lot of it was sitting down together, having our lawyers explain how case law research works, having our researchers show what we’ve done, and learning from OpenAI about the levers we had to approach the problem.”

Harvey and OpenAI worked together to add the depth of context needed, first starting with case law from Delaware, and then expanding to include all of U.S. case law. They added the equivalent of 10 billion tokens worth of data to power the custom-trained case law model.

## Achieving highly relevant, accurate results with source citations

To test the case law model, Harvey worked with 10 of the largest law firms. They provided attorneys with side-by-sides of the output from the custom case law model, versus the output from GPT‑4 for the same question. They were surprised by how strong the reaction was.

![A comparison of GPT-4 and a GPT-4 custom model. The resulting model achieved an 83% increase in factual responses and attorneys preferred the customized model’s outputs 97% of the time over GPT-4.](images/customizing-models-for-legal-professionals-openai/img_003.gif)

“97% of the time, the lawyers preferred the output from the case law model,” Weinberg said. “Usually, it was because it was a longer, more complete answer. It went into the nuance of what the question was asking and covered more relevant case law.”

Hallucination reduction was one of Harvey’s motivations for building a custom model, and the investment paid off. “Not only does the case law model not make up cases, but every sentence is actually supported with the case it’s citing,” Weinberg said.

As they roll this out to more users, Harvey is eager to explore other applications of the case law model, such as drafting briefs and motions, or helping attorneys understand how case law varies across different jurisdictions.

## Building for the next-generation of LLMs

Pereyra offered this advice for other founders working in AI: “Don’t build for the current capabilities of models today—build for where the models are going to be. Tackle more complex versions of problems so that when better versions of the models come out, they aren’t solved as a side effect.”

What’s Harvey tackling next? One of their focuses is agents, or how to combine multiple model calls together into a single working output. This would simplify the user experience and reduce the amount of prompt engineering and typing users need to do.

The vision is for Harvey to serve as a supportive member of the team. “The volume of legal work is growing and associates spend countless hours on complex, but routine, tasks,” Weinberg said. “The opportunity we have, not just with legal but with all professional services, is to take care of the routine tasks so professionals can focus their time on client interactions.”

“This was cutting-edge research,” Pereya said. “We needed a partner that was willing to invest resources to try something new. We looked at all options, but we only trusted building a custom-trained model with OpenAI.”

> “This was cutting-edge research. We needed a partner that was willing to invest resources to try something new. We looked at all options, but we only trusted building a custom-trained model with OpenAI.”

Gabe Pereyra, AI Researcher and Co-founder

## Interested in learning more about ChatGPT for business?

[Talk with our team](https://openai.com/contact-sales/)

## Related customer stories

[View all](https://openai.com/news/api/)

![Klarna > Cover Image](images/customizing-models-for-legal-professionals-openai/img_004.png)

[Klarna's AI assistant does the work of 700 full-time agents\\
\\
ChatGPTApr 5, 2024](https://openai.com/index/klarna/)

![Oscar Cover Image](images/customizing-models-for-legal-professionals-openai/img_005.png)

[Reducing health insurance costs and improving care\\
\\
APIApr 1, 2024](https://openai.com/index/oscar/)

![Zelma Story Cover Image](images/customizing-models-for-legal-professionals-openai/img_006.png)

[Making education data accessible\\
\\
APIMar 28, 2024](https://openai.com/index/zelma/)

Customizing models for legal professionals \| OpenAI
&#123;% endraw %}
