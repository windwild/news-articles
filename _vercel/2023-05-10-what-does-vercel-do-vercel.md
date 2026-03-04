---
title: "What does Vercel do?  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/what-is-vercel"
date: "2023-05-10"
scraped_at: "2026-03-02T09:52:45.010674030+00:00"
language: "en-zh"
translated: true
description: "Technically newsletter founder Justin Gage explains how Vercel makes building web applications as easy as possible, powered by the frontend cloud."
---
&#123;% raw %}

May 10, 2023

2023年5月10日

"Technically" newsletter founder Justin Gage explains how Vercel makes building web applications as easy as possible, powered by the frontend cloud.

“Technically”通讯简报创始人 Justin Gage 解释了 Vercel 如何依托“前端云”（frontend cloud），将 Web 应用的构建过程简化到极致。

Vercel builds a **frontend-as-a-service** product—they make it easy for engineers to deploy and run the user facing parts of their applications.

Vercel 打造了一款 **“前端即服务”（frontend-as-a-service）** 产品——它让工程师能轻松部署并运行其应用中面向用户的前端部分。

- Applications have two parts: the frontend and the backend (have I [mentioned this before](https://technically.substack.com/p/the-details-frontends-and-backends)???)

- 应用通常由两部分组成：前端（frontend）与后端（backend）（我之前[提过这一点吗？](https://technically.substack.com/p/the-details-frontends-and-backends)???）

- The frontend is usually **deployed with the backend** on a single server (or set of servers), which means infrastructure to set up and manage

- 前端通常与后端**一同部署**在单台服务器（或一组服务器）上，这意味着需要自行搭建和运维基础设施。

- Vercel lets teams **deploy their frontend stupidly easily**, separately from their backend

- Vercel 让团队能够**以极简方式单独部署前端**，完全独立于后端。

- Deploying with Vercel gives you **nice features** like deploy previews, functions as a service, analytics, and more

- 使用 Vercel 部署，可获得一系列**实用功能**，例如部署预览（deploy previews）、函数即服务（Functions as a Service）、分析统计（analytics）等。

- Beyond just the frontend, Vercel has been adding cloud-like features like **storage and databases**

- 除前端能力外，Vercel 还持续加入类云服务功能，例如 **存储（storage）与数据库（databases）**。

While how you deployed your frontend was nobody’s business a few years ago, tools like Vercel are now (maybe?) the standard for how teams get their frontends up on the web. The [Technically website](https://technically.dev/) is even built with Vercel!

几年前，前端如何部署还无人关心；而如今，像 Vercel 这样的工具，或许已（至少正在成为）团队将前端上线至 Web 的标准方案。就连 [“Technically” 网站](https://technically.dev/) 本身也是使用 Vercel 构建的！

You may notice unusual enthusiasm for this product from me in this post, but it is not sponsored—I’ve just been using the product for years and really like it.

你可能会注意到，我在本文中对这款产品表现出异乎寻常的热情；但需说明：本文并非赞助内容——我只是已使用该产品多年，且真心喜爱它。

[**See for yourself**  
Get a step-by-step walkthrough of Vercel.  
Take the Tour](https://vercel.com/product-tour)

[**亲身体验**  
逐步了解 Vercel 的使用流程。  
立即开启导览之旅](https://vercel.com/product-tour)

## **What does deploying mean? Why do I need to do it with my frontend?**

## **什么是部署？为什么我的前端也需要部署？**

The frontend of your application is the part that your users see. But it’s actually a bit more than that. Your typical frontend codebase does a bunch of things:

您的应用程序的前端，是用户直接看到的部分。但它的作用其实远不止于此。典型的前端代码库通常承担以下多项任务：

- 使用 HTML 和 CSS 构建网页上所见的视觉元素；

- 通过 JavaScript 实现交互功能与动画效果；

- 调用内部或外部 API，为页面填充数据（例如用户个人资料页）。

Frontends are usually organized as a series of files representing which pages exist, what their structure is, and accompanying JavaScript for handling interactivity, logic, and API calls. We’ve used the analogy of the front of the house (yes, chef) vs. the back of the house, and this sort of works. The FOH is the customer’s interface to the back, making sure orders get to the kitchen, the right food gets back to the customer, etc.

前端通常由一系列文件组织而成，用于定义页面的存在性、结构布局，以及配套的 JavaScript 代码以处理交互、业务逻辑和 API 调用。我们曾用“餐厅前厅（FOH，Front of House，没错，就是主厨所在之处）”与“后厨（Back of House）”作类比——这个比喻颇为贴切：前厅是顾客与后厨之间的接口，确保订单准确送达厨房，也确保正确的菜品最终送到顾客手中。

### **Deeper look**

### **深入探讨**

Some engineering teams stick to what’s called a [**monorepo**](https://vercel.com/resources/monorepos-ebook), where all of the application code—the entire frontend and backend—are all in one giant repository, i.e. one master folder. Others have separate repositories for the frontend and backend, and others yet several repositories for different parts of the backend. Which setup teams choose depend on their priorities and how complex their application is.

部分工程团队采用所谓 [**单体仓库（monorepo）**](https://vercel.com/resources/monorepos-ebook) 的架构方式，即整个应用（包括全部前端与后端代码）都存放在一个巨型代码仓库中——相当于一个统一的主文件夹。另一些团队则将前端与后端分别置于独立的仓库中；还有些团队甚至为后端的不同模块设立多个专用仓库。团队选择哪种架构，取决于其具体优先事项以及应用本身的复杂程度。

### **Deeper look**

### **深入探讨**

However you want to understand the frontend, the important takeaway here is that the frontend code needs to _sit_ somewhere. Developers build the frontend on their laptop and need to put it up on a server somewhere so users on the web can access it. So how do they do that? There are a few options:

无论你以何种方式理解前端，此处最关键的一点是：前端代码必须**部署在某个地方**。开发者通常在自己的笔记本电脑上构建前端，然后需要将其部署到某台服务器上，以便网络上的用户能够访问。那么，他们具体是如何实现的呢？主要有以下几种选择：

1. Put it up on a dedicated server, separate from your backend

1. 将其部署在一台独立的专用服务器上，与后端服务分离。

2. Put it up on the same server as your backend

2. 将其与后端服务一同部署在同一台服务器上。

3. Put it up (with or without your backend) on a PaaS like Heroku, Railway, Render, etc.

3. 将其（无论是否连同后端）部署在 Heroku、Railway、Render 等平台即服务（PaaS）平台上。

All of these options require a good deal of setup and configuration. The basic requirements include setting up authentication / networking to your local setup and (possibly) the backend server(s), caching your frontend across the world so it’s close to your users, handling DNS so you can have a nice URL to access, and plenty of fun other stuff. I’m not trying to scare you here with terms or concepts you don’t know, there’s just a lot to do.

以上所有方案都需要大量设置和配置工作。基本要求包括：为你本地开发环境（以及可能的后端服务器）配置身份验证与网络连接；将前端资源缓存至全球各地的节点，使其尽可能靠近你的用户；配置 DNS 以提供简洁易记的访问域名；此外还有许多其他有趣但繁杂的任务。我并非有意用你不熟悉的术语或概念吓唬你——只是这件事确实涉及大量工作。

Vercel, and products like it, are **specifically built for deploying frontends** and making all of the above work as easy as possible.

Vercel 及其同类产品，正是**专为前端部署而设计**的，旨在让上述所有复杂工作变得尽可能简单。

## **The basic Vercel product**

## **Vercel 的核心产品功能**

Vercel makes it as easy as possible to deploy and use your frontend. Like any software project, I have my frontend code for technically.dev in a GitHub repository. All I need to do to get it up and running on the web is create a Vercel account, give it permissions to my technically.dev repository, and configure the domain name. Boom, your site is live:

Vercel 极大简化了前端的部署与使用流程。就像任何软件项目一样，我的 technically.dev 前端代码托管在 GitHub 仓库中。只需三步，即可让网站上线：注册一个 Vercel 账户、授予其访问 technically.dev 仓库的权限、并配置域名。搞定！你的网站立即上线：

![](images/what-does-vercel-do-vercel/img_001.jpg)![](images/what-does-vercel-do-vercel/img_002.jpg)

![](images/what-does-vercel-do-vercel/img_001.jpg)![](images/what-does-vercel-do-vercel/img_002.jpg)

Behind the scenes, Vercel has taken that code of mine, put it on servers around the world, put a URL in front of it, and optimized it to run and load fast. But this is just the start!

在幕后，Vercel 已将我的代码自动部署至全球各地的服务器，为其分配了一个可访问的 URL，并进行了性能优化，确保网站运行流畅、加载迅速。但这仅仅是个开始！

If I want to make changes to my website, all I need to do is push those changes to my GitHub repo, and Vercel _automatically_ redeploys the site and puts the new code on the server. You get this nice dashboard for each site you have deployed that gives you information on status, recent deploys, and what domains it’s sitting at.

如果我想修改我的网站，只需将这些更改推送到我的 GitHub 仓库，Vercel 就会 _自动_ 重新部署该网站，并将新代码发布到服务器上。每个已部署的网站都会提供一个简洁美观的控制面板，显示其运行状态、最近的部署记录以及所绑定的域名。

![](images/what-does-vercel-do-vercel/img_003.jpg)![](images/what-does-vercel-do-vercel/img_004.jpg)

If anything went wrong during your build and the code isn’t working on the server, you can look at the server logs to debug (something you’d normally need to do in your terminal):

如果构建过程中出现任何问题，导致代码在服务器上无法正常运行，你可以查看服务器日志进行调试（这通常是需要在终端中手动完成的操作）：

![](images/what-does-vercel-do-vercel/img_005.jpg)![](images/what-does-vercel-do-vercel/img_006.jpg)

Another really nice feature is deploy previews. When you open a new [pull request](https://technically.substack.com/p/whats-version-control-and-github) with changes to your frontend codebase that you’re considering merging / applying, Vercel automatically tries to deploy that code on a _new_ server so you can see how it looks before agreeing to apply those changes. I’m considering a name change for Technically (not really) so I’ve opened up a PR to change the name on the site:

另一项非常实用的功能是部署预览（deploy previews）。当你为前端代码库发起一个新的 [pull request](https://technically.substack.com/p/whats-version-control-and-github)，并考虑将其合并/应用时，Vercel 会自动将该 PR 中的代码部署到一个 _全新的_ 服务器上，让你能在实际应用前直观地预览效果。我正在（开玩笑地）考虑为 “Technically” 更名，因此我提交了一个 PR 来修改网站上的名称：

![](images/what-does-vercel-do-vercel/img_007.jpg)![](images/what-does-vercel-do-vercel/img_008.jpg)

Vercel automatically pre-deployed the new code and created a deploy preview that I can access on the web. Let’s take a look:

Vercel 自动预先部署了新代码，并生成了一个可通过网页访问的部署预览。我们来看一下：

![](images/what-does-vercel-do-vercel/img_009.jpg)![](images/what-does-vercel-do-vercel/img_010.jpg)

Alright this looks silly we should not do this. I knew that already since I developed this locally on my laptop, but this deploy preview made it simple to see on web and confirm. The same holds true for my teammates, who can easily see what this looks like live instead of me sending them screenshots. If I _did_ merge this PR though, Vercel would then take the new code and put it on the production server. This deploy preview feature makes testing new changes incredibly easy and requires basically no configuration whatsoever.

好吧，这看起来很傻，我们不该这么做。其实我在本地笔记本上开发时就已经知道了，但这个部署预览功能让我能轻松地在网页端直观确认。我的团队成员也同样受益：他们可以直接在线实时查看效果，而无需我再单独发送截图。当然，如果我真的合并了这个 PR，Vercel 就会把新代码正式部署到生产服务器上。这一部署预览功能让新功能的测试变得极其简单，几乎完全无需额外配置。

### **Confusion alert**

### **注意：此处易产生混淆**

> 如果你的代码托管在 GitHub 网站上，那它为什么不算“已部署”？我的用户为什么不能直接通过 GitHub 访问代码？这个问题的答案比较复杂，但核心原因很简单：GitHub 本就不是为此类用途而设计的。你缺少域名管理、服务器对外暴露、预览功能，以及 Vercel 等平台所提供的其他诸多便利特性。确实存在一个鲜为人知的功能叫作 [GitHub Pages](https://pages.github.com/)，你可以在一定程度上实现类似目标，但它功能有限，尚不足以支撑真正意义上的应用程序。

### **注意：易混淆点**

> 最后，默认情况下，Vercel 会为你的项目分配一个随机生成的 URL，让你能立即在 Web 上访问它。但你也可以轻松添加自己的自定义域名——比如我在这里使用的 technically.dev。顺便提个有趣的小知识：你仍可通过旧地址 [https://technically-app.vercel.app/](https://technically-app.vercel.app/) 访问该网站的早期版本。

## **Next.js 的现状**

Vercel 最引人注目的特点之一，或许在于它是当今全球最受欢迎的 Web 框架之一 —— [Next.js](https://nextjs.org/) 的创始者与主要维护者。Next.js 是专为 [React](https://technically.substack.com/p/whats-react) 设计的框架，目前在 Web 开发领域广受青睐。Next.js 是开源且免费的，其受欢迎程度很可能远超 Vercel 自身的商业产品（后者属于纯商业化服务）。

Web 框架是一套轻量级工具集，旨在简化 Web 服务器（尤其是前端）的开发过程，避免开发者编写大量重复或定制化代码。具体技术细节已超出本文讨论范围，但可以明确的是：几乎所有现代 Web 应用都在使用某种 Web 框架。以下是一些你可能听过的主流框架：

- Python 生态中的 [Django](https://www.djangoproject.com/) 或 [Flask](https://flask.palletsprojects.com/en/2.3.x/)

- Ruby 生态中的 [Ruby on Rails](https://rubyonrails.org/)

- PHP 生态中的 [Laravel](https://laravel.com/)

- Java 生态中的 [Spring](https://spring.io/)

As React has gotten a lot more popular, Next.js popped up as a React-specific web framework (others are [Create React App](https://create-react-app.dev/), [Gatsby](https://www.gatsbyjs.com/), etc.).

随着 React 日益流行，Next.js 应运而生，成为专为 React 设计的 Web 框架（其他同类框架还包括 [Create React App](https://create-react-app.dev/)、[Gatsby](https://www.gatsbyjs.com/) 等）。

Because Vercel is the owner / maintainer of Next.js, they’re able to natively integrate it into their commercial frontend-as-a-service product in a few interesting ways. Along with some nifty performance optimizations, every function in the “api” folder automatically gets deployed as a [serverless function](https://technically.substack.com/p/whats-serverless) in Vercel, which is at least _one_ way to build an easy backend.

由于 Vercel 是 Next.js 的所有者与主要维护者，他们得以以若干颇具创意的方式，将 Next.js 原生集成至其商业化的“前端即服务”（frontend-as-a-service）产品中。除了一系列精巧的性能优化外，`"api"` 目录下的每个函数都会自动在 Vercel 上部署为一个 [无服务器函数（serverless function）](https://technically.substack.com/p/whats-serverless)，这至少提供了一种构建简易后端的可行路径。

## **Vercel as a frontend cloud**

## **Vercel 作为前端云**

Beyond the frontend-as-a-service offering, Vercel has consistently released supporting features to make it a legitimate place to build your entire application:

除了“前端即服务”这一核心能力外，Vercel 持续推出一系列配套功能，使其真正成为构建完整应用的可靠平台：

- [**Edge Functions**](https://vercel.com/features/edge-functions): run server side / backend code serverlessly to handle things like authentication, [experimentation](https://technically.substack.com/p/technically-dispatch-what-is-ab-testing), etc.

- [**边缘函数（Edge Functions）**](https://vercel.com/features/edge-functions)：以无服务器方式运行服务端／后端代码，用于处理身份认证、[A/B 测试等实验性功能](https://technically.substack.com/p/technically-dispatch-what-is-ab-testing)等任务。

- [**Analytics**](https://vercel.com/analytics): statistics and dashboards on your site’s performance and accessibility

- [**分析服务（Analytics）**](https://vercel.com/analytics)：提供网站性能与可访问性（accessibility）相关的统计数据及可视化仪表盘。

- [**CLI / API**](https://vercel.com/docs/rest-api): interact programmatically with Vercel to do things like run deployments, run performance checks, etc.

- [**命令行工具（CLI）／API 接口**](https://vercel.com/docs/rest-api)：通过编程方式与 Vercel 交互，例如触发部署、执行性能检测等操作。

The Edge Function stuff is probably the most important to keep an eye on. Though Serverless and functions as a service aren’t a new concept, Vercel’s implementation is interesting. While your functions on a service like AWS Lambda are typically deployed in one place (a single geographical region), Vercel has those functions running across the globe in multiple locales. According to their team, it’s both faster and cheaper than other providers.

边缘函数（Edge Functions）无疑是当前最值得关注的功能。尽管“无服务器架构”（Serverless）和“函数即服务”（Functions-as-a-Service）并非新概念，但 Vercel 的实现方式却别具特色：在 AWS Lambda 等平台上，你的函数通常仅部署于单一地理区域；而 Vercel 则让这些函数在全球多个地理位置（locales）并行运行。据其团队介绍，这种方式在速度与成本两方面均优于其他厂商。

Today, significant applications are still usually deployed manually on servers somewhere (even if via PaaS)—serverless is picking up steam but still not for core backend stuff. Will that change? Maybe!

如今，重要的应用程序仍普遍依赖人工方式部署在某处服务器上（即便借助 PaaS 平台亦然）；无服务器架构虽已渐成趋势，但尚未大规模应用于核心后端场景。这种局面会改变吗？或许吧！

Taking all of these features into account, it’s probably more accurate today to call Vercel a **frontend cloud**, meaning a collection of services centered on the frontend that make building apps easier. At their conference last week, they announced a bunch of new features that support this story:

综合考量上述全部功能，如今将 Vercel 称为 **前端云（frontend cloud）** 可能更为准确——它指的是一整套以前端为中心的服务集合，旨在显著降低应用开发门槛。在上周举办的开发者大会上，Vercel 宣布了一系列全新功能，进一步印证并强化了这一战略定位：

1. **Storage**: simple object storage—think files, videos, etc.—but embedded at “the edge” i.e. on servers across the world close to your users (called “Vercel Blob” which is fun to pronounce)

1. **存储**：简易的对象存储——例如文件、视频等——但部署在“边缘”（edge），即分布在全球各地、靠近用户所在位置的服务器上（名为“Vercel Blob”，读起来很有趣）。

2. **Databases**: managed databases, starting with a [key-value store and Postgres](https://technically.substack.com/p/the-beginners-guide-to-databases)

2. **数据库**：托管式数据库，首发支持键值存储（key-value store）和 PostgreSQL。  
[数据库入门指南](https://technically.substack.com/p/the-beginners-guide-to-databases)

3. **Visual editing**: the ability to edit your frontend by just clicking and typing¹

3. **可视化编辑**：只需点击与输入，即可直接编辑前端界面¹。

If you’re thinking “wow, this sounds like a cloud” you’d be right. A cloud provides managed infrastructure for developers so they can build faster; Vercel is definitely a cloud at this point, but a cloud focused on the [**frontend**](https://technically.substack.com/p/the-details-frontends-and-backends) and abstracting the backend.

如果你心想：“哇，这听起来就像一朵云（cloud）”，那你就说对了。云平台为开发者提供托管式基础设施，从而加速开发；Vercel 目前毫无疑问已是一朵云，但它是一朵专注于[**前端**](https://technically.substack.com/p/the-details-frontends-and-backends)、并自动抽象化后端复杂性的云。

There are a few other small announcements around security and code management, but the ones above are the big ones. Over the time I’ve been using it (back when it was called Zeit), it’s been cool to see Vercel evolve from a simple frontend deployer to a proper way to build and run a whole app.

此外还有几项关于安全性和代码管理的小型更新，但上述三项才是本次发布的核心亮点。自它还叫 Zeit 时起，我就一直在使用 Vercel；亲眼见证它从一个简单的前端部署工具，逐步演进为构建与运行完整应用的成熟平台，实在令人振奋。

- [¹](https://technically.substack.com/p/b86eb8bf-4217-4740-b010-41b8502a9bdf#footnote-anchor-1-75112278) _Sort of. Behind the scenes it’s an integration with your content management system, so some work needs to happen. Nevertheless, it’s cool._

- [¹](https://technically.substack.com/p/b86eb8bf-4217-4740-b010-41b8502a9bdf#footnote-anchor-1-75112278) _某种程度上是的。其背后实际是与你的内容管理系统（CMS）集成，因此仍需一些配置工作。尽管如此，这项功能依然非常酷。_

Vercel.com landing page

Vercel.com 官网首页

### See how teams ship faster with frontend cloud

### 了解团队如何借助前端云加速交付

Blog post

博客文章

May 5, 2023

2023 年 5 月 5 日

### Authentication for the frontend cloud

### 前端云的身份验证

![](images/what-does-vercel-do-vercel/img_011.jpg)

Colin Sidoti
&#123;% endraw %}
