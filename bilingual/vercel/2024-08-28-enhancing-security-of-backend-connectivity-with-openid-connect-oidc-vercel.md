---
title: "Enhancing security of backend connectivity with OpenID Connect (OIDC) - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/enhancing-security-of-backend-connectivity-with-openid-connect"
date: "2024-08-28"
scraped_at: "2026-03-02T09:41:42.370450601+00:00"
language: "en-zh"
translated: true
description: "Vercel OpenID Connect support helps you replace long-lived credentials with temporary tokens to reduce risk."
---

Aug 28, 2024

2024 年 8 月 28 日

Vercel OpenID Connect 支持帮助您以临时令牌替代长期有效的凭据，从而降低安全风险。

In 2014, the OpenID Foundation introduced a new standard for authenticating people online, known as [OpenID Connect (OIDC)](https://openid.net/developers/how-connect-works/). This standard was initially created to simplify the authentication process for users, providing a streamlined and secure way to log into various services. Today, Vercel leverages OIDC to enhance the security of backend connectivity, enabling developers to replace long-lived credentials with more secure, temporary tokens.

2014 年，OpenID 基金会推出了一项面向在线用户身份认证的新标准，即 [OpenID Connect（OIDC）](https://openid.net/developers/how-connect-works/)。该标准最初旨在简化用户的身份认证流程，为用户登录各类服务提供更简洁、更安全的方式。如今，Vercel 借助 OIDC 提升后端连接的安全性，使开发者能够以更安全的临时令牌替代长期有效的凭据。

## **The evolution and utility of OIDC**

## **OIDC 的演进与应用价值**

OpenID Connect was initially introduced as an extension to OAuth 2.0, building on its authorization capabilities to include authentication. This combination allows OIDC to not only grant access to resources but also to verify the identity of the user, thus providing a more comprehensive and user-friendly authentication framework.

OpenID Connect 最初作为 OAuth 2.0 的扩展而提出，在其授权能力基础上增加了身份认证功能。这种结合使 OIDC 不仅能授予对资源的访问权限，还能验证用户身份，从而构建起更全面、更易用的身份认证框架。

But OIDC is not just useful for authenticating individuals, but also for authenticating services to each other. This opened up new possibilities for securing communication between service providers. The core of OIDC lies in establishing trust between service providers and identifying the caller of a service, rather than relying on static secrets.

但 OIDC 的用途不仅限于个人身份认证，还可用于服务之间的相互认证。这为保障服务提供商之间的通信安全开辟了新路径。OIDC 的核心在于在服务提供商之间建立信任关系，并识别服务调用方的身份，而非依赖静态密钥（static secrets）。  

Here's how it works:

其工作原理如下：

1. OIDC sets up a trust relationship between an identity provider (IdP) and the services that need mutual authentication.

1. OIDC 在身份提供商（IdP）与需要相互认证的服务之间建立信任关系。

2. When one service calls another, it presents an OIDC token that identifies the caller.

2. 当某项服务调用另一项服务时，它会出示一个用于标识调用方的 OIDC 令牌。

3. The receiving service can then verify the token and decide whether to accept the call based on the caller's identity.

3. 接收方服务可据此验证该令牌，并依据调用方身份决定是否接受此次调用。

This process eliminates the need for long-lived secrets that can be lost, stolen, or otherwise compromised.  
该流程消除了对长期有效的密钥（secrets）的需求，从而避免了密钥丢失、被盗或以其他方式遭到破坏的风险。

The benefits of this approach are twofold, it's:  
这种方案的优势体现在两个方面：

1. More secure because there are no static credentials that can be leaked.  
1. 更加安全：由于不存在可能泄露的静态凭据。

2. Operationally easier because the token issuance and rotation are automated.  
2. 运维更简便：令牌的签发与轮换均由系统自动完成。

By understanding how Vercel implements OIDC, you'll see how it can improve your application's security, streamline credential management, and reduce potential risks.  
通过了解 Vercel 如何实现 OIDC，您将认识到它如何提升应用安全性、简化凭据管理，并降低潜在风险。

## Leveraging OIDC with Vercel for enhanced security

## 借助 Vercel 使用 OIDC 提升安全性

Vercel recently introduced support for [OIDC Federation](https://vercel.com/docs/security/secure-backend-access/oidc). Vercel's support allows developers to replace long-lived credentials stored in environment variables with short-lived, RSA-signed JSON Web Tokens (JWTs) for external requests in both builds and [Vercel Functions](https://vercel.com/docs/functions). In other words, you can swap your risky long-living credentials with temporary ones that are verifiable by Vercel and third parties.  
Vercel 最近推出了对 [OIDC 联邦（OIDC Federation）](https://vercel.com/docs/security/secure-backend-access/oidc) 的支持。Vercel 的这一能力使开发者能够将存储在环境变量中的长期有效凭据，替换为专用于构建过程（builds）和 [Vercel Functions](https://vercel.com/docs/functions) 外部请求的短期有效、RSA 签名的 JSON Web Token（JWT）。换言之，您可以将高风险的长期凭据，替换为由 Vercel 及第三方均可验证的临时凭据。

![Long-lived credentials increase risk over time, while short-lived tokens are only created as-needed and expire, effectively minimizing associated risks.](images/enhancing-security-of-backend-connectivity-with-openid-connect-oidc-vercel/img_001.jpg)![Long-lived credentials increase risk over time, while short-lived tokens are only created as-needed and expire, effectively minimizing associated risks.](images/enhancing-security-of-backend-connectivity-with-openid-connect-oidc-vercel/img_002.jpg)  
![长期凭据随时间推移风险递增，而短期令牌仅按需生成且会过期，从而有效最小化相关风险。](images/enhancing-security-of-backend-connectivity-with-openid-connect-oidc-vercel/img_001.jpg)![长期凭据随时间推移风险递增，而短期令牌仅按需生成且会过期，从而有效最小化相关风险。](images/enhancing-security-of-backend-connectivity-with-openid-connect-oidc-vercel/img_002.jpg)  
Long-lived credentials increase risk over time, while short-lived tokens are only created as-needed and expire, effectively minimizing associated risks.  
长期凭据随时间推移风险递增，而短期令牌仅按需生成且会过期，从而有效最小化相关风险。

### Why use OIDC?

### 为何使用 OIDC？

OIDC provides a framework for securing authentication and authorization. It eliminates the need for storing long-lived credentials by issuing short-lived tokens signed by Vercel using RSA cryptography, ensuring their integrity and authenticity.  
OIDC 为身份认证（authentication）与授权（authorization）提供了安全框架。它通过签发由 Vercel 使用 RSA 密码学签名的短期令牌，取代长期凭据的存储，从而保障令牌的完整性与真实性。

By using OIDC, you can minimize the window of opportunity for attackers to exploit stolen credentials, automate token issuance and rotation to reduce the maintenance burden on developers, and ensure consistent role-based access control by managing roles instead of credentials.  
借助 OIDC，您可以大幅压缩攻击者利用被盗凭据进行恶意操作的时间窗口；通过自动化令牌签发与轮换，减轻开发者的运维负担；并通过基于角色（而非凭据）的管理方式，确保角色权限控制（RBAC）的一致性。

Using OIDC with Vercel allows seamless integration with other cloud providers and third-party services, leveraging OIDC's broad industry support and standardized protocol. The short-lived tokens issued by Vercel as the OIDC provider are recognized by major platforms like AWS, Azure, Firebase, and GCP. This interoperability enables you to manage authentication and authorization across your entire infrastructure using a single, consistent framework. Whether accessing databases, APIs, or other services, OIDC ensures that your credentials are always up-to-date and secure.

使用 Vercel 配合 OIDC，可实现与其它云服务提供商及第三方服务的无缝集成，充分利用 OIDC 广泛的行业支持和标准化协议。作为 OIDC 提供方，Vercel 所签发的短期有效令牌（short-lived tokens）已被 AWS、Azure、Firebase 和 GCP 等主流平台原生支持。这种互操作性使您能够借助统一、一致的框架，集中管理整个基础设施中的身份认证（authentication）与授权（authorization）。无论访问数据库、API 还是其他服务，OIDC 均可确保您的凭据始终最新且安全。

### Scenario 1: Using long-lived credentials in environment variables

### 场景 1：在环境变量中使用长期有效的凭据

Imagine a typical setup where a developer needs to connect their application to AWS S3. They store the AWS credentials in environment variables like `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. These credentials might look like this in a `.env` file:

设想一种典型场景：开发者需让其应用连接至 AWS S3。他们将 AWS 凭据以环境变量形式存储，例如 `AWS_ACCESS_KEY_ID` 和 `AWS_SECRET_ACCESS_KEY`。这些凭据在 `.env` 文件中可能如下所示：

```bash
AWS_ACCESS_KEY_ID=AWSKEYEXAMPLE

AWS_SECRET_ACCESS_KEY=AWSSECRETACCESSKEYEXAMPLE
```

```bash
AWS_ACCESS_KEY_ID=AWSKEYEXAMPLE

AWS_SECRET_ACCESS_KEY=AWSSECRETACCESSKEYEXAMPLE
```

These environment variables are then used throughout the application to authenticate and perform operations on S3. A potential issue with this approach is that these credentials may be static and long-lived. Over time, they might not be rotated or updated regularly. If an attacker manages to obtain your AWS credentials, they could potentially misuse these credentials to access sensitive data indefinitely until the breach is detected and the credentials are manually revoked.

这些环境变量随后在整个应用中被用于身份认证，并执行对 S3 的各类操作。该方式存在一个潜在风险：此类凭据通常是静态的、长期有效的；随着时间推移，它们可能未被定期轮换或更新。一旦攻击者成功获取您的 AWS 凭据，便可能长期滥用这些凭据访问敏感数据——直至安全事件被发现，且凭据被人工撤销为止。

![Without OIDC, credentials are typically hard-coded and stored in environment variables, remaining static and reused until manually rotated.](images/enhancing-security-of-backend-connectivity-with-openid-connect-oidc-vercel/img_003.jpg)![Without OIDC, credentials are typically hard-coded and stored in environment variables, remaining static and reused until manually rotated.](images/enhancing-security-of-backend-connectivity-with-openid-connect-oidc-vercel/img_004.jpg)Without OIDC, credentials are typically hard-coded and stored in environment variables, remaining static and reused until manually rotated.

![未采用 OIDC 时，凭据通常被硬编码并存储于环境变量中，长期保持静态，仅在人工干预下才进行轮换。](images/enhancing-security-of-backend-connectivity-with-openid-connect-oidc-vercel/img_003.jpg)![未采用 OIDC 时，凭据通常被硬编码并存储于环境变量中，长期保持静态，仅在人工干预下才进行轮换。](images/enhancing-security-of-backend-connectivity-with-openid-connect-oidc-vercel/img_004.jpg)未采用 OIDC 时，凭据通常被硬编码并存储于环境变量中，长期保持静态，仅在人工干预下才进行轮换。

### Scenario 2: Using Vercel as an IdP with OIDC

### 场景 2：将 Vercel 用作身份提供方（IdP），结合 OIDC 实现认证

By using short-lived tokens, the credentials automatically expire after a short period, mitigating the risk of long-term exploitation. Now, consider an improved setup where the developer leverages Vercel as an Identity Provider (IdP) to manage authentication using OpenID Connect (OIDC).

通过采用短期有效令牌，凭据将在较短时间内自动过期，从而显著降低长期被恶意利用的风险。现在，考虑一种更优的架构方案：开发者将 Vercel 作为身份提供方（Identity Provider, IdP），基于 OpenID Connect（OIDC）协议来统一管理身份认证。

In this scenario, instead of storing static credentials, the developer configures Vercel to issue short-lived, RSA-signed JSON Web Tokens (JWTs) dynamically when needed. This approach ensures that even if a token is compromised, it is only valid for a limited time, thereby enhancing security.

在此场景中，开发者不再存储静态凭据，而是配置 Vercel 动态签发短期有效、经 RSA 签名的 JSON Web Token（JWT）。该机制确保：即便某枚令牌不幸泄露，其有效性也仅限于极短的时间窗口，从而大幅提升整体安全性。

[First](https://vercel.com/docs/security/secure-backend-access/oidc#getting-started), the developer enables OIDC in their Vercel project's security settings. They then use the `@vercel/functions` package to fetch AWS credentials dynamically. Here’s how the integration might look:

首先，开发者在 Vercel 项目的安全设置中启用 OIDC。然后，他们使用 `@vercel/functions` 包动态获取 AWS 凭据。以下为该集成的示例：

```javascript
import { awsCredentialsProvider } from '@vercel/functions/oidc';

import * as s3 from '@aws-sdk/client-s3';



const s3client = new s3.S3Client({

5  credentials: awsCredentialsProvider({

6    roleArn: process.env.AWS_ROLE_ARN!,

7  }),

8});
```

In this setup, whenever the application needs to perform operations on S3, it requests temporary credentials from Vercel's OIDC provider. These credentials are specific to the required operation and have a short lifespan, significantly reducing the risk of misuse. For example, the `awsCredentialsProvider` function is given the Vercel-provided OIDC token, and it then obtains short-lived credentials using the role ARN specified in the environment variable, allowing the application to assume a specific role with limited permissions.

在此配置中，每当应用程序需要对 S3 执行操作时，它都会向 Vercel 的 OIDC 提供商请求临时凭证。这些凭证专用于所需的操作，且有效期很短，从而显著降低了被滥用的风险。例如，`awsCredentialsProvider` 函数接收 Vercel 提供的 OIDC 令牌，然后利用环境变量中指定的角色 ARN 获取短期有效的凭证，使应用程序能够以受限权限承担特定角色。

This method aligns with best practices in modern authentication and authorization, ensuring compliance with regulatory standards and reducing the burden of credential management.

该方法符合现代身份认证与授权的最佳实践，确保满足监管合规要求，并减轻凭证管理负担。

![With OIDC, tokens are generated dynamically and have short expiration times, reducing the risk associated with long-lived credentials.](images/enhancing-security-of-backend-connectivity-with-openid-connect-oidc-vercel/img_005.jpg)![With OIDC, tokens are generated dynamically and have short expiration times, reducing the risk associated with long-lived credentials.](images/enhancing-security-of-backend-connectivity-with-openid-connect-oidc-vercel/img_006.jpg)With OIDC, tokens are generated dynamically and have short expiration times, reducing the risk associated with long-lived credentials.

![使用 OIDC 时，令牌动态生成且有效期很短，从而降低了长期有效凭证所带来的风险。](images/enhancing-security-of-backend-connectivity-with-openid-connect-oidc-vercel/img_005.jpg)![使用 OIDC 时，令牌动态生成且有效期很短，从而降低了长期有效凭证所带来的风险。](images/enhancing-security-of-backend-connectivity-with-openid-connect-oidc-vercel/img_006.jpg)使用 OIDC 时，令牌动态生成且有效期很短，从而降低了长期有效凭证所带来的风险。

In both scenarios, identical API calls can be made to AWS, but leveraging OIDC offers a significantly more secure authentication method, effectively mitigating associated risks.

在两种场景下，均可向 AWS 发出完全相同的 API 调用；但采用 OIDC 可提供显著更安全的身份认证方式，从而有效缓解相关风险。

### How it works under the hood

### 其底层工作原理

Vercel's support for OIDC can provide an easier and more simple method for securing your application. Vercel acts as identity provider that gives your third party, in this case AWS, the means to verify that you are who you say you are. As a request is made through Vercel and goes to compute (Vercel Functions), the request is enriched with an OIDC token that’s been pre-signed and can be verified by the third party. The token may look something like this:

Vercel 对 OIDC 的支持可为您的应用提供一种更简易、更直接的安全加固方式。Vercel 充当身份提供商（Identity Provider），向第三方（此处为 AWS）提供验证您身份真实性的手段。当请求经由 Vercel 发起并进入计算层（即 Vercel Functions）时，该请求会被附加一个预签名的 OIDC 令牌，该令牌可由第三方进行验证。该令牌可能如下所示：

```bash
eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Im1yay00MzAyZWMxYjY3MGY0OGE5OGFkNjFkYWRlNGEyM2JlNyJ9.eyJpc3MiOiI8aHR0cHM6Ly9vaWRjLnZlcmNlbC5jb20-Iiwic3ViIjoib3duZXI6bWFyYy1ncmVlbnN0b2Nrcy1wcm9qZWN0czpwcm9qZWN0Om9pZGMtZGVtbzplbnZpcm9ubWVudDpkZXZlbG9wbWVudCIsInNjb3BlIjoib3duZXI6bWFyYy1ncmVlbnN0b2Nrcy1wcm9qZWN0czpwcm9qZWN0Om9pZGMtZGVtbzplbnZpcm9ubWVudDpkZXZlbG9wbWVudCIsImF1ZCI6IjxodHRwczovL3ZlcmNlbC5jb20vbWFyYy1ncmVlbnN0b2Nrcy1wcm9qZWN0cz4iLCJvd25lcl90eXBlIjoidGVhbSIsIm93bmVyIjoibWFyYy1ncmVlbnN0b2Nrcy1wcm9qZWN0cyIsIm93bmVyX2lkIjoidGVhbV9BMWIyQzNkNEU1RjZnN0g4aTlKMGtMbU4iLCJwcm9qZWN0Ijoib2lkYy1kZW1vIiwicHJvamVjdF9pZCI6InByal9LMkZuVDl5WnhWNkh3UXBMME84UjNzUGRXYzdYIiwiZW52aXJvbm1lbnQiOiJkZXZlbG9wbWVudCIsIm5iZiI6MTcyMzA5ODY5OCwiaWF0IjoxNzIzMDk4Njk4LCJleHAiOjE3MjMxNDE4OTh9.J3XFGWdHdOhnk-nbHKYWz-Aa7fT02RBzTBoGK4zSzeLh_AyMGqGqVknhudedF13sqLKHHvZoo77cryijNAg11V_jyayYsTos7KHuLX9qIjMqlKEC7Fin76z6l3qG6sj-X_JrKTCe_4wpWrIYycK2Tz01XXt2NnWEqfChyQ46n05G0e8WjT3EbL8euxhokQemrNnQLRD1gcsAQ-3_VZZ8CWZ0L5OGFyFT9qaj2cCrm_Pli1uIPpSyyZRzzvM7-X41_w1ajvvoJwSgi8JDqMfRa41Y-ipGFoR-gGAa5cxf1xeXh3W5woz7RexbYPSvrIAcnJUDvofnrdXdbYLjdWM5DQ
```

If you decode this (it's just Base64 encoded, not encrypted, and can be decoded with [jwt.io's debugger](https://jwt.io/#debugger-io?token=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Im1yay00MzAyZWMxYjY3MGY0OGE5OGFkNjFkYWRlNGEyM2JlNyJ9.eyJpc3MiOiI8aHR0cHM6Ly9vaWRjLnZlcmNlbC5jb20-Iiwic3ViIjoib3duZXI6bWFyYy1ncmVlbnN0b2Nrcy1wcm9qZWN0czpwcm9qZWN0Om9pZGMtZGVtbzplbnZpcm9ubWVudDpkZXZlbG9wbWVudCIsInNjb3BlIjoib3duZXI6bWFyYy1ncmVlbnN0b2Nrcy1wcm9qZWN0czpwcm9qZWN0Om9pZGMtZGVtbzplbnZpcm9ubWVudDpkZXZlbG9wbWVudCIsImF1ZCI6IjxodHRwczovL3ZlcmNlbC5jb20vbWFyYy1ncmVlbnN0b2Nrcy1wcm9qZWN0cz4iLCJvd25lcl90eXBlIjoidGVhbSIsIm93bmVyIjoibWFyYy1ncmVlbnN0b2Nrcy1wcm9qZWN0cyIsIm93bmVyX2lkIjoidGVhbV9BMWIyQzNkNEU1RjZnN0g4aTlKMGtMbU4iLCJwcm9qZWN0Ijoib2lkYy1kZW1vIiwicHJvamVjdF9pZCI6InByal9LMkZuVDl5WnhWNkh3UXBMME84UjNzUGRXYzdYIiwiZW52aXJvbm1lbnQiOiJkZXZlbG9wbWVudCIsIm5iZiI6MTcyMzA5ODY5OCwiaWF0IjoxNzIzMDk4Njk4LCJleHAiOjE3MjMxNDE4OTh9.J3XFGWdHdOhnk-nbHKYWz-Aa7fT02RBzTBoGK4zSzeLh_AyMGqGqVknhudedF13sqLKHHvZoo77cryijNAg11V_jyayYsTos7KHuLX9qIjMqlKEC7Fin76z6l3qG6sj-X_JrKTCe_4wpWrIYycK2Tz01XXt2NnWEqfChyQ46n05G0e8WjT3EbL8euxhokQemrNnQLRD1gcsAQ-3_VZZ8CWZ0L5OGFyFT9qaj2cCrm_Pli1uIPpSyyZRzzvM7-X41_w1ajvvoJwSgi8JDqMfRa41Y-ipGFoR-gGAa5cxf1xeXh3W5woz7RexbYPSvrIAcnJUDvofnrdXdbYLjdWM5DQ)), you'll see a payload with a few notable details including information that identifies your Vercel account, such as the `environment`, `project`, and `owner`, as well as an expiration date (`exp`):

若您对该令牌进行解码（它仅采用 Base64 编码，未加密，可通过 [jwt.io 调试器](https://jwt.io/#debugger-io?token=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Im1yay00MzAyZWMxYjY3MGY0OGE5OGFkNjFkYWRlNGEyM2JlNyJ9.eyJpc3MiOiI8aHR0cHM6Ly9vaWRjLnZlcmNlbC5jb20-Iiwic3ViIjoib3duZXI6bWFyYy1ncmVlbnN0b2Nrcy1wcm9qZWN0czpwcm9qZWN0Om9pZGMtZGVtbzplbnZpcm9ubWVudDpkZXZlbG9wbWVudCIsInNjb3BlIjoib3duZXI6bWFyYy1ncmVlbnN0b2Nrcy1wcm9qZWN0czpwcm9qZWN0Om9pZGMtZGVtbzplbnZpcm9ubWVudDpkZXZlbG9wbWVudCIsImF1ZCI6IjxodHRwczovL3ZlcmNlbC5jb20vbWFyYy1ncmVlbnN0b2Nrcy1wcm9qZWN0cz4iLCJvd25lcl90eXBlIjoidGVhbSIsIm93bmVyIjoibWFyYy1ncmVlbnN0b2Nrcy1wcm9qZWN0cyIsIm93bmVyX2lkIjoidGVhbV9BMWIyQzNkNEU1RjZnN0g4aTlKMGtMbU4iLCJwcm9qZWN0Ijoib2lkYy1kZW1vIiwicHJvamVjdF9pZCI6InByal9LMkZuVDl5WnhWNkh3UXBMME84UjNzUGRXYzdYIiwiZW52aXJvbm1lbnQiOiJkZXZlbG9wbWVudCIsIm5iZiI6MTcyMzA5ODY5OCwiaWF0IjoxNzIzMDk4Njk4LCJleHAiOjE3MjMxNDE4OTh9.J3XFGWdHdOhnk-nbHKYWz-Aa7fT02RBzTBoGK4zSzeLh_AyMGqGqVknhudedF13sqLKHHvZoo77cryijNAg11V_jyayYsTos7KHuLX9qIjMqlKEC7Fin76z6l3qG6sj-X_JrKTCe_4wpWrIYycK2Tz01XXt2NnWEqfChyQ46n05G0e8WjT3EbL8euxhokQemrNnQLRD1gcsAQ-3_VZZ8CWZ0L5OGFyFT9qaj2cCrm_Pli1uIPpSyyZRzzvM7-X41_w1ajvvoJwSgi8JDqMfRa41Y-ipGFoR-gGAa5cxf1xeXh3W5woz7RexbYPSvrIAcnJUDvofnrdXdbYLjdWM5DQ) 解码），将看到其载荷（payload）中包含若干关键信息，例如标识您 Vercel 账户的 `environment`（环境）、`project`（项目）和 `owner`（所有者），以及过期时间（`exp`）：

```json
1{

2  "iss": "https://oidc.vercel.com",

3  `"sub": "owner:marc-greenstocks-projects:project:oidc-demo:environment:development"`,  
3  `"sub": "所有者:marc-greenstocks-projects:项目:oidc-demo:环境:development"`,

4  `"scope": "owner:marc-greenstocks-projects:project:oidc-demo:environment:development"`,  
4  `"scope": "所有者:marc-greenstocks-projects:项目:oidc-demo:环境:development"`,

5  `"aud": "https://vercel.com/marc-greenstocks-projects"`,  
5  `"aud": "https://vercel.com/marc-greenstocks-projects"`,

6  `"owner": "marc-greenstocks-projects"`,  
6  `"owner": "marc-greenstocks-projects"`,

7  `"owner_id": "team_A1b2C3d4E5F6g7H8i9J0kLmN"`,  
7  `"owner_id": "team_A1b2C3d4E5F6g7H8i9J0kLmN"`,

8  `"project": "oidc-demo"`,  
8  `"project": "oidc-demo"`,

9  `"project_id": "prj_K2FnT9yZxV6HwQpL0O8R3sPdWc7X"`,  
9  `"project_id": "prj_K2FnT9yZxV6HwQpL0O8R3sPdWc7X"`,

10  `"environment": "development"`,  
10  `"environment": "development"`,

11  `"nbf": 1723098698`,  
11  `"nbf": 1723098698`,

12  `"iat": 1723098698`,  
12  `"iat": 1723098698`,

13  "exp": 1723141898

13  “exp”: 1723141898

14}

14}

```

Within your function, you can simply then leverage `awsCredentialProvider`, a function embedded within `@vercel/functions/oidc` which has knowledge of the token. This will kick off an exchange where your Vercel account now takes on the role you send along with the `awsCredentialProvider` request.

在您的函数中，只需直接调用 `awsCredentialProvider` 即可——这是一个内置于 `@vercel/functions/oidc` 包中的函数，能够识别并处理该 OIDC 令牌。此调用将触发一次凭证交换流程：您的 Vercel 账户将据此承担您随 `awsCredentialProvider` 请求一同指定的 AWS 角色。

Specifically, it calls `AssumeRoleWithWebIdentity` which is described as “returns a set of temporary security credentials for users who have been authenticated in a mobile or web application with a web identity provider.” From here, your token exchange has been automatically handled, it was just created and will expire shortly, and the only thing stored in your application is the Role that needed to be assumed.

具体而言，该流程调用的是 `AssumeRoleWithWebIdentity` API，其官方定义为：“为已在移动或 Web 应用中通过 Web 身份提供商完成身份验证的用户，返回一组临时安全凭证。” 至此，您的令牌交换已由系统自动完成：该临时凭证刚刚生成，且即将过期；而您的应用程序中唯一需要持久化存储的，仅是待承担的 AWS 角色（Role）本身。

By transitioning from long-lived credentials stored in environment variables to using Vercel as an Identity Provider (IdP) with OIDC, developers can make minimal configuration adjustments designed to enhance security.

通过将长期有效的凭据（存储于环境变量中）迁移至以 Vercel 作为 OpenID Connect（OIDC）身份提供商（IdP）的模式，开发者仅需进行极少的配置调整，即可显著提升应用安全性。

### Securing backend connectivity with Vercel

### 使用 Vercel 保障后端连接安全

As security threats continue to evolve, it's crucial to adopt best practices that minimize risks and enhance protection. Vercel’s support for OpenID Connect (OIDC) is part of a comprehensive security suite that includes [Secure Compute](https://vercel.com/docs/security/secure-compute), which enables organizations to establish secure perimeters between the Vercel Edge Network and their backend systems. Combined with OIDC’s temporary, RSA-signed tokens, this creates a robust security framework that can reduce the risks associated with credential management and backend connectivity.

随着安全威胁持续演进，采用能最大限度降低风险、增强防护能力的最佳实践变得至关重要。Vercel 对 OpenID Connect（OIDC）的支持，是其全面安全套件的重要组成部分；该套件还包括 [Secure Compute（安全计算）](https://vercel.com/docs/security/secure-compute)，可帮助组织在 Vercel 边缘网络与后端系统之间构建安全边界。再结合 OIDC 所颁发的临时性、RSA 签名令牌，这一组合形成了一个稳健的安全框架，有效降低了凭证管理与后端连接环节所面临的安全风险。

Vercel’s security approach is designed to make the web secure by default. By integrating these measures, developers can build robust applications while adding layers of protection against evolving threats. Vercel’s focus on embedded security contributes to a safer, more resilient web.

Vercel 的安全理念旨在“让 Web 默认即安全”。通过集成上述机制，开发者可在构建健壮应用的同时，层层加固防御体系，从容应对不断变化的安全威胁。Vercel 对嵌入式安全（embedded security）的专注，正助力打造一个更安全、更具韧性的互联网生态。

[Get started with OIDC in your Vercel projects](https://vercel.com/docs/security/secure-backend-access/oidc#getting-started) today and take a significant step towards a more secure and efficient development environment.

[立即在您的 Vercel 项目中启用 OIDC](https://vercel.com/docs/security/secure-backend-access/oidc#getting-started)，迈出通往更安全、更高效开发环境的关键一步。