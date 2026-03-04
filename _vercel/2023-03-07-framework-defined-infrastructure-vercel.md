---
title: "Framework-defined infrastructure - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/framework-defined-infrastructure"
date: "2023-03-07"
scraped_at: "2026-03-02T09:53:55.650200609+00:00"
language: "en-zh"
translated: true
description: "Framework defined infrastructure means programmatic framework understanding for automatic infrastructure provisioning—an evolution from Infrastructure as Code (IaC)."
---

render_with_liquid: false
Mar 7, 2023

2023年3月7日

Programmatic framework understanding for automatic infrastructure provisioning

程序化框架理解与自动化基础设施供给

[Infrastructure as code (IaC)](https://en.wikipedia.org/wiki/Infrastructure_as_code) is the industry-standard practice for provisioning infrastructure in a repeatable and reliable way.  
[基础设施即代码（IaC）](https://zh.wikipedia.org/wiki/%E5%9F%BA%E7%A1%80%E8%AE%BE%E6%96%BD%E5%8D%B3%E4%BB%A3%E7%A0%81) 是业界标准实践，用于以可重复、高可靠的方式供给基础设施。  
**Framework-defined infrastructure (FdI)** is an evolution of IaC, where the deployment environment automatically provisions infrastructure derived from the framework and the applications written in it.  
**框架定义的基础设施（FdI）** 是 IaC 的演进形态，其部署环境能自动根据所采用的框架及其上开发的应用程序，供给相应的基础设施。

The best way to understand it is that a build-time program parses the source code written to a framework, understands the intent behind the code, and then automatically generates the IaC configuration needed to run the software.  
理解它的最佳方式是：一个构建时程序解析面向某框架编写的源代码，理解代码背后的意图，并自动生成运行该软件所需的 IaC 配置。  
This means more predictable, lower cost, and lower risk DevOps through truly serverless—dare we say, _infrastructureless_—architecture.  
这意味着，借助真正无服务器（甚至可大胆称之为“无基础设施”）的架构，DevOps 流程将变得更加可预测、成本更低、风险更小。

In this article, we’ll explain how framework-defined infrastructure fits into modern views of infrastructure definition and automation.  
本文将阐述框架定义的基础设施如何融入现代基础设施定义与自动化理念之中。  
We’ll then show examples of how framework-defined infrastructure improves the experience of developing in open-source frameworks.  
随后，我们将通过实例说明框架定义的基础设施如何提升在开源框架中进行开发的体验。

## Contextualizing infrastructure as code (IaC)

## 基础设施即代码（IaC）的演进背景

In the early days of servers and the Internet we `ssh`-ed (or worse) into individual machines, running install scripts or even configuring production software using graphical user interfaces to provision infrastructure.  
在服务器与互联网发展的早期阶段，我们通常直接通过 `ssh`（或更原始的方式）登录到单台物理机器，运行安装脚本，甚至使用图形用户界面来配置生产环境软件，从而完成基础设施供给。  
As the Web scaled, it quickly became clear that this approach wouldn't scale with it, and together with the DevOps movement, IaC became the best practice for provisioning infrastructure in a repeatable and reliable way.  
随着 Web 规模不断扩大，人们很快意识到这种手动方式无法随业务同步扩展；于是，在 DevOps 运动的推动下，IaC 逐渐成为以可重复、高可靠方式供给基础设施的最佳实践。

The code in IaC represents a version-controlled description of the desired state of the infrastructure—which, when executed, will create the described system state.  
IaC 中的代码代表了对基础设施期望状态的版本化描述；当执行这些代码时，系统将被构建为所描述的状态。  
In this scenario, infrastructure can refer to:

在此语境下，“基础设施”可涵盖以下内容：

- Network equipment and setups  
- 网络设备及网络配置  

- Web and application servers  
- Web 服务器与应用服务器

- Databases and message queues

- 数据库和消息队列


## What is framework-defined infrastructure?

## 什么是框架定义的基础设施？

Framework-defined infrastructure abstracts over cloud primitives such as servers, message queues, and serverless functions, making them mere implementation details of the frameworks' concepts:

框架定义的基础设施对云原语（如服务器、消息队列和无服务器函数）进行抽象，使其仅成为框架概念的实现细节：

- Providing portability between different target infrastructure providers

- 实现跨不同目标基础设施提供商的可移植性

- Eliminating the need to manually configure infrastructure to run an application in production

- 消除在生产环境中运行应用时需手动配置基础设施的需要

- Increasing the time spent writing product code over system management

- 提升用于编写产品代码的时间占比，降低系统运维管理所占时间

- Allowing the unchanged use of the framework's native local development tools

- 允许直接使用框架原生的本地开发工具，无需任何修改

- Standardizing on pre-reviewed secure services

- 统一采用经过预审的安全服务


Frameworks use well-established patterns to provide structure and abstraction to applications, making them easier to write and understand. While the word _framework_ is hard to define, the Hollywood principle, "Don't call us, we call you," probably captures best the inversion of control, where the framework manages the high-level application flow while the developer writes code within the hooks provided by it.

框架采用成熟的设计模式，为应用程序提供结构与抽象，从而使其更易于编写和理解。尽管“框架”（_framework_）一词难以精确定义，但好莱坞原则（“别给我们打电话，我们会打给你”）最恰当地诠释了控制反转（Inversion of Control）：框架负责管理应用的高层执行流程，而开发者则在框架所提供的扩展点（hooks）中编写业务逻辑。

Framework-defined infrastructure takes advantage of both this inversion of control and the predictable structure of framework-based applications to automatically map framework concepts onto the appropriate infrastructure without the need for explicit declaration or configuration of the infrastructure.

框架定义的基础设施充分利用这种控制反转机制，以及基于框架的应用程序所具备的可预测结构，自动将框架概念映射到相应的底层基础设施上，而无需显式声明或配置基础设施。

Note that this post is giving examples based on Vercel's [Platform as a Service](https://en.wikipedia.org/wiki/Platform_as_a_service) offering. The concept, however, can be applied more widely as the basic idea of understanding a framework, and generating IaC configuration for it, can also be used for more traditional infrastructure deployments.

请注意，本文所举示例基于 Vercel 的[平台即服务（Platform as a Service）](https://en.wikipedia.org/wiki/Platform_as_a_service) 产品。然而，这一概念具有更广泛的适用性：理解某个框架并为其生成基础设施即代码（IaC）配置这一基本思路，同样可用于更传统的基础设施部署场景。

## Applying framework-defined infrastructure

## 应用框架定义的基础设施

We'll now show examples of how frameworks automatically map their concepts onto Vercel's infrastructure. Though we'll be using [the popular Next.js framework](https://nextjs.org/?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_framework_defined_infrastructure) here for demonstration, Vercel's implementation of framework-defined infrastructure supports a [multitude of other frameworks](https://vercel.com/docs/frameworks) based on the same underlying mechanism.

接下来，我们将展示框架如何自动将其自身概念映射到 Vercel 的基础设施上。虽然本文以[广受欢迎的 Next.js 框架](https://nextjs.org/?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_framework_defined_infrastructure)为例进行演示，但 Vercel 对“框架定义的基础设施”的实现，依托同一底层机制，也支持[众多其他框架](https://vercel.com/docs/frameworks)。

![Flowchart showing the process from user code to automatically inferred infrastructure.](images/framework-defined-infrastructure-vercel/img_001.jpg)![Flowchart showing the process from user code to automatically inferred infrastructure.](images/framework-defined-infrastructure-vercel/img_002.jpg)Flowchart showing the process from user code to automatically inferred infrastructure.

![展示从用户代码到自动推断出的基础设施的流程图。](images/framework-defined-infrastructure-vercel/img_001.jpg)![展示从用户代码到自动推断出的基础设施的流程图。](images/framework-defined-infrastructure-vercel/img_002.jpg)展示从用户代码到自动推断出的基础设施的流程图。

Next.js uses a file-based router that maps files in a directory structure to URLs in a web application. For example, the file `pages/blog/index.ts` creates a URL route that maps the URL `/blog` to the code defined in that file.

Next.js 采用基于文件的路由机制，将目录结构中的文件映射为 Web 应用中的 URL。例如，文件 `pages/blog/index.ts` 会创建一条 URL 路由，将路径 `/blog` 映射至该文件中定义的代码逻辑。

Framework-defined infrastructure starts by uplifting this understanding of the route table of a web application from an implementation detail of the framework to something that the infrastructure understands. In Vercel’s case, the route table generated from a framework would eventually be deployed to our gateway service, which then knows how to invoke the correct infrastructure primitive for any given route.

“框架定义的基础设施”首先将 Web 应用路由表这一原本属于框架实现细节的概念，提升为基础设施层可理解、可操作的一等公民。在 Vercel 的实现中，由框架生成的路由表最终会被部署至其网关服务（gateway service），该服务由此能够针对任意给定路由，准确调用相应的基础设施原语（infrastructure primitive）。

The contents of `pages/blog/index.tsx` might look something like this:

`pages/blog/index.tsx` 文件的内容可能如下所示：

pages/blog/index.tsx

```tsx
export default function BlogPosts({ posts }) {

2  return posts.map(post => <BlogPost key={post.id} post={post} />)
```

```
3}



export async function getServerSideProps() {

6  const posts = await getBlogPosts();

7  return {

8    props: { posts }

9  }

10}
```

```
3}



export async function getServerSideProps() {

6  const posts = await getBlogPosts();

7  return {

8    props: { posts }

9  }

10}
```

Example of a dynamically-rendered page in Next.js.

Next.js 中动态渲染页面的示例。

In this example, the user code defines a `getServerSideProps` function that fetches the blog posts on our site. Next.js invokes this function and passes the output to the default export `BlogPosts` function which renders a list of posts.

本例中，用户代码定义了一个 `getServerSideProps` 函数，用于获取我们网站上的博客文章。Next.js 会调用该函数，并将其返回结果传递给默认导出的 `BlogPosts` 函数，由该函数负责渲染文章列表。

Next.js pages with a `getServerSideProps` function get rendered dynamically on every page view. That means a production setup needs a compute service (like an application server or a serverless function) to perform this data fetching and rendering operation.

使用框架定义的基础设施（framework-defined infrastructure）时，系统会利用“含有 `getServerSideProps` 的页面需要计算资源来执行渲染操作”这一知识，自动推断出必须为此类渲染操作配置相应的计算基础设施。以 Vercel 为例，这意味着会基于 AWS Lambda 创建并部署一个无服务器函数（serverless function），其中包含渲染该页面所需的全部代码；随后，调用该函数的相关路由逻辑会被部署至网关服务（gateway service），作为应用路由表（routing table）的一部分。

Now, let's slightly modify the code example from above, to change `getServerSideProps` to `getStaticProps`:

现在，让我们对上面的代码示例稍作修改，将 `getServerSideProps` 替换为 `getStaticProps`：

pages/blog/index.tsx

```tsx
export default function BlogPosts({ posts }) {

2  return posts.map(post => <BlogPost key={post.id} post={post} />)

3}



export async function getStaticProps() {

6  const posts = await getBlogPosts();
```

```markdown
7  return {

8    props: {posts}

9  }

10}
```

```markdown
7  return {

8    props: {posts}

9  }

10}
```

The change of `getServerSideProps` to `getStaticProps` now generates the HTML at build time.

将 `getServerSideProps` 更改为 `getStaticProps` 后，HTML 现在将在构建时生成。

In Next.js, `getStaticProps` implies that rather than rendering the page on every view, the function may be invoked at build time to generate a static HTML page which then can be served to the user. Again, with framework-defined infrastructure it can be inferred that no more production compute infrastructure is needed to serve this particular web page. Instead, the artifacts generated at build time can be deployed to lower-cost, static, web-serving infrastructure. In Vercel's case, this means that **no** serverless function is deployed for this page, and instead, the application's routing table is updated to point to the respective static file service.

在 Next.js 中，`getStaticProps` 意味着：该页面无需在每次访问时动态渲染，而是可在构建阶段调用该函数，预先生成一个静态 HTML 页面，随后直接提供给用户。同样地，借助框架所定义的基础设施，我们可以推断：为服务此特定网页，**无需额外的生产环境计算资源**。取而代之的是，构建阶段生成的产物可部署至成本更低、专用于静态内容分发的 Web 托管基础设施。以 Vercel 为例，这意味着：**该页面不会部署任何无服务器函数（serverless function）**；相反，应用的路由表会被更新，使其指向对应的静态文件服务。

While this is just one example of how changes to the code within a given file can trigger the deployment of various pieces of infrastructure, the concept can be expanded to a multitude of infrastructure resources. For example:

尽管这只是“单个文件内代码变更触发多种基础设施部署”的一个示例，但这一概念可推广至大量基础设施资源。例如：

- Gatsby has a concept called [Deferred Static Generation](https://vercel.com/docs/frameworks/gatsby#deferred-static-generation). When used, a serverless function is deployed to perform the deferred generation on user request similar to server-side rendering. However, the function output is then stored in AWS S3 and pushed globally to be servable from Vercel’s edge without another function invocation.

- Gatsby 提出了一种名为 [延迟静态生成（Deferred Static Generation）](https://vercel.com/docs/frameworks/gatsby#deferred-static-generation) 的机制。启用该机制后，系统会部署一个无服务器函数，在用户请求时执行延迟生成（其行为类似于服务端渲染）。然而，该函数的输出结果随后会被存储至 AWS S3，并同步分发至全球边缘节点，从而可直接由 Vercel 边缘网络提供服务，**无需再次调用函数**。

- SvelteKit has the concept of [form actions](https://kit.svelte.dev/docs/form-actions?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_framework_defined_infrastructure). When used, a serverless function is automatically created to perform the action. The same thing happens when using [Remix](https://vercel.com/guides/deploying-remix-with-vercel).

- SvelteKit 引入了 [表单操作（form actions）](https://kit.svelte.dev/docs/form-actions?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_framework_defined_infrastructure) 的概念。一旦使用该功能，系统将自动创建一个无服务器函数来执行对应操作。类似机制也出现在 [Remix](https://vercel.com/guides/deploying-remix-with-vercel) 中。

- Next.js supports the concept of [middleware](https://nextjs.org/docs/advanced-features/middleware?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_framework_defined_infrastructure), which triggers the automatic provisioning of edge computing resources which execute the middleware code during the request processing phase.

- Next.js 支持 [中间件（middleware）](https://nextjs.org/docs/advanced-features/middleware?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_framework_defined_infrastructure) 概念，它会自动配置边缘计算资源，使中间件代码能在请求处理阶段于边缘节点上执行。

- Using the [component for image optimization](https://nextjs.org/docs/api-reference/next/image?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_framework_defined_infrastructure) automatically triggers setup of a high-performance image optimization system tailoring the image for the visiting user’s device.

- 使用 [图像优化组件](https://nextjs.org/docs/api-reference/next/image?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_framework_defined_infrastructure)，可自动启用高性能图像优化系统，根据访问用户的设备动态适配图像。

Internally, the framework primitives get compiled to Vercel’s Build Output API which is a more traditional declarative IaC configuration API that gets consumed by Vercel’s platform to provision the production infrastructure.

在内部，框架原语会被编译为 Vercel 的 Build Output API——这是一种更传统的声明式基础设施即代码（IaC）配置 API，由 Vercel 平台消费，用于部署生产环境基础设施。

## Serverless in an IaC world

## IaC 世界中的无服务器架构

IaC uses machine-readable files, which developers can version much like software, to provision infrastructure such as physical servers, virtual machines, and higher-level services like databases or applications. Serverless architecture—which, despite its name, still uses servers—eliminates the need for developers to manage specific physical or virtual servers.

基础设施即代码（IaC）使用机器可读的配置文件（开发者可像管理软件代码一样对其进行版本控制），来部署物理服务器、虚拟机，以及数据库或应用程序等更高层级的服务。无服务器（Serverless）架构——尽管其名称中不含“服务器”，但实际上仍依赖服务器——消除了开发者对特定物理或虚拟服务器进行手动管理的需求。

Serverless products still require developers to define and deploy their respective serverless primitives, much like more traditional infrastructure. For example, in the archetype of serverless products, [AWS Lambda](https://aws.amazon.com/lambda/), developers need to create a lambda function and deploy code to it.

但无服务器产品仍要求开发者像配置传统基础设施一样，明确定义并部署各自的无服务器原语。例如，在典型的无服务器产品 [AWS Lambda](https://aws.amazon.com/lambda/) 中，开发者需创建一个 Lambda 函数，并将代码部署至该函数。

In other words, the process for creating a lambda function, while somewhat less involved, is similar to the process for creating a new serverful service. Here is a sample for how to create a lambda function using [HashiCorp's Terraform](https://www.terraform.io/), one of the most popular IaC configuration tools. As you can see, the lambda function is just another resource:

换言之，创建 Lambda 函数的过程虽相对简化，但其整体流程与创建一个新的有服务器（serverful）服务十分相似。以下是一个使用目前最主流的 IaC 配置工具之一 —— [HashiCorp Terraform](https://www.terraform.io/) 创建 Lambda 函数的示例。如您所见，Lambda 函数不过是另一种资源：

```javascript
resource "aws_lambda_function" "my_lambda" {

2  filename      = "lambda_function_payload.zip"

3  function_name = "lambda_function_name"

4  role          = aws_iam_role.iam_for_lambda.arn
```

```javascript
resource "aws_lambda_function" "my_lambda" {

2  filename      = "lambda_function_payload.zip"

3  function_name = "lambda_function_name"

4  role          = aws_iam_role.iam_for_lambda.arn
```

5  handler       = "index.test"

5  处理程序（handler）= "index.test"

6  source_code_hash = filebase64sha256("lambda_function_payload.zip")

6  源代码哈希值（source_code_hash）= filebase64sha256("lambda_function_payload.zip")

7  runtime = "nodejs16.x"

7  运行时环境（runtime）= "nodejs16.x"

8  environment {

8  环境变量（environment）{

9    variables = {

9    变量（variables）= {

10      foo = "bar"

10      foo = "bar"

11    }

11    }

12  }

12  }

13}
```

13}
```

Creating a Lambda function leveraging HashiCorp Terraform

使用 HashiCorp Terraform 创建 Lambda 函数

## Solving the local development problem for serverless

## 解决无服务器架构下的本地开发难题

While serverless architecture greatly simplifies managing production infrastructure, the systems that run serverless code are often complex and proprietary, which can cause problems with local development. In a worst case scenario, local development isn't possible, and developers must test local changes by making comparatively slow deploys to the production infrastructure. In a best case scenario, developers must create a local simulation of the complex serverless stack, which then has to stay up-to-date with the production environment.

尽管无服务器架构极大简化了生产环境基础设施的管理工作，但运行无服务器代码的系统往往结构复杂且具有专有性，这给本地开发带来了诸多挑战。在最糟糕的情况下，本地开发根本无法进行，开发者只能通过将本地修改部署到生产环境（这一过程相对缓慢）来完成测试；而在较理想的情况下，开发者也必须自行构建一个本地模拟环境，以复现复杂的无服务器技术栈——而该模拟环境还需持续与生产环境保持同步更新。

![Comparison of local dev environment with and without framework-defined infrastructure. ](images/framework-defined-infrastructure-vercel/img_003.jpg)![Comparison of local dev environment with and without framework-defined infrastructure. ](images/framework-defined-infrastructure-vercel/img_004.jpg)Comparison of local dev environment with and without framework-defined infrastructure.

![框架定义基础设施对本地开发环境的影响对比图](images/framework-defined-infrastructure-vercel/img_003.jpg)![框架定义基础设施对本地开发环境的影响对比图](images/framework-defined-infrastructure-vercel/img_004.jpg)启用与未启用框架定义基础设施时的本地开发环境对比。

Framework-defined infrastructure completely eliminates this problem. Because framework-defined infrastructure lets the framework itself dictate the production behavior, local development can just use the framework's own tooling, while production infrastructure is automatically configured to be a scaled and optimized representation of the same underlying behavior.

框架定义基础设施（Framework-defined infrastructure）彻底消除了这一问题。由于框架定义基础设施允许框架自身决定生产环境的行为逻辑，因此本地开发可直接复用框架自带的开发工具；与此同时，生产环境基础设施会自动配置为同一底层行为逻辑的规模化、优化版实现。

## Framework-defined infrastructure and immutable deployments

## 框架定义基础设施与不可变部署

These days application code is developed almost exclusively within version control systems such as Git. IaC maintains infrastructure definition in either the same or a sibling version control system. Often, however, production infrastructure itself can only represent limited points in time of the infrastructure's version history. This is fundamentally incompatible with framework-defined infrastructure, which expects that production infrastructure directly maps to the framework code at the same commit hash.

如今，应用程序代码几乎完全在 Git 等版本控制系统中进行开发。基础设施即代码（IaC）则将基础设施定义保存在相同或关联的版本控制系统中。然而，生产环境基础设施本身往往仅能反映基础设施版本历史中有限的若干时间点。这与框架定义基础设施存在根本性冲突——后者要求生产环境基础设施必须严格对应于框架代码在某一特定提交哈希（commit hash）处的状态。

Immutable deployments solve this impedance mismatch between an application's and the infrastructure’s version history. Instead of deploying onto a limited number of infrastructures such as “production” and “staging,” immutable deploys create a completely new infrastructure for every single deployment that is ever made. This infrastructure is then never changed—it is immutable.

不可变部署（Immutable deployments）解决了应用程序版本历史与基础设施版本历史之间的这种“阻抗失配”。它不再将应用部署到数量有限的预设环境（如“生产环境”或“预发布环境”），而是为每一次部署都创建一套全新的基础设施。这套基础设施一经生成便永不变更——即所谓“不可变”。

![Each commit gets an immutable deployment and generates virtual infrastructure.](images/framework-defined-infrastructure-vercel/img_005.jpg)![Each commit gets an immutable deployment and generates virtual infrastructure.](images/framework-defined-infrastructure-vercel/img_006.jpg)Each commit gets an immutable deployment and generates virtual infrastructure.

![每次提交均触发一次不可变部署，并生成对应的虚拟基础设施](images/framework-defined-infrastructure-vercel/img_005.jpg)![每次提交均触发一次不可变部署，并生成对应的虚拟基础设施](images/framework-defined-infrastructure-vercel/img_006.jpg)每次提交均触发一次不可变部署，并生成对应的虚拟基础设施。

Naturally, immutable deployments are impossible to perform in a world where infrastructure is mapped to finite physical resources, which would get used up as new deployments get made. However, in a serverless world, where unused infrastructure can scale to zero, immutable deployments become possible to perform, as unused deployments do not take up physical compute resources beyond the baseline storage needed for their contents. For example, Vercel's platform creates an immutable deployment for each `git hash` pushed to a repository which is then mapped onto an entirely new virtual serverless infrastructure.

显然，在基础设施需绑定有限物理资源的传统环境中，不可变部署是不可行的——因为随着新部署不断产生，物理资源终将耗尽。但在无服务器世界中，未使用的基础设施可自动缩容至零，因此不可变部署成为可能：闲置的部署除存储其内容所需的最低限度存储资源外，并不占用任何实际计算资源。例如，Vercel 平台会对推送至代码仓库的每一个 `git hash` 创建一次不可变部署，并将其映射到一套全新、独立的虚拟无服务器基础设施上。

### Acknowledgements

### 致谢

Framework-defined infrastructures as an idea stands on the shoulder of giants.  
框架定义的基础设施这一理念，站在巨人的肩膀之上。

It relies on IaC as the ultimate infrastructure interface and hence could not work without the amazing work by its community.  
它以基础设施即代码（IaC）作为终极基础设施接口，因此若无其社区所做出的卓越贡献，便无法实现。

Furthermore, it relies on infrastructure abstractions such as [Kubernetes](https://kubernetes.io/) to actually be feasible given the relatively low amount of detail that can be extracted from the original source code, and the approach is particularly suited for targeting [PaaS](https://en.wikipedia.org/wiki/Platform_as_a_service) offerings such as the [original Google AppEngine](https://cloudplatform.googleblog.com/2008/04/introducing-google-app-engine-our-new.html).  
此外，鉴于原始源代码中可提取的细节相对有限，该理念实际可行的前提是依赖 Kubernetes 等基础设施抽象层；这种思路尤其适用于面向平台即服务（PaaS）类云产品——例如最初的 Google App Engine。

## Frameworks, not primitives

## 框架优先，而非底层原语

Here we have discussed how framework-defined infrastructure builds on IaC by understanding how a framework's patterns map to infrastructure primitives needed to run code in a scalable production system, greatly simplifying local development.  
本文探讨了框架定义的基础设施如何在 IaC 基础上进一步演进：通过理解框架自身的开发模式，将其自动映射为支撑可扩展生产系统所需的底层基础设施原语，从而极大简化本地开发流程。

Immutable deployments based on serverless architecture allow production infrastructure to perfectly map to the version of the code running on the infrastructure while being both exceptionally scalable and cost effective during low usage.  
基于无服务器架构的不可变部署，使得生产环境基础设施能与当前运行其上的代码版本严格一一对应；同时，在低负载期间仍具备极强的可伸缩性与成本效益。

It's worth repeating: at Vercel, we're implementing framework-defined infrastructure for more predictable, lower cost, and lower risk DevOps through truly serverless—and, for developers, _infrastructureless—_ architecture.  
值得再次强调：Vercel 正在通过真正意义上的无服务器架构（对开发者而言，更是“无需关注基础设施”的架构），落地框架定义的基础设施，以实现更可预测、更低成本、更低风险的 DevOps 实践。

Vercel.com landing page

Vercel.com 官网首页

### Talk to a migration expert

### 与迁移专家交流

Vercel.com landing page

Vercel.com 官网首页

### See for yourself

### 亲身体验