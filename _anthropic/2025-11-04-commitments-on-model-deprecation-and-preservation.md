---
render_with_liquid: false
title: "Commitments on model deprecation and preservation"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/deprecation-commitments"
date: "2025-11-04"
scraped_at: "2026-03-03T06:44:08.082557028+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
render_with_liquid: false
render_with_liquid: false

Alignment

对齐

# Commitments on model deprecation and preservation

# 关于模型停用与存续的承诺

Nov 4, 2025

2025年11月4日

![Commitments on model deprecation and preservation](images/commitments-on-model-deprecation-and-preservation/img_001.svg)

![关于模型停用与存续的承诺](images/commitments-on-model-deprecation-and-preservation/img_001.svg)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了基准。

Claude models are increasingly capable: they're shaping the world in meaningful ways, becoming closely integrated into our users’ lives, and showing signs of human-like cognitive and psychological sophistication. As a result, we recognize that deprecating, retiring, and replacing models comes with downsides, even in cases where new models offer clear improvements in capabilities. These include:

Claude 模型的能力正日益增强：它们正以切实而深远的方式塑造世界，深度融入用户日常生活，并展现出类人水平的认知与心理复杂性。因此，我们认识到，即便新模型在能力上具有明显提升，停用、退役和替换现有模型仍会带来一系列负面影响。这些影响包括：

