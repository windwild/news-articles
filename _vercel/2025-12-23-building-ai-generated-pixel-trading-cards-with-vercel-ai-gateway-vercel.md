---
render_with_liquid: false
title: "Building AI-Generated Pixel Trading Cards with Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/pixel-portraits-ai-generated-trading-cards"
date: "2025-12-23"
scraped_at: "2026-03-02T09:23:30.725690775+00:00"
language: "en-zh"
translated: true
description: "How Vercel built AI-generated pixel trading cards for Next.js Conf and Ship AI, then turned the same pipeline into a v0 template and festive holiday experiment."
---
render_with_liquid: false
render_with_liquid: false

Dec 23, 2025

2025年12月23日

At our recent Next.js Conf and Ship AI events, we introduced an activation that blended technical experimentation with playful nostalgia. The idea started long before anyone stepped into the venue. As part of the online registration experience for both events, attendees could prompt and generate their own trading cards, giving them an early taste of the format and creating the foundation for what we wanted to bring into the real world.

在最近举办的 Next.js Conf 和 Ship AI 活动中，我们推出了一项融合技术探索与趣味怀旧感的互动体验。这一创意早在任何人踏入会场之前便已萌芽。作为两场活动线上注册流程的一部分，参会者即可通过提示词生成专属交易卡，提前感受该形式的魅力，并为我们将这一体验带入现实世界奠定基础。

![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_001.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_002.jpg)

![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_001.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_002.jpg)

Building on that momentum, our team crafted a pixel portrait trading card experience designed to scale to thousands of attendees while still feeling personal. At its core was an AI-powered photobooth that captured each participant’s portrait, transformed it into a custom pixel-style rendering, and printed it on demand as a collectible card. Every card was sealed in a PSA-inspired sleeve and finished with a serialized grading label unique to each attendee.

乘势而上，我们的团队打造了一套像素风格肖像交易卡体验——既可支持数千名参会者规模，又始终保有个性化温度。其核心是一台由 AI 驱动的拍照亭：它实时捕捉每位参与者的肖像，将其转化为定制化的像素风图像，并即时打印为一张可收藏的实体卡片。每张卡片均封装于仿 PSA（Professional Sports Authenticator）风格的保护封套中，并附有唯一序列号的评级标签，专属于每位参会者。

![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_003.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_004.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_005.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_006.jpg)

![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_003.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_004.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_005.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_006.jpg)

What emerged was more than a keepsake. It became a lightweight system for generating user-led storytelling, a moment where attendees stepped into the brand and carried it forward themselves. As the cards spread across social channels, they turned into small but striking signals of the events, each one a pocket-sized artifact of the experience we wanted to create: technically sharp, tactile, and unmistakably ours.

最终呈现的，远不止一枚纪念品。它演化为一个轻量级的用户主导叙事系统——一个参会者主动“走入”品牌、并自发将其延续传播的契机。当这些卡片在社交平台广泛流转时，它们化作微小却醒目的活动信号；每一张都是我们所构想体验的缩影：技术精准、触感真实，且极具辨识度——完完全全属于我们。

Behind the simplicity of stepping up to a photobooth and receiving a trading card a few seconds later was a tightly orchestrated pipeline spanning AI generation, image processing, and on-site production. Each step was designed to be fast, predictable, and invisible to attendees.

看似简单的“走近拍照亭—数秒后领取交易卡”背后，是一条高度协同、环环相扣的技术流水线，横跨 AI 生成、图像处理与现场印制三大环节。每个步骤均以高速、稳定、对用户完全无感为目标进行设计。

![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_007.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_008.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_009.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_010.jpg)

![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_007.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_008.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_009.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_010.jpg)

The flow began the moment someone posed for their photo. The captured image was sent into our generation pipeline, which used the `flux-kontext-lora` model paired with a custom LoRA trained on a nostalgic 16-bit pixel art style. The system produced a pixel portrait that preserved the attendee’s likeness and rendered it on a bright green background for downstream processing.

