---
title: "Work smarter with your company knowledge in ChatGPT | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-company-knowledge"
date: "2025-10-23"
scraped_at: "2026-03-02T10:09:29.466198055+00:00"
language: "en-US"
translated: false
description: "Company knowledge brings context from your apps into ChatGPT for answers specific to your business, with clear citations, security, privacy, and admin controls. Available now for Business, Enterprise,..."
---

October 23, 2025


# Work smarter with your company knowledge in ChatGPT

A new way to bring together context from all your connected tools for answers that know your business.

00:00



ChatGPT can help with almost any question, but the context you need to get work done often lives in your internal tools: docs, files, messages, emails, tickets, and project trackers. Those tools don’t always connect to each other, and the most accurate answer is often spread across them.

Today we're introducing company knowledge for ChatGPT Business, Enterprise, and Edu. Company knowledge brings all the context from your connected apps together in ChatGPT, giving you answers specific to your business—so you can make decisions, take action, and get things done.

With company knowledge, the information in your connected apps—like Slack, SharePoint, Google Drive, and GitHub—becomes more useful and accessible. It’s powered by a version of GPT‑5 that’s trained to look across multiple sources to give more comprehensive and accurate answers. Every response includes clear citations so you can see where the information came from and trust the results.

For example, if you have an upcoming client call, ChatGPT can create a briefing for you based on recent messages from your account channel in Slack, key details from emails with your client, the last call notes in Google Docs, and any escalations from Intercom support tickets since your last meeting.

Starting today, anyone on ChatGPT Business, Enterprise, and Edu can use company knowledge. Company knowledge respects your existing company permissions, so ChatGPT only has access to what each user is already authorized to view.

## How it works

To get started, tap “Company knowledge” under the message composer. When using it for the first time, you’ll need to connect your work apps. After that, whenever you enable it, ChatGPT will look across all your apps to bring relevant context into its answers.

![ChatGPT interface with a prompt field asking ‘What can I help with?’ and a button labeled ‘Company knowledge.’ On the right, a setup panel titled ‘Connect apps you use at work’ lists integration options including Google Drive, Gmail, GitHub, SharePoint, and HubSpot, each with a plus icon for connecting accounts.](images/work-smarter-with-your-company-knowledge-in-chatgpt-openai/img_001.png)

As it works, you can follow along in the sidebar to see what it’s looking at and how it’s using the information. When it’s done, you’ll see exactly what sources it used to inform its response, along with the specific snippets it drew from. You can then click on any citation to open the original source for more details.

