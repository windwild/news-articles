---
title: "Beyond Text: Making GenAI Applications Accessible to All"
source: "LangChain Blog"
url: "https://blog.langchain.com/beyond-text-making-genai-applications-accessible-to-all/"
date: "2023-10-23"
scraped_at: "2026-03-03T08:32:56.863827267+00:00"
language: "en-zh"
translated: true
---

_Editor's Note: This post was written by [_Andres Torres_](https://www.linkedin.com/in/andres-torres-360248b1/?ref=blog.langchain.com) and [_Dylan Brock_](https://www.linkedin.com/in/dylan-brock-b8926760/?ref=blog.langchain.com) from [_Norwegian Cruise Line_](https://www.ncl.com/?ref=blog.langchain.com). Building UI/UX for AI applications is hard and there's lot of subtleties. This is a fantastic deep dive into the issues and concerns they are thinking about._

编辑注：本文由挪威邮轮公司（[_Norwegian Cruise Line_](https://www.ncl.com/?ref=blog.langchain.com)）的 [_Andres Torres_](https://www.linkedin.com/in/andres-torres-360248b1/?ref=blog.langchain.com) 和 [_Dylan Brock_](https://www.linkedin.com/in/dylan-brock-b8926760/?ref=blog.langchain.com) 撰写。为 AI 应用构建用户界面（UI）与用户体验（UX）极具挑战性，其中存在大量细微而关键的考量。本文正是对这些实际问题与设计关切的一次精彩而深入的剖析。

Everyone loves having some vacation and time to enjoy with their loved ones. At Norwegian Cruise Line, our team mission is to provide exceptional vacation experiences through a commitment to world-class hospitality and innovation. This experience starts with their first digital touch point and extends all the way past their disembark date. It’s imperative that we create a seamless and enjoyable planning experience.

每个人都渴望假期，渴望与所爱之人共度美好时光。在挪威邮轮公司，我们团队的使命是通过践行世界级的待客之道与持续创新，为宾客提供卓越的度假体验。这一体验始于宾客首次接触我们的数字触点，并延续至其下船之后。因此，打造无缝、愉悦的行程规划体验，对我们而言至关重要。

Our team believes that GenAI will make it easier for our guests to build and plan their dream vacation. In developing our vision, it became clear how sizable the gap is between those comfortable with AI applications and our average consumer. Most of the GenAI products in the marketplace are not built to inspire and immerse their consumers. Our guests won’t accept that. So, we made a focal point of our journey about bridging the gap between traditional LLM user interfaces and immersive, easy to use, and capable experiences. The following outlines many of the UX/UI lessons we’ve learned along the way. These are easily replicated and can help with nearly any use case seeking to leverage LLMs. In future posts, we will do a deeper dive into just how we integrate our UX/UI using Langchain and how you can make it work for your use case.

我们的团队相信，生成式 AI（GenAI）将让宾客更轻松地构建并规划他们梦想中的假期。在构想这一愿景的过程中，我们愈发清晰地意识到：熟悉 AI 应用的用户群体，与我们广大普通消费者之间，存在着显著的认知与能力鸿沟。当前市面上大多数 GenAI 产品，并未以激发用户兴趣、营造沉浸感为目标进行设计；而我们的宾客绝不会接受这种体验。因此，“弥合传统大语言模型（LLM）用户界面与沉浸式、易用且功能强大的体验之间的差距”，成为我们整个产品旅程的核心焦点。下文将系统梳理我们在实践中积累的诸多 UX/UI 经验与教训。这些策略易于复现，可广泛适用于各类希望借助 LLM 技术的场景。在后续文章中，我们将深入探讨：如何利用 LangChain 实现 UX/UI 的深度集成，以及您如何将其适配到自身具体用例中。

### **Introduction**

### **引言**

It is hard to discuss GenAI applications and not picture a chat-based UI. The general population is extremely comfortable with chat bubbles through text messaging, service agents, and work-collaboration applications. This format remains the quickest UX path today. Booking.com, ChatGPT, Bard, etc., all use some form of basic chat window.

谈及生成式 AI（GenAI）应用，人们脑海中几乎总会浮现出基于聊天对话的用户界面（UI）。得益于短信、客服机器人及办公协作工具等日常应用，大众早已对气泡式对话界面习以为常。时至今日，这种形式仍是实现高效用户体验（UX）的最快路径。Booking.com、ChatGPT、Bard 等产品，均采用了某种基础形态的聊天窗口。

But LLMs are not yet replacements for the personal touch of true human interaction. They tend to overexplain, creating a completely different experience from traditional service agents. So, if GenAI is the next great paradigm shift in digital interactions, it is crucial to solve for the UX/UI. Consumers reject complexity, even in the face of evolution. By nature, LLMs require reading and writing. Until we can advance the integration between LLM output and traditional UX interaction, the majority of your users will fall into the “stuck” zones.

但大语言模型（LLM）尚无法真正替代真实人际互动中那种富有温度的个性化服务。它们往往倾向于过度解释，从而创造出一种与传统人工客服截然不同的交互体验。因此，倘若 GenAI 确实代表着数字交互领域的下一次重大范式变革，那么 UX/UI 的设计优化就尤为关键。消费者天然排斥复杂性——即便技术本身正在演进亦是如此。而 LLM 本质上依赖读写交互；在我们将 LLM 输出与传统 UX 交互方式深度融合之前，绝大多数用户仍会陷入“卡顿”或“不知所措”的困境。

![](images/beyond-text-making-genai-applications-accessible-to-all/img_001.png)

![](images/beyond-text-making-genai-applications-accessible-to-all/img_001.png)

Furthermore, utilizing prompting as our primary interaction method relies on the customer to get it right. This path reduces development effort at the sacrifice of adoption and accessibility. In the early stages of advancement this was widely acceptable. ChatGPT was used by everyone but has since seen a steady decline. It’s not as if the model is somehow producing extra errors. The newness has worn off, and users feel more like, “OK, but what’s next?”. The outlook becomes even more troubling when you consider [literacy rates are in decline.](https://www.npr.org/2023/06/22/1183653578/u-s-reading-and-math-scores-drop-to-their-lowest-levels-in-decades?ref=blog.langchain.com) How can such a complex product that requires reading and writing at higher levels than standard web practice become the next great revolution?

此外，若将“提示词输入（prompting）”作为主要交互方式，则意味着成败很大程度上取决于用户能否准确表达需求。这种路径虽降低了开发投入，却以牺牲产品普及率与可访问性为代价。在技术发展的早期阶段，这种取舍尚可被广泛接受：ChatGPT 曾风靡一时，但使用热度已呈现持续下滑趋势。这并非因为模型错误率上升，而是“新鲜感”已然消退，用户心态正悄然转向：“好吧，那接下来呢？” 更令人担忧的是，[美国民众读写能力正持续下降](https://www.npr.org/2023/06/22/1183653578/u-s-reading-and-math-scores-drop-to-their-lowest-levels-in-decades?ref=blog.langchain.com)。一个比常规网页应用对读写能力要求更高、更为复杂的产物，又怎能成为下一场伟大的技术革命？

This post outlines a few UX strategies to help empower your users and bridge the gap between standard UX and LLM interfaces. None of these will break your roadmap in terms of effort, but they can go a long way in creating a more accessible, usable product. We will cover:

本文将介绍若干 UX 设计策略，旨在赋能用户，弥合标准用户体验与 LLM 交互界面之间的鸿沟。这些策略均无需大幅调整您的开发路线图，却能显著提升产品的可访问性与可用性。我们将涵盖以下内容：

- Helping your users get up to speed faster  
- 帮助用户更快上手

- Accounting for Anthropomorphism  
- 应对拟人化倾向（Anthropomorphism）

- User Feedback and testing  
- 用户反馈与测试

### **Preventing the Blank Canvas Problem**

### **防止“空白画布”问题**

The art world has a well-known concept of a blank canvas. Picture an artist with an empty easel, endlessly wondering where or how to start. The canvas will feel different for different artists. It can represent fear of the unknown or endless, infinite, possibilities. How an artist feels about the canvas will depend on factors such as skill set, experience, environment, intention, deadlines, or expectations. Users attempting to engage with a chat tool will feel like these artists. A blank canvas with unlimited possibilities, one that feels either impossible to start or exciting and rewarding.

艺术界有一个广为人知的概念——“空白画布”。试想一位艺术家站在空荡荡的画架前，反复思索：该从何处下笔？又该如何开始？对不同艺术家而言，“画布”的感受各不相同：它可能象征着对未知的恐惧，也可能代表着无穷无尽、浩瀚无垠的可能性。艺术家对画布的感受，取决于其技能水平、经验积累、所处环境、创作意图、截止期限或外界期待等因素。当普通用户尝试使用一款聊天工具时，也会产生类似的感受——面对一块充满无限可能的“空白画布”，既可能因无从下手而望而却步，也可能因跃跃欲试而倍感兴奋与满足。

How can we increase comfortability and reduce the barrier to entry for the average user? We believe the best way to account for this is via shortcuts or recommendations. When building these shortcuts, there are a few factors to consider:

我们如何提升普通用户的使用舒适度、降低入门门槛？我们认为，最有效的应对方式是提供快捷入口（shortcuts）或智能推荐。在设计这些快捷入口时，需重点考虑以下几点：

- Keep the Prompts Short and friendly  
- Embed the shortcuts  
- Make it one-click  

- 提示语应简短友好  
- 将快捷入口嵌入主界面  
- 实现一键触发  

**Keep the Prompts Short and Friendly**

**提示语应简短友好**

When shortcuts are presented in traditional call-to-action buttons, the gap between conventional UX and natural language interactions is bridged. The prompts must be written in the most friendly language possible. Think “Debug my Python code” vs. “Using the below input, review and debug the Python code to improve quality”. Google does a phenomenal job of this in their latest version of Bard.

当快捷入口以传统行动号召（call-to-action）按钮形式呈现时，便能有效弥合常规用户界面（UX）与自然语言交互之间的鸿沟。提示语必须采用尽可能亲切、自然的语言风格。例如：“调试我的 Python 代码”就远比“请基于下方输入，审阅并调试该 Python 代码以提升质量”更简洁友好。Google 在其最新版 Bard 中对此做了极为出色的实践。

![](images/beyond-text-making-genai-applications-accessible-to-all/img_002.png)

![](images/beyond-text-making-genai-applications-accessible-to-all/img_002.png)

Bard is designed to be capable of nearly anything. Through this shortcut process, we can avoid the blank canvas issue. Both generic and advanced users can learn just enough from the three categories, all of which are written in short format. Consider why users would want to use your tool when designing for your use case. Go beyond the confines of the regular web UX, and use illustrative words like “imagine”, “dream”, and “engage” to pull the user's mind into the power of natural language.

Bard 被设计为几乎无所不能。借助此类快捷入口机制，我们便可有效规避“空白画布”问题。无论普通用户还是资深用户，都能通过三个简洁明了的分类快速掌握核心功能。在针对具体应用场景进行设计时，请深入思考：用户究竟为何要选择并使用你的工具？切勿拘泥于传统网页界面的设计范式；不妨大胆运用富有画面感与感染力的词汇——如“想象（imagine）”、“梦想（dream）”、“互动（engage）”——将用户的思维自然引导至自然语言所蕴含的强大能力之中。

**Embed the Shortcuts**

**将快捷入口嵌入主界面**

Embedding the components in the same area as the prompt input and output helps orient the user to the end experience. In line components keep the user focused on capabilities over the endless unknown. It helps maintain the separation of value created by the tool (responses in the window), and the input from the user.

将快捷入口组件与提示输入框及输出区域置于同一视觉区域内，有助于用户快速建立对最终交互体验的整体认知。内联式（in-line）组件可引导用户聚焦于工具的实际能力，而非陷入对“无限未知”的焦虑。此举亦有助于清晰区分工具所创造的价值（即窗口中呈现的响应内容）与用户主动提供的输入信息。

**Make it One Click**

**一键即达**

Regardless of the level of your temperature, or the tightness of your system prompt, there exists a degree of randomness to any response. Embedding shortcuts as a one-click experience is the fastest way to improve your users' skills. A user clicking the shortcuts will send a pre-defined prompt to the LLM. This creates more deterministic experiences.

无论你设置的温度（temperature）值高低，抑或系统提示（system prompt）多么严格，任何大语言模型（LLM）的输出始终存在一定随机性。将快捷指令设计为“一键式”交互，是提升用户使用能力最快捷的方式。当用户点击快捷按钮时，系统会自动向大语言模型发送一条预定义的提示词（prompt），从而显著增强响应结果的确定性与可预期性。

Your designers can explicitly account for these scenarios in unique ways. For example, a call-to-action "Show me a code snippet" leaves a lot of room for context interpretation, "what code language?", "a code snippet for what?", etc. If this call-to-action was part of a GenAI solution to help web developers build quick UIs in React, the user would expect a specific context-aware response from the assistant. While the title of the call-to-action could stay the same, "Show me a code snippet," the prompt that is executed behind the scenes could be more complex. The prompt can provide more context to the agent, ensuring the experience matches and delivers value to the user:

设计师可针对此类场景进行专门而富有创意的设计。例如，行动号召语（call-to-action）“给我一个代码片段”本身留有大量解释空间：“什么编程语言？”“哪一类功能的代码片段？”等等。若该按钮属于一款面向 Web 开发者的生成式 AI（GenAI）工具，旨在帮助其快速构建 React UI 组件，则用户自然期望助手能基于上下文给出精准、专业的回应。此时，按钮表面文案可保持不变——仍为“给我一个代码片段”，但后台实际执行的提示词却可以更丰富、更具针对性。通过在提示词中注入更多上下文信息，我们能确保助手输出真正契合用户需求、具备实用价值的结果：

"You are an expert React JS developer who creates beautiful UIs. Show a snippet of code for a UI component following Material Guidelines. Make sure the component can be reused in different settings. Suggest the user for alternative versions of the component."

“你是一位精通 React JS 的资深前端开发专家，擅长打造美观、现代的用户界面。请提供一个遵循 Material Design 规范的 UI 组件代码片段；该组件需具备良好的可复用性，适用于多种不同场景；同时，请为用户提供该组件的其他可选变体建议。”

We recommend utilizing these shortcuts as fast mini-tutorials. An average user will acclimate to the new UX paradigm much faster when shown what their effort rewards.

我们建议将这些快捷指令作为轻量级、高效率的微型教程来使用。当用户能直观看到自身操作所获得的具体回报时，他们将更快适应全新的用户体验范式。

### **The Human Touch: Exploring Anthropomorphism in GenAI Interfaces**

### **人性温度：探索生成式 AI 界面中的拟人化设计**

The majority of GenAI applications make it seem like the user can openly converse with it. This causes users to attribute human-like qualities, characteristics, or emotions to the application. This is called Anthropomorphism.

当前绝大多数生成式 AI 应用都刻意营造出一种“用户可与其自由对话”的表象，这容易促使用户将人类才具备的特质、性格乃至情绪投射到应用之上。这种心理现象被称为“拟人化”（Anthropomorphism）。

To borrow concepts from Don Norman's book *The Design of Everyday Things*, we must ensure that our system signifiers match its affordances. This means that the application must clearly communicate what it can do.

借用唐·诺曼（Don Norman）在《设计心理学》（*The Design of Everyday Things*）一书中提出的概念：我们必须确保系统的“示意符”（signifiers）与其真实“可供性”（affordances）相匹配。换言之，应用必须清晰传达它真正具备的能力边界。

Since users are already susceptible to anthropomorphizing chat systems, adding characteristics that reinforce this human persona (name, avatar, empathy, etc.) might be signifying capabilities our system will not perform. This will frustrate users when they realize their expectations are falling short.

由于用户本就倾向于对聊天系统进行拟人化解读，若我们进一步添加强化“人类形象”的元素（如命名、头像、共情表达等），反而可能暗示出系统实际并不具备的能力。一旦用户意识到自己的期待落空，便极易产生挫败感。

Anthropomorphism is not an absolute. There are various shades of grey we must apply to signify the right affordances and set the correct expectations for our users. The name, avatar, pronouns it uses, personality traits, and communication style can be combined to make it more human or machine-like. These characteristics must match closely with what the system can do. The more human-like, the more the user will believe the system is, in fact, a human and will expect it to behave as such (know current events, weather, contextual information, be empathic, fewer errors, etc.)

拟人化并非非黑即白的二元选择；它是一系列细腻的灰度光谱。我们需要审慎权衡，借助名称、头像、代词选择、人格特质及沟通风格等多重维度的组合，精准调节其“人性化”程度——既可更贴近人类，也可更凸显机器本质。所有这些表征特征，都必须与系统真实能力高度一致。越是呈现得像人类，用户就越可能将其视作真实的人类，并随之产生相应期待：比如了解实时新闻与天气、理解复杂上下文、展现共情能力、极少出错等等。

### **The Value of User Feedback in GenAI: A Win-Win for Users and Designers**

### **生成式 AI 中用户反馈的价值：用户与设计师的双赢**

When designing a high-quality user experience, constant feedback and iteration are necessary to build a high-quality digital platform. With the young nature of LLM-based interfaces, the silver bullet has yet to be discovered. This means we have a due diligence to test and test and test, until we find a reliable method. [Paul Thomson does a great job writing about this in another Langsmith blog post](https://blog.langchain.com/peering-into-the-soul-of-ai-decision-making-with-langsmith/) where you can see how this is like evaluating the quality, accuracy or relevancy of our LLMs. We don’t know what we don’t know, and we require our users to help us figure that out.

在设计高质量用户体验时，持续获取反馈并反复迭代，是构建高质量数字平台的必要条件。由于基于大语言模型（LLM）的界面尚处于发展早期，目前尚未发现“银弹”式解决方案。这意味着我们必须尽职尽责地反复测试、再测试、再再测试，直至找到一种可靠的方法。[Paul Thomson 在另一篇 Langsmith 博客文章中对此做了精彩阐述](https://blog.langchain.com/peering-into-the-soul-of-ai-decision-making-with-langsmith/)，文中指出，这一过程类似于评估我们 LLM 的质量、准确性或相关性。我们无法预知自己尚未意识到的问题，因此必须依靠用户帮助我们识别和厘清这些盲区。

Integrating a feedback system into the LLM must be seamless and easily accessible for the users. The benefit of LLMs over traditional UX is your feedback loop, “we got your feedback, and we’re implementing it,” can be immediate. If you don’t like the response, or the answer is just wrong, you can correct the agent and trigger an automatic re-try. If the response is too wordy, short, contrived, or ineffectively formatted, the user can respond in both natural language and traditional UX buttons to signal this.

将反馈系统集成到 LLM 中，必须做到无缝且对用户高度易用。相比传统 UX，LLM 的一大优势在于其反馈闭环——“我们已收到您的反馈，并正在落实”——可以即时实现。如果您不喜欢当前回复，或答案明显错误，您可直接修正代理输出，并触发自动重试；若回复过于冗长、简短、生硬或格式低效，用户既可用自然语言表达意见，也可通过传统 UX 按钮（如“太长了”“不够详细”等）快速反馈。

There are many ways to provide feedback to the system. We break these down into two forms: **direct** and **indirect**.

向系统提供反馈的方式多种多样。我们将其划分为两类：**直接反馈**与**间接反馈**。

Direct feedback requires formal input from the user with the intention of improving the product. ChatGPT gives the user a thumbs up or down when providing an output. The user knows what it means to interact with these buttons and does so with intent. Indirect, however, operates more in the grey. Users don't intentionally provide feedback. Instead, feedback is provided through the UX design. Examples such as accepting a suggestion on Github Copilot or selecting a generated image in Midjourney before being able to download it both provide us with successful feedback that the model makes a good recommendation.

直接反馈要求用户以明确改进产品为目的，进行正式输入。例如 ChatGPT 在每次输出后为用户提供“点赞”或“点踩”按钮；用户清楚这些按钮的含义，并有意识地使用它们。而间接反馈则更模糊、更隐性——用户并非有意提供反馈，而是通过交互行为本身传递信号。例如，在 GitHub Copilot 中采纳某条代码建议，或在 Midjourney 中选择一张生成图像后才可下载，这些行为都构成了一种成功的间接反馈，表明模型的推荐是有效的。

It's essential to try a variety of options. The more badass the user, the more likely they will give you specific natural language feedback. For the public, it’s vital to account for one-click feedback buttons.

务必尝试多种反馈机制。用户能力越强（即“越资深”），越可能给出具体、详尽的自然语言反馈；而面向大众用户时，则必须优先考虑一键式反馈按钮的设计。

We recommend starting with something, even if you’re unsure what the final list will look like. Feedback is better than none, and you will see quickly what you are missing. Utilizing Langsmith’s evaluation capabilities, you can see immediately how the LLM is being asked to improve and what new feedback mechanisms you need to include.

我们建议哪怕尚不明确最终方案，也应先从某个简单机制起步。有反馈总比没有强，而且您很快就能发现当前缺失的关键环节。借助 Langsmith 的评估能力，您可以即时洞察 LLM 正在被要求改进的方向，以及还需补充哪些新的反馈机制。

### **In Conclusion**

### **结语**

The paradigm shift in digital UX/UI is upon us. As technology advances and more and more consumers are faced with GenAI applications, the responsibility of designers to account for the unknown paths grows. Consumers need our help to bridge the gap between “Wow, this is cool” and “I seek it out and can’t live without it”. As it’s our job to make this happen, we can empower our users by setting the right expectations, creating feedback mechanisms, and embedding shortcuts. These are not exhaustive and guarantees. As the industry experiments with new and innovative ways to form inputs and outputs, we will constantly revisit how we set up these mechanisms.

数字 UX/UI 的范式变革已然到来。随着技术演进，越来越多消费者正直面生成式 AI 应用，设计师应对未知路径的责任也随之加重。用户需要我们的协助，才能跨越从“哇，这真酷！”到“我主动寻找它，已离不开它”的鸿沟。既然这是我们的使命，我们就可通过设定合理预期、构建反馈机制、嵌入快捷操作等方式，真正赋能用户。上述方法并非穷尽所有可能，亦非万全保障。随着行业不断探索输入与输出形式的新颖、创新路径，我们也将持续审视并优化这些机制的设计方式。

If you like this blog, drop us a line and let us know! This is only the beginning of our deeper dive into Large Language Model User Interfaces.

如果您喜欢本文，请随时联系我们并告诉我们！这只是我们深入探讨大语言模型用户界面（LLM UI）的起点。