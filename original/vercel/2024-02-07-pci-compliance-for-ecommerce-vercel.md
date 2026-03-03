---
title: "PCI compliance for ecommerce - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/pci-compliance-for-ecommerce-teams"
date: "2024-02-07"
scraped_at: "2026-03-02T09:48:04.808550007+00:00"
language: "en"
translated: false
description: "Leverage iframes for payment processing to enable PCI compliance and maintain secure transactions on Vercel."
---




Feb 7, 2024

Learn how to leverage iframes for payment processing to enable PCI compliance and maintain resilient workloads.

At Vercel, we strive to provide the best support for ecommerce customers worldwide. As a part of this work, we want to ensure that we provide support for our customers to comply with the Payment Card Industry Data Security Standard (PCI-DSS).

In accordance with Vercel's [shared responsibility model](https://vercel.com/docs/security/shared-responsibility), this post will walk you through our recommended approach using an [iframe](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe) to process payments—creating a secure conduit between your end users and your payment provider.

## Role of iframes in PCI compliance

In the context of your application on Vercel, an iframe serves a specific and vital purpose for payment processing and PCI compliance.

The **`<iframe>`** [HTML](https://developer.mozilla.org/en-US/docs/Web/HTML) element represents a nested [browsing context](https://developer.mozilla.org/en-US/docs/Glossary/Browsing_context), embedding another HTML page into the current one.

When your application integrates an iframe for payment processing, it effectively creates a secure conduit for payment transactions. The iframe is designed to host a payment form, directly provided and managed by your chosen [payment processor](https://www.pcisecuritystandards.org/glossary/payment-processor/).

![An example iframe payment flow](images/pci-compliance-for-ecommerce-vercel/img_001.jpg)![An example iframe payment flow](images/pci-compliance-for-ecommerce-vercel/img_002.jpg)An example iframe payment flow

This approach is emblematic of [Vercel’s shared responsibility model](https://vercel.com/docs/security/shared-responsibility), which states that Vercel serves as a service provider to customers who process payment and cardholder data, and ensures the following remain true:

### Data isolation

The payment card information entered by your application’s end users in the iframe is completely isolated from Vercel’s environment—at no point does the payment information touch or pass through your application’s managed infrastructure on Vercel.

### Direct data transmission

Any information entered into the iframe is transmitted directly to your payment processor. This is because the iframe acts as a separate document with its own HTTP requests, independent of those made by the parent page. Ensuring that Vercel never processes, stores, or has access to your end users’ payment card data.

### Reduced PCI DSS scope

By isolating payment data from your application, and ensuring that it is handled exclusively by the payment processor, the iframe method considerably narrows the scope of PCI DSS compliance that customers subject to PCI DSS need to manage. This simplifies compliance efforts, and enhances the overall security posture of your ecommerce solution.

## Implementing iframe payment solutions

**First, select a** [**payment service provider**](https://www.pcisecuritystandards.org/glossary/payment-processor/) **.** Select a provider that offers end-to-end encryption, data tokenization, built-in fraud detection, utilizes [3DS authentication protocol](https://listings.pcisecuritystandards.org/documents/FAQs_for_PCI_3DS_Core_Security_Standard.pdf), and most importantly, is compliant with the latest PCI DSS requirements.

**Begin the integration process.** Embedding the provider’s iframe into your application’s payment page is usually straightforward, and should require minimal code change. Below is some basic pseudo-code for a payment processor iframe.

```javascript
export function PaymentIframe() {

2  return (

3    <iframe

4      src="https://payment-processor.com/secure-payment-form"

5      width="100%"

6      height="500px"

7      sandbox="allow-forms allow-top-navigation allow-same-origin"

8    />

9  );

10};
```

Included, you’ll notice the `sandbox` [attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe#sandbox) and with it values that are often required by the payment processor for functionality.

- `allow-forms`: Enables form submissions in the iframe, essential for payment data entry.

- `allow-top-navigation`: Allows the iframe to change the full page URL, useful for post-transaction redirections.

- `allow-same-origin`: Permits the iframe to interact with resources from the hosting page's origin, crucial for functionality but slightly reduces isolation.


## Maintaining PCI compliance

While the inclusion of the iframe is relatively trivial for your frontend, maintaining security and integrity, requires diligence, and often involves maintaining at least some level of PCI compliance. For any organization integrating a payments processor, the PCI Security Standards Council provides a guide to [Best Practices for Securing Ecommerce](https://docs-prv.pcisecuritystandards.org/Guidance%20Document/e-Commerce/best_practices_securing_ecommerce.pdf), which we recommend reading. To learn more about Vercel and PCI DSS compliance, please visit our [Security & Compliance Measures](https://vercel.com/docs/security#pci-dss).