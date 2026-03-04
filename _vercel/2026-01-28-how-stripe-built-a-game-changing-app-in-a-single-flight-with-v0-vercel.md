---
title: "How Stripe built a game-changing app in a single flight with v0 - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/how-stripe-built-a-game-changing-app-in-a-single-flight-with-v0"
date: "2026-01-28"
scraped_at: "2026-03-02T09:21:40.332114777+00:00"
language: "en-zh"
translated: true
description: "Stripe built a production GTM value calculator in a single flight using v0, boosting adoption 288% and cutting value analysis time by 80%."
---

render_with_liquid: false
Jan 28, 2026

2026年1月28日

过去通常需要跨多个团队耗时数月进行产品开发协调与构建的工作，如今由一人在一次航程中便已完成。

> “Stripe 鼓励实验精神与好奇心，而 v0 帮助我们瞬间将创意加速转化为创新。”  
>  
> ![](images/how-stripe-built-a-game-changing-app-in-a-single-flight-with-v0-vercel/img_001.jpg)  
>  
> **Janette Lee**，全球业务价值咨询负责人  

## **Stripe 加速价值工具建设：让 GTM 团队更快、更智能、完全自助化**

## **Stripe 推动价值工具提速增效：赋能 GTM 团队实现更快、更智能、全自助式应用**

Mario Braz 登上一趟国际航班时带着一个问题；下飞机时，他已手握一个可运行的生产级应用。

