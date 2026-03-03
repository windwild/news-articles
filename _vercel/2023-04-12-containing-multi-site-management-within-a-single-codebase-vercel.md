---
title: "Containing multi-site management within a single codebase - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/wunderman-thompson-composable-workflow"
date: "2023-04-12"
scraped_at: "2026-03-02T09:53:21.266487897+00:00"
language: "en-zh"
translated: true
description: "Discover how to create an efficient design system that streamlines the site creation process, inspired by Wunderman Thompson's work in managing hundreds of brands from a single codebase."
---

Apr 12, 2023

2023年4月12日

Learn how Wunderman Thompson's enterprise workflow controls all data from one source of truth.

了解 Wunderman Thompson 的企业级工作流如何通过单一可信数据源统一管控全部数据。

Wunderman Thompson, a global digital agency, specializes in [helping brands create](https://vercel.com/customers/how-vercel-enables-wunderman-thompson-to-launch-global-brands) and manage their digital presence.

Wunderman Thompson 是一家全球性数字代理机构，专注于[帮助品牌构建](https://vercel.com/customers/how-vercel-enables-wunderman-thompson-to-launch-global-brands)并管理其数字形象。

Their teams based in Europe often serve multiple countries and languages, catering to the needs of various portfolio brands, each with its own unique identity.

其位于欧洲的团队常需同时服务多个国家与多种语言市场，以满足旗下多个品牌组合（portfolio brands）的不同需求——而每个品牌都拥有自身独特的品牌个性与视觉识别体系。

To tackle these challenges, Wunderman Thompson uses the principles of [Atomic Design](https://atomicdesign.bradfrost.com/chapter-2/), a headless CMS, a monorepo workflow, and Vercel's serverless platform. This approach **cuts development time by a factor of 10 and costs by a factor of 25** compared to their former method of PHP servers and WordPress monoliths.

为应对上述挑战，Wunderman Thompson 采用 [Atomic Design（原子设计）](https://atomicdesign.bradfrost.com/chapter-2/) 原则、无头 CMS（headless CMS）、单体代码仓库（monorepo）工作流，以及 Vercel 的无服务器平台。相较过去依赖 PHP 服务器与 WordPress 单体架构的开发方式，该方案将开发周期缩短至原来的 **十分之一**，成本降低至原来的 **二十五分之一**。

In this guide, we'll discuss the importance of choosing the right framework for an efficient developer workflow, and walk you through how to use these techniques to create your own efficient design system deployed on Vercel and the headless CMS of your choice.

本指南将探讨：为实现高效开发者工作流，选择合适框架的重要性；并逐步指导您如何运用这些技术，构建一套可部署于 Vercel 及您所选无头 CMS 上的高效设计系统。

- [Choose a component-based framework](https://vercel.com/blog/wunderman-thompson-composable-workflow#choose-a-component-based-framework-like-next.js-or-sveltekit)

- [选择基于组件的框架](https://vercel.com/blog/wunderman-thompson-composable-workflow#choose-a-component-based-framework-like-next.js-or-sveltekit)

- [Apply Atomic Design principles](https://vercel.com/blog/wunderman-thompson-composable-workflow#apply-atomic-design-principles)

- [应用 Atomic Design（原子设计）原则](https://vercel.com/blog/wunderman-thompson-composable-workflow#apply-atomic-design-principles)

- [Manage data with a headless CMS](https://vercel.com/blog/wunderman-thompson-composable-workflow#streamline-data-management-with-a-headless-cms)

- [借助无头 CMS 管理数据](https://vercel.com/blog/wunderman-thompson-composable-workflow#streamline-data-management-with-a-headless-cms)

- [Adopt a monorepo workflow (with Turborepo)](https://vercel.com/blog/wunderman-thompson-composable-workflow#adopt-a-monorepo-workflow)

- [采用单体代码仓库（monorepo）工作流（搭配 Turborepo）](https://vercel.com/blog/wunderman-thompson-composable-workflow#adopt-a-monorepo-workflow)

- [Let Vercel manage the infrastructure](https://vercel.com/blog/wunderman-thompson-composable-workflow#let-vercel-manage-the-infrastructure)

- [让 Vercel 托管基础设施](https://vercel.com/blog/wunderman-thompson-composable-workflow#let-vercel-manage-the-infrastructure)


[**Compose a modern solution**\\
\\
Learn how to future-proof your team's digital transformation.\\
\\
Grab the Guide](https://vercel.com/try/ebook-digital-transformation-for-enterprise-teams)

[**构建现代化解决方案**\\
\\
了解如何为团队的数字化转型打造面向未来的能力。\\
\\
立即获取指南](https://vercel.com/try/ebook-digital-transformation-for-enterprise-teams)

## Choose a component-based framework like Next.js or SvelteKit

## 选择 Next.js 或 SvelteKit 等基于组件的框架

An efficient developer workflow begins with selecting the right framework. [Next.js](https://vercel.com/solutions/nextjs) and [SvelteKit](https://vercel.com/solutions/svelte) are powerful frameworks that offer a range of benefits for managing complex component hierarchies, like the ones Wunderman Thompson uses to keep their component library organized and flexible.

高效的开发者工作流始于选择合适的框架。[Next.js](https://vercel.com/solutions/nextjs) 和 [SvelteKit](https://vercel.com/solutions/svelte) 是功能强大的框架，能为管理复杂的组件层级结构提供诸多优势——正如 Wunderman Thompson 所做的那样，借助这些框架保持其组件库的条理性与灵活性。

Here's why choosing a framework like Next.js or SvelteKit matters for your team's efficiency and speed:

以下是你团队在效率与开发速度方面，选择 Next.js 或 SvelteKit 这类框架的关键原因：

1. **Full stack access:** Next.js and SvelteKit offer built-in support for routing, server-side tasks, APIs, and middleware, streamlining setup and allowing you to serve frontend and backend code from the same application.

1. **全栈能力：** Next.js 和 SvelteKit 原生支持路由、服务端任务、API 及中间件，大幅简化项目搭建流程，并允许你从同一应用中同时提供前端与后端代码。

2. **Component-based architecture:** Both frameworks promote reusability, modularity, and maintainability with their component-based architecture.

2. **基于组件的架构：** 二者均采用基于组件的架构，显著提升代码复用性、模块化程度与可维护性。

3. **Optimized performance:** By supporting dynamic imports and code splitting (which give you the ability to defer scripts down to the component level and only serve code that the client uses), both frameworks ensure your sites remain fast as your design system grows more complex.

3. **性能优化：** 通过支持动态导入（dynamic imports）与代码分割（code splitting）——即按需延迟加载至组件级别，并仅向客户端提供其实际使用的代码——两大框架确保你的网站在设计系统日益复杂时仍能保持高速响应。

4. **Efficient rendering:** Next.js and SvelteKit support Incremental Static Regeneration (ISR), [improving user experience and search ranking](https://vercel.com/blog/nextjs-seo-playbook) by pre-rendering dynamic data without needing to redeploy your site when content changes.

4. **高效渲染：** Next.js 和 SvelteKit 支持增量静态再生（Incremental Static Regeneration, ISR），可在内容更新时无需重新部署网站，即可对动态数据进行预渲染，从而[提升用户体验与搜索引擎排名](https://vercel.com/blog/nextjs-seo-playbook)。

5. **Enhanced developer experience:** With rich ecosystems of plugins, tools, and community support, both frameworks simplify the creation, management, and maintenance of component-based systems while ensuring scalability and adaptability.

5. **卓越的开发者体验：** 凭借丰富的插件生态、配套工具及活跃的社区支持，这两大框架显著简化了基于组件系统的创建、管理与维护过程，同时保障系统具备良好的可扩展性与适应性。

6. **Adaptive deployment:** Embracing [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure), Vercel automatically provisions infrastructure based on your Next.js or SvelteKit projects, simplifying deployment and boosting team productivity.

6. **自适应部署：** 通过采用 [框架定义的基础设施（Framework-Defined Infrastructure）](https://vercel.com/blog/framework-defined-infrastructure)，Vercel 能够根据您的 Next.js 或 SvelteKit 项目自动配置所需基础设施，从而简化部署流程，并提升团队生产力。

By providing a robust foundation for managing complex component hierarchies, Next.js and SvelteKit empower you to adopt industry best practices without worrying about the size or complexity of your codebase. They offer ease of migration and incremental adoption, making them an ideal choice for scaling your projects.

Next.js 和 SvelteKit 为管理复杂的组件层级结构提供了坚实基础，使您能够轻松采纳行业最佳实践，而无需担忧代码库的规模或复杂度。它们支持平滑迁移与渐进式采用，是规模化扩展项目的理想选择。

[**So what are the tradeoffs?**\\  
\\  
Basement.studio recently navigated a large-scale migration to Next.js. Here's where they landed.\\  
\\  
Learn More](https://vercel.com/blog/navigating-tradeoffs-in-large-scale-website-migrations)

[**那么，其中的取舍是什么？**\\  
\\  
Basement.studio 最近完成了一次大规模向 Next.js 的迁移。以下是他们的实践总结。\\  
\\  
了解更多](https://vercel.com/blog/navigating-tradeoffs-in-large-scale-website-migrations)

## Apply Atomic Design principles

## 应用原子设计（Atomic Design）原则

A unified design system keeps all your sites up-to-date and avoids inconsistencies. Wunderman Thompson attributes their success to Brad Frost's principles of [Atomic Design](https://atomicdesign.bradfrost.com/chapter-2/), which provide a structured approach with five levels: atoms, molecules, organisms, templates, and pages.

统一的设计系统可确保所有网站保持同步更新，并避免不一致性。Wunderman Thompson 将其成功归功于 Brad Frost 提出的 [原子设计（Atomic Design）](https://atomicdesign.bradfrost.com/chapter-2/) 原则——该方法提供了一种结构化的设计体系，包含五个层级：原子（Atoms）、分子（Molecules）、生物体（Organisms）、模板（Templates）和页面（Pages）。

Atomic Design is one of _many_ possible ways to organize your codebase. We're showcasing its success here, since Wunderman Thompson uses it to streamline multiple sites into one component-based workflow.

原子设计只是组织代码库的 _诸多可行方式之一_。我们在此重点介绍它的成功实践，因为 Wunderman Thompson 正是借助该方法，将多个网站整合进统一的、基于组件的工作流中。

### Identify your atoms

### 识别您的“原子”组件

Atoms are the smallest, reusable components in your application. They cannot be broken down into smaller components. Creating a library of atoms helps provide consistency across your projects.

“原子”是应用程序中最小、可复用的组件单元，无法进一步拆解为更小的组件。构建一套原子组件库，有助于保障各项目间的一致性。

For instance, you might make a `Button.js`:

例如，您可以创建一个 `Button.js` 文件：

Button.js

```jsx
export default function Button({ children, onClick }) {

2    return (

3        <button onClick={onClick}>{children}</button>

4    )

5}
```

`Button.js` 原子组件。

你可以设想其他类似的组件，例如 `InputField.js` 或 `Label.js`，它们也都只封装单一功能。原子组件也可以是布局元素（如 Flexbox 和 Grid 布局），或是用于品牌色的 CSS 变量（如 `--var-background`、`--var-accent-1` 等）。

无论采用哪种方式，都应从简单开始：原子设计（Atomic Design）的核心在于迭代。没有人希望采用瀑布式工作流——即一个团队必须等待另一个团队完成任务后才能开展工作。通过快速梳理出应用所需的一整套组件库，你能让设计师与开发者协同并行工作。

### 表单分子组件（Form molecules）

接下来，将原子组件组合成功能更丰富的分子组件，例如搜索栏、卡片（card）、工具提示（tooltip）或警告消息（alert message）。分子组件可由任意数量的原子组成，但务必遵循[单一职责原则](https://en.wikipedia.org/wiki/Single-responsibility_principle)，确保每个分子组件专注且出色地完成一项任务。

You might, for example, combine input field, input label, and button atoms to make a search bar molecule:

例如，您可以将输入字段（input field）、输入标签（input label）和按钮（button）等原子组件组合起来，构建一个搜索栏分子（search bar molecule）：

SearchBar.js

SearchBar.js

```jsx
import InputField from "../atoms/InputField";

import InputLabel from "../atoms/InputLabel";

import Button from "../atoms/Button";



import { useState } from "react";



export default function SearchBar({ onSearch }) {

8  const [searchText, setSearchText] = useState("");
```

10  const handleSearch = () => {

10  const handleSearch = () => {

11    onSearch(searchText);

11    onSearch(searchText);

12  };

12  };



14  const handleChange = (event) => {

14  const handleChange = (event) => {

15    setSearchText(event.target.value);

15    setSearchText(event.target.value);

16  };

16  };



18  return (

18  return (

19    <div>

19    <div>

20      <InputLabel htmlFor="search">Search</InputLabel>

20      <InputLabel htmlFor="search">搜索</InputLabel>

21      <InputField

21      <InputField

22        id="search"

22        id="search"

23        type="text"

23        type="text"

24        value={searchText}

24        value={searchText}

25        onChange={handleChange}

25        onChange={handleChange}

26      />

26      />

27      <Button onClick={handleSearch}>Search</Button>

27      <Button onClick={handleSearch}>搜索</Button>

28    </div>

28    </div>

29  );

30}
```

一个示例分子组件 `SearchBar.js`，它组合了原子组件 `InputField`、`InputLabel` 和 `Button`。

### 构建生物体（Organisms）

基于分子组件，构建代表更大设计区块的生物体组件，例如页脚（footer）、导航菜单（menu），甚至商品展示区域（product displays）。此时，你将开始需要创建专属于你应用程序业务目标的独特组件。

例如，你可以构建一个页眉（Header）组件，其中包含上文所述的搜索栏分子（`SearchBar`），以及新增的菜单分子（`Menu`）和网站标题分子（`SiteTitle`）：

`Header.js`

```jsx
import SearchBar from "../molecules/SearchBar";

import Menu from "../molecules/Menu";

import SiteTitle from "../molecules/SiteTitle";
```

```javascript
import Flex from "../atoms/Flex";

import Title from "../atoms/Title";

import Logo from "../atoms/Logo";



export default function Header({ onSearch, menuOptions }) {

9  return (

10    <header>

11      <Flex justify="between">

12        <SiteTitle logo={Logo} title={Title} />

13        <SearchBar onSearch={onSearch} />
```

```javascript
导入 Flex 组件：`import Flex from "../atoms/Flex";`

导入 Title 组件：`import Title from "../atoms/Title";`

导入 Logo 组件：`import Logo from "../atoms/Logo";`



导出默认函数组件 Header（接收 onSearch 和 menuOptions 两个 props）：

9  返回（

10    `<header>` 元素，

11    内嵌一个 `Flex` 组件，其 `justify` 属性设为 `"between"`（两端对齐），

12    左侧渲染 `<SiteTitle>` 组件，并传入 `logo` 和 `title` 两个 props（值分别为 `Logo` 和 `Title`），

13    右侧渲染 `<SearchBar>` 组件，并传入 `onSearch` prop。
```

14        <Menu menuOptions={menuOptions} />

14        <Menu menuOptions={menuOptions} />

15      </Flex>

15      </Flex>

16    </header>

16    </header>

17  );

17  );

18}
```

18}
```

An organism that imports various molecules and atoms to construct a complex, reusable component.

一种有机体，它导入多种分子与原子，以构建复杂且可复用的组件。

### Develop templates and populate pages

### 开发模板并填充页面

Arrange organisms into templates, defining your site's layout and structure. Templates are just pages on your website that are constructed to accept dynamic data, avoiding the trap of "hard-coding" information.

将有机体组合为模板，从而定义网站的布局与结构。模板本质上就是网站中的页面，其设计初衷是支持动态数据注入，从而避免陷入“硬编码”信息的陷阱。

When you bring your clients' content into your templates, via a headless CMS, you've built your final pages. If you've built your system correctly, client data can easily customize templates all the way down to the atomic level to make truly unique brands.

当您通过无头 CMS 将客户的内容注入模板时，最终页面便已成型。若您已正确构建系统，客户数据便可轻松自上而下定制模板，甚至细化至原子层级，从而打造出真正独一无二的品牌体验。

Need to make changes? Work from the bottom up, implementing fixes and designs where it makes the most sense, keeping code clean and singularly functional.

需要调整修改？请采用自底向上的方式，在最合理的位置实施修复与设计优化，确保代码简洁、职责单一、功能明确。

## Streamline data with a headless CMS

## 借助无头 CMS 简化数据管理

Using Atomic Design in conjunction with [a headless CMS](https://vercel.com/blog/your-guide-to-headless-commerce) creates a seamless, composable workflow. A headless CMS serves as a single source of truth for all the atoms, molecules, organisms, and templates you've built, as well as your customers' dynamic data.

将原子设计（Atomic Design）与[无头 CMS](https://vercel.com/blog/your-guide-to-headless-commerce)相结合，可构建出流畅、可组合的工作流。无头 CMS 作为单一可信数据源（single source of truth），统一管理您所构建的所有原子（atoms）、分子（molecules）、有机体（organisms）和模板（templates），同时也承载客户所需的动态数据。

Before adopting a CMS, Wunderman Thompson stored data on individual servers for each client, which meant onboarding new clients required new infrastructure, a unique CMS, and a custom website.

在采用 CMS 之前，Wunderman Thompson 为每位客户单独部署服务器存储数据，这意味着每新增一位客户，都需要配置新的基础设施、部署专属的 CMS，并开发定制化网站。

![Monolithic architecture often requires repetition of labor, but the flexibility of composable allows for data templating that works for all clients.](images/containing-multi-site-management-within-a-single-codebase-vercel/img_001.jpg)![Monolithic architecture often requires repetition of labor, but the flexibility of composable allows for data templating that works for all clients.](images/containing-multi-site-management-within-a-single-codebase-vercel/img_002.jpg)Monolithic architecture often requires repetition of labor, but the flexibility of composable allows for data templating that works for all clients.

![单体式架构往往导致重复劳动，而可组合架构的灵活性则支持面向所有客户的通用数据模板化。](images/containing-multi-site-management-within-a-single-codebase-vercel/img_001.jpg)![单体式架构往往导致重复劳动，而可组合架构的灵活性则支持面向所有客户的通用数据模板化。](images/containing-multi-site-management-within-a-single-codebase-vercel/img_002.jpg)单体式架构往往导致重复劳动，而可组合架构的灵活性则支持面向所有客户的通用数据模板化。

Now, they manage all customer data within [DatoCMS](https://vercel.com/integrations/datocms), grouping similar clients together while ensuring privacy. Onboarding new clients, such as [Sogrape](https://sogrape.com/) and their wine sub-brands, becomes easier as common data points are templated. Wunderman Thompson can create new sites in a matter of days, combining pre-existing organisms into templates tailored to each client.

如今，他们将全部客户数据集中托管于[DatoCMS](https://vercel.com/integrations/datocms)中，在保障数据隐私的前提下，将业务模式相似的客户归类管理。当接入新客户（例如[Sogrape](https://sogrape.com/)及其旗下多个葡萄酒子品牌）时，由于通用数据字段已实现模板化，整个流程显著简化。Wunderman Thompson 只需数天即可搭建全新站点——通过复用既有的有机体（organisms），快速组装出契合每位客户个性化需求的专属模板。

These templates are populated with the client's unique data, including brand design elements, which makes adjustments as simple as tweaking a few parameters or switching the component order in the CMS.

这些模板会注入客户独有的数据（包括品牌视觉设计元素等），因此后续调整极为便捷：只需在 CMS 中微调若干参数，或重新排列组件顺序即可完成。

## Adopt a monorepo workflow

## 采用单体仓库（monorepo）工作流

So, how does your CMS access the code behind the components?

那么，您的 CMS 如何访问组件背后的代码？

Wunderman Thompson uses a monorepo to store all Next.js components, ensuring code consistency across client websites while still allowing for unique component compositions. Each client site is designed to be visually distinct while using the same set of components from the monorepo.

Wunderman Thompson 采用单体仓库（monorepo）统一存放所有 Next.js 组件，在确保各客户网站间代码高度一致的同时，仍支持灵活定制化的组件组合方式。每个客户网站在视觉呈现上各具特色，但底层均复用同一套来自 monorepo 的组件集合。

In this workflow, individual site identity is controlled by an environmental variable in the deployment, which maps to a unique ID for a unique client site composed entirely in the headless CMS. This streamlined workflow uses, as the single source of truth, the CMS for data and the monorepo for code.

在此工作流中，各独立站点的身份标识由部署时的环境变量控制，该变量映射至一个唯一 ID，对应完全在无头 CMS 中构建的特定客户站点。这一精简高效的工作流，以 CMS 作为数据的单一可信来源，以 monorepo 作为代码的单一可信来源。

Enterprise companies like Wunderman Thompson use this approach to focus on maintaining high-quality components, easily onboarding new clients by adding them to the CMS without needing to redesign code. Any new components required by the client are built from pre-existing atoms, ensuring seamless integration within the system.

像 Wunderman Thompson 这样的企业公司采用这一方法，专注于维护高质量的组件；通过将新客户直接添加至内容管理系统（CMS），即可轻松完成客户接入，无需重新设计代码。客户所需的任何新组件均基于已有的原子化组件（atoms）构建，从而确保其与系统无缝集成。

### Make it Turbo

### 让开发“飞”起来

Wunderman Thompson uses Turborepo to vastly improve the speed of working with such a large monorepo.

Wunderman Thompson 使用 Turborepo 大幅提升在如此庞大的单体仓库（monorepo）中工作的速度。

[Turborepo](https://turbo.build/repo?utm_source=vercel_site&utm_medium=blog&utm_campaign=wunderman_thompson_composable) offers intelligent caching for remarkably fast builds and empowers you to create a customized, streamlined schedule of tasks tailored to your repo's needs. This ensures alignment and velocity for all developers, making it much easier for them to navigate and contribute to the codebase.

[Turborepo](https://turbo.build/repo?utm_source=vercel_site&utm_medium=blog&utm_campaign=wunderman_thompson_composable) 提供智能缓存机制，实现极速构建；同时支持您根据仓库实际需求，定制化、精简化地编排任务执行流程。这保障了所有开发人员步调一致、高效协同，显著降低了代码库的上手与贡献门槛。

From Wunderman Thompson's perspective, [when using Remote Caching](https://vercel.com/blog/vercel-remote-cache-turbo), Turborepo not only accelerates as the team grows but also boosts their Continous Integration (CI) performance. Once a team member caches a build, all of WT's developers and their CI system gain local access to that cache.

在 Wunderman Thompson 看来，[启用远程缓存（Remote Caching）](https://vercel.com/blog/vercel-remote-cache-turbo) 后，Turborepo 不仅能随团队规模扩大而持续加速，还能显著提升其持续集成（CI）性能。一旦某位团队成员完成一次构建并生成缓存，Wunderman Thompson 全体开发者及其 CI 系统均可本地访问该缓存。

Building for numerous sites can strain your CI, slowing down iteration speeds. To keep up with client demands, Wunderman Thompson relies on a fast pipeline facilitated by Turborepo, enabling them to efficiently manage a large design system that continually processes dynamic customer data.

为大量网站构建应用会给 CI 带来巨大压力，拖慢迭代速度。为及时响应客户需求，Wunderman Thompson 依托 Turborepo 打造高速构建流水线，从而高效管理一个庞大且持续处理动态客户数据的设计系统。

[**Need some space to experiment?**\\
\\
Check out this Next.js and Turborepo starter template to ease your way into monorepo development.\\
\\
Deploy](https://vercel.com/templates/next.js/turborepo-next-basic)

[**想找个地方动手试试？**\\
\\
立即体验这个 Next.js + Turborepo 入门模板，轻松开启单体仓库（monorepo）开发之旅。\\
\\
一键部署](https://vercel.com/templates/next.js/turborepo-next-basic)

## **Let Vercel manage the infrastructure**

## **让 Vercel 托管基础设施**

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_003.svg)

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_003.svg)

Native integrations

原生集成

Vercel operates under principles of [Framework-defined infrastructure (FDI)](https://vercel.com/blog/framework-defined-infrastructure), natively integrating with Next.js (or SvelteKit), DatoCMS, and Turborepo. FDI creates a seamless development and deployment experience.

Vercel 遵循“框架定义基础设施（Framework-defined Infrastructure，FDI）”原则，原生集成 Next.js（或 SvelteKit）、DatoCMS 和 Turborepo。FDI 为开发与部署提供了无缝衔接的体验。

For instance, DatoCMS users can trigger Vercel deployments directly from Dato, removing the need to handle deployments separately.

例如，DatoCMS 用户可直接从 Dato 触发 Vercel 部署，无需单独管理部署流程。

Next.js analytics, on the other hand, automatically populate in your Vercel Analytics dashboard, removing the hassle of setting up your own monitoring.

另一方面，Next.js 分析数据会自动同步至您的 Vercel Analytics 仪表板，省去了自行配置监控系统的繁琐步骤。

Wunderman Thompson utilizes [these native integrations](https://vercel.com/integrations) to efficiently manage their international, multi-domain portfolio of sites.

Wunderman Thompson 借助[这些原生集成](https://vercel.com/integrations)，高效管理其面向全球、涵盖多个域名的网站组合。

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_004.svg)

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_004.svg)

Preview deployments

预览部署

Vercel's Preview Deployments allow customers to experience live previews of their sites quickly, facilitating rapid prototyping. With a preview deployment for every commit on every Git branch, your company remains agile and capable of experimentation and iteration.

Vercel 的预览部署（Preview Deployments）使客户能够快速体验网站的实时预览效果，从而加速原型设计。每一次 Git 分支上的提交都会自动生成对应的预览部署，确保企业始终保持敏捷，灵活开展实验与迭代。

These live preview deployments accurately represent the final site, complete with the global edge network, showcasing the site's performance.

这些实时预览部署精准还原最终上线站点，依托全球边缘网络，真实展现网站性能表现。

Clients can interactively engage with the site, and with [Vercel's Figma-like comments feature](https://vercel.com/docs/concepts/deployments/comments), they can provide feedback directly on Preview Deployments. This eliminates the need for screenshots or lengthy descriptions, enabling quicker design iterations from a single source of truth.

客户可与预览站点进行交互式操作；借助[Vercel 类似 Figma 的评论功能](https://vercel.com/docs/concepts/deployments/comments)，他们还能直接在预览部署页面上提交反馈。此举免除了截图或冗长文字说明的需要，让设计迭代基于单一可信来源，更加高效快捷。

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_005.svg)

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_005.svg)

# Serverless for scale

# 无服务器架构实现弹性伸缩

Before adopting Vercel, Wunderman Thompson had to manage a separate server for each client, upgrading server capabilities as traffic increased and incurring costs when traffic was low. Vercel's serverless platform eliminates these concerns, allowing the design system and portfolio of sites to scale seamlessly based on demand.

在采用 Vercel 之前，Wunderman Thompson 需要为每位客户单独维护一台服务器：随着流量增长不断升级服务器性能，而流量低迷时仍需承担固定成本。Vercel 的无服务器平台彻底消除了这些顾虑，使设计系统及整套网站组合能够根据实际需求无缝弹性伸缩。

With Vercel, Wunderman Thompson enjoys peace of mind, knowing their infrastructure can handle traffic fluctuations without crashing or breaking.

借助 Vercel，Wunderman Thompson 拥有十足信心——其基础设施足以从容应对流量波动，绝不会崩溃或中断服务。

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_006.png)

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_006.png)

## A global Edge Network

## 全球边缘网络

[Vercel's global Edge Network](https://vercel.com/features/edge-functions), including Edge Middleware and Functions, enables truly localized digital experiences. Internationalization and localization are built-in from the start, simplifying the management of multi-language websites.

[Vercel 全球边缘网络](https://vercel.com/features/edge-functions)（涵盖边缘中间件与边缘函数）可提供真正本地化的数字体验。国际化（i18n）与本地化（l10n）能力从项目伊始即原生集成，大幅简化多语言网站的管理流程。

Wunderman Thompson incorporates localized versions of their websites within their CMS. To add another language, they adjust an environmental variable in the Vercel deployment.

Wunderman Thompson 将各语种版本的网站内容统一纳入其内容管理系统（CMS）。如需新增一种语言，只需在 Vercel 部署中调整一个环境变量即可完成。

## Improve your customer story

## 提升您的客户故事

The composable workflow talked about in this article delivers impressive results: for Wunderman Thompson it's meant improving developer productivity by 10x and slashing costs by 25x compared to a monolithic solution like WordPress.

本文所探讨的可组合式工作流带来了令人瞩目的成效：对 Wunderman Thompson 而言，相比 WordPress 这类单体式解决方案，开发者生产力提升了 10 倍，成本则降低了 25 倍。

By leveraging a unified Turborepo powered by a headless CMS, plus Vercel's supported frameworks and seamless tool integrations, your team can focus on delivering innovative solutions with unprecedented agility. Imagine delighting your customers with live previews of their sites within a week, complete with commenting and global Edge Network performance.

通过采用由无头 CMS 驱动的统一 Turborepo，结合 Vercel 所支持的各类框架及无缝工具集成能力，您的团队得以专注于以史无前例的敏捷性交付创新解决方案。试想：仅用一周时间，您就能为客户呈现带评论功能、并依托全球边缘网络实现高性能响应的网站实时预览——让客户倍感惊喜。

Future-proof your codebase and empower your team to create exceptional digital experiences with more speed, efficiency, and versatility than ever before.

让您的代码库面向未来，并赋能团队以前所未有的速度、效率与灵活性打造卓越的数字体验。

[**Talk with a migration expert**  
**与迁移专家交流**  

We can help you find the best workflow for your team's unique needs.  
我们可以帮助您为团队的独特需求找到最优工作流。  

Send a Message  
发送消息](https://vercel.com/contact/sales)

Blog post  
博客文章  

Feb 9, 2023  
2023年2月9日  

### Navigating tradeoffs in large-scale website migrations  

### 大型网站迁移中的权衡取舍  

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_007.jpg)![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_008.jpg)  

Julian and Jose  
朱利安与何塞  

Vercel.com landing page  
Vercel.com 官网落地页  

### Read this ebook  

### 阅读本电子书