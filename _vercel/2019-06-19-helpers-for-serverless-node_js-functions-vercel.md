---
title: "Helpers for Serverless Node.js Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-node-helpers"
date: "2019-06-19"
scraped_at: "2026-03-02T10:07:52.481186080+00:00"
language: "en-zh"
translated: true
description: "Introducing six default methods to the request and response payloads in your Node.js Serverless Functions."
---
{% raw %}

Jun 19, 2019

2019 年 6 月 19 日

迁移到无服务器 Node.js 函数，或从零开始创建新的无服务器函数，可能意味着您此前使用的一些工具和框架已不再适用。

借助本次功能更新，我们希望通过向您的 Node.js 函数中提供一组默认的 **内置辅助方法（helpers）** 来解决这一问题。

## What's New

## 新增功能

Vercel 上无服务器 Node.js 函数的最新更新，为 `request` 和 `response` 对象新增了六个默认方法：

- `request.query`

- `request.cookies`

- `request.body`

- `response.status()`

- `response.json()`

- `response.send()`  

- `response.send()`

In order to access any of these methods, **no changes are required on your side.**  

为了使用这些方法中的任意一个，**您无需进行任何修改。**

### Performance  

### 性能  

With the introduction of helpers, your application receives a **gain in performance** when compared to a basic [Express.js](https://expressjs.com/) application:  

随着辅助工具（helpers）的引入，您的应用相较于基础的 [Express.js](https://expressjs.com/) 应用可获得**性能提升**：

**NOTE:** The benchmarks above are used to showcase the performance difference between serverless Node.js functions on Vercel and the [Express.js](https://expressjs.com/) framework.  

**注意：** 上述基准测试旨在展示 Vercel 上的无服务器 Node.js 函数与 [Express.js](https://expressjs.com/) 框架之间的性能差异。

While the relative improvement will stay the same, the actual time taken will vary depending on your system configuration.  

尽管相对提升幅度保持不变，但实际耗时将因您的系统配置而异。

## How to Use Helpers  

## 如何使用辅助工具（Helpers）

These are the properties and methods that are available on the `request` and `response` arguments that your serverless function receives:  

以下是您的无服务器函数所接收的 `request` 和 `response` 参数上可用的属性与方法：

### `request.query`  

### `request.query`

**Before this update**, the easiest way to parse the GET parameters of an incoming GET request was to retrieve the `request.url` property and then pass the value to a parser.  

**在此更新之前**，解析传入的 GET 请求中查询参数（GET parameters）最简便的方式是获取 `request.url` 属性，再将该值传递给一个解析器。

With `request.query`, however, you have direct access to all the GET parameters, without having to parse them on your own:

然而，借助 `request.query`，您可以直接访问所有 GET 参数，而无需自行解析：

```javascript
module.exports = (request, response) => {

2  console.log(request.query);

3};
```

```javascript
module.exports = (request, response) => {

2  console.log(request.query);

3};
```

For example, if your endpoint's URL is `/endpoint?key=value`, the content of `request.query` would look like this:

例如，如果您的端点 URL 是 `/endpoint?key=value`，那么 `request.query` 的内容将如下所示：

```javascript
1{ "key": "value" }
```

```javascript
1{ "key": "value" }
```

### `request.cookies`

### `request.cookies`

In order to access the cookies supplied by an incoming request, you **previously** had to retrieve the `Set-Cookie` [header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie) from the request and then parse it manually.

过去，若要访问传入请求所提供的 Cookie，您**必须**先从请求中提取 `Set-Cookie` [HTTP 头部](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Set-Cookie)，再手动解析。

With `request.cookies`, you only need to invoke a property:

而借助 `request.cookies`，您只需访问一个属性即可：

```javascript
module.exports = (request, response) => {
```

```javascript
module.exports = (request, response) => {
```

2  console.log(request.cookies);

3};
```

这样做会以单个对象的形式返回所有 Cookie：

```javascript
1{
2  "cookie1": "i am a cookie",
3  "cookie2": "i am yet another cookie"
4}
```

### `request.body`

作为上述所有属性中功能最强大的一个，`request.body` 使您能够轻松访问传入请求的请求体，**无论其格式如何**：

```javascript
module.exports = (request, response) => {

2  console.log(request.body);

3};
```

自然地，无服务器函数接收的请求体（request body）可以是以下任意一种格式：

- 纯文本字符串（`text/plain`）

- 二进制缓冲区（`application/octet-stream`）

- JSON 对象（`application/json`）

- 表单数据查询字符串（`application/x-www-form-urlencoded`）

无论你使用上述哪一种格式作为请求体，访问 `request.body` 都会自动对其进行解析并返回解析后的结果。

例如，对于一个 JSON 请求，其请求体将如下所示：

```javascript
1{

2  "firstKey": "example value",

2  “firstKey”：“示例值”，

3  "secondKey": "another example value"

3  “secondKey”：“另一个示例值”

4}
```

4}
```

### )`response.status()`

### )`response.status()`

This method for outgoing responses can be invoked before `response.send()` and `response.json()` in order to define a [status code](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status) for the response.

该方法用于出站响应，可在调用 `response.send()` 和 `response.json()` 之前调用，以设置响应的[状态码](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Status)。

If you were to return an access error, for example, you could do it like this:

例如，若需返回一个访问错误，可按如下方式实现：

```javascript
module.exports = (request, response) => {

2  response.status(403);

3  response.json({ error: 'You do not have access' });

4};
```

```javascript
module.exports = (request, response) => {

2  response.status(403);

3  response.json({ error: '您无权访问' });

4};
```

### )`response.json()`

### )`response.json()`

As you can see in the example above, the `response.json()` method can be invoked with a JSON object as the first (and only) argument. It will then stringify the JSON it receives and send it back to the client:

如上例所示，`response.json()` 方法可接收一个 JSON 对象作为其第一个（也是唯一一个）参数。该方法会将接收到的 JSON 数据序列化为字符串，并将其发送回客户端：

```javascript
module.exports = (request, response) => {

2  response.json({ property: 'value' });

3};
```

```javascript
module.exports = (request, response) => {

2  response.json({ property: 'value' });

3};
```

When invoked, the method will automatically set the `Content-Type` header of the outgoing response to `application/json`, in order for the client to understand that JSON was sent.

调用该方法时，它会自动将响应的 `Content-Type` 响应头设为 `application/json`，以便客户端识别出返回的是 JSON 数据。

### )`response.send()`

### )`response.send()`

This method – just like `response.json()` – allows you to define the body of the outgoing response. However, it is used for sending **plain text** or **buffers:**

该方法与 `response.json()` 类似，也允许你定义响应体的内容；但其用途是发送**纯文本**或**缓冲区（buffers）**：

```javascript
module.exports = (request, response) => {

2  const example = Buffer.from('Welcome!');

```

```javascript
module.exports = (request, response) => {

2  const example = Buffer.from('Welcome!');

```

3  response.send(example);

4};
```

## Conclusion

## 结论

Assuming you are using the latest version of Vercel, there is no action to be taken: Edit one of your serverless Node.js functions and start using the helpers.

假设您正在使用最新版本的 Vercel，则无需任何额外操作：只需编辑任意一个无服务器 Node.js 函数，即可立即开始使用这些辅助方法。

In the future, **the list of helpers will grow**. So [stay tuned](https://twitter.com/vercel)!

未来，**辅助方法列表将持续扩充**。敬请关注！[关注 Vercel 官方 Twitter](https://twitter.com/vercel)

We also recommend checking out:

我们还推荐您查阅以下资源：

- [The feature documentation](https://vercel.com/docs/runtimes#official-runtimes/node-js/node-js-request-and-response-objects)

- [功能文档](https://vercel.com/docs/runtimes#official-runtimes/node-js/node-js-request-and-response-objects)

- [Example written in TypeScript](https://github.com/vercel/vercel/blob/master/examples/gatsby/api/date.ts)

- [TypeScript 示例代码](https://github.com/vercel/vercel/blob/master/examples/gatsby/api/date.ts)

Should you encounter any problems with the current helpers, please [let us know](https://vercel.com/feedback) or join the [Vercel Community](https://community.vercel.com/) to find answers to your questions.

如果您在使用当前辅助方法时遇到任何问题，请[向我们反馈](https://vercel.com/feedback)，或加入 [Vercel 社区](https://community.vercel.com/) 寻求帮助与解答。
{% endraw %}
