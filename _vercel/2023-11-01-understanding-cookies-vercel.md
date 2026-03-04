---
render_with_liquid: false
title: "Understanding cookies - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/understanding-cookies"
date: "2023-11-01"
scraped_at: "2026-03-02T09:50:05.467376564+00:00"
language: "en-zh"
translated: true
description: "Learn how cookies function, how they are used by websites, and the importance of managing them for privacy and security."
---
render_with_liquid: false
render_with_liquid: false

Nov 1, 2023

2023 年 11 月 1 日

Learn how cookies function, how they are used by websites, and the importance of managing them for privacy and security.

了解 Cookie 的工作原理、网站如何使用 Cookie，以及为保障隐私与安全而对其进行管理的重要性。

Cookies are small pieces of data stored by web browsers on a user's device at the request of web servers. They are sent back unchanged by the browser each time it accesses that server. Cookies allow the server to "remember" specific user information, facilitating functionalities like **maintaining user sessions**, **remembering preferences**, and **tracking user behavior**.

Cookie 是由 Web 浏览器根据 Web 服务器的请求，在用户设备上存储的小段数据。每当浏览器再次访问该服务器时，便会原样将其发送回服务器。Cookie 使服务器能够“记住”特定的用户信息，从而支持诸如 **维持用户会话**、**保存用户偏好设置** 和 **追踪用户行为** 等功能。

### **How Do Cookies Work?**

### **Cookie 是如何工作的？**

Cookies are set by a combination of both the server and browser.

Cookie 由服务器与浏览器协同设置。

![](images/understanding-cookies-vercel/img_001.jpg)

1. First, when the user visits a website, the server can send a **`Set-Cookie`** header in its response. "This instructs the browser to save the cookie on the user's device.

1. 首先，当用户访问某个网站时，服务器可在其响应中发送一个 **`Set-Cookie`** 响应头，指示浏览器将该 Cookie 保存至用户设备上。

2. Once a cookie is stored, the browser includes it as the **`Cookie`** header for subsequent requests to the same domain or path. This behavior is configurable through attributes such as **`SameSite`**, **`HttpOnly`**, and **`Secure.`**

2. Cookie 一旦被存储，浏览器会在后续向同一域名或路径发起的请求中，将其作为 **`Cookie`** 请求头一并发送。该行为可通过 **`SameSite`**、**`HttpOnly`** 和 **`Secure`** 等属性进行配置。

3. Cookies have an expiration time set using the **`Expires`** or **`Max-Age`** attributes. After this time, the cookie is automatically deleted. If neither is set, the cookie is treated as a session cookie and is deleted when the browser is closed.

3. Cookie 的过期时间通过 **`Expires`** 或 **`Max-Age`** 属性设定；超过该时间后，Cookie 将被自动删除。若两者均未设置，则该 Cookie 被视为会话 Cookie（session cookie），将在浏览器关闭时被清除。

The `Set-Cookie` response header consists of a few elements that determine how the browser will treat the cookie. It consists of:

`Set-Cookie` 响应头包含若干元素，用以决定浏览器将如何处理该 Cookie。其组成包括：

![](images/understanding-cookies-vercel/img_002.jpg)

![](images/understanding-cookies-vercel/img_002.jpg)

- **Name** and **Value**: The actual data in the cookie. They form a pair like **`name=value`**.

- **名称（Name）** 和 **值（Value）**：Cookie 中的实际数据，以 **`name=value`** 的键值对形式存在。

- `Domain` and `Path`: Define the scope of the cookie. The cookie will be sent only to requests made to the given domain and path.

- `Domain`（域名）和 `Path`（路径）：定义 Cookie 的作用范围。该 Cookie 仅会在向指定域名及路径发起请求时被发送。

- `Expires` and `Max-Age`: Specify when the cookie will expire. **`Expires`** sets an exact date and time, while **`Max-Age`** sets a duration.

- `Expires`（过期时间）和 `Max-Age`（最大存活时长）：指定 Cookie 的失效时间。**`Expires`** 设置一个确切的日期与时间，而 **`Max-Age`** 则设置一段相对时长（单位为秒）。

- `Secure`: Indicates that the cookie should be sent only over HTTPS.

- `Secure`（安全标志）：表示该 Cookie 仅可通过 HTTPS 协议传输。