Mario Braz 拥有金融背景，却毫无正式工程训练经历。作为 Stripe GTM 业务价值咨询团队的一员，他借助 [v0](https://v0.app/) 在长途飞行途中完成了一个完整应用的原型开发。落地之时，首个可用版本已然就绪——纯 Web 架构、响应式适配移动端，且可立即部署。

最终成果是一款面向客户的“价值计算器”（Value Calculator），使 GTM 团队无需业务价值团队支持，即可快速为各类客户画像生成定制化的财务假设。

过去通常需跨多个团队耗时数月进行产品开发协调与构建的工作，如今被压缩至单次航程之内。

## **采用难题**

## **落地挑战**

Stripe 的业务价值咨询团队致力于量化客户使用 Stripe 所带来的财务影响——涵盖营收增长、规模化与效率提升，以及风险缓释等方面。其财务模型在公司内部广受信赖，但长期被锁定在电子表格中，不仅使用门槛高，就连标准化场景也依赖一支规模有限的团队提供人工支持。

“We invested heavily in training, but the field kept giving us the same message: the models were powerful, but the spreadsheet format created too much friction and was too complex for AEs to use consistently,” Mario recalls  

“我们投入了大量资源开展培训，但一线团队反复向我们传递同一个信息：模型本身能力强大，但电子表格格式带来了过多使用阻力，对销售代表（AE）而言过于复杂，难以持续、稳定地应用。”Mario 回忆道。

Even a simplified version couldn’t solve the problem. “Spreadsheets introduce cognitive overload,” Mario explains. “The moment an AE opens one, it signals complexity, regardless of how much you try to streamline it.”  

即使简化版本也无法解决这一问题。“电子表格会引发认知超载，”Mario 解释道，“只要销售代表一打开表格，就会立刻感知到‘这很复杂’——无论你如何精简其设计。”

The result: Stripe's value quantification remained bottlenecked on a small team, limiting scalability and the adoption of value based selling across the GTM organization.  

结果是：Stripe 的价值量化工作长期受限于一个小型团队，严重制约了规模化落地，也阻碍了以价值为导向的销售策略在整个上市（GTM）组织中的推广。

## **Why v0 at Stripe**  

## **为何 Stripe 选择 v0**

The team considered other low-code options, but v0 stood out for its ability to synthesize intent beyond the prompt, generating cleaner, more intuitive code and one-click deployment to a secure, public-facing site. Additionally, mobile accessibility made it easy to implement fixes on the go.  

团队曾评估过其他低代码方案，但 v0 凭借其超越提示词本身、深度理解用户意图的能力脱颖而出——它能生成更简洁、更直观的代码，并支持一键部署至安全、可公开访问的网站。此外，v0 对移动端的良好支持，也让团队能够随时随地快速完成修复与迭代。

> “v0 has an excellent ability to synthesize the intention of its user beyond simply what's on the AI prompt, leading to optimal results. v0 has an excellent ability to synthesize the intention of its user beyond simply what's on the AI prompt, leading to optimal results.”  
>  
> > “v0 具备卓越的意图理解能力——它不仅能解析 AI 提示词表面的内容，更能深入捕捉用户的真实意图，从而产出最优结果。v0 具备卓越的意图理解能力——它不仅能解析 AI 提示词表面的内容，更能深入捕捉用户的真实意图，从而产出最优结果。”  
>  
> ![](images/how-stripe-built-a-game-changing-app-in-a-single-flight-with-v0-vercel/img_002.jpg)  
>  
> **Mario Braz,** Stripe GTM Business Value Consulting  
>  
> **Mario Braz**，Stripe 上市（GTM）业务价值咨询团队

The application transformed Stripe's complex financial models into a focused, guided interface. Instead of overwhelming users with dozens of variables, it presented clean inputs with detailed documentation.  

该应用将 Stripe 原本复杂的财务模型，重构为一个聚焦明确、引导清晰的交互界面。它不再用数十个变量让用户应接不暇，而是提供简洁明了的输入项，并辅以详尽的说明文档。

“When AEs see the application, the path becomes immediately clear,” Braz explains. “It focuses them on the inputs that matter and creates the structure they need to drive a confident, consistent value conversation.” Mario explains.  

“当销售代表看到这个应用时，行动路径立刻变得清晰明了，”Braz 解释道，“它引导他们聚焦于真正关键的输入项，并构建起支撑自信、一致的价值对话所需的结构化框架。”Mario 补充道。

## **How it's being used today**  

## **当前的实际应用情况**

The numbers tell a clear story.  

数据清晰地讲述了一个成功的故事。

Excluding the launch week spike, the v0 app now sees an average of 92 unique weekly internal users versus 23 in the old Google Sheets model. That's a **288%** increase in adoption.

剔除上线首周的峰值后，v0 版应用目前平均每周有 92 名独立内部用户，而旧版 Google Sheets 模型仅为 23 人。用户采纳率提升了 **288%**。

But engagement goes deeper than visits: the team tracks how many users complete the full workflow. The final step is exporting the calculations performed in the tool to an automatically created customer-facing presentation, which is the the bottom of the funnel. Each week, approximately 10 unique value presentations are produced, with 126 created since launch. At an estimated 3-4 hours saved per slide deck, that's 30-40 hours of FTE time saved every week.

但参与度远不止于访问量：团队持续追踪完成完整工作流的用户数量。工作流的最后一步，是将工具中执行的计算结果导出为自动生成的、面向客户的演示文稿——这正是转化漏斗的最末端。目前每周约产出 10 份独立的价值演示文稿，自上线以来累计已达 126 份。按每套幻灯片节省约 3–4 小时估算，每周可节省 30–40 小时的全职员工（FTE）工时。

Three weeks after launch, the broader results were clear:

上线三周后，更广泛的影响已清晰显现：

- **Time to generate initial value hypotheses decreased by ~80%**

- **初始价值假设的生成时间缩短约 80%**

- **Multiple CxOs granted executive sponsorship** after experiencing the app in real sales conversations

- **多位首席高管（CxO）在真实销售对话中体验该应用后，授予其高层背书**

"The tool has made me excited all over again about Stripe's opportunity to sell into Enterprise by talking directly to CFOs," one rep shared. Another wrote: "Just finished a call with a CFO and earned their sponsorship—and this calculator was pivotal." A third called it a "life changing tool!"

一位销售代表分享道：“这款工具让我重新燃起对 Stripe 向企业客户（尤其是直接面向 CFO）销售机会的热情。”另一位写道：“刚刚结束一场与 CFO 的通话，并成功赢得其背书——而这款计算器起到了关键作用。”还有一位称其为“改变人生的工具！”

The impact extended beyond the application itself. It has inspired Solution Architects to start building their own demos, and Product Managers to create prototypes to guide engineering. Sales teams now mock up what Stripe's checkout experience would look like with a prospect's actual branding and products.

其影响已超越应用本身：它激励解决方案架构师（Solution Architects）开始自主构建演示方案，也促使产品经理（Product Managers）制作原型以指导工程开发；销售团队如今能基于潜在客户的实际品牌与产品，快速模拟出 Stripe 结账体验的效果。

“Instead of telling, our sales teams are now able to show users what their end-customer experience will be like,” Braz says.

布拉兹（Braz）表示：“我们的销售团队不再只是‘讲述’，而是真正能够向用户‘展示’其终端客户的实际体验。”

## **The bigger picture**

## **更大的图景**

What started as one person's experiment has become a force multiplier for Stripe's entire go-to-market organization.

最初仅源于一人的一次实验，如今已成长为赋能 Stripe 整个市场进入（Go-to-Market）组织的倍增器。

"Given our small team size, this tool now allows us to have significantly broader reach," Braz notes.  
“鉴于我们团队规模较小，这款工具如今使我们的影响力显著扩大。”布拉兹指出。

"From SMBs to Enterprise customers, we now have the opportunity to influence how our GTM teams engage with users."  
“从中小型企业（SMB）到大型企业客户，我们现在有机会影响我们的上市（GTM）团队如何与用户互动。”

Janette Lee, Head of Global Business Value Consulting at Stripe, sees it as validation:  
斯特里普（Stripe）全球商业价值咨询主管珍妮特·李（Janette Lee）将其视为一种认可：

"Stripe encourages experimentation and curiosity, and v0 helped us accelerate from idea to innovation in no time."  
“Stripe 倡导实验精神与好奇心，而 v0 帮助我们瞬间将创意加速转化为创新成果。”

The tool didn't come from a product brief. It emerged because the cost of experimentation had dropped low enough that the person closest to the problem—a finance professional with no coding background—could simply build it himself.  
这款工具并非源自一份产品需求文档；它的诞生，是因为实验成本已大幅降低——以至于最贴近问题本身的人——一位毫无编程背景的财务专业人士——也能亲自将其构建出来。

"Don't underestimate how Vercel can bridge the gap between business expertise and technical implementation," Braz advises.  
“切勿低估 Vercel 在业务专长与技术实现之间所架起的桥梁作用。”布拉兹建议道。

"Subject matter experts without traditional engineering backgrounds can create sophisticated, high-impact applications when given the tools and incentives."  
“当获得恰当的工具与激励机制时，那些不具备传统工程背景的领域专家，同样能够开发出复杂且高影响力的软件应用。”

For teams with insights locked in spreadsheets or business cases requiring too much manual work, the barrier between having an idea and shipping a solution has never been lower.  
对于那些将洞见锁在电子表格中、或因业务场景过于依赖人工操作而举步维艰的团队而言，从灵光一现到交付解决方案之间的门槛，从未如此之低。

Sometimes all it takes is a single flight.  
有时，仅需一次飞行而已。