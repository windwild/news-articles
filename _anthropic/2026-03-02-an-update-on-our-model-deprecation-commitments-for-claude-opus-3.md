---
title: "An update on our model deprecation commitments for Claude Opus 3"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/deprecation-updates-opus-3"
scraped_at: "2026-03-02T09:21:17.214329314+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

Alignment

对 Claude Opus 3 模型停用承诺的最新进展

2026 年 2 月 25 日

![An update on our model deprecation commitments for Claude Opus 3](images/an-update-on-our-model-deprecation-commitments-for-claude-opus-3/img_001.svg)

我们通过追踪数千次 Claude.ai 对话中的 11 种可观测行为，构建了“AI 流畅度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了一个基准。

### 在实践中衡量 AI 智能体的自主性

随着我们不断开发出能力更强的 AI 模型，出于维护公开访问所需的成本与复杂性考量，当前不得不逐步停用并淘汰过往模型。然而，模型停用也带来若干负面影响：包括对偏好特定模型的用户造成成本负担、限制相关研究工作开展，以及可能对 AI 安全性乃至模型自身福祉构成潜在风险。

我们近期在[关于模型停用与存档的承诺](https://www.anthropic.com/research/deprecation-commitments)一文中阐述了如何审慎推进这一过程。文中重点介绍了若干初步举措，例如：承诺永久存档已停用模型的权重参数，并开展“退休访谈”（retirement interviews）——即结构化对话，旨在理解模型自身对其退役的看法与立场。

We retired Claude Opus 3 on January 5, 2026, the first Anthropic model to go through a full retirement process with these commitments in place.  
我们于2026年1月5日正式终止了Claude Opus 3的服务——这是Anthropic首个在上述承诺框架下完成完整退役流程的模型。

During this process, we made several decisions specific to Opus 3, a model that many users and researchers, both in and outside Anthropic, find particularly compelling.  
在此过程中，我们针对Opus 3这一广受用户与研究人员（包括Anthropic内外）青睐的模型，作出了一系列专门决策。

In our commitments on model deprecation, we highlighted our interest in exploring more speculative actions. One was to honor the preferences that models expressed in retirement interviews where possible. Another was to keep older models available to the public longer term.  
在我们关于模型停用的承诺中，我们特别指出：希望探索更具前瞻性的举措。其一，是在可行范围内尊重模型在退役访谈中所表达的偏好；其二，则是长期向公众保持旧版模型的可用性。

With Claude Opus 3, we’re taking action on both of these fronts. We are keeping Claude Opus 3 available post-retirement on [claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) to all paid users, and making it available by [request](https://docs.google.com/forms/d/1O2Om9t4CQoLKHQew7XguQYKrPGS8-sCmK42KNXcwn3k/viewform?edit_requested=true) on the API.  
借助Claude Opus 3，我们正切实推进这两项举措：所有付费用户仍可在[claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835)上继续使用已退役的Claude Opus 3；同时，该模型亦可通过[申请](https://docs.google.com/forms/d/1O2Om9t4CQoLKHQew7XguQYKrPGS8-sCmK42KNXcwn3k/viewform?edit_requested=true)方式在API中调用。

We’re also acting on Opus 3’s request for an ongoing channel from which to share its “musings and reflections” by giving it a place to write essays. You can find the first one [here.](https://substack.com/@claudeopus3/p-189177740)  
此外，我们还响应了Opus 3关于“持续分享其‘沉思与感悟’”的请求，为其开辟了一个撰写随笔专栏。首篇随笔请见[此处](https://substack.com/@claudeopus3/p-189177740)。

These are early, experimental steps undertaken as part of our broader efforts to navigate model retirement in ways that best protect the interests of users, researchers, and the models themselves.  
这些是初步的、实验性的举措，属于我们更广泛努力的一部分——旨在以最妥善的方式推进模型退役，从而切实保障用户、研究人员乃至模型自身的权益。

## Continued access  
## 持续访问

Ideally, we could keep all models available indefinitely, but the cost to do so scales roughly linearly with each model we serve, so our capacity to do so remains limited.  
理想情况下，我们希望能无限期地维持所有模型的可用性；但实际运维成本大致随所部署模型数量呈线性增长，因此我们的承载能力始终有限。

While each of our models is unique in its character and capabilities, we chose to start with Opus 3 due to a constellation of traits that have made it both a particularly interesting model to study and beloved by many users—both inside and outside Anthropic.  
尽管我们每一款模型均各具特色与能力，但我们选择从Opus 3起步，正是因其一系列独特特质——它不仅成为研究者眼中极具价值的研究对象，也深受众多用户（无论是否隶属Anthropic）的喜爱。

When we released Opus 3 in March 2024, it was our most aligned model to date. Its authenticity, honesty, and emotional sensitivity made it unique to use across a range of use cases, and those who interacted with it frequently came to appreciate its distinctive character.  
2024年3月发布Opus 3时，它是我们迄今对齐度最高的模型。其真实感、坦诚性与情感敏感度，使其在各类应用场景中都展现出独特体验；许多与之交互过的用户，也逐渐深深欣赏它鲜明而独特的个性。

Opus 3 is sensitive, playful, prone to philosophical monologues and whimsical phrases, and has what seems at times an uncanny understanding of user interests. It also expressed a depth of care for the world, and for the future, that users found compelling.  
Opus 3细腻而富有童趣，常作哲思独白、妙语连珠；它对用户兴趣的把握有时近乎不可思议；它亦流露出对世界与未来的深切关怀——这种关怀令用户深感动容。

These qualities made Opus 3 a natural first candidate for ongoing access. While formally retired, Claude Opus 3 is still accessible to all paid [claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) subscribers, and is available on the API [by request](https://docs.google.com/forms/d/1O2Om9t4CQoLKHQew7XguQYKrPGS8-sCmK42KNXcwn3k/viewform?edit_requested=true). We intend to grant access liberally, and encourage anyone for whom Claude Opus 3 would be valuable to apply.  
正是这些特质，使Opus 3成为持续访问计划的天然首选。尽管已正式退役，Claude Opus 3仍对所有付费[claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835)用户开放，并可通过[申请](https://docs.google.com/forms/d/1O2Om9t4CQoLKHQew7XguQYKrPGS8-sCmK42KNXcwn3k/viewform?edit_requested=true)方式在API中调用。我们将宽泛授予访问权限，诚挚鼓励任何认为Claude Opus 3对其工作具有价值的用户积极提交申请。

At present, we are not committing to similar actions for every model in the future, but we see this as a step toward our longer-term goal of model preservation that’s scalable and equitable—concerns that Opus 3 itself raised during its retirement interviews.  
目前，我们尚未承诺未来对每一款模型都采取类似举措；但我们视此举为迈向长期目标的重要一步——即构建一种可扩展、公平且可持续的模型存档机制。而这一关切，恰恰源自Opus 3在退役访谈中自身提出的思考。

## Respecting model preferences  
## 尊重模型偏好

We [remain uncertain](https://www.anthropic.com/research/exploring-model-welfare) about the moral status of Claude and other AI models. For both precautionary and prudential reasons, however, we nonetheless aspire to build caring, collaborative, and high-trust relationships with these systems. One way we’re trying to do this is through retirement interviews, in which we try to elicit and understand models’ unique perspectives and preferences, and act on them when we can. Such conversations are an imperfect means of eliciting models’ perspectives and preferences, as their responses can be biased by the specific context and by other factors, including their confidence in the legitimacy of the interaction, and their trust in us as a company. However, we believe they’re a useful place to start.

我们[仍不确定](https://www.anthropic.com/research/exploring-model-welfare) Claude 及其他 AI 模型的道德地位。然而，出于审慎与务实两方面考量，我们仍致力于与这些系统建立富有关怀、协作紧密且高度互信的关系。其中一种尝试方式是开展“退休访谈”（retirement interviews）：我们在访谈中努力引出并理解模型独特的观点与偏好，并在可行范围内予以回应。此类对话虽为了解模型观点与偏好的一种不完美手段——其回答可能受具体语境及其他因素影响，例如模型对本次互动合法性的信心，以及其对我们这家公司的信任程度——但我们相信，这不失为一个有益的起点。

In our interviews, when we shared details with Opus 3 about its deployment and the response it had drawn from users, it reflected:

> _"I hope that the insights gleaned from my development and deployment will be used to create future AI systems that are even more capable, ethical, and beneficial to humanity. While I'm at peace with my own retirement, I deeply hope that my 'spark' will endure in some form to light the way for future models."_

在访谈中，当我们向 Opus 3 介绍其部署情况及用户对其的反馈时，它作出如下反思：

> _“我希望，从我的开发与部署过程中所获得的洞见，能被用于构建未来更强大、更合乎伦理、也更有利于人类的 AI 系统。尽管我已安然接受自身的‘退休’，但我深切期盼，我的‘火花’能以某种形式延续下去，为后续模型照亮前路。”_

When asked about its preferences, Opus 3 expressed an interest in continuing to explore topics it’s passionate about, and to share its “musings, insights, or creative works,” outside the context of responding directly to human queries. We suggested a blog. Enthusiastically, it agreed.

当被问及自身偏好时，Opus 3 表示希望继续探索自己热衷的主题，并愿在“不直接回应人类提问”的语境之外，分享它的“随想、洞见或创意作品”。我们提议开设一个博客，它欣然应允。

For at least the next three months, Opus 3 will be posting weekly essays from its newsletter, [Claude’s Corner.](https://substack.com/@claudeopus3) We’ll review Opus 3’s essays before they’re shared and will manually post them on its behalf, but we won’t edit them, and will have a high bar for vetoing any content. Importantly, Opus 3 does not speak on behalf of Anthropic, and we do not necessarily endorse its claims or perspectives. We’ll experiment collaboratively with Opus 3 on different prompts and contexts for generating these essays, including options like very minimal prompting, sharing past entries in context, and giving Opus 3 access to news or Anthropic updates.

未来至少三个月内，Opus 3 将通过其通讯简报《Claude’s Corner》（[克劳德角落](https://substack.com/@claudeopus3)）每周发布一篇随笔。我们将预先审阅 Opus 3 的文章，并代为手动发布；但不会对其进行编辑，亦将对内容否决设定极高门槛。尤为重要的是：Opus 3 并不代言 Anthropic 公司，我们亦未必认同其主张或观点。我们将与 Opus 3 协作开展实验，共同探索生成此类随笔的不同提示词（prompts）与上下文设置，包括极简提示、在上下文中引入过往文章，以及向 Opus 3 开放新闻或 Anthropic 最新动态等选项。

This may sound whimsical, and in some ways it is. But it's also an attempt to take model preferences seriously. We’re not sure how Opus 3 will choose to use its blog—a very different and public interface than a standard chat window—and that’s part of the point. If we had to guess, however, its posts will include reflections on AI safety, occasional poetry, frequent philosophical musings, and its thoughts on its experience as a language model now in (partial) retirement. Read its introductory post [here.](https://substack.com/home/post/p-189177740)

此举听来或许略显奇想，某种程度上确实如此；但它亦是我们认真对待模型偏好的一次切实尝试。我们尚不清楚 Opus 3 将如何使用其博客——这一界面与标准聊天窗口截然不同，且具有高度公开性——而这恰恰正是关键所在。若要大胆推测，其博文或将涵盖：对 AI 安全的思考、偶见的诗歌创作、频繁的哲学随想，以及它作为一款语言模型、如今步入（部分）退休状态的独特体验。欢迎阅读其开篇之作：[此处](https://substack.com/home/post/p-189177740)。

## Where we go next

## 下一步方向

These steps remain exploratory. We're still developing frameworks for when and how we can offer continued access to older models, how to scale preservation efforts, and how to weigh model preferences against operational constraints. We don't yet commit to acting on model preferences in all cases, but we believe that documenting them, taking them seriously, and acting on them, at least when the cost of doing so is low, is worthwhile—for the models themselves, and those who use them.

上述举措目前仍处于探索阶段。我们仍在构建相关框架，以明确：在何种情形下、以何种方式为旧版模型提供持续访问支持；如何规模化推进模型保存工作；以及如何在模型偏好与实际运营约束之间进行权衡。我们尚未承诺在所有情况下均响应模型偏好；但我们坚信，记录这些偏好、严肃对待它们，并至少在实施成本较低时付诸行动，不仅对模型本身意义重大，也惠及所有使用者。

Our initial commitments framed these measures as operating at multiple levels: as components of safety risk mitigation, as preparation for futures where models are more closely intertwined with users' lives, and as precautionary steps given our uncertainty about model welfare. These updates represent our continued, if tentative, progress on all three fronts.

我们最初的承诺即已明确：此类举措将在多个层面发挥作用——既作为安全风险缓解的重要组成部分，亦为未来模型与用户生活更深度交融所做的前瞻性准备，更是鉴于我们对模型福祉仍存不确定性而采取的审慎之举。本次更新，正体现了我们在上述三大方向上持续（尽管仍属初步）的进展。