[Get started now⁠(opens in a new window)](http://chatgpt.com/?company-knowledge=&openaicom-did=d24fa91f-4a35-4b83-a09a-c46e0c82ad0c&openaicom_referred=true) or learn more in our [Help Center⁠(opens in a new window)](https://help.openai.com/en/articles/12628342).

![Interface showing a summary of connected workplace sources labeled ‘32 sources,’ including Outlook, Linear, and SharePoint. The content preview lists items such as an Outlook email titled ‘October Results & Next Steps,’ a Linear task ‘Q4 Rollout Checklist,’ and a SharePoint document ‘Q4 Growth Plan,’ each containing short text excerpts about campaign planning and growth preparation.](images/work-smarter-with-your-company-knowledge-in-chatgpt-openai/img_002.png)

## Built to understand what’s going on at work

Company knowledge can run multiple searches to resolve conflicting details, making it more effective at handling ambiguous questions and situations where there isn’t a clear answer. This is especially useful when teams aren’t on the same page or a decision hasn’t been made. For example, if you ask _“_ Where did we land on company goals for next year? _”_ ChatGPT can summarize what’s been discussed and highlight differing viewpoints, so you can take the right next step with the team.

It can also provide more balanced, comprehensive responses. For example, if you say, “Report on customer feedback from the mobile launch,” it won’t just recap sentiment but will also bring in related support tickets, customer quotes, and even recommend next steps. This gives you a more complete picture of what’s really happening to help you make better decisions.

And because it can think while it searches and use date filters, company knowledge is good at finding time-based information. For example, if you ask _“_ Give me a quick update on our company performance,” ChatGPT can pull from multiple Slack channels and Google Docs and Sheets, ranking sources by recency and quality to give you the most current view. It can also track down information from a specific moment in time, like “Look back at our company performance in Q1,” so you don’t have to dig through past files or messages yourself.

## Your company data stays private, protected, and in your control

As ChatGPT becomes even more helpful at work, we’re giving organizations more control over who can access what, where data lives, and how it’s protected.

- **Control:** Enterprise and Edu admins can manage access to the connected apps that power company knowledge across their workspace. They can create custom roles and [set group-level permissions⁠(opens in a new window)](https://help.openai.com/en/articles/11750701-rbac) to ensure users only access what they need.
- **Privacy**: Company knowledge respects your existing permissions—ChatGPT can only access what each user is already allowed to view. **OpenAI never trains on your data by default.**
- **Security:** All data is protected with industry-standard encryption. [SSO⁠(opens in a new window)](https://help.openai.com/en/articles/10468051-sso-overview) and [SCIM⁠(opens in a new window)](https://help.openai.com/en/articles/9627404-openai-chatgpt-scim-integration-faq) simplify secure access management at scale, and [IP allowlisting⁠(opens in a new window)](https://help.openai.com/en/articles/12111596-ip-allowlisting-for-chatgpt) ensures only traffic from approved IP addresses can access ChatGPT.
- **Compliance**: Admins can access conversation logs through the [Enterprise Compliance API⁠⁠(opens in a new window)](https://help.openai.com/en/articles/9261474-compliance-apis-for-enterprise-customers) for reporting and regulatory purposes.

[Learn more⁠](https://openai.com/business-data/) about our enterprise-grade security, data privacy, and compliance programs.

### Ways to use it

![ChatGPT interface showing a prompt reading ‘Summarize customer feedback and strategically prioritize the next mobile release.’ Below, the response references connected company data sources such as Google Slides (‘Mobile App User Survey’), Slack (‘#user-feedback’), and Intercom (‘Mobile Performance’), summarizing user insights and outlining key feedback for the upcoming mobile app release.](images/work-smarter-with-your-company-knowledge-in-chatgpt-openai/img_003.png)

Company knowledge goes beyond answering questions like “How do I file an expense report?” It helps ChatGPT understand your work context right away, so it can be more useful with tasks like drafting plans, compiling reports, or catching up on a new project—without you having to explain what you’re working on.

Use it to help you:

- **Turn customer insights into strategy docs:** ChatGPT can synthesize the most recent customer feedback shared in Slack channels, survey results insights from Google Slides, and key themes from support tickets to help inform roadmap planning.
- **Create reports using the latest info:** After a campaign, ChatGPT can pull contacts or deals tied to your campaign from HubSpot, briefs and post-mortem notes from Google Docs, and highlights shared in email threads to generate a performance summary.
- **Build release plans**: ChatGPT can scan your GitHub repo for open TODOs, check Linear for related tickets, and look through your Slack engineering channels for any unresolved bug reports to help plan your next feature release. It can then summarize what’s outstanding, what’s already tracked, and what still needs to be logged.

## Limitations and what’s next

To use company knowledge today, you’ll need to manually select it when you start a new conversation. When it’s not selected, ChatGPT may still use your connected apps to help answer questions, but its responses won’t include the same depth or detailed citations. We’re working to bring these experiences together in the coming months.

When company knowledge is on, ChatGPT can’t search the web or create charts and images. You can turn it off and continue working in the same conversation to use these capabilities, while keeping your existing context. In the coming months, we plan to integrate company knowledge with ChatGPT’s full range of capabilities.

We’ll continue adding support for additional tools to make company knowledge responses even more comprehensive. This week, we introduced new connectors to Asana, GitLab Issues, ClickUp, and [many more⁠(opens in a new window)](https://chatgpt.com/features/connectors?openaicom-did=d24fa91f-4a35-4b83-a09a-c46e0c82ad0c&openaicom_referred=true).

Learn more about [**ChatGPT Business** ⁠(opens in a new window)](https://chatgpt.com/business?openaicom-did=d24fa91f-4a35-4b83-a09a-c46e0c82ad0c&openaicom_referred=true) or [**contact our team** ⁠(opens in a new window)](https://chatgpt.com/contact-sales?openaicom-did=d24fa91f-4a35-4b83-a09a-c46e0c82ad0c&openaicom_referred=true) to start using ChatGPT with your company knowledge.

- [2025](https://openai.com/news/?tags=2025)