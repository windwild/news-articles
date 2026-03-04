---
title: "DALL·E 3 is now available in ChatGPT Plus and Enterprise | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/dall-e-3-is-now-available-in-chatgpt-plus-and-enterprise"
date: "2023-10-19"
scraped_at: "2026-03-02T10:22:11.086585132+00:00"
language: "en-US"
translated: false
description: "We developed a safety mitigation stack to ready DALL·E 3 for wider release and are sharing updates on our provenance research."
tags: ["Product"]
---
&#123;% raw %}

October 19, 2023


# DALL·E 3 is now available in ChatGPT Plus and Enterprise

We developed a safety mitigation stack to ready DALL·E 3 for wider release and are sharing updates on our provenance research.

[Read research paper(opens in a new window)](https://cdn.openai.com/papers/dall-e-3.pdf) [View DALL·E 3 system card](https://openai.com/index/dall-e-3-system-card/)

![Cloud astronaut](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_001.png)

Illustration: Valerie Ranum × DALL·E


4:17


## DALL·E 3 in ChatGPT

ChatGPT can now create unique images from a simple conversation—and this new feature is available to Plus and Enterprise users today. Describe your vision, and ChatGPT will bring it to life by providing a selection of visuals for you to refine and iterate upon. You can ask for revisions right in the chat. This is powered by our most capable image model, [DALL·E 3⁠](https://openai.com/index/dall-e-3/).

- [Science project](https://openai.com/index/dall-e-3-is-now-available-in-chatgpt-plus-and-enterprise/#)
- [Website design](https://openai.com/index/dall-e-3-is-now-available-in-chatgpt-plus-and-enterprise/#)
- [Business logo](https://openai.com/index/dall-e-3-is-now-available-in-chatgpt-plus-and-enterprise/#)

I am doing a report on cirrus clouds for my high school science class. I need photorealistic images that show off how wispy they are. I am going to compare them to photos I took of puffy cumulonimbus clouds at my house yesterday.

OAI

Here are the photorealistic images of cirrus clouds showcasing their wispy and delicate nature. You can compare these with the photos of cumulonimbus clouds you took to highlight the differences in their structures and appearances. If you need any further information or assistance, please let me know!

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_002.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_003.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_004.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_005.png)

## Research

DALL·E 3 is the culmination of several research advancements, both from within and outside of OpenAI. Compared to its predecessor, DALL·E 3 generates images that are not only more visually striking but also crisper in detail. DALL·E 3 can reliably render intricate details, including text, hands, and faces. Additionally, it is particularly good in responding to extensive, detailed prompts, and it can support both landscape and portrait aspect ratios. These capabilities were achieved by training a state-of-the art image captioner to generate better textual descriptions for the images that we trained our models on. DALL·E 3 was then trained on these improved captions, resulting in a model which heeds much more attention to the user-supplied captions. You can read more about this process in our [research paper⁠(opens in a new window)](https://cdn.openai.com/papers/dall-e-3.pdf).

## Responsible development and deployment

We use a multi-tiered safety system to limit DALL·E 3’s ability to generate potentially harmful imagery, including violent, adult or hateful content. Safety checks run over user prompts and the resulting imagery before it is surfaced to users. We also worked with early users and expert red-teamers to identify and address gaps in coverage for our safety systems which emerged with new model capabilities. For example, the feedback helped us identify edge cases for graphic content generation, such as sexual imagery, and stress test the model's ability to generate convincingly misleading images.

As part of the work done to prepare DALL·E 3 for deployment, we’ve also taken steps to limit the model’s likelihood of generating content in the style of living artists, images of public figures, and to improve demographic representation across generated images. To read more about the work done to prepare DALL·E 3 for wide deployment, see the [DALL·E 3 system card.⁠](https://openai.com/index/dall-e-3-system-card/)

User feedback will help make sure we continue to improve. ChatGPT users can share feedback with our research team by using the flag icon to inform us of unsafe outputs or outputs that don’t accurately reflect the prompt you gave to ChatGPT. Listening to a diverse and broad community of users and having real-world understanding is critical to developing and deploying AI responsibly and is core to our mission.

We’re researching and evaluating an initial version of a provenance classifier—a new internal tool that can help us identify whether or not an image was generated by DALL·E 3. In early internal evaluations, it is over 99% accurate at identifying whether an image was generated by DALL·E when the image has not been modified. It remains over 95% accurate when the image has been subject to common types of modifications, such as cropping, resizing, JPEG compression, or when text or cutouts from real images are superimposed onto small portions of the generated image. Despite these strong results on internal testing, the classifier can only tell us that an image was likely generated by DALL·E, and does not yet enable us to make definitive conclusions. This provenance classifier may become part of a range of techniques to help people understand if audio or visual content is AI-generated. It’s a challenge that will require collaboration across the AI value chain, including with the platforms that distribute content to users. We expect to learn a great deal about how this tool works and where it might be most useful, and to improve our approach over time.

## Creative controls

DALL·E 3 is designed to decline requests that ask for an image in the style of a living artist. We also offer the option for creators to [opt their images out⁠(opens in a new window)](https://share.hsforms.com/1_OuT5tfFSpic89PqN6r1CQ4sk30) from training of our future image generation models.

## Gallery

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_006.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_006.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_008.jpg)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_008.jpg)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_010.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_010.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_012.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_012.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_014.jpg)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_014.jpg)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_016.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_016.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_018.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_018.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_020.jpg)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_020.jpg)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_022.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_022.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_024.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_024.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_026.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_026.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_028.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_028.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_030.jpg)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_030.jpg)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_032.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_032.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_034.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_034.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_036.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_036.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_038.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_038.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_040.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_040.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_042.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_042.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_044.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_044.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_046.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_046.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_048.png)

![](images/dall_e-3-is-now-available-in-chatgpt-plus-and-enterprise-openai/img_048.png)

- [ChatGPT](https://openai.com/news/?tags=chatgpt)
- [2023](https://openai.com/news/?tags=2023)
&#123;% endraw %}
