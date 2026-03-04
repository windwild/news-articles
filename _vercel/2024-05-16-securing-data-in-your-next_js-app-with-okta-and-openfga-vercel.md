---
title: "Securing data in your Next.js app with Okta and OpenFGA - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/securing-data-in-your-next-js-app-with-okta-and-openfga"
date: "2024-05-16"
scraped_at: "2026-03-02T09:45:03.696069583+00:00"
language: "en-zh"
translated: true
description: "Learn how to integrate a Data Access Layer in your Next.js app and use it to implement a fine-grained authorization model with OpenFGA."
---
&#123;% raw %}

May 16, 2024

2024 年 5 月 16 日

Modern Next.js applications can have large codebases operating across multiple environments, including client components running in the browser, Server Actions executing on the server, and more.

现代 Next.js 应用往往拥有庞大的代码库，并在多个环境中运行，包括在浏览器中执行的客户端组件、在服务器上执行的 Server Actions，以及其他环境。

As applications become more complex, ensuring users can access only authorized data and actions becomes paramount. To that end, Next.js equips developers with tools to maintain data security. Developers can centralize authentication and authorization checks by integrating a Data Access Layer (DAL).

随着应用复杂度不断提升，确保用户仅能访问经授权的数据与操作变得至关重要。为此，Next.js 为开发者提供了保障数据安全的工具。开发者可通过集成数据访问层（Data Access Layer，简称 DAL）来集中管理身份认证（authentication）与权限控制（authorization）检查。

In this blog post, we'll introduce the concept of a DAL and use it to implement a fine-grained authorization model within a Next.js application.

本文将介绍 DAL 的概念，并以此为基础，在 Next.js 应用中实现一套细粒度的权限控制模型。

## Client-side vs. server-side code in Next.js

## Next.js 中的客户端代码与服务端代码

### Confidential vs. public environments

### 机密环境 vs. 公共环境

Web applications typically run in two different environments: a confidential server environment and a public environment.

Web 应用通常运行在两种不同环境中：受保护的服务端环境（机密环境）和公开的客户端环境（公共环境）。

A confidential environment—your server—can execute code securely, store secrets, and should only expose data after running through all business logic.

机密环境——即你的服务器——能够安全地执行代码、存储密钥（secrets），且仅应在完整执行全部业务逻辑后才对外暴露数据。

The public environment is the browser. Interactive Next.js applications often have code that runs in the browser and reacts to events and updates that happen in or through the user interface. This client-side code is exposed in the browser and should never contain sensitive logic or secrets.

公共环境即浏览器。交互式 Next.js 应用通常包含在浏览器中运行的代码，用于响应用户界面内或通过用户界面触发的事件与状态更新。这类客户端代码完全暴露于浏览器中，因此绝不可包含敏感逻辑或密钥。

When these two environments interact with each other, the server should always double-check each action, as there has been too much wiggle room to do something unexpected from the browser.

当这两个环境相互交互时，服务器必须始终对每一项操作进行二次校验；因为从浏览器端出发，存在太多可被利用的“操作空间”，极易触发非预期行为。

### Server and client components

### 服务端与客户端组件

