---
title: "Securing your agents with authentication and authorization"
source: "LangChain Blog"
url: "https://blog.langchain.com/agent-authorization-explainer/"
date: "2025-10-13"
scraped_at: "2026-03-03T07:23:53.569683517+00:00"
language: "en-zh"
translated: true
description: "Agents can take action which makes proper authentication and authorization critical. Read on for how to implement and evolve agent auth."
---
&#123;% raw %}

最近，每家公司都在竞相构建智能体（agents）。与几年前的 AI 应用不同，智能体不再局限于聊天交互。智能体的显著特点是能够主动执行操作——例如获取文件、发送消息、调用工具以及更新记录。这使得其影响范围更广、风险更高，因而亟需一套更为审慎周密的安全保障策略。

# 最近，每家公司都在竞相构建智能体（agents）。

# Recently, every company has been rushing to build agents.

与几年前的 AI 应用不同，智能体不再局限于聊天交互。智能体的显著特点是能够主动执行操作——例如获取文件、发送消息、调用工具以及更新记录。这使得其影响范围更广、风险更高，因而亟需一套更为审慎周密的安全保障策略。

And unlike the AI applications of years before, agents aren’t limited to chat. Agents are notable because they can take action; they can fetch files, send messages, call tools and update records — which makes the stakes higher and warrants a more thoughtful approach to securing them.

### 访问控制入门

### Access Control Primer

为访问敏感数据和使用各类工具，智能体必须经过身份认证（authentication）与权限授权（authorization）。尽管这两个术语常被混用，但其含义截然不同：

- 身份认证（AuthN）：验证“你是谁”。当访问数据时，你的智能体必须拥有一个区别于其他所有用户或应用的唯一身份。
- 权限授权（AuthZ）：决定“你能做什么”。你的智能体应对其可访问的数据范围及可执行的操作行为施加明确限制。

身份认证与权限授权（统称“鉴权”，auth）适用于所有类型的应用程序，而不仅限于智能体。为此，业界已存在 OAuth 2.0 等成熟框架，用以支持 AuthN/Z 的实现。当前许多身份提供商（Identity Providers）均在 OAuth 2.0 基础上构建了丰富的服务，帮助开发者在其应用中快速落地访问控制机制。然而，相较于现有方案所服务的传统应用，智能体具备若干独特属性，因此有必要为其设计额外的访问控制抽象与机制。

To access sensitive data and use tools, agents need to be authenticated and authorized. While often used interchangeably, the two terms have distinct meanings:

- Authentication (AuthN): verifies _who_ you are. When accessing data, your agent needs to have a distinct identity from all the other users or applications that also want access.
- Authorization (AuthZ): determines _what you can do_. Your agent should have limits on what data it can access or what actions it can take.

Authentication and authorization (collectively referred to as “auth”) are relevant to all types of applications, not just agents. To that end, there are existing frameworks like OAuth 2.0 to facilitate AuthN/Z. Many identity providers today have built extensive services on top of OAuth 2.0 to allow developers to implement access control in their applications. However, compared to the applications served by existing solutions, agents have some unique attributes that make it useful to create additional constructs for access.

### 智能体有何不同？

### What Makes Agents Different?

智能体与传统应用之间最核心的区别体现在以下三点：

1. 相较于大多数传统应用，智能体需接入数量极其庞大的服务与工具；
2. 智能体具有高度动态性，其访问需求远比传统应用更加灵活多变；
3. 智能体的审计难度显著高于传统应用。

上述每一项新特性，都对智能体的身份认证与权限授权提出了全新挑战。我们将在下文逐一展开分析。

The biggest distinctions between agents and traditional applications are:

1. Compared to most applications, agents will need to access an extremely large number of services and tools.
2. Agents are dynamic, and have significantly more fluid access needs.
3. Agents are more complex to audit than traditional applications.

Each of these new attributes comes with new considerations for agent authentication and authorization. We break them down below.

