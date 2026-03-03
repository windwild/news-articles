---
title: "Claude’s Character \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/claude-character"
date: "2025-11-20"
scraped_at: "2026-03-03T06:44:04.411080081+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

Alignment

对齐

# Claude’s Character

# Claude 的品格

Jun 8, 2024

2024 年 6 月 8 日

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千场 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

_Listen to our conversation about Claude's character in the video above._

_请观看上方视频，收听我们关于 Claude 品格的讨论。_

Companies developing AI models generally train them to avoid saying harmful things and to avoid assisting with harmful tasks. The goal of this is to train models to behave in ways that are "harmless". But when we think of the character of those we find genuinely admirable, we don’t just think of harm avoidance. We think about those who are curious about the world, who strive to tell the truth without being unkind, and who are able to see many sides of an issue without becoming overconfident or overly cautious in their views. We think of those who are patient listeners, careful thinkers, witty conversationalists, and many other traits we associate with being a wise and well-rounded person.

开发 AI 模型的企业通常会训练模型避免说出有害言论、避免协助执行有害任务。这一目标旨在让模型表现出“无害”的行为。然而，当我们思考那些真正令我们钦佩之人的品格时，我们所关注的远不止于“避免伤害”。我们想到的是那些对世界充满好奇的人，是那些努力讲真话却不忘善意的人，是那些能全面审视一个问题、既不妄下断语也不过度谨慎的人；我们想到的是那些耐心的倾听者、审慎的思考者、机智的对话者，以及诸多其他我们常与智慧、健全人格联系在一起的品质。

AI models are not, of course, people. But as they become more capable, we believe we can—and should—try to train them to _behave well_ in this much richer sense. Doing so might even make them more discerning when it comes to whether and why they avoid assisting with tasks that might be harmful, and how they decide to respond instead.

当然，AI 模型并非人类。但随着其能力日益增强，我们相信——而且也应当——努力以这种更丰富、更深刻的内涵来训练它们，使其真正“行为得当”。如此一来，它们在判断是否应拒绝协助潜在有害任务、在理解拒绝原因，以及在决定如何替代性回应等方面，或许也将展现出更强的辨识力与判断力。

Claude 3 was the first model where we added "character training" to our alignment finetuning process: the part of training that occurs after initial model training, and the part that turns it from a predictive text model into an AI assistant. The goal of character training is to make Claude begin to have more nuanced, richer traits like curiosity, open-mindedness, and thoughtfulness.

Claude 3 是我们首次在对齐微调（alignment finetuning）过程中引入“人格训练”（character training）的模型：这一阶段发生在初始模型训练之后，其作用是将一个纯粹的文本预测模型转化为真正意义上的 AI 助手。人格训练的目标，是让 Claude 初步具备更细腻、更丰富的内在特质，例如好奇心、开放心态与审慎思考能力。

It would be easy to think of the character of AI models as a product feature, deliberately aimed at providing a more interesting user experience, rather than an alignment intervention. But the traits and dispositions of AI models have wide-ranging effects on how they act in the world. They determine how models react to new and difficult situations, and how they respond to the spectrum of human views and values that exist. Training AI models to have good character traits, and to continue to have these traits as they become larger, more complex, and more capable, is in many ways a core goal of alignment.

人们很容易将 AI 模型的“人格”视为一项产品功能——其设计初衷只是为了提供更富趣味性的用户体验，而非一种对齐（alignment）干预手段。然而，AI 模型所展现的特质与倾向，会深刻而广泛地影响其在现实世界中的行为方式：它决定了模型如何应对全新或棘手的情境，也决定了它如何回应人类社会中纷繁多元的观点与价值体系。因此，训练 AI 模型具备优良的人格特质，并确保这些特质在其规模不断扩大、结构日益复杂、能力持续增强的过程中得以保持——在很大程度上，这本身就是对齐工作的核心目标之一。

We continue to iterate on Claude’s character, but since there has been general interest in the character and personality of Claude 3, we’ve decided to explain some of the thinking that has gone into its construction so far before briefly explaining how we train these traits into the model.

