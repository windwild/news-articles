---
title: "Helpers for Serverless Node.js Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-node-helpers"
date: "2019-06-19"
scraped_at: "2026-03-02T10:07:52.481186080+00:00"
language: "en"
translated: false
description: "Introducing six default methods to the request and response payloads in your Node.js Serverless Functions."
---




Jun 19, 2019

Migrating to serverless Node.js functions or creating new ones can mean that some of the tools and frameworks you used previously are not suitable anymore.

With today's feature release, we want to solve this problem by providing you with a set of default **helpers exposed within your Node.js function**.

## What's New

The recent update to serverless Node.js functions on Vercel introduces six default methods to the `request` and `response` payload:

- `request.query`

- `request.cookies`

- `request.body`

- `response.status()`

- `response.json()`

- `response.send()`


In order to access any of these methods, **no changes are required on your side.**

### Performance

With the introduction of helpers, your application receives a **gain in performance** when compared to a basic [Express.js](https://expressjs.com/) application:

**NOTE:** The benchmarks above are used to showcase the performance difference between serverless Node.js functions on Vercel and the [Express.js](https://expressjs.com/) framework.

While the relative improvement will stay the same, the actual time taken will vary depending on your system configuration.

## How to Use Helpers

These are the properties and methods that are available on the `request` and `response` arguments that your serverless function receives:

### `request.query`

**Before this update**, the easiest way to parse the GET parameters of an incoming GET request was to retrieve the `request.url` property and then pass the value to a parser.

With `request.query`, however, you have direct access to all the GET parameters, without having to parse them on your own:

```javascript
module.exports = (request, response) => {

2  console.log(request.query);

3};
```

For example, if your endpoint's URL is `/endpoint?key=value`, the content of `request.query` would look like this:

```javascript
1{ "key": "value" }
```

### `request.cookies`

In order to access the cookies supplied by an incoming request, you **previously** had to retrieve the `Set-Cookie` [header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie) from the request and then parse it manually.

With `request.cookies`, you only need to invoke a property:

```javascript
module.exports = (request, response) => {

2  console.log(request.cookies);

3};
```

Doing so will give you all the cookies in a single object:

```javascript
1{

2  "cookie1": "i am a cookie",

3  "cookie2": "i am yet another cookie"

4}
```

### `request.body`

As the most versatile property out of all mentioned above, `request.body` allows you to easily access the body of incoming requests, **no matter what format**:

```javascript
module.exports = (request, response) => {

2  console.log(request.body);

3};
```

Naturally, the body for incoming requests to serverless functions can be either:

- A string of text (`text/plain`)

- A buffer (`application/octet-stream`)

- A json object (`application/json`)

- A form data query string (`application/x-www-form-urlencoded`)


No matter which of those formats you are using for your body, accessing `request.body` will automatically parse it and return it.

For example, this is what the body would look like for a JSON request:

```javascript
1{

2  "firstKey": "example value",

3  "secondKey": "another example value"

4}
```

### )`response.status()`

This method for outgoing responses can be invoked before `response.send()` and `response.json()` in order to define a [status code](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status) for the response.

If you were to return an access error, for example, you could do it like this:

```javascript
module.exports = (request, response) => {

2  response.status(403);

3  response.json({ error: 'You do not have access' });

4};
```

### )`response.json()`

As you can see in the example above, the `response.json()` method can be invoked with a JSON object as the first (and only) argument. It will then stringify the JSON it receives and send it back to the client:

```javascript
module.exports = (request, response) => {

2  response.json({ property: 'value' });

3};
```

When invoked, the method will automatically set the `Content-Type` header of the outgoing response to `application/json`, in order for the client to understand that JSON was sent.

### )`response.send()`

This method – just like `response.json()` – allows you to define the body of the outgoing response. However, it is used for sending **plain text** or **buffers:**

```javascript
module.exports = (request, response) => {

2  const example = Buffer.from('Welcome!');

3  response.send(example);

4};
```

## Conclusion

Assuming you are using the latest version of Vercel, there is no action to be taken: Edit one of your serverless Node.js functions and start using the helpers.

In the future, **the list of helpers will grow**. So [stay tuned](https://twitter.com/vercel)!

We also recommend checking out:

- [The feature documentation](https://vercel.com/docs/runtimes#official-runtimes/node-js/node-js-request-and-response-objects)

- [Example written in TypeScript](https://github.com/vercel/vercel/blob/master/examples/gatsby/api/date.ts)


Should you encounter any problems with the current helpers, please [let us know](https://vercel.com/feedback) or join the [Vercel Community](https://community.vercel.com/) to find answers to your questions.