**1. 智能体需接入数量极其庞大的服务与工具：**

**1\. Agents will need to access an extremely large number of services and tools:**

- Common constructs will be useful to standardize tool access from agents  
- 采用通用的构造有助于统一规范代理（agents）对工具的访问方式  

- A standardized interface abstracting common OAuth 2.0 flows will simplify giving agents access to the data they need  
- 一个抽象了常见 OAuth 2.0 流程的标准化接口，将简化为代理授予其所需数据访问权限的过程  

**2\. Agents having significantly more fluid access needs:**  

**2．代理具有显著更灵活多变的访问需求：**  

- Traditional applications have structured access needs, where the scope of the application’s behavior is well defined. This means access controls can afford to be simpler, mainly checking if a user is allowed to consent to whatever permissions the app is requesting.  
- 传统应用程序具有结构化的访问需求，其行为范围界定清晰。这意味着访问控制可以相对简单，主要只需检查用户是否被允许同意应用程序所请求的各类权限。  

- Agent behavior is nondeterministic, not well-defined. The correct level of access may be heavily context dependent, which can make it useful to set rules like “Agent A is never allowed to request consent for permission A” or “Agent B must request consent each time permission C is needed”  
- 代理的行为具有不确定性，且难以明确定义。恰当的访问权限级别往往高度依赖具体上下文，因此设定如下规则可能十分必要：“代理 A 永远不得就权限 A 请求用户授权”，或“代理 B 每次需要权限 C 时都必须重新请求用户授权”。  

**3\. Agents are more complex to audit than traditional applications:**  

**3．代理比传统应用程序更难审计：**  

- Due to the number of services agents can access, audit logs may be spread across many providers  
- 由于代理可访问的服务数量众多，审计日志可能分散在多个服务提供商处  

- Each call to an agent may involve many services and actions, which makes individual access trajectories more difficult to interpret  
- 每次调用代理都可能涉及多项服务与操作，使得单次访问路径更难解读  

- Agents benefit more from a centralized location to track audit events and analyze access patterns  
- 代理更能从集中化的审计事件追踪与访问模式分析平台中获益  

Taken together, these considerations form the shape of a centralized framework to manage agent authentication and authorization. It should consolidate auditable events and allow flexible rule configurations to match the dynamic access needs of agents. In essence, an auth server for agents.  

综上所述，这些考量共同勾勒出一个用于管理代理身份认证与授权的集中式框架的轮廓。该框架应能聚合所有可审计事件，并支持灵活的规则配置，以适配代理动态变化的访问需求。本质上，这就是一个专为代理设计的身份认证与授权服务器（auth server）。  

### An Agent Auth Server  

### 代理身份认证与授权服务器（Agent Auth Server）  

What might such an auth server look like? We could draw inspiration from existing paradigms for human access, such as Role Based Access Control (RBAC) or Just in Time (JIT) access.  

这样的身份认证与授权服务器会是什么样？我们可以借鉴已有的、面向人类用户的访问控制范式，例如基于角色的访问控制（Role Based Access Control, RBAC）或即时（Just in Time, JIT）访问机制。  

RBAC is an access control mechanism that grants humans access to resources based on their role. Instead of tying permissions to a particular user’s identity, the permission is tied to the role the user holds (i.e. administrator). Roles can be granted and removed from users to dynamically adjust their access based on changing conditions, which can help fulfill the fluid access needs of agents.  

RBAC 是一种基于用户角色来授予其资源访问权限的访问控制机制。它不将权限直接绑定到某个具体用户的身份，而是将其绑定至该用户所担任的角色（例如“管理员”）。角色可被动态地赋予或撤销，从而根据不断变化的条件实时调整用户的访问权限——这一特性正有助于满足代理灵活多变的访问需求。  

