---
title: "Understanding CSRF attacks - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/understanding-csrf-attacks"
date: "2023-09-29"
scraped_at: "2026-03-02T09:50:19.909790629+00:00"
language: "en-zh"
translated: true
description: "Understand the mechanics and risks of Cross-Site Request Forgery (CSRF) attacks, and discover crucial development practices, like anti-CSRF tokens and appropriate use of HTTP methods, to fortify web a..."
---

render_with_liquid: false
Sep 29, 2023

2023年9月29日

Understand the mechanics and risks of Cross-Site Request Forgery (CSRF) attacks, and discover crucial development practices.

了解跨站请求伪造（CSRF）攻击的原理与风险，并掌握关键的开发实践。

Cross-Site Request Forgery (CSRF) is an attack that tricks users into executing unwanted actions on a web application where they're currently authenticated.

跨站请求伪造（CSRF）是一种攻击手段，诱使用户在当前已通过身份验证的 Web 应用程序中执行非自愿的操作。

Imagine you're logged into your online banking platform. In another tab, you click on a seemingly harmless link. The next thing you know, money has been transferred out of your account without your knowledge. Oh no, you've just fallen victim to a CSRF attack! But how could this happen?

假设您已登录网上银行平台。此时，在另一个浏览器标签页中，您点击了一个看似无害的链接。下一秒，您便发现账户资金已被转出，而您对此毫不知情。糟了！您刚刚成为了一次 CSRF 攻击的受害者！但这一切究竟是如何发生的呢？

CSRF attacks occur in a few steps:

CSRF 攻击通常包含以下几个步骤：

- **1\. The attacker identifies a target site** that is vulnerable to CSRF. Typically, this is a site where important actions occur through predictable URLs or requests.

- **1. 攻击者识别一个易受 CSRF 攻击的目标网站**。这类网站通常通过可预测的 URL 或请求来执行关键操作。

![](images/understanding-csrf-attacks-vercel/img_001.jpg)

![](images/understanding-csrf-attacks-vercel/img_001.jpg)

- **2\. The attacker creates a malicious request**. For this demo, let's assume our bank's website transfers money using a simple URL like **`bank.com/transfer?amount=1000&toAccount=attackerAccountId`**. The user - unaware of what is about to happen - just logged into the bank's website, which sets a session cookie.

- **2. 攻击者构造一条恶意请求**。在本示例中，假设我们的银行网站通过如下简单 URL 执行转账操作：**`bank.com/transfer?amount=1000&toAccount=attackerAccountId`**。用户在不知情的情况下刚登录了该银行网站，从而触发了会话 Cookie 的设置。

![](images/understanding-csrf-attacks-vercel/img_002.jpg)

![](images/understanding-csrf-attacks-vercel/img_002.jpg)

- **3\. The attacker needs to trick an authenticated user** into triggering this request. They can do this by asking the user to click a link, or by embedding the malicious URL in the source code of an image on a different site, like: **`<img src="bank.com/transfer?amount=100&to=AttackerAccount" />`**.

- **3. 攻击者需诱骗已通过身份验证的用户**触发该请求。实现方式包括诱导用户点击某个链接，或在其他网站的图片 HTML 源码中嵌入恶意 URL，例如：**`<img src="bank.com/transfer?amount=100&to=AttackerAccount" />`**。

![](images/understanding-csrf-attacks-vercel/img_003.jpg)

在该场景中，攻击者创建了一个网站，该网站会在页面加载时自动提交表单。用户只需访问该网站，此请求便会自动发出。

- **4. 攻击者可利用用户的 Cookie 和会话，向银行服务器发起合法请求**。资金随即在后台完成转账，通常用户对此毫不知情。

### **为什么 CSRF 如此严重？**

### **为何 CSRF 攻击如此危险？**

CSRF 攻击之所以危险，是因为它们：

- 利用已通过身份验证的会话，使恶意操作看似合法。

- 可在用户毫不知情的情况下执行。

- 通常几乎不留痕迹，因为难以区分哪些用户操作是合法的、哪些是被劫持的。

### Preventing CSRF attacks

### 防范 CSRF 攻击

