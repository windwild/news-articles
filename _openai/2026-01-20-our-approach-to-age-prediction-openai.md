---
title: "Our approach to age prediction | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/our-approach-to-age-prediction"
date: "2026-01-20"
scraped_at: "2026-03-02T10:08:32.016422188+00:00"
language: "en-US"
translated: true
description: "ChatGPT is rolling out age prediction to estimate if accounts are under or over 18, applying safeguards for teens and refining accuracy over time."
tags: ["Safety"]
---
{% raw %}

January 20, 2026

2026年1月20日

[Safety](https://openai.com/news/safety-alignment/) [Company](https://openai.com/news/company-announcements/)

[安全](https://openai.com/news/safety-alignment/) [公司动态](https://openai.com/news/company-announcements/)

# Our approach to age prediction

# 我们对年龄预测的方法

Building on our work to strengthen teen safety.

在我们加强青少年安全工作的基础上持续推进。

We’re rolling out age prediction on ChatGPT consumer plans to help determine whether an account likely belongs to someone under 18, so the right experience and safeguards can be applied to teens. As we’ve outlined in our [Teen Safety Blueprint⁠](https://openai.com/index/introducing-the-teen-safety-blueprint/) and [Under-18 Principles for Model Behavior⁠](https://openai.com/index/updating-model-spec-with-teen-protections/), young people deserve technology that both expands opportunity and protects their well-being.

我们正面向 ChatGPT 消费者版计划推出年龄预测功能，以辅助判断一个账户是否可能属于18岁以下用户，从而为青少年提供适配的使用体验与安全保障。正如我们在《[青少年安全蓝图](https://openai.com/index/introducing-the-teen-safety-blueprint/)》和《[面向18岁以下用户的模型行为准则](https://openai.com/index/updating-model-spec-with-teen-protections/)》中所阐明的那样：青少年理应享有既能拓展机遇、又能守护其身心福祉的技术。

Age prediction builds on protections already in place. Teens who tell us they are under 18 when they sign up automatically receive additional safeguards to reduce exposure to sensitive or potentially harmful content. This also enables us to treat adults like adults and use our tools in the way that they want, within the bounds of safety.

年龄预测功能建立在现有保护措施之上。当青少年在注册时主动告知我们其年龄低于18岁，系统将自动为其启用额外的安全保障，以降低其接触敏感或潜在有害内容的风险。该机制同时也使我们能够将成年用户视作成年人对待，并在确保安全的前提下，尊重其按自身意愿使用我们工具的权利。

We previously shared our [early plans⁠](https://openai.com/index/building-towards-age-prediction/) for age prediction, and today we’re sharing more detail as the rollout is underway.

此前，我们已公布过年龄预测功能的[初步规划](https://openai.com/index/building-towards-age-prediction/)；如今，随着该功能正逐步上线，我们进一步分享更多技术细节。

## How age prediction works

## 年龄预测如何运作

ChatGPT uses an age prediction model to help estimate whether an account likely belongs to someone under 18. The model looks at a combination of behavioral and account-level signals, including how long an account has existed, typical times of day when someone is active, usage patterns over time, and a user’s stated age. Deploying age prediction helps us learn which signals improve accuracy, and we use those learnings to continuously refine the model over time.

ChatGPT 借助一个年龄预测模型，辅助估算某账户是否可能属于18岁以下用户。该模型综合分析多种行为特征与账户层级信号，包括账户存续时长、用户日常活跃时段、长期使用模式，以及用户自行申报的年龄信息。通过部署年龄预测功能，我们得以识别哪些信号有助于提升预测准确率，并持续利用这些发现优化和迭代模型。

Users who are incorrectly placed in the under-18 experience will always have a fast, simple way to confirm their age and restore their full access with a selfie through Persona, a secure identity-verification service. Users can check if safeguards have been added to their account and start this process at any time by going to Settings > Account.

被错误归入“未满18岁”体验的用户，始终可通过Persona（一种安全的身份验证服务）快速、简便地上传自拍照来确认真实年龄，并立即恢复全部功能权限。用户可随时前往“设置 > 账户”，查看账户是否已启用相关保护措施，并即时启动年龄验证流程。

When the age prediction model estimates that an account may belong to someone under 18, ChatGPT automatically applies [additional protections⁠](https://openai.com/index/updating-model-spec-with-teen-protections/) designed to reduce exposure to sensitive content, such as:

当年龄预测模型判定某账户可能属于未满18周岁的用户时，ChatGPT将自动启用[额外保护措施⁠](https://openai.com/index/updating-model-spec-with-teen-protections/)，以降低其接触敏感内容的风险，包括：

- Graphic violence or gory content  
- 暴力血腥内容  
- Viral challenges that could encourage risky or harmful behavior in minors  
- 可能诱导未成年人从事高风险或有害行为的网络挑战  
- Sexual, romantic, or violent role play  
- 涉及性、浪漫关系或暴力的主题角色扮演  
- Depictions of self-harm  
- 自残行为的呈现  
- Content that promotes extreme beauty standards, unhealthy dieting, or body shaming  
- 宣扬极端审美标准、不健康节食或身体羞辱的内容  

This approach is guided by expert input and rooted in academic literature about the science of child development and acknowledges known teen differences in risk perception, impulse control, peer influence, and emotional regulation. While these content restrictions help reduce teens’ exposure to sensitive material, we are focused on continually improving these protections, especially to address attempts to bypass our safeguards. When we are not confident about someone’s age or have incomplete information, we default to a safer experience.

该方案基于儿童发展科学领域的学术研究成果，并融合了心理学、教育学等专家的专业建议，充分考虑青少年在风险认知、冲动控制、同伴影响及情绪调节等方面与成年人的已知差异。尽管上述内容限制有助于减少青少年接触敏感信息的可能性，我们仍将持续优化这些保护机制——尤其着力防范绕过防护措施的行为。当系统对用户年龄缺乏足够置信度，或所掌握信息不完整时，我们将默认为其提供更安全的使用体验。

In addition to these safeguards, parents can choose to customize their teen’s experience further through [parental controls⁠(opens in a new window)](https://help.openai.com/en/articles/12315553-parental-controls-on-chatgpt-faq) including setting quiet hours when ChatGPT can not be used, controlling features such as memory or model training, and receiving notifications if signs of acute distress are detected.

除上述保护措施外，家长还可通过[家长控制功能⁠(在新窗口中打开)](https://help.openai.com/en/articles/12315553-parental-controls-on-chatgpt-faq)进一步个性化青少年的使用体验，例如：设定“静默时段”（在此期间无法使用ChatGPT）、管控记忆功能或模型训练等特性，并在系统检测到用户出现急性心理困扰迹象时及时接收通知。

## What’s next

## 后续计划

We’re learning from the initial rollout and continuing to improve the accuracy of age prediction over time. We will closely track rollout and use those signals to guide ongoing improvements.

我们正从首轮上线实践中汲取经验，并持续提升年龄预测模型的准确性。我们将密切跟踪部署效果，利用各项反馈信号指导后续迭代优化。

In the EU, age prediction will roll out in the coming weeks to account for regional requirements. For more detail, visit our [help page⁠(opens in a new window)](https://help.openai.com/en/articles/12652064-age-prediction-in-chatgpt).

在欧盟地区，年龄预测功能将在未来几周内分阶段上线，以满足当地法规要求。详情请参阅我们的[帮助页面⁠(在新窗口中打开)](https://help.openai.com/en/articles/12652064-age-prediction-in-chatgpt)。

While this is an important milestone, our work to support teen safety is ongoing. We’ll continue to share updates on our progress and what we’re learning, in dialogue with experts including the American Psychological Association, ConnectSafely, and [Global Physicians Network⁠](https://openai.com/index/strengthening-chatgpt-responses-in-sensitive-conversations/).

尽管这是保障青少年安全的重要里程碑，我们的相关工作仍在持续推进。我们将持续与美国心理学会（APA）、ConnectSafely以及[全球医师网络⁠](https://openai.com/index/strengthening-chatgpt-responses-in-sensitive-conversations/)等专家机构保持对话，并定期公开分享项目进展与阶段性研究成果。

- [2026](https://openai.com/news/?tags=2026)  
- [2026](https://openai.com/news/?tags=2026)  
- [ChatGPT](https://openai.com/news/?tags=chatgpt)  
- [ChatGPT](https://openai.com/news/?tags=chatgpt)  
- [User Safety & Control](https://openai.com/news/?tags=user-safety)  
- [用户安全与控制](https://openai.com/news/?tags=user-safety)
{% endraw %}