JIT access is a security principle where users are granted temporary, privileged access to systems or resources only when needed, for a limited time. For agents, JIT access could be an effective method to allow agents to do powerful things while minimizing potential security risks.  

JIT 访问是一种安全原则，即仅在确有需要时、于限定时间内，向用户授予临时性、高权限的系统或资源访问权。对代理而言，JIT 访问可成为一种高效手段：既使其能够执行高权限操作，又最大限度降低潜在的安全风险。

By consolidating agent auth through a single service, access to tools and resources can be centralized and standardized. The server could consolidate disparate audit events, and organize them for easier review.

通过将代理（agent）的身份认证统一到单一服务中，对工具和资源的访问可以实现集中化与标准化。该服务器还可整合来自不同来源的审计事件，并对其进行结构化组织，以便更便捷地审查。

While some of these components are still being built, that doesn’t mean you, as a developer, cannot build authentication and authorization into your agents today. The foundational frameworks of auth, like OAuth 2.0, can still be used to secure your individual agentic applications.

尽管其中部分组件仍在开发中，但这并不意味着作为开发者的您无法**今天就**为您的代理集成身份认证（AuthN）与授权（AuthZ）功能。OAuth 2.0 等基础认证授权框架，依然可用于保障您各个代理应用的安全性。

### Agent AuthN and AuthZ Today

### 当前代理的身份认证与授权实践

Though agents bring new challenges, at a high level they share many similarities with traditional applications. At their core, they’re pieces of software that want access to resources. Most modern applications today use the OAuth 2.0 framework for authorization and the OIDC framework built on top of OAuth 2.0 for authentication. Agents can also effectively use these standards.

尽管代理带来了新的挑战，但从宏观层面看，它们与传统应用程序具有诸多共性：本质上，它们都是需要访问资源的软件组件。当今大多数现代应用采用 OAuth 2.0 框架实现授权，而基于 OAuth 2.0 构建的 OpenID Connect（OIDC）框架则用于身份认证。代理同样可高效采用这些标准。

However, OAuth 2.0 covers a lot of ground, and not all flows will be relevant for the agents you build. Access patterns can be broadly broken into two categories: Delegated Access and Direct Access

然而，OAuth 2.0 覆盖范围极广，并非所有授权流程都适用于您所构建的代理。访问模式大体可分为两类：**委托式访问（Delegated Access）** 与 **直连式访问（Direct Access）**。

|  | Delegated Access | Direct Access |
| --- | --- | --- |
| Definition | The agent needs to access a resource on behalf of a user | The agent needs to access a resource without user involvement |
| 定义 | 代理需代表用户访问某项资源 | 代理需在无需用户参与的情况下访问某项资源 |
| Agent Types | Useful for agents dedicated to fulfilling human requests OR agents reliant on human oversight | Useful for ambient agents, which can trigger off events, or agents conducting autonomous processes |
| 适用代理类型 | 适用于专注于响应人类请求的代理，或依赖人工监督的代理 | 适用于环境型代理（ambient agents）——可由事件自动触发，或执行完全自主流程的代理 |
| Benefits | Delegated access allows you to limit your agent’s permissions to what the human is allowed to do. It also lets you associate agent actions with human approvers | Direct Access access allows your agents to operate independently of humans, and identify when agents are conducting fully autonomous flows |
| 优势 | 委托式访问可将代理权限限制在用户本身被允许的操作范围内；同时支持将代理操作与人工审批者关联起来 | 直连式访问使代理能够脱离人工独立运行，并可明确识别出代理正在执行完全自主的流程 |
| Examples | An email assistant needing access to your emails would need you to delegate access to read your emails | A security agent triaging large amounts of incidents might need access to system logs independent of a human |
| 示例 | 邮件助手若需读取您的邮件，则需您授权其代表您访问邮箱 | 安全代理在对大量告警事件进行初步分类时，可能需要独立于人工直接访问系统日志 |