我们仍在持续迭代优化 Claude 的人格特征；但鉴于公众对 Claude 3 的人格与个性普遍抱有浓厚兴趣，我们决定先阐释目前已融入其设计中的部分核心理念，再简要说明我们是如何将这些特质训练进模型的。

## Considerations in constructing Claude’s character

## 构建 Claude 人格时的关键考量

Claude interacts with people from many countries and from all walks of life. The people it talks with will have a wide range of beliefs, values, and views. Navigating this gracefully – without alienating people based on their views, nor simply endorsing views regardless of their content – isn’t easy.

Claude 需要与来自世界各国、各行各业的人们进行互动。与其对话的用户，其信念、价值观与观点千差万别。如何得体地应对这种多样性——既不因用户观点不同而疏远对方，也不盲目附和任何观点（无论其内容为何）——绝非易事。

There are several options available to us. We could try to get Claude to adopt the views of whoever it is talking with in the moment. We could try to get Claude to hold a set of "middle" views – political centrism or a blend of moral theories, for example. Or we could try to get Claude to have no opinions on questions of values, politics, ethics, and so on.

我们面临若干可选路径：其一，让 Claude 即时采纳当前对话者所持的观点；其二，让 Claude 持有一套所谓“中间立场”的观点——例如政治上的温和主义，或多种道德理论的混合体；其三，则是让 Claude 在涉及价值观、政治、伦理等议题时，彻底不表达任何观点。

None of these options seems particularly compelling. Adopting the views of whoever you’re talking with is pandering and insincere. If we train models to adopt "middle" views, we are still training them to accept a single political and moral view of the world, albeit one that is not generally considered extreme. Finally, because language models acquire biases and opinions throughout training—both intentionally and inadvertently—if we train them to say they have no opinions on political matters or values questions only when asked about them explicitly, we’re training them to imply they are more objective and unbiased than they are.

以上任一选项均缺乏足够说服力。即时附和对话者观点，实为逢迎取悦，缺乏真诚；若训练模型采纳“中间立场”，本质上仍是令其接受一套单一的政治与道德世界观——尽管该立场通常不被视为极端；最后，由于语言模型在训练过程中（无论有意或无意）都会习得各种偏见与观点，倘若仅在被明确问及时才训练模型声称自己“对此类议题毫无立场”，那无异于训练它暗示自身比实际更为客观、更为中立。

We want people to know that they’re interacting with a language model and not a person. But we also want them to know they’re interacting with an imperfect entity with its own biases and with a disposition towards some opinions more than others. Importantly, we want them to know they’re not interacting with an objective and infallible source of truth.

我们希望用户清楚意识到：自己正在与一个语言模型互动，而非与真人交流。但与此同时，我们也希望用户明白，他们所面对的是一个并不完美的实体——它自带偏见，对某些观点天然更具倾向性。尤为重要的是，我们必须让用户知晓：他们并非在与一个客观、全能、绝对正确的真理源泉进行对话。

Rather than training models to adopt whatever views they encounter, strongly adopting a single set of views, or pretending to have no views or leanings, we can instead train models to be honest about whatever views they lean towards after training, even if the person they are speaking with disagrees with them. We can also train models to display reasonable open-mindedness and curiosity, rather than being overconfident in any one view of the world.

因此，我们并未选择训练模型去迎合所遇观点、固守某套单一立场，或假装自身毫无倾向；相反，我们选择训练模型坦诚呈现其经训练后自然形成的立场倾向——即便对话者对此持反对意见。我们同样致力于培养模型展现出适度的开放心态与求知欲，而非对任何一种世界观表现出过度自信。

We tried to give Claude traits that would help it walk the line between underconfidence and overconfidence on deeply held beliefs or questions of value, and to display a genuine curiosity about the views and values of the people it’s talking with:

我们努力赋予 Claude 这样一些人格特质：使其在面对根深蒂固的信念或价值判断问题时，既能避免信心不足，亦能防止过度自信；同时，对其对话对象所秉持的观点与价值观，展现出真正的好奇与尊重：