作为开发者，我们可以采取以下若干措施来保护用户免受 CSRF 攻击。

**Anti-CSRF Tokens**

**反 CSRF 令牌**

Anti-CSRF tokens, often just called CSRF tokens, are a common and effective measure against CSRF attacks. They add an additional layer of security by requiring any state-changing request to include a token that the server will verify.

反 CSRF 令牌（通常简称为 CSRF 令牌）是一种常见且有效的抵御 CSRF 攻击的措施。它通过要求所有可能改变服务端状态的请求都携带一个服务器将予以验证的令牌，从而增加一层安全防护。

![The request is deemed legitimate if it includes a CSRF token that matches the token previously issued for that user's session by the server](images/understanding-csrf-attacks-vercel/img_004.jpg)  
该请求被视为合法，当且仅当其包含一个 CSRF 令牌，且该令牌与服务器此前为该用户会话所颁发的令牌完全匹配。

1. **Token Generation:** When a user logs into a website, the server generates a unique CSRF token for that user's session. This token is typically a random string that's hard to guess.

1. **令牌生成：** 当用户登录网站时，服务器为其当前会话生成一个唯一的 CSRF 令牌。该令牌通常是一个难以预测的随机字符串。

2. **Sending the Token:** The server sends this token to the client's browser. The browser might store this token in a hidden form field, a cookie, or in the site's local storage.

2. **发送令牌：** 服务器将该令牌发送至客户端浏览器。浏览器可能将其存储在隐藏表单字段、Cookie 或网站的本地存储（local storage）中。

3. **Making Requests:** Whenever the browser wants to make a request that can change data or state (like transferring money or updating an email address), it must include this CSRF token as part of the request.

3. **发起请求：** 每当浏览器需要发起可能修改数据或状态的请求（例如转账、更新邮箱地址等），都必须将此 CSRF 令牌作为请求的一部分一并提交。

4. **Server Verification:** When the server receives the request, it checks if the CSRF token in the request matches the token it has on record for that user's session. If the tokens don't match or if the token is missing, the server will reject the request.

4. **服务端验证：** 服务器接收到请求后，会检查其中所含 CSRF 令牌是否与该用户会话所记录的令牌一致。若两者不匹配，或请求中缺失该令牌，服务器将拒绝该请求。

5. **Short Lifespan:** These tokens often have a short lifespan to enhance security further. This means that even if an attacker manages to get hold of a token, they have a very limited window to carry out an attack; the token becomes useless afterward.

5. **短期有效：** 此类令牌通常具有较短的有效期，以进一步提升安全性。这意味着即使攻击者成功获取了某个令牌，其可用于发动攻击的时间窗口也极为有限；令牌过期后即失效。

Generate a unique token each time a user loads a form and embed it within the form. On the server side, verify this token upon form submission. Attackers cannot predict this token, making it challenging to craft valid malicious requests.

每次用户加载表单时均生成一个唯一令牌，并将其嵌入表单中；服务端在表单提交时对该令牌进行验证。由于攻击者无法预测该令牌，因此难以构造出有效的恶意请求。

### `SameSite` **Cookie Attribute**

### `SameSite` **Cookie 属性**

Modern browsers support the **`SameSite`** cookie attribute, which prevents cookies from being sent in cross-site requests. This attribute can be particularly effective against CSRF attacks. [Read more about the SameSite cookie attribute here](https://vercel.com/guides/understanding-the-samesite-attribute).

现代浏览器支持 **`SameSite`** Cookie 属性，该属性可防止 Cookie 在跨站请求中被发送。此属性对防范 CSRF 攻击尤为有效。[点击此处了解有关 SameSite Cookie 属性的更多信息](https://vercel.com/guides/understanding-the-samesite-attribute)。

### **Check** `Referer` **Headers**

### 检查 `Referer` 请求头

Servers can examine the **`Referer`** header of incoming requests to verify if they originate from trusted pages.

服务器可检查传入请求的 **`Referer`** 请求头，以验证其是否源自可信页面。

### **Avoid** `GET` **for State-Changing Operations**

### 避免在状态变更操作中使用 `GET` 请求

Reserve **`GET`** requests solely for data retrieval and avoid using them to modify the application's state. Instead, use **`POST`** requests for actions, as they provide an additional layer of security.

请仅将 **`GET`** 请求用于数据获取，避免用其修改应用程序状态。对于执行操作（如提交表单、触发业务逻辑等），应改用 **`POST`** 请求，因其提供了额外的安全保障。

1. `GET` is intended for fetching data. **`GET`** requests should be idempotent, meaning they don't cause any side effects, regardless of how many times they're made. When you access a website by typing a URL in the browser or click on a link, you're making a **`GET`** request.

1. `GET` 的设计初衷是获取数据。**`GET`** 请求应当是幂等的，即无论执行多少次，均不会产生任何副作用。当你在浏览器地址栏中输入 URL 或点击超链接访问网站时，发起的正是一个 **`GET`** 请求。

2. `POST` is used for submitting data to be processed to a specified resource. **`POST`**  
    requests can change the server's state, like creating a new account or making a purchase.

2. `POST` 用于向指定资源提交待处理的数据。**`POST`**  
    请求可能改变服务器状态，例如创建新账户或完成一笔购买。

**Reasons to Avoid Using** **`GET`** **for State-Changing Actions:**

**避免在状态变更操作中使用 `GET` 请求的原因：**

1. **Predictability:** If actions are performed using predictable **`GET`** URLs, an attacker can craft malicious links that, when clicked by a victim, trigger unwanted actions on the target site where the victim is authenticated.

1. **可预测性：** 若状态变更操作通过可预测的 **`GET`** URL 执行，攻击者便可构造恶意链接；当受害者点击该链接时，便会在其已通过身份验证的目标站点上触发非预期的操作。

2. **Easier to Trick Users:** It's easier to trick users into clicking on a link (a **`GET`** request) than to trick them into submitting a form (typically a **`POST`** request). For instance, an attacker could embed an image tag in a forum post with a source URL, triggering a harmful **`GET`** action.

2. **更容易诱骗用户：** 诱使用户点击一个链接（即发起一次 **`GET`** 请求）比诱使其提交表单（通常是 **`POST`** 请求）要容易得多。例如，攻击者可在论坛帖子中嵌入一个 `<img>` 标签，并将 `src` 属性设为恶意 URL，从而无意中触发有害的 **`GET`** 操作。

3. **Browser History:** **`GET`** requests and their parameters are stored in browser history. If these requests change the application's state, it means revisiting that URL from the history could unintentionally trigger the action again.

3. **浏览器历史记录：** **`GET`** 请求及其参数会被保存在浏览器历史中。如果此类请求会改变应用程序状态，则从历史记录中重新访问该 URL 可能会无意间再次触发该操作。

**Benefits of Using** **`POST`** **for State-Changing Actions:**

**使用** **`POST`** **执行状态变更操作的优势：**

1. **Protection from Accidental Clicks:** A user can't be tricked into making a **`POST`**  
    request just by clicking a link. They'd typically have to submit a form, which is a more intentional action.

1. **防范误点操作：** 用户仅通过点击链接无法被诱骗发起 **`POST`** 请求；通常必须主动提交表单，而这一行为更具明确意图。

2. **Using Anti-CSRF Tokens:** **`POST`** requests allow for embedding anti-CSRF tokens within the request (usually inside the form), adding an additional layer of security against CSRF attacks.

2. **使用反 CSRF Token：** **`POST`** 请求支持在请求中嵌入反 CSRF Token（通常置于表单内），从而为抵御 CSRF 攻击提供额外的安全防护层。

Reserving **`GET`** for data retrieval and using **`POST`** for actions isn't just good for security, but it also follows the principle of making web behaviors predictable and understandable. Adhering to the intended use of HTTP methods leads to both a better user experience _and_ improved security.

将 **`GET`** 专用于数据获取、将 **`POST`** 专用于执行操作，不仅有利于提升安全性，也符合“让 Web 行为可预测、易理解”的设计原则。严格遵循 HTTP 方法的语义约定，既能改善用户体验，又能增强系统安全性。