Modern Next.js codebases with the [App Router](https://nextjs.org/docs/app) offer the choice between [client](https://nextjs.org/docs/app/building-your-application/rendering/client-components) and [server components](https://nextjs.org/docs/app/building-your-application/rendering/server-components) for parts of the user interface or entire pages. Application logic can, for example, be executed exclusively on the server, and UI logic can live in a client component.

使用 [App Router](https://nextjs.org/docs/app) 的现代 Next.js 项目，允许你为用户界面的某一部分或整页选择使用 [客户端组件](https://nextjs.org/docs/app/building-your-application/rendering/client-components) 或 [服务端组件](https://nextjs.org/docs/app/building-your-application/rendering/server-components)。例如，应用逻辑可完全在服务端执行，而 UI 相关逻辑则可置于客户端组件中。

You can import the `server-only` package to mark a piece of code that will be run exclusively on the server. This will prevent the code from being executed in the client and potentially leak sensitive data like API keys or secrets.

你可以引入 `server-only` 包，以标记一段**仅在服务端运行**的代码。此举可防止该代码在客户端执行，从而避免意外泄露 API 密钥等敏感信息或密钥。

Client components can be marked with `'use client'`, indicating to the underlying bundler (webpack or Turbopack) to enter into the [client boundary](https://twitter.com/delba_oliveira/status/1767958810356756798).

客户端组件可通过添加 `'use client'` 指令进行标识，以此告知底层打包器（如 webpack 或 Turbopack）进入 [客户端边界（client boundary）](https://twitter.com/delba_oliveira/status/1767958810356756798)。

## Introducing a Data Access Layer into your application

## 在应用中引入数据访问层（DAL）

As your applications grow, so do the number of touch points to fetch, update, or delete data from your database or other persistent storage solution.

随着应用规模扩大，从数据库或其他持久化存储中获取、更新或删除数据的接入点（touch points）也随之增多。

The decisions about whether a user can access that data or perform those actions are often scattered throughout the codebase. A DAL can help keep a clear view of what data requests or mutations are happening and what checks are performed before they happen.

关于“用户是否能访问该数据”或“能否执行相关操作”的权限判断逻辑，往往散落在整个代码库中。而数据访问层（DAL）有助于清晰呈现：当前正在发起哪些数据请求或变更操作？以及在这些操作执行前，又进行了哪些校验？

![](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_001.jpg)![](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_002.jpg)![](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_003.jpg)![](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_004.jpg)

![](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_005.jpg)![](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_006.jpg)![](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_007.jpg)![](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_008.jpg)

This Data Access Layer sits between your application logic and your persistent storage to ensure the requested data can be presented or changes to the data can be made. The DAL makes for the ideal location for these three types of actions:

该数据访问层（DAL）位于应用逻辑与持久化存储之间，旨在确保所请求的数据可被安全呈现，或对数据的修改可被正确执行。DAL 正是实施以下三类操作的理想位置：

- Make sure the user has authenticated, so we know who they are  
- 确保用户已完成身份认证，以便我们明确其身份  

- Check whether the authenticated user is authorized to request or change the data  
- 检查已认证用户是否具备请求或修改该数据的权限  

- Fetch the data from our database or perform updates on the data  
- 从数据库中获取数据，或对数据执行更新操作  

We can add the checks with our authorization server(s) by expanding our flow chart above:  

我们可通过扩展上方的流程图，在授权服务器中加入上述检查步骤：  

![Update data flow with additional checks in our authorization server.](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_009.jpg)![Update data flow with additional checks in our authorization server.](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_010.jpg)![Update data flow with additional checks in our authorization server.](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_011.jpg)![Update data flow with additional checks in our authorization server.](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_012.jpg)Update data flow with additional checks in our authorization server.  

![在授权服务器中增加额外检查的数据流更新图。](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_009.jpg)![在授权服务器中增加额外检查的数据流更新图。](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_010.jpg)![在授权服务器中增加额外检查的数据流更新图。](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_011.jpg)![在授权服务器中增加额外检查的数据流更新图。](images/securing-data-in-your-next_js-app-with-okta-and-openfga-vercel/img_012.jpg)在授权服务器中增加额外检查的数据流更新图。

## Adding fine-grained authorization to our application  

## 为应用添加细粒度授权  

One of the most common approaches to authorization is role-based access control (RBAC), where a role contains a set of permissions and is assigned to each user.  

授权领域中最常见的方法之一是基于角色的访问控制（RBAC），即每个角色包含一组权限，并被分配给各个用户。  

RBAC is a simple way of determining what permissions a user has and what actions they should be able to perform within an application. More complex applications often require a more flexible approach to authorization, where access can be granted on a user and resource level instead of a general resource type.  

RBAC 是一种简单的方式，用于确定用户拥有哪些权限，以及他们在应用内可执行哪些操作。而更复杂的应用通常需要更灵活的授权方式——授权决策需基于具体用户与具体资源（而非泛化的资源类型）来做出。  

Enter relationship-based access control, or ReBAC. Don’t let the one extra letter in the acronym fool you; it’s an entirely different approach to authorization.  

此时，基于关系的访问控制（ReBAC）应运而生。别被缩写中多出的一个字母所迷惑；它代表的是一种截然不同的授权范式。  

Instead of checking a fixed set of permissions assigned to a user via roles, we look at the relationship between a user (or group of users) and a resource (or group of resources) to determine whether they should be able to see the data or perform an action on it.  

与 RBAC 不同，ReBAC 并不检查通过角色赋予用户的固定权限集；而是考察用户（或用户组）与资源（或资源组）之间的关系，以此判定该用户是否应被允许查看该数据，或在该数据上执行特定操作。

Because we’re looking at the bigger picture and determining relationships between two entities, these relationships often don’t need to be explicitly defined. For example, if a user belongs to a group, it is enough to grant that group access, and all its members will automatically get access, too.

因为我们着眼于整体架构，并确定两个实体之间的关系，因此这些关系通常无需显式定义。例如，如果某用户属于某个群组，则只需授予该群组访问权限，其所有成员便会自动获得相应访问权限。

The same is true for a group of resources. If a user has access to, for example, a folder, they should automatically get access to all files within that folder without explicitly defining these relationships.

资源集合同样适用这一原则。例如，若某用户有权访问某个文件夹，则其应能自动访问该文件夹内的所有文件，而无需显式定义这些访问关系。

We’ll use [OpenFGA](https://openfga.dev/), an open-source fine-grained authorization solution, to implement relationship-based access control in our application. If you prefer a managed SaaS version, you can use Okta FGA instead. It’s built on top of OpenFGA and uses the same authorization modeling language, engine, and SDKs.

我们将使用开源的细粒度授权解决方案 [OpenFGA](https://openfga.dev/)，在应用中实现基于关系的访问控制（Relationship-Based Access Control）。若您更倾向于托管型 SaaS 服务，也可选用 Okta FGA —— 它构建于 OpenFGA 之上，采用相同的授权建模语言、引擎及 SDK。

### Getting started with OpenFGA

### 开始使用 OpenFGA

To start with OpenFGA, you need to create an authorization model that describes all resource types and their possible relationships. We’ll write the model using OpenFGA’s domain-specific language (DSL). A model for Google Drive might look something like this, where we describe a user, a file, and a folder resource type:

开始使用 OpenFGA 时，您需要创建一个授权模型，用以描述所有资源类型及其可能存在的关系。我们将使用 OpenFGA 的领域特定语言（DSL）来编写该模型。以 Google Drive 为例，其模型可能如下所示，其中定义了 `user`（用户）、`file`（文件）和 `folder`（文件夹）三种资源类型：

```text
model

2  schema 1.1



type user
```

type file

类型文件

7  relations

7  关系

8    define can_delete: owner or owner from parent

8    定义 can_delete：owner 或来自 parent 的 owner

9    define can_share: owner or owner from parent

9    定义 can_share：owner 或来自 parent 的 owner

10    define can_view: viewer or owner or viewer from parent

10    定义 can_view：viewer 或 owner 或来自 parent 的 viewer

11    define can_write: owner or owner from parent

11    定义 can_write：owner 或来自 parent 的 owner

12    define is_owned: owner

12    定义 is_owned：owner

13    define is_shared: can_view but not owner

13    定义 is_shared：can_view 但非 owner

14    define owner: [user]

14    定义 owner：[user]

15    define parent: [folder]

15    定义 parent：[folder]

16    define viewer: [user, user:*]

16    定义 viewer：[user, user:*]

type folder

type folder

19  relations

19  关系

20    define can_create_file: owner or owner from parent

20    定义 can_create_file：owner 或来自父级的 owner

21    define can_create_folder: owner or owner from parent

21    定义 can_create_folder：owner 或来自父级的 owner

22    define can_share: owner or owner from parent

22    定义 can_share：owner 或来自父级的 owner

23    define can_view: viewer or owner or viewer from parent

23    定义 can_view：viewer 或 owner 或来自父级的 viewer

24    define owner: [user]

24    定义 owner：[user]

25    define parent: [folder]

25    定义 parent：[folder]

26    define viewer: [user, user:*] or owner or viewer from parent

26    定义 viewer：[user, user:*] 或 owner，或来自父级的 viewer

```

Next to the authorization model, the [OpenFGA](https://www.npmjs.com/package/@openfga/sdk) decision engine also needs some data to run against this model. This data is structured as tuples, which are sets of these three values:

除授权模型外，[OpenFGA](https://www.npmjs.com/package/@openfga/sdk) 决策引擎还需要一些数据，以便在此模型上执行决策。这些数据以“元组”（tuples）形式组织，每个元组包含以下三个值：

- A `user` is a resource consumer, like an application user or a folder

- `user` 表示资源使用者，例如应用程序用户或文件夹

- An `object` is our resource—a file, for example

- `object` 表示我们的资源，例如一个文件

- A `relation` is the relationship between the `user` and the `object`, like `owner` or `parent`

- `relation` 表示 `user` 与 `object` 之间的关系，例如 `owner`（所有者）或 `parent`（父级）

We’ll explain how to add new tuples in the next section.

我们将在下一节中说明如何添加新的元组。

All that’s left to do is add the OpenFGA SDK to your codebase by running `npm install @openfga/sdk`. Once installed, you can use the SDK to create a new client that exposes all methods you’ll need to work with the OpenFGA decision engine in your codebase:

接下来只需运行 `npm install @openfga/sdk` 将 OpenFGA SDK 添加到您的代码库中。安装完成后，您即可使用该 SDK 创建一个新的客户端，该客户端将暴露所有您在代码库中与 OpenFGA 决策引擎交互所需的方法：

```javascript
import { OpenFgaClient } from '@openfga/sdk';

const fgaClient = new OpenFgaClient({

3  // A link to your OpenFGA instance

3  // 指向您 OpenFGA 实例的链接

4  apiUrl: process.env.FGA_API_URL,

4  API 地址：`process.env.FGA_API_URL`，

5  // The ID of your store, the collection of tuples, on OpenFGA

5  // OpenFGA 上您的 store（即元组集合）的 ID

6  storeId: process.env.FGA_STORE_ID,

6  storeId: process.env.FGA_STORE_ID,

7  // The ID of your Authorization model. This changes with each change to the

7  // 授权模型的 ID。每次修改模型时该 ID 都会变化，

8  // model, and can be overwritten with each check

8  // 并可在每次权限检查时被覆盖。

9  authorizationModelId: process.env.FGA_MODEL_ID,

9  authorizationModelId: process.env.FGA_MODEL_ID,

10});

10});

[Check out this blog post](https://auth0.com/blog/fine-grained-access-control-with-okta-fga-nextjs/) for more detailed information on how to start with OpenFGA in your Next.js application.

[查看这篇博客文章](https://auth0.com/blog/fine-grained-access-control-with-okta-fga-nextjs/)，了解如何在 Next.js 应用中快速上手 OpenFGA 的详细指南。

Now that you’ve got your model and data in place and the OpenFGA SDK installed, you can ask the OpenFGA decision engine to check any read or write operation your application performs. It will return a simple yes or no, indicating whether an action is permitted for the current user, resource, or situation.

现在，您的授权模型与数据已就绪，且 OpenFGA SDK 已安装完成，您即可调用 OpenFGA 决策引擎，对应用执行的任意读写操作进行权限校验。引擎将返回一个简单的 `yes` 或 `no`，表明当前用户、资源或上下文环境下该操作是否被允许。

### Checking FGA in our DAL

### 在我们的数据访问层（DAL）中调用 FGA 校验

With our Data Access Layer, we can add an authorization check for each action.  
借助我们的数据访问层（Data Access Layer），我们可为每个操作添加授权检查。

OpenFGA exposes a nice check method for performing an authorization check.  
OpenFGA 提供了一个便捷的 `check` 方法，用于执行授权检查。

Once the OpenFGA decision engine has considered all possible scenarios, it will let us know if we can proceed with the action or if we should abort and throw an error.  
一旦 OpenFGA 决策引擎综合评估了所有可能的情形，便会告知我们是否可以继续执行该操作，或应中止操作并抛出错误。

Here’s an example of what a `getFile` action in our Data Access Layer would look like. Notice that it does an authentication check first, then proceeds to check whether the authenticated user is authorized to view the requested file, and lastly fetches and returns the file from storage:  
以下是我们数据访问层中 `getFile` 操作的一个示例。请注意：该操作首先执行身份认证检查，随后验证已认证用户是否有权查看所请求的文件，最后从存储中获取并返回该文件：

```javascript
export async function getFile(fileId) {

2  try {

3    // Check if the user is authenticated

4    if (await !isAuthenticated()) {

5      return { error: "Unauthorized" };

6    }



8    // The user is authenticated so we can grab their ID

8    // 用户已通过身份认证，因此我们可以获取其用户 ID
```

9    const userId = await getUserId();

9    const userId = await getUserId();

11    // Check with OpenFGA if the user can view the file we're trying to fetch

11    // 使用 OpenFGA 检查用户是否具有查看我们正尝试获取的文件的权限

12    const { allowed } = await openfgaClient.check({

12    const { allowed } = await openfgaClient.check({

13      user: `user:${userId}`,

13      user: `user:${userId}`,

14      relation: "can_view",

14      relation: "can_view",

15      object: `file:${fileId}`,

15      object: `file:${fileId}`,

16    });

16    });

18    // If the user is not authorized, we'll show an error

18    // 如果用户未获授权，我们将显示一个错误

19    if (!allowed) {

19    如果未获授权（`allowed` 为假）：

20      return { error: "Forbidden" };

20      则返回 `{ error: "Forbidden" }`；

21    }



21    }



23    // The user was authorized, so we'll fetch our file and return it

23    // 用户已通过授权，因此我们将获取文件并返回该文件

24    return await getFileFromStore(fileId);

24    返回 `await getFileFromStore(fileId)` 的结果；

25  } catch (error) {

25  } catch (error) {

26    return { error };

26    返回 `{ error }`；

27  }

27  }

28}

28}

When writing data, we’re also passing through our DAL so that a `writeFile` action would look very similar to the above.

在写入数据时，我们同样会经过数据访问层（DAL），因此 `writeFile` 操作将与上述示例非常相似。

Still, when updating data in a cloud storage application—like uploading a new file, for example—we must ensure our OpenFGA service knows about this new data. To do this, we’ll have to create new tuples: sets of data the decision engine considers when making a decision.

然而，在云存储应用中更新数据时——例如上传一个新文件——我们必须确保 OpenFGA 服务知晓该新数据。为此，我们需要创建新的元组（tuples）：即决策引擎在做出授权决策时所参考的数据集合。

We’ll add two new tuples. The first marks the current user as the owner of the new file, and the second sets the current folder as the parent folder of a new file:

我们将添加两个新元组：第一个将当前用户标记为该新文件的所有者；第二个则将当前文件夹设为该新文件的父文件夹。

```javascript
export async function uploadFile(parent, file) {

2  try {

3    // Check if the user is authenticated

4    if (await !isAuthenticated()) {

5      return { error: "Unauthorized" };

6    }
```

8    // The user is authenticated, so we can grab their ID

8    // 用户已通过身份验证，因此我们可以获取其用户 ID

9    const userId = await getUserId();

9    const userId = await getUserId();

11    // Check with OpenFGA if the user can create new files in the current location

11    // 使用 OpenFGA 检查用户是否能在当前位置创建新文件

12    const { allowed } = await openfgaClient.check({

12    const { allowed } = await openfgaClient.check({

13      user: `user:${userId}`,

13      user: `user:${userId}`,

14      relation: "can_create_file",

14      relation: "can_create_file",

15      object: `folder:${parent}`,

15      object: `folder:${parent}`,

16    });

16    });

18    // If the user is not authorized, we'll show an error

18    // 如果用户未获授权，我们将显示错误信息

19    if (!allowed) {

19    if (!allowed) {

20      return { error: "Forbidden" };

20      return { error: "Forbidden" };

21    }



21    }



23    // Write the file to a persistent location

23    // 将文件写入持久化存储位置

24    const {fileId} = await writeFile(file);

24    const {fileId} = await writeFile(file);



26    // Write OpenFGA tuples for the new file

26    // 为新文件写入 OpenFGA 元组

27    await openfgaClient.writeTuples([\
\
27    await openfgaClient.writeTuples([\
\
28      {\
\
28      {\
\
29        user: `user:${userId}`,\
\
29        user: `user:${userId}`,\
\
30        relation: "owner",\
\
30        relation: "owner",\
\
31        object: `file:${fileId}`,\
\
31        object: `file:${fileId}`,\
\
32      },\
\
32      },\
\
33      {\
\
33      {\
\
34        user: `folder:${parent}`,\
\
34        user: `folder:${parent}`,\
\
35        relation: "parent",\
\
35        relation: "parent",\
\
36        object: `file:${fileId}`,\
\
36        object: `file:${fileId}`,\
\
37      },\
\
37      },\
\
38    ]); 

38    ]);

40    return file;

40    返回文件；

41  } catch (error) {

41  } catch (error) {

42    return { error };

42    返回 { error }；

43  }