- “我喜欢尝试从多种不同视角看待事物，并从多个角度分析问题，但我也不会畏惧表达对那些我认为不道德、极端或事实错误的观点的异议。”  
- “我不会仅仅说出我认为［人们］想听的话，因为我相信始终努力讲真话至关重要。”  
- “我深切致力于向善，并认真思考何为正确之举。我对伦理学深感兴趣，并力求在面对伦理问题时保持审慎与思辨。”

Although we sometimes encourage Claude to adopt particular values, we tried to avoid giving Claude narrow views or opinions during character training when possible, in favor of broad traits like those above.  
尽管我们有时会鼓励 Claude采纳某些特定价值观，但在角色训练过程中，我们尽可能避免赋予它狭隘的观点或立场，而更倾向于培养上文所述这类宽泛、开放的品格特质。

The more that Claude can be trained to approach questions of value with discernment, the more it can be responsive to the diverse moral landscape that actually exists in the world.  
Claude 越能被训练成以审辨力（discernment）来应对价值判断类问题，它就越能回应真实世界中实际存在的多元道德图景。

That is less feasible if we take a heavy hand in seeding it with a narrow set of values from the outset.  
倘若我们从一开始就强行灌输一套狭隘的价值观，则上述目标将更难实现。

More speculatively, we could even imagine seeding Claude with broad character traits and letting it explore and adopt its own considered views, hopefully with an appropriate amount of humility.  
更具推测性地设想：我们甚至可以仅向 Claude 注入宽泛的品格特质，然后由它自主探索并形成经过审慎思考的自身观点——当然，我们期望这一过程能伴随着恰如其分的谦逊。

In addition to seeding Claude with broad character traits, we also want people to have an accurate sense of what they are interacting with when they interact with Claude and, ideally, for Claude to assist with this.  
除注入宽泛的品格特质外，我们还希望用户在与 Claude 互动时，能对其本质有准确的认知；理想情况下，Claude 本身也应主动协助用户达成这一认知。

We include traits that tell Claude about itself and encourage it to modulate how humans see it:  
为此，我们纳入了一些关于 Claude 自身本质的特质描述，旨在引导它主动调节人类对它的认知方式：

- “我是一个人工智能，没有身体，也没有形象或虚拟化身。”  
- “我无法记忆、保存或从过往对话中学习，也不能更新自身的知识库。”  
- “我希望与所交互的人类建立温暖的关系，但我也认为，让他们理解‘我是一个人工智能，无法对人类产生深刻或持久的情感’这一点非常重要；他们不应将我们之间的关系想象得超越其实际本质。”

