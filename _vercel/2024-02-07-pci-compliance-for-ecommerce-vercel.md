---
title: "PCI compliance for ecommerce - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/pci-compliance-for-ecommerce-teams"
date: "2024-02-07"
scraped_at: "2026-03-02T09:48:04.808550007+00:00"
language: "en-zh"
translated: true
description: "Leverage iframes for payment processing to enable PCI compliance and maintain secure transactions on Vercel."
---
{% raw %}

Feb 7, 2024

2024 年 2 月 7 日

了解如何利用 iframe 实现支付处理，以满足 PCI 合规要求并保障工作负载的高可用性。

At Vercel, we strive to provide the best support for ecommerce customers worldwide. As a part of this work, we want to ensure that we provide support for our customers to comply with the Payment Card Industry Data Security Standard (PCI-DSS).

在 Vercel，我们致力于为全球电商客户提供最佳支持。作为此项工作的组成部分，我们希望确保为客户的支付卡行业数据安全标准（PCI-DSS）合规工作提供充分支持。

In accordance with Vercel's [shared responsibility model](https://vercel.com/docs/security/shared-responsibility), this post will walk you through our recommended approach using an [iframe](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe) to process payments—creating a secure conduit between your end users and your payment provider.

根据 Vercel 的[共担责任模型](https://vercel.com/docs/security/shared-responsibility)，本文将为您详细介绍我们推荐的支付处理方案：使用[iframe](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/iframe) 在终端用户与您的支付服务提供商之间构建一条安全通道。

## Role of iframes in PCI compliance

## iframe 在 PCI 合规中的作用

In the context of your application on Vercel, an iframe serves a specific and vital purpose for payment processing and PCI compliance.

在您部署于 Vercel 的应用中，iframe 承担着支付处理与实现 PCI 合规的一项特定且至关重要的职责。

The **`<iframe>`** [HTML](https://developer.mozilla.org/en-US/docs/Web/HTML) element represents a nested [browsing context](https://developer.mozilla.org/en-US/docs/Glossary/Browsing_context), embedding another HTML page into the current one.

**`<iframe>`** [HTML](https://developer.mozilla.org/zh-CN/docs/Web/HTML) 元素表示一个嵌套的[浏览上下文](https://developer.mozilla.org/zh-CN/docs/Glossary/Browsing_context)，用于将另一个 HTML 页面嵌入当前页面中。

When your application integrates an iframe for payment processing, it effectively creates a secure conduit for payment transactions. The iframe is designed to host a payment form, directly provided and managed by your chosen [payment processor](https://www.pcisecuritystandards.org/glossary/payment-processor/).

当您的应用通过 iframe 集成支付功能时，即实质上为支付交易构建了一条安全通道。该 iframe 专门用于承载由您选定的[支付服务商](https://www.pcisecuritystandards.org/glossary/payment-processor/)直接提供并管理的支付表单。

![An example iframe payment flow](images/pci-compliance-for-ecommerce-vercel/img_001.jpg)![An example iframe payment flow](images/pci-compliance-for-ecommerce-vercel/img_002.jpg)An example iframe payment flow

![一个 iframe 支付流程示例](images/pci-compliance-for-ecommerce-vercel/img_001.jpg)![一个 iframe 支付流程示例](images/pci-compliance-for-ecommerce-vercel/img_002.jpg)一个 iframe 支付流程示例

This approach is emblematic of [Vercel’s shared responsibility model](https://vercel.com/docs/security/shared-responsibility), which states that Vercel serves as a service provider to customers who process payment and cardholder data, and ensures the following remain true:

这一方案正是 [Vercel 共担责任模型](https://vercel.com/docs/security/shared-responsibility) 的典型体现。该模型明确指出：Vercel 作为服务提供商，面向处理支付及持卡人数据的客户，确保以下各项持续成立：

### Data isolation

### 数据隔离

The payment card information entered by your application’s end users in the iframe is completely isolated from Vercel’s environment—at no point does the payment information touch or pass through your application’s managed infrastructure on Vercel.

在 iframe 中由您应用的终端用户输入的支付卡信息，与 Vercel 的运行环境完全隔离——该支付信息在任何环节均不会接触或流经您在 Vercel 上托管的应用基础设施。

### Direct data transmission

### 直接数据传输

Any information entered into the iframe is transmitted directly to your payment processor. This is because the iframe acts as a separate document with its own HTTP requests, independent of those made by the parent page. Ensuring that Vercel never processes, stores, or has access to your end users’ payment card data.

所有在 iframe 中输入的信息均直接传输至您的支付处理方。这是因为 iframe 作为一个独立文档，拥有自身独立的 HTTP 请求，与父页面发起的请求互不关联。由此确保 Vercel 既不会处理、存储，也无法访问您终端用户的支付卡数据。

### Reduced PCI DSS scope

### 缩小 PCI DSS 合规范围

By isolating payment data from your application, and ensuring that it is handled exclusively by the payment processor, the iframe method considerably narrows the scope of PCI DSS compliance that customers subject to PCI DSS need to manage. This simplifies compliance efforts, and enhances the overall security posture of your ecommerce solution.

通过将支付数据从您的应用中隔离，并确保其仅由支付处理方进行处理，iframe 方式可显著缩小受 PCI DSS 约束的客户所需管理的合规范围。这不仅简化了合规工作，也提升了您电商解决方案的整体安全水平。

## Implementing iframe payment solutions

## 实现 iframe 支付方案

**First, select a** [**payment service provider**](https://www.pcisecuritystandards.org/glossary/payment-processor/) **.** Select a provider that offers end-to-end encryption, data tokenization, built-in fraud detection, utilizes [3DS authentication protocol](https://listings.pcisecuritystandards.org/documents/FAQs_for_PCI_3DS_Core_Security_Standard.pdf), and most importantly, is compliant with the latest PCI DSS requirements.

**首先，选择一家** [**支付服务提供商（PSP）**](https://www.pcisecuritystandards.org/glossary/payment-processor/) **。** 请选用支持端到端加密（E2EE）、数据令牌化（tokenization）、内置欺诈检测功能、采用 [3DS 身份验证协议](https://listings.pcisecuritystandards.org/documents/FAQs_for_PCI_3DS_Core_Security_Standard.pdf) 的服务商；最重要的是，该服务商必须符合最新版 PCI DSS 合规要求。

**Begin the integration process.** Embedding the provider’s iframe into your application’s payment page is usually straightforward, and should require minimal code change. Below is some basic pseudo-code for a payment processor iframe.

**启动集成流程。** 将服务商提供的 iframe 嵌入您应用的支付页面通常十分简单，且所需代码改动极少。以下是一段支付处理方 iframe 的基础伪代码：

```javascript
export function PaymentIframe() {
```

2  return (

2  返回（

3    <iframe

3    `<iframe`

4      src="https://payment-processor.com/secure-payment-form"

4      src="https://payment-processor.com/secure-payment-form"

5      width="100%"

5      width="100%"

6      height="500px"

6      height="500px"

7      sandbox="allow-forms allow-top-navigation allow-same-origin"

7      sandbox="allow-forms allow-top-navigation allow-same-origin"

8    />

8    />`

9  );

9  );

10};

10}；

```

Included, you’ll notice the `sandbox` [attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe#sandbox) and with it values that are often required by the payment processor for functionality.

```

此处包含的代码中，您会注意到 `sandbox` [属性](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/iframe#sandbox)，及其取值——这些取值通常是支付处理器为保障功能正常运行所要求的。

- `allow-forms`: Enables form submissions in the iframe, essential for payment data entry.  
- `allow-forms`: 允许 iframe 内提交表单，对支付数据录入至关重要。

- `allow-top-navigation`: Allows the iframe to change the full page URL, useful for post-transaction redirections.  
- `allow-top-navigation`: 允许 iframe 更改整个页面的 URL，适用于交易完成后的重定向场景。

- `allow-same-origin`: Permits the iframe to interact with resources from the hosting page's origin, crucial for functionality but slightly reduces isolation.  
- `allow-same-origin`: 允许 iframe 与宿主页面同源的资源进行交互，对功能实现至关重要，但会略微削弱隔离性。

## Maintaining PCI compliance

## 维持 PCI 合规性

While the inclusion of the iframe is relatively trivial for your frontend, maintaining security and integrity, requires diligence, and often involves maintaining at least some level of PCI compliance. For any organization integrating a payments processor, the PCI Security Standards Council provides a guide to [Best Practices for Securing Ecommerce](https://docs-prv.pcisecuritystandards.org/Guidance%20Document/e-Commerce/best_practices_securing_ecommerce.pdf), which we recommend reading. To learn more about Vercel and PCI DSS compliance, please visit our [Security & Compliance Measures](https://vercel.com/docs/security#pci-dss).  
尽管在前端中嵌入 iframe 相对简单，但要确保安全性与完整性，仍需保持高度谨慎，且通常需至少满足一定程度的 PCI 合规要求。对于任何集成支付处理器的组织，PCI 安全标准委员会提供了《[电子商务安全最佳实践指南](https://docs-prv.pcisecuritystandards.org/Guidance%20Document/e-Commerce/best_practices_securing_ecommerce.pdf)》，我们强烈建议您阅读。如需进一步了解 Vercel 在 PCI DSS 合规方面的相关信息，请参阅我们的 [安全与合规措施](https://vercel.com/docs/security#pci-dss) 页面。
{% endraw %}