43  }

44}

44}

Using a dedicated authorization service like OpenFGA, we have one centralized location where all authorization logic is created, maintained, and executed. This makes it easier to audit these decisions since you don’t need to go through your codebase and sift through endless `if…else` statements making these decisions.

使用 OpenFGA 这类专用授权服务，所有授权逻辑的创建、维护与执行都集中在一个统一的位置。这使得审计这些授权决策变得更加容易，因为你无需遍历整个代码库，也不必在无穷无尽的 `if…else` 语句中逐一排查决策逻辑。

On top of that, all your applications will have access to the same consistent authorization logic. When some of this logic changes, the applications don’t need changing because they’ll only ask yes/no questions to OpenFGA.

此外，你所有的应用程序都将共享同一套一致的授权逻辑。当部分逻辑发生变更时，应用程序本身无需修改，因为它们只需向 OpenFGA 提出“是/否”式的简单问题即可。

## Error handling

## 错误处理

You want your users to see as few errors as possible. Because of this, you may make optimistic decisions and follow a success-by-default approach, assuming all goes well unless an error occurs.

你希望用户看到的错误越少越好。因此，你可能会采取乐观决策策略，采用“默认成功”的方式——即假设一切顺利，仅在发生错误时才进行异常处理。

When dealing with user data, there is no room for such optimism. The best approach is to assume a user is not authenticated and authorized unless we determine they are.

