---
render_with_liquid: false
title: "Build a fast, animated image gallery with Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/building-a-fast-animated-image-gallery-with-next-js"
date: "2023-01-09"
scraped_at: "2026-03-02T09:57:06.100378076+00:00"
language: "en-zh"
translated: true
description: "Learn how to build a performant image gallery using the Next.js image component and Cloudinary that can handle hundreds of large images and deliver great UX."
---
render_with_liquid: false
render_with_liquid: false

Jan 9, 2023

2023年1月9日

How to use the Next.js Image component to automatically optimize hundreds of image.

如何使用 Next.js 的 `Image` 组件自动优化数百张图片。

We held our biggest ever Next.js Conference on October 25, 2022 with over 110,000 registered developers, 55,000 online attendees, and hundreds attending in person in San Fransisco. We had photographers on site to capture the experience and we wanted to share the photos they took with the community.

2022年10月25日，我们举办了迄今为止规模最大的 Next.js 大会：注册开发者超过 11 万人，在线参会者达 5.5 万人，另有数百人亲临旧金山现场参会。大会现场安排了专业摄影师全程记录，并希望将他们拍摄的照片与整个社区共享。

Instead of just sharing photos with a Google Drive link, we thought it’d be good idea to showcase these 350+ amazing photos in an [image gallery](https://nextjsconf-pics.vercel.app/) that was fast, functional, and beautiful. We ended up building our own and [open sourcing the code](https://vercel.com/templates/next.js/image-gallery-starter), making it easy for anyone to build their own image gallery.

我们没有简单地通过 Google Drive 链接分享照片，而是决定将这 350 多张精彩照片呈现在一个[图片画廊](https://nextjsconf-pics.vercel.app/)中——该画廊兼具高速、实用与美观。最终，我们自主开发了这一画廊，并将源代码[开源](https://vercel.com/templates/next.js/image-gallery-starter)，让任何人都能轻松构建属于自己的图片画廊。

In this blog post, we’re going to share the techniques we used to build a performant image gallery site that can handle hundreds of large images and deliver a great user experience.

本文将分享我们构建高性能图片画廊网站所采用的技术方案——该网站可高效处理数百张大尺寸图片，并为用户提供卓越的浏览体验。

## Rendering hundreds of images performantly

## 高性能渲染数百张图片

The biggest challenge was handling hundreds of high quality images with large source file sizes. We used [Cloudinary](https://cloudinary.com/) as our CDN to store all of these images, fetched them all at build time using `getStaticProps`, and then used the [Next.js Image component](https://nextjs.org/docs/basic-features/image-optimization) to display them. We made several decisions along the way to make the site as fast as possible. Let’s explore the choices we made.

最大的挑战在于处理数百张高分辨率、原始文件体积庞大的图片。我们选用 [Cloudinary](https://cloudinary.com/) 作为 CDN 存储全部图片；在构建时（build time）通过 `getStaticProps` 一次性获取所有图片元数据；再借助 [Next.js 的 `Image` 组件](https://nextjs.org/docs/basic-features/image-optimization) 进行渲染。过程中我们做出多项关键决策，以最大限度提升网站性能。下面逐一介绍这些技术选型。

There are three different areas in the application that displayed images:

应用中有三个不同区域需要展示图片：

1. The main screen, where images were displayed in a large grid.

1. 主界面：图片以大型网格形式呈现。

2. The modal that pops up when a user clicks an image, which displayed both a large version and a bottom carousel showing the rest of the images as thumbnails.

2. 用户点击某张图片后弹出的模态框（modal）：其中既显示当前图片的高清大图，底部还配有轮播组件（carousel），以缩略图形式展示其余全部图片。

3. 展示单张独立高清照片的各个动态路由。

3. 展示单张独立高清照片的各个动态路由。

为确保整个应用具备出色的性能，我们针对上述每个区域，以不同尺寸获取了相同的图像。

为确保整个应用具备出色的性能，我们针对上述每个区域，以不同尺寸获取了相同的图像。

在下方的主界面中，我们以 720×480 像素的尺寸获取图像。借助 Cloudinary 的 [变换 URL API](https://cloudinary.com/documentation/transformation_reference#w_width)，这一操作极为简单——只需在 URL 中添加 `w=720` 查询参数即可实现。

在下方的主界面中，我们以 720×480 像素的尺寸获取图像。借助 Cloudinary 的 [变换 URL API](https://cloudinary.com/documentation/transformation_reference#w_width)，这一操作极为简单——只需在 URL 中添加 `w=720` 查询参数即可实现。

![图库区域 #1：首页，以网格形式展示多张图片](images/build-a-fast-animated-image-gallery-with-next_js-vercel/img_001.jpg)  
图库区域 #1：首页，以网格形式展示多张图片

![图库区域 #1：首页，以网格形式展示多张图片](images/build-a-fast-animated-image-gallery-with-next_js-vercel/img_001.jpg)  
图库区域 #1：首页，以网格形式展示多张图片

进入模态框后，您会发现其中包含一张主图，以及底部一个由若干小图组成的轮播组件。我们以 1280×853 像素的尺寸获取主图，并在 `next/image` 组件中使用 `priority` 属性，使其被预加载，从而提升加载性能；而轮播中的小图则以 180×120 像素的尺寸获取。

进入模态框后，您会发现其中包含一张主图，以及底部一个由若干小图组成的轮播组件。我们以 1280×853 像素的尺寸获取主图，并在 `next/image` 组件中使用 `priority` 属性，使其被预加载，从而提升加载性能；而轮播中的小图则以 180×120 像素的尺寸获取。

![图库区域 #2：模态框，含一张大图及一组小图轮播](images/build-a-fast-animated-image-gallery-with-next_js-vercel/img_002.jpg)  
图库区域 #2：模态框，含一张大图及一组小图轮播

![图库区域 #2：模态框，含一张大图及一组小图轮播](images/build-a-fast-animated-image-gallery-with-next_js-vercel/img_002.jpg)  
图库区域 #2：模态框，含一张大图及一组小图轮播

您可能注意到一个有趣的现象：上一张截图与下一张截图中网站的 URL 完全相同，但页面内容却截然不同。这究竟是如何实现的？

您可能注意到一个有趣的现象：上一张截图与下一张截图中网站的 URL 完全相同，但页面内容却截然不同。这究竟是如何实现的？

这得益于 Next.js `Link` 组件的 `as` 属性，它可对实际 URL 进行隐藏（即“URL 掩码”）。在切换照片时，我们希望导航过程既快速又具备动画效果，而这要求整个交互必须保留在单个页面内——本例中即首页（`index` 页面）。为此，我们引入了一个名为 `photoId` 的查询参数，用以标识当前选中的照片，同时保持用户始终停留在首页。此外，我们还添加了 `shallow` 属性，确保当该查询参数发生变化时，不会触发数据的重新获取。

这得益于 Next.js `Link` 组件的 `as` 属性，它可对实际 URL 进行隐藏（即“URL 掩码”）。在切换照片时，我们希望导航过程既快速又具备动画效果，而这要求整个交互必须保留在单个页面内——本例中即首页（`index` 页面）。为此，我们引入了一个名为 `photoId` 的查询参数，用以标识当前选中的照片，同时保持用户始终停留在首页。此外，我们还添加了 `shallow` 属性，确保当该查询参数发生变化时，不会触发数据的重新获取。

```javascript
const Home: NextPage = () => {

2  const [loading, setLoading] = useState<boolean>(false);
```

3  const [bio, setBio] = useState<String>("");

3  const [bio, setBio] = useState<String>("");

4  const [vibe, setVibe] = useState<VibeType>("Professional");

4  const [vibe, setVibe] = useState<VibeType>("Professional");

5  const [generatedBios, setGeneratedBios] = useState<String>("");

5  const [generatedBios, setGeneratedBios] = useState<String>("");



7  const prompt = `Generate 2 ${vibe} twitter bios with no hashtags and clearly labeled "1." and "2.". Make sure each generated bio is at least 14 words and at max 20 words and base them on this context: ${bio}`;

7  const prompt = `生成两条 ${vibe} 风格的 Twitter 简介，不包含话题标签（hashtags），并明确标注为“1.”和“2.”。确保每条生成的简介至少包含 14 个单词、最多 20 个单词，并基于以下上下文：${bio}`;



9  const generateBio = async (e: any) => {

9  const generateBio = async (e: any) => {

10    // call serverless function

10    // 调用无服务器函数

11  };

11  };

13  return (

13  返回（

14    <Layout>

14    <Layout>

15      <Header />

15      <Header />

16      <main className="flex flex-1 w-full flex-col items-center justify-center text-center px-4 mt-12 sm:mt-20">

16      <main className="flex flex-1 w-full flex-col items-center justify-center text-center px-4 mt-12 sm:mt-20">

17        <a

17        <a

18          className="flex max-w-fit items-center justify-center space-x-2 rounded-full border border-gray-300 bg-white px-4 py-2 text-sm text-gray-600 shadow-md transition-colors hover:bg-gray-100 mb-5"

18          className="flex max-w-fit items-center justify-center space-x-2 rounded-full border border-gray-300 bg-white px-4 py-2 text-sm text-gray-600 shadow-md transition-colors hover:bg-gray-100 mb-5"

19          href="https://github.com/Nutlope/twitterbio"

19          href="https://github.com/Nutlope/twitterbio"

20          target="_blank"

20          target="_blank"

21          rel="noopener noreferrer"

21          rel="noopener noreferrer"

22        >

23          <Github />

23          <Github />

24          <p>Star on GitHub</p>

24          <p>在 GitHub 上点亮 Star</p>

25        </a>

25        </a>

26        <h1 className="sm:text-6xl text-4xl max-w-2xl font-bold text-slate-900">

26        <h1 className="sm:text-6xl text-4xl max-w-2xl font-bold text-slate-900">

27          Generate your next Twitter bio in seconds

27          几秒钟内生成你的下一条 Twitter 个人简介

28        </h1>

28        </h1>

29        <p className="text-slate-500 mt-5">18,167 bios generated so far.</p>

29        <p className="text-slate-500 mt-5">截至目前，已生成 18,167 条个人简介。</p>

30        <div className="max-w-xl">

30        <div className="max-w-xl">

31          <div className="flex mt-10 items-center space-x-3">

31          <div className="flex mt-10 items-center space-x-3">

32            <Image

32            <Image

33              src="/1-black.png"

33              src="/1-black.png"

34              width={30}

34              width={30}

35              height={30}

35              height={30}

36              alt="1 icon"

36              alt="图标 1"

37              className="mb-5 sm:mb-0"

37              className="mb-5 sm:mb-0"

38            />

38            />

39            <p className="text-left font-medium">

39            <p className="text-left font-medium">

40              Copy your current bio{" "}

40              复制您当前的个人简介{" "}

41              <span className="text-slate-500">

41              <span className="text-slate-500">

42                (or write a few sentences about yourself).

42                （或撰写几句关于您自己的介绍）。

43              </span>

43              </span>

44            </p>

44            </p>

45          </div>

45          </div>

46          <textarea

46          <textarea

47            value={bio}

47            value={bio}

48            onChange={(e) => setBio(e.target.value)}

48            onChange={(e) => setBio(e.target.value)}

49            rows={4}

49            rows={4}

50            className="w-full rounded-md border-gray-300 shadow-sm focus:border-black focus:ring-black my-5"

50            className="w-full rounded-md border-gray-300 shadow-sm focus:border-black focus:ring-black my-5"

51            placeholder={

51            placeholder={

52              "e.g. Senior Developer Advocate @vercel. Tweeting about web development, AI, and React / Next.js. Writing nutlope.substack.com."

52              “例如：Senior Developer Advocate @vercel。分享有关 Web 开发、AI 以及 React / Next.js 的内容。撰写博客于 nutlope.substack.com。”

53            }

53            }

54          />

54          />

55          <div className="flex mb-5 items-center space-x-3">

55          <div className="flex mb-5 items-center space-x-3">

56            <Image src="/2-black.png" width={30} height={30} alt="1 icon" />

56            <Image src="/2-black.png" width={30} height={30} alt="1 icon" />

57            <p className="text-left font-medium">Select your vibe.</p>

57            <p className="text-left font-medium">选择你的氛围风格。</p>

58          </div>

58          </div>

59          <div className="block">

59          <div className="block">

60            <DropDown vibe={vibe} setVibe={(newVibe) => setVibe(newVibe)} />

60            <DropDown vibe={vibe} setVibe={(newVibe) => setVibe(newVibe)} />

63          {!loading && (

63          {!loading && (

64            <button

64            <button

65              className="bg-black rounded-xl text-white font-medium px-4 py-2 sm:mt-10 mt-8 hover:bg-black/80 w-full"

65              className="bg-black rounded-xl text-white font-medium px-4 py-2 sm:mt-10 mt-8 hover:bg-black/80 w-full"

66              onClick={(e) => generateBio(e)}

66              onClick={(e) => generateBio(e)}

67            >

67            >

68              Generate your bio &rarr;

68              生成您的个人简介 &rarr;

69            </button>

69            </button>

70          )}

70          )}

71          {loading && (

71          {loading && (

73              className="bg-black rounded-xl text-white font-medium px-4 py-2 sm:mt-10 mt-8 hover:bg-black/80 w-full"

73              类名="bg-black rounded-xl text-white font-medium px-4 py-2 sm:mt-10 mt-8 hover:bg-black/80 w-full"

74              disabled

74              已禁用

75            >

75            >

76              <LoadingDots color="white" style="large" />

76              <LoadingDots color="white" style="large" />

77            </button>

77            </button>

78          )}

78          )}

79        </div>

79        </div>

80        <hr className="h-px bg-gray-700 border-1 dark:bg-gray-700" />

80        <hr className="h-px bg-gray-700 border-1 dark:bg-gray-700" />

81        <div className="space-y-10 my-10">

81        <div className="space-y-10 my-10">

82          {generatedBios && (

82          {generatedBios && (

83            <>

83            <>

84              <div>

84              <div>

85                <h2 className="sm:text-4xl text-3xl font-bold text-slate-900 mx-auto">

85                <h2 className="sm:text-4xl text-3xl font-bold text-slate-900 mx-auto">

86                  Your generated bios

86                  您生成的个人简介

87                </h2>

87                </h2>

88              </div>

88              </div>

89              <div className="space-y-8 flex flex-col items-center justify-center max-w-xl mx-auto">

89              <div className="space-y-8 flex flex-col items-center justify-center max-w-xl mx-auto">

90                {generatedBios

90                {generatedBios

91                  .substring(generatedBios.indexOf("1") + 3)

91                  .substring(generatedBios.indexOf("1") + 3)

92                  .split("2.") 

92                  .split("2.")

93                  .map((generatedBio) => {

93                  .map((generatedBio) => {

94                    return (

94                    返回 (

95                      <div

95                      <div

96                        className="bg-white rounded-xl shadow-md p-4 hover:bg-gray-100 transition cursor-copy border"

96                        className="bg-white rounded-xl shadow-md p-4 hover:bg-gray-100 transition cursor-copy border"

97                        key={generatedBio}

97                        key={generatedBio}

98                      >

98                      >

99                        <p>{generatedBio}</p>

99                        <p>{generatedBio}</p>

100                      </div>

100                      </div>

101                    );

101                    );

102                  })}

102                  })}

103              </div>

103              </div>

104            </>

104            </>

105          )}

105          )}

106      <Footer />

106      <Footer />

107		</Layout>

107		</Layout>

108    </div>

108    </div>

109  );

109  );

110};



110};



export default Home;

export default Home;

When the page is refreshed, it stops using the `photoId` query param and instead uses the `/p/[id]` dynamic route that has a slightly different layout as seen below.

页面刷新后，将不再使用 `photoId` 查询参数，而是改用 `/p/[id]` 动态路由——该路由的布局略有不同，如下图所示。

![Area #3 of the Image Gallery: Individual dynamic routes that showed one image](images/build-a-fast-animated-image-gallery-with-next_js-vercel/img_003.jpg)  
图 3：图片画廊中的区域 #3 —— 展示单张图片的独立动态路由

In this dynamic route, because we pre-generate it, we actually request a higher resolution photo (2560x1706px) and set the OG card to use the image for that specific dynamic route. It’s inspired by how Facebook Messenger shows images with their background blurred. Finally, we added a Share on Twitter button that autofills the Tweet with a picture that comes from the OG image for the specific page being shared.

在此动态路由中，由于我们预先生成了该页面，因此实际请求的是更高分辨率的图片（2560×1706 像素），并设置 Open Graph（OG）卡片使用该特定动态路由所对应的图片。这一设计灵感源自 Facebook Messenger 中图片展示方式——背景模糊、主体清晰。最后，我们添加了一个“分享到 Twitter”按钮，点击后可自动生成一条预填充推文，其中配图即为当前被分享页面的 OG 图片。

However, we wanted to also make it so folks could access the original high resolution images, which were all in 4k resolution. We did this by including a link to the high quality image at the top right of the modal in a download button.

然而，我们也希望用户能直接获取原始的高分辨率图片（全部为 4K 分辨率）。为此，我们在模态框（modal）右上角添加了一个下载按钮，链接指向对应高清原图。

### Generating image placeholders for optimal UX

### 生成图像占位符以实现最佳用户体验

We used image blur placeholders to instantly show users something as the images were loading. We did this by taking our images, blurring them by fetching them at a very small size, then converting them to base64. Base64 is a way to represent images in a long string format. The benefit of doing this is that you can embed these placeholders directly in your HTML, without needing to make a request. This makes them load instantly, no matter how slow the client device’s internet is.

我们采用模糊图像占位符（blur placeholder），在图片加载过程中即时向用户呈现一个视觉提示。具体做法是：先将原始图片缩放到极小尺寸（从而自然产生模糊效果），再将其转换为 base64 编码字符串。Base64 是一种以长文本字符串形式表示图像数据的编码方式。其优势在于：可直接将这些占位符嵌入 HTML 中，无需额外网络请求——因此无论用户设备网络多么缓慢，占位符均可瞬时加载。

To make sure page weight was minimal, we also performed an optimization to minify the image before generating the blurred versions using a library called `imagemin`.

为确保页面体积最小化，我们在生成模糊占位符前，还借助名为 `imagemin` 的库对原始图像进行了压缩优化。

This is the function we used to generate our image placeholders.

这是我们用于生成图像占位符的函数：

```javascript
import imagemin from "imagemin";

import imageminJpegtran from "imagemin-jpegtran";
```

```typescript
export async function getBase64ImageUrl(imageUrl: string) {

export async function getBase64ImageUrl(imageUrl: string) {

5  // fetch image and convert it to base64

5  // 获取图片并将其转换为 Base64 编码

6  const response = await fetch(imageUrl);

6  const response = await fetch(imageUrl);

7  const buffer = await response.arrayBuffer();

7  const buffer = await response.arrayBuffer();

8	const minified = await imagemin.buffer(Buffer.from(buffer), {

8	const minified = await imagemin.buffer(Buffer.from(buffer), {

9    plugins: [imageminJpegtran()],

9    plugins: [imageminJpegtran()],

10  });

10  });

11  const base64 = Buffer.from(minified).toString("base64")

11  const base64 = Buffer.from(minified).toString("base64")

12  return `data:image/jpeg;base64,${base64}`;

12  return `data:image/jpeg;base64,${base64}`;
```

13}
```

### Using the Next.js Image component

### 使用 Next.js 的 Image 组件

Another big performance win was using the Next.js Image component. Let’s take a look at all the properties we used.

另一个显著的性能提升来自于使用 Next.js 的 Image 组件。我们来逐一查看所用到的所有属性。

```javascript
1<Image

2  alt={caption}

3  style={{ transform: "translate3d(0, 0, 0)" }}

4  className="transform rounded-lg brightness-90 transition group-hover:brightness-110"

5  placeholder="blur"

6  blurDataURL={blurDataUrl}

7  src={`https://res.cloudinary.com/...`}
```

8  width={720}

8  width={720}

9  height={480}

9  height={480}

10  loading={id < 4 ? "eager" : "lazy"}

10  loading={id < 4 ? "eager" : "lazy"}

11  sizes="(max-width: 640px) 100vw,

11  sizes="(max-width: 640px) 100vw,

12    (max-width: 1280px) 50vw,

12    (max-width: 1280px) 50vw,

13    (max-width: 1536px) 33vw,

13    (max-width: 1536px) 33vw,

14    25vw"

14    25vw"

15/>
```

15/>
```

- **Auto-generated alt text:** We used a caption for the alt text. We’ll talk about how we generated this in the [auto-generated alt tag section](https://vercel.com/blog/building-a-fast-animated-image-gallery-with-next-js#accessibility-wins-with-headless-ui-and-auto-generated-alt-tags).

- **自动生成的 alt 文本（替代文本）：** 我们使用图像标题作为 `alt` 属性的值。关于该 `alt` 文本的具体生成方式，我们将在[“自动生成 alt 标签”小节](https://vercel.com/blog/building-a-fast-animated-image-gallery-with-next-js#accessibility-wins-with-headless-ui-and-auto-generated-alt-tags)中详细说明。

- **Translate3d CSS property**: Translate3d is typically used to move an element in 3d space, but when it's used with (0,0,0), it doesn't move the element at all. Instead, it makes some devices use their GPU for rendering–something that traditionally, only native apps could do. Since most rendering in browsers is usually done with software, using a GPU results in higher frames per second and smoother rendering when scrolling through hundreds of images, especially on Safari.

- **`translate3d` CSS 属性：** `translate3d` 通常用于在三维空间中移动元素；但当其参数设为 `(0, 0, 0)` 时，元素实际上并不会发生位移。它的真正作用是触发某些设备启用 GPU 进行渲染——这原本是原生应用才具备的能力。由于浏览器中的大多数渲染工作传统上依赖 CPU 软件完成，启用 GPU 渲染可显著提升帧率（FPS），使滚动浏览数百张图片时的画面更加流畅，尤其在 Safari 浏览器中效果更为明显。

- **Blur placeholder**: The blur placeholder that we talked about in the [last section](https://vercel.com/blog/building-a-fast-animated-image-gallery-with-next-js#generating-image-placeholders-for-optimal-ux) was also used.

- **模糊占位图**：我们在[上一节](https://vercel.com/blog/building-a-fast-animated-image-gallery-with-next-js#generating-image-placeholders-for-optimal-ux)中提到的模糊占位图（blur placeholder）也被沿用。

- **Lazy Loading**: We defined an explicit width and height, and set the `loading` prop to eager for the first 4 images to get those loaded as soon as possible, then lazy loaded the rest so that only the images in the user’s viewport loaded initially. The images would progressively load as the user scrolled.

- **懒加载（Lazy Loading）**：我们为图片显式定义了宽高，并将前 4 张图片的 `loading` 属性设为 `eager`，以确保它们能尽快加载；其余图片则启用懒加载，即仅在用户视口内时才开始加载。随着用户滚动页面，图片将逐步加载。

- **Sizes property**: We set the `sizes` property to let Next.js know the exact space the images would take up on different viewports in advance to only generate the correct sizes.

- **`sizes` 属性**：我们设置了 `sizes` 属性，以便 Next.js 能预先获知图片在不同视口尺寸下所占据的确切空间，从而仅生成尺寸匹配的图片资源。

It was important that not all the images on the page loaded at once since this would significantly slow down the First Input Delay (FID) and increase page loading time in general. Thankfully, `next/image` does this lazy loading by default, only loading images that are in the user's viewport.

页面上的所有图片不应一次性全部加载，这一点至关重要——否则将显著拖慢首次输入延迟（First Input Delay, FID），并整体延长页面加载时间。值得庆幸的是，`next/image` 默认即支持此类懒加载机制，仅加载位于用户当前视口内的图片。

### Implementing smooth animations

### 实现流畅动画

For our animations, we used [Framer Motion](https://www.framer.com/motion/), a declarative animation library for React. This let us pull off several animations, including the animations when navigating through images in the modal and animating the modal itself when the user clicked a photo. In addition to these animations, we used loading states, taking advantage of the `onLoadingComplete` prop in `next/image`, to only load the buttons on the modal after the image finished loading.

在动画实现方面，我们采用了 [Framer Motion](https://www.framer.com/motion/) —— 一款面向 React 的声明式动画库。借助它，我们实现了多种动画效果，包括模态框（modal）内图片切换时的过渡动画，以及用户点击照片后模态框自身的入场/出场动画。此外，我们还结合 `next/image` 提供的 `onLoadingComplete` 属性，利用加载状态控制：仅当图片加载完成之后，才渲染模态框中的操作按钮。

To learn more about the techniques we used to animate our image gallery, watch [Animating an Image Carousel](https://buildui.com/series/framer-motion-recipes/carousel-part-1?token=bShjdwoo6LJFrCjg). We also used a library called `react-swipable` to implement swiping through the modal on mobile devices, making it behave more like photo galleries on native apps.

如需深入了解我们为图片画廊所采用的动画技术，请观看教程视频：[Animating an Image Carousel（为图片轮播图添加动画）](https://buildui.com/series/framer-motion-recipes/carousel-part-1?token=bShjdwoo6LJFrCjg)。我们还引入了名为 `react-swipable` 的库，以支持移动端模态框内的手势滑动操作，使其交互体验更贴近原生应用中的相册功能。

### Accessibility wins with Headless UI and auto-generated alt tags

### 借助 Headless UI 与自动生成的 `alt` 标签提升可访问性

To improve the accessibility of the site, we used a UI library called [Headless UI](https://headlessui.com/), which provides many built-in fully accessible components. We also [used AI](https://vercel.com/templates/next.js/ai-alt-text-generator) to programmatically generate alt tags for all our 300+ photos.

为提升网站的可访问性（Accessibility），我们选用了 UI 组件库 [Headless UI](https://headlessui.com/)，它提供了大量开箱即用、完全符合无障碍标准（WCAG）的组件。同时，我们还[借助 AI 技术](https://vercel.com/templates/next.js/ai-alt-text-generator)为全部 300 多张照片自动生成 `alt` 替代文本（alt tags）。

Note that using AI to generate image tags is not perfect and we manually reviewed all the generated alt tags to make sure they were correct. Here's the script we used to generate the alt tags. It reads images from our CDN (Cloudinary), passes them into the API, then saves the generated description as metadata back to Cloudinary.

需要说明的是，AI 生成的图片标签并非万无一失，因此我们对所有自动生成的 `alt` 标签均进行了人工复核，以确保其准确性与语义恰当性。以下是用于生成 `alt` 标签的脚本逻辑：它从我们的 CDN（Cloudinary）读取图片，将其传入 AI 接口，再将生成的描述文本作为元数据写回 Cloudinary。

```javascript
import cloudinary from "../../utils/cloudinary";

import cloudinary from "../../utils/cloudinary";

export default async function getAltText() {

export default async function getAltText() {

4	const results = await cloudinary.v2.search

4	const results = await cloudinary.v2.search

5	    .expression(`folder:${process.env.CLOUDINARY_FOLDER}/*`)

5	    .expression(`folder:${process.env.CLOUDINARY_FOLDER}/*`)

6	    .sort_by("public_id", "desc")

6	    .sort_by("public_id", "desc")

7	    .max_results(400)

7	    .max_results(400)

8	    .execute();

8	    .execute();

10	  for (let result of results.resources) {

10	  for (let result of results.resources) {
```

11	    const imageUrl = result.url;

11    const imageUrl = result.url;

12	    const response = await fetch(

12    const response = await fetch(

13	      `https://alt-text-generator.vercel.app/generate?imageUrl=${imageUrl}`

13      `https://alt-text-generator.vercel.app/generate?imageUrl=${imageUrl}`

14	    );

14    );

15	    const altText = await response.text();

15    const altText = await response.text();

16	    const finalAltText = altText.split("Caption: ")[1];

16    const finalAltText = altText.split("Caption: ")[1];



18	    await cloudinary.v2.api.update(

18    await cloudinary.v2.api.update(

19	      result.public_id,

19      result.public_id,

20	      { type: "upload", context: { caption: finalAltText } },

20      { type: "upload", context: { caption: finalAltText } },

21	      function (_, result) {

21	      函数 (_, result) {

22	        console.log({ result });

22	        console.log({ result });

23	        console.log(`${result.public_id} done`);

23	        console.log(`${result.public_id} 已完成`);

24	      }

24	      }

25	    );

25	    );

26	  }

26	  }

27}
```

27}
```

### Restoring scroll when navigating back to the grid

### 返回照片网格时恢复滚动位置

Another helpful feature we implemented is keeping track of what the current photo in the modal is, so when users pressed outside the modal or hit escape, they would go back to the grid of photos scrolled to the exact position that photo was in. This made for a great user experience, especially when folks shared dynamic photos that were further down the page.

我们实现的另一项实用功能是持续追踪模态框（modal）中当前显示的照片，这样当用户点击模态框外部或按下 Esc 键关闭模态框时，页面会自动返回到照片网格，并将视图滚动至该照片原本所在的确切位置。这一设计显著提升了用户体验，尤其在用户分享位于页面较下方的动态照片时效果尤为明显。

We did this by keeping track of the last known photo in the modal, then using the browser `scrollIntoView` method to scroll to that specific ref when the user exited the modal.

我们通过记录模态框中最后显示的照片，然后在用户退出模态框时调用浏览器原生的 `scrollIntoView` 方法，滚动至对应 DOM 元素的引用（ref），从而实现了这一功能。

```javascript
import Image from "next/image";

import Link from "next/link";

import { useEffect, useRef } from "react";

import { useLastViewedPhoto } from "../utils/useLastViewedPhoto";



export default function GridImage() {

7  const router = useRouter();

8  const { photoId } = router.query;



10  const [lastViewedPhoto, setLastViewedPhoto] = useLastViewedPhoto();
```

```javascript
导入 Image 组件（来自 "next/image"）。

导入 Link 组件（来自 "next/link"）。

从 "react" 导入 useEffect 和 useRef 钩子。

从 "../utils/useLastViewedPhoto" 导入自定义钩子 useLastViewedPhoto。



默认导出函数组件 GridImage()：

7  声明常量 router，用于获取 Next.js 路由对象。

8  从路由查询参数中解构出 photoId。



10  使用 useLastViewedPhoto 自定义钩子，声明 lastViewedPhoto 状态及其设置函数 setLastViewedPhoto。
```

11  const lastViewedPhotoRef = useRef<HTMLAnchorElement>(null);

11  const lastViewedPhotoRef = useRef<HTMLAnchorElement>(null);

13  useEffect(() => {

13  useEffect(() => {

14    // This effect keeps track of the last viewed photo in the modal

14    // 此副作用用于跟踪模态框中最后查看的照片

15    if (lastViewedPhoto && !photoId) {

15    if (lastViewedPhoto && !photoId) {

16      lastViewedPhotoRef.current.scrollIntoView({ block: "center" });

16      lastViewedPhotoRef.current.scrollIntoView({ block: "center" });

17      setLastViewedPhoto(null);

17      setLastViewedPhoto(null);

18    }

18    }

19  }, [photoId, lastViewedPhoto, setLastViewedPhoto]);

19  }, [photoId, lastViewedPhoto, setLastViewedPhoto]);

21  return (

21  返回（

22    <Link

22    `<Link`

23      key={id}

23      `key={id}`

24      href={`/?photoId=${id}`}

24      `href={`/?photoId=${id}`}`

25      as={`/p/${id}`}

25      `as={`/p/${id}`}`

26      ref={id === lastViewedPhoto ? lastViewedPhotoRef : null}

26      `ref={id === lastViewedPhoto ? lastViewedPhotoRef : null}`

27      shallow

27      `shallow`

28      className="..."

28      `className="..."`

29    >

29    `>`

30      <Image src="..." width={720} height={480} />

30      `<Image src="..." width={720} height={480} />`

31    </Link>

31    </Link>

32  );

32  );

33}
```

33}
```

## Final performance

## 最终性能表现

All the decisions we made led to a website that not only has a nearly perfect Lighthouse score and great core web vitals, but feels snappy to use while handling hundreds of images.

我们所做的所有决策，最终打造出一个网站：它不仅拥有近乎完美的 Lighthouse 分数和出色的核心网页指标（Core Web Vitals），而且在处理数百张图片时依然响应迅速、操作流畅。

![Lighthouse score for the image gallery site.](images/build-a-fast-animated-image-gallery-with-next_js-vercel/img_004.jpg)Lighthouse score for the image gallery site.

![图片库网站的 Lighthouse 分数。](images/build-a-fast-animated-image-gallery-with-next_js-vercel/img_004.jpg)图片库网站的 Lighthouse 分数。

## Clone and deploy today

## 立即克隆并部署

We hope this walkthrough helps outline some of the challenges we faced and our thought process for handling them. You can visit the [Next.js Conf Image Gallery site](https://nextjsconf-pics.vercel.app/) to see everything we talked about in action or [clone and deploy](https://vercel.com/templates/next.js/image-gallery-starter) your own today.

我们希望本次教程能清晰呈现我们所面临的部分挑战，以及应对这些问题的思考过程。您可以访问 [Next.js Conf 图片库网站](https://nextjsconf-pics.vercel.app/)，亲身体验本文所讨论的所有功能；或立即 [克隆并部署](https://vercel.com/templates/next.js/image-gallery-starter) 属于您自己的版本。

Want to get started with Next.js on Vercel? [Here's a trial](https://vercel.com/signup?next=/dashboard?createTeam=true) to get you deploying on the only infrastructure that will always support the latest Next.js features the moment they release.

想在 Vercel 上快速开始使用 Next.js？[点击此处试用](https://vercel.com/signup?next=/dashboard?createTeam=true)，即可在唯一能够即时支持最新 Next.js 功能发布的基础设施上完成部署——新功能一经发布，立即可用。