整个流程始于用户摆好姿势拍摄照片的瞬间。所捕获的图像随即进入我们的生成流水线——该流水线采用 `flux-kontext-lora` 模型，并搭配一个专为怀旧式 16 位像素艺术风格训练的定制 LoRA（Low-Rank Adaptation）模型。系统输出的像素肖像不仅精准保留了参会者的面部特征，更统一渲染于明亮绿色背景之上，便于后续处理。

From there, BRIA’s RMBG 2.0 model removed the green screen, isolating the character for compositing. The Canvas API assembled the trading card by layering the pixel portrait with the event’s background pattern and brand overlay. A custom gradient map applied with the sharp image library created the final color identity for each event. The finished PNG was then sent to the on-site printer, completing the digital workflow in roughly six seconds. Attendees could also scan a QR code to save a digital version of their card.

随后，BRIA 公司的 RMBG 2.0 模型自动完成绿幕抠图，将人物主体精准分离，为合成做好准备。Canvas API 负责组装整张交易卡：将像素肖像叠加至活动专属背景图案及品牌视觉层之上；再借助 sharp 图像处理库应用定制渐变映射（gradient map），为每场活动赋予最终的色彩身份。最终生成的 PNG 文件被发送至现场打印机，整个数字工作流耗时约六秒。参会者还可扫描二维码，保存自己卡片的数字版本。

![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_011.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_012.jpg)

工作流的实体环节为整个体验画上了圆满句号。每张打印出的卡片均经手工模切，以实现经典收藏卡所特有的圆角轮廓。为提升制作效率，我们在活动前已预先印制了按顺序编号的评级标签，并将其预先粘贴在仿PSA（Professional Sports Authenticator）风格的亚克力保护套上——工作人员只需将卡片滑入套中，即可在数秒内完成交付。

## **将像素肖像引入 v0**

## **将“像素肖像”引入 v0**

活动结束后，我们希望“像素肖像”不仅停留在线下互动的瞬间，更能持续在线上延续生命力。为此，我们基于 Vercel AI Gateway 与 Fal 集成，端到端构建了一个 v0 模板，将这一创意完整迁移至浏览器中。

### 其工作原理如下：

### 工作原理：

1. **图像输入**：用户可通过网络摄像头拍照，或上传、粘贴、拖放任意图片。应用会自动将其裁剪为适合卡片展示的宽高比，并转换为 base64 格式的数据 URL。

1. **图像输入**：用户可以通过网络摄像头拍照，或上传、粘贴、拖放一张图片。该应用会将其裁剪为适合卡片显示的宽高比，并转换为 base64 数据 URL。

2. **风格参考图**：一张预设的像素艺术参考图（`style_reference.png`）被加载并以相同方式编码。它作为视觉锚点，定义了目标 16 位风格的视觉基调。

2. **风格参考图**：一张预设的像素艺术参考图（`style_reference.png`）被加载并以相同方式编码。它作为视觉锚点，定义了目标 16 位风格的视觉基调。

3. **GPT Image 1.5 编辑**：模型首先接收用户图像，其次接收风格参考图，并配合一段提示词（prompt），强制约束输出效果，例如：色彩数量有限、像素边缘锐利、构图保持一致等。

3. **GPT Image 1.5 编辑**：模型首先接收用户图像，其次接收风格参考图，并配合一段提示词（prompt），强制约束输出效果，例如：色彩数量有限、像素边缘锐利、构图保持一致等。

4. **合成处理**：生成图像经背景移除（使用 BRIA）清理后，再叠加至品牌化卡片边框之上；最后通过渐变映射（gradient mapping）生成适配 Next.js 和 Vercel 品牌调性的最终版本。

4. **合成处理**：生成图像经背景移除（BRIA）清理后，再叠加至品牌化卡片边框之上；最后通过渐变映射（gradient mapping）生成适配 Next.js 和 Vercel 品牌调性的最终版本。

```tsx
1// app/actions.ts

2"use server"



import * as fal from "@fal-ai/serverless-client"



6// Configure fal.ai with your API key

6// 使用您的 API 密钥配置 fal.ai

fal.config({

8  credentials: process.env.FAL_KEY,

9})



11// The prompt that transforms photos into pixel art

11// 将照片转换为像素艺术的提示词

```javascript
const PIXEL_ART_PROMPT = `Image roles



Image 1 (user photo): sole source of identity, facial geometry, proportions, hairline, hairstyle, silhouette, and recognisable likeness.



Image 2 (reference): pixel grid, colour discipline, framing, scale, and composition schema only.



Step 1: Identity Projection



Project the user photo onto a coarse 24×24 pixel grid, preserving the user's exact facial geometry: head width, jaw shape, cheek structure, eye spacing, nose width, mouth position, hairline, and overall silhouette.
```

