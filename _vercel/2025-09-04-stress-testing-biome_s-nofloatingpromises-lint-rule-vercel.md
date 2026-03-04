---
render_with_liquid: false
title: "Stress testing Biome's noFloatingPromises lint rule - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/stress-testing-biomes-nofloatingpromises-lint-rule"
date: "2025-09-04"
scraped_at: "2026-03-02T09:29:10.325631690+00:00"
language: "en-zh"
translated: true
description: "We partnered with Biome to push their noFloatingPromises lint rule to the limit, uncovering edge cases and showing how we solve hard problems together."
---
render_with_liquid: false
render_with_liquid: false

Sep 4, 2025

2025 年 9 月 4 日

Recently we [partnered](https://biomejs.dev/blog/vercel-partners-biome-type-inference/) with the [Biome](https://biomejs.dev/) team to strengthen their `noFloatingPromises` [lint rule](https://next.biomejs.dev/linter/rules/no-floating-promises/) to catch more subtle edge cases.  

最近，我们与 [Biome](https://biomejs.dev/) 团队[展开合作](https://biomejs.dev/blog/vercel-partners-biome-type-inference/)，共同强化其 `noFloatingPromises` [代码检查规则](https://next.biomejs.dev/linter/rules/no-floating-promises/)，以捕获更多隐蔽的边界情况。

This rule prevents unhandled Promises, which can cause silent errors and unpredictable behavior. Once Biome had an early version ready, they asked if we could help stress test it with some test cases.

该规则用于防止未处理的 Promise，因为这类 Promise 可能引发静默错误和不可预测的行为。当 Biome 完成早期版本后，他们邀请我们使用一批测试用例协助开展压力测试。

At Vercel, we know good tests require creativity just as much as attention to detail. To ensure strong coverage, we wanted to stretch the rule to its limits and so we thought it would be fun to turn this into a friendly internal competition. Who could come up with the trickiest examples that would still break the updated lint rule?

在 Vercel，我们深知：优秀的测试既需要细致入微的观察力，也离不开天马行空的创造力。为确保规则覆盖全面、鲁棒性强，我们希望将其能力推向极限——于是，我们决定将这项工作变成一场轻松友好的内部竞赛：谁能设计出最精巧、最刁钻的示例，仍能让升级后的 lint 规则“败下阵来”？

Part of the fun was learning together, but before we dive into the snippets, let’s revisit what makes a Promise “float”.

共同学习本身便充满乐趣；但在深入探讨具体代码片段之前，让我们先重温一下：究竟什么样的 Promise 才算“漂浮（floating）”？

## What is a floating Promise?

## 什么是“漂浮的 Promise”？

A [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) is “floating” when it’s created in a way that its errors can never be handled or observed. A Promise is not considered floating if it’s awaited, assigned to a variable, returned from an async function, called with the [`void` operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/void), or has `.then(...).catch(...)` handlers.

当一个 [Promise](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Promise) 的创建方式导致其错误永远无法被处理或观测时，它即被视为“漂浮的”。若 Promise 被 `await` 等待、被赋值给变量、从异步函数中返回、被 [`void` 运算符](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/void)调用，或已配备 `.then(...).catch(...)` 处理器，则它不被视为“漂浮的”。

This lint rule is important because broken control flow and unhandled errors resulting from floating Promises are notoriously hard to catch. Many engineers have campfire stories of floating Promises taking down production.

该 lint 规则至关重要——因“漂浮的 Promise”引发的控制流中断和未处理错误，向来极难被发现。许多工程师都曾围坐在“篝火旁”，分享过因“漂浮的 Promise”导致生产环境宕机的真实故事。

With that in mind, let’s look at some of the edge cases our engineers came up with.

带着这一背景，让我们来看看我们的工程师们挖掘出的若干边界案例。

## Array of Promises

## Promise 数组

Let’s kick it off with a great example of “smarter not harder”. This snippet was taken directly from [`typescript-eslint`’s docs](https://typescript-eslint.io/rules/no-floating-promises/#examples) for their floating Promises rule.

我们先从一个体现“聪明胜于蛮力”的绝佳示例入手。该代码片段直接取自 [`typescript-eslint`](https://typescript-eslint.io/rules/no-floating-promises/#examples) 关于“漂浮的 Promise”规则的官方文档。

```javascript
1[1, 2, 3].map(async (x) => x + 1)
```

它看起来无害，但其实很棘手，因为生成的 Promise 数组既未被保存，也未被 `await`，导致所有内部 Promise 处于“悬空”（floating）状态。

## Promise-like objects  
## 类 Promise 对象

通常，TypeScript 能识别出：如果你返回一个 `Promise`，那么当该 Promise 悬空时，代码检查工具（linter）就能捕获到：

```tsx
function normalPromise(): Promise<number> {

2  return new Promise((_, reject) => reject(2))

3}



normalPromise() // linter 警告：悬空的 Promise


```

But if you return a `PromiseLike` ( [PromiseLike is a TypeScript built-in](https://github.com/microsoft/TypeScript/blob/e635bb97f59c892f62c5061cbfeab5af211d743c/src/lib/es5.d.ts#L1519)), it’s only structurally similar, not the real thing:

但如果你返回一个 `PromiseLike`（[PromiseLike 是 TypeScript 的内置类型](https://github.com/microsoft/TypeScript/blob/e635bb97f59c892f62c5061cbfeab5af211d743c/src/lib/es5.d.ts#L1519)），它仅在结构上相似，而非真正的 `Promise`：

```tsx
function promiseLike(): PromiseLike<number> {

2  return new Promise((_, reject) => reject(2))

3}



promiseLike() // floating Promise
```

```tsx
function promiseLike(): PromiseLike<number> {

2  return new Promise((_, reject) => reject(2))

3}



promiseLike() // 悬浮的 Promise（未被处理的 Promise）
```

Since `PromiseLike` is only a structural match, calling `promiseLike()` and ignoring its rejection leaves an unhandled async result floating in space.

由于 `PromiseLike` 仅是结构上的匹配，调用 `promiseLike()` 后若忽略其拒绝（rejection），就会导致一个未被处理的异步结果“悬浮”在运行时环境中。

`typescript-eslint` handles this kind of case with a special [configuration option](https://typescript-eslint.io/rules/no-floating-promises/#checkthenables) for “Thenables” (another name for what `PromiseLike` represents)

`typescript-eslint` 通过一项专门的 [配置选项](https://typescript-eslint.io/rules/no-floating-promises/#checkthenables) 来处理此类情况，用于检查 “Thenables”（即 `PromiseLike` 所代表的对象的另一种称呼）。

## Structural typing tricks

## 结构化类型技巧

By copying [the TypeScript structure for a Promise](https://github.com/microsoft/TypeScript/blob/e635bb97f59c892f62c5061cbfeab5af211d743c/src/lib/es5.d.ts#L1532) under a different name, you can sneak past naïve checks.

通过将 [TypeScript 中 `Promise` 的结构定义](https://github.com/microsoft/TypeScript/blob/e635bb97f59c892f62c5061cbfeab5af211d743c/src/lib/es5.d.ts#L1532) 复制并另起一个类型名，你便可以绕过一些简单的类型检查。

```tsx
1/** a direct copy of the TypeScript `Promise` type, but with a different name */

1/** TypeScript 中 `Promise` 类型的直接复刻，但使用了不同的名称 */

interface Duck<T> {

interface Duck<T> {

3	then<TResult1 = T, TResult2 = never>(

3	then<TResult1 = T, TResult2 = never>(

4		onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null,

4		onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null,

5		onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null

5		onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null

6	): Promise<TResult1 | TResult2>

6	): Promise<TResult1 | TResult2>

7.catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): Promise<T | TResult>

7.catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): Promise<T | TResult>

8}

8}

function promise(): Duck<string> {

function promise(): Duck<string> {
```

11	return new Promise((_, reject) => reject(2))

11	返回一个新 Promise，立即以值 `2` 拒绝（reject）。

12}



promise()  // floating Promise (thenable)

promise()  // 悬浮的 Promise（可 then 的对象）

```

You’ve made a new type called `Duck` that looks exactly like a `Promise`, just with a different name. Because TypeScript uses [“structural”](https://en.wikipedia.org/wiki/Structural_type_system) typing, `Duck` behaves like a Promise but slips past lint rules that only check names. The name itself is a nod to “duck typing”, referencing the old idiom “if it walks like a duck, and talks like a duck, then it's a duck”.

你创建了一个名为 `Duck` 的新类型，其结构与 `Promise` 完全一致，仅名称不同。由于 TypeScript 采用[“结构化”](https://zh.wikipedia.org/wiki/%E7%BB%93%E6%9E%84%E5%9E%8B%E7%B1%BB%E5%9E%8B%E7%B3%BB%E7%BB%9F)（structural）类型系统，`Duck` 在行为上与 `Promise` 完全等效，却能绕过那些仅依赖名称进行检查的 ESLint 规则。该名称本身即是对“鸭子类型”（duck typing）的致敬，源自经典谚语：“若它走起来像鸭子、叫起来也像鸭子，那它就是一只鸭子”。

## Conditional type aliases

## 条件类型别名

Now we’re getting to the fun stuff: type-level trickery. Normally, TypeScript knows when you’re returning a Promise directly:

现在我们进入有趣的部分：类型层面的技巧（type-level trickery）。通常情况下，TypeScript 能准确识别你是否直接返回了一个 `Promise`：

```tsx
async function promiseLike() {

2  return new Promise((_, reject) => reject(2))

3}
```

```markdown
promiseLike() // linter warns: floating Promise

promiseLike() // 代码检查器警告：悬空的 Promise

```

But if you wrap the `Promise` inside a generic alias with a conditional, it doesn’t look like a plain Promise anymore.

但如果你将 `Promise` 封装在一个带条件判断的泛型类型别名中，它就不再看起来像一个普通的 `Promise` 了。

```tsx
type Cheating<T extends 1> = T extends 1 ? Promise<string> : Promise<string>



async function promiseLike(): Cheating<1> {

4	return new Promise((_, reject) => reject(2))

5}



promiseLike() // floating Promise
```

```tsx
type Cheating<T extends 1> = T extends 1 ? Promise<string> : Promise<string>



async function promiseLike(): Cheating<1> {

4	return new Promise((_, reject) => reject(2))

5}



promiseLike() // 悬空的 Promise
```

Although `Cheating<T>` always resolves to a `Promise<string>`, the conditional type and type parameter make that less obvious at the call site. If the lint rule only checks keys on the literal Promise name (instead of “thenables”), `promiseLike(): Cheating<1>` can slip past. The call to `promiseLike()` still returns a rejecting Promise, which is ignored and still floats.

虽然 `Cheating<T>` 始终解析为 `Promise<string>`，但条件类型与类型参数使得这一事实于调用处并不明显。如果该 lint 规则仅检查字面量名称 `Promise` 上的属性（而非更宽泛的“thenable”），那么 `promiseLike(): Cheating<1>` 就可能逃过检测。对 `promiseLike()` 的调用仍会返回一个拒绝态的 Promise，而该 Promise 被忽略，从而继续“漂浮”（即未被处理）。

## Proxy-based Promises

## 基于 Proxy 的 Promise

The JavaScript [`Proxy` object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Proxy) is useful to those that absolutely need it and incomprehensibly complex to everyone else. So it’s no wonder that we got one submission that ran with the idea “I bet I can use Proxy objects to break this”. This is perhaps the submission least likely to occur in production, but hey, a type-level hole is a type-level hole.

JavaScript 的 [`Proxy` 对象](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Proxy) 对那些确实需要它的人而言非常有用，但对其他人来说却晦涩难懂、极其复杂。因此，我们收到一份提交——其思路是：“我打赌能用 Proxy 对象来绕过这个检查”——也就毫不奇怪了。这或许是生产环境中最不可能出现的案例，但话说回来：类型层面的漏洞，终究还是类型层面的漏洞。

Normally, if you call methods on a Promise, the linter knows what’s going on:

通常，当你在 Promise 上调用方法时，linter 能够识别其行为：

```tsx
new Promise((_, reject) => reject(2)).then(() => {})
```

```tsx
new Promise((_, reject) => reject(2)).then(() => {})
```

But with JavaScript’s `Proxy`, you can intercept property access and sneak in hidden async behavior:

但借助 JavaScript 的 `Proxy`，你可以拦截属性访问，并悄悄注入隐藏的异步行为：

```tsx
function createLazyPromise<

2	T extends string,

3	U extends (prop: PropertyKey) => Promise<T>,

4>(getValue: U) {
```

```tsx
function createLazyPromise<

2	T extends string,

3	U extends (prop: PropertyKey) => Promise<T>,

4>(getValue: U) {
```

5	let resolve: (value: T) => void

5	令 `resolve` 为一个函数，其参数类型为 `T`，无返回值。

6	const promise = new Promise<T>((r) => {

6	const promise = new Promise<T>((r) => {

7		resolve = r

7		resolve = r

8		return r

8		return r

9	})

9	})



11	const proxy = new Proxy(promise as Promise<T>, {

11	const proxy = new Proxy(promise as Promise<T>, {

12		get(target, prop, receiver) {

12		get(target, prop, receiver) {

13			if (prop in target) {

13			if (prop 在 target 上存在) {

14				return Reflect.get(target, prop, receiver)

14				return Reflect.get(target, prop, receiver)

15			}

15			}

16			// Access to any other property triggers resolution

16			// 访问任何其他属性都会触发解析

17			getValue(prop).then(resolve) // floating promise

17			getValue(prop).then(resolve) // 悬浮式 Promise（未被 await 或 catch 的 Promise）

18			return undefined // Could also return another proxy here

18			return undefined // 此处也可返回另一个 Proxy

19		},

19		},

20	})

20	})

21	return proxy as Promise<T>

21	return proxy as Promise<T>

22}



22}



const lazy = createLazyPromise((prop) =>

const lazy = createLazyPromise((prop) =>

25	Promise.resolve(`You accessed: ${String(prop)}`),

25	Promise.resolve(`您访问了：${String(prop)}`),

26)



lazy.then((result) => {

26	`lazy`.then((result) => {

29	console.log(result) // floating Promise

29	console.log(result); // 悬浮的 Promise

30})


30})


32(lazy as any).foo // floating Promise

32(lazy as any).foo // 悬浮的 Promise
```

```

Here, accessing any non-Promise property on `lazy` secretly triggers an async side effect that floats unhandled. Even the `lazy.then(...)` call returns a Promise that goes unhandled, compounding the drift. It’s a contrived example, but it shows how flexible (and fragile) type inference can be.

此处，对 `lazy` 访问任何非 Promise 类型的属性，都会在后台悄悄触发一个异步副作用，且该副作用产生的 Promise 未被处理（即“悬浮”）。甚至 `lazy.then(...)` 调用本身也返回一个未被处理的 Promise，进一步加剧了这种失控状态。这是一个人为构造的例子，但它揭示了类型推断在灵活性（强大）背后所隐含的脆弱性。

## Frozen Promise objects

## 冻结的 Promise 对象

Freezing a Promise changes its type in ways that complicate detection.

冻结 Promise 会以复杂化检测的方式改变其类型。

```tsx
Object.freeze(new Promise((_, reject) => reject(2)))
```

```tsx
Object.freeze(new Promise((_, reject) => reject(2)))
```

The type of this expression is `Readonly<Promise<unknown>>`. That’s because [`Object.freeze()` prevents writing](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/freeze) on any object you pass it. It’s tricky because you’re wrapping the type with [the `Readonly` utility type](https://github.com/microsoft/TypeScript/blob/3eb7b6a1794a6d2cde7948a3016c57e628b104b9/src/lib/es5.d.ts#L1581) which makes it harder for a linter to catch.

该表达式的类型为 `Readonly<Promise<unknown>>`。这是因为 [`Object.freeze()` 会阻止对传入的任意对象进行写操作](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/freeze)。问题在于：你用 [TypeScript 内置的 `Readonly` 工具类型](https://github.com/microsoft/TypeScript/blob/3eb7b6a1794a6d2cde7948a3016c57e628b104b9/src/lib/es5.d.ts#L1581) 包裹了原始类型，从而增加了 linter 检测的难度。

## Promise-returning object members

## 返回 Promise 的对象成员

Finally! A simple one. Wrapping a Promise in an object method hides it behind another layer.

终于！这是一个相对简单的情况。将 Promise 封装在对象方法中，相当于为其增加了一层隐藏。

```tsx
const sneakyObject = {

2	rejectSomething() {

3		return new Promise((_, reject) => reject(2))

4	}

5}
```

```tsx
const sneakyObject = {

2	rejectSomething() {

3		return new Promise((_, reject) => reject(2))

4	}

5}
```

sneakyObject.rejectSomething() // 悬浮的 Promise  
```

与其依赖某种技巧，本示例将 Promise 封装在一个名为 `rejectSomething` 的函数中，而该函数本身是 `sneakyObject` 的一个成员。

## 属性访问器（Property getters）

JavaScript 的 getter 也可以在属性访问背后隐藏 Promise。

```tsx
const sneakyObject2 = {

2	get something() {

3		return new Promise((_, reject) => reject(2))

4	},

5}

sneakyObject2.something // 悬浮的 Promise
```

Similar to the last example, you can use [JavaScript’s `get` syntax](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/get) to hide the floating Promise. At a glance it looks like a simple property, but it’s actually returning an unhandled Promise.

与上一个示例类似，你可以使用 [JavaScript 的 `get` 语法](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/get) 来隐藏悬空的 Promise。乍看之下它像一个普通属性，但实际上返回的是一个未被处理的 Promise。

## Type remapping with getters

## 使用 getter 进行类型重映射

Normally, accessing an object property feels safe. But with a mapped type, even a getter can hide a Promise. This snippet disguises an async call as a harmless property getter.

通常，访问对象属性看起来是安全的。但在映射类型中，即使是 getter 也可能隐藏一个 Promise。此代码片段将异步调用伪装成一个无害的属性 getter。

```tsx
interface Things {

2	Thing: string

3}



type CalculateGetter<T> = {

6	[K in keyof T as K extends string ? `get${K}` : never]: () => Promise<T[K]>

7}
```

```ts
declare const lazyThings: CalculateGetter<Things>



lazyThings.getThing() // floating Promise
```

映射类型（mapped type）生成了返回 `Promise` 的 `get*` 方法，但若调用 `lazyThings.getThing()` 时未使用 `await`（或 `.then`），该 `Promise` 就会处于“悬浮”（floating）状态。表面上看这像一次简单的字段读取操作，而泛型的巧妙设计却悄然将其转化为一个未被处理的异步操作。在代码审查中，你几乎不可能发现这类问题！

## 短路运算符（Short-circuit operators）

逻辑运算符返回的是值，而非副作用（effects），因此可能使 `Promise` 悬而未决。

```tsx
true && new Promise((_, reject) => reject(2)) // floating Promise
```

典型的短路陷阱：`true && <Promise>` 表达式求值结果为右侧的 `Promise`，从而在纯表达式位置产生一个 `Promise` 值。由于没有任何地方对它执行 `await` 或调用 `.catch`，该拒绝（rejection）便无人处理。这提醒我们：`&&` 并不会执行副作用并等待其完成；它实际返回一个值——而此处这个值恰好是一个易失的（volatile）`Promise`。

## 随机化表达式（Randomized expressions）

What if you only sometimes have a floating Promise? When randomness is involved, sometimes only part of the code returns a Promise.

如果有时才出现一个“悬浮的” Promise 呢？当涉及随机性时，代码中仅部分分支会返回 Promise。

```tsx
Math.random() > 0.5

2  ? new Promise((_, reject) => reject(2)) // floating Promise

3  : null
```

```tsx
Math.random() > 0.5

2  ? new Promise((_, reject) => reject(2)) // 悬浮的 Promise

3  : null
```

Maybe there’s some value that only exists at runtime, perhaps from user input or some API. In that case, it still should be a lint error. The type of this expression is `Promise<unknown> | null` \- and that’s good enough to fit the bill!

也许存在某个仅在运行时才确定的值，例如来自用户输入或某个 API 的响应。此时，它仍应被识别为一条 lint 错误。该表达式的类型为 `Promise<unknown> | null` —— 这已足以触发规则检查！

## Optional chaining fallbacks

## 可选链式调用中的回退逻辑

Optional chaining with fallbacks can produce Promises that go unhandled. Similar to the last two, you can trigger the “short circuiting” however you want, and this example uses optional chaining.

使用可选链式调用（optional chaining）配合回退逻辑，可能产生未被处理的 Promise。与前两个示例类似，你可以通过任意方式触发“短路求值”，而本例采用的就是可选链式调用。

```tsx
const optionalObject: Record<string, (() => unknown) | undefined> = {}

optionalObject?.nonExistentMethod?.() || new Promise((_, reject) => reject(2))
```

```tsx
const optionalObject: Record<string, (() => unknown) | undefined> = {}

optionalObject?.nonExistentMethod?.() || new Promise((_, reject) => reject(2))
```

The optional call returns `undefined`, so `||` eagerly evaluates the right-hand side which constructs a rejecting Promise. Because that Promise lives only in expression position (never assigned, awaited, or `.catch`ed), the rejection floats silently behind an innocent-looking fallback.

可选调用返回 `undefined`，因此 `||` 会立即求值右侧表达式，从而构造出一个拒绝（reject）状态的 Promise。由于该 Promise 仅存在于表达式位置（既未被赋值给变量、也未被 `await` 或 `.catch()` 处理），其拒绝行为便会在看似无害的回退逻辑背后悄然发生。

## Immediately invoked functions

## 立即执行函数（IIFE）

There was once a time when every JavaScript developer had to be aware of the [immediately invoked function expression](https://developer.mozilla.org/en-US/docs/Glossary/IIFE) (IIFE, pronounced “if-y”)

曾经有一段时间，每位 JavaScript 开发者都必须了解 [立即调用函数表达式](https://developer.mozilla.org/zh-CN/docs/Glossary/IIFE)（IIFE，读作 “if-y”）。

```tsx
1(() => new Promise((_, reject) => reject(2)))()
```

```tsx
1(() => new Promise((_, reject) => reject(2)))()
```

Wrapping in a function call doesn’t change the fact that the Promise is unhandled.

将 Promise 包裹在函数调用中，并不能改变其未被处理（unhandled）的事实。

## The comma operator

## 逗号运算符

Last up, we have the obscure [comma operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comma_operator). If you’ve ever looked at minified JavaScript you’ve likely seen this in action.

最后登场的是鲜为人知的 [逗号运算符](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Comma_operator)。如果你曾查看过压缩后的 JavaScript 代码，很可能已经见过它在实际中的应用。

```tsx
let _x = 5

2_x++, new Promise((_, reject) => reject(2))
```

```tsx
let _x = 5

2_x++, new Promise((_, reject) => reject(2))
```

The result of the expression is the Promise, which is ignored and left floating. It’s a syntactically tight way to discard the left expression and return whatever’s on the right. It once had niche uses, but today it’s mostly syntactic trivia. Still, it’s one more case a linter has to catch.

该表达式的结果是右侧的 Promise，而它被忽略且处于“悬空”（floating）状态。这是一种语法上高度紧凑的方式：舍弃左侧表达式的值，仅返回右侧的值。它过去曾有某些特定场景下的用途，但如今基本只属于语法冷知识。尽管如此，它仍是代码检查工具（linter）需要额外识别并告警的一种情况。

## Winner

## 最终胜出者

After consideration from an esteemed panel of judges, it was decided that the Proxy Promise submission was the winner. It was the least practical, most convoluted, and most obscure example. But that's exactly what we were looking for. The goal was never to find real-world bugs, but to stress test the implementation with any trick we could imagine.

经过一众德高望重的评委审慎考量，最终决定“Proxy Promise”提交方案胜出。它是所有参选示例中实用性最低、逻辑最绕、语义最晦涩的一个——而这恰恰正是我们所寻求的。本次竞赛的目标从来就不是发现真实世界中的 Bug，而是用我们所能想到的一切奇技淫巧，对实现进行极限压力测试。

These snippets helped the Biome maintainers quickly fix issues, many of which are now resolved today. Like any software, linters need to prioritize the cases most likely to affect users. If you have an edge case of your own that isn't fixed, consider [sending Biome a PR](https://github.com/biomejs/biome)!

这些代码片段帮助 Biome 维护者快速定位并修复了诸多问题，其中许多如今已得到解决。与任何软件一样，代码检查工具（linter）也需优先处理最可能影响用户的情形。如果你遇到了尚未修复的边界情况，欢迎向 Biome 提交 [Pull Request（PR）](https://github.com/biomejs/biome)！

## Join us

## 加入我们

This competition was just as much about culture as it was about improving the lint rule. It gave us the chance to collaborate, get creative, support open source, and share in some friendly mischief. That reflects the culture we're building at Vercel: solving hard problems together while having fun along the way.

这场竞赛不仅关乎改进某条代码检查规则，更是一次关于工程文化的实践。它为我们提供了协作的机会、激发创意的空间、支持开源的平台，以及共享善意恶作剧的乐趣。这正体现了 Vercel 正在构建的文化：携手攻克难题，同时乐在其中。

Our engineers care deeply about improving the developer experience, building fast and reliable systems, and giving back to the open source community. We thrive on curiosity, creativity, and collaboration, whether that’s designing scalable infrastructure, pushing the boundaries of web performance, or inventing new ways to make developers more productive.

我们的工程师深切关注开发者体验的提升、高性能可靠系统的构建，以及对开源社区的回馈。我们以好奇心、创造力与协作精神为驱动力——无论是设计可扩展的基础设施、突破网页性能的边界，还是开创提升开发者生产力的新方法，皆是如此。

If that sounds like you, we’d love to work together. [Explore open roles at Vercel](https://vercel.com/careers).

如果你也认同这样的理念，我们诚挚期待与你共事。[浏览 Vercel 当前开放职位](https://vercel.com/careers)。