In practice, most agents will have some tasks where they need delegated access, and some where they want direct access. Most of these access scenarios can be covered by a few particular OAuth flows, which we’ll break down in this next section.

在实际应用中，大多数代理既存在需委托式访问的任务，也存在需直连式访问的任务。上述多数访问场景均可通过若干特定的 OAuth 流程予以覆盖——我们将在下一节中逐一解析。

### Delegated Access

### 委托式访问

Let’s list some common requirements for tasks in which agents need delegated access.

下面我们列举代理在执行委托式访问任务时的一些常见需求：

1. The agent needs to fulfill human requests, and is available to users as a service  
   代理需响应人类用户的请求，并以服务形式向用户开放；

2. Users should not be able to view the requests of other users without explicit permission. This means you need to…  
   用户不应能在未经明确授权的情况下查看其他用户的请求。这意味着您需要……  
   1. Identify who the user accessing your agent is — meaning you need to authenticate users  
      识别访问您代理的用户身份——即需对用户进行身份认证（AuthN）；  
   2. Control whether users have access to view a particular request to your agent — meaning you need to authorize your users  
      控制用户是否有权查看发往您代理的某项特定请求——即需对用户进行授权（AuthZ）；

3. The Agent needs to access data across several platforms (Microsoft, Slack, Jira, Google, Datadog, etc.) to do useful work. This means…  
   代理需跨多个平台（如 Microsoft、Slack、Jira、Google、Datadog 等）获取数据，才能完成有价值的工作。这意味着……  
   1. Your agent needs to obtain access to other services — meaning your agent needs authorization from these other services  
      您的代理需获得其他服务的访问权限——即需从这些外部服务处获取授权；  
   2. While handling user requests, your agent should be limited to what the user is allowed to do. If the user can’t view a top secret Microsoft document, the agent shouldn’t use that document when answering their question.  
      在处理用户请求时，您的代理操作应严格受限于该用户自身的权限范围。例如，若某用户无权查看一份“绝密”级别的 Microsoft 文档，则代理在回答其问题时也不应使用该文档。

