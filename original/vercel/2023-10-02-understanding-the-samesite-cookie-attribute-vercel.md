---
title: "Understanding the SameSite cookie attribute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/understanding-the-samesite-cookie-attribute"
date: "2023-10-02"
scraped_at: "2026-03-02T09:50:38.127601830+00:00"
language: "en"
translated: false
description: "Explore the SameSite cookie attribute's significance in ensuring web security and user privacy to strike the right balance between security and usability."
---




Oct 2, 2023

Explore the SameSite cookie attribute's significance in ensuring web security and user privacy to strike the right balance between security and usability.

Navigating the web safely while ensuring user privacy is a top priority. When working with cookies, it’s important to ensure they are secure and serve their intended purpose without compromising user privacy.

One key attribute to consider is **`SameSite`**, which dictates when and how cookies are sent in cross-site requests.

## **What Are Cookies?**

[Cookies](https://vercel.com/guides/understanding-cookies) are small data pieces that web browsers save on user devices when websites ask them to. They help websites remember things about users, like their preferences or what's in their shopping cart.

However, with growing concerns about unwanted data sharing and potential security risks, there's a need to control when and where these cookies are used. That's where the **`SameSite`** attribute steps in, allowing developers to specify when a cookie is sent based on where the request comes from. This attribute can be set to **`Strict`**, **`Lax`**, or **`None`** to fit various needs.

### **`Strict`**

When a cookie's **`SameSite`** attribute is set to **`Strict`**, it means the cookie will be sent only if the request originates from the same site.

![](images/understanding-the-samesite-cookie-attribute-vercel/img_001.jpg)

**Use Cases:**

- Ideal for high-security applications like online banking.

- Prevents any cross-site usage, ensuring high levels of data confidentiality.


### `Lax`

The **`Lax`** setting strikes a balance between usability and security. With this setting, the cookie:

- **Won't be sent on cross-site subresource requests**, such as images, stylesheets, and scripts.

- **Will be sent for top-level navigations**, like when a user clicks on a link leading to the site.


![](images/understanding-the-samesite-cookie-attribute-vercel/img_002.jpg)

**Use Cases:**

- Useful for content embedded on other sites where some degree of cross-site interaction is okay.

- Enhances the browsing experience by maintaining sessions even when users arrive from an external link.


If the **`SameSite`** attribute isn't set, browsers will treat the cookie as if it were set to `Lax`.

### `None`

For the cookie to be sent with every request, including cross-site ones, the **`SameSite`** attribute should be set to **`None`**.

However, when using **`SameSite=None`**, the cookie must also be marked as **`Secure`**, meaning it can only be transported over HTTPS. If you attempt to set a cookie with **`SameSite=None`** without the **`Secure`** attribute on an HTTPS site, the browser will likely show a warning in the console, and the cookie won't function as intended!

![](images/understanding-the-samesite-cookie-attribute-vercel/img_003.jpg)

**Use Cases:**

- Cross-site tracking, often used by advertising platforms.

- Single Sign-On systems that require authentication across various domains.

- Functionalities intended for direct use by external websites.


Deciding which configuration to use depends on your specific use case.

- **Want top-notch security?** Go with **`Strict`**. This guarantees the cookie is only ever sent to its origin, minimizing the risk of CSRF attacks or unintentional leaks.

- **Want a mix of user-friendliness and safety?** Go with **`Lax`**. This ensures a smoother user experience while still offering protection against potential threats.

- **Need to share cookie data across sites?** Go with **`None`**. Just remember to also set it to **`Secure`**.


## **Conclusion**

The **`SameSite`** attribute offers web developers granular control over cookies, enhancing web security and ensuring a better user experience. By understanding the nuances of **`Strict`**, **`Lax`**, and **`None`**, you can make more informed decisions, keeping users both happy and secure.