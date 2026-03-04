---
title: "Automatic SSL with Vercel and Let's Encrypt - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/automatic-ssl-with-vercel-lets-encrypt"
date: "2019-04-16"
scraped_at: "2026-03-02T10:07:47.986422017+00:00"
language: "en-zh"
translated: true
description: "Learn how Vercel uses Let's Encrypt to provision free SSL certificates for all users, automatically."
---
&#123;% raw %}

Apr 16, 2019

2019 年 4 月 16 日

Our Vercel platform enables you to deploy modern websites and applications without needing any complicated server configuration. Not only do we automatically configure DNS records for your domain, we also instantly issue and renew free wildcard SSL certificates, completely hands-free.

Vercel 平台使您无需进行任何复杂的服务器配置，即可部署现代网站与应用程序。我们不仅会自动为您配置域名的 DNS 记录，还能即时签发并自动续期免费的通配符 SSL 证书，全程无需人工干预。

Historically, companies have spent thousands to get their websites HTTPS-enabled. Not to mention the whole process of issuance, download, re-upload, reconfigure, restart server with downtime — it's always enormously stressful and requires significant engineering resources.

过去，企业往往需花费数千美元才能为其网站启用 HTTPS；更不用说整个流程——证书申请、下载、重新上传、服务器重配置、重启（伴随服务中断）——始终令人倍感压力，且需投入大量工程资源。

So how are _we_ able to make this process automatic and free?

那么，我们究竟是如何实现这一流程的自动化与免费化的呢？

