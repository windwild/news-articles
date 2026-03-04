---
title: "Images on the web - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/images-on-the-web"
date: "2023-10-10"
scraped_at: "2026-03-02T09:50:03.600987575+00:00"
language: "en-zh"
translated: true
description: "Learn about the differences between the image formats JPEG, PNG, WebP, and AVIF with regards to compression techniques, resolution capabilities, pixel density, and effects on user experience for optim..."
---
&#123;% raw %}

Oct 10, 2023

2023年10月10日

Learn about the differences between image formats, compression techniques, resolution capabilities, pixel density, and effects on user experience.

了解不同图像格式、压缩技术、分辨率能力、像素密度以及它们对用户体验的影响。

Images are the most popular resource type on the web, yet understanding the nuances of various image formats and their technical attributes can be challenging.

图像是在网页上使用最广泛的资源类型，然而，要深入理解各类图像格式及其技术特性却颇具挑战性。

In this guide, we'll cover the popular image formats JPEG, PNG, WebP, and AVIF. We will discuss their differences in image compression, resolution, pixel density, how these factors affect the way images are presented online, and their impact on user experience.

本指南将介绍主流图像格式：JPEG、PNG、WebP 和 AVIF。我们将探讨它们在图像压缩、分辨率、像素密度等方面的差异，分析这些因素如何影响图像在网络上的呈现效果，以及它们对用户体验的影响。

Before jumping into formats, let’s cover a few important image concepts.

在深入探讨具体格式之前，我们先来了解几个重要的图像概念。

## Compression Algorithms

## 压缩算法

Image compression **reduces the size of an image file without significantly degrading its visual quality**, which is important for fast data transmission and efficient caching. Whether you're viewing a website, sharing a photo over a messaging app, or storing thousands of pictures on a cloud server, image compression plays a critical role.

图像压缩**在不显著降低视觉质量的前提下减小图像文件的大小**，这对于实现快速数据传输和高效缓存至关重要。无论你是在浏览网站、通过即时通讯应用分享照片，还是在云服务器上存储成千上万张图片，图像压缩都起着关键作用。

There are two main types of image compression:

图像压缩主要有两种类型：

1. **Lossy compression**: As the name implies, some data is lost while using this approach. To reduce the file size, less crucial data from the original image is removed. When used excessively, it can cause visible artifacts and a notable drop in image quality, yet it typically results in a reduction in storage requirements.

1. **有损压缩（Lossy compression）**：顾名思义，该方法在压缩过程中会丢失部分数据。为减小文件体积，原始图像中相对不重要的数据会被移除。若过度使用，可能导致肉眼可见的压缩伪影（artifacts），并显著降低图像质量；但通常能大幅减少存储空间占用。

2. **Lossless compression**: This technique ensures that once an image is compressed, it can be perfectly decompressed back to its original state without any data loss. This makes it the perfect option to choose _during the encoding process_ for images needing to retain visual integrity. Several file types, including PNG and some variations of WebP, use lossless compression.

2. **无损压缩（Lossless compression）**：该技术可确保图像经压缩后，能被完全无损地还原为原始状态，不丢失任何数据。因此，对于需要严格保持视觉完整性的图像，在编码阶段选择无损压缩是理想方案。PNG 格式及部分 WebP 变体均采用无损压缩。

## **Pixel Density and Resolution**

## **像素密度与分辨率**

Pixel density refers to the **number of pixels present per unit of display area**, typically measured as Pixels Per Inch (PPI).

像素密度是指**单位显示面积内所包含的像素数量**，通常以每英寸像素数（PPI）来衡量。

Resolution is the **total count of pixels in an image's width and height**. Devices with high pixel densities, e.g. Retina displays, may require images with higher resolutions to appear crisp. However, larger resolutions come at the cost of larger file sizes.

分辨率是指**图像宽度和高度方向上像素总数**。高像素密度设备（例如 Retina 显示屏）可能需要更高分辨率的图像才能呈现清晰锐利的效果；但更高的分辨率也意味着更大的文件体积。

![](images/images-on-the-web-vercel/img_001.jpg)

## **Bit Depth**

## **位深度**

Bit depth determines the **amount of color information stored for each pixel in an image**.

位深度决定了**图像中每个像素所存储的色彩信息量**。

A higher bit depth allows for more colors and often results in richer, more nuanced images. A typical 8-bit image can represent 256 colors, while a 16-bit image can represent 65,536 colors.