- `HttpOnly`: Ensures client-side scripts cannot access the cookie. By ensuring cookies aren't accessible via JavaScript, you reduce the risk of them being stolen should an attacker manage to inject malicious scripts into your website (XSS).

- `HttpOnly`（仅 HTTP 访问）：确保客户端脚本（如 JavaScript）无法访问该 Cookie。通过禁止 JavaScript 访问 Cookie，可显著降低因网站遭受跨站脚本攻击（XSS）而导致 Cookie 被窃取的风险。

- `SameSite`: This attribute is crucial for cookie security and defines when the cookie should be sent to the server. It can be set to either Strict, Lax or None. [This guide](https://vercel.com/guides/understanding-the-samesite-attribute) discusses the different configurations and their implications.

- `SameSite`（同站策略）：该属性对 Cookie 安全至关重要，用于定义 Cookie 在何种情况下会被发送至服务器。其值可设为 `Strict`、`Lax` 或 `None`。[本指南](https://vercel.com/guides/understanding-the-samesite-attribute) 详细阐述了不同配置及其安全影响。

When working with cookies, it's essential to prioritize security. It’s good practice to:

在处理 Cookie 时，务必以安全性为首要考量。良好的实践包括：

1. Use the **`Secure`** **and** **`HttpOnly`** attributes wherever applicable to enhance security.

1. 在适用场景下始终启用 **`Secure`** 和 **`HttpOnly`** 属性，以增强安全性。

2. Set the **`SameSite`** attribute appropriately can help mitigate CSRF attacks.

2. 合理配置 **`SameSite`** 属性，有助于防范跨站请求伪造（CSRF）攻击。

3. **Limit Lifespan**: Set cookies to expire as soon as they're no longer needed by setting the right `max-age` or `expires` values.

3. **限制有效期**：通过设置恰当的 `max-age` 或 `expires` 值，使 Cookie 在不再需要时立即过期。

4. **Avoid Sensitive Data**: Never store sensitive data like passwords or personal identification numbers directly in cookies.

4. **避免存储敏感数据**：切勿直接在 Cookie 中存储密码或个人身份号码等敏感信息。

Inspecting and debugging cookies is important in complex applications where security is crucial. Browsers usually provide a streamlined way to do this, such as Google Chrome's Developer Tools.

在安全至关重要的复杂应用中，检查与调试 Cookie 至关重要。浏览器通常为此提供便捷的内置工具，例如 Google Chrome 的开发者工具（Developer Tools）。

To access Google Chrome's Developer Tools, press F12 or right-click and select "Inspect," then go to the "Application" tab. In the left-hand sidebar, you will find an expandable "Cookies" section under "Storage," which lists all the domains associated with the cookies stored in your current session.

要打开 Google Chrome 的开发者工具，请按 `F12` 键，或右键单击页面并选择“检查”（Inspect），然后切换到“Application”（应用程序）选项卡。在左侧边栏中，您可在“Storage”（存储）下找到可展开的“Cookies”（Cookie）部分，其中列出了当前会话中所有已存储 Cookie 所关联的域名。

By clicking on a domain, you can view all the cookies set by that domain in a table format. Each row provides detailed information such as the cookie's name, value, domain, path, expiration date, and security attributes like `Secure`, `HttpOnly`, and `SameSite`.

点击某个域名，即可以表格形式查看该域名所设置的所有 Cookie。每一行均提供详细信息，包括 Cookie 的名称、值、所属域名、路径、过期时间，以及 `Secure`、`HttpOnly` 和 `SameSite` 等安全属性。

![](images/understanding-cookies-vercel/img_003.jpg)

![](images/understanding-cookies-vercel/img_003.jpg)

This interface provides real-time updates, allowing you to monitor cookies as they are created, modified, or deleted while interacting with the web application. This makes it easier to troubleshoot issues such as incorrect cookie settings, session persistence problems, or any unexpected behavior related to cookie-based authentication. You can even manipulate cookie values or attributes directly within the Developer Tools, enabling you to simulate different scenarios and conduct thorough cookie testing and debugging.

该界面支持实时更新，让您能在与 Web 应用交互过程中，即时监控 Cookie 的创建、修改与删除行为。这有助于快速排查诸如 Cookie 配置错误、会话持久性异常，或基于 Cookie 的身份认证出现的任何意外行为等问题。您甚至可以直接在开发者工具中修改 Cookie 的值或属性，从而模拟不同场景，开展全面的 Cookie 测试与调试工作。