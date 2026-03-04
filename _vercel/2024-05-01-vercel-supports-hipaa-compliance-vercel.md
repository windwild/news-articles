---
title: "Vercel supports HIPAA compliance - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-supports-hipaa-compliance"
date: "2024-05-01"
scraped_at: "2026-03-02T09:45:15.844218864+00:00"
language: "en-zh"
translated: true
description: "Vercel now supports HIPAA compliance for our enterprise customers, enabling companies to leverage our Frontend Cloud while maintaining compliance"
---

render_with_liquid: false
May 1, 2024

2024 年 5 月 1 日

Vercel is committed to providing a [secure](https://vercel.com/security) and reliable platform for hosting websites and applications—across all industries. But this can be challenging with industry-specific regulations, especially for healthcare organizations and entities that process protected health information (PHI).

Vercel 致力于为所有行业的网站与应用程序提供一个[安全](https://vercel.com/security)、可靠的托管平台。然而，面对行业特定的监管要求（尤其是医疗健康组织及处理受保护健康信息（PHI）的相关机构），实现这一目标颇具挑战。

Today, we're excited to announce that Vercel supports compliance with the Health Insurance Portability and Accountability Act of 1996 (HIPAA) for our enterprise customers, enabling relevant companies to leverage our Frontend Cloud while maintaining compliance with industry-specific regulations.

今天，我们非常高兴地宣布：Vercel 已为我们的企业客户支持《1996 年健康保险可携性和责任法案》（HIPAA）合规性，使相关企业可在严格遵循行业监管要求的前提下，充分利用我们的前端云（Frontend Cloud）服务。

![](images/vercel-supports-hipaa-compliance-vercel/img_001.jpg)![](images/vercel-supports-hipaa-compliance-vercel/img_002.jpg)

## **What does this mean for our customers?**

## **这对我们的客户意味着什么？**

HIPAA promotes the use of electronic health records while safeguarding the security and privacy of PHI.

HIPAA 旨在推动电子健康记录（EHR）的应用，同时保障受保护健康信息（PHI）的安全性与隐私性。

Vercel is considered a business associate for our healthcare customers, including hospitals, medical services providers, research facilities, and insurance companies, who must comply with HIPAA as " [covered entities](https://www.hhs.gov/hipaa/for-professionals/covered-entities/index.html)." Being a business associate—an entity that provides services to covered entities—requires Vercel to comply with certain HIPAA obligations.

对于必须依据 HIPAA 作为“[承保实体](https://www.hhs.gov/hipaa/for-professionals/covered-entities/index.html)”（covered entities）履行合规义务的医疗健康客户（包括医院、医疗服务提供商、科研机构及保险公司），Vercel 被视为其“业务关联方”（business associate）。作为向承保实体提供服务的一方，“业务关联方”须履行特定的 HIPAA 合规义务，Vercel 亦不例外。

Based on a customer's configuration, Vercel’s records may contain healthcare information, which could include data relevant to PHI. Any additional data captured within the platform is at the discretion of Vercel’s customers. We do not manage or review this information. We help ensure that our customers' data is stored in their systems securely and is highly available for their use per our [Shared Responsibility Model](https://vercel.com/docs/security/shared-responsibility).

根据客户的配置，Vercel 的系统记录中可能包含医疗健康相关信息，其中或涉及与 PHI 相关的数据。平台内捕获的任何额外数据均由 Vercel 客户自主决定。我们既不管理也不审核此类信息。我们通过践行[共担责任模型](https://vercel.com/docs/security/shared-responsibility)，协助确保客户数据在其自有系统中得到安全存储，并具备高可用性，以满足其业务需求。

Another way Enterprise customers can ensure interactions with their digital presence are secure, resilient, and performant is through [Vercel Secure Compute](https://vercel.com/docs/security/secure-compute). Secure Compute adds an additional layer of security to applications by placing deployments and build containers in an isolated network with dedicated IP addresses in a region of their choice and logically separated from other containers.

企业客户还可借助[Vercel Secure Compute](https://vercel.com/docs/security/secure-compute)，进一步保障其数字资产交互过程的安全性、韧性与高性能。Secure Compute 通过将部署环境与构建容器置于客户自选区域内的隔离网络中（配备专属 IP 地址，且在逻辑层面与其他容器完全分离），为应用增添一层额外安全保障。

[**Get started**\\
\\
For more information about IP blocking or Secure Compute on Vercel Enterprise, or if you require support for VPC peering or VPN connections, please contact our sales team.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**立即开始**\\
\\
如需了解 Vercel 企业版中关于 IP 封禁或 Secure Compute 的更多信息，或需要 VPC 对等连接（VPC peering）或 VPN 连接支持，请联系我们的销售团队。\\
\\
联系我们](https://vercel.com/contact/sales)

Having an isolated network with dedicated IP addresses provides customers more control over which resources access their network. Additionally, enabling VPC peering (AWS only) and VPN support allows customers to establish secure tunnels within their AWS infrastructure, creating fewer entry points into their networks.

使用具备专用 IP 地址的隔离网络，使客户能够更精准地控制哪些资源可访问其网络。此外，启用 VPC 对等连接（仅限 AWS）和 VPN 支持，可帮助客户在其 AWS 基础设施内建立安全隧道，从而减少进入其网络的入口点。

### How did we do this?

### 我们是如何实现这一目标的？

We wanted to bring the same level of rigor to evaluating our compliance with HIPAA that we apply to our SOC 2 Type 2, PCI DSS, and ISO 27001 frameworks. To achieve this, we underwent an independent third-party audit to ensure that we support compliance with the HIPAA Security Rule and HITECH Breach Notification Requirements.

我们希望以与评估 SOC 2 Type 2、PCI DSS 和 ISO 27001 合规性同等严格的标准，来评估我们在 HIPAA 合规性方面的表现。为此，我们接受了独立第三方审计，以确保我们符合 HIPAA《安全规则》（Security Rule）及《HITECH 法案》关于数据泄露通知的要求（Breach Notification Requirements）。

Our evaluation involved several key steps to ensure the protection of health information:

为保障健康信息的安全，我们的评估工作包含以下关键步骤：

1. **Understand HIPAA requirements**: We familiarized ourselves with business associate requirements to understand our obligations to covered entities for protecting PHI.

1. **理解 HIPAA 要求**：我们深入学习了作为“业务伙伴”（Business Associate）的相关要求，以明确自身在保护受保护健康信息（PHI）方面对“覆盖实体”（Covered Entities）所承担的义务。

2. **Conduct a risk assessment**: We conducted a risk assessment to identify potential risks and vulnerabilities and understand if improvements were needed.

2. **开展风险评估**：我们实施了全面的风险评估，以识别潜在风险与安全漏洞，并判断是否需要进行改进。

3. **Implement administrative, physical, and technical safeguards**: We updated policies and procedures, including our incident response plan, with HIPAA-specific breach notification requirements. We also implemented HIPAA-specific training for staff and reviewed our encryption, access, and backup controls to ensure the availability and integrity of PHI if stored or transmitted by Vercel.

3. **落实行政、物理与技术保障措施**：我们更新了各项政策与流程（包括事件响应计划），纳入 HIPAA 特定的数据泄露通知要求；为员工提供了 HIPAA 专项培训；并全面审查了加密机制、访问控制及备份策略，以确保由 Vercel 存储或传输的 PHI 具备可用性与完整性。

4. **Signing business associate agreements (BAAs)**: We sign BAAs with enterprise customers who are covered entities under HIPAA to outline each party's responsibilities for protecting PHI.

4. **签署业务伙伴协议（BAAs）**：我们与符合 HIPAA 定义的“覆盖实体”的企业客户签署业务伙伴协议（BAAs），明确双方在保护 PHI 方面各自的责任。

5. **Conduct regular audits and monitoring**: We regularly audit and monitor our systems and processes to maintain ongoing compliance with HIPAA requirements, including reviewing access logs, conducting vulnerability scans, and performing risk assessments.

5. **开展定期审计与监控**：我们持续对系统与流程进行审计和监控，以维持对 HIPAA 各项要求的长期合规性，具体措施包括审查访问日志、执行漏洞扫描以及开展风险评估。

6. **Stay informed and up to date**: We regularly monitor updates to the Security Rule, HITECH Breach Notification Requirements, and standard industry practices to keep Vercel up to date and continue to support compliance with evolving requirements.

6. **保持信息同步与及时更新**：我们持续跟踪《安全规则》、《HITECH 法案》数据泄露通知要求以及行业通用最佳实践的最新动态，确保 Vercel 始终保持最新状态，并持续支持不断演进的合规性要求。

## Dedication to security and compliance

## 致力于安全与合规

Healthcare organizations can confidently host their websites and applications on Vercel, knowing that we support compliance with HIPAA. Our successful completion of an independent HIPAA audit underscores our commitment to protecting our customers' information.

医疗保健机构可放心地将网站和应用程序托管在 Vercel 上，因为我们支持符合《健康保险可携性和责任法案》（HIPAA）的要求。我们已成功通过独立的 HIPAA 合规性审计，这充分印证了我们保护客户信息的坚定承诺。

This achievement reaffirms our dedication to providing a secure and reliable platform for businesses across all industries, including healthcare. We look forward to helping healthcare organizations thrive in an increasingly digital world while ensuring the highest standards of data security and privacy.

这一成果再次彰显了我们致力于为包括医疗健康在内的各行各业企业提供安全、可靠平台的决心。我们期待助力医疗保健机构在日益数字化的世界中蓬勃发展，同时确保数据安全与隐私保护达到最高标准。

[**Take the next step**\\
\\
Reach out to an expert to learn more about security on Vercel for your Enterprise.\\
\\
Get in Touch](https://vercel.com/contact/sales)

[**迈出下一步**\\
\\
联系专家，深入了解 Vercel 企业版的安全能力。\\
\\
立即联系](https://vercel.com/contact/sales)