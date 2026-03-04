---
title: "Optimizing web fonts - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/optimizing-web-fonts"
date: "2023-09-26"
scraped_at: "2026-03-02T09:50:40.278105613+00:00"
language: "en-zh"
translated: true
description: "Learn how to optimize web fonts using resource hints, font-face descriptors, and the next/font module."
---
{% raw %}

Sep 26, 2023

2023 年 9 月 26 日

Learn how to optimize web fonts using resource hints, font-face descriptors, and the next/font module.

学习如何利用资源提示（resource hints）、`@font-face` 描述符以及 `next/font` 模块来优化网页字体。

Web fonts are vital to branding and user experience. However, the inconsistent rendering of these fonts while they're being fetched from the server can cause unintended shifts in layout.

网页字体对品牌塑造和用户体验至关重要。然而，这些字体在从服务器加载过程中渲染不一致，可能导致布局发生意外偏移。

Luckily, there are solutions to minimize unexpected shifts and enhance the user experience when working with web fonts.

幸运的是，我们有多种方案可最大限度减少意外偏移，并在使用网页字体时提升用户体验。

Ever noticed a split-second change in the font while a page loads? Or even no text at all for a short moment?

您是否曾在页面加载时，注意到字体在极短时间内发生变化？甚至在极短的一瞬间完全看不到文字？

![](images/optimizing-web-fonts-vercel/img_001.jpg)

![](images/optimizing-web-fonts-vercel/img_001.jpg)

These flashes of invisible and unstyled text happen because the browser is still fetching the web font from the server that hosts the fonts.

这类“不可见文本闪烁”（FOIT）和“未样式文本闪烁”（FOUT）现象的发生，是因为浏览器仍在从托管字体的服务器获取网页字体。

Luckily, the **`font-display`** property gives developers control over this behavior by setting it to either `block`, `swap`, `fallback`, `optional`, or `auto`.

幸运的是，**`font-display`** 属性使开发者能够通过将其设为 `block`、`swap`、`fallback`、`optional` 或 `auto` 来控制这一行为。

**`block`** can be used to prioritize **visual consistency** by keeping text invisible for a couple seconds. If the custom font hasn't loaded within that time, it shows a fallback until the custom font is available.

**`block`** 值可用于优先保障**视觉一致性**：在最初几秒钟内使文字保持不可见；若自定义字体在此时限内尚未加载完成，则先显示后备字体，直至自定义字体可用为止。

![](images/optimizing-web-fonts-vercel/img_002.jpg)

![](images/optimizing-web-fonts-vercel/img_002.jpg)

You can use **`swap`** to make the **content visible immediately** by rendering a fallback font first, which is then switched to the custom font once loaded.

您可以使用 **`swap`**，通过先渲染一个备用字体（fallback font），待自定义字体加载完成后再切换过去，从而让**内容立即可见**。

![](images/optimizing-web-fonts-vercel/img_003.jpg)

**`fallback`** provides a balance between `block` and `swap`. It briefly renders invisible text, and defaults to the fallback font. If the web font still hasn’t loaded after 3 seconds, the fallback font remains even if the custom font loads later. Future navigations will display the custom font.

**`fallback`** 在 `block` 和 `swap` 之间取得平衡：它会短暂地将文本渲染为不可见状态，随后默认使用备用字体；若网络字体在 3 秒后仍未加载完成，则即使之后该字体最终加载成功，仍将始终沿用备用字体；而在后续的页面导航中，则会直接显示已缓存的自定义字体。

![](images/optimizing-web-fonts-vercel/img_004.jpg)

**`optional`** lets the browser decide whether to use the web font based on factors like network speed. If the font is cached and loads within 100ms, the custom font is displayed. Otherwise, the fallback font remains.

**`optional`** 允许浏览器根据网络速度等因素自主决定是否使用网络字体：若字体已缓存且能在 100 毫秒内完成加载，则显示自定义字体；否则，始终保留备用字体。

![](images/optimizing-web-fonts-vercel/img_005.jpg)

**`auto`** lets the browser decide which strategy to use, typically defaulting to **`swap`**.

**`auto`** 由浏览器自主选择采用哪种策略，通常默认使用 **`swap`**。

## **Ensuring Consistency with Fallback Fonts**

## **借助备用字体保障视觉一致性**

If you choose to display a fallback font, it is important to ensure that this fallback font closely matches the intended web font. However, this can be tricky because fonts have different measurements. Even if the fallback font and the web font have the same **`font-size`**, layout shift can still occur.

若您选择显示备用字体，则需确保该备用字体与目标网络字体在视觉上高度接近。然而这颇具挑战性，因为不同字体具有各异的度量参数（metrics）；即便备用字体与网络字体设置了相同的 **`font-size`**，仍可能发生布局偏移（layout shift）。

![Despite having the same font-size value, fonts can take up different amounts of space.](images/optimizing-web-fonts-vercel/img_006.jpg)  
![尽管字号值相同，不同字体实际占用的空间可能截然不同。](images/optimizing-web-fonts-vercel/img_006.jpg)  
Despite having the same font-size value, fonts can take up different amounts of space.  
尽管字号值相同，不同字体实际占用的空间可能截然不同。

One way to address this issue is by using the **`size-adjust`** font-face descriptor.

解决此问题的一种方法是使用 **`size-adjust`** 字体面描述符。

**`size-adjust`** scales all metrics associated with the font by a specified percentage. By adjusting the size to match the web font, the text size will remain (roughly) the same even if the font is swapped from the fallback to the web font. This can help prevent unexpected changes in the page layout.

