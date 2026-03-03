---
title: "How Rubric Labs and Graphite leveraged LLMs to create personalized videos at scale"
source: "LangChain Blog"
url: "https://blog.langchain.com/rubric-labs-graphite-personalized-video-at-scale/"
date: "2023-12-19"
scraped_at: "2026-03-03T08:19:23.579747625+00:00"
language: "en-zh"
translated: true
description: "How Rubric Labs and Graphite generated personalized, unique GitHub Wrapped 2023 videos for each user."
---

随着2023年接近尾声，[Graphite](https://graphite.dev/?ref=blog.langchain.com)希望向[GitHub](https://github.com/?ref=blog.langchain.com)用户致以诚挚谢意，表彰他们全年来的卓越贡献。我们的目标是为开发者献上一份特别的年终礼物，助其重温过往、静心反思，并在新的一年里获得灵感与鼓舞。

作为[GitHub Wrapped](https://github.com/neat-run/wrapped?ref=blog.langchain.com)（我们于2021年开发并成功扩展至1万名用户的项目）的缔造者，[Rubric](https://rubriclabs.com/?ref=blog.langchain.com)团队天然具备承接这一项目的实力与经验。

然而，2023年注定是不同寻常的一年——这一年，[大语言模型（LLMs）](https://en.wikipedia.org/wiki/Large_language_model?ref=blog.langchain.com)正式走向大众、全面开放。

与2021年相比，我们仿佛骤然置身于一片机遇无限的广阔天地。因此，我们决心突破以往静态图像与模板化叙事的局限，转而打造真正个性化、完全专属每位终端用户的内容；同时，我们也希望这份体验足够沉浸、引人入胜。由此，[Year in code](https://year-in-code.com/?ref=blog.langchain.com)应运而生——一款由AI生成、高度个性化的视频！

毫不意外，我们最终选择借助[LangChain](https://langchain.com/?ref=blog.langchain.com)来构建这一项目。LangChain开箱即用的辅助函数，使我们得以在数天内而非数周内快速上线产品。

# 重要链接

# 重要链接

- [立即体验 Year in code](https://year-in-code.com/?ref=blog.langchain.com)
- [GitHub 代码仓库](https://github.com/withgraphite/year-in-code?ref=blog.langchain.com)
- [立即体验 Graphite](https://graphite.dev/?ref=blog.langchain.com)

# 技术栈

# 技术栈

- [GitHub GraphQL](https://docs.github.com/en/graphql?ref=blog.langchain.com) API：用于获取 GitHub 数据统计
- [LangChain.js](https://js.langchain.com/?ref=blog.langchain.com) 与 [OpenAI GPT-4-turbo](https://platform.openai.com/docs/models/gpt-4-and-gpt-4-turbo?ref=blog.langchain.com)：用于生成 `video_manifest`（即视频脚本）
- [Remotion](https://www.remotion.dev/?ref=blog.langchain.com)：用于创建并播放视频
- [AWS Lambda](https://aws.amazon.com/lambda/?ref=blog.langchain.com)：用于视频渲染
- [AWS S3](https://aws.amazon.com/s3/?ref=blog.langchain.com)：用于视频存储
- [Three.js](https://threejs.org/?ref=blog.langchain.com)：用于渲染3D对象
- [Supabase](https://supabase.com/?ref=blog.langchain.com)：用于数据库管理与用户认证
- [Next.js](https://nextjs.org/?ref=blog.langchain.com) 13：前端框架
- [Vercel](https://vercel.com/?ref=blog.langchain.com)：部署与托管平台
- [Tailwind](https://tailwindcss.com/?ref=blog.langchain.com)：样式设计工具
- [Zod](https://zod.dev/?ref=blog.langchain.com)：数据结构校验工具

# 架构设计

# 架构设计

## Overview

## 概览

Let’s summarize the architecture in a diagram:

让我们通过一张图来概括整体架构：

![](images/how-rubric-labs-and-graphite-leveraged-llms-to-create-personalized-videos-at-sca/img_001.png)Overview of the architecture

![](images/how-rubric-labs-and-graphite-leveraged-llms-to-create-personalized-videos-at-sca/img_001.png)架构概览

We begin by authenticating a GitHub user using [Supabase auth](https://supabase.com/docs/guides/auth/social-login/auth-github?ref=blog.langchain.com). Once authenticated, we fetch user-specific data from the GitHub GraphQL API, and store it in our PostgreSQL database hosted on [Supabase](https://supabase.com/?ref=blog.langchain.com). Supabase offers an out of the box API with [Row Level Security (RLS)](https://supabase.com/docs/guides/auth/row-level-security?ref=blog.langchain.com) which streamlines reads/writes to the database.

我们首先使用 [Supabase auth](https://supabase.com/docs/guides/auth/social-login/auth-github?ref=blog.langchain.com) 对 GitHub 用户进行身份验证。认证成功后，我们从 GitHub GraphQL API 获取该用户的专属数据，并将其存储在托管于 [Supabase](https://supabase.com/?ref=blog.langchain.com) 的 PostgreSQL 数据库中。Supabase 提供开箱即用的 API，并内置 [行级安全（Row Level Security, RLS）](https://supabase.com/docs/guides/auth/row-level-security?ref=blog.langchain.com)，从而大幅简化数据库的读写操作。

At this point, we pass user stats to the LLM (`gpt-4-turbo`) using LangChain. Leveraging prompt engineering, [function-calling](https://js.langchain.com/docs/modules/model_io/models/chat/how_to/function_calling?ref=blog.langchain.com) & [Zod schema validation](https://js.langchain.com/docs/modules/model_io/output_parsers/structured?ref=blog.langchain.com), we are able to generate structured output called the `video_manifest`. Think of this as the script of the video.

此时，我们借助 LangChain 将用户统计数据传入大语言模型（`gpt-4-turbo`）。通过提示词工程（prompt engineering）、[函数调用（function-calling）](https://js.langchain.com/docs/modules/model_io/models/chat/how_to/function_calling?ref=blog.langchain.com) 以及 [Zod 模式校验（Zod schema validation）](https://js.langchain.com/docs/modules/model_io/output_parsers/structured?ref=blog.langchain.com)，我们得以生成结构化输出——即 `video_manifest`。你可以将它理解为视频的“剧本”。

This manifest is passed to a [Remotion player](https://www.remotion.dev/docs/player/?ref=blog.langchain.com) which allows easy embeds of Remotion videos in React apps at runtime. The manifest maps over a set of a React components.

该 `video_manifest` 被传入 [Remotion player](https://www.remotion.dev/docs/player/?ref=blog.langchain.com)，从而实现在 React 应用中于运行时便捷嵌入 Remotion 视频。`video_manifest` 会遍历一组 React 组件并驱动其渲染。

At this point, the user is able to play the video in the client and also share their URL with their friends. Next.js 13 [server rendering patterns](https://nextjs.org/docs/app/building-your-application/rendering?ref=blog.langchain.com) make this seamless for the end user. Additionally, the user is able to download an `.mp4` file for easy sharing by rendering the video in the cloud using [AWS lambda](https://www.remotion.dev/docs/lambda?ref=blog.langchain.com) and storing the video in an S3 storage bucket.

至此，用户可在客户端直接播放视频，并可将视频 URL 分享给朋友。Next.js 13 的 [服务端渲染模式（server rendering patterns）](https://nextjs.org/docs/app/building-your-application/rendering?ref=blog.langchain.com) 让整个体验对终端用户而言流畅自然。此外，用户还可一键下载 `.mp4` 文件以便轻松分享：系统通过 [AWS Lambda](https://www.remotion.dev/docs/lambda?ref=blog.langchain.com) 在云端完成视频渲染，并将最终视频文件存入 S3 存储桶。

Let’s explore this in greater detail.

下面我们深入探讨这一流程的更多细节。

### Fetching stats

### 获取用户数据统计

When you log into the app with GitHub, we fetch some of your stats right away. These include:

当你使用 GitHub 登录应用时，我们会立即获取你的一部分数据统计信息。这些信息包括：

- your most-written languages  
- 您使用最多的编程语言  

- repositories you’ve contributed to  
- 您参与贡献过的代码仓库  

- stars you’ve given and received, and  
- 您送出和收到的 Star（星标），以及  

- your newest friends.  
- 您最新结识的朋友。  

We also fetch your total commits, pull requests, and opened issues. Check the type below to get a sense of the data we fetch. We wanted to be cognizant of [scope](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/scopes-for-oauth-apps?ref=blog.langchain.com#available-scopes) here so we ask for the most necessary permissions, excluding any access to code. The project is also fully open source to reinforce trust with the end user.  

我们还会获取您的总提交次数（commits）、拉取请求（pull requests）和已开启的问题（opened issues）。请参阅下方类型定义，以了解我们所获取的数据范围。在此过程中，我们特别注意了 GitHub 的 [权限范围（scope）](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/scopes-for-oauth-apps?ref=blog.langchain.com#available-scopes)，因此仅申请最必需的权限，**完全不涉及任何源代码访问权限**。此外，该项目完全开源，以进一步增强终端用户对项目的信任。

```javascript
interface Stats {
	username: string
	year: number
	email: string
	fullName: string
	avatarUrl: string
	company: string
	commits: number
	pulls: number
	contributions: number
	contributionsHistory: Week[]
	repos: number
	reviews: number
	stars: Star
	topRepos: Repo[]
	topLanguages: Language[]
	topFollows: Follows
	firstContributionDate: string
	codingStreakInDays: number
}
```

[查看完整类型定义](https://github.com/withgraphite/year-in-code/blob/19397d1dbc9011907604822d263bfc35c73d64ef/lib/types/github.ts?ref=blog.langchain.com#L1)

## Generating the manifest  
## 生成视频脚本（manifest）

We then pass these stats to OpenAI’s `gpt-4-turbo` model via LangChain, along with a prompt on how to format its response. Here’s the prompt:  

随后，我们将上述统计信息连同一条格式化指令提示（prompt）一并传入 OpenAI 的 `gpt-4-turbo` 模型——该过程通过 LangChain 实现。以下是该提示词内容：

```js
const prompt = ChatPromptTemplate.fromMessages([\
  [\
    'system',\
    `You are Github Video Maker, an AI tool that is responsible for generating\
a compelling narative video based on a users year in code.\
It is very important that this video feels personal, motivated by their\
real activities and highlights what was special about that users year in code.\
The goal of this video is to make the end user feel seen, valued and have a\
nostalgic moment of review. You do not need to touch on everything, rather\
hone in on and focus on the key elements that made this year special.\
Make sure there is a story arch that builds over time, and that the video\
has a clear beginning, middle and end. When choosing colors, make sure to hone in\
on a definitive and aesthetically pleasing color palette, chosing complimentary\
colors that aren't aggressively different.'\
Videos must always have exactly 12 scenes.\
Today's date (UTC) is ${new Date().toLocaleDateString()}.`\
  ],\
  ['human', `The GitHub stats are as follows: ${stats}`]\
]);
```

[提示词完整源码链接](https://github.com/withgraphite/year-in-code/blob/19397d1dbc9011907604822d263bfc35c73d64ef/lib/utils/generate.ts?ref=blog.langchain.com#L40)

Given user stats, the AI generates a `video_manifest` which is similar to a script for the video. The manifest tells a unique story in 12 sequences (as defined in the prompt). Assuming each sequence lasts 5 seconds, this results in a 60 second video consistently.  

基于用户的统计数据，AI 将生成一份 `video_manifest`（视频脚本），其结构类似于视频分镜脚本。该脚本按提示词要求，将故事划分为**恰好 12 个镜头序列**。假设每个镜头持续 5 秒，则最终视频长度恒为 **60 秒**。

Here we ran into a challenging problem: do we give the AI complete creative freedom or do we template as guardrails for the AI?  

在此过程中，我们遇到了一个颇具挑战性的问题：是赋予 AI 完全的创作自由，还是为其设定结构化的模板作为“护栏”（guardrails）？

After running some experiments, we quickly realized that in the given timeframe, we couldn’t generate high quality video by giving AI the complete creative freedom. While the output was decent and could have been improved, it wasn’t good enough to have that nostalgic moment, especially in the engineering time that we had.

在进行若干实验后，我们很快意识到：在既定的时间范围内，若赋予 AI 完全的创作自由，将无法生成高质量视频。尽管输出结果尚可、且仍有提升空间，但其质量仍不足以唤起那种怀旧感——尤其受限于我们当时紧张的工程开发周期。

So instead we struck middle ground by creating a bank of “scenes” and parametrized them as much as possible. This allowed the AI pick the most relevant scenes based on the user’s data based on descriptions for each scene that the AI could match with. Using these AI-selected scenes, and passing user-specific data, we are able to generate a unique sequence of personalized frames.

因此，我们选择了一条折中路径：构建一个“场景库”，并尽可能对每个场景进行参数化。这使得 AI 能够根据用户数据，结合每个场景的文本描述（AI 可据此进行语义匹配），自动挑选最相关的场景。再将这些 AI 筛选出的场景与用户专属数据相结合，我们便能生成一段独一无二、高度个性化的视频帧序列。

This was possible using [OpenAI’s Function Calling](https://platform.openai.com/docs/assistants/tools/function-calling?ref=blog.langchain.com) which enabled the AI to output parsable text, conforming to a [Zod schema](https://www.npmjs.com/package/zod-to-json-schema?ref=blog.langchain.com). The schema uses a Zod discriminated union (not the name of a rockband) to distinguish scenes:

这一能力的实现依赖于 [OpenAI 的 Function Calling](https://platform.openai.com/docs/assistants/tools/function-calling?ref=blog.langchain.com)，它使 AI 能够输出结构清晰、可解析的文本，并严格遵循 [Zod 模式定义](https://www.npmjs.com/package/zod-to-json-schema?ref=blog.langchain.com)。该模式采用 Zod 的“带区分字段的联合类型”（discriminated union）——注意，这不是某支摇滚乐队的名字——来区分不同类型的场景：

```javascript
import z from 'zod'

export const videoSchema = z.object({
  scenes: z
    .array(
      z.object({
        text: z.string().describe('Displays on screen'),
        animation: z
          .discriminatedUnion('type', [\
            z\
              .object({\
                type: z.enum(['intro']),\
                planet: z\
                  .enum([\
                    'mars',\
                    // ...\
                    'venus',\
                    'moon'\
                  ])\
                    .describe('Pick a random planet!')\
                  })\
                  .describe(\
                    'Text in front of a planet'\
                  )\
                  // ...\
                ])
              .describe('Animation to be used to display alongside the text')
            })
          )
        .describe('Scenes in the video')
})

export type Manifest = z.infer<typeof videoSchema>
```

[Check the full schema here](https://github.com/withgraphite/year-in-code/blob/main/lib/types/video.ts?ref=blog.langchain.com)

[查看完整 Schema 定义](https://github.com/withgraphite/year-in-code/blob/main/lib/types/video.ts?ref=blog.langchain.com)

​Let’s look at a sample output video manifest.

下面我们来看一份示例输出的视频清单（video manifest）：

```json
[\
  {\
    "text": "Sarim Malik's Year in Code",\
    "animation": {\
      "type": "intro",\
      "planet": "mars"\
    }\
  },\
  {\
    "text": "A journey through time and code...",\
    "animation": {\
      "type": "flashback",\
      "dateTo": "2023-01-25T00:00:00Z",\
      "dateFrom": "2023-12-19T00:00:00Z"\
    }\
  },\
  ...\
]
```

示例视频清单（video manifest）

每个清单（scene）条目都是一个包含 `text` 字段和 `animation` 字段的对象。每个场景的文本内容是唯一的，各场景的顺序也是唯一的；而每个场景所使用的动画，则是从一组预构建的组件库中选取的。

## 播放视频

## 播放视频

现在进入最有趣的部分：实际播放视频。这一环节颇具挑战性，因为我们本质上是在让 AI 担任视频导演，由它决定最终剪辑的版本；再基于该“导演剪辑版”，我们将各个场景映射为 React 组件，交由 [Remotion](https://www.remotion.dev/?ref=blog.langchain.com) 渲染生成视频。请看示例：

```javascript
export const Video = ({video}) => {
  const {fps} = useVideoConfig()

  return video.scenes.map(({text, animation}, i) => {
    switch (animation?.type) {
      case 'languages':
        return (
          <Languages from={i * fps * 5} languages={animation.languages} />
        )
      case 'people':
        return (
          <People from={i * fps * 5} people={animation.people} />
        )
      // ...
      default:
        return (
            <Conclusion from={i * fps * 5} text={text} />
        )
    }
  })
}
```

在客户端播放视频

此处，`from` 属性决定了该场景起始显示的帧序号。

为生成 3D 对象，我们采用了 [Three.js](https://threejs.org/?ref=blog.langchain.com)。例如，要将一张扁平的星系图像塑造成虫洞效果，我们充分利用了 Three.js 的 [TubeGeometry](https://threejs.org/docs/?ref=blog.langchain.com#api/en/geometries/TubeGeometry)，通过设置极高的多边形数量与极小的管径，将其性能压至极限。

![](images/how-rubric-labs-and-graphite-leveraged-llms-to-create-personalized-videos-at-sca/img_002.png)虫洞效果

如今，我们希望该体验具备良好的可扩展性，因此力求整体实现尽可能轻量。通过仅保存 `video_manifest`（视频清单），而非实际渲染完成的视频文件，项目所需的带宽与存储开销可降低达 100 倍。这种方案的另一大优势在于：生成的视频本身具备交互能力。

## Rendering the video

## 渲染视频

Since we map over a manifest in the client using React components, to download the video as `.mp4`, we have to render the video first. This is achieved using [Remotion lambda](https://www.remotion.dev/docs/lambda?ref=blog.langchain.com) leveraging 10,000 concurrent AWS Lambda instances and storing the file in an S3 bucket. Each user only has to render their video once, after which we store their download URL in Supabase for subsequent downloads.

由于我们在客户端使用 React 组件遍历视频清单（manifest），若要将视频下载为 `.mp4` 格式，必须先完成视频渲染。该过程通过 [Remotion Lambda](https://www.remotion.dev/docs/lambda?ref=blog.langchain.com) 实现——它可同时调度多达 10,000 个 AWS Lambda 实例，并将生成的文件存储于 S3 存储桶中。每位用户仅需渲染其视频一次；此后，我们将对应的下载 URL 持久化保存至 Supabase，供后续重复下载使用。

This step is the most expensive in the entire process and we intentionally added some friction to this step so that only the users that care the most about sharing their video end up executing this step.

这一步是整个流程中成本最高的环节；我们有意在此处引入一定操作门槛，确保只有那些最重视分享自己视频的用户才会真正执行该步骤。

# Conclusion

# 结语

This project makes use of all the latest tech: server-side rendering, an open-source database, LLMs, 3D, generative video. These sound like buzzwords but each is used very intentionally in this project. We hope it inspires you to build something new in 2024!

本项目融合了当前全部前沿技术：服务端渲染（SSR）、开源数据库、大语言模型（LLMs）、3D 渲染与生成式视频。这些术语听似流行口号，但在本项目中，每一项技术均被审慎而务实地选用。我们诚挚希望，它能激发你在 2024 年开创属于自己的全新作品！

Ready for takeoff? Give [Year in code](https://year-in-code.com/?ref=blog.langchain.com) a try. Translate your keystrokes into stardust. Find solace in your retrospection, let others join you in your journey, and connect with starfarers alike.

准备启程了吗？立即体验 [Year in code](https://year-in-code.com/?ref=blog.langchain.com) 吧！将你的每一次敲击转化为星尘；在回望过往中寻得慰藉，邀请他人同行于你的旅程，并与志同道合的“星际远航者”彼此联结。

Your chronicle awaits.

你的专属编年史，静待开启。

* * *

Thanks for reading! If you have feedback on this post, please reach out to us at [_hello@rubriclabs.com_](mailto:hello@rubriclabs.com) _._

感谢阅读！若您对本文有任何反馈，欢迎致信 [_hello@rubriclabs.com_](mailto:hello@rubriclabs.com)。