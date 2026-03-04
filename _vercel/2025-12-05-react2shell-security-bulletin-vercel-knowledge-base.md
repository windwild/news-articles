---
title: "React2Shell Security Bulletin      | Vercel Knowledge Base"
source: "Vercel Blog"
url: "https://vercel.com/blog/resources-for-protecting-against-react2shell"
date: "2025-12-05"
scraped_at: "2026-03-02T09:24:24.574752701+00:00"
language: "en-us"
translated: true
description: "CVE-2025-55182 is a critical vulnerability in React, Next.js, and other frameworks that requires immediate action"
---
&#123;% raw %}

_2025 年 12 月 11 日更新：继 React2Shell 漏洞披露后，社区对 React Server Components 的深入研究又发现了两个需紧急修复的漏洞：CVE-2025-55184（拒绝服务，DoS）和 CVE-2025-55183（源代码泄露）。详情请参阅最新发布的_[_安全公告_](https://vercel.com/kb/bulletin/security-bulletin-cve-2025-55184-and-cve-2025-55183)_。_

2025 年 12 月 4 日，针对 React2Shell（一个影响 React 19 的严重漏洞，[CVE-2025-55182](https://www.cve.org/CVERecord?id=CVE-2025-55182)）及使用该技术的框架（如 Next.js，[CVE-2025-66478](https://github.com/vercel/next.js/security/advisories/GHSA-9qr9-h5gf-34mp)）的公开利用代码（exploits）开始出现。当前形势仍在持续演变中。我们建议您频繁查阅本页面以及 [Vercel 开发者 X 账号](https://x.com/vercel_dev)，以获取最新动态；同时，相关更新也将持续同步至 Vercel 控制台（Dashboard）。

### [需立即采取的措施](https://vercel.com/kb/bulletin/react2shell#required-action)

该漏洞影响 Next.js 版本 15.0.0 至 16.0.6。若您运行的是受影响版本，请立即升级，无论是否已部署其他防护措施。请跳转至 [如何升级并保护您的 Next.js 应用](https://vercel.com/kb/bulletin/react2shell#how-to-upgrade-and-protect-your-next.js-app) 指南，了解具体修补与防护方法。

### [最新动态](https://vercel.com/kb/bulletin/react2shell#updates)

| 日期 | 更新内容 |
| --- | --- |
| 12 月 8 日，美国太平洋时间晚上 8:31 | Vercel Agent 现可执行自动化代码审查，并自动发起 Pull Request 以升级存在风险的项目。详情请参阅 [使用 Vercel Agent 自动升级](https://vercel.com/kb/bulletin/react2shell#automated-upgrade-with-vercel-agent) 章节。 |
| 12 月 8 日，美国太平洋时间晚上 6:09 | 我们强烈建议为除生产环境域名外的所有部署启用“标准防护”（Standard Protection），并全面审计所有部署生成的可共享链接（shareable links）。操作说明请见公告中的 [Vercel 部署防护](https://vercel.com/kb/bulletin/react2shell#vercel-deployment-protection) 章节。 |
| 12 月 6 日，美国太平洋时间晚上 9:05 | 若您的应用在 2025 年 12 月 4 日下午 1:00（PT）仍处于在线且未打补丁状态，我们强烈建议您立即轮换（rotate）其使用的全部密钥（secrets），优先处理最关键的部分。有关密钥轮换的操作指南，请参阅我们的 [文档](https://vercel.com/docs/environment-variables/rotating-secrets)。 |
| 12 月 5 日，美国太平洋时间晚上 10:29 | Vercel 已发布一个 `npm` 包，用于更新受此漏洞影响的 Next.js 应用。请运行 `npx fix-react2shell-next`，或访问 [GitHub 页面](https://github.com/vercel-labs/fix-react2shell-next) 了解更多信息。 |
| 12 月 5 日，美国太平洋时间下午 3:44 | Vercel 已与 HackerOne 合作，就 Vercel 平台防护（Vercel Platform Protection）的关键绕过（workaround）开展负责任披露计划。仅针对本 CVE，凡能成功演示绕过 Vercel 防护机制的有效报告，均可获得奖励：高危（High）级别奖励 $25,000，严重（Critical）级别奖励 $50,000。欢迎访问 [HackerOne 页面](https://hackerone.com/vercel_platform_protection) 参与计划。 |

### [本公告涵盖内容：](https://vercel.com/kb/bulletin/react2shell#in-this-bulletin:)

- [何时应升级您的应用](https://vercel.com/kb/bulletin/react2shell#when-to-upgrade-your-application)
- [了解 React2Shell 是什么，以及它是否影响您](https://vercel.com/kb/bulletin/react2shell#understanding-react2shell)
- [如何升级并保护您的 Next.js 应用](https://vercel.com/kb/bulletin/react2shell#how-to-upgrade-and-protect-your-next.js-app)
  - [Vercel 安全操作控制台](https://vercel.com/kb/bulletin/react2shell#vercel-security-actions-dashboard)
  - [Vercel 部署防护](https://vercel.com/kb/bulletin/react2shell#vercel-deployment-protection)
  - [版本升级方式](https://vercel.com/kb/bulletin/react2shell#version-upgrade-methods)
  - [轮换环境变量](https://vercel.com/kb/bulletin/react2shell#rotating-environment-variables)
- [如何升级其他框架](https://vercel.com/kb/bulletin/react2shell#how-to-upgrade-other-frameworks)
- [常见问题解答（FAQ）](https://vercel.com/kb/bulletin/react2shell#faq)

## [何时应升级您的应用](https://vercel.com/kb/bulletin/react2shell#when-to-upgrade-your-application)

当出现以下任一情况时，您应立即升级：

- You're using Next.js 15.0.0 through 16.0.6: All Next.js applications running versions between 15.0.0 and 16.0.6 are affected by this vulnerability.  
- 您正在使用 Next.js 15.0.0 至 16.0.6 版本：所有运行在 15.0.0 至 16.0.6 版本区间内的 Next.js 应用均受此漏洞影响。

- You're using Next.js 14 canary versions: If you're using Next.js 14 canaries after 14.3.0-canary.76, you are also vulnerable and need to downgrade or upgrade.  
- 您正在使用 Next.js 14 的 Canary 版本：若您使用的是 14.3.0-canary.76 之后的 Next.js 14 Canary 版本，同样存在该漏洞风险，需降级或升级。

- You're using React Server Components in any framework: This vulnerability affects React Server Components broadly. If you use RSC through Next.js or another framework, you need to update.  
- 您在任意框架中使用了 React Server Components（RSC）：该漏洞广泛影响 React Server Components。无论您是通过 Next.js 还是其他框架使用 RSC，均需立即更新。

### [Recommendation](https://vercel.com/kb/bulletin/react2shell#recommendation)

### [建议措施](https://vercel.com/kb/bulletin/react2shell#recommendation)

For Next.js, upgrading to a [patched version](https://nextjs.org/blog/CVE-2025-66478) is strongly recommended and the only complete fix. All users of React Server Components, whether through Next.js or any other framework, should update immediately. Learn how to upgrade for [Next.js](https://vercel.com/kb/bulletin/react2shell#how-to-upgrade-for-next.js) and [other frameworks](https://vercel.com/kb/bulletin/react2shell#how-to-upgrade-for-other-frameworks).  
对于 Next.js 用户，强烈建议升级至[已修复版本](https://nextjs.org/blog/CVE-2025-66478)，这是唯一完整的修复方案。所有使用 React Server Components 的用户（无论是否通过 Next.js 或其他框架），均应立即更新。请查阅[Next.js 的升级指南](https://vercel.com/kb/bulletin/react2shell#how-to-upgrade-for-next.js)及[其他框架的升级指南](https://vercel.com/kb/bulletin/react2shell#how-to-upgrade-for-other-frameworks)。

## [Understanding React2Shell](https://vercel.com/kb/bulletin/react2shell#understanding-react2shell)

## [了解 React2Shell 漏洞](https://vercel.com/kb/bulletin/react2shell#understanding-react2shell)

React2Shell is a critical vulnerability in React Server Components that affects React 19 and frameworks that use it. Under certain conditions, specially crafted requests could lead to unintended remote code execution.  
React2Shell 是 React Server Components 中的一个严重漏洞，影响 React 19 及所有使用它的框架。在特定条件下，经恶意构造的请求可能导致非预期的远程代码执行（RCE）。

### [Checking your vulnerability status](https://vercel.com/kb/bulletin/react2shell#checking-your-vulnerability-status)

### [检查您的漏洞状态](https://vercel.com/kb/bulletin/react2shell#checking-your-vulnerability-status)

The most reliable way to determine if you're vulnerable is to check your deployed version of React and Next.js. You need to verify the versions of:  
判断您是否受影响最可靠的方式，是检查您已部署的 React 和 Next.js 版本。您需确认以下依赖项的版本：

- `next`  
- `react-server-dom-webpack`  
- `react-server-dom-parcel`  
- `react-server-dom-turbopack`  

If you're using Vercel, you will see a banner in the [vercel.com](http://vercel.com/) dashboard when your production deployment is using a vulnerable version of these packages.​ This banner is an additional indication to review your deployment.  
若您使用 Vercel，在生产环境部署中若使用了上述任一存在漏洞的包版本，您将在 [vercel.com](http://vercel.com/) 控制台看到提示横幅。该横幅是提醒您审查当前部署的额外信号。

Everyone should also check their versions directly. This can be done automatically by using `npx fix-react2shell-next` (see instructions in [this section](https://vercel.com/kb/bulletin/react2shell#automatic-fix) of the bulletin).  
所有用户也应直接核查自身依赖版本。您可通过运行 `npx fix-react2shell-next` 自动完成检查与修复（详见公告中[“自动修复”章节](https://vercel.com/kb/bulletin/react2shell#automatic-fix)的说明）。

### [Vercel WAF protection](https://vercel.com/kb/bulletin/react2shell#vercel-waf-protection)

### [Vercel WAF 防护](https://vercel.com/kb/bulletin/react2shell#vercel-waf-protection)

Vercel WAF rules provide an additional layer of defense by filtering known exploit patterns:

Vercel WAF 规则通过过滤已知的漏洞利用模式，提供额外的一层防御：

- [Prior to the CVE announcement](https://vercel.com/changelog/cve-2025-55182), Vercel worked with the React Team to design WAF rules to block exploitation and globally delivered protection to all Vercel users.

- 在 [CVE 公告发布之前](https://vercel.com/changelog/cve-2025-55182)，Vercel 已与 React 团队合作设计 WAF 规则，以阻断相关漏洞利用，并已向所有 Vercel 用户全局部署了防护措施。

- Ongoing monitoring for new exploit variants with iterative WAF rule updates (as of December 5, 2025, additional rules were deployed to cover newly identified attack patterns)

- 持续监控新型漏洞利用变种，并通过迭代更新 WAF 规则加以应对（截至 2025 年 12 月 5 日，已部署新增规则以覆盖新发现的攻击模式）。

WAF rules cannot guarantee protection against all possible variants of an attack.

WAF 规则无法保证对所有可能的攻击变种提供完全防护。

## [How to upgrade and protect your Next.js app](https://vercel.com/kb/bulletin/react2shell#how-to-upgrade-and-protect-your-next.js-app)

## [如何升级并保护您的 Next.js 应用](https://vercel.com/kb/bulletin/react2shell#how-to-upgrade-and-protect-your-next.js-app)

In this section:

本节内容包括：

- [Vercel security actions dashboard](https://vercel.com/kb/bulletin/react2shell#vercel-security-actions-dashboard)

- [Vercel 安全操作仪表板](https://vercel.com/kb/bulletin/react2shell#vercel-security-actions-dashboard)

- [Vercel deployment protection](https://vercel.com/kb/bulletin/react2shell#vercel-deployment-protection)

- [Vercel 部署防护](https://vercel.com/kb/bulletin/react2shell#vercel-deployment-protection)

- [Version upgrade methods](https://vercel.com/kb/bulletin/react2shell#version-upgrade-methods)

- [版本升级方法](https://vercel.com/kb/bulletin/react2shell#version-upgrade-methods)

  - [Automated upgrade with Vercel Agent](https://vercel.com/kb/bulletin/react2shell#automated-upgrade-with-vercel-agent)

  - [使用 Vercel Agent 自动升级](https://vercel.com/kb/bulletin/react2shell#automated-upgrade-with-vercel-agent)

  - [Upgrade with the command line utility](https://vercel.com/kb/bulletin/react2shell#upgrade-with-the-command-line-utility)

  - [使用命令行工具升级](https://vercel.com/kb/bulletin/react2shell#upgrade-with-the-command-line-utility)

  - [Manual upgrade](https://vercel.com/kb/bulletin/react2shell#manual-upgrade)

  - [手动升级](https://vercel.com/kb/bulletin/react2shell#manual-upgrade)

- [Rotating environment variables](https://vercel.com/kb/bulletin/react2shell#rotating-environment-variables)

- [轮换环境变量](https://vercel.com/kb/bulletin/react2shell#rotating-environment-variables)

### [Vercel security actions dashboard](https://vercel.com/kb/bulletin/react2shell#vercel-security-actions-dashboard)

### [Vercel 安全操作仪表板](https://vercel.com/kb/bulletin/react2shell#vercel-security-actions-dashboard)

Vercel provides a unified dashboard that surfaces any security issues requiring action from your team, including remediation steps. View [your security actions dashboard](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Ffixes&title=View+Security+Actions+Dashboard).

Vercel 提供统一的仪表板，集中呈现您团队需立即处理的所有安全问题，并附带相应的修复建议。请访问 [您的安全操作仪表板](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Ffixes&title=View+Security+Actions+Dashboard)。

### [Vercel deployment protection](https://vercel.com/kb/bulletin/react2shell#vercel-deployment-protection)

### [Vercel 部署防护](https://vercel.com/kb/bulletin/react2shell#vercel-deployment-protection)

Even if your production app has been patched, older versions could still be vulnerable. We strongly recommend turning on [Standard Protection](https://vercel.com/docs/deployment-protection#standard-protection) for all deployments besides your production domain.

即使您的生产环境应用已打补丁，旧版本仍可能存在安全漏洞。我们强烈建议为除生产域名外的所有部署启用[标准防护（Standard Protection）](https://vercel.com/docs/deployment-protection#standard-protection)。

You can see a list of projects without deployment protection in your [security actions dashboard](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Ffixes&title=View+Security+Actions+Dashboard) or by reviewing [your deployment protection settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%2F%5Bproject%5D%2Fsettings%2Fdeployment-protection&title=Update%20deployment%20protection).

您可在[安全操作仪表板（Security Actions Dashboard）](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Ffixes&title=View+Security+Actions+Dashboard)中查看未启用部署防护的项目列表，或通过查阅[您的部署防护设置（Deployment Protection Settings）](https://vercel.com/d?to=%2F%5Bteam%5D%2F%2F%5Bproject%5D%2Fsettings%2Fdeployment-protection&title=Update%20deployment%20protection)进行确认。

Make sure that preview deployments and deployments from other environments are not used by external users without protection bypass first (see the [documentation](https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection) for details).

请确保预览部署（preview deployments）及其他环境的部署，在未首先配置防护绕过机制（protection bypass）前，不被外部用户直接访问（详情请参阅[相关文档](https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection)）。

You should also audit [shareable links](https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection/sharable-links) from your deployments. If you have disabled deployment protection to share domains that point to preview or custom environment deployments, you should implement [deployment protection exceptions](https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection/deployment-protection-exceptions) and make sure that all deployments added to the exception list have been patched.

您还应审核来自各部署的[可共享链接（Shareable Links）](https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection/sharable-links)。若您曾为共享指向预览环境或自定义环境部署的域名而禁用了部署防护，请务必配置[部署防护例外规则（Deployment Protection Exceptions）](https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection/deployment-protection-exceptions)，并确保所有列入例外清单的部署均已打上安全补丁。

### [Version upgrade methods](https://vercel.com/kb/bulletin/react2shell\#version-upgrade-methods)

### [版本升级方法](https://vercel.com/kb/bulletin/react2shell\#version-upgrade-methods)

#### [Automated upgrade with Vercel Agent](https://vercel.com/kb/bulletin/react2shell\#automated-upgrade-with-vercel-agent)

#### [使用 Vercel Agent 自动升级](https://vercel.com/kb/bulletin/react2shell\#automated-upgrade-with-vercel-agent)

Vercel Agent can automatically detect vulnerable projects and open PRs that upgrade your code to patched versions.

Vercel Agent 可自动识别存在漏洞的项目，并发起 Pull Request（PR），将您的代码升级至已修复的版本。

View vulnerable projects and initiate upgrades [in the Vercel dashboard](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Ffixes&title=Fix+Vulnerable+Projects).

请在[Vercel 仪表板](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Ffixes&title=Fix+Vulnerable+Projects)中查看存在漏洞的项目并启动升级流程。

#### [Upgrade with the command line utility](https://vercel.com/kb/bulletin/react2shell\#upgrade-with-the-command-line-utility)

#### [使用命令行工具升级](https://vercel.com/kb/bulletin/react2shell\#upgrade-with-the-command-line-utility)

You can quickly update your Next.js project to the right version by using the `fix-react2shell-next` npm package by running the following command in the root of your application:

您可通过在应用根目录下运行以下命令，借助 `fix-react2shell-next` npm 包，快速将 Next.js 项目升级至正确的修复版本：

terminal

终端

```bash
npx fix-react2shell-next
```

```bash
npx fix-react2shell-next
```

Once tested, deploy your updated application as soon as possible. See the [deployment guide](https://vercel.com/kb/bulletin/react2shell#deployment-guide) for instructions.

测试完成后，请尽快部署您更新后的应用。具体操作步骤请参阅[部署指南](https://vercel.com/kb/bulletin/react2shell#deployment-guide)。

#### [Manual upgrade](https://vercel.com/kb/bulletin/react2shell\#manual-upgrade)

#### [手动升级](https://vercel.com/kb/bulletin/react2shell\#manual-upgrade)

1\. Identify your current version

1. 确认当前版本

Load a page from your app and run `next.version` in the browser console to see the current version or check your `package.json` to find your current Next.js version:

在您的应用中加载任意一个页面，然后在浏览器控制台中运行 `next.version` 查看当前版本；或者检查 `package.json` 文件以确认您当前使用的 Next.js 版本：

package.json

`package.json`

```json
{

  "dependencies": {

    "next": "15.3.4"
```

```
}

}
```

2\. Update to the patched version

2. 更新至已修复版本

Based on the following list, identify which patched release you need to upgrade to:

根据以下列表，确定您需要升级到的已修复版本：

| Vulnerable version | Patched release |
| --- | --- |
| Next.js 15.0.x | 15.0.5 |
| Next.js 15.1.x | 15.1.9 |
| Next.js 15.2.x | 15.2.6 |
| Next.js 15.3.x | 15.3.6 |
| Next.js 15.4.x | 15.4.8 |
| Next.js 15.5.x | 15.5.7 |
| Next.js 16.0.x | 16.0.10 |
| Next.js 14 canaries after 14.3.0-canary.76 | Downgrade to 14.3.0-canary.76 (not vulnerable) |
| Next.js 15 canaries before 15.6.0-canary.58 | 15.6.0-canary.58 |
| Next.js 16 canaries before 16.1.0-canary.12 | 16.1.0-canary.12 and after |

| 易受攻击的版本 | 已修复版本 |
| --- | --- |
| Next.js 15.0.x | 15.0.5 |
| Next.js 15.1.x | 15.1.9 |
| Next.js 15.2.x | 15.2.6 |
| Next.js 15.3.x | 15.3.6 |
| Next.js 15.4.x | 15.4.8 |
| Next.js 15.5.x | 15.5.7 |
| Next.js 16.0.x | 16.0.10 |
| Next.js 14 的 Canary 版本（发布于 14.3.0-canary.76 之后） | 降级至 14.3.0-canary.76（不受此漏洞影响） |
| Next.js 15 的 Canary 版本（发布于 15.6.0-canary.58 之前） | 15.6.0-canary.58 |
| Next.js 16 的 Canary 版本（发布于 16.1.0-canary.12 之前） | 16.1.0-canary.12 及后续版本 |

These patched versions include the hardened React Server Components implementation.

这些已修复版本包含了加固后的 React Server Components 实现。

If you're currently using canary releases to enable PPR, you can update to 15.6.0-canary.58, which includes a fix for the vulnerability while continuing to support PPR. For other ways to patch older versions, see this [discussion post.](https://github.com/vercel/next.js/discussions/86813)

如果您当前正使用 Canary 版本来启用 PPR（Partial Prerendering），可升级至 15.6.0-canary.58 —— 该版本在继续支持 PPR 的同时修复了该安全漏洞。如需了解修复旧版本的其他方法，请参阅此 [讨论帖](https://github.com/vercel/next.js/discussions/86813)。

Update your `package.json`:

更新您的 `package.json` 文件：

package.json

`package.json`

```json
{

```json
"dependencies": {
  "next": "15.3.6"
}
```

```json
"dependencies": {
  "next": "15.3.6"
}
```

3 . Install dependencies and update lockfile

3 . 安装依赖项并更新锁文件

_Always commit lockfile changes with together with_ `package.json` _changes._

_请始终将锁文件（lockfile）的更改与_ `package.json` _的更改一并提交。_

Run your package manager's install command:

运行包管理器的安装命令：

terminal

terminal

```bash
# npm

npm install
```

```bash
# npm

npm install
```

# yarn

# yarn

yarn install

yarn install

# pnpm

# pnpm

pnpm install

pnpm install

# bun

# bun

bun install

bun install

```

4. Deploy immediately

4. 立即部署

Once tested, deploy your updated application as soon as possible. See the [deployment guide](https://vercel.com/kb/bulletin/react2shell#deployment-guide) for instructions.

测试完成后，请尽快部署您更新后的应用。具体操作步骤请参阅[部署指南](https://vercel.com/kb/bulletin/react2shell#deployment-guide)。

#### [Deployment guide](https://vercel.com/kb/bulletin/react2shell#deployment-guide)

#### [部署指南](https://vercel.com/kb/bulletin/react2shell#deployment-guide)

Once tested, deploy your updated application as soon as possible.

测试完成后，请尽快部署您更新后的应用。

If you're deploying to Vercel, the platform already blocks new deployments of vulnerable versions and has WAF rules in place, but upgrading remains critical.

如果您将应用部署到 Vercel，该平台已自动阻止对存在漏洞版本的新部署，并已启用 Web 应用防火墙（WAF）规则；但升级仍至关重要。

If you deploy via Git, pushing your changes will trigger a preview build with the patched version, and merging will promote that build to production. You can also create a Manual Deployment from the Vercel Dashboard to publish the fix immediately.

如果您通过 Git 部署，推送代码更改将触发一次预览构建（使用已修复的版本），而合并操作则会将该构建提升至生产环境。您也可以在 Vercel 控制台中创建一次手动部署（Manual Deployment），立即发布修复。

If you are using the Vercel CLI, deploy with:

如果您正在使用 Vercel CLI，请执行以下命令进行部署：

terminal

```bash
vercel --prod
```

### [Rotating environment variables](https://vercel.com/kb/bulletin/react2shell\#rotating-environment-variables)

### [轮换环境变量](https://vercel.com/kb/bulletin/react2shell\#rotating-environment-variables)

Assume your vulnerable systems are potentially compromised. Once you have patched your framework version and re-deployed your application, we recommend rotating all your application secrets. Learn [how to rotate the environment variables](https://vercel.com/docs/environment-variables/rotating-secrets) for your Vercel team and projects.

请假设您的存在漏洞的系统可能已被入侵。在完成框架版本修复并重新部署应用后，我们建议您轮换所有应用密钥（secrets）。了解如何为您的 Vercel 团队及项目[轮换环境变量](https://vercel.com/docs/environment-variables/rotating-secrets)。

## [How to upgrade other frameworks](https://vercel.com/kb/bulletin/react2shell\#how-to-upgrade-other-frameworks)

## [如何升级其他框架](https://vercel.com/kb/bulletin/react2shell\#how-to-upgrade-other-frameworks)

If you use another framework that implements React Server Components, consult the [React Security Advisory](https://react.dev/blog/2025/12/03/critical-security-vulnerability-in-react-server-components) posted on the [react.dev blog](https://react.dev/blog). If you are running a vulnerable version of the affected software, you should update to a patched version immediately.

如果您使用的其他框架实现了 React Server Components，请参阅 [react.dev 博客](https://react.dev/blog) 上发布的 [React 安全公告](https://react.dev/blog/2025/12/03/critical-security-vulnerability-in-react-server-components)。若您正在运行受影响软件的易受攻击版本，请立即升级至已修复的版本。

## [Next steps](https://vercel.com/kb/bulletin/react2shell\#next-steps)

## [后续步骤](https://vercel.com/kb/bulletin/react2shell\#next-steps)

- Review the [official Next.js security advisory](https://github.com/vercel/next.js/security/advisories)  
- 查阅 [Next.js 官方安全公告](https://github.com/vercel/next.js/security/advisories)

- For additional questions, contact us at [security@vercel.com](mailto:security@vercel.com).  
- 如有其他疑问，请通过 [security@vercel.com](mailto:security@vercel.com) 与我们联系。

## [Frequently asked questions](https://vercel.com/kb/bulletin/react2shell#faq)  
## [常见问题解答（FAQ）](https://vercel.com/kb/bulletin/react2shell#faq)

### What’s the easiest way to upgrade to a patched version?[Direct link to this question](https://vercel.com/kb/bulletin/react2shell#what-s-the-easiest-way-to-upgrade-to-a-patched-version)  
### 升级到已修复版本的最简单方法是什么？[跳转至该问题](https://vercel.com/kb/bulletin/react2shell#what-s-the-easiest-way-to-upgrade-to-a-patched-version)

We’ve released an `npm` package to scan for vulnerable packages and upgrade them. You can read the full details on the [package page](https://www.npmjs.com/package/fix-react2shell-next). Here’s an example run:  
我们已发布一个 `npm` 包，用于扫描并升级存在漏洞的依赖包。完整说明请参阅 [该包的 npm 页面](https://www.npmjs.com/package/fix-react2shell-next)。以下为一次执行示例：

![terminal-light.png](images/react2shell-security-bulletin-vercel-knowledge-base/img_001.jpg)![terminal-light.png](images/react2shell-security-bulletin-vercel-knowledge-base/img_002.jpg)  
![terminal-light.png](images/react2shell-security-bulletin-vercel-knowledge-base/img_001.jpg)![terminal-light.png](images/react2shell-security-bulletin-vercel-knowledge-base/img_002.jpg)

### How do I know if I’m vulnerable to this CVE?[Direct link to this question](https://vercel.com/kb/bulletin/react2shell#how-do-i-know-if-i-m-vulnerable-to-this-cve)  
### 我如何判断自己是否受此 CVE 影响？[跳转至该问题](https://vercel.com/kb/bulletin/react2shell#how-do-i-know-if-i-m-vulnerable-to-this-cve)

The most definitive way to understand your exposure is to check the version of React/Next that you have deployed against the CVE. See the [Checking your vulnerability status](https://vercel.com/kb/bulletin/react2shell#checking-your-vulnerability-status) above for information on how to check this.  
最准确的评估方式是将您已部署的 React/Next 版本与该 CVE 的影响范围进行比对。有关具体检查方法，请参阅上方的 [检查您的漏洞状态](https://vercel.com/kb/bulletin/react2shell#checking-your-vulnerability-status)。

We have enabled a banner on the [vercel.com](http://vercel.com/) dashboard for our customers that informs you if the production deployment of a project contains a vulnerable version of `next`, `react-server-dom-webpack`, `react-server-dom-parcel`, or `react-server-dom-turbopack`.  
我们已在 [vercel.com](http://vercel.com/) 控制台为用户启用了提示横幅，当某项目的生产环境部署中包含存在漏洞的 `next`、`react-server-dom-webpack`、`react-server-dom-parcel` 或 `react-server-dom-turbopack` 版本时，该横幅将向您发出提醒。

Please consider this an extra layer of defense and not a replacement for checking if you are running vulnerable versions directly.  
请将此横幅视为额外的一层防护机制，而非直接检查自身是否运行了易受攻击版本的替代方案。

### How do I know if my app was exploited by CVE-2025-66478?[Direct link to this question](https://vercel.com/kb/bulletin/react2shell#how-do-i-know-if-my-app-was-exploited-by-cve-2025-66478)  
### 我如何判断自己的应用是否已被 CVE-2025-66478 利用？[跳转至该问题](https://vercel.com/kb/bulletin/react2shell#how-do-i-know-if-my-app-was-exploited-by-cve-2025-66478)

You cannot definitely tell but we recommend reviewing your application logs and activity for unexpected behavior. This could include unusual POST requests or spikes in function timeouts. However, function timeouts do not reliably indicate compromise because attackers can craft payloads that complete successfully, and timeouts could simply indicate scanning or probing activity rather than successful exploitation.

您无法完全确定，但我们建议您审查应用程序日志和活动，以排查异常行为。这可能包括异常的 POST 请求或函数超时次数激增。然而，函数超时并不能可靠地表明系统已被入侵，因为攻击者可以构造能够成功执行的有效载荷；而超时现象也可能仅反映扫描或探测行为，而非实际的成功利用。

Vercel deployed WAF mitigations prior to the CVE announcement. As new exploit variants have emerged, we have identified and patched bypasses to our WAF rules. WAF rules are one layer of defense but can never guarantee 100% coverage. Upgrading to a patched version remains the only way to fully secure your application.

Vercel 在 CVE 公告发布前即已部署了 Web 应用防火墙（WAF）缓解措施。随着新型漏洞利用变体的出现，我们已识别并修复了针对 WAF 规则的绕过手段。WAF 规则是防御体系中的一环，但永远无法保证 100% 的覆盖防护。升级至已修复版本，仍是全面保障应用安全的唯一途径。

### What are the protections available to me?[Direct link to this question](https://vercel.com/kb/bulletin/react2shell\#what-are-the-protections-available-to-me)

### 我可获得哪些防护措施？[直接跳转至该问题](https://vercel.com/kb/bulletin/react2shell\#what-are-the-protections-available-to-me)

Upgrading to a patched version is the only complete fix. Vercel WAF rules provide an additional layer of defense by filtering known exploit patterns, but WAF rules cannot guarantee protection against all possible variants of an attack.

升级至已修复版本是唯一彻底的解决方案。Vercel 的 WAF 规则通过过滤已知的漏洞利用模式，提供额外一层防御，但 WAF 规则无法确保抵御所有可能的攻击变体。

You can ensure other deployments besides your production domain are protected by reviewing [your deployment protection settings](https://vercel.com/docs/deployment-protection#understanding-deployment-protection-by-environment).

您可通过查阅[您的部署保护设置](https://vercel.com/docs/deployment-protection#understanding-deployment-protection-by-environment)，确保除生产环境域名外的其他部署也受到保护。

We are closely monitoring for new exploit variants and iterating on our WAF rules as new information emerges. As of this morning, December 5, we’ve deployed additional rules to cover newly identified attack patterns. Our team will continue to add further layers of protections and share updates as they become available.

我们正密切监控新型漏洞利用变体，并随新情报的出现持续优化 WAF 规则。截至今日（12 月 5 日）上午，我们已部署额外规则，以覆盖最新识别出的攻击模式。我们的团队将持续增加更多防护层级，并在更新可用时及时同步相关信息。

### What if I am using canary-only features in Next.js?[Direct link to this question](https://vercel.com/kb/bulletin/react2shell\#what-if-i-am-using-canary-only-features-in-next-js)

### 如果我在 Next.js 中使用了仅限 Canary 版本的功能，该怎么办？[直接跳转至该问题](https://vercel.com/kb/bulletin/react2shell\#what-if-i-am-using-canary-only-features-in-next-js)

If you are currently using canary-only features in Next.js you should still prioritize updating to a patched version. See the [Required Action section](https://nextjs.org/blog/CVE-2025-66478#required-action) of the [Next.js Security Advisory](https://nextjs.org/blog/CVE-2025-66478) for instructions on how to update to a patched Next.js version without having to disable canary-only features.

若您当前正在 Next.js 中使用仅限 Canary 版本的功能，仍应优先升级至已修复版本。请参阅 [Next.js 安全公告](https://nextjs.org/blog/CVE-2025-66478) 中的[“必要操作”章节](https://nextjs.org/blog/CVE-2025-66478#required-action)，了解如何在不关闭 Canary 功能的前提下，将 Next.js 升级至已修复版本。

### How can I test that the mitigations are working? Should I be using publicly available POCs to test if my application is secure?[Direct link to this question](https://vercel.com/kb/bulletin/react2shell\#how-can-i-test-that-the-mitigations-are-working-should-i-be-using-publicly-available-poc-s-to-test-if-my-application-is-secure)

### 如何验证缓解措施是否生效？我是否应使用公开的 PoC（概念验证）代码来测试我的应用是否安全？[直接跳转至该问题](https://vercel.com/kb/bulletin/react2shell\#how-can-i-test-that-the-mitigations-are-working-should-i-be-using-publicly-available-poc-s-to-test-if-my-application-is-secure)

We caution against using publicly available exploits against your production environment. Instead, we recommend following the above procedures to ensure all public deployments are using the latest versions of React Server Components and Next.js.

我们强烈提醒：切勿在您的生产环境中运行任何公开的漏洞利用代码（exploits）。相反，我们建议您遵循上述流程，确保所有面向公众的部署均使用最新版本的 React Server Components 和 Next.js。

If you have a complex deployment that requires additional verification, we recommend testing in a sandboxed environment with synthetic data to avoid unintended consequences on your production services and data.

如果您拥有一个需要额外验证的复杂部署，我们建议在沙盒环境中使用合成数据进行测试，以避免对您的生产服务和数据造成意外影响。

### Are v0 applications vulnerable?[Direct link to this question](https://vercel.com/kb/bulletin/react2shell\#are-v0-applications-vulnerable)

### v0 应用是否存在漏洞？[直接跳转至该问题](https://vercel.com/kb/bulletin/react2shell\#are-v0-applications-vulnerable)

Vercel is rolling out patches to existing v0 chats automatically over the next few days. However, you should patch affected v0 apps immediately rather than wait for the automatic update.

Vercel 将在未来几天内自动为现有的 v0 聊天应用推送补丁。但您应立即手动修复受影响的 v0 应用，而不应等待自动更新。

To patch a [v0 app](https://v0.app/) manually:

要手动修复一个 [v0 应用](https://v0.app/)：

1. Open the deploy dialogue for your affected v0 chat  
   打开您受影响的 v0 聊天应用的部署对话框  
2. Click the "Fix with v0" button  
   点击“使用 v0 修复”按钮  

Note that v0 apps that are not published are unaffected by React2Shell.

请注意，未发布的 v0 应用不受 React2Shell 影响。
&#123;% endraw %}