**`size-adjust`** 将字体相关所有度量值按指定百分比进行缩放。通过将尺寸调整为与 Web 字体匹配，即使字体从备用字体切换为 Web 字体，文本尺寸也能（大致）保持不变。这有助于防止页面布局发生意外变化。

![](images/optimizing-web-fonts-vercel/img_007.jpg)

![](images/optimizing-web-fonts-vercel/img_007.jpg)

If you want even more control, you can use other CSS descriptors such as **`ascent-override`**, **`descent-override`**, and **`line-gap-override`** to define the ascent metric, descent metric, and line gap.

如果需要更精细的控制，还可使用其他 CSS 描述符，例如 **`ascent-override`**、**`descent-override`** 和 **`line-gap-override`**，分别定义上升部（ascent）、下降部（descent）和行间距（line gap）。

![](images/optimizing-web-fonts-vercel/img_008.jpg)

![](images/optimizing-web-fonts-vercel/img_008.jpg)

By using the appropriate fallback font and setting the necessary overrides, you can ensure that your users experience minimal layout shift when the custom font eventually loads in.

通过选用合适的备用字体并设置必要的覆盖参数，可确保在自定义字体最终加载完成时，用户所感知到的布局偏移（layout shift）降至最低。

## Reducing **Download Times**

## 缩短**下载时间**

The time it takes to request a web font from the server can be an issue. To speed up this process, we can utilize the **`preconnect`** and **`preload`** resource hints.

从服务器请求 Web 字体所需的时间可能成为性能瓶颈。为加快该过程，我们可以利用 **`preconnect`** 和 **`preload`** 这两类资源提示（resource hints）。

By using **`preconnect`**, we instruct the browser to establish a connection to the server hosting the font as soon as the page starts loading. This can significantly improve the speed at which the font is downloaded and displayed.

借助 **`preconnect`**，我们可指示浏览器在页面开始加载时即与托管该字体的服务器建立连接。此举可显著提升字体的下载与渲染速度。

![](images/optimizing-web-fonts-vercel/img_009.jpg)

![](images/optimizing-web-fonts-vercel/img_009.jpg)

With **`preload`**, we direct the browser to begin fetching the font as early as possible, usually before the browser starts rendering the page. This prevents any potential issues with the font rendering incorrectly or changing while the page is loading, resulting in a seamless user experience.

使用 **`preload`**，我们指示浏览器尽可能早地开始获取字体，通常是在浏览器开始渲染页面之前。这可以避免字体在页面加载过程中出现渲染错误或发生样式变化等问题，从而带来流畅无缝的用户体验。

![](images/optimizing-web-fonts-vercel/img_010.jpg)

## **Auto-optimization with next/font**

## **借助 `next/font` 实现自动优化**

Adding **`preconnect`** and **`font-face`** descriptors can improve the performance of fonts on your website. It speeds up their loading time and defines their characteristics. However, manually adding these optimizations can be time-consuming and it's easy to forget something.

为字体添加 **`preconnect`** 和 **`font-face`** 描述符，可提升网站字体的加载性能：加快加载速度，并明确定义字体的各项特性。然而，手动添加这些优化措施既耗时又容易遗漏某些细节。

Ideally, we want our fonts to be optimized automatically. If you're using Next.js, you can use the [**` next/font`** module](https://nextjs.org/docs/app/api-reference/components/font) to easily add local and Google fonts to your website without worrying about optimization details.

理想情况下，我们希望字体能够被自动优化。如果你正在使用 Next.js，可通过 [`next/font`](https://nextjs.org/docs/app/api-reference/components/font) 模块轻松将本地字体和 Google 字体添加到网站中，而无需操心具体的优化细节。

This module handles many tasks for you, including:

该模块为你自动完成多项任务，包括：

- Downloading the web font at build time and serving it locally.

- 在构建时下载网页字体，并将其作为本地资源提供服务。

- Adding a fallback font that closely resembles your web font.

- 添加一种与你的网页字体高度相似的备用字体（fallback font）。

- Automatically preloading your font.

- 自动预加载你的字体。

At build time, the **`next/font`** module downloads the font stylesheet and font files, making them available locally. This eliminates the need for external requests.

在构建阶段，**`next/font`** 模块会下载字体样式表（font stylesheet）和字体文件，并将其保存至本地，从而完全避免了对外部资源的请求。

The module also provides a custom fallback font that closely matches the intended web font. It even calculates necessary measurements such as **`size-adjust`**, **`ascent-override`**, **`descent-override`**, and **`line-gap-override`** at build time.

该模块还提供一种自定义的备用字体，其外观与目标网页字体高度一致。它甚至能在构建时自动计算必要的度量值，例如 **`size-adjust`**、**`ascent-override`**、**`descent-override`** 和 **`line-gap-override`**。

Lastly, the module preloads fonts when a **`subset`** has been defined. This improves both performance and user experience. Preloaded fonts are downloaded as soon as possible, often before the browser renders the page.

最后，当定义了 **`subset`**（子集）时，该模块会预先加载字体。此举既提升了性能，也优化了用户体验。预加载的字体会被尽可能早地下载，通常在浏览器渲染页面之前即已完成。

By using this module, you can use web fonts worry-free. Your users will likely experience minimal or no layout shift, and no additional developer effort is required.

通过使用该模块，您可无忧无虑地使用网页字体。您的用户几乎不会遇到布局偏移（layout shift），且开发者无需额外投入精力。
{% endraw %}
