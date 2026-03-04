---
title: "Introducing our latest image generation model in the API | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/image-generation-api"
date: "2025-04-23"
scraped_at: "2026-03-02T10:12:44.356362657+00:00"
language: "en-US"
translated: false
description: "Our latest image generation model is now available in the API via ‘gpt-image-1’—enabling developers and businesses to build professional-grade, customizable visuals directly into their own tools..."
tags: ["Product"]
---
&#123;% raw %}

April 23, 2025


# Introducing our latest image generation model in the API

[Try in Playground(opens in a new window)](http://platform.openai.com/playground/images?preset=sunglasses-sun)



When we introduced image generation in ChatGPT last month, it quickly became one of our most popular features: over 130 million users around the world created more than 700 million images in just the [first week⁠(opens in a new window)](https://www.linkedin.com/posts/bradlightcap_very-crazy-first-week-for-images-in-chatgpt-activity-7313616345667878912-RBzt/).

Today, we’re bringing the natively multimodal model that powers this experience in ChatGPT to the API via `gpt-image-1`, enabling developers and businesses to easily integrate high-quality, professional-grade image generation directly into their own tools and platforms. The model’s versatility allows it to create images across diverse styles, faithfully follow custom guidelines, leverage world knowledge, and accurately render text—unlocking countless practical applications across multiple domains.

Leading enterprises and startups across industries including creative tools, e-commerce, education, enterprise software, gaming, are already using image generation in their products and experiences. We’re excited to share some of these examples below.

**Adobe’s** leading ecosystem of creative tools including its Firefly and Express apps will provide access to OpenAI’s image generation capabilities, giving creators the choice and flexibility to experiment with different aesthetic styles—something business professionals, consumers and creators all value when generating new creative ideas.

We’re also continuing to work with developers and businesses to uncover more ways image generation in the API can serve their use cases, including:

**Designing and editing: Canva** is exploring ways to integrate OpenAI's `gpt-image-1` to push the boundaries of design generation and editing in its Canva AI and Magic Studio tools. Through `gpt-image-1` capabilities like transforming rough sketches into stunning graphic elements and enabling high-fidelity visual edits, Canva will further empower its 230 million users to bring their ideas to life in entirely new ways.

**Creating and editing logos: GoDaddy** is actively experimenting to integrate image generation so customers can easily create logos that are editable, remove backgrounds, and generate professional typography. In addition, as a new experience with GoDaddy Airo®, the team is working towards customers creating social media posts and marketing assets that reflect their unique brand identities for original product and brand content created from a prompt.

**Building marketing collateral: HubSpot** is exploring how OpenAI's new AI image generation capabilities can help customers create marketing and sales collateral. As HubSpot continues to add new AI-powered tools for scaling businesses, these image generation capabilities have the potential to transform how customers produce high-quality images for social media, email marketing, and landing pages without requiring specialized design expertise.

**Generating recipes and shopping lists: Instacart** is testing new ways to use the API for image generation, including images for recipes and shopping lists.

**Editing videos: invideo** enables millions of users to transform their ideas into videos using AI. With the integration of `gpt-image-1`, the platform now offers improved text generation, fine-grain editing controls, and advanced style guidance.

## Safety

The `gpt-image-1`model in the API leverages the same safety guardrails as 4o image generation in ChatGPT, including safeguards that restrict the model from generating harmful images and the inclusion of C2PA metadata in generated images—you can read more about this in our past blog post [here](https://openai.com/index/introducing-4o-image-generation/). Additionally, developers can also control moderation sensitivity with the \`moderation\` parameter, which can be set to **auto**(default) for standard filtering, or **low** for less restrictive filtering. Learn more in our [docs⁠(opens in a new window)](https://platform.openai.com/docs/api-reference/images).

By default, we never train on customer API data, and all image inputs and outputs remain subject to our [API usage policies.](https://openai.com/policies/usage-policies/)

## Pricing

Usage of `gpt-image-1` is priced per token, with separate pricing for text and image tokens:

- **Text input tokens (prompt text):** $5 per 1M tokens
- **Image input tokens (input images):** $10 per 1M tokens
- **Image output tokens (generated images):** $40 per 1M tokens

In practice, this translates to roughly $0.02, $0.07, and $0.19 per generated image for low, medium, and high-quality square images, respectively. For detailed pricing by image quality and size, see the [docs⁠(opens in a new window)](https://platform.openai.com/docs/pricing).

## Get started

The `gpt-image-1` model is now available globally via the Images API, with support in the Responses API coming soon. Some developers may need to [verify⁠(opens in a new window)](https://help.openai.com/en/articles/10910291-api-organization-verification) their organization before being able to use the model. Please check the [organization settings⁠(opens in a new window)](https://platform.openai.com/settings/organization/limits) to see if you already have access.

To get started, explore the model’s capabilities in the [playground⁠(opens in a new window)](https://platform.openai.com/playground/images) and check out our [image generation guide⁠(opens in a new window)](https://platform.openai.com/docs/guides/image-generation). We look forward to seeing what you build.

- [2025](https://openai.com/news/?tags=2025)
- [API Platform](https://openai.com/news/?tags=api-platform)
&#123;% endraw %}