All thanks to [Let's Encrypt™](https://letsencrypt.org/), a non-profit whose platform we utilize to issue SSL certificates to our users.

这一切都要归功于非营利组织 [Let's Encrypt™](https://letsencrypt.org/) —— 我们借助其平台，为用户签发 SSL 证书。

**To support Let's Encrypt's mission to encrypt the web, Vercel is coming on board as a sponsor**.

**为支持 Let's Encrypt “加密整个互联网”的使命，Vercel 正式成为其赞助商**。

Let's Encrypt's role has been fundamental in enabling our customers to offer a secure experience to their users.

Let's Encrypt 所发挥的关键作用，使我们的客户能够为其用户提供安全可靠的使用体验。

In this post, we explore how we utilize [Let's Encrypt™](https://letsencrypt.org/) under the hood.

本文将深入探讨我们在底层如何利用 [Let's Encrypt™](https://letsencrypt.org/)。

### No more painful and expensive SSL Certificates

### 告别繁琐又昂贵的 SSL 证书

HTTPS plays a fundamental role in enabling privacy and integrity on the web today.

如今，HTTPS 在保障网络隐私性与数据完整性方面发挥着基础性作用。

When properly configured, not only does it promise a fast and secure web experience, it opens you up to [better SEO](https://searchengineland.com/googles-gary-illyes-https-may-break-ties-between-two-equal-search-results-230691), [AMP support](https://www.ampproject.org/), and [trustworthy status](https://security.googleblog.com/2016/09/moving-towards-more-secure-web.html).

在正确配置后，它不仅可提供快速、安全的网页体验，还能为您带来[更优的搜索引擎优化（SEO）效果](https://searchengineland.com/googles-gary-illyes-https-may-break-ties-between-two-equal-search-results-230691)、[AMP 支持](https://www.ampproject.org/)以及[可信网站标识](https://security.googleblog.com/2016/09/moving-towards-more-secure-web.html)。

![](images/automatic-ssl-with-vercel-and-let_s-encrypt-vercel/img_001.jpg)

[Labelbox](https://labelbox.com/) 是我们优秀的初创企业客户之一，也是一家前沿的人工智能公司。他们从未手动配置 SSL，而是选择专注于通过机器学习改变世界。

使用 Vercel 部署时，您完全无需操心网站 SSL 证书的配置与续期工作。

### Use case 1: Automatic SSL and renewal

### 场景一：自动 SSL 配置与证书续期

You need an HTTPS-enabled site before you can roll it out to customers.

在面向客户正式上线前，您的网站必须支持 HTTPS。

Vercel completely automates this for you. Once you purchase a domain [through Vercel domains](https://vercel.com/domains) or [set up an external one](https://vercel.com/docs/custom-domains), you can add an alias from the domains tab on the project dashboard.

Vercel 将全程为您自动完成此项工作。您只需通过 [Vercel 域名服务](https://vercel.com/domains) 购买域名，或 [配置外部域名](https://vercel.com/docs/custom-domains)，即可在项目仪表板的“Domains（域名）”标签页中添加域名别名。

That's it! The next time you deploy with [`vercel --target production`](https://vercel.com/docs/custom-domains#deploying-with-your-domain), we automatically alias your chosen domain name to the latest deployment, and ensure that they have fresh certificates installed.

就这样！下次您运行 [`vercel --target production`](https://vercel.com/docs/custom-domains#deploying-with-your-domain) 进行部署时，我们将自动将您选定的域名指向最新部署，并确保其始终配备有效且最新的 SSL 证书。

Deployments are automatically HTTPS-enabled.

所有部署均默认启用 HTTPS。

### Use case 2: Automatic staging for teams

### 场景二：面向团队的自动预发布环境

Your team is constantly introducing new features via pull requests on GitHub or merge requests on GitLab. Wouldn't it be great to have an instant staging deployment tied to every branch?

您的团队正持续通过 GitHub 上的 Pull Request 或 GitLab 上的 Merge Request 引入新功能。如果每个分支都能自动触发一个即时的预发布（staging）部署，那岂不是很棒？

Our official [GitHub](https://vercel.com/github) and [GitLab](https://vercel.com/gitlab) integrations trigger automatic deployments when you push your code. Each GitHub PR or GitLab MR gets a distinct, HTTPS-enabled staging URL that your team can use to test work before it gets merged.

我们官方提供的 [GitHub](https://vercel.com/github) 和 [GitLab](https://vercel.com/gitlab) 集成会在您推送代码时自动触发部署。每个 GitHub Pull Request 或 GitLab Merge Request 都会获得一个独立的、支持 HTTPS 的预发布 URL，您的团队可在代码合并前使用该地址进行测试。

![As you introduce new changes to the branch, the deployment URL doesn't change and reflects all the updates.](images/automatic-ssl-with-vercel-and-let_s-encrypt-vercel/img_002.jpg)  
![当您向分支引入新更改时，部署 URL 保持不变，并实时反映所有更新。](images/automatic-ssl-with-vercel-and-let_s-encrypt-vercel/img_002.jpg)  
As you introduce new changes to the branch, the deployment URL doesn't change and reflects all the updates.

当您向分支引入新更改时，部署 URL 保持不变，并实时反映所有更新。

Once the branch is merged to the default branch and deployed, as outlined previously, we automatically alias to your chosen production domain name, and ensure you have valid certificates.

一旦该分支被合并至默认分支并完成部署（如前所述），我们将自动将其别名（alias）指向您指定的生产环境域名，并确保您拥有有效的证书。

### Under the hood

### 底层原理

To enable HTTPS on a website, we need a certificate from a trusted [Certificate Authority (CA)](https://en.wikipedia.org/wiki/Certificate_authority), and for that, all CAs require us to prove that we have control over our domain.

要为网站启用 HTTPS，我们需要从受信任的[证书颁发机构（Certificate Authority, CA）](https://en.wikipedia.org/wiki/Certificate_authority)获取证书；而所有 CA 均要求我们证明对该域名拥有控制权。

In the case of Let's Encrypt, the issuance communication takes place over ACME, a protocol introduced via [IETF RFC 8555](https://tools.ietf.org/html/rfc8555). ACME, which stands for _Automatic Certificate Management Environment_, allows for automated certificate issuance through a series of _challenges_ presented to the owner of the domain name. When you deploy with Vercel, **we communicate with Let's Encrypt on your behalf** through ACME.

以 Let’s Encrypt 为例，证书签发过程通过 ACME 协议完成——该协议由 [IETF RFC 8555](https://tools.ietf.org/html/rfc8555) 定义。ACME（全称：_Automatic Certificate Management Environment_，即“自动化证书管理环境”）通过向域名所有者发起一系列 _验证挑战（challenges）_，实现证书的自动化签发。当您使用 Vercel 进行部署时，**我们将代表您通过 ACME 协议与 Let’s Encrypt 进行通信**。

There are two main types of _challenges_ under ACME:

ACME 协议下主要有两类 _验证挑战（challenges）_：

- **HTTP challenges**: applicable to **common domains** (e.g `now.sh`)

- **HTTP 验证挑战**：适用于**普通域名**（例如 `now.sh`）

- **DNS challenges**: required for **wildcard domains** (e.g `*.now.sh`)

- **DNS 验证挑战**：适用于**通配符域名（wildcard domains）**（例如 `*.now.sh`）

When we request a certificate, Let's Encrypt first examines the domain and presents us with an appropriate challenge to solve.

当我们申请证书时，Let’s Encrypt 首先检查域名，并向我们提出一项适当的验证挑战以供完成。

In the typical **HTTP challenge**, we are asked to set up an arbitrary route on our domain, which contains a token specified by Let's Encrypt. For example, they may want to make a request at `http://<domain>/.well-known/acme-challenge/1234` and expect to find `2345` at that location.

在典型的 **HTTP 验证挑战** 中，我们需要在自己的域名下配置一个任意路径，该路径需包含 Let’s Encrypt 指定的一个令牌。例如，Let’s Encrypt 可能会向 `http://<domain>/.well-known/acme-challenge/1234` 发起请求，并期望在该路径下返回值 `2345`。

An illustration of the communication around an ACME HTTP challenge between Vercel and Let's Encrypt.

Vercel 与 Let’s Encrypt 之间围绕 ACME HTTP 验证挑战的通信示意图。

In a DNS challenge, Let's Encrypt asks us to create a DNS entry with a specific set of prescribed values.

在 DNS 验证挑战中，Let’s Encrypt 要求我们在 DNS 中创建一条具有特定预设值的记录。

For example, we could be asked to create a `TXT` record with the value `ABC`, such that on `dig TXT _acme-challenge.<domain>.com +short` they are able to access the matched value.

例如，我们可能被要求创建一条值为 `ABC` 的 `TXT` 记录，使得执行 `dig TXT _acme-challenge.<domain>.com +short` 命令时，Let’s Encrypt 能够查询并获取该匹配值。

An illustration of the communication around an ACME DNS challenge between Vercel and Let's Encrypt.

Vercel 与 Let’s Encrypt 之间围绕 ACME DNS 验证挑战的通信示意图。

Once issued, we immediately set up the certificate against your domain, and your website becomes HTTPS-ready.

证书一经签发，我们将立即将其部署至您的域名，您的网站随即具备 HTTPS 访问能力。

### Conclusion

### 总结

At Vercel, our mission is to make the cloud accessible to everyone. We are constantly observing and working with the developer workflow so we can locate unpleasant experiences and fix them.

在 Vercel，我们的使命是让云技术惠及每一个人。我们持续观察并深度参与开发者的工作流，以便及时发现令人困扰的体验并加以改进。

By making deployments HTTPS-ready automatically, we are able to free the modern developer to focus on their core applications and not on server set up.

通过自动将部署配置为 HTTPS 就绪，我们得以解放当代开发者，使其专注于核心应用开发，而非服务器配置等底层事务。

Our roadmap is informed by our incredible community of users. We look forward to learning from your experience deploying with Vercel.

我们的路线图由我们卓越的用户社区所驱动。我们期待从您使用 Vercel 进行部署的实践中汲取经验与洞见。

For any feedback, suggestions, or just to say hi, please reach out to us on [Twitter](https://twitter.com/vercel) or [Chat](https://github.com/vercel/vercel/discussions).

如您有任何反馈、建议，或只是想打个招呼，请通过 [Twitter](https://twitter.com/vercel) 或 [Chat](https://github.com/vercel/vercel/discussions) 与我们联系。
&#123;% endraw %}
