---
render_with_liquid: false
title: "The Hidden Metric That Determines AI Product Success"
source: "LangChain Blog"
url: "https://blog.langchain.com/the-hidden-metric-that-determines-ai-product-success/"
date: "2025-06-12"
scraped_at: "2026-03-03T07:30:29.963206496+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes"]
---
render_with_liquid: false
render_with_liquid: false

_Co-authored by Assaf Elovic and Harrison Chase. You can also find a version of this post_ [_published on Assaf's Medium_](https://medium.com/@assafelovic/the-hidden-metric-that-determines-ai-product-success-799a98fd57aa?ref=blog.langchain.com) _._

由 Assaf Elovic 与 Harrison Chase 联合撰写。您也可以在 [_Assaf 的 Medium 博客_](https://medium.com/@assafelovic/the-hidden-metric-that-determines-ai-product-success-799a98fd57aa?ref=blog.langchain.com) 上阅读本文的另一版本。

Why do some AI products explode in adoption while others struggle to gain traction? After a decade of building AI products and watching hundreds of launches across the industry, we’ve noticed a pattern that has almost nothing to do with model accuracy or technical sophistication.

为何某些 AI 产品能迅速获得大规模采用，而另一些却举步维艰？在历经十年 AI 产品研发，并持续观察行业数百次产品发布后，我们发现了一个规律——它几乎与模型准确率或技术复杂度无关。

The difference comes down to what we call **“CAIR” — Confidence in AI Results**. This psychological factor can actually be measured, predicted, and optimized for. It’s not just another vanity metric. It’s the hidden variable that determines whether your AI product will succeed or fail, regardless of how impressive your underlying technology is.

这一差异归结为我们所称的 **“CAIR”——用户对 AI 结果的信心（Confidence in AI Results）**。这一心理因素实际上可被量化、预测并针对性优化。它绝非又一个华而不实的指标，而是决定 AI 产品成败的关键隐性变量——无论您的底层技术多么出色，若 CAIR 不足，产品仍难成功。

# Understanding user adoption barriers

# 理解用户采用障碍

Adoption is fundamentally blocked by fear. For maximum adoption, you want low fear and high confidence. We need a metric for this confidence that we can optimize for. That’s where CAIR comes in.

用户采用的根本阻碍在于恐惧。要实现最大化的采用率，就需要低恐惧、高信心。因此，我们必须建立一个可量化、可优化的“信心”指标——这正是 CAIR 的价值所在。

CAIR measures user confidence through a simple relationship that balances the value users get against the psychological barriers they face:

CAIR 通过一个简洁的关系式来衡量用户信心，该式在用户所获价值与所面临心理障碍之间取得平衡：

![](images/the-hidden-metric-that-determines-ai-product-success/img_001.png)CAIR Metric

![](images/the-hidden-metric-that-determines-ai-product-success/img_001.png)CAIR 指标

The equation makes intuitive sense:

该公式符合直觉：

- **Value**: The benefit users get when AI succeeds  
- **Value（价值）**：AI 成功时用户获得的收益  

- **Risk**: The consequence if the AI makes an error  
- **Risk（风险）**：AI 出错时带来的后果  

- **Correction**: The effort required to fix AI mistakes  
- **Correction（修正成本）**：修复 AI 错误所需付出的努力  

When CAIR is high, users embrace AI features enthusiastically. When CAIR is low, adoption stalls no matter how technically impressive your AI is.

当 CAIR 值较高时，用户会热情接纳 AI 功能；而当 CAIR 值偏低时，无论您的 AI 技术多么先进，采用进程都将陷入停滞。

**CAIR is primarily determined by product design decisions, not just the underlying AI capabilities.**

**CAIR 主要取决于产品设计决策，而不仅仅是底层 AI 能力。**

Of course, probability of success matters — if your AI fails most of the time, no amount of clever product design will save you. Success probability is already baked into the Value component of our equation. When AI fails, users get zero value, which tanks CAIR naturally. More importantly, we’re focusing on the variables you can actually control as a product team. Model accuracy improves over time as AI vendors ship better models, but the product design decisions that determine Risk and Correction effort? Those are entirely in your hands, and they’re what separate successful AI products from failed ones using identical underlying technology.

当然，成功率至关重要——如果你的 AI 大多数时候都失败，再精巧的产品设计也救不了你。成功率已内化于我们公式中的“价值（Value）”分量中。当 AI 失败时，用户获得的价值为零，CAIR 自然会急剧下降。更重要的是，我们聚焦于产品团队真正能够掌控的变量。模型准确率会随着 AI 供应商持续发布更优模型而逐步提升；但决定“风险（Risk）”和“修正成本（Correction effort）”的产品设计决策？这些完全掌握在你手中，也正是这些设计选择，让采用相同底层技术的 AI 产品走向成功或失败。

# Why Cursor conquered coding

# 为何 Cursor 征服了编程领域

Consider [Cursor](https://www.cursor.com/?ref=blog.langchain.com), the AI-powered code editor that’s taken the developer world by storm. In theory, code generation should create low confidence — incorrect code could crash systems serving millions of users. Yet Cursor has seen explosive growth because it’s engineered an experience where confidence approaches maximum.

让我们来看 [Cursor](https://www.cursor.com/?ref=blog.langchain.com)——这款由 AI 驱动的代码编辑器，正以雷霆之势席卷开发者世界。理论上，代码生成本应带来较低的信心——错误的代码可能导致服务数百万用户的系统崩溃。然而 Cursor 却实现了爆发式增长，因为它精心打造了一种让用户信心趋近于极致的使用体验。

![](images/the-hidden-metric-that-determines-ai-product-success/img_002.png)Cursor AI IDE

![](images/the-hidden-metric-that-determines-ai-product-success/img_002.png)Cursor AI 集成开发环境（IDE）

Let’s apply our equation to Cursor using a simple High/Medium/Low scale:

下面我们用简化的“高/中/低”三级标度，将我们的公式应用于 Cursor：

- **Risk**: Low — Code is generated locally in a safe environment, never touching production systems  
- **风险（Risk）**：低——代码在本地安全环境中生成，从不接触生产系统  

- **Correction**: Low — You simply delete the suggestion and write it yourself  
- **修正成本（Correction）**：低——你只需删除建议内容，自行重写即可  

- **Value**: High — Hours of saved coding time and mental effort  
- **价值（Value）**：高——节省数小时编码时间与大量脑力消耗  

**CAIR = High ÷ (Low × Low) = Very High**

**CAIR = 高 ÷（低 × 低） = 极高**

This is the product design genius of Cursor. Imagine if they had designed the product to automatically commit generated code to production systems. The Risk would skyrocket to High, but Correction could still remain Low/Mid if they enabled easy rollbacks through version control. Even in this high-stakes scenario, the low correction effort would still yield reasonably high CAIR because while the stakes are high, recovery is easy.

这正是 Cursor 产品设计的精妙之处。试想，如果他们将产品设计为自动生成并自动提交代码至生产系统，那么“风险（Risk）”将飙升至“高”，但只要通过版本控制支持便捷回滚，“修正成本（Correction）”仍可维持在“低/中”水平。即便在这种高风险场景下，较低的修正成本仍能带来相对较高的 CAIR——因为尽管后果严重，恢复却十分容易。

However, if the system lacked easy rollbacks, both Risk and Correction would become High, completely changing the equation:

然而，倘若系统缺乏便捷的回滚机制，那么“风险（Risk）”与“修正成本（Correction）”都将变为“高”，整个公式的平衡将彻底改变：

**Alternative Design CAIR = High ÷ (High × High) = Low**

**替代设计方案：CAIR = 高 ÷（高 × 高）= 低**

That dramatic decrease in confidence would likely kill adoption, even with identical AI model quality. This illustrates why CAIR is fundamentally about product experience, not just technology capability, and why the separation of Risk and Correction effort allows for more nuanced product design decisions.

即便 AI 模型质量完全相同，这种信心的急剧下降也极可能导致产品被用户弃用。这正说明了：CAIR 的本质在于产品体验，而不仅关乎技术能力；同时，将“风险（Risk）”与“修正难度（Correction）”两个维度解耦，有助于做出更精细、更富弹性的产品设计决策。

Creative writing tools like Jasper follow the same pattern. They position AI as a collaborative partner rather than an autonomous creator, keeping CAIR high by ensuring users retain editorial control.

以 Jasper 等创意写作工具为例，它们遵循同样的设计逻辑：将 AI 定位为协作伙伴，而非独立创作者；通过确保用户始终掌握编辑主导权，从而维持较高的 CAIR 值。

# The mid-CAIR opportunity: Monday AI

# 中等 CAIR 值的机遇：Monday AI

[Monday.com](https://monday.com/w/ai?ref=blog.langchain.com) offers a fascinating case study in moderate confidence. Their AI Blocks can create automations and deploy changes, but these modifications take effect immediately on users’ Monday boards, boards that often contain business critical workflow data connected to real operations.

[Monday.com](https://monday.com/w/ai?ref=blog.langchain.com) 提供了一个关于“中等信心水平”的精彩案例研究。其 AI Blocks 功能可创建自动化流程并即时部署变更——这些变更会立刻生效于用户的 Monday 看板上；而这些看板往往承载着与真实业务运营紧密关联的关键工作流数据。

![](images/the-hidden-metric-that-determines-ai-product-success/img_003.gif)Automating monday.com boards with AI

![](images/the-hidden-metric-that-determines-ai-product-success/img_003.gif)使用 AI 自动化管理 monday.com 看板

Let’s break down each variable:

下面我们逐项分析各变量：

**Risk**: Medium — Monday boards are “production data” that teams rely on for daily operations, often connected to other workflows throughout an organization. An incorrect automation could cascade across departments, send wrong information to clients, or disrupt project timelines.

**风险（Risk）**：中等 — Monday 看板属于“生产环境数据”，团队日常运营高度依赖其准确性，且通常与组织内其他工作流系统深度集成。一次错误的自动化操作可能波及多个部门、向客户发送错误信息，或打乱项目进度。

**Correction**: Medium — Because boards are interconnected with other systems, fixing AI mistakes requires detective work to identify changes, understand downstream effects, and manually reverse automation changes across multiple workflows.

**修正难度（Correction）**：中等 — 由于看板与其他系统相互关联，修复 AI 错误需开展“侦探式”排查：定位具体变更、评估其下游影响，并在多个工作流中手动回滚自动化更改。

**Value**: High — The AI can automate tedious manual workflow management, potentially saving teams dozens of hours per week on routine operations like updating project statuses and triggering follow-up actions.

**价值（Value）**：高 — AI 可自动化繁琐的手动工作流管理任务，例如定期更新项目状态、触发后续动作等，有望为团队每周节省数十小时的重复性劳动。

**CAIR = High ÷ (Medium × Medium) = Moderate**

**CAIR = 高 ÷（中 × 中）= 中等**

This moderate CAIR creates adoption hesitation, especially for users managing critical workflows. The psychological barrier isn’t the AI’s capability, it’s that users must commit to changes without being confident about them first.

这一中等水平的 CAIR 会引发采用迟疑，尤其对于管理关键工作流的用户而言。造成心理障碍的并非 AI 的能力本身，而是用户必须在尚未对其变更建立充分信心之前，就先行承诺采纳这些变更。

The framework suggests a clear product improvement: adding a preview interface where users can evaluate AI changes before they go live. This single design change would dramatically reduce Risk from Medium to Low by separating the “testing” from the “deploying” mental models.

该框架明确指出一项产品优化方向：增加预览界面，使用户能在 AI 变更正式上线前先行评估。仅凭这一项设计改进，即可通过将“测试”与“部署”的心智模型分离，将风险等级从“中等”显著降低至“低”。

![](images/the-hidden-metric-that-determines-ai-product-success/img_004.png)

![](images/the-hidden-metric-that-determines-ai-product-success/img_004.png)

This simple UX improvement would boost CAIR significantly and likely translate to much higher adoption rates. It’s a perfect example of how CAIR analysis can identify high-impact product improvements that require zero changes to the underlying AI technology, just smarter product design around the same AI capabilities. It’s a perfect example of how CAIR analysis can identify high-impact product improvements that require zero changes to the underlying AI technology.

这一简洁的用户体验改进将大幅提升 CAIR，并很可能转化为显著更高的采用率。它完美诠释了 CAIR 分析如何识别出具有高影响力的产品优化点——这些优化无需改动底层 AI 技术，仅需围绕现有 AI 能力进行更明智的产品设计。它完美诠释了 CAIR 分析如何识别出具有高影响力的产品优化点，而这些优化完全无需改动底层 AI 技术。

While workflow optimization tools like Monday AI represent moderate risk scenarios, some domains face fundamentally different challenges due to both high stakes and AI’s inherent limitations with numerical reasoning.

尽管 Monday AI 等工作流优化工具属于中等风险场景，但某些领域却因后果严重性极高，叠加 AI 在数值推理方面固有的局限性，而面临本质截然不同的挑战。

# High stakes domains: Where design matters most

# 高风险领域：设计至关重要之处

Financial services and healthcare illustrate how AI’s fundamental limitations, particularly with math and numerical reasoning, create inherently low CAIR that requires careful product design to overcome.

金融服务业与医疗健康业正是典型案例，凸显了 AI 在数学运算与数值推理方面的根本性局限——这种局限天然导致极低的 CAIR，唯有依靠审慎细致的产品设计方能弥补。

The challenge isn’t just about consequences, it’s about capability gaps. LLMs are fundamentally unreliable with mathematical calculations, numerical analysis, and precise reasoning. This makes domains like accounting, tax preparation, and investment advice extremely challenging regardless of how well you design the user experience.

挑战不仅在于后果严重，更在于能力鸿沟。大语言模型（LLMs）在数学计算、数值分析及精确推理方面本质上不可靠。因此，无论用户体验设计得多么精良，会计、税务申报和投资建议等领域依然极具挑战性。

Consider AI tax preparation software. The core issue isn’t just that mistakes have consequences (IRS audits, penalties), but that LLMs can’t reliably perform the mathematical calculations and rule applications that tax preparation requires. If such a system automatically filed returns, the CAIR would be devastating:

以 AI 税务申报软件为例：核心问题不仅在于出错会带来严重后果（如美国国税局 IRS 的稽查与罚金），更在于大语言模型无法可靠地执行税务申报所必需的数学运算与规则应用。倘若此类系统直接自动提交纳税申报表，其 CAIR 将是灾难性的：

**Auto-Filing Tax AI CAIR = High ÷ (High × High) = Very Low**

**自助报税 AI 的 CAIR = 高 ÷（高 × 高）= 极低**

[TurboTax’s](https://turbotax.intuit.com/?ref=blog.langchain.com) success comes from recognizing this fundamental limitation. Rather than just offering final expert review, they’ve built human oversight throughout the entire process, guided workflows where humans input data, AI suggests optimizations, and humans approve each step. The AI augments human capability rather than replacing human judgment on numerical calculations.

TurboTax 的成功源于对这一根本性局限的清醒认知。他们并未仅停留在提供最终专家复核环节，而是将人工监督嵌入整个流程：在结构化工作流中，由人类输入数据、AI 提出优化建议、再由人类逐项审核确认。AI 在此过程中增强人类能力，而非取代人类在数值计算上的判断力。

![](images/the-hidden-metric-that-determines-ai-product-success/img_005.jpg)Turbotax + AI

![](images/the-hidden-metric-that-determines-ai-product-success/img_005.jpg)TurboTax + AI

Similarly, auto investment traders face the dual challenge of mathematical complexity and severe consequences. Autonomous systems that execute trades create paralyzing low confidence:

同样，自动投资交易系统也面临数学复杂性与后果严重性的双重挑战。完全自主执行交易的系统会引发令人瘫痪的低置信度：

**Autonomous Trading CAIR = High ÷ (High × High) = Very Low**

**自主交易 AI 的 CAIR = 高 ÷（高 × 高）= 极低**

Successful platforms like [Wealthfront](https://www.wealthfront.com/?ref=blog.langchain.com) achieve moderate CAIR by limiting AI to pattern recognition and trend analysis while keeping humans responsible for all numerical decisions and trade execution.

像 [Wealthfront](https://www.wealthfront.com/?ref=blog.langchain.com) 这样成功的平台，通过将 AI 的作用严格限定于模式识别与趋势分析，同时将所有数值型决策及交易执行权保留在人类手中，从而实现了中等水平的 CAIR。

Healthcare faces identical patterns. AI diagnostic tools struggle with the numerical precision required for dosage calculations, risk assessments, and measurement interpretations. Successful ECG analysis tools achieve moderate CAIR by positioning AI as a pattern detection tool that highlights anomalies for human interpretation, rather than attempting numerical diagnosis.

医疗健康领域亦呈现相同规律。AI 辅助诊断工具在剂量计算、风险评估及测量结果解读等需高度数值精度的任务上表现乏力。而成功的 ECG（心电图）分析工具则通过将 AI 定位为“异常模式检测器”——即仅负责标记可疑异常，交由医生进行专业判读——从而实现中等水平的 CAIR，而非试图直接输出数值型诊断结论。

![](images/the-hidden-metric-that-determines-ai-product-success/img_006.png)CAIR by Industry and products

![](images/the-hidden-metric-that-determines-ai-product-success/img_006.png)各行业及产品对应的 CAIR 水平

The pattern is clear: high-stakes domains requiring numerical precision aren’t waiting for more accurate AI, they’re designing around AI’s fundamental limitations while leveraging its pattern recognition strengths. This creates sustainable competitive advantages that are harder to replicate than pure technical improvements.

规律已然清晰：那些对数值精度要求极高、容错成本巨大的关键领域，并未坐等 AI 数值准确性进一步提升，而是主动围绕 AI 的根本性局限开展产品设计，同时充分发挥其在模式识别方面的固有优势。这种以人机协同范式构建的竞争优势，远比单纯的技术参数提升更可持续、更难被复制。

# The five principles of CAIR optimization

# CAIR 优化的五大原则

After analyzing successful AI products, we’ve identified five reliable strategies for optimizing CAIR. These aren’t theoretical, the data consistently validates their effectiveness across diverse industries and use cases.

在分析了众多成功的 AI 产品后，我们总结出五种切实可行的 CAIR 优化策略。这些并非纸上谈兵——数据持续验证了它们在不同行业与应用场景中的有效性。

1. **Strategic human-in-the-loop (Optimizes all three variables) —** Teams often think “autonomous” equals “better,” but this dramatically increases Risk in most scenarios. You must add human oversight, but strategically. Adding it everywhere kills Value, while placing it at key decision points maximizes CAIR. For instance, requiring approval for every suggestion kills productivity, but requiring approval before irreversible actions maintains both safety and utility. The art lies in identifying where **human oversight adds the most CAIR optimization for the least value dilution**.

1. **战略性“人在环中”机制（同步优化全部三个变量）** —— 团队常误以为“自主性”即等于“更优”，但在大多数场景下，这反而会显著推高 Risk（风险）。你必须引入人工监督，但需讲究策略：处处设防会扼杀 Value（价值），而仅在关键决策节点部署监督，则可最大化 CAIR。例如，要求用户对每一条 AI 建议都审批，将严重拖累生产力；但若仅在执行不可逆操作前设置审批环节，则既能保障安全，又不牺牲实用性。其精妙之处在于精准识别：**在何处施加人工监督，能以最小的价值损耗换取最大的 CAIR 提升**。

2. **Reversibility (Reduces Correction) —** When users know they can easily undo an AI action, the effort to correct mistakes plummets. The psychological safety of a clear “escape hatch” transforms anxiety into confidence. We’ve consistently seen adoption rates double simply by adding prominent undo capabilities.

2. **可逆性（降低 Correction 成本）** —— 当用户确信自己能轻松撤销 AI 的操作时，纠错所需付出的努力将大幅下降。“明确退出路径”带来的心理安全感，可将焦虑转化为信心。我们反复观察到：仅通过增设醒目、易用的“撤销”功能，产品采用率即可翻倍。

3. **Consequence isolation (Reduces Risk) —** Create safe spaces for AI experimentation through sandboxes, previews, and draft modes. This separates the “testing” from the “deploying” mental models, effectively eliminating consequence fears during exploration. Sandbox environments consistently show 3–4x higher adoption rates.

3. **后果隔离（降低 Risk）** —— 借助沙盒环境、预览模式和草稿模式，为 AI 实验打造安全空间。此举将用户心智模型中的“测试”与“上线”明确区隔开来，从而在探索阶段彻底消除对不良后果的担忧。沙盒环境的采用率始终比常规模式高出 3–4 倍。

4. **Transparency (Reduces Risk and Correction) —** When users understand why an AI made a decision, they can better assess its reliability (reducing perceived Risk) and identify specific issues to fix (reducing Correction effort). Explanation features dramatically increase repeated use because users can correct specific flawed assumptions rather than throwing out entire AI outputs.

4. **透明性（同时降低 Risk 与 Correction 成本）** —— 当用户理解 AI 做出某项决策的原因时，便能更准确地评估其可靠性（从而降低主观感知的 Risk），并精准定位待修复的具体问题（从而减少 Correction 所需投入）。具备解释能力的功能可显著提升用户复用率——因为用户得以修正个别错误假设，而非全盘弃用整段 AI 输出。

5. **Control gradients (Increases Value while managing Risk) —** Allow users to calibrate CAIR to their personal comfort level. Start with low risk features and progressively offer higher value capabilities as confidence builds. This acknowledges that everyone has different risk tolerance and creates a natural progression path.

5. **控制梯度（在管控 Risk 的同时提升 Value）** —— 允许用户根据自身舒适度动态调节 CAIR 水平：从低风险功能起步，随用户信心逐步增强，渐进式开放更高价值的能力。这一设计尊重了每个人风险偏好的差异，并自然构建起一条可持续的成长路径。

# Reframing AI product development

# 重构 AI 产品开发范式

CAIR fundamentally changes how we evaluate AI readiness. Instead of only asking “Is the AI accurate enough?”, we should also ask “Is the CAIR high enough for adoption?”

CAIR 彻底改变了我们评估 AI 就绪度的方式。我们不应再只问：“AI 够准确吗？”——还应同步追问：“CAIR 是否足够高，足以支撑用户采纳？”

This shift moves the conversation from purely technical metrics to a balanced technical product perspective. The most important questions become:

这一转变，将讨论焦点从纯技术指标，转向兼顾技术与产品的综合视角。此时，最关键的问题变为：

- How easily can users correct AI mistakes?  
- 用户纠正 AI 错误是否便捷？

- How severe are the consequences of AI errors?  
- AI 出错所引发的后果有多严重？

- How much value does successful AI completion provide?  
- AI 成功完成任务所能创造的价值有多大？

- How much control do humans retain at critical moments?  
- 在关键节点上，人类仍保有多少控制权？

- How clearly are limitations communicated?  
- AI 的能力边界是否被清晰传达？

For product leaders, this insight is liberating. You don’t need to wait for perfect AI to create successful products. An 85% accurate AI in a high-CAIR design will consistently outperform a 95% accurate AI in a low-CAIR design in terms of user adoption and satisfaction.

对产品负责人而言，这一洞见极具解放意义：你无需苦等“完美 AI”问世，即可打造成功的产品。一个准确率为 85% 但 CAIR 极高的 AI 设计，其用户采纳率与满意度，将稳定超越准确率达 95% 却 CAIR 极低的设计。

For organizations, this means AI initiatives should be jointly led by product and AI teams, with product design decisions considered as important as model tuning in determining success. AI readiness assessments must include CAIR calculations, not just technical evaluations.

对企业组织而言，这意味着 AI 项目须由产品团队与 AI 团队共同主导；产品设计决策的重要性，应与模型调优并驾齐驱。AI 就绪度评估必须纳入 CAIR 计算，而不仅限于技术层面的评测。

The companies that will win in AI aren’t necessarily those with the most advanced models, they’re the ones that understand how to engineer confidence and maximize CAIR through thoughtful product design.

最终在 AI 领域胜出的企业，未必拥有最前沿的模型；真正制胜者，是那些深谙如何通过审慎的产品设计来构建用户信心、并最大化 CAIR 的公司。

**Start here**: Calculate the CAIR score for your current AI features. Identify your lowest CAIR touch points, pick one, and implement a single CAIR optimization principle. Measure adoption before and after. You’ll likely see the difference immediately, and more importantly, you’ll have a repeatable framework for every AI product decision that follows.

**即刻行动**：为你当前的 AI 功能计算 CAIR 得分；找出 CAIR 最低的关键触点，选定其中一项，应用一条 CAIR 优化原则；对比实施前后的采用率变化。你很可能立刻看到显著差异；更重要的是，你将由此获得一套可复用的框架，指导后续每一个 AI 产品决策。

The question isn’t whether your AI is good enough. The question is whether your users are confident enough in it to find out.

问题不在于你的 AI 是否足够好，而在于用户是否对其有足够的信心，愿意去尝试和探索。

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison 的热评](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/the-hidden-metric-that-determines-ai-product-success/img_007.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[![关于 Agent 框架与 Agent 可观测性](images/the-hidden-metric-that-determines-ai-product-success/img_007.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于 Agent 框架与 Agent 可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热评](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/the-hidden-metric-that-determines-ai-product-success/img_008.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪到洞察：规模化理解 Agent 行为](images/the-hidden-metric-that-determines-ai-product-success/img_008.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪到洞察：规模化理解 Agent 行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热评](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/the-hidden-metric-that-determines-ai-product-success/img_009.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件中，代码记录应用；在 AI 中，追踪（traces）承担这一角色。](images/the-hidden-metric-that-determines-ai-product-success/img_009.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件中，代码记录应用；在 AI 中，追踪（traces）承担这一角色。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/the-hidden-metric-that-determines-ai-product-success/img_010.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架（Agent Frameworks）、运行时（Runtimes）与封装器（Harnesses）——天哪！](images/the-hidden-metric-that-determines-ai-product-success/img_010.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架（Agent Frameworks）、运行时（Runtimes）与封装器（Harnesses）——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟

[![Reflections on Three Years of Building LangChain](images/the-hidden-metric-that-determines-ai-product-success/img_011.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考与感悟](images/the-hidden-metric-that-determines-ai-product-success/img_011.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考与感悟**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：6 分钟

[![Not Another Workflow Builder](images/the-hidden-metric-that-determines-ai-product-success/img_012.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不。](images/the-hidden-metric-that-determines-ai-product-success/img_012.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不！**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