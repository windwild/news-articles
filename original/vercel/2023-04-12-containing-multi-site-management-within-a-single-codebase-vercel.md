---
title: "Containing multi-site management within a single codebase - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/wunderman-thompson-composable-workflow"
date: "2023-04-12"
scraped_at: "2026-03-02T09:53:21.266487897+00:00"
language: "en"
translated: false
description: "Discover how to create an efficient design system that streamlines the site creation process, inspired by Wunderman Thompson's work in managing hundreds of brands from a single codebase."
---




Apr 12, 2023

Learn how Wunderman Thompson's enterprise workflow controls all data from one source of truth.

Wunderman Thompson, a global digital agency, specializes in [helping brands create](https://vercel.com/customers/how-vercel-enables-wunderman-thompson-to-launch-global-brands) and manage their digital presence.

Their teams based in Europe often serve multiple countries and languages, catering to the needs of various portfolio brands, each with its own unique identity.

To tackle these challenges, Wunderman Thompson uses the principles of [Atomic Design](https://atomicdesign.bradfrost.com/chapter-2/), a headless CMS, a monorepo workflow, and Vercel's serverless platform. This approach **cuts development time by a factor of 10 and costs by a factor of 25** compared to their former method of PHP servers and WordPress monoliths.

In this guide, we'll discuss the importance of choosing the right framework for an efficient developer workflow, and walk you through how to use these techniques to create your own efficient design system deployed on Vercel and the headless CMS of your choice.

- [Choose a component-based framework](https://vercel.com/blog/wunderman-thompson-composable-workflow#choose-a-component-based-framework-like-next.js-or-sveltekit)

- [Apply Atomic Design principles](https://vercel.com/blog/wunderman-thompson-composable-workflow#apply-atomic-design-principles)

- [Manage data with a headless CMS](https://vercel.com/blog/wunderman-thompson-composable-workflow#streamline-data-management-with-a-headless-cms)

- [Adopt a monorepo workflow (with Turborepo)](https://vercel.com/blog/wunderman-thompson-composable-workflow#adopt-a-monorepo-workflow)

- [Let Vercel manage the infrastructure](https://vercel.com/blog/wunderman-thompson-composable-workflow#let-vercel-manage-the-infrastructure)


[**Compose a modern solution**\\
\\
Learn how to future-proof your team's digital transformation.\\
\\
Grab the Guide](https://vercel.com/try/ebook-digital-transformation-for-enterprise-teams)

## Choose a component-based framework like Next.js or SvelteKit

An efficient developer workflow begins with selecting the right framework. [Next.js](https://vercel.com/solutions/nextjs) and [SvelteKit](https://vercel.com/solutions/svelte) are powerful frameworks that offer a range of benefits for managing complex component hierarchies, like the ones Wunderman Thompson uses to keep their component library organized and flexible.

Here's why choosing a framework like Next.js or SvelteKit matters for your team's efficiency and speed:

1. **Full stack access:** Next.js and SvelteKit offer built-in support for routing, server-side tasks, APIs, and middleware, streamlining setup and allowing you to serve frontend and backend code from the same application.

2. **Component-based architecture:** Both frameworks promote reusability, modularity, and maintainability with their component-based architecture.

3. **Optimized performance:** By supporting dynamic imports and code splitting (which give you the ability to defer scripts down to the component level and only serve code that the client uses), both frameworks ensure your sites remain fast as your design system grows more complex.

4. **Efficient rendering:** Next.js and SvelteKit support Incremental Static Regeneration (ISR), [improving user experience and search ranking](https://vercel.com/blog/nextjs-seo-playbook) by pre-rendering dynamic data without needing to redeploy your site when content changes.

5. **Enhanced developer experience:** With rich ecosystems of plugins, tools, and community support, both frameworks simplify the creation, management, and maintenance of component-based systems while ensuring scalability and adaptability.

6. **Adaptive deployment:** Embracing [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure), Vercel automatically provisions infrastructure based on your Next.js or SvelteKit projects, simplifying deployment and boosting team productivity.


By providing a robust foundation for managing complex component hierarchies, Next.js and SvelteKit empower you to adopt industry best practices without worrying about the size or complexity of your codebase. They offer ease of migration and incremental adoption, making them an ideal choice for scaling your projects.

[**So what are the tradeoffs?**\\
\\
Basement.studio recently navigated a large-scale migration to Next.js. Here's where they landed.\\
\\
Learn More](https://vercel.com/blog/navigating-tradeoffs-in-large-scale-website-migrations)

## Apply Atomic Design principles

A unified design system keeps all your sites up-to-date and avoids inconsistencies. Wunderman Thompson attributes their success to Brad Frost's principles of [Atomic Design](https://atomicdesign.bradfrost.com/chapter-2/), which provide a structured approach with five levels: atoms, molecules, organisms, templates, and pages.

Atomic Design is one of _many_ possible ways to organize your codebase. We're showcasing its success here, since Wunderman Thompson uses it to streamline multiple sites into one component-based workflow.

### Identify your atoms

Atoms are the smallest, reusable components in your application. They cannot be broken down into smaller components. Creating a library of atoms helps provide consistency across your projects.

For instance, you might make a `Button.js`:

Button.js

```jsx
export default function Button({ children, onClick }) {

2    return (

3        <button onClick={onClick}>{children}</button>

4    )

5}
```

Button.js atom.

You can imagine other components, like `InputField.js` or `Label.js`, that also have a single function. Atoms can also be elements like flexbox and grid layouts, or CSS variables for brand colors (`--var-background`, `--var-accent-1`, and so on).

Either way, start simple: the core of Atomic Design is iteration. Nobody wants a waterfall workflow, where one team has to wait on the other to accomplish tasks. By quickly sketching up the library of components your application needs, you enable designers to work in conjunction with developers.

### Form molecules

Next, combine your atoms into versatile molecules, such as search bars, cards, tooltips, or alert messages. Molecules can consist of any number of atoms, but be sure to stick to the [single-responsibility principle](https://en.wikipedia.org/wiki/Single-responsibility_principle) to allow each molecule to do one thing well.

You might, for example, combine input field, input label, and button atoms to make a search bar molecule:

SearchBar.js

```jsx
import InputField from "../atoms/InputField";

import InputLabel from "../atoms/InputLabel";

import Button from "../atoms/Button";



import { useState } from "react";



export default function SearchBar({ onSearch }) {

8  const [searchText, setSearchText] = useState("");



10  const handleSearch = () => {

11    onSearch(searchText);

12  };



14  const handleChange = (event) => {

15    setSearchText(event.target.value);

16  };



18  return (

19    <div>

20      <InputLabel htmlFor="search">Search</InputLabel>

21      <InputField

22        id="search"

23        type="text"

24        value={searchText}

25        onChange={handleChange}

26      />

27      <Button onClick={handleSearch}>Search</Button>

28    </div>

29  );

30}
```

An example molecule, SearchBar.js, which combines the atoms of \`InputField\`, \`InputLabel\`, and \`Button\`.

### Build organisms

From molecules, create organisms that represent larger design sections, such as footers, menus, or even product displays. This is where you'll start needing components unique to your application's purpose.

For instance, you could make a header that includes the search bar molecule from above plus new menu and site title molecules:

Header.js

```jsx
import SearchBar from "../molecules/SearchBar";

import Menu from "../molecules/Menu";

import SiteTitle from "../molecules/SiteTitle";

import Flex from "../atoms/Flex";

import Title from "../atoms/Title";

import Logo from "../atoms/Logo";



export default function Header({ onSearch, menuOptions }) {

9  return (

10    <header>

11      <Flex justify="between">

12        <SiteTitle logo={Logo} title={Title} />

13        <SearchBar onSearch={onSearch} />

14        <Menu menuOptions={menuOptions} />

15      </Flex>

16    </header>

17  );

18}
```

An organism that imports various molecules and atoms to construct a complex, reusable component.

### Develop templates and populate pages

Arrange organisms into templates, defining your site's layout and structure. Templates are just pages on your website that are constructed to accept dynamic data, avoiding the trap of "hard-coding" information.

When you bring your clients' content into your templates, via a headless CMS, you've built your final pages. If you've built your system correctly, client data can easily customize templates all the way down to the atomic level to make truly unique brands.

Need to make changes? Work from the bottom up, implementing fixes and designs where it makes the most sense, keeping code clean and singularly functional.

## Streamline data with a headless CMS

Using Atomic Design in conjunction with [a headless CMS](https://vercel.com/blog/your-guide-to-headless-commerce) creates a seamless, composable workflow. A headless CMS serves as a single source of truth for all the atoms, molecules, organisms, and templates you've built, as well as your customers' dynamic data.

Before adopting a CMS, Wunderman Thompson stored data on individual servers for each client, which meant onboarding new clients required new infrastructure, a unique CMS, and a custom website.

![Monolithic architecture often requires repetition of labor, but the flexibility of composable allows for data templating that works for all clients.](images/containing-multi-site-management-within-a-single-codebase-vercel/img_001.jpg)![Monolithic architecture often requires repetition of labor, but the flexibility of composable allows for data templating that works for all clients.](images/containing-multi-site-management-within-a-single-codebase-vercel/img_002.jpg)Monolithic architecture often requires repetition of labor, but the flexibility of composable allows for data templating that works for all clients.

Now, they manage all customer data within [DatoCMS](https://vercel.com/integrations/datocms), grouping similar clients together while ensuring privacy. Onboarding new clients, such as [Sogrape](https://sogrape.com/) and their wine sub-brands, becomes easier as common data points are templated. Wunderman Thompson can create new sites in a matter of days, combining pre-existing organisms into templates tailored to each client.

These templates are populated with the client's unique data, including brand design elements, which makes adjustments as simple as tweaking a few parameters or switching the component order in the CMS.

## Adopt a monorepo workflow

So, how does your CMS access the code behind the components?

Wunderman Thompson uses a monorepo to store all Next.js components, ensuring code consistency across client websites while still allowing for unique component compositions. Each client site is designed to be visually distinct while using the same set of components from the monorepo.

In this workflow, individual site identity is controlled by an environmental variable in the deployment, which maps to a unique ID for a unique client site composed entirely in the headless CMS. This streamlined workflow uses, as the single source of truth, the CMS for data and the monorepo for code.

Enterprise companies like Wunderman Thompson use this approach to focus on maintaining high-quality components, easily onboarding new clients by adding them to the CMS without needing to redesign code. Any new components required by the client are built from pre-existing atoms, ensuring seamless integration within the system.

### Make it Turbo

Wunderman Thompson uses Turborepo to vastly improve the speed of working with such a large monorepo.

[Turborepo](https://turbo.build/repo?utm_source=vercel_site&utm_medium=blog&utm_campaign=wunderman_thompson_composable) offers intelligent caching for remarkably fast builds and empowers you to create a customized, streamlined schedule of tasks tailored to your repo's needs. This ensures alignment and velocity for all developers, making it much easier for them to navigate and contribute to the codebase.

From Wunderman Thompson's perspective, [when using Remote Caching](https://vercel.com/blog/vercel-remote-cache-turbo), Turborepo not only accelerates as the team grows but also boosts their Continous Integration (CI) performance. Once a team member caches a build, all of WT's developers and their CI system gain local access to that cache.

Building for numerous sites can strain your CI, slowing down iteration speeds. To keep up with client demands, Wunderman Thompson relies on a fast pipeline facilitated by Turborepo, enabling them to efficiently manage a large design system that continually processes dynamic customer data.

[**Need some space to experiment?**\\
\\
Check out this Next.js and Turborepo starter template to ease your way into monorepo development.\\
\\
Deploy](https://vercel.com/templates/next.js/turborepo-next-basic)

## **Let Vercel manage the infrastructure**

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_003.svg)

Native integrations

Vercel operates under principles of [Framework-defined infrastructure (FDI)](https://vercel.com/blog/framework-defined-infrastructure), natively integrating with Next.js (or SvelteKit), DatoCMS, and Turborepo. FDI creates a seamless development and deployment experience.

For instance, DatoCMS users can trigger Vercel deployments directly from Dato, removing the need to handle deployments separately.

Next.js analytics, on the other hand, automatically populate in your Vercel Analytics dashboard, removing the hassle of setting up your own monitoring.

Wunderman Thompson utilizes [these native integrations](https://vercel.com/integrations) to efficiently manage their international, multi-domain portfolio of sites.

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_004.svg)

Preview deployments

Vercel's Preview Deployments allow customers to experience live previews of their sites quickly, facilitating rapid prototyping. With a preview deployment for every commit on every Git branch, your company remains agile and capable of experimentation and iteration.

These live preview deployments accurately represent the final site, complete with the global edge network, showcasing the site's performance.

Clients can interactively engage with the site, and with [Vercel's Figma-like comments feature](https://vercel.com/docs/concepts/deployments/comments), they can provide feedback directly on Preview Deployments. This eliminates the need for screenshots or lengthy descriptions, enabling quicker design iterations from a single source of truth.

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_005.svg)

Serverless for scale

Before adopting Vercel, Wunderman Thompson had to manage a separate server for each client, upgrading server capabilities as traffic increased and incurring costs when traffic was low. Vercel's serverless platform eliminates these concerns, allowing the design system and portfolio of sites to scale seamlessly based on demand.

With Vercel, Wunderman Thompson enjoys peace of mind, knowing their infrastructure can handle traffic fluctuations without crashing or breaking.

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_006.png)

A global Edge Network

[Vercel's global Edge Network](https://vercel.com/features/edge-functions), including Edge Middleware and Functions, enables truly localized digital experiences. Internationalization and localization are built-in from the start, simplifying the management of multi-language websites.

Wunderman Thompson incorporates localized versions of their websites within their CMS. To add another language, they adjust an environmental variable in the Vercel deployment.

## Improve your customer story

The composable workflow talked about in this article delivers impressive results: for Wunderman Thompson it's meant improving developer productivity by 10x and slashing costs by 25x compared to a monolithic solution like WordPress.

By leveraging a unified Turborepo powered by a headless CMS, plus Vercel's supported frameworks and seamless tool integrations, your team can focus on delivering innovative solutions with unprecedented agility. Imagine delighting your customers with live previews of their sites within a week, complete with commenting and global Edge Network performance.

Future-proof your codebase and empower your team to create exceptional digital experiences with more speed, efficiency, and versatility than ever before.

[**Talk with a migration expert**\\
\\
We can help you find the best workflow for your team's unique needs.\\
\\
Send a Message](https://vercel.com/contact/sales)

Blog post

Feb 9, 2023

### Navigating tradeoffs in large-scale website migrations

![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_007.jpg)![](images/containing-multi-site-management-within-a-single-codebase-vercel/img_008.jpg)

Julian and Jose

Vercel.com landing page

### Read this ebook