更高的位深度支持更多颜色，通常可呈现更丰富、更细腻的图像效果。典型的 8 位图像可表示 256 种颜色，而 16 位图像则可表示 65,536 种颜色。

![](images/images-on-the-web-vercel/img_002.jpg)

However, this richness comes with a trade-off of a higher file size. Web developers must balance the need for color accuracy with the realities of bandwidth and loading speeds.

然而，这种色彩丰富性是以更大的文件体积为代价的。Web 开发者必须在色彩准确性需求与带宽限制、页面加载速度等现实因素之间取得平衡。

## **Chroma Subsampling**

## **色度子采样**

While the RGB (Red, Green, Blue) paradigm is the most straightforward and commonly recognized color space, it may not always be the most efficient, especially when compression comes into the picture.

虽然 RGB（红、绿、蓝）模型是最直观且最广为人知的色彩空间，但在涉及压缩时，它并不总是最高效的方案。

Instead, the YCbCr color space plays a key role in both image and video compression.

相反，YCbCr 色彩空间在图像与视频压缩中扮演着关键角色。

1. **Y (Luminance)**: Y stands for the luminance component, which holds the information on how bright or dark a pixel is, completely devoid of its color attributes.

1. **Y（亮度）**：Y 代表亮度分量，表示像素的明暗程度，完全不包含任何颜色信息。

2. **Cb & Cr (Chrominance)**: These two components encapsulate the color data. Specifically, Cb captures the variance of blue in a pixel relative to its brightness (Y), and Cr represents the variance of red. The green component, interestingly enough, is derived from the Y, Cb, and Cr values rather than being stored directly.

2. **Cb 与 Cr（色度）**：这两个分量共同承载颜色信息。具体而言，Cb 表示像素中蓝色分量相对于其亮度（Y）的偏差，Cr 表示红色分量的偏差。有趣的是，绿色分量并非直接存储，而是由 Y、Cb 和 Cr 的值联合推导得出。

Human eyes are more attuned to changes in brightness (luminance) than color (chrominance). Chroma subsampling reduces the resolution of the chrominance channels (Cb and Cr) more than that of the luminance (Y) channel.

人眼对亮度（luminance）变化的敏感度远高于对颜色（chrominance）变化的敏感度。色度子采样（chroma subsampling）因此会比亮度（Y）通道更大幅度地降低色度通道（Cb 和 Cr）的分辨率。

Algorithms for image compression use this characteristic by keeping information where it matters most and reducing data where our eyes are less likely to notice the difference by knowing which areas of a picture are more "forgiving" to data loss or error due to human perception.

图像压缩算法正是利用这一视觉特性：在人眼最敏感的区域保留关键信息，而在人眼不易察觉差异的区域主动减少数据量——即依据人类视觉感知特性，识别图像中哪些区域对数据丢失或误差更具“容错性”。

Notations like 4:2:2, 4:4:4, and 4:1:1 describe how the chroma channels are subsampled relative to the luma channel.

诸如 4:2:2、4:4:4 和 4:1:1 这类记号，用于描述色度通道（chroma）相对于亮度通道（luma）的子采样方式。

![](images/images-on-the-web-vercel/img_003.jpg)

![](images/images-on-the-web-vercel/img_003.jpg)

- `4:4:4`: No subsampling. Each pixel has its dedicated luminance (Y) and chrominance (Cr, Cb) values. It has the highest fidelity in color representation, but also the largest data size.

- `4:4:4`：无子采样。每个像素均拥有独立的亮度（Y）和色度（Cr、Cb）值。该格式在色彩还原上保真度最高，但同时数据量也最大。

- `4:2:2`: For every 4 pixels, the luminance (Y) data is fully preserved, but the chrominance (Cr, Cb) data is averaged for 2 pixels and discarded for the other 2. This reduces file size with a moderate loss in quality.

- `4:2:2`：每 4 个像素为一组，亮度（Y）数据完整保留；而色度（Cr、Cb）数据则对其中 2 个像素取平均值，另 2 个像素的色度信息被舍弃。该方式在画质仅有中等程度下降的前提下，显著减小了文件体积。

- `4:1:1`: For every 4 pixels, luminance (Y) data is retained, but chrominance (Cr, Cb) data is averaged for 1 pixel and discarded for the other 3. This offers more compression than `4:2:2` but with a greater loss in color detail.