The most common OAuth 2.0 flow used to fulfill Requirement 2 is [**Auth Code Flow**](https://auth0.com/docs/get-started/authentication-and-authorization-flow/authorization-code-flow?ref=blog.langchain.com) **.**

满足“要求 2”的最常用 OAuth 2.0 流程是 [**授权码流程（Auth Code Flow）**](https://auth0.com/docs/get-started/authentication-and-authorization-flow/authorization-code-flow?ref=blog.langchain.com)。

The OAuth 2.0 flow used to fulfill Requirement 3 is the [**OBO (On-Behalf-Of) Token Flow.**](https://learn.microsoft.com/en-us/entra/identity-platform/v2-oauth2-on-behalf-of-flow?ref=blog.langchain.com)

满足“要求 3”的 OAuth 2.0 流程是 [**OBO（On-Behalf-Of，代收代付）令牌流程**](https://learn.microsoft.com/en-us/entra/identity-platform/v2-oauth2-on-behalf-of-flow?ref=blog.langchain.com)。

**In most delegated access scenarios, Auth Code Flow and OBO Token Flow are all you need for your agent.**

**在大多数委托访问场景中，授权码流程（Auth Code Flow）和 OBO 令牌流程已足以满足您的智能体需求。**

### Direct Access

### 直接访问

We can take the same approach for Direct access, and list some requirements:

我们可采用类似方法处理“直接访问”，并列出若干要求：

1. Your agent needs to access one or more services without human involvement. This means…  
1. 您的智能体需在无人工干预的情况下访问一个或多个服务。这意味着……  

1. Other services need to be able to identify your agent and distinguish it from other applications — meaning your agent needs to be authenticated to these services  
1. 其他服务必须能够识别您的智能体，并将其与其他应用程序区分开来——即您的智能体需通过这些服务的身份验证；  

2. Your agent needs access to other services — these services need to authorize your agent to control what it has access to  
2. 您的智能体需要访问其他服务——这些服务必须对您的智能体进行授权，以管控其具体可访问的资源范围。

**The OAuth flow used to accomplish the Direct Access scenario above is the** [**Client Credentials Flow**](https://auth0.com/docs/get-started/authentication-and-authorization-flow/client-credentials-flow?ref=blog.langchain.com)

**实现上述“直接访问”场景所采用的 OAuth 流程是** [**客户端凭据流程（Client Credentials Flow）**](https://auth0.com/docs/get-started/authentication-and-authorization-flow/client-credentials-flow?ref=blog.langchain.com)。

- Client Credentials flow requires that your agent is running in a private environment where its source code is not exposed to third parties - so no mobile apps or Single Page Apps (SPAs)  
- 客户端凭据流程要求您的智能体运行于私有环境中，其源代码不得向第三方暴露——因此不适用于移动应用或单页应用（SPA）；  

- In production, it’s good practice to use a credential management mechanism to avoid long-lived credentials (which are vulnerable to compromise).  
- 在生产环境中，建议采用凭证管理机制，避免使用长期有效的凭据（此类凭据易遭泄露或滥用）。

To recap, if you’re looking to set up access for your agent, there’s likely 3 flows you’ll need:

最后总结一下：若您正为智能体配置访问权限，通常需用到以下三种 OAuth 2.0 流程：

| Type of Access | OAuth 2.0 Flows |
| --- | --- |
| Delegated Access | 1\. Auth Code Flow 2. OBO Token Flow |
| Direct Access | 3\. Client Credentials Flow |

| 访问类型 | OAuth 2.0 流程 |
| --- | --- |
| 委托访问 | 1. 授权码流程（Auth Code Flow）<br>2. OBO 令牌流程（OBO Token Flow） |
| 直接访问 | 3. 客户端凭据流程（Client Credentials Flow） |

### Conclusion

### 结论

As agents become more capable, more autonomous, and more useful, the need for a good authentication and authorization story increases.

随着智能体（agents）能力不断提升、自主性持续增强、实用性日益提高，构建一套完善的身份认证（authentication）与授权（authorization）机制的需求也愈发迫切。

Part of that story is a continuation of what’s already been built: the existing standards of OAuth 2.0 and OIDC. If you need to implement auth for your agent, you’ll likely find yourself implementing Auth Code Flow, OBO Token Flow, or Client Credentials Flow.

这一机制的一部分，是延续已有成果：即当前广泛采用的 OAuth 2.0 和 OpenID Connect（OIDC）标准。若需为您的智能体实现身份认证，您很可能需要采用授权码流程（Auth Code Flow）、“代表他人”令牌流程（OBO Token Flow），或客户端凭据流程（Client Credentials Flow）。

However, agents _do_ bring new challenges to the table. Agents will routinely span dozens of services, request access in fluid ways, and trigger chains of actions that are harder to audit. We believe there’ll be a need for new tooling to centralize control and standardize agent access.

然而，智能体确实带来了全新的挑战。智能体通常需横跨数十项服务，以动态、灵活的方式请求访问权限，并触发一系列难以审计的操作链。我们认为，亟需开发新型工具，以实现对智能体访问权限的集中管控与标准化管理。

We’ve written about [agent access control](https://blog.arcade.dev/agent-authorization-langgraph-guide?ref=blog.langchain.com) before with our friends at [Arcade](https://www.arcade.dev/?ref=blog.langchain.com), in case you’re interested in diving deeper.

我们此前曾与 [Arcade](https://www.arcade.dev/?ref=blog.langchain.com) 团队合作撰文，深入探讨了[智能体访问控制（agent access control）](https://blog.arcade.dev/agent-authorization-langgraph-guide?ref=blog.langchain.com)，若您希望进一步了解，欢迎阅读。
&#123;% endraw %}
