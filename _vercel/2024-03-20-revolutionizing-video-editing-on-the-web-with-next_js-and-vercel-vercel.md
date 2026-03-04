---
title: "Revolutionizing video editing on the web with Next.js and Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/revolutionizing-video-editing-on-the-web-with-next-js-and-vercel"
date: "2024-03-20"
scraped_at: "2026-03-02T09:46:17.904908453+00:00"
language: "en-zh"
translated: true
description: "Ozone, the AI-infused, web-based video editor, accelerated their development process by 5x after switching to Vercel and Next.js. See how."
---
{% raw %}

Mar 20, 2024

2024年3月20日

协作式、AI赋能的基于 Web 的视频编辑平台 Ozone 已从 Heroku 迁移至 Vercel，以提供极致的用户体验。

#### 5x

开发速度提升 5 倍

#### 85%

构建时间减少 85%

[Talk to an Expert](https://vercel.com/contact/sales)

[与专家交流](https://vercel.com/contact/sales)

[Ozone](https://www.ozone.pro/) 旨在通过拥抱 Web 技术彻底变革视频编辑方式。

受 Figma 等成功 Web 应用的启发，Ozone 的创始团队认识到 Web 环境在可访问性、更新便捷性以及工具民主化方面所蕴含的巨大潜力。借助现代 Web 架构的强大能力与灵活性，Ozone 使用户能够直接在浏览器中完成高强度的视频编辑任务，彻底摆脱了笨重的桌面应用程序。

Ozone 最初部署在 Heroku 上，但面临部署缓慢和频繁宕机等挑战。为寻求更可靠、更高效的托管平台，Ozone 决定迁移到 Vercel——这一转变带来了颠覆性的成效。

Deployment speeds skyrocketed: tasks that once took 15 minutes now completed in a fraction of the time. This not only **accelerated the development process by 5x**, but also empowered team members to iterate on features rapidly and independently.

部署速度大幅飙升：过去耗时 15 分钟的任务，如今仅需极短时间即可完成。这不仅**将开发流程提速了 5 倍**，还使团队成员能够快速、独立地迭代各项功能。

Additionally, given Ozone is a heavy product built on React and WebAssembly, with many custom submodules, load times were massively improved by switching to Vercel—even with the heavy-duty rendering functionalities and large amounts of data that they need to surface to users.

此外，Ozone 是一款基于 React 和 WebAssembly 构建的重量级产品，包含大量自定义子模块。即便需支持高负载渲染功能及向用户呈现海量数据，迁移到 Vercel 后，其加载时间仍实现了显著优化。

## **Democratizing collaboration and development**

## **赋能协作与开发的民主化**

Vercel's developer experience workflow unlocked new possibilities for collaboration. The ability to [leave comments](https://vercel.com/docs/workflow-collaboration/comments) on feature branches and deploy each feature independently allowed teams to work at their own pace and ship features more efficiently.

Vercel 的开发者体验工作流为协作开辟了全新可能。团队可在功能分支上[直接留言评论](https://vercel.com/docs/workflow-collaboration/comments)，并独立部署每个功能——这使得各团队能按自身节奏高效推进，更快交付功能。

With hundreds of features to develop and just a small team to do it, Ozone relied on Vercel to streamline the journey from idea to experimentation to final deployment—a feat previously unimaginable with other platforms.

面对数百项待开发功能，而团队规模却十分有限，Ozone 依托 Vercel 实现了从创意构想到实验验证、再到最终上线部署的全流程提效——这一目标在其他平台此前根本无法实现。

> “Knowing that an engineer can finish working on something that I can test in staging or production within a matter of what seconds is incredible. In the past, I was waiting 15 to 20 minutes to be able to get my hands on anything. Knowing that an engineer can finish working on something that I can test in staging or production within a matter of what seconds is incredible. In the past, I was waiting 15 to 20 minutes to be able to get my hands on anything. ”
>
> ![](images/revolutionizing-video-editing-on-the-web-with-next_js-and-vercel-vercel/img_001.png)
>
> **Max von Wolff,** Founder & CEO

> “工程师刚完成某项工作，我就能在几秒钟内于预发布（staging）或生产环境中进行测试——这简直令人难以置信。过去，我往往要等待 15 到 20 分钟，才能拿到可测试的内容。”  
>   
> ![](images/revolutionizing-video-editing-on-the-web-with-next_js-and-vercel-vercel/img_001.png)  
>   
> **马克斯·冯·沃尔夫（Max von Wolff）**，创始人兼首席执行官

One team member may be working on AI, another working on the timeline, and someone may be working on exporting and collaboration. By deploying each and every one of those features to their own unique branch, Vercel removes cross-team dependencies, and everyone can move at their own pace to ship features in the most efficient way.

一名团队成员可能专注于 AI 功能，另一名负责时间轴（timeline）模块，还有人则聚焦于导出与协作能力。通过将每一项功能分别部署至其专属分支，Vercel 消除了跨团队依赖，让每位成员都能按自身节奏高效交付功能。

## **AI integration and future innovations**

## **AI 集成与未来创新**

Building on its success, Ozone has begun incorporating AI functionality into its platform, enabling users to generate videos, images, music, and speech on the fly by integrating with models from companies like Stability AI, Meta, and ElevenLabs. This integration not only enhances the editing experience, but also positions Ozone at the forefront of technological innovation in the industry.

在既有成果基础上，Ozone 已开始将 AI 功能深度融入平台：通过对接 Stability AI、Meta 和 ElevenLabs 等公司的模型，用户可实时生成视频、图像、音乐与语音。该集成不仅极大提升了编辑体验，更使 Ozone 站在了行业技术革新的最前沿。

Next.js and Vercel helped the team to integrate AI APIs into their codebase, test them, and get to production. With [AI Integrations](https://vercel.com/docs/integrations/ai) available right from the Vercel dashboard, and the [AI SDK](https://sdk.vercel.ai/docs) to help developers build conversational streaming user interfaces, the barrier to entry has never been lower.

Next.js 与 Vercel 协助团队将 AI API 无缝集成至代码库，完成测试并快速上线。借助 Vercel 控制台内置的 [AI 集成（AI Integrations）](https://vercel.com/docs/integrations/ai)，以及专为构建对话式流式用户界面而设计的 [AI SDK](https://sdk.vercel.ai/docs)，AI 应用开发的门槛前所未有地降低。

[**Start building today**  
**今天就开始构建吧**

Explore, preview, and seamlessly integrate AI models and databases into your Vercel projects.  
探索、预览，并无缝将 AI 模型与数据库集成到您的 Vercel 项目中。

Get Started  
立即开始](https://vercel.com/docs/integrations/ai)

> “It would be foolish not to embrace this incredible AI trend that is happening. And with Vercel, it's easy to allow creators to really let their creativity run wild and create it all in one platform by incorporating AI easily into our platform.”  
> “若不拥抱这场正在发生的非凡 AI 浪潮，那将是愚蠢的。而借助 Vercel，创作者可以轻松将 AI 便捷地融入我们的平台，在单一平台上尽情释放创意、完成全部创作。”

> ![](images/revolutionizing-video-editing-on-the-web-with-next_js-and-vercel-vercel/img_002.png)  
> ![](images/revolutionizing-video-editing-on-the-web-with-next_js-and-vercel-vercel/img_002.png)

> **Alexander Kollmann,** Product Manager  
> **亚历山大·科爾曼（Alexander Kollmann）**，产品经理

## **Competitive advantage and future outlook**  
## **竞争优势与未来展望**

For Ozone, the ability to iterate quickly and incorporate user feedback is a competitive advantage. By leveraging Vercel's capabilities, Ozone has accelerated its development cycle, enhanced performance, and democratized the development process.  
对 Ozone 而言，快速迭代并整合用户反馈的能力构成了一项核心竞争优势。通过充分利用 Vercel 的各项能力，Ozone 显著加快了开发周期、提升了性能表现，并推动了开发流程的民主化。

With a focus on innovation and collaboration, Ozone is poised to continue disrupting the video editing landscape and shaping the future of content creation.  
依托对创新与协作的持续聚焦，Ozone 将继续重塑视频编辑领域格局，并引领内容创作的未来发展。

[**Want to add Vercel to your composable stack?**  
**希望将 Vercel 加入您的可组合技术栈？**

Talk to an expert to learn how you can get started with Vercel today.  
联系专家，了解如何即刻开启您的 Vercel 之旅。

Get in Touch  
立即联系](https://vercel.com/contact/sales)
{% endraw %}
