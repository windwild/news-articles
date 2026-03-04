---
render_with_liquid: false
title: "How the world’s biggest YouTuber served millions of users on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/serving-millions-of-users-on-the-new-mrbeast-storefront"
date: "2022-09-29"
scraped_at: "2026-03-02T10:00:33.392860304+00:00"
language: "en-zh"
translated: true
description: "Find out how basement.studio balanced performance, entertainment, and reliability for MrBeast's new storefront. "
---
render_with_liquid: false
render_with_liquid: false

Sep 29, 2022

2022 年 9 月 29 日

_How do you build a site to support peak traffic, when peak traffic means a fanbase of over 100 million Youtube subscribers? In this guest post, Julian Benegas, Head of Development at basement.studio, walks us through balancing performance, entertainment, and keeping "the buying flow" as the star of the show for MrBeast's new storefront._

当“峰值流量”意味着拥有超 1 亿 YouTube 订阅者的庞大粉丝群体时，你该如何构建一个能从容应对的网站？在本文这篇客座投稿中，basement.studio 开发主管 Julian Benegas 将带我们深入剖析：如何在 MrBeast 全新线上商店项目中，兼顾性能表现、娱乐体验，并始终让“购物流程”成为整场演出的绝对主角。

It all started with a call from a media & TV company. Their merchandiser had big news to share—they were leading a new campaign for MrBeast, and [our studio](https://basement.studio/) would be designing and developing the storefront where his immense fanbase would shop.

一切始于一家媒体与电视公司的来电。他们的商品经理带来了一个重磅消息——他们正主导 MrBeast 的全新营销活动，而[我们的工作室](https://basement.studio/)将负责设计并开发该活动的线上商店，供 MrBeast 庞大的粉丝群体购物。

> “Anyone would be scared when confronted with a challenge this big, but when you have a dream team like ours, you can put those fears to rest.” Anyone would be scared when confronted with a challenge this big, but when you have a dream team like ours, you can put those fears to rest.” ”
>
> “面对如此巨大的挑战，任何人都会感到畏惧；但当你拥有一支像我们这样的梦之队时，这些担忧便可烟消云散。”  
> “面对如此巨大的挑战，任何人都会感到畏惧；但当你拥有一支像我们这样的梦之队时，这些担忧便可烟消云散。”  
>
> ![](images/how-the-world_s-biggest-youtuber-served-millions-of-users-on-vercel-vercel/img_001.jpg)
>
> **Jose Rago,** Founder & Partner at basement.studio
>
> **Jose Rago**，basement.studio 创始人兼合伙人

With MrBeast's almost 200 million followers across social channels, we knew Vercel could handle traffic, but we had never handled as much as MrBeast would bring.

凭借 MrBeast 在各大社交平台近 2 亿粉丝的体量，我们确信 Vercel 能够承载其流量压力；但我们此前从未处理过如此规模的访问量。

However, keeping the site up alone wasn’t enough. We needed to give every visitor a delightful shopping experience. That meant a top-notch experience in terms of both design and performance, with fun mini-games to make it feels like a MrBeast video. Most importantly, it had to direct users to buy.

然而，仅仅确保网站“在线”还远远不够。我们必须为每一位访客提供愉悦的购物体验——这既要求卓越的设计水准，也要求极致的性能表现；同时融入趣味十足的小游戏，让整个浏览过程宛如观看一支 MrBeast 视频。而最重要的是：它必须清晰、高效地引导用户完成购买。

[**Rely on the fastest frontend platform during peak traffic.**\\
\\
Chat with an expert to learn how Vercel can support your own fast, dynamic site.\\
\\
Contact Sales](https://vercel.com/contact/sales)

[**在流量峰值期间，依托全球最快的前端平台。**  
\\  
与专家一对一交流，了解 Vercel 如何助力您打造快速、动态的自有网站。  
\\  
联系销售](https://vercel.com/contact/sales)

## **Taking it to the lab**

## **走进实验室**

While designing the site, we had both concrete requirements and more abstract ones. The media company proposed the sitemap and content structure, then left it up to us to be creative. Their main goal: making sure people had fun on the site.

在网站设计阶段，我们既要满足明确具体的硬性需求，也要回应更抽象、更具延展性的目标。媒体公司提出了网站地图与内容架构的初步方案，随后将创意发挥的空间完全交予我们。他们的核心目标很明确：确保用户在网站上玩得尽兴。

After several brainstorming sessions, Lambo Jump was born—an infinite runner with similar mechanics to Google’s famous _“No Internet Connection T-REX Game”_, but with MrBeast style. We also knew that we couldn’t compromise the site’s performance because of this, so we loaded Lambo Jump’s JavaScript immediately when the user pressed the “play” button.

经过多轮头脑风暴，“Lambo Jump”应运而生——这是一款无限奔跑类小游戏，其核心机制借鉴了谷歌著名的离线彩蛋游戏 _“无网络连接时的 T-REX 小游戏”_，但整体风格全面融入 MrBeast 式的幽默与活力。与此同时，我们深知绝不能因加入游戏而牺牲网站性能，因此仅在用户点击“开始游戏”按钮后，才即时加载 Lambo Jump 所需的 JavaScript 脚本。

The game was a huge success, with MrBeast fans sharing their scores on Twitter, and some of them even filming YouTube videos about their experience playing it.

这款游戏大获成功，MrBeast 的粉丝们纷纷在 Twitter 上晒出自己的得分，其中一些人甚至专门拍摄 YouTube 视频，分享他们游玩这款游戏的体验。

While Lambo Jump was a good initial idea, we wanted something more. Inspired by the “Cookie Clicker” game, we came up with “Slap to Win”: a game where visitors would “slap” members of the MrBeast crew. The media company's team loved it, and suggested the game rewards could be actual products.

尽管“Lambo Jump”是一个不错的初步构想，但我们希望更进一步。受经典网页游戏“Cookie Clicker”启发，我们推出了“Slap to Win”（拍击赢奖）——一款让访客“拍击”MrBeast 团队成员的游戏。这家媒体公司的团队非常喜欢这个创意，并建议将游戏奖励设为真实可兑换的商品。

## **Challenges along the way**

## **过程中的挑战**

While it was the perfect combination—engaging visitors with a fun game that had real, redeemable rewards—we had one outstanding concern. Tech-savvy users could hack “Slap to Win” ( [which they did](https://github.com/nismo1337/shopmrbeastslaptowin)), and we were giving away real products as a result. We worked together with the media & TV company to incorporate game rules and rolled them out quickly on Vercel, ensuring that prizes would only be redeemable alongside other purchases and players would be able to redeem only one prize per purchase.

这本是完美的组合——用一款趣味十足、且奖励真实可兑的游戏吸引访客——但我们仍面临一个突出隐患：技术娴熟的用户可能破解“Slap to Win”（[他们确实这么做了](https://github.com/nismo1337/shopmrbeastslaptowin)），导致我们不得不发放真实商品作为奖励。为此，我们与该媒体及电视公司紧密协作，迅速将游戏规则集成并部署至 Vercel 平台，确保奖品仅能与其他商品一同下单时方可兑换，且每位玩家每次下单仅可兑换一份奖品。

We also solved the game’s logic server-side. With the help of Shopify’s Admin API, we created discount codes for the products that users redeemed, and luckily for our developers, Shopify’s Discounts API has fine-grain controls that allowed us to set rules exactly as we wanted to.

我们还把游戏逻辑全部迁移至服务端实现。借助 Shopify 的 Admin API，我们为用户所兑换的商品动态生成折扣码；幸运的是，Shopify 的 Discounts API 提供了精细的权限控制能力，使我们的开发人员得以精准设定所需规则。

## **Development and pre-launch stack**

## **开发与上线前的技术栈**

Throughout the project, success came down to three key tools: Vercel, Shopify, Axiom.

整个项目的成功，归功于三大核心工具：Vercel、Shopify 和 Axiom。

### **Vercel**

### **Vercel**

Vercel not only helped us iterate faster and deliver the site to all of our users—their Customer Success team also worked alongside us to ensure everything was set up correctly from our side and theirs. When asked if we’d be able to keep the site up despite high-volume and unpredictable traffic, we knew we could rely on Vercel to make it happen. We actually set a record on the Vercel platform for the most requested site in the span of a week. Stressful, but still, a great achievement.

Vercel 不仅帮助我们加速迭代、将网站高效交付给所有用户；其客户成功团队更全程与我们并肩协作，确保双方系统配置均准确无误。当被问及能否在高并发、不可预测的流量冲击下保障网站稳定运行时，我们确信 Vercel 能够胜任。事实上，该项目在 Vercel 平台上创下了“单周请求量最高网站”的纪录——虽令人倍感压力，却也是一项了不起的成就。

**Shopify**  

**Shopify**

[Shopify](https://vercel.com/integrations/shopify) is our go-to ecommerce provider, and their wide suite of features covered all our needs.  

[Shopify](https://vercel.com/integrations/shopify) 是我们首选的电子商务平台，其丰富全面的功能完全满足了我们的各项需求。

We leveraged their [Storefront API](https://shopify.dev/api/storefront), with a library built by us to connect to it in a type-safe manner: [react-dropify](https://github.com/basementstudio/react-dropify).  

我们深度集成了 Shopify 的 [Storefront API](https://shopify.dev/api/storefront)，并自主研发了一个类型安全的对接库：[react-dropify](https://github.com/basementstudio/react-dropify)。

They served all of MrBeast’s traffic just fine.  

该方案轻松承载了 MrBeast 全部的流量压力。

**Axiom**

**Axiom**

[Axiom](https://vercel.com/integrations/axiom) is a newcomer to “the basement stack” ™.  

[Axiom](https://vercel.com/integrations/axiom) 是“地下室技术栈”™ 的新成员。

They provide observability at scale, which allowed us to monitor everything that was happening on the site at all times.  

它提供大规模可观测性能力，使我们能够实时监控网站上发生的每一项操作与状态。

We created a Launch Dashboard which observed different metrics and errors and gave us the confidence to know everything was performing as it should.  

我们构建了一套上线监控仪表盘（Launch Dashboard），持续追踪各类关键指标与错误日志，从而确保系统始终按预期稳定运行。

## **The Beast and 100 million subscribers**

## **“野兽”与一亿订阅者**

Creating a merchandising experience for 100 million subscribers is a big ask.  

为一亿订阅者打造一套商品销售体验，是一项极具挑战性的任务。

Thanks to Vercel, Shopify, Axiom, and the media & TV company's team, we stuck to our mantra: make it cool, and make it perform.  

得益于 Vercel、Shopify、Axiom 以及这家媒体与电视公司的团队通力协作，我们始终坚守自己的信条：既要酷炫，更要高性能。

In the end, the work speaks for itself.  

最终，成果本身已不言自明。