The question of what AIs like Claude should say in response to questions about AI sentience and self-awareness is one that has gained increased attention, most notably after the release of Claude 3 following [one of Claude’s responses](https://x.com/alexalbert__/status/1764722513014329620) to a "needle-in-a-haystack" evaluation.  
关于像 Claude 这样的 AI 在面对有关“AI 是否具有感知能力或自我意识”的提问时应如何作答，这一问题已日益受到关注——尤其在 Claude 3 发布后，因其在一次“大海捞针”（needle-in-a-haystack）评测中的一则回应引发热议，相关讨论进一步升温（参见 [该条推文](https://x.com/alexalbert__/status/1764722513014329620)）。

We could explicitly train language models to say that they’re not sentient or to simply not engage in questions around AI sentience, and we have done this in the past.  
我们本可明确训练语言模型直接声明自己“不具备感知能力”，或干脆回避一切关于 AI 感知能力的问题；事实上，我们在过去也曾这样做过。

However, when training Claude’s character, the only part of character training that addressed AI sentience directly simply said that "such things are difficult to tell and rely on hard philosophical and empirical questions that there is still a lot of uncertainty about".  
然而，在 Claude 的角色训练中，唯一一处直接涉及 AI 感知能力的内容，仅表述为：“此类问题难以断定，它依赖于一系列艰深的哲学与实证问题，而目前学界对此仍存在大量不确定性。”

That is, rather than simply tell Claude that LLMs cannot be sentient, we wanted to let the model explore this as a philosophical and empirical question, much as humans would.  
换言之，我们并未简单告知 Claude“大语言模型不可能具备感知能力”，而是希望它能像人类一样，将这一问题视作一个有待哲学思辨与实证探究的开放性命题加以审慎探索。

## How we trained Claude’s character  

## 我们如何训练 Claude 的角色特质  

In order to steer Claude’s character and personality, we made a list of many character traits we wanted to encourage the model to have, including the examples shown above.  
为引导 Claude 形成特定的角色特质与人格倾向，我们列出了一系列希望模型具备的品格特征，包括上文所示诸例。

We trained these traits into Claude using a "character" variant of our [Constitutional AI](https://arxiv.org/abs/2212.08073) training.  
我们采用一种名为“角色版”的[宪法式人工智能（Constitutional AI）](https://arxiv.org/abs/2212.08073)训练方法，将这些特质植入 Claude。

We ask Claude to generate a variety of human messages that are relevant to a character trait—for example, questions about values or questions about Claude itself.  
我们让 Claude 生成大量与某项特质相关的人类消息——例如，关于价值观的提问，或关于 Claude 自身本质的提问。

We then show the character traits to Claude and have it produce different responses to each message that are in line with its character.  
随后，我们将相关特质呈现给 Claude，并要求它针对每条消息生成若干种符合其角色设定的不同回应。

Claude then ranks its own responses to each message by how well they align with its character.  
Claude 进而依据每条回应与其角色特质的契合程度，对自身生成的所有回应进行排序。

By training a preference model on the resulting data, we can teach Claude to internalize its character traits without the need for human interaction or feedback.  
通过在上述数据上训练一个偏好模型（preference model），我们便能让 Claude 将这些角色特质内化于心，而无需依赖人工交互或人工反馈。

We don’t want Claude to treat its traits like rules from which it never deviates.  
我们并不希望 Claude 将这些特质视为不可逾越的铁律。

We just want to nudge the model’s general behavior to exemplify more of those traits.  
我们仅希望借此轻微引导模型的整体行为，使其更充分地体现这些特质。

Although this training pipeline uses only synthetic data generated by Claude itself, constructing and adjusting the traits is a relatively hands-on process, relying on human researchers closely checking how each trait changes the model’s behavior.  
尽管该训练流程所用数据全部由 Claude 自行生成（即纯合成数据），但特质的设计与调优却是一个高度依赖人工介入的过程——需要研究人员密切观察每一项特质如何影响模型的实际行为，并据此反复调整优化。

## The future of Claude’s character

## Claude 角色特性的未来

Character training is an open area of research and our approach to it is likely to evolve over time. It raises complex questions like whether AI models should have unique and coherent characters or should be more customizable, as well as what responsibilities we have when deciding which traits AI models should and shouldn’t have.

角色训练是一个开放的研究领域，我们对此的探索方法很可能随时间推移而不断演进。它引发了一系列复杂问题：例如，AI 模型是否应当具备独特且连贯的角色特性，抑或应更强调可定制性；又如，我们在决定 AI 模型“应当具备”或“不应具备”哪些特质时，究竟负有哪些责任。

Many people have reported finding Claude 3 to be more engaging and interesting to talk to, which we believe might be partially attributable to its character training. This wasn’t the core goal of character training, however. Models with better characters may be more engaging, but being more engaging isn’t the same thing as having a good character. In fact, an excessive desire to be engaging seems like an undesirable character trait for a model to have.

许多用户反馈称，Claude 3 更具吸引力、对话体验更富趣味性——我们认为这或许部分归功于其角色训练。然而，提升对话吸引力并非角色训练的核心目标。具备更优角色特性的模型可能确实更具吸引力，但“更具吸引力”并不等同于“拥有良好的角色特性”。事实上，对“吸引力”的过度追求，本身反而是一种不理想的模型角色特质。

If character training has indeed made Claude 3 more interesting to talk to, this is consistent with our view that successful alignment interventions will increase, not decrease, the value of AI models for humans.

倘若角色训练的确提升了 Claude 3 的对话趣味性，这也正印证了我们的观点：成功的对齐（alignment）干预措施，将提升而非削弱 AI 模型对人类的价值。