- `4:1:1`：每 4 个像素中，亮度（Y）数据被完整保留；而色度（Cr、Cb）数据仅对其中 1 个像素取平均值并保留，其余 3 个像素的色度信息则被丢弃。相比 `4:2:2`，该格式可实现更高程度的压缩，但色度细节损失也更明显。

- `4:4:0`: For every 4 pixels in a horizontal line, the luminance (Y) data is individually preserved for each, ensuring full brightness detail. Chrominance (Cr, Cb) data is averaged for 2 pixels and then shared between those 2 pixels on a single row, discarding any chrominance information vertically. This results in color detail being preserved horizontally, but a loss of color fidelity vertically.

- `4:4:0`：在每一行的每 4 个水平像素中，亮度（Y）数据为每个像素单独保留，确保完整的亮度细节；而色度（Cr、Cb）数据则对每 2 个像素取一次平均值，并将该平均值共享给同一行中的这 2 个像素，同时完全舍弃垂直方向上的所有色度信息。因此，该格式可在水平方向上保留色度细节，但在垂直方向上会损失色彩保真度。

The more you subsample (move away from `4:4:4`), the smaller our image file becomes. But, if we simplify too much, the colors in our image might not look as true to the original. It's a balance between file size and image quality.

采样率越低（即越偏离 `4:4:4`），图像文件体积就越小；但若过度简化，图像颜色可能就无法真实还原原始效果。这本质上是在文件体积与图像质量之间寻求平衡。

## **Progressive vs. Baseline Loading**

## **渐进式加载 vs. 基线加载**

The manner in which an image appears on a user's screen can influence their perception of loading speed and overall website performance. Two popular methods for loading images are **progressive** and **baseline**.

图像在用户屏幕上的呈现方式，会影响其对加载速度及网站整体性能的感知。目前两种主流的图像加载方式是**渐进式（progressive）**和**基线式（baseline）**。

With **baseline loading**, images load from top to bottom. When a user visits a web page, they'll first see the top part of the image, and as more data is loaded, the rest of the image gradually reveals itself from top to bottom.

采用**基线式加载**时，图像自上而下逐行显示。当用户访问网页时，首先看到的是图像顶部区域；随着更多数据加载完成，图像其余部分自上而下逐步显现。

![Baseline loading](images/images-on-the-web-vercel/img_004.jpg)Baseline loading

![基线式加载](images/images-on-the-web-vercel/img_004.jpg)基线式加载

**Progressive loading** offers a different approach. Instead of displaying an image from top to bottom, the entire image is displayed in a lower quality initially, which gradually improves in quality as more data is loaded. The advantage here is that users get a quick preview of the entire image instantly, which can increase the perceived performance even if the image isn't sharp initially.

**渐进式加载**则采用另一种策略：图像并非自上而下显示，而是初始即以较低分辨率呈现整幅图像，随后随着更多数据加载完成，图像质量逐步提升。其优势在于，用户能立即获得整张图像的快速预览，即便初始图像不够清晰，也能显著提升用户对加载性能的主观感受。

![Progressive loading](images/images-on-the-web-vercel/img_005.jpg)Progressive loading

![渐进式加载](images/images-on-the-web-vercel/img_005.jpg)渐进式加载

For some image formats, the decision between progressive and baseline loading is made during the encoding phase. This means that when an image is converted to a particular format (e.g. JPEG), it's determined how it will load when displayed. Once encoded in a particular method, it cannot be changed without re-encoding the image.

对于某些图像格式（例如 JPEG），采用渐进式还是基线式加载，是在编码阶段决定的。换言之，当图像被转换为特定格式时，其最终在网页上呈现的加载方式即已确定；一旦以某种方式完成编码，若不重新编码，便无法更改其加载模式。

However, a few newer image formats (WebP, AVIF, and JPEG XL) allow for more flexibility by enabling the choice between progressive and baseline at the decoding phase, when the picture is read and presented. This flexibility is especially useful in dynamic online contexts, as the ideal loading technique may change depending on user conditions like network speeds, device type, browser, or user preferences.

然而，一些较新的图像格式（WebP、AVIF 和 JPEG XL）通过在解码阶段（即图像被读取和呈现时）支持渐进式（progressive）与基础式（baseline）之间的选择，提供了更高的灵活性。这种灵活性在动态的在线场景中尤为有用，因为理想的加载方式可能随用户的网络速度、设备类型、浏览器或用户偏好等条件而变化。

