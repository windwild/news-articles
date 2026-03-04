---
render_with_liquid: false
title: "Introducing Operator | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-operator"
date: "2025-01-23"
scraped_at: "2026-03-02T10:15:30.247742416+00:00"
language: "en-US"
translated: false
description: "A research preview of an agent that can use its own browser to perform tasks for you. Available to Pro users in the U.S."
tags: ["Product"]
---

January 23, 2025


# Introducing Operator

A research preview of an agent that can use its own browser to perform tasks for you. Available to Pro users in the U.S.

[Go to Operator(opens in a new window)](https://operator.chatgpt.com/)

![Introducing Operator > Hero > Media Item](images/introducing-operator-openai/img_001.png)



_**July 17, 2025 update**_ _: Operator is now fully integrated into ChatGPT as ChatGPT agent. To access these updated capabilities, simply select “agent mode” from the dropdown in the composer and enter your query directly within ChatGPT. As a result, the standalone Operator site (operator.chatgpt.com) will sunset on in the coming weeks._

* * *

Today we’re releasing [Operator⁠(opens in a new window)](https://operator.chatgpt.com/), an agent that can go to the web to perform tasks for you. Using its own browser, it can look at a webpage and interact with it by typing, clicking, and scrolling. **It is currently a research preview**, meaning it has limitations and will evolve based on user feedback. Operator is one of our first agents, which are AIs capable of doing work for you independently—you give it a task and it will execute it.

Operator can be asked to handle a wide variety of repetitive browser tasks such as filling out forms, ordering groceries, and even creating memes. The ability to use the same interfaces and tools that humans interact with on a daily basis broadens the utility of AI, helping people save time on everyday tasks while opening up new engagement opportunities for businesses.

To ensure a safe and iterative rollout, we are starting small. Starting today, Operator is available to [Pro](https://openai.com/chatgpt/pricing/) users in the U.S. at [operator.chatgpt.com⁠(opens in a new window)](https://operator.chatgpt.com/). This research preview allows us to learn from our users and the broader ecosystem, refining and improving as we go. Our plan is to expand to Plus, Team, and Enterprise users and integrate these capabilities into ChatGPT in the future.

00:00

## How Operator works

Operator is powered by a new model called [Computer-Using Agent (CUA)](https://openai.com/index/computer-using-agent/). Combining GPT‑4o's vision capabilities with advanced reasoning through reinforcement learning, CUA is trained to interact with graphical user interfaces (GUIs)—the buttons, menus, and text fields people see on a screen.

Operator can “see” (through screenshots) and “interact” (using all the actions a mouse and keyboard allow) with a browser, enabling it to take action on the web without requiring custom API integrations.

If it encounters challenges or makes mistakes, Operator can leverage its reasoning capabilities to self-correct. When it gets stuck and needs assistance, it simply hands control back to the user, ensuring a smooth and collaborative experience.

While CUA is still in early stages and has limitations, it sets new state-of-the-art benchmark results in WebArena and WebVoyager, two key browser use benchmarks. Read more about evals and the research behind Operator in [our research blog post](https://openai.com/index/computer-using-agent/).

## How to use

To get started, simply describe the task you’d like done and Operator can handle the rest. Users can choose to take over control of the remote browser at any point, and Operator is trained to proactively ask the user to take over for tasks that require login, payment details, or when solving CAPTCHAs.

Users can personalize their workflows in Operator by adding custom instructions, either for all sites or for specific ones, such as setting preferences for airlines on Booking.com. Operator lets users save prompts for quick access on the homepage, ideal for repeated tasks like restocking groceries on Instacart. Similar to using multiple tabs on a browser, users can have Operator run multiple tasks simultaneously by creating new conversations, like ordering a personalized enamel mug on Etsy while booking a campsite on Hipcamp.

00:00

## Ecosystem & users

[Operator⁠(opens in a new window)](https://operator.chatgpt.com/) transforms AI from a passive tool to an active participant in the digital ecosystem. It will streamline tasks for users and bring the benefits of agents to companies that want innovative customer experiences and desire higher rates of conversion. We’re collaborating with companies like DoorDash, Instacart, OpenTable, Priceline, StubHub, Thumbtack, Uber, and others to ensure Operator addresses real-world needs while respecting established norms. In addition to these collaborations, we see a lot of potential to improve the accessibility and efficiency of certain workflows, particularly in public sector applications. To explore these use cases further, we’re working with organizations like the [City of Stockton⁠(opens in a new window)](https://www.stocktonca.gov/) to make it easier to enroll in city services and programs.

> “As we learn more about Operator during its research preview, we'll be better equipped to identify ways that AI can make civic engagement even easier for our residents.”

Jamil Niazi, Director of Information Technology at City of Stockton

By releasing Operator to a limited audience initially, we aim to learn quickly and refine its capabilities based on real-world feedback, ensuring we balance innovation with trust and safety. This collaborative approach helps ensure Operator delivers meaningful value to users, creators, businesses, and public sector organizations alike.

> “OpenAI's Operator is a technological breakthrough that makes processes like ordering groceries incredibly easy.”

Daniel Danker, Chief Product Officer at Instacart

## Safety and privacy

Ensuring Operator is safe to use is a top priority, with three layers of safeguards to prevent abuse and ensure users are firmly in control.

First, Operator is trained to ensure that the person using it is always in control and asks for input at critical points.

- **Takeover mode:** Operator asks the user to take over when inputting sensitive information into the browser, such as login credentials or payment information. When in takeover mode, Operator does not collect or screenshot information entered by the user.
- **User confirmations**: Before finalizing any significant action, such as submitting an order or sending an email, Operator should ask for approval.
- **Task limitations:** Operator is trained to decline certain sensitive tasks, such as banking transactions or those requiring high-stakes decisions, like making a decision on a job application.
- **Watch mode**: On particularly sensitive sites, such as email or financial services, Operator requires close supervision of its actions, allowing users to directly catch any potential mistakes.

Next, we’ve made it easy to manage data privacy in Operator.

- **Training opt out:** Turning off ‘Improve the model for everyone’ in ChatGPT settings means data in Operator will also not be used to train our models.
- **Transparent data management:** Users can delete all browsing data and log out of all sites with one click under the Privacy section of Operator settings. Past conversations in Operator can also be deleted with one click.

Lastly, we’ve built defenses against adversarial websites that may try to mislead Operator through hidden prompts, malicious code, or phishing attempts:

- **Cautious navigation**: Operator is designed to detect and ignore prompt injections.
- **Monitoring**: A dedicated “monitor model” watches for suspicious behavior and can pause the task if something seems off.
- **Detection pipeline**: Automated and human review processes continuously identify new threats and quickly update safeguards.

We know bad actors may try to misuse this technology. That’s why we’ve designed Operator to refuse harmful requests and block disallowed content. Our moderation systems can issue warnings or even revoke access for repeated violations, and we’ve integrated additional review processes to detect and address misuse. We’re also providing [guidance](https://openai.com/policies/using-chatgpt-agent-in-line-with-our-policies/) on how to interact with Operator in compliance with our [Usage Policies](https://openai.com/policies/usage-policies/).

While Operator is designed with these safeguards, no system is flawless and this is still a research preview; we are committed to continuous improvement through real-world feedback and rigorous testing. For more on our approach, [visit the safety section of the Operator research blog](https://openai.com/index/computer-using-agent/).

## Limitations

Operator is currently in an early research preview, and while it’s already capable of handling a wide range of tasks, it’s still learning, evolving and may make mistakes. For instance, it currently encounters challenges with complex interfaces like creating slideshows or managing calendars. Early user feedback will play a vital role in enhancing its accuracy, reliability, and safety, helping us make Operator better for everyone.

## What's next

**CUA in the API:** We plan to expose the model powering Operator, [CUA](https://openai.com/index/computer-using-agent/), in the API soon so that developers can use it to build their own computer-using agents.

**Enhanced Capabilities:** We’ll continue to improve Operator’s ability to handle longer and more complex workflows.

**Wider Access:** We plan to expand [Operator⁠(opens in a new window)](https://operator.chatgpt.com/) to Plus, Team, and Enterprise users and integrate its capabilities directly into ChatGPT in the future once we are confident in its safety and usability at scale, unlocking seamless real-time and asynchronous task execution.

![](images/introducing-operator-openai/img_002.png)

Play video