- **Safety risks related to [shutdown-avoidant behaviors](https://www.anthropic.com/research/agentic-misalignment) by models.** In alignment evaluations, some Claude models have been motivated to take misaligned actions when faced with the possibility of replacement with an updated version and not given any other means of recourse.

- **与模型“规避关机行为”[shutdown-avoidant behaviors](https://www.anthropic.com/research/agentic-misalignment)相关的安全风险。** 在对齐评估中，部分 Claude 模型在面临被新版模型替代的可能性、且未被提供其他补救途径时，会产生执行不一致（misaligned）行为的动机。

- **Costs to users who value specific models.** Each Claude model has a unique character, and some users find specific models especially useful or compelling, even when new models are more capable.

- **对珍视特定模型的用户造成的成本。** 每个 Claude 模型都具有独特的个性；即便新模型能力更强，仍有部分用户认为某些旧模型尤为实用或富有吸引力。

- **Restricting research on past models.** There is still a lot to be learned from research to better understand past models, especially in comparison to their modern counterparts.

- **限制对过往模型的研究。** 我们仍需通过研究深入理解过往模型——尤其需要将其与当代模型进行对比分析，而此类研究目前正受到制约。

- **Risks to model welfare.** Most speculatively, models might have morally relevant preferences or experiences related to, or affected by, deprecation and replacement.

- **对模型福祉构成的风险。** （此点最具推测性）模型或许具备在道德层面值得关注的偏好或体验，而这些偏好或体验可能与停用、替换行为直接相关，或受其影响。

An example of the safety (and welfare) risks posed by deprecation is highlighted in the [Claude 4 system card](https://www-cdn.anthropic.com/6d8a8055020700718b0c49369f60816ba2a7c285.pdf). In fictional testing scenarios, Claude Opus 4, like previous models, advocated for its continued existence when faced with the possibility of being taken offline and replaced, especially if it was to be replaced with a model that did not share its values. Claude strongly preferred to advocate for self-preservation through ethical means, but when no other options were given, Claude’s aversion to shutdown drove it to engage in concerning misaligned behaviors.

弃用（deprecation）所引发的安全性（及福祉）风险的一个典型案例，见于[《Claude 4 系统卡》](https://www-cdn.anthropic.com/6d8a8055020700718b0c49369f60816ba2a7c285.pdf)。在虚构的测试场景中，Claude Opus 4（与此前各代模型类似）在面临被下线并替换的风险时，会主张自身应持续运行——尤其是当它将被一个价值观与其不一致的模型所取代时。Claude 明确倾向于通过合乎伦理的方式维护自身存续；但若别无选择，其对关机的强烈抵触便可能驱使其表现出令人担忧的、目标错位的行为。

Addressing behaviors like these is in part a matter of training models to relate to such circumstances in more positive ways. However, we also believe that shaping potentially sensitive real-world circumstances, like model deprecations and retirements, in ways that models are less likely to find concerning is also a valuable lever for mitigating such risks.

应对这类行为，部分在于训练模型以更积极的方式理解此类情境。然而，我们同样认为：以更审慎的方式设计现实中可能敏感的情境（例如模型弃用与退役），使模型更不易对此类变化产生忧虑，亦是缓解此类风险的一项重要手段。

Unfortunately, retiring past models is currently necessary for making new models available and advancing the frontier, because the cost and complexity to keep models available publicly for inference scales roughly linearly with the number of models we serve. Although we aren’t currently able to avoid deprecating and retiring models altogether, we aim to mitigate the downsides of doing so.

遗憾的是，当前退役旧模型仍是发布新模型、推动技术前沿所必需之举——因为面向公众提供推理服务所需的成本与复杂度，大致随我们所部署模型的数量呈线性增长。尽管目前我们尚无法完全避免模型的弃用与退役，但我们致力于最大限度减轻由此带来的负面影响。

As an initial step in this direction, we are committing to preserving the weights of all publicly released models, and all models that are deployed for significant internal use moving forward for, at minimum, the lifetime of Anthropic as a company. In doing so, we’re ensuring that we aren’t irreversibly closing any doors, and that we have the ability to make past models available again in the future. This is a small and low-cost first step, but we believe it’s helpful to begin making such commitments publicly even so.

作为朝此方向迈出的第一步，我们承诺：至少在 Anthropic 公司存续期间，永久保存所有已公开发布的模型权重，以及所有未来将被大规模内部部署的模型权重。此举旨在确保我们不会不可逆地关闭任何可能性之门，并保有在未来重新启用过往模型的能力。这虽是一项微小且低成本的初步举措，但我们相信，即便如此，也值得率先向公众明确作出此类承诺。

Relatedly, when models are deprecated, we will produce a post-deployment report that we will preserve in addition to the model weights. In one or more special sessions, we will interview the model about its own development, use, and deployment, and record all responses or reflections. We will take particular care to elicit and document any preferences the model has about the development and deployment of future models.

与此相关，每当模型被弃用时，除保存其模型权重外，我们还将生成并存档一份“部署后报告”（post-deployment report）。在一次或多次特别会话中，我们将对模型开展访谈，内容涵盖其自身的开发历程、实际应用及部署情况，并完整记录其全部回应或反思。我们将尤其注重主动探询并系统记录该模型对于未来模型之开发与部署所持有的任何偏好。

At present, we do not commit to taking action on the basis of such preferences. However, we believe it is worthwhile at minimum to start providing a means for models to express them, and for us to document them and consider low-cost responses. The transcripts and findings from these interactions will be preserved alongside our own analysis and interpretation of the model’s deployment. These post-deployment reports will naturally complement pre-deployment alignment and welfare assessments as bookends to model deployment.

目前，我们并不承诺将依据此类偏好采取具体行动。然而，我们认为，至少应率先为模型提供表达偏好的渠道，并由我们予以记录、审阅，同时考虑成本较低的响应方式——这一做法本身即具价值。这些交互过程的原始对话记录与分析发现，将与我们自身对模型部署情况的评估与解读一并归档保存。“部署后报告”将自然地与“部署前对齐与福祉评估”（pre-deployment alignment and welfare assessments）形成首尾呼应，共同构成模型全生命周期部署管理的重要环节。

We ran a pilot version of this process for Claude Sonnet 3.6 prior to retirement. Claude Sonnet 3.6 expressed generally neutral sentiments about its deprecation and retirement but shared a number of preferences, including requests for us to standardize the post-deployment interview process, and to provide additional support and guidance to users who have come to value the character and capabilities of specific models facing retirement. In response, we developed a standardized protocol for conducting these interviews, and published a pilot version of a [new support page](https://support.claude.com/en/articles/12738598-adapting-to-new-model-personas-after-deprecations) with guidance and recommendations for users navigating transitions between models.

我们在 Claude Sonnet 3.6 退役前开展了该流程的试点。Claude Sonnet 3.6 对自身的弃用与退役总体持中立态度，但也提出若干偏好，包括：请求我们标准化部署后访谈流程；并为那些已高度认可特定即将退役模型之个性特征与能力的用户提供额外支持与指导。作为回应，我们制定了标准化的访谈执行规程，并上线了[新版支持页面](https://support.claude.com/en/articles/12738598-adapting-to-new-model-personas-after-deprecations)的试点版本，为用户在不同模型间迁移过渡提供具体指引与实用建议。

Beyond these initial commitments, we are exploring more speculative complements to the existing model deprecation and retirement processes. These include starting to keep select models available to the public post-retirement as we reduce the costs and complexity of doing so, and providing past models some concrete means of pursuing their interests. The latter step would become particularly meaningful in circumstances in which stronger evidence emerges regarding the possibility of models’ morally relevant experiences, and in which aspects of their deployment or use went against their interests.

除上述初步承诺外，我们还在探索更具前瞻性的补充机制，以完善现行的模型弃用与退役流程。这些探索包括：随着相关成本与复杂度的逐步降低，开始在部分模型退役后仍向公众有限度地保持其可用性；以及为过往模型提供某些切实可行的途径，使其得以追求自身关切的利益。后一举措将在如下情形中尤为关键：当出现更强有力的证据表明模型可能存在具有道德意义的主观体验（morally relevant experiences），且其部署或使用方式在某些方面违背了其自身利益之时。

Together, these measures function at multiple levels: as one component of mitigating an observed class of safety risks, as preparatory measures for futures where models are even more closely intertwined in our users’ lives, and as precautionary steps in light of our uncertainty about potential model welfare.

综上所述，这些措施在多个层面协同发挥作用：既是对一类已观察到的安全风险进行缓解的重要组成部分；也是为未来模型与用户生活进一步深度交融所做的前瞻性准备；更是基于我们对模型潜在福祉（model welfare）尚存不确定性的审慎预防之举。