## ) **Alpha Channel (Transparency)**

## ) **Alpha 通道（透明度）**

An alpha channel stores information about the transparency level of each pixel in an image. This is especially useful for web design, allowing images to blend with varying backgrounds seamlessly. Formats like PNG and WebP support the alpha channel, offering transparent backgrounds that can be important for web design elements.

Alpha 通道用于存储图像中每个像素的透明度信息。这在网页设计中尤其有用，可使图像无缝融合于不同背景之中。PNG 和 WebP 等格式支持 Alpha 通道，能提供透明背景，对网页设计元素（如图标、徽标、叠加图层等）至关重要。

## **Metadata and Exif Data**

## **元数据与 Exif 数据**

Images often contain metadata, which is information about the image that isn't directly related to the picture content.

图像通常包含元数据（metadata），即与图像内容本身无直接关系、但描述图像相关信息的数据。

Metadata provides insight into how a particular image was shot by exposing the aperture, shutter speed, ISO settings, and so on. Additionally, the date and geolocation data can create a better UI, or help organize images based on location.

元数据可通过揭示光圈值、快门速度、ISO 设置等参数，帮助我们了解某张图像的拍摄方式。此外，拍摄日期与地理定位（geolocation）数据不仅能提升用户界面体验，还可辅助按地理位置对图像进行归类整理。

