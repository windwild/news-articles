---
title: "React Server Components security update: DoS and Source Code Exposure - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/react-server-components-security-update-dos-and-source-code-exposure"
date: "2025-12-11"
scraped_at: "2026-03-02T09:24:15.924757194+00:00"
language: "en-zh"
translated: true
description: "Two additional vulnerabilities in React Server Components have been identified: CVE-2025-55184 and CVE-2025-55183"
---

Dec 11, 2025

2025 年 12 月 11 日

> _请参阅_ [_安全公告_](https://vercel.com/kb/bulletin/security-bulletin-cve-2025-55184-and-cve-2025-55183) _获取最新更新。_

> _请参阅_ [_安全公告_](https://vercel.com/kb/bulletin/security-bulletin-cve-2025-55184-and-cve-2025-55183) _以获取最新更新。_

## **Summary**

## **摘要**

Two additional vulnerabilities in React Server Components have been identified: a high-severity Denial of Service ( [CVE-2025-55184](https://www.cve.org/CVERecord?id=CVE-2025-55184)) and a medium-severity Source Code Exposure ( [CVE-2025-55183](https://www.cve.org/CVERecord?id=CVE-2025-55183)). These issues were discovered while security researchers examined the patches for the original React2Shell vulnerability. The initial fix was incomplete and did not fully prevent denial-of-service attacks for all payload types, resulting in [CVE-2025-67779](https://www.cve.org/CVERecord?id=CVE-2025-67779).

已发现 React Server Components 中存在两个新漏洞：一个为高危级别的拒绝服务（DoS）漏洞（[CVE-2025-55184](https://www.cve.org/CVERecord?id=CVE-2025-55184)），另一个为中危级别的源代码泄露漏洞（[CVE-2025-55183](https://www.cve.org/CVERecord?id=CVE-2025-55183)）。这些漏洞是在安全研究人员审查原始 React2Shell 漏洞修复补丁时发现的。初始修复方案不完整，未能全面阻止所有类型载荷引发的拒绝服务攻击，从而导致了 [CVE-2025-67779](https://www.cve.org/CVERecord?id=CVE-2025-67779)。

**Importantly, none of these new issues allow for Remote Code Execution.**

**重要提示：上述任一新漏洞均无法实现远程代码执行（Remote Code Execution）。**

We created new rules to address these vulnerabilities and deployed them to the Vercel WAF to automatically protect all projects hosted on Vercel at no cost. However, do not rely on the WAF for full protection. Immediate upgrades to a patched version are required.

我们已制定新的防护规则以应对上述漏洞，并将其部署至 Vercel Web 应用防火墙（WAF），从而免费、自动地保护所有托管在 Vercel 上的项目。但请注意：切勿完全依赖 WAF 提供全面防护；您必须立即升级至已修复的版本。

## **Impact**

## **影响范围**

### ) **Denial of Service (** [**CVE-2025-55184**](https://www.cve.org/CVERecord?id=CVE-2025-55184) **)**

### ) **拒绝服务（**[**CVE-2025-55184**](https://www.cve.org/CVERecord?id=CVE-2025-55184)**）**

A malicious HTTP request can be crafted and sent to any App Router endpoint that, when deserialized, can cause the server process to hang and consume CPU.

攻击者可构造恶意 HTTP 请求并发送至任意 App Router 端点；该请求在反序列化过程中可能导致服务器进程挂起并持续占用 CPU 资源。

### ) **Source Code Exposure (** [**CVE-2025-55183**](https://www.cve.org/CVERecord?id=CVE-2025-55183) **)**

### ) **源代码泄露（**[**CVE-2025-55183**](https://www.cve.org/CVERecord?id=CVE-2025-55183)**）**

A malicious HTTP request can be crafted and sent to any App Router endpoint that can return the compiled source code of Server Actions. This could reveal business logic, but would not expose secrets unless they were hardcoded directly into Server Action's code.

攻击者可构造并发送恶意 HTTP 请求至任意能够返回 Server Action 编译后源代码的 App Router 端点。这可能导致业务逻辑泄露，但除非密钥被直接硬编码在 Server Action 的代码中，否则不会导致敏感信息（如密钥）泄露。

These vulnerabilities are present in versions `19.0.0`, `19.0.1`, `19.1.0`, `19.1.1`, `19.1.2`, `19.2.0`, and `19.2.1` of the following packages:

以下软件包的 `19.0.0`、`19.0.1`、`19.1.0`、`19.1.1`、`19.1.2`、`19.2.0` 和 `19.2.1` 版本存在上述漏洞：

- `react-server-dom-parcel`

- `react-server-dom-webpack`

- `react-server-dom-turbopack`


These packages are included in the following frameworks and bundlers:

这些软件包被集成于以下框架和打包工具中：

- **Next.js**: `13.x`, `14.x`, `15.x`, and `16.x`.

- **Next.js**：`13.x`、`14.x`、`15.x` 和 `16.x` 版本。

- Other frameworks and plugins that embed or depend on React Server Components implementation (e.g., Vite, Parcel, React Router, RedwoodSDK, Waku)

- 其他嵌入或依赖 React Server Components 实现的框架与插件（例如：Vite、Parcel、React Router、RedwoodSDK、Waku）


## **Resolution**

## **修复方案**

After creating mitigations to address these vulnerabilities, we deployed them across our globally-distributed platform to protect our customers. We still recommend upgrading to the latest patched version.

我们在制定缓解措施后，已将其部署至全球分布式平台，以保障客户安全。我们仍强烈建议升级至最新已修复版本。

Updated releases of React and affected downstream frameworks include fixes to prevent these issues. All users should upgrade to a patched version as soon as possible.

React 和受影响的下游框架的最新版本已包含修复措施，以防止上述问题。所有用户应尽快升级至已修复的版本。

## **Fixed in**

## **已修复版本**

- **React:** `19.0.2`, `19.1.3`, `19.2.2`.

- **Next.js:** `14.2.35`, `15.0.7`, `15.1.11`, `15.2.8`, `15.3.8`, `15.4.10`, `15.5.9`, `15.6.0-canary.60`, `16.0.10`, `16.1.0-canary.19`.

Frameworks and bundlers using the aforementioned packages should install the latest versions provided by their respective maintainers.

使用上述软件包的框架和构建工具（bundlers）应安装其各自维护者发布的最新版本。

## **Credit**

## **致谢**

Thanks to [RyotaK](https://ryotak.net/) from GMO Flatt Security Inc. and [Andrew MacPherson](https://github.com/AndrewMohawk) for identifying and responsibly reporting these vulnerabilities, and the Meta Security and React teams for their partnership.

感谢 GMO Flatt Security Inc. 的 [RyotaK](https://ryotak.net/) 以及 [Andrew MacPherson](https://github.com/AndrewMohawk)，他们发现并负责任地报告了这些漏洞；同时感谢 Meta 安全团队与 React 团队的通力合作。

## **References**

## **参考链接**

- [Next.js Security Update: December 11, 2025](https://nextjs.org/blog/security-update-2025-12-11)

- [React Blog: Denial of Service and Source Code Exposure in React Server Components](https://react.dev/blog/2025/12/11/denial-of-service-and-source-code-exposure-in-react-server-components)

- [React security advisory (CVE-2025-55183)](https://www.cve.org/CVERecord?id=CVE-2025-55183)

- [React 安全公告（CVE-2025-55183）](https://www.cve.org/CVERecord?id=CVE-2025-55183)

- [React security advisory (CVE-2025-55184)](https://www.cve.org/CVERecord?id=CVE-2025-55184)

- [React 安全公告（CVE-2025-55184）](https://www.cve.org/CVERecord?id=CVE-2025-55184)