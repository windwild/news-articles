---
title: "Custom Authentication and Access Control for LangGraph Platform"
source: "LangChain Blog"
url: "https://blog.langchain.com/custom-authentication-and-access-control-in-langgraph/"
date: "2025-10-13"
scraped_at: "2026-03-03T07:25:07.057421884+00:00"
language: "en-zh"
translated: true
---
{% raw %}

_Note: As of October 2025, LangGraph Platform has been re-named to "LangSmith Deployment"._

_注：截至 2025 年 10 月，LangGraph Platform 已正式更名为 “LangSmith Deployment”。_

Today we're introducing custom authentication and resource-level access control for Python deployments in LangGraph Cloud and self-hosted environments. This feature lets you integrate your own auth providers and implement granular access patterns directly in your LangGraph applications.

今天，我们正式推出面向 LangGraph Cloud 及自托管环境的 Python 部署的**自定义身份验证（Custom Authentication）与资源级访问控制（Resource-Level Access Control）**功能。该功能支持您集成自有身份认证服务提供商，并在 LangGraph 应用中直接实现细粒度的访问控制策略。

## Quick Links

## 快速链接

- [Video Tutorial: Adding Custom Authentication to LangGraph](https://youtu.be/g7s_6t5Jm4I?ref=blog.langchain.com)  
- [视频教程：为 LangGraph 添加自定义身份验证](https://youtu.be/g7s_6t5Jm4I?ref=blog.langchain.com)
- Authentication tutorial series:  
- 身份验证系列教程：
1. [Basic Authentication](https://langchain-ai.github.io/langgraph/tutorials/auth/getting_started/?ref=blog.langchain.com) \- Learn to add user authentication to a `langgraph` app  
1. [基础身份验证](https://langchain-ai.github.io/langgraph/tutorials/auth/getting_started/?ref=blog.langchain.com) — 学习如何为 `langgraph` 应用添加用户身份验证  
2. [Resource Authorization](https://langchain-ai.github.io/langgraph/tutorials/auth/resource_auth/?ref=blog.langchain.com) \- Add authorization & resource filtering to make conversations private  
2. [资源授权](https://langchain-ai.github.io/langgraph/tutorials/auth/resource_auth/?ref=blog.langchain.com) — 添加授权机制与资源过滤能力，保障对话私密性  
3. [Production Auth](https://langchain-ai.github.io/langgraph/tutorials/auth/add_auth_server/?ref=blog.langchain.com) \- Connect your application with OAuth2 providers like Supabase  
3. [生产环境身份验证](https://langchain-ai.github.io/langgraph/tutorials/auth/add_auth_server/?ref=blog.langchain.com) — 将您的应用与 Supabase 等 OAuth2 认证服务提供商对接  
- [Conceptual Guide: Authentication & Access Control](https://langchain-ai.github.io/langgraph/concepts/auth/?ref=blog.langchain.com)  
- [概念指南：身份验证与访问控制](https://langchain-ai.github.io/langgraph/concepts/auth/?ref=blog.langchain.com)
- [Quick guide](https://langchain-ai.github.io/langgraph/how-tos/auth/custom_auth/?ref=blog.langchain.com) on how to implement custom auth  
- [快速入门指南](https://langchain-ai.github.io/langgraph/how-tos/auth/custom_auth/?ref=blog.langchain.com)：如何实现自定义身份验证  
- [`Auth`](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.Auth) reference docs  
- [`Auth`](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.Auth) 参考文档  

## Why Custom Authentication?

## 为何需要自定义身份验证？

While LangGraph Cloud provides built-in API key authentication, production deployments often need deeper integration with existing auth systems. Teams frequently need to:

尽管 LangGraph Cloud 提供了内置的 API 密钥身份验证机制，但在生产环境中，部署通常需更深度地集成现有身份认证系统。团队常面临以下需求：

- Validate credentials using their own auth provider  
- 使用自有身份认证服务提供商验证凭据  
- Scope conversations to specific users  
- 将对话范围限定于特定用户  
- Add OAuth support for end-user authentication  
- 为终端用户身份验证添加 OAuth 支持  
- Implement role-based access control (RBAC)  
- 实施基于角色的访问控制（RBAC）

Custom authentication provides low-level primitives that integrate with any auth system while maintaining LangGraph's simplicity. A typical flow would look something like the following:

自定义身份验证提供底层原语（primitives），可与任意身份认证系统无缝集成，同时保持 LangGraph 原有的简洁性。一个典型的工作流程如下图所示：

![](images/custom-authentication-and-access-control-for-langgraph-platform/img_001.png)

Your [`@auth.authenticate`](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.Auth.authenticate) handler in LangGraph handles steps 4-6, while your [`@auth.on`](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.Auth.on) handlers implement step 7. Keep reading to learn more!

LangGraph 中的 [`@auth.authenticate`](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.Auth.authenticate) 处理器负责执行流程中的第 4–6 步；而 [`@auth.on`](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.Auth.on) 处理器则用于实现第 7 步。请继续阅读，深入了解详情！

## Adding to your app

## 添加到您的应用中

The system centers around the [`Auth`](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.Auth) object, which provides two key capabilities:

系统围绕 [`Auth`](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.Auth) 对象构建，该对象提供两项核心能力：

1. **Authentication**: Validate credentials and identify users. The authentication handler (marked by `@auth.authenticate` ) receives each request and returns a [`MinimalUserDict`](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.types.MinimalUserDict) containing the user's identity:

1. **身份认证（Authentication）**：验证凭据并识别用户。身份认证处理器（通过 `@auth.authenticate` 标记）接收每个请求，并返回一个包含用户身份信息的 [`MinimalUserDict`](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.types.MinimalUserDict)：

```python
from langgraph_sdk import Auth

auth = Auth()

@auth.authenticate
async def get_current_user(authorization: str | None) -> Auth.types.MinimalUserDict:
    """Validate JWT tokens and extract user information."""
    assert authorization
    scheme, token = authorization.split()
    assert scheme.lower() == "bearer"

    # Validate with your auth provider
    user = await validate_token(token)
    return {
        "identity": user["id"],
        "email": user["email"],
        "is_authenticated": True
    }
```

```python
from langgraph_sdk import Auth

auth = Auth()

@auth.authenticate
async def get_current_user(authorization: str | None) -> Auth.types.MinimalUserDict:
    """验证 JWT 令牌并提取用户信息。"""
    assert authorization
    scheme, token = authorization.split()
    assert scheme.lower() == "bearer"

    # 使用您自己的认证服务进行验证
    user = await validate_token(token)
    return {
        "identity": user["id"],
        "email": user["email"],
        "is_authenticated": True
    }
```

With authentication alone, non-credentialed requests are rejected. However, authenticated users are still able to access all resources since we haven't introduced any resource ownership. That's the role of the authorization handlers below.

仅靠身份认证，未携带有效凭据的请求将被拒绝；但已通过认证的用户仍可访问所有资源，因为我们尚未引入任何资源所有权机制。这一职责由下方的授权处理器（authorization handlers）承担。

![](images/custom-authentication-and-access-control-for-langgraph-platform/img_002.png)

![](images/custom-authentication-and-access-control-for-langgraph-platform/img_002.png)

2. **Authorization**: Control access to specific resources. Authorization handlers receive an [`AuthContext`](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.types.AuthContext) containing user information (from your `@auth.authenticate` function above) and can add metadata to the resource indicating ownership and/or return filters that control resource access:

2. **授权（Authorization）**：控制对特定资源的访问权限。授权处理器接收一个 [`AuthContext`](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.types.AuthContext)，其中包含用户信息（即上文 `@auth.authenticate` 函数所返回的数据），并可向资源添加表明所有权的元数据，和/或返回用于控制资源访问范围的过滤器：

```python
@auth.on
async def add_owner(ctx: Auth.types.AuthContext, value: dict):
    """Make resources private to their creator."""
    filters = {"owner": ctx.user.identity}
    metadata = value.setdefault("metadata", {})
    metadata.update(filters)
    return filters
```

```python
@auth.on
async def add_owner(ctx: Auth.types.AuthContext, value: dict):
    """使资源仅对其创建者私有。"""
    filters = {"owner": ctx.user.identity}
    metadata = value.setdefault("metadata", {})
    metadata.update(filters)
    return filters
```

Now that an authorization handler has been implemented, resources' metadata are stamped with an "`owner`" ID to restrict access only to threads the user has created.

在授权处理程序实现后，资源的元数据将被标记上一个 "`owner`"（所有者）ID，从而将访问权限限制为仅限用户自己创建的线程。

![](images/custom-authentication-and-access-control-for-langgraph-platform/img_003.png)

Authorization event handlers have three main jobs:

授权事件处理程序主要有三项职责：

1. Add metadata to resources being created.  
   1. 向正在创建的资源添加元数据。

2. Return filters so users can only access matching resources  
   2. 返回过滤器，确保用户仅能访问匹配的资源。

3. Reject requests from users who lack permissions to this resource or action.  
   3. 拒绝无权访问该资源或执行该操作的用户的请求。

To use custom auth in your deployment, add an auth configuration to your `langgraph.json`, pointing to the `auth` variable name and path in your app deployment.

如需在部署中使用自定义认证机制，请在 `langgraph.json` 中添加一项 `auth` 配置，指向应用部署代码中 `auth` 变量的路径和名称。

```json
{
  "auth": {
    "path": "src/security/auth.py:auth"
  }
}
```

```json
{
  "auth": {
    "path": "src/security/auth.py:auth"
  }
}
```

## Resource-Level Control

## 资源级控制

The authorization system provides fine-grained control over `threads`, `assistants`, and `crons` (support for authorization on `store` actions to be released soon). Instead of a single global handler, you can implement custom logic for different operations:

授权系统支持对 `threads`（会话）、`assistants`（助手）和 `crons`（定时任务）进行细粒度控制（对 `store`（存储）操作的授权支持即将发布）。与单一全局处理程序不同，您可以为不同操作分别实现定制化逻辑：

```python
@auth.on.threads.create
async def on_thread_create(ctx: Auth.types.AuthContext, value: Auth.types.on.threads.create.value):
    """Custom logic for thread creation"""
    if not has_permission(ctx.user, "threads:create"):
        raise Auth.exceptions.HTTPException(status_code=403)
    return {"owner": ctx.user.identity}
```

```python
@auth.on.threads.create
async def on_thread_create(ctx: Auth.types.AuthContext, value: Auth.types.on.threads.create.value):
    """线程创建的自定义逻辑"""
    if not has_permission(ctx.user, "threads:create"):
        raise Auth.exceptions.HTTPException(status_code=403)
    return {"owner": ctx.user.identity}
```

```python
@auth.on.assistants
async def on_assistants(ctx: Auth.types.AuthContext, value: Auth.types.on.assistants.value):
    """Restrict access to assistants resource"""
    if not is_admin(ctx.user):
        raise Auth.exceptions.HTTPException(status_code=403)
```

```python
@auth.on.assistants
async def on_assistants(ctx: Auth.types.AuthContext, value: Auth.types.on.assistants.value):
    """限制对 assistants 资源的访问"""
    if not is_admin(ctx.user):
        raise Auth.exceptions.HTTPException(status_code=403)
```

LangGraph will use the most specific handler that matches the resource and action being accessed, falling back to broader handlers when needed. For a given event, at most one handler is called.

LangGraph 将优先使用与被访问资源及操作最匹配的最具体处理器；当无精确匹配时，则回退至更宽泛的处理器。对于任一给定事件，最多仅调用一个处理器。

## Current Support

## 当前支持情况

Custom authentication is currently available for Python deployments only. Support for JavaScript deployments is coming soon.

目前，自定义身份验证仅支持 Python 部署。JavaScript 部署的支持即将上线。

## Next Steps

## 下一步

The fastest way to get started is by checking out the [quick how-to guide](https://langchain-ai.github.io/langgraph/how-tos/auth/custom_auth/?ref=blog.langchain.com) on implementing custom auth. We also have the following resources:

最快上手的方式是查阅关于实现自定义身份验证的[快速入门指南](https://langchain-ai.github.io/langgraph/how-tos/auth/custom_auth/?ref=blog.langchain.com)。我们还提供以下资源：

- Video Tutorial: Adding Custom Authentication to LangGraph  
- 视频教程：为 LangGraph 添加自定义身份验证  
- Authentication tutorial series:  
- 身份验证系列教程：  
1. [Basic Authentication](https://langchain-ai.github.io/langgraph/tutorials/auth/getting_started/?ref=blog.langchain.com) \- learn to add user authentication to a langgraph app  
1. [基础身份验证](https://langchain-ai.github.io/langgraph/tutorials/auth/getting_started/?ref=blog.langchain.com) — 学习如何为 LangGraph 应用添加用户身份验证  
2. [Resource Authorization](https://langchain-ai.github.io/langgraph/tutorials/auth/resource_auth/?ref=blog.langchain.com) \- add authorization & resource filtering to make conversations private  
2. [资源授权](https://langchain-ai.github.io/langgraph/tutorials/auth/resource_auth/?ref=blog.langchain.com) — 添加授权机制与资源过滤，保障对话私密性  
3. [Production Auth](https://langchain-ai.github.io/langgraph/tutorials/auth/add_auth_server/?ref=blog.langchain.com) \- integrate with an identity server to finish the implementation  
3. [生产环境身份验证](https://langchain-ai.github.io/langgraph/tutorials/auth/add_auth_server/?ref=blog.langchain.com) — 与身份认证服务器集成，完成最终部署  

To learn even more, check out the [conceptual guide on custom authentication & access control](https://langchain-ai.github.io/langgraph/concepts/auth/?ref=blog.langchain.com), and the [reference docs](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.Auth) on the auth object.

如需深入了解，请参阅[自定义身份验证与访问控制的概念指南](https://langchain-ai.github.io/langgraph/concepts/auth/?ref=blog.langchain.com)，以及关于 `auth` 对象的[参考文档](https://langchain-ai.github.io/langgraph/cloud/reference/sdk/python_sdk_ref/?ref=blog.langchain.com#langgraph_sdk.auth.Auth)。

And check out the [full-stack template](https://github.com/langchain-ai/custom-auth?ref=blog.langchain.com) ( [demo](https://custom-auth.vercel.app/?ref=blog.langchain.com)) that connects your LangGraph chatbot with a react frontend.

此外，欢迎查看该[全栈模板](https://github.com/langchain-ai/custom-auth?ref=blog.langchain.com)（含 [演示应用](https://custom-auth.vercel.app/?ref=blog.langchain.com)），它将您的 LangGraph 聊天机器人与 React 前端无缝集成。

Try it out and share your feedback on [GitHub](https://github.com/langchain-ai/langgraph/discussions?ref=blog.langchain.com). This is another step toward supporting more sophisticated deployment patterns — we're excited to see what you build!

欢迎立即尝试，并在 [GitHub](https://github.com/langchain-ai/langgraph/discussions?ref=blog.langchain.com) 上分享您的反馈。这是 LangGraph 支持更复杂部署模式的又一重要进展——我们热切期待您构建出的精彩应用！
{% endraw %}