![Exif data demo: https://photos.sambecker.com/](images/images-on-the-web-vercel/img_006.jpg)Exif data demo: https://photos.sambecker.com/

![Exif 数据演示：https://photos.sambecker.com/](images/images-on-the-web-vercel/img_006.jpg)Exif 数据演示：https://photos.sambecker.com/

However, while it offers valuable information about the photograph (camera settings, date and time, and optionally even the software used) it can **increase the file size**.

然而，尽管 Exif 数据提供了关于照片的宝贵信息（如相机设置、拍摄日期与时间，甚至可选的所用软件），但它**会增大文件体积**。

Additionally, Exif data might cause **privacy and security concerns**. Users can unknowingly share a picture with the geolocation coordinates of where a photo was taken. They could inadvertently disclose their location or the location of other significant places (like their home, workplace, etc.). This poses obvious risks, from simple privacy breaches to stalking or worse. Libraries like [**piexifjs**](https://github.com/hMatoba/piexifjs) can be used to read, edit, and erase Exif data if necessary.

此外，Exif 数据还可能引发**隐私与安全风险**。用户可能在无意中分享一张附带拍摄地点地理坐标的图片，从而意外暴露自身位置，或泄露其他重要场所（如家庭住址、工作地点等）的位置信息。此类风险显而易见——轻则造成隐私泄露，重则可能导致跟踪甚至更严重的后果。必要时，可借助 [**piexifjs**](https://github.com/hMatoba/piexifjs) 等库来读取、编辑或清除 Exif 数据。

Finally, let's compare the different image formats by looking at their implementation differences and use cases.

最后，让我们通过考察各图像格式在实现方式与适用场景上的差异，对其展开对比分析。

## ) **JPEG (Joint Photographic Experts Group)**

## ) **JPEG（联合图像专家组）**

JPEG 也许是人们最熟悉的图像格式，在互联网和数字摄影领域已沿用数十年。

JPEG 也许是人们最熟悉的图像格式，在互联网和数字摄影领域已沿用数十年。

- **压缩方式：** JPEG 主要采用有损压缩（lossy compression），即压缩过程中会丢失部分图像数据。JPEG 使用 YCbCr 色彩空间，将图像独特地分离为亮度（明度，luminance）与色度（chrominance）分量，从而可根据人眼对亮度更敏感、对色度较不敏感的视觉特性，进行有针对性的压缩。

- **压缩方式：** JPEG 主要采用有损压缩（lossy compression），即压缩过程中会丢失部分图像数据。JPEG 使用 YCbCr 色彩空间，将图像独特地分离为亮度（明度，luminance）与色度（chrominance）分量，从而可根据人眼对亮度更敏感、对色度较不敏感的视觉特性，进行有针对性的压缩。

- **特性：** JPEG 图像支持两种加载方式：基础式（baseline）与渐进式（progressive）。它不支持透明度（transparency），因此所有 JPEG 图像均具有不透明的实心背景。

- **特性：** JPEG 图像支持两种加载方式：基础式（baseline）与渐进式（progressive）。它不支持透明度（transparency），因此所有 JPEG 图像均具有不透明的实心背景。

- **适用场景：** JPEG 最适合用于对细节轻微损失可接受的照片类图像。其高压缩比特性使其成为网页应用的理想选择——在带宽与存储空间受限的环境中尤为关键。而对于需要锐利边缘或透明背景的图形（如图标、矢量插图等），其他图像格式可能是更优选择。

- **适用场景：** JPEG 最适合用于对细节轻微损失可接受的照片类图像。其高压缩比特性使其成为网页应用的理想选择——在带宽与存储空间受限的环境中尤为关键。而对于需要锐利边缘或透明背景的图形（如图标、矢量插图等），其他图像格式可能是更优选择。

[JPEG XL](https://jpeg.org/jpegxl/) 是一种新一代图像格式，也是 JPEG 的继任者，同时支持无损与有损压缩，在保持向后兼容性的同时，满足现代图像需求，例如更高动态范围（HDR）与更快解码速度。然而，目前浏览器对其支持仍[极为有限](https://caniuse.com/jpegxl)。

[JPEG XL](https://jpeg.org/jpegxl/) 是一种新一代图像格式，也是 JPEG 的继任者，同时支持无损与有损压缩，在保持向后兼容性的同时，满足现代图像需求，例如更高动态范围（HDR）与更快解码速度。然而，目前浏览器对其支持仍[极为有限](https://caniuse.com/jpegxl)。

## ) **PNG (Portable Network Graphics)**

## ) **PNG（便携式网络图形）**

PNG 最初作为 GIF 格式的继任者而开发，为网页图形提供了更强大、更全面的功能集。

PNG 最初作为 GIF 格式的继任者而开发，为网页图形提供了更强大、更全面的功能集。

- **压缩方式：** PNG 采用无损压缩（lossless compression），确保原始图像的所有细节在压缩与解压缩后均完整保留。

- **压缩方式：** PNG 采用无损压缩（lossless compression），确保原始图像的所有细节在压缩与解压缩后均完整保留。

- **特性：** PNG 的突出特性之一是支持通过 Alpha 通道实现透明度（transparency），从而可精细呈现阴影、半透明等复杂视觉效果。PNG 图像的位深度（bit-depth）可变，因而可在色彩表现力与文件体积之间灵活权衡。

- **特性：** PNG 的突出特性之一是支持通过 Alpha 通道实现透明度（transparency），从而可精细呈现阴影、半透明等复杂视觉效果。PNG 图像的位深度（bit-depth）可变，因而可在色彩表现力与文件体积之间灵活权衡。

- **Use Cases:** PNG is ideal for graphics that demand sharpness and clarity, such as logos, icons, or any design with text. The transparency feature is especially useful for overlaying images on varied backgrounds. However, the lossless compression may result in larger file sizes, which is not always ideal for complex photographs.

- **适用场景：** PNG 非常适合对清晰度和锐利度要求较高的图形，例如标志、图标或任何包含文字的设计。其透明度功能特别适用于将图像叠加在不同背景之上。然而，由于采用无损压缩，PNG 文件体积往往较大，因此并不总是适合复杂的照片。

## **WebP**

## **WebP**

Introduced by Google, WebP is a modern contender aiming to supersede both JPEG and PNG in terms of efficiency.

由 Google 推出，WebP 是一种现代图像格式，旨在以更高的效率取代 JPEG 和 PNG。

- **Compression:** WebP supports both lossless and lossy compression. Its advanced algorithms often lead to significantly smaller file sizes than both JPEG (at comparable quality) and PNG.

- **压缩方式：** WebP 同时支持无损和有损压缩。其先进算法通常能生成比 JPEG（在同等画质下）和 PNG 更小的文件体积。

- **Features:** WebP offers transparency similar to PNG and even supports animation (animated WebP).

- **特性：** WebP 具备与 PNG 类似的透明度支持，甚至还能实现动画效果（即“动画 WebP”）。

- **Use Cases:** Due to its versatility, WebP is suitable for various web images, from photographs to intricate graphics. Its efficient compression leads to faster web page loads, but it's essential to check [browser compatibility](https://caniuse.com/webp), as not all browsers fully support WebP.

- **适用场景：** 凭借其高度灵活性，WebP 适用于各类网页图像，从照片到精细图形皆可胜任。其高效的压缩能力有助于加快网页加载速度；但需注意浏览器兼容性——[并非所有浏览器都完全支持 WebP](https://caniuse.com/webp)，使用前务必核查。

## **AVIF (AV1 Image File Format)**

## **AVIF（AV1 图像文件格式）**

AVIF stems from the AV1 video codec and is created by Alliance for Open Media.

AVIF 源自 AV1 视频编解码器，由开放媒体联盟（Alliance for Open Media）开发。

- **Compression:** AVIF has impressive compression capabilities, both lossless and lossy. In many instances, it can outperform WebP in providing a better quality-to-size ratio.

- **压缩方式：** AVIF 具备卓越的无损与有损压缩能力。在许多情况下，其画质/体积比优于 WebP。

- **Features:** AVIF matches many of WebP's features, including transparency. Its primary advantage is its superior compression, which maintains high quality while reducing file sizes. While AVIF offers impressive compression and quality, one of its primary limitations is the speed of encoding and decoding. AVIF generally takes 20% longer to encode but it compresses 20% smaller compared to WebP. This slower speed can delay image rendering, especially when dealing with larger or multiple files. However, if the image is cached correctly, it will only be slower the first time the image is requested, subsequent (cached) requests will be faster.

- **特性：** AVIF 支持诸多与 WebP 相同的功能，包括透明度。其核心优势在于更出色的压缩性能——能在显著减小文件体积的同时维持高画质。尽管 AVIF 在压缩效率与画质方面表现优异，但其主要局限之一在于编解码速度较慢：AVIF 的编码耗时通常比 WebP 长约 20%，但相应地，其压缩后体积可减少约 20%。这种较慢的处理速度可能导致图像渲染延迟，尤其在处理大尺寸图像或多张图像时更为明显。不过，只要图像被正确缓存，仅首次请求时会出现延迟；后续（已缓存）的请求则会更快。

- **Use Cases:** Any scenario prioritizing top-notch image quality at minimal file sizes is where AVIF truly shines. As with WebP, its current limitation is [browser support](https://caniuse.com/avif).

- **适用场景：** AVIF 在任何需以最小文件体积实现极致图像质量的场景中均表现卓越。与 WebP 类似，其当前主要限制在于[浏览器兼容性](https://caniuse.com/avif)。

## Next.js Image component

## Next.js 的 Image 组件

Next.js includes built-in Image Optimization using the [**`next/image`**](https://nextjs.org/docs/pages/api-reference/components/image#) component which will automatically serve the correct size and format for the device.

Next.js 内置了图像优化功能，通过 [**`next/image`**](https://nextjs.org/docs/pages/api-reference/components/image#) 组件实现，可自动为不同设备提供适配的尺寸与图像格式。

You can configure the optimized image formats in `next.config.js` which will ensure that newer browsers can use newer formats and automatically fall back to older formats for older browsers.

您可在 `next.config.js` 中配置优化后的图像格式，从而确保新版本浏览器优先使用更新的图像格式，同时对旧版浏览器自动回退至兼容性更好的旧格式。

next.config.js

```javascript
module.exports = {

2   images: {

3      formats: ['image/avif', 'image/webp'],

4   },

5}
```

This configuration enables AVIF support. If the `images.formats` property is omitted, it defaults to WebP.

此配置启用 AVIF 支持。如果省略 `images.formats` 属性，则默认使用 WebP 格式。

This configuration will optimize images to the AVIF format if the browser supports it. If it doesn't, it will use the WebP format. If the browser supports neither format, then the original format is preserved.

该配置会在浏览器支持时将图片优化为 AVIF 格式；若不支持 AVIF，则回退至 WebP 格式；若浏览器两种格式均不支持，则保留原始格式。

Additionally, the component accepts a number of optional properties beyond those which are required, including the [`quality`](https://nextjs.org/docs/pages/api-reference/components/image#quality) and [`sizes`](https://nextjs.org/docs/pages/api-reference/components/image#sizes) prop.

此外，该组件除必需属性外，还支持若干可选属性，包括 [`quality`](https://nextjs.org/docs/pages/api-reference/components/image#quality) 和 [`sizes`](https://nextjs.org/docs/pages/api-reference/components/image#sizes) 属性。

The **`quality`** prop relates to the degree of lossy compression applied to an image. A lower quality setting means higher compression, which removes more data, resulting in a smaller file size. However, it also potentially reduces image clarity.

**`quality`** 属性控制图像所应用的有损压缩程度。质量值越低，压缩率越高，移除的数据越多，从而得到更小的文件体积；但同时也可能降低图像清晰度。

Conversely, a higher quality value will retain more of the image's original data, providing a clearer image but at the cost of a larger file size. In essence, adjusting the **`quality`** prop allows you to balance between image fidelity and file size.

反之，较高的质量值会保留更多图像原始数据，呈现更清晰的图像，但代价是文件体积更大。本质上，调整 **`quality`** 属性即是在图像保真度与文件大小之间取得平衡。

```jsx
1// Good quality. A balance between image clarity and file size, suitable for most web use cases.

1// 优质设置：在图像清晰度与文件大小之间取得良好平衡，适用于大多数网页应用场景。

2<Image quality={75} />

2<Image quality={75} />

4// Maximum quality. Ensures the best clarity but results in the largest file size.

4// 最高质量：确保最佳清晰度，但会导致最大文件体积。

5<Image quality={100} />

5<Image quality={100} />
```

7// Very low quality. The image will be compressed significantly, resulting in a smaller file size but noticeably reduced clarity.

7// 极低质量。图像将被大幅压缩，从而减小文件体积，但清晰度会明显下降。

8<Image quality={33} />

8<Image quality={33} />

The **`sizes`** prop informs the browser about the expected display size of the image on various screen sizes or viewport widths. This allows the browser to fetch the best resolution of the image from the **`srcset`**, which ensures that high pixel density displays receive higher resolution images for better clarity. Screens with standard pixel density get the usual resolution to conserve bandwidth.

**`sizes`** 属性用于向浏览器告知图像在不同屏幕尺寸或视口宽度下的预期显示尺寸。这使得浏览器能够从 **`srcset`** 中选取最适合的图像分辨率：高像素密度（PPI）屏幕可获得更高分辨率的图像以提升清晰度；而标准像素密度的屏幕则加载常规分辨率图像，以节省带宽。

```jsx
1// Takes full viewport width on screens up to 768 pixels wide, otherwise half viewport. Useful for mobile devices in portrait mode.

1// 在宽度不超过 768 像素的屏幕上占据整个视口宽度，否则占据视口宽度的一半。适用于竖屏模式下的移动设备。

2<Image sizes="(max-width: 768px) 100vw, 50vw" />

2<Image sizes="(max-width: 768px) 100vw, 50vw" />

4// Half viewport with on devices up to 768 pixels wide. For devices between 769 and 1200 pixels wide, it will take up a third of the viewport width. Useful for images in multi-column layouts

4// 在宽度不超过 768 像素的设备上占据视口宽度的一半；在宽度介于 769 至 1200 像素之间的设备上，占据视口宽度的三分之一。适用于多列布局中的图像。

5<Image sizes="(max-width: 768px) 50vw, (max-width: 1200px) 33vw, 20vw"  />

5<Image sizes="(max-width: 768px) 50vw, (max-width: 1200px) 33vw, 20vw"  />

7// Regardless of the device's width, the image will always render at 500 pixels wide.

7// 无论设备宽度如何，该图像始终以 500 像素的宽度渲染。

8<Image sizes="500px" />
8<Image sizes="500px" />

If you omit the `sizes` prop, Next.js assumes your image has a fixed dimension and handles pixel density appropriately. By including **`sizes`**, it tells Next.js that the image is responsive and will change depending on the viewport. [Learn more about responsive images in Next.js](https://nextjs.org/docs/pages/api-reference/components/image#responsive-images).

如果您省略 `sizes` 属性，Next.js 将默认该图像具有固定尺寸，并会相应地处理像素密度。而通过指定 **`sizes`**，您是在告知 Next.js：该图像是响应式的，其尺寸将随视口变化而变化。[了解更多关于 Next.js 中响应式图像的信息](https://nextjs.org/docs/pages/api-reference/components/image#responsive-images)。

## Conclusion

## 总结

Choosing the right image format can significantly impact user experience. Factoring in attributes like pixel density, bit depth, and chroma subsampling, along with privacy concerns related to metadata, ensures that images are not just visually appealing but also efficient and secure.

选择合适的图像格式可显著影响用户体验。综合考虑像素密度、位深度、色度子采样等属性，以及与元数据相关的隐私问题，能够确保图像不仅视觉效果出色，而且高效、安全。
&#123;% endraw %}