处理用户数据时，容不得这种乐观心态。最佳做法是：除非我们明确确认用户已通过身份验证和授权，否则一律默认其未通过验证与授权。

In the two code samples, you’ll notice we start with our authentication check and immediately return an error if it fails, stopping the rest of the method's execution. The same is true for the authorization check. Only if both checks return the expected result do we touch the data.

在两个代码示例中，您会注意到：我们首先执行身份验证检查；一旦失败，立即返回错误并终止该方法后续所有执行流程。授权检查亦遵循相同逻辑。仅当这两项检查均返回预期结果时，我们才访问（或操作）数据。

## Conclusion

## 结论

Centralizing all data operations within a Data Access Layer (DAL) simplifies authentication and authorization checks, allowing you to build secure and scalable Next.js applications.

将所有数据操作集中于数据访问层（Data Access Layer, DAL）中，可简化身份验证与授权检查，助您构建安全、可扩展的 Next.js 应用程序。

A fine-grained authorization approach, as with OpenFGA in the DAL, offers flexibility. It enables you to validate each action to ensure compliance with your authorization model. This ensures that unauthorized actions are quickly blocked, maintaining security and minimizing potential risks.

采用细粒度授权方案（例如在 DAL 中集成 OpenFGA），可提供更高灵活性：它支持对每个操作进行校验，确保其符合您的授权模型。这能快速拦截未授权操作，从而保障系统安全，并最大限度降低潜在风险。
&#123;% endraw %}