```javascript
const PIXEL_ART_PROMPT = `图像角色



图像 1（用户照片）：身份的唯一来源，涵盖面部几何结构、比例、发际线、发型、轮廓以及可识别的肖像特征。



图像 2（参考图）：仅提供像素网格、色彩规范、构图框架、缩放比例及构图范式。



步骤 1：身份映射



将用户照片投射至一个粗粒度的 24×24 像素网格上，精确保留用户的面部几何结构：头部宽度、下颌形状、颧骨结构、眼距、鼻宽、嘴部位置、发际线以及整体轮廓。
```

Each major facial region (forehead, cheeks, nose, jaw, hair mass) must resolve into a small number of large pixel blocks, not fine detail.

每个主要面部区域（额头、脸颊、鼻子、下颌、发量）必须简化为少量大像素块，而非精细细节。

This step defines identity and geometry only. No stylistic averaging.

此步骤仅定义身份特征与几何结构，不进行任何风格化平均处理。

## Step 2: Pixel Formatting

## 第二步：像素格式化

Format the projected identity using ultra-blocky 16-bit pixel art rules, matching the reference image's pixel size, framing, scale, and negative space, without altering identity geometry.

使用高度块状化的 16 位像素画规则对投影出的身份特征进行格式化，使其严格匹配参考图像的像素尺寸、构图、缩放比例及负空间，同时不改变身份的几何结构。

Treat the portrait as if it were hand-placed pixel art, not a filtered image.

将肖像视作手工逐像素放置的像素画作品，而非经过滤镜处理的图像。

### Pixel Art Rules

### 像素画规则

33- 使用的颜色总数最多为 10 种  

33- 使用的颜色总数最多为 10 种  

34- 以 24×24 像素尺寸渲染，然后无平滑地放大  

34- 以 24×24 像素尺寸渲染，然后无平滑地放大  

35- 所有像素必须大、清晰且呈完美的正方形  

35- 所有像素必须大、清晰且呈完美的正方形  

36- 像素邻接关系必须是硬边、阶梯状和块状的，不得有任何混合、插值或羽化效果  

36- 像素邻接关系必须是硬边、阶梯状和块状的，不得有任何混合、插值或羽化效果  

37- 不得将像素簇进一步细分为更小的内部细节  

37- 不得将像素簇进一步细分为更小的内部细节  

38- 禁用抖动（dithering）、渐变（gradients）及柔和阴影（soft shading）  

38- 禁用抖动（dithering）、渐变（gradients）及柔和阴影（soft shading）  

Shading must be posterised and minimal, using 1 highlight and 1 shadow tone per facial region at most.  

阴影处理必须采用海报化（posterised）风格，且尽可能简洁：每个面部区域最多仅使用 1 种高光色与 1 种阴影色。

Apply lighting with a right-side light source, so the left side of the face is darker, using large, clearly separated pixel blocks to express contrast.

使用右侧光源打光，使面部左侧较暗，并以大块、边界清晰的像素块来表现明暗对比。

Facial Construction

面部结构

Construct hair, beard, and facial features as large geometric pixel clusters derived directly from the user photo's real silhouette and contours.

将头发、胡须及面部特征构建为大型几何像素簇，这些像素簇须直接源自用户照片中真实的轮廓与剪影。

Hair must read as a single or very small number of chunky shapes, not many interlocking fragments.

头发须呈现为单个或极少数几个粗厚的形状，而非大量相互嵌套的碎片。

Cluster scale may match the reference, but cluster shapes must follow the user's geometry, not the reference's.

像素簇的尺寸可与参考图一致，但其形状必须遵循用户的实际几何结构，而非参考图的形状。

Facial features must remain recognisable, but expressed with the fewest pixels possible:  

面部特征必须保持可识别性，但需以尽可能少的像素来表现：

eye spacing, eyebrow angle, nose width, mouth shape, jawline, and hairline must map clearly to the user photo without added detail.  

眼距、眉毛角度、鼻宽、嘴型、下颌线和发际线必须清晰对应用户照片，不得添加额外细节。

Use classic retro-game proportions: simplified forms, bold contours, minimal detail, slightly enlarged eyes relative to resolution.  

采用经典复古游戏比例：造型简化、轮廓粗重、细节极少，眼睛尺寸相对于分辨率略为放大。

Rendering Constraints  

渲染约束

60- No photorealistic texture  

60—禁止使用照片级真实感纹理  

61- No strands, pores, wrinkles, micro-shading, or smooth curves  

61—禁止表现发丝、毛孔、皱纹、微阴影或平滑曲线

62- 不得添加次要高光或轮廓线

62- No secondary highlights or contouring

63- 在头部、面部特征及服装轮廓周围使用粗像素描边

63- Use thick pixel outlines around the head, facial features, and clothing silhouette

64- 角色面部朝前

64- Character faces forward

65- 人物居中置于纯绿色平面背景上

65- Figure is centered on a flat green background

Clothing

服装

Clothing must match the type and silhouette from the user photo but be rendered entirely in black, using at most two dark tones for minimal pixel-art shading.

服装须与用户照片中的服装类型和剪影一致，但整体须以纯黑色呈现，并最多仅使用两种深色色调进行极简风格的像素画阴影处理。

72// Load the style reference image as base64  
72// 以 base64 格式加载风格参考图像

async function getStyleReferenceBase64(): Promise<string> {  

async function getStyleReferenceBase64(): Promise<string> {

74  const baseUrl = process.env.VERCEL_URL  
74  const baseUrl = process.env.VERCEL_URL

75    ? `https://${process.env.VERCEL_URL}`  
75    ? `https://${process.env.VERCEL_URL}`

