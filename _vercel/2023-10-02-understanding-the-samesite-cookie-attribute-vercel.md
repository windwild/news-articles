---
title: "Understanding the SameSite cookie attribute - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/understanding-the-samesite-cookie-attribute"
date: "2023-10-02"
scraped_at: "2026-03-02T09:50:38.127601830+00:00"
language: "en-zh"
translated: true
description: "Explore the SameSite cookie attribute's significance in ensuring web security and user privacy to strike the right balance between security and usability."
---

render_with_liquid: false
Oct 2, 2023

2023年10月2日

Explore the SameSite cookie attribute's significance in ensuring web security and user privacy to strike the right balance between security and usability.

探索 `SameSite` Cookie 属性在保障网络安全与用户隐私方面的重要意义，以在安全性与可用性之间取得恰当平衡。

Navigating the web safely while ensuring user privacy is a top priority. When working with cookies, it’s important to ensure they are secure and serve their intended purpose without compromising user privacy.

安全地浏览网页并保障用户隐私是首要任务。在使用 Cookie 时，必须确保其安全性，并切实履行其设计用途，同时不损害用户隐私。

One key attribute to consider is **`SameSite`**, which dictates when and how cookies are sent in cross-site requests.

一个关键的属性是 **`SameSite`**，它决定了 Cookie 在跨站请求中何时以及如何被发送。

## **What Are Cookies?**

## **什么是 Cookie？**

[Cookies](https://vercel.com/guides/understanding-cookies) are small data pieces that web browsers save on user devices when websites ask them to. They help websites remember things about users, like their preferences or what's in their shopping cart.

[Cookies（Cookie）](https://vercel.com/guides/understanding-cookies) 是网站请求浏览器保存在用户设备上的小型数据片段。它们帮助网站记住有关用户的信息，例如用户的偏好设置或购物车中的商品。

However, with growing concerns about unwanted data sharing and potential security risks, there's a need to control when and where these cookies are used. That's where the **`SameSite`** attribute steps in, allowing developers to specify when a cookie is sent based on where the request comes from. This attribute can be set to **`Strict`**, **`Lax`**, or **`None`** to fit various needs.

然而，随着人们对非预期数据共享及潜在安全风险的日益关注，有必要对 Cookie 的使用时机和场景加以管控。此时，**`SameSite`** 属性便应运而生——它允许开发者根据请求来源指定 Cookie 的发送时机。该属性可设为 **`Strict`**、**`Lax`** 或 **`None`**，以满足不同应用场景的需求。

### **`Strict`**

### **`Strict`（严格模式）**

When a cookie's **`SameSite`** attribute is set to **`Strict`**, it means the cookie will be sent only if the request originates from the same site.

当 Cookie 的 **`SameSite`** 属性被设为 **`Strict`** 时，表示该 Cookie 仅在请求源自同一站点时才会被发送。

![](images/understanding-the-samesite-cookie-attribute-vercel/img_001.jpg)

**Use Cases:**

**使用场景：**

- Ideal for high-security applications like online banking.

- 适用于在线银行等高安全性应用场景。

- Prevents any cross-site usage, ensuring high levels of data confidentiality.

- 可防止任何跨站使用，从而确保高度的数据机密性。


### `Lax`

### `Lax`

The **`Lax`** setting strikes a balance between usability and security. With this setting, the cookie:

**`Lax`** 设置在可用性与安全性之间取得平衡。启用该设置后，Cookie 将：

- **Won't be sent on cross-site subresource requests**, such as images, stylesheets, and scripts.

- **不会随跨站子资源请求（例如图片、样式表和脚本）一同发送。**

- **Will be sent for top-level navigations**, like when a user clicks on a link leading to the site.

- **会在顶层导航（例如用户点击链接跳转至该站点）时发送。**


![](images/understanding-the-samesite-cookie-attribute-vercel/img_002.jpg)

![](images/understanding-the-samesite-cookie-attribute-vercel/img_002.jpg)

**Use Cases:**

**使用场景：**

- Useful for content embedded on other sites where some degree of cross-site interaction is okay.

- 适用于嵌入在其他网站中的内容，且允许一定程度的跨站交互。

- Enhances the browsing experience by maintaining sessions even when users arrive from an external link.

- 通过在用户从外部链接访问时仍保持会话，提升浏览体验。

If the **`SameSite`** attribute isn't set, browsers will treat the cookie as if it were set to `Lax`.

如果未设置 **`SameSite`** 属性，浏览器将把该 Cookie 视为设置了 `Lax`。

### `None`

### `None`

For the cookie to be sent with every request, including cross-site ones, the **`SameSite`** attribute should be set to **`None`**.

若希望 Cookie 在所有请求（包括跨站请求）中均被发送，则需将 **`SameSite`** 属性设为 **`None`**。

However, when using **`SameSite=None`**, the cookie must also be marked as **`Secure`**, meaning it can only be transported over HTTPS. If you attempt to set a cookie with **`SameSite=None`** without the **`Secure`** attribute on an HTTPS site, the browser will likely show a warning in the console, and the cookie won't function as intended!

但使用 **`SameSite=None`** 时，Cookie 还必须标记为 **`Secure`**，即仅可通过 HTTPS 传输。若您尝试在 HTTPS 站点上设置一个未带 **`Secure`** 属性的 **`SameSite=None`** Cookie，浏览器很可能会在控制台中显示警告，且该 Cookie 将无法按预期工作！

![](images/understanding-the-samesite-cookie-attribute-vercel/img_003.jpg)

![](images/understanding-the-samesite-cookie-attribute-vercel/img_003.jpg)

**Use Cases:**

**适用场景：**

- Cross-site tracking, often used by advertising platforms.

- 跨站追踪，常用于广告平台。

- Single Sign-On systems that require authentication across various domains.

- 需要在多个域名间实现身份认证的单点登录（SSO）系统。

- Functionalities intended for direct use by external websites.

- 专为外部网站直接调用而设计的功能。

Deciding which configuration to use depends on your specific use case.

选择使用哪种配置取决于您的具体应用场景。

- **Want top-notch security?** Go with **`Strict`**. This guarantees the cookie is only ever sent to its origin, minimizing the risk of CSRF attacks or unintentional leaks.

- **追求最高级别的安全性？** 请选择 **`Strict`**。该模式确保 Cookie 仅发送至其原始来源，从而最大限度地降低 CSRF 攻击或意外泄露的风险。

- **Want a mix of user-friendliness and safety?** Go with **`Lax`**. This ensures a smoother user experience while still offering protection against potential threats.

- **希望兼顾用户体验与安全性？** 请选择 **`Lax`**。该模式在保障用户操作流畅性的同时，仍能有效防范潜在安全威胁。

- **Need to share cookie data across sites?** Go with **`None`**. Just remember to also set it to **`Secure`**.

- **需要在多个网站间共享 Cookie 数据？** 请选择 **`None`**。但请务必同时将其设置为 **`Secure`**。

## **Conclusion**

## **总结**

The **`SameSite`** attribute offers web developers granular control over cookies, enhancing web security and ensuring a better user experience. By understanding the nuances of **`Strict`**, **`Lax`**, and **`None`**, you can make more informed decisions, keeping users both happy and secure.

**`SameSite`** 属性为 Web 开发者提供了对 Cookie 的精细化控制能力，既提升了 Web 安全性，又保障了更优质的用户体验。深入理解 **`Strict`**、**`Lax`** 和 **`None`** 各自的特性与适用场景，有助于您做出更明智的决策，让用户既满意又安全。