76    : "http://localhost:3000"  
76    : "http://localhost:3000"

78  const response = await fetch(`${baseUrl}/style_reference.png`)  
78  const response = await fetch(`${baseUrl}/style_reference.png`)

79  const blob = await response.blob()  
79  const blob = await response.blob()

80  const buffer = await blob.arrayBuffer()  
80  const buffer = await blob.arrayBuffer()

81  const base64 = btoa(String.fromCharCode(...new Uint8Array(buffer)))  
81  const base64 = btoa(String.fromCharCode(...new Uint8Array(buffer)))

83  return `data:image/png;base64,${base64}`

83  返回 `data:image/png;base64,${base64}`

84}

84}

export async function generatePixelPortrait(userImageDataUrl: string) {

export async function generatePixelPortrait(userImageDataUrl: string) {

87  // Load the style reference image

87  // 加载风格参考图像

88  const styleReference = await getStyleReferenceBase64()

88  const styleReference = await getStyleReferenceBase64()

90  // Call fal.ai's GPT Image 1.5 Edit model

90  // 调用 fal.ai 的 GPT Image 1.5 Edit 模型

91  // Pass user image first, style reference second

91  // 首先传入用户图像，其次传入风格参考图像

92  const result = await fal.subscribe("fal-ai/gpt-image-1.5/edit", {

92  const result = await fal.subscribe("fal-ai/gpt-image-1.5/edit", {

93    input: {

93    input: {

94      prompt: PIXEL_ART_PROMPT,

94      prompt: PIXEL_ART_PROMPT,

95      image_urls: [userImageDataUrl, styleReference],

95      image_urls: [userImageDataUrl, styleReference],

96      image_size: "auto",

96      image_size: "自动",

97      quality: "high",

97      quality: "高",

98      input_fidelity: "high",

98      input_fidelity: "高",

99      num_images: 1,

99      num_images: 1,

100      output_format: "png",

100      output_format: "png",

102  })

102  })

104  return result.images[0].url

104  返回 result.images[0].url

105}
105}

From a user’s perspective, the template is simple: upload or take a selfie and watch it become a retro trading card. The key is the pairing of the user image with a single, consistent style reference. That reference keeps output stable across a wide range of inputs, while the prompt does the rest of the constraint work to avoid “generic pixelation” and land on something that reads as intentional sprite art.

从用户角度看，该模板极为简洁：上传照片或自拍，即可实时生成一张复古风格的交易卡。关键在于将用户图像与一个单一、统一的风格参考图配对。该参考图确保了在广泛多样的输入下输出结果保持稳定；而提示词（prompt）则承担其余约束任务，以避免出现“泛化的像素化失真”，最终生成具有明确意图的像素风精灵图（sprite art）。

From there, the rest of the app is about presentation: background removal for clean compositing, card-frame layering in the browser, and gradient mapping for the two branded variants. The end result is a small, forkable project that shows how far you can get with a few well-scoped steps and a clear style target.

此后，应用的其余部分聚焦于呈现效果：通过背景移除实现干净的图像合成；在浏览器中叠加卡片边框图层；并为两种品牌变体分别应用渐变映射。最终成果是一个轻量级、可分叉（forkable）的项目，展示了仅需若干边界清晰的关键步骤与明确的风格目标，便能走得多远。

Remix the [**v0 template**](https://v0.app/templates/pixel-portraits-KT0d8HiuPW3) to try Pixel Portraits for yourself. Connect your Fal.ai API key to run generations and experiment with prompts, models, and style references.

点击 remix [**v0 模板**](https://v0.app/templates/pixel-portraits-KT0d8HiuPW3)，亲自体验 Pixel Portraits。接入您的 Fal.ai API 密钥，即可运行图像生成，并自由尝试不同提示词、模型及风格参考图。

## **Vercelf Yourself: a festive remix**

## **Vercelf Yourself：一场节日主题的创意改编**

With the template in place, the same building blocks became a natural foundation for seasonal experiments. For the holidays, we created [Vercelf Yourself](https://v0-vercelf-yourself.vercel.app/), a spin off that turns your photo into a festive 16-bit pixel portrait.

模板就绪后，相同的模块自然演变为开展季节性实验的理想基础。值此佳节之际，我们推出了衍生项目 [Vercelf Yourself](https://v0-vercelf-yourself.vercel.app/) —— 将您的照片转化为充满节日氛围的 16 位像素风格肖像。

![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_013.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_014.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_015.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_016.jpg)  
![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_013.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_014.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_015.jpg)![](images/building-ai-generated-pixel-trading-cards-with-vercel-ai-gateway-vercel/img_016.jpg)

Vercelf Yourself uses the same style-reference approach as the template, but extends it with multiple filters. Each filter (Vercelf, Comfy, Santa, Wham!) has its own reference image and tailored prompt, all aiming at a strict greyscale, Vercel-forward aesthetic. The prompts control details like scale, crop, and framing while preserving recognizable traits from the original image. That combination keeps results consistent while giving each filter a distinct personality.

Vercelf Yourself 沿用了模板所采用的“风格参考”（style-reference）方法，但进一步扩展为支持多种滤镜。每种滤镜（Vercelf、Comfy、Santa、Wham!）均配有专属参考图像与定制化提示词（prompt），共同致力于实现一种严格的灰度（greyscale）视觉风格，并凸显 Vercel 品牌调性。这些提示词精准控制图像的缩放比例、裁剪方式与构图布局，同时保留原始照片中可识别的人物特征。这种设计既确保了生成结果的高度一致性，又赋予每种滤镜鲜明而独特的个性。

**Wham! filter prompt structure:**

**Wham! 滤镜提示词结构：**

```markdown
Apply the same 16 bit pixel art portrait style shown in the reference image to the user photo. Match the scale, crop and framing of the character in the style reference so the portrait aligns visually with the reference image. The final generated image must be strictly greyscale and use only black, grey and white. Do not introduce any colour. The character should face forward and wear a fluffy black fur coat inspired by Wham!’s Last Christmas video. Add two black and white retro 1980s skis in the foreground on the left side of the portrait, standing vertically as if the character is holding them. Add a silver hoop earring on the character’s right ear. Update the hairstyle to an 80s-inspired version of the user’s hair while keeping it recognisable. Preserve recognisable attributes from the user photo including skintone and facial features so the pixel character clearly resembles the person. Place the figure centered on a black background with a dark grey snowflake pattern.
```

```markdown
将参考图像中呈现的同款 16 位像素艺术肖像风格应用于用户照片。严格匹配参考图像中人物的缩放比例、裁剪区域与画面构图，使生成肖像在视觉上与参考图像对齐。最终生成图像必须为严格灰度图像，仅使用黑色、灰色与白色，不得引入任何彩色元素。人物须正面对镜头，身着一件毛茸茸的黑色皮草大衣——灵感源自 Wham! 经典歌曲《Last Christmas》MV 中的造型。在肖像左侧前景中添加两支黑白配色的复古 1980 年代滑雪板，垂直竖立，仿佛由人物手持。在人物右耳佩戴一枚银色圆环耳环。将用户发型更新为具有 1980 年代风格的版本，同时确保其仍具备可识别性。保留用户原照片中可辨识的关键特征（如肤色与面部轮廓），以确保生成的像素化人物形象清晰可辨、高度还原真人。人物居中置于纯黑背景之上，背景叠加深灰色雪花图案。
```

On the implementation side, the app uses Gemini image generation through the Vercel AI Gateway and the AI SDK to keep the integration minimal. The core of the request looks like this:

在实现层面，该应用通过 Vercel AI Gateway 与 AI SDK 调用 Gemini 图像生成功能，从而保持集成轻量简洁。请求的核心逻辑如下所示：

route.ts

route.ts

```typescript
const result = await generateText({

2  model: "google/gemini-3-pro-image",

3  messages: [{\
\
4    role: "user",\
\
5    content: [\
\
6      { type: "image", image: userImage },\
\
7      { type: "image", image: styleReferenceImage },\
\
8      { type: "text", text: prompt },\
\
9    ],\
\
10  }],

11})
```

```typescript
const result = await generateText({

2  model: "google/gemini-3-pro-image",

3  messages: [{\
\
4    role: "user",\
\
5    content: [\
\
6      { type: "image", image: userImage },\
\
7      { type: "image", image: styleReferenceImage },\
\
8      { type: "text", text: prompt },\
\
9    ],\
\
10  }],

11})
```

The AI Gateway handles routing, authentication, and response formatting behind the scenes. Because the interface stays consistent across providers, we can experiment with models or update the stack later without rewriting the app. That leaves us free to focus on what the experience feels like, not how it is wired together.

AI Gateway 在后台自动处理路由调度、身份认证与响应格式化。由于该接口在不同模型提供商之间保持统一，我们后续可灵活尝试其他模型，或升级技术栈，而无需重写应用程序。这使我们得以专注于用户体验本身——即“感受如何”，而非底层实现细节——即“如何连接与组装”。

Create your own festive portrait in the [**Vercelf yourself app**](https://v0-vercelf-yourself.vercel.app/). You can generate up to three images per day, or remix the [**v0 template**](https://v0.app/templates/vercelf-yourself-xDhJfRWwrud) to experiment with filters, prompts, and models using your own AI Gateway setup.

在 [**Vercelf yourself 应用**](https://v0-vercelf-yourself.vercel.app/) 中，创作属于你自己的节日肖像。每天最多可生成三张图像；或 remix [**v0 模板**](https://v0.app/templates/vercelf-yourself-xDhJfRWwrud)，借助你自己的 AI Gateway 配置，尝试不同的滤镜、提示词（prompts）和模型。

## **Wrapping up**

## **总结收尾**

Pixel Portraits started as a physical activation and evolved into a set of reusable patterns for building small, personal AI experiences: clear visual anchors, constrained prompts, simple pipelines, and just enough UI to make the whole thing approachable.

Pixel Portraits 最初是一项线下互动活动，随后演变为一套可复用的设计模式，用于构建轻量、个性化的 AI 体验：清晰的视觉锚点、受约束的提示词、简化的处理流程，以及恰到好处的用户界面——让整个体验亲切易上手。

Those same patterns now power a v0 template, a festive Vercelf Yourself variant, and whatever else we decide to plug into the pipeline next.

如今，这些模式已驱动一个 v0 模板、一个节日主题的 Vercelf Yourself 变体，以及未来我们将接入该流程的任何其他新功能。

Happy holidays!

节日快乐！