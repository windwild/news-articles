---
title: " How we built the v0 iOS app - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-we-built-the-v0-ios-app"
date: "2025-11-24"
scraped_at: "2026-03-02T09:25:04.284296657+00:00"
language: "en-zh"
translated: true
description: "The v0 engineering team breaks down the challenges and decisions behind building the v0 app for iOS."
---
&#123;% raw %}

Nov 24, 2025

2025 年 11 月 24 日

We recently released [v0 for iOS](https://apps.apple.com/us/app/v0/id6745097949), Vercel’s first mobile app. As a company focused on the web, building a native app was new territory for us.

我们近期发布了 [v0 for iOS](https://apps.apple.com/us/app/v0/id6745097949)——Vercel 首款移动应用。作为一家专注于 Web 的公司，开发原生移动应用对我们而言是一片全新领域。

Our goal was to build an app worthy of an Apple Design Award, and we were open-minded on the best tech stack to get there. To that end, we built dozens of iterations of the product prior to our public beta. We experimented with drastically different tech stacks and UI patterns.

我们的目标是打造一款足以角逐 Apple 设计大奖（Apple Design Award）的应用；为此，我们对实现这一目标的最佳技术栈持开放态度。在公开测试版发布前，我们已构建了数十个产品迭代版本，并尝试了截然不同的技术栈与用户界面设计模式。

We took inspiration from apps which speak the iPhone’s language, such as Apple Notes and iMessage. v0 had to earn a spot on your Home Screen among the greats.

我们从那些“说 iPhone 语言”的应用中汲取灵感，例如 Apple Notes 和 iMessage。v0 必须凭借自身实力，在你的主屏幕之上，与这些杰出应用并驾齐驱。

After weeks of experimentation, we landed on React Native with Expo to achieve this. We are pleased with the results, and our customers are too. In fact, the influx of messages from developers asking how the app feels so native compelled us to write a technical breakdown of how we did it.

经过数周的探索与验证，我们最终选定 React Native 搭配 Expo 来实现这一目标。我们对成果深感满意，用户亦然。事实上，大量开发者纷纷发来消息，好奇这款应用为何能拥有如此原生的体验——这促使我们撰写了本文，深入剖析其实现原理。

## Table of contents

## 目录

- [How we built the v0 chat experience](https://vercel.com/blog/how-we-built-the-v0-ios-app#how-we-built-the-v0-chat-experience)

  - [如何构建 v0 的聊天体验](https://vercel.com/blog/how-we-built-the-v0-ios-app#how-we-built-the-v0-chat-experience)

  - [Building a composable chat](https://vercel.com/blog/how-we-built-the-v0-ios-app#building-a-composable-chat)

  - [构建可组合的聊天界面](https://vercel.com/blog/how-we-built-the-v0-ios-app#building-a-composable-chat)

  - [Sending your first message](https://vercel.com/blog/how-we-built-the-v0-ios-app#sending-your-first-message)

  - [发送你的第一条消息](https://vercel.com/blog/how-we-built-the-v0-ios-app#sending-your-first-message)

  - [Fading in the first assistant message](https://vercel.com/blog/how-we-built-the-v0-ios-app#fading-in-the-first-assistant-message)

  - [淡入首条助手回复](https://vercel.com/blog/how-we-built-the-v0-ios-app#fading-in-the-first-assistant-message)

  - [Sending messages in an existing chat](https://vercel.com/blog/how-we-built-the-v0-ios-app#sending-messages-in-an-existing-chat)

  - [在已有聊天中发送消息](https://vercel.com/blog/how-we-built-the-v0-ios-app#sending-messages-in-an-existing-chat)

  - [How we solved messages scrolling to the top](https://vercel.com/blog/how-we-built-the-v0-ios-app#how-we-solved-it)

  - [我们如何解决消息滚动至顶部的问题](https://vercel.com/blog/how-we-built-the-v0-ios-app#how-we-solved-it)

- [Taming the keyboard](https://vercel.com/blog/how-we-built-the-v0-ios-app#taming-the-keyboard)

- [驯服键盘](https://vercel.com/blog/how-we-built-the-v0-ios-app#taming-the-keyboard)

- [Scrolling to end initially](https://vercel.com/blog/how-we-built-the-v0-ios-app#scrolling-to-end-initially)

- [初始加载时滚动到底部](https://vercel.com/blog/how-we-built-the-v0-ios-app#scrolling-to-end-initially)

- [Floating composer](https://vercel.com/blog/how-we-built-the-v0-ios-app#floating-composer)

- [浮动输入框](https://vercel.com/blog/how-we-built-the-v0-ios-app#floating-composer)

  - [Make it float](https://vercel.com/blog/how-we-built-the-v0-ios-app#make-it-float)

  - [实现悬浮效果](https://vercel.com/blog/how-we-built-the-v0-ios-app#make-it-float)

  - [Make it native](https://vercel.com/blog/how-we-built-the-v0-ios-app#make-it-native)

  - [使其原生化](https://vercel.com/blog/how-we-built-the-v0-ios-app#make-it-native)

  - [Pasting images](https://vercel.com/blog/how-we-built-the-v0-ios-app#pasting-images)

  - [粘贴图片](https://vercel.com/blog/how-we-built-the-v0-ios-app#pasting-images)

- [Fading in content](https://vercel.com/blog/how-we-built-the-v0-ios-app#fading-in-streaming-content)

- [内容渐显（流式响应）](https://vercel.com/blog/how-we-built-the-v0-ios-app#fading-in-streaming-content)

- [Sharing code between web and native](https://vercel.com/blog/how-we-built-the-v0-ios-app#sharing-code-between-web-and-native)

- [在 Web 与原生平台间共享代码](https://vercel.com/blog/how-we-built-the-v0-ios-app#sharing-code-between-web-and-native)

- [Styling](https://vercel.com/blog/how-we-built-the-v0-ios-app#styling)

- [样式设计](https://vercel.com/blog/how-we-built-the-v0-ios-app#styling)

  - [Native menus](https://vercel.com/blog/how-we-built-the-v0-ios-app#native-menus)

  - [原生菜单](https://vercel.com/blog/how-we-built-the-v0-ios-app#native-menus)

  - [Native alerts](https://vercel.com/blog/how-we-built-the-v0-ios-app#native-alerts)

  - [原生提醒框（Native alerts）](https://vercel.com/blog/how-we-built-the-v0-ios-app#native-alerts)

  - [Native bottom sheets](https://vercel.com/blog/how-we-built-the-v0-ios-app#native-bottom-sheets)

  - [原生底部弹出面板（Native bottom sheets）](https://vercel.com/blog/how-we-built-the-v0-ios-app#native-bottom-sheets)

- [Looking forward](https://vercel.com/blog/how-we-built-the-v0-ios-app#looking-forward)

- [展望未来](https://vercel.com/blog/how-we-built-the-v0-ios-app#looking-forward)


## How we built the v0 chat experience

## 我们如何构建 v0 的聊天体验

When you’re away from your computer, you might have a quick idea you want to act on. Our goal was to let you turn that idea into something tangible, without requiring context switching. v0 for iOS is the next generation of your Notes app, where your ideas get built in the background.

当你离开电脑时，脑海中可能突然闪现出一个亟待实现的创意。我们的目标是让你无需切换上下文，就能将这个想法快速转化为切实可用的内容。v0 for iOS 是你笔记应用的下一代演进——在这里，你的创意将在后台自动构建成型。

We did not set out to build a mobile IDE with feature parity with our website. Instead, we wanted to build a simple, delightful experience for using AI to make things on the go. The centerpiece of that experience is the chat.

我们并非旨在打造一款与网页端功能完全对等的移动 IDE；相反，我们希望构建一种简洁、愉悦的移动端 AI 创作体验。而这一体验的核心，正是聊天界面（chat）。

To build a great chat, we set the following requirements:

为打造出色的聊天体验，我们设定了以下设计要求：

- New messages animate in smoothly

- 新消息以流畅动画形式逐条呈现

- New user messages scroll to the top of the screen

- 用户发送的新消息会自动滚动至屏幕顶部

- Assistant messages fade in with a staggered transition as they stream

- 助理回复内容在流式输出过程中，以错落有致的淡入动画逐段呈现

- The composer uses Liquid Glass and floats on top of scrollable content

- 输入框（composer）采用 Liquid Glass 视觉效果，并悬浮于可滚动内容之上

- Opening existing chats starts scrolled to the end  
- 打开已有聊天会自动滚动至底部

- Keyboard handling feels natural  
- 键盘交互体验自然流畅

- The text input lets you paste images and files  
- 文本输入框支持粘贴图片和文件

- The text input supports pan gestures to focus and blur it  
- 文本输入框支持通过拖拽（pan）手势实现聚焦与失焦

- Markdown is fast and supports dynamic components  
- Markdown 渲染快速，并支持动态组件

While a number of UI patterns have emerged for AI chat in mobile apps, there is no equivalent set of patterns for AI code generation on mobile.  
尽管在移动应用中，AI 聊天已涌现出多种 UI 设计模式，但面向移动端的 AI 代码生成却尚无对应的设计模式体系。

We hadn’t seen these features in existing React Native apps, so we found ourselves inventing patterns on the fly. It took an extraordinary amount of work, testing, and coordination across each feature to make it meet our standards.  
我们在现有 React Native 应用中尚未见到上述功能，因此不得不边开发边探索、即兴设计交互模式。为使每一项功能均达到我们的标准，我们投入了大量工作，进行了密集测试，并在各功能模块间开展了高度协同。

## Building a composable chat  

## 构建可组合的聊天界面

To meet our requirements, we structured our chat code to be [composable](https://www.youtube.com/watch?v=4KvbVq3Eg5w) on a per-feature basis.  
为满足需求，我们将聊天功能的代码按“特性粒度”组织为[可组合式结构](https://www.youtube.com/watch?v=4KvbVq3Eg5w)。

Our chat is powered by a few open source libraries: [LegendList](https://legendapp.com/open-source/list/), [React Native Reanimated](https://docs.swmansion.com/react-native-reanimated/), and [React Native Keyboard Controller](https://kirillzyusko.github.io/react-native-keyboard-controller/). To start, we set up multiple context providers.  
我们的聊天功能依托若干开源库实现：[LegendList](https://legendapp.com/open-source/list/)、[React Native Reanimated](https://docs.swmansion.com/react-native-reanimated/) 和 [React Native Keyboard Controller](https://kirillzyusko.github.io/react-native-keyboard-controller/)。初始阶段，我们配置了多个 Context Provider。

```tsx
export function ChatProvider({ children }) {

2  return (

3    <ComposerHeightProvider>

4      <MessageListProvider>

5        <NewMessageAnimationProvider>

6          <KeyboardStateProvider>{children}</KeyboardStateProvider>

7        </NewMessageAnimationProvider>

8      </MessageListProvider>

9    </ComposerHeightProvider>

10  )
```

```tsx
export function ChatProvider({ children }) {

2  返回 (

3    <ComposerHeightProvider>

4      <MessageListProvider>

5        <NewMessageAnimationProvider>

6          <KeyboardStateProvider>{children}</KeyboardStateProvider>

7        </NewMessageAnimationProvider>

8      </MessageListProvider>

9    </ComposerHeightProvider>

10  )
```

11}
```

该组件将 `MessagesList` 包裹在 `ChatProvider` 中：

```tsx
export function ChatMessagesList({ chatId }) {

2  const messages = useMessages({ chatId }).data

3  return (

4    <ChatProvider key={chatId}>

5      <MessagesList messages={messages} />

6    </ChatProvider>

7  )

8}
```

Next, our messages list implements these features as composable plugins, each with its own hook.

接下来，我们的消息列表通过可组合的插件实现这些功能，每个插件都拥有自己独立的 Hook。

```jsx
function MessagesList({ messages }) {

2  useKeyboardAwareMessageList()

3  useScrollMessageListFromComposerSizeUpdates()

4  useUpdateLastMessageIndex()

5  const { animatedProps, ref, onContentSizeChange, onScroll } = useMessageListProps()

6  return (

7    <AnimatedLegendList

8      animatedProps={animatedProps}

9      ref={ref}

10      onContentSizeChange={onContentSizeChange}

10      内容尺寸变化回调函数={onContentSizeChange}

11      onScroll={onScroll}

11      滚动事件回调函数={onScroll}

12      enableAverages={false}

12      启用平均值计算={false}

13      data={messages}

13      数据源={messages}

14      keyExtractor={(item) => item.id}

14      键提取器={(item) => item.id}

15      renderItem={({ item, index }) => {

15      渲染项={({ item, index }) => {

16        if (item.role === 'user') {

16        如果 (item.role === 'user') {

17          return <UserMessage message={item} index={index} />

17          返回 <UserMessage message={item} index={index} />

18        }

18        }

19        if (item.role === 'assistant') {

19        如果 (item.role === 'assistant') {

20          return <AssistantMessage message={item} index={index} />

20          返回 `<AssistantMessage message={item} index={index} />`

21        }

21        }

22        if (item.role === 'optimistic-placeholder') {

22        如果 `item.role` 等于 `'optimistic-placeholder'`：

23          return <OptimisticAssistantMessage index={index} />

23          则返回 `<OptimisticAssistantMessage index={index} />`

24        }

24        }

25      }}

25      }}

26    />

26    />

27  )

27  )

28}
28}

The following sections break down each hook to demonstrate how they work together.

以下各节将逐一解析每个 Hook，以说明它们如何协同工作。

## Sending your first message

## 发送您的第一条消息

When you send a message on v0, the message bubble smoothly fades in and slides to the top. Immediately after the user message is done animating, the assistant messages fade in.

在 v0 上发送消息时，消息气泡会平滑地淡入并向上滑动至顶部。用户消息的动画一结束，助手回复的消息随即淡入显示。

When the user sends a message, we set a Reanimated shared value to indicate the animation should begin. Shared values let us update state without triggering re-renders.

当用户发送消息时，我们设置一个 Reanimated 共享值（shared value），以指示动画应开始执行。共享值使我们能够在不触发组件重新渲染的情况下更新状态。

```tsx
const { isMessageSendAnimating } = useNewMessageAnimation()

const chatId = useChatId()



const onSubmit = () => {

5  const isNewChat = !chatId



7  if (isNewChat) {

8    isMessageSendAnimating.set(true)

9  }



11  send()

12}
```

提交时设置动画状态

在 Reanimated 中跟踪了我们的状态后，我们现在可以为 `UserMessage` 添加动画效果。

```tsx
export function UserMessage({ message, index }) {

2  const isFirstUserMessage = index === 0

4  const { style, ref, onLayout } = useFirstMessageAnimation({

4  const { style, ref, onLayout } = useFirstMessageAnimation({

5    disabled: !isFirstUserMessage,

5    disabled: !isFirstUserMessage,

6  })

6  })



8  return (

8  return (

9    <Animated.View style={style} ref={ref} onLayout={onLayout}>

9    <Animated.View style={style} ref={ref} onLayout={onLayout}>

10      <UserMessageContent message={message} />

10      <UserMessageContent message={message} />

11    </Animated.View>

11    </Animated.View>

12  )

12  )

13}
```
13}
```

Wrapping the user message in an animated view

将用户消息包裹在带动画效果的视图中

Notice that `UserMessageContent` is wrapped with an `Animated.View` which receives props from `useFirstMessageAnimation`.

注意：`UserMessageContent` 被包裹在 `Animated.View` 中，该组件接收来自 `useFirstMessageAnimation` 的属性。

### How `useFirstMessageAnimation` works

### `useFirstMessageAnimation` 的工作原理

This hook is responsible for 3 things:

该 Hook 主要负责以下三件事：

1. Measure the height of the user message with `itemHeight`, a Reanimated shared value

1. 使用 `itemHeight`（一个 Reanimated 共享值）测量用户消息的高度。

2. Fade in the message when `isMessageSendAnimating`

2. 当 `isMessageSendAnimating` 为真时，使消息淡入显示。

3. Signal to the assistant message that the animation is complete

3. 向助手消息通知：当前动画已结束。

```tsx
export function useFirstMessageAnimation({ disabled }) {

2  const { keyboardHeight } = useKeyboardContextState()

3  const { isMessageSendAnimating } = useNewMessageAnimation()
```

4  const windowHeight = useWindowDimensions().height

4  const windowHeight = useWindowDimensions().height

5  const translateY = useSharedValue(0)

5  const translateY = useSharedValue(0)

6  const progress = useSharedValue(-1)

6  const progress = useSharedValue(-1)

7  const { itemHeight, ref, onLayout } = useMessageRenderedHeight()

7  const { itemHeight, ref, onLayout } = useMessageRenderedHeight()



9  useAnimatedReaction(

9  useAnimatedReaction(

10    () => {

10    () => {

11      const didAnimate = progress.get() !== -1

11      const didAnimate = progress.get() !== -1



13      if (disabled || didAnimate || !isMessageSendAnimating.get()) {

13      if (disabled || didAnimate || !isMessageSendAnimating.get()) {

14        return -1

14        返回 -1

15      }

15      }

17      return itemHeight.get()

17      返回 itemHeight.get()

18    },

18    },

19    (messageHeight) => {

19    (messageHeight) => {

20      if (messageHeight <= 0) return

20      如果 messageHeight ≤ 0，则直接返回

22      const animatedValues = getAnimatedValues({

22      const animatedValues = getAnimatedValues({

23        itemHeight: messageHeight,

23        itemHeight: messageHeight,

24        windowHeight,

24        窗口高度，

25        keyboardHeight: keyboardHeight.get(),

25        键盘高度：keyboardHeight.get(),

26      })

26      })

27      const { start, end, duration, easing, config } = animatedValues

27      const { start, end, duration, easing, config } = animatedValues



29      translateY.set(

29      translateY.set(

30        // initialize values at the "start" state with duration 0

30        // 以持续时间为 0 初始化值，使其处于“起始”状态

31        withTiming(start.translateY, { duration: 0 }, () => {

31        withTiming(start.translateY, { duration: 0 }, () => {

32          // next, transition to the "end" state

32          // 接着，过渡到“结束”状态

33          translateY.set(withSpring(end.translateY, config))

33          translateY.set(withSpring(end.translateY, config))

34        })

34        })

35      )

35      )

36      progress.set(

36      progress.set(

37        withTiming(start.progress, { duration: 0 }, () => {

37        withTiming(start.progress, { duration: 0 }, () => {

38          progress.set(withTiming(end.progress, { duration, easing }), () => {

38          progress.set(withTiming(end.progress, { duration, easing }), () => {

39            isMessageSendAnimating.set(false)

39            isMessageSendAnimating.set(false)

40          })

40          })

41        })

41        })

42      )

42      )

43    }

43    }

44  )

44  )

46  const style = useAnimatedStyle(...)

46  const style = useAnimatedStyle(...)

47  const didUserMessageAnimate = useDerivedValue(() => progress.get() === 1)

47  const didUserMessageAnimate = useDerivedValue(() => progress.get() === 1)

49  return { style, ref, onLayout, didUserMessageAnimate }

49  return { style, ref, onLayout, didUserMessageAnimate }

50}
50}

```

```

The useFirstMessageAnimation hook

`useFirstMessageAnimation` 自定义 Hook

Thanks to React Native’s New Architecture, `ref.current.measure()` in `useLayoutEffect` is synchronous, giving us height on the first render. Subsequent updates fire in `onLayout`.

得益于 React Native 的新架构，`useLayoutEffect` 中的 `ref.current.measure()` 是同步执行的，因此我们能在首次渲染时即获取到消息元素的高度；后续的高度更新则通过 `onLayout` 触发。

Based on the message height, window height, and current keyboard height, `getAnimatedValues` constructs the easing, `start`, and `end` states for `translateY` and `progress`. The resulting shared values are passed to `useAnimatedStyle` as `transform` and `opacity` respectively.

`getAnimatedValues` 函数依据消息高度、窗口高度以及当前键盘高度，计算出 `translateY` 和 `progress` 动画所需的缓动函数（easing）、起始值（`start`）与结束值（`end`）。最终生成的共享值（shared values）分别作为 `transform` 和 `opacity` 参数传入 `useAnimatedStyle`。

And there we have it. Our first message fades in using Reanimated. Once it’s done animating, we’re ready to fade in the first assistant message response.

就这样，我们的第一条消息便通过 Reanimated 实现了淡入效果。当该动画播放完毕后，我们即可开始淡入第一条助手消息的响应内容。

## Fading in the first assistant message

## 淡入第一条助手消息

Similar to `UserMessage`, the assistant message content is wrapped in an animated view that fades in after the user message animation completes.

与 `UserMessage` 类似，助手消息的内容也被包裹在一个动画视图中，该视图会在用户消息动画完成之后执行淡入效果。

```tsx
function AssistantMessage({ message, index }) {

2  const isFirstAssistantMessage = index === 1



4  const { didUserMessageAnimate } = useFirstMessageAnimation({

5    disabled: !isFirstAssistantMessage,

6  })
```

8  const style = useAnimatedStyle(() => ({

8  const style = useAnimatedStyle(() => ({

9    opacity: didUserMessageAnimate.get() ? withTiming(1, { duration: 350 }) : 0,

9    opacity: didUserMessageAnimate.get() ? withTiming(1, { duration: 350 }) : 0,

10  }))

10  }))

12  return (

12  return (

13    <Animated.View style={style}>

13    <Animated.View style={style}>

14      <AssistantMessageContent message={message} />

14      <AssistantMessageContent message={message} />

15    </Animated.View>

15    </Animated.View>

16  )

16  )

17}
```
17}
```

Fading in after the user message animation completes

用户消息动画播放完毕后，助手消息淡入显示。

This fade in behavior is only enabled for the first assistant message in the chat, where `index === 1`. Messages in existing chats will have different behavior than messages in new chats.

该淡入行为仅对聊天中的第一条助手消息启用（即 `index === 1`）。在已有聊天中发送的消息，其行为与新聊天中的消息不同。

What happens if you open an existing chat that has one user message and one assistant message? Will it animate in again? No, because the animations here only apply if `isMessageSendAnimating` is `true`, which gets set `onSubmit` and cleared when you change chats.

如果打开一个已存在的聊天（其中已有一条用户消息和一条助手消息），助手消息会再次执行动画吗？不会。因为此处的动画仅在 `isMessageSendAnimating` 为 `true` 时触发；而该状态仅在调用 `onSubmit` 时设为 `true`，并在切换聊天时被清除。

## Sending messages in an existing chat

## 在已有聊天中发送消息

We’ve covered how v0 handles animating in messages for new chats. For existing chats, however, the logic is entirely distinct. Rather than rely on Reanimated animations, such as the one in `useFirstMessageAnimation`, we rely on an implementation of `scrollToEnd()`.

我们已介绍 v0 如何为新聊天实现消息的进入动画。但对于已有聊天，其逻辑则完全不同：我们不再依赖 Reanimated 动画（例如 `useFirstMessageAnimation` 中所用的动画），而是采用 `scrollToEnd()` 的具体实现。

So all we need to do is scroll to end if we’re sending a message in an existing chat, right?

那么，只要我们在已有聊天中发送消息，就只需滚动到底部，对吧？

```tsx
useEffect(function onNewMessage() {

2  const didNewMessageSend = // ...some logic

3  if (didNewMessageSend) {

4    listRef.current?.scrollToEnd()
```

5  }

6}, ...)
```

The naive approach

朴素的方法

In a perfect world, this is all the logic we’d need. Let’s explore why it’s not enough.

在理想世界中，上述逻辑就已足够。接下来我们探讨它为何并不充分。

If you recall from the introduction, one of our requirements is that new messages have to scroll to the top of the screen. If we simply call `scrollToEnd()`, then the new messages will show at the bottom of the screen.

如果你回顾前文的介绍，就会想起我们的一个需求：新消息必须滚动至屏幕顶部显示。而如果我们直接调用 `scrollToEnd()`，新消息则会出现在屏幕底部。

![](images/how-we-built-the-v0-ios-app-vercel/img_001.jpg)![](images/how-we-built-the-v0-ios-app-vercel/img_002.jpg)

We needed a strategy to push the user message to the top of the chat. We referred to this as “blank size”: the distance between the bottom of the last assistant message, and the end of the chat.

我们需要一种策略，将用户消息“推”至聊天界面的顶部。我们将这一距离称为“空白尺寸（blank size）”：即最后一条助手消息底部与聊天区域底部之间的距离。

![](images/how-we-built-the-v0-ios-app-vercel/img_003.jpg)![](images/how-we-built-the-v0-ios-app-vercel/img_004.jpg)

To float the content to the top of the chat, we had to push it up by the amount equal to the blank size. Thanks to synchronous height measurements in React Native's New Architecture, this was possible to do on each frame without a flicker. But it still required a lot of trickery and coordination.

为使内容“悬浮”至聊天区域顶部，我们必须将其向上推动的距离恰好等于该空白尺寸。得益于 React Native 新架构中同步的高度测量能力，我们得以在每一帧中完成此操作，且无视觉闪烁。但即便如此，整个实现仍需大量精巧的技巧与协调工作。

In the image above, you’ll notice that the blank size is dynamic. Its height depends on the keyboard’s open state. And it can change on every render, since the assistant message streams in quickly and with unpredictable sizes.

在上方图示中，你可以注意到该空白尺寸是动态变化的：其高度取决于键盘的展开状态；并且每次渲染都可能发生变化——因为助手消息以较快的速度流式输出，且每条消息的尺寸难以预先确定。

动态高度是虚拟化列表中常见的挑战。而频繁更新的空白区域尺寸（blank size）则将这一挑战提升到了新的难度级别。我们的列表项具有动态且未知的高度，并且这些高度会频繁变化，同时我们还需要让它们自动浮动到顶部。

对于足够长的助手消息（assistant messages），空白区域尺寸可能为零，这又引入了一组全新的边界情况（edge cases）。

![](images/how-we-built-the-v0-ios-app-vercel/img_005.jpg)![](images/how-we-built-the-v0-ios-app-vercel/img_006.jpg)

## 我们如何解决该问题

我们尝试了多种不同的方式来实现空白区域尺寸：在 `ScrollView` 底部添加一个带固定高度的 `View`、为 `ScrollView` 本身设置底部内边距（bottom padding）、对可滚动内容使用 `translateY`、以及为最后一条系统消息设置最小高度。但所有这些方案最终都带来了奇怪的副作用和较差的性能表现——往往是因为 Yoga 布局引擎需要频繁重新计算布局。

最终，我们采用了一个基于 `ScrollView` 的 `contentInset` 属性的解决方案，从而在不引发抖动（jitters）的前提下处理空白区域尺寸。`contentInset` 直接映射到 UIKit 中 `UIScrollView` 的原生属性。

随后，我们在用户发送消息时，将 `contentInset` 与 `scrollToEnd({ offset })` 方法配合使用。

一条助手消息的空白区域尺寸，由其自身高度、其前一条用户消息（user message）的高度，以及整个聊天容器（chat container）的高度共同决定。

![](images/how-we-built-the-v0-ios-app-vercel/img_007.jpg)![](images/how-we-built-the-v0-ios-app-vercel/img_008.jpg)

### 实现 `useMessageBlankSize`

To implement blank size, we start with a hook called `useMessageBlankSize` in the assistant message:

要实现空白尺寸，我们从助手消息中一个名为 `useMessageBlankSize` 的 Hook 开始：

```tsx
function AssistantMessage({ message, index }) {

2  // ...styling logic

3  const { onLayout, ref } = useMessageBlankSize({ index })

4  return (

5    <Animated.View ref={ref} onLayout={onLayout}>

6      <AssistantMessageContent message={message} />

7    </Animated.View>

8  )

9}
```

`useMessageBlankSize` is responsible for the following logic:

`useMessageBlankSize` 负责以下逻辑：

1. Synchronously measure the assistant message

1. 同步测量助手消息（assistant message）

2. Measure the user message before it

2. 测量其前方的用户消息（user message）

3. Calculate the minimum distance for the blank size below the assistant message

3. 计算助手消息下方空白区域（blank size）所需的最小距离

4. Keep track of what the blank size should be when the keyboard is opened or closed

4. 跟踪键盘打开或关闭时空白区域（blank size）应设置为何值

5. Set the `blankSize` shared value at the root context provider

5. 在根级 Context Provider 中设置 `blankSize` 共享值（shared value）

Lastly, we consume `blankSize` and pass it to the `contentInset` of our `ScrollView`:

最后，我们消费 `blankSize`，并将其传入 `ScrollView` 的 `contentInset` 属性：

```tsx
export function MessagesList(props) {

2  const { blankSize, composerHeight, keyboardHeight } = useMessageListContext()
```

4  const animatedProps = useAnimatedProps(() => {

4  const animatedProps = useAnimatedProps(() => {

5    return {

5    返回 {

6      contentInset: {

6      contentInset: {

7        bottom: blankSize.get() + composerHeight.get() + keyboardHeight.get(),

7        bottom: blankSize.get() + composerHeight.get() + keyboardHeight.get(),

8      },

8      },

9    }

9    }

10  })

10  })



12  return <AnimatedLegendList {...props} animatedProps={animatedProps} />

12  返回 <AnimatedLegendList {...props} animatedProps={animatedProps} />

13}
```

Passing blankSize to contentInset

将 `blankSize` 传入 `contentInset`

`useAnimatedProps` from Reanimated lets us update props on the UI thread on each frame without triggering re-renders. `contentInset` saw great performance and worked far better than every previous attempt.

Reanimated 提供的 `useAnimatedProps` 允许我们在每一帧于 UI 线程上直接更新组件属性，而无需触发重新渲染。`contentInset` 方案性能表现优异，效果远超此前所有尝试。

## Taming the keyboard

## 驾驭键盘

Building a good chat experience hinges on elegant keyboard handling. Achieving [native feel](https://x.com/fernandorojo/status/1857403323738927329) in this area was tedious and challenging with React Native. When v0 iOS was in public beta, Apple released iOS 26. Every time a new iOS beta version came out, our chat seemingly broke entirely. Each iOS release turned into a game of cat-and-mouse of reproducing tiny discrepancies and jitters.

构建出色的聊天体验，关键在于优雅的键盘交互处理。在 React Native 中实现该领域的 [原生手感](https://x.com/fernandorojo/status/1857403323738927329) 曾是一项繁琐且极具挑战性的任务。当 v0 的 iOS 版本处于公开测试阶段时，恰逢 Apple 发布 iOS 26。每次 Apple 推出新的 iOS 测试版，我们的聊天界面几乎都会完全失常。每一次 iOS 更新都演变成一场“猫鼠游戏”：我们不得不反复复现那些细微的偏差与抖动现象。

Luckily, [Kiryl](https://github.com/kirillzyusko), the maintainer of `react-native-keyboard-controller`, helped us address these issues, often updating the library within 24 hours of Apple releasing a new beta.

幸运的是，`react-native-keyboard-controller` 的维护者 [Kiryl](https://github.com/kirillzyusko) 协助我们解决了这些问题——Apple 每次发布新测试版后，他往往能在 24 小时内同步更新该库。

### **Building** **`useKeyboardAwareMessageList`**

### **构建** **`useKeyboardAwareMessageList`**

We used many of the hooks provided by React Native Keyboard Controller to build our own keyboard management system tailored to v0’s chat.

我们充分利用了 React Native Keyboard Controller 提供的多个 Hook，构建了一套专为 v0 聊天场景定制的键盘管理系统。

`useKeyboardAwareMessageList` is our custom React hook responsible for all of our keyboard handling logic. We render it alongside our chat list, and it abstracts away everything we need to make the keyboard feel right.

`useKeyboardAwareMessageList` 是我们自研的 React Hook，承载全部键盘交互逻辑。它与聊天消息列表一同渲染，并将所有使键盘行为“恰到好处”所需的细节尽数封装、隐藏。

```tsx
function MessagesList() {

2  useKeyboardAwareMessageList()
```

4  // ……消息列表其余部分

5}
```

使用 `useKeyboardAwareMessageList`

虽然调用该 Hook 仅需一行代码，但其内部实现约有 1,000 行代码，并配有大量单元测试。`useKeyboardAwareMessageList` 主要依赖上游的 `useKeyboardHandler`，用于处理 `onStart`、`onEnd` 和 `onInteractive` 等事件，同时结合多个 Reanimated 的 `useAnimatedReaction` 调用，在特定边界情况下重试事件。

`useKeyboardAwareMessageList` 还专门处理了 iOS 上若干异常行为。例如：当键盘处于打开状态时将应用切至后台，随后再重新聚焦该应用，iOS 会毫无缘由地连续触发三次键盘 `onEnd` 事件。由于我们此前依赖事件触发时的命令式逻辑，因此不得不设计一些技巧来去重重复事件，并追踪应用状态的变化。

`useKeyboardAwareMessageList` 实现了以下功能：

1. 键盘弹出时缩小 `blankSize`；

2. 若聊天列表已滚动至底部且 `blankSize` 为零，则在键盘弹出时将内容整体上移；

3. 若用户已向上滚动足够远，且 `blankSize` 为零，则让键盘直接覆盖在内容上方，而不移动内容本身。

4. When the user interactively dismisses the keyboard via the scroll view or text input, drag it down smoothly

4. 当用户通过滚动视图或文本输入框以交互方式收起键盘时，应平滑地将键盘向下拖动。

5. If you’re scrolled to the end of the chat, and the blank size is bigger than the keyboard, the content should stay in place

5. 如果你已滚动至聊天末尾，且空白区域高度大于键盘高度，则内容应保持原位不动。

6. If you’re scrolled to the end of the chat and the blank size is greater than zero, but it should be zero when the keyboard is open, shift content up so that it lands above the keyboard

6. 如果你已滚动至聊天末尾，且当前空白区域高度大于零（但键盘展开时该空白高度本应为零），则需将内容整体上移，使其最终停驻在键盘上方。

There was no single trick to get this all working. We spent dozens of hours using the app, noticing imperfections, tracing issues, and rewriting the logic until it felt right.

实现上述全部行为并无单一“技巧”。我们花费了数十小时反复使用该应用，观察各种细微瑕疵，追踪问题根源，并不断重写逻辑，直至整体体验自然流畅。

## Scrolling to end initially

## 初始加载时自动滚动到底部

When you open an existing chat, v0 starts the chat scrolled to end. This is similar to using the `inverted` prop on React Native’s `FlatList`, which is common for bottom-to-top chat interfaces.

当你打开一个已有聊天会话时，v0 默认将聊天列表滚动至底部。这一行为类似于在 React Native 的 `FlatList` 中启用 `inverted` 属性，这在自底向上排列消息的聊天界面中十分常见。

However, we decided not to use `inverted` since it felt incompatible with an AI chat where messages stream in multiple times per second. We opted not to autoscroll as the assistant message streams. Instead, we let the content fill in naturally under the keyboard, together with a button to scroll to the end. This follows the same behavior as ChatGPT’s iOS app.

然而，我们最终决定不采用 `inverted` 方案，因为它与 AI 聊天场景存在兼容性问题——AI 助手的消息往往每秒多次流式输出。我们选择不在助手消息持续流式到达时自动滚动；相反，我们让新内容自然地在键盘下方逐步填充，并额外提供一个“滚动到底部”按钮。该设计与 ChatGPT 的 iOS 应用行为完全一致。

That said, we wanted an inverted-list-style experience when you first opened an existing chat. To make this work, we call `scrollToEnd` when a chat first becomes visible.

尽管如此，我们仍希望用户首次打开已有聊天会话时，能获得类似倒序列表的视觉体验。为此，我们在聊天界面首次变为可见时调用 `scrollToEnd`。

Due to a complex combination of dynamic message heights and blank size, we had to call `scrollToEnd` multiple times. If we didn’t, our list would either not scroll properly, or scroll too late. Once the content has scrolled, we call `hasScrolledToEnd.set(true)` to fade in the chat.

由于消息高度动态变化、空白区域尺寸复杂多变，我们必须多次调用 `scrollToEnd`。若仅调用一次，列表可能无法正确滚动，或滚动时机过晚。一旦内容完成滚动，我们即调用 `hasScrolledToEnd.set(true)`，使聊天界面渐显呈现。

```tsx
import { scheduleOnRN } from 'react-native-worklets'
```

```javascript
export function useInitialScrollToEnd(blankSize, scrollToEnd, hasMessages) {

export function useInitialScrollToEnd(blankSize, scrollToEnd, hasMessages) {

4  const hasStartedScrolledToEnd = useSharedValue(false)

4  const hasStartedScrolledToEnd = useSharedValue(false)

5  const hasScrolledToEnd = useSharedValue(false)

5  const hasScrolledToEnd = useSharedValue(false)

6  const scrollToEndJS = useLatestCallback(() => {

6  const scrollToEndJS = useLatestCallback(() => {

7    scrollToEnd({ animated: false })

7    scrollToEnd({ animated: false })

8    // Do another one just in case because the list may not have fully laid out yet

8    // 再执行一次，以防列表尚未完全完成布局

9    requestAnimationFrame(() => {

9    requestAnimationFrame(() => {

10      scrollToEnd({ animated: false })

10      scrollToEnd({ animated: false })
```

12      // and another one again in case

12      // 再来一次，以防万一

13      setTimeout(() => {

13      setTimeout(() => {

14        scrollToEnd({ animated: false })

14        scrollToEnd({ animated: false })



16        // and yet another!

16        // 还有再一次！

17        requestAnimationFrame(() => {

17        requestAnimationFrame(() => {

18          hasScrolledToEnd.set(true)

18          hasScrolledToEnd.set(true)

19        })

19        })

20      }, 16)

20      }, 16)

21    })

21    })

22  })

22  })

24  useAnimatedReaction(

24  useAnimatedReaction(

25    () => {

25    () => {

26      if (hasStartedScrolledToEnd.get() || !hasMessages) {

26      如果 hasStartedScrolledToEnd.get() 为真，或 hasMessages 为假：

27        return false

27        返回 false

28      }

28      }

29      return blankSize.get() > 0

29      返回 blankSize.get() > 0

30    },

30    },

31    (shouldScroll) => {  

31    (shouldScroll) => {

32      if (shouldScroll) {

32      如果需要滚动：

33        hasStartedScrolledToEnd.set(true)

33        hasStartedScrolledToEnd.set(true)

34        scheduleOnRN(scrollToEndJS)

34        scheduleOnRN(scrollToEndJS)

35      }

35      }

36    }

36    }

37  )

37  )



39  return hasScrolledToEnd

39  return hasScrolledToEnd

40}
40}

```

Calling scrollToEnd multiple times to handle dynamic heights

```

为处理动态高度而多次调用 scrollToEnd

## Floating composer

## 悬浮式输入框

Inspired by iMessage’s bottom toolbar in iOS 26, we built a Liquid Glass composer with a progressive blur.

受 iOS 26 中 iMessage 底部工具栏的启发，我们构建了一个具备渐进式模糊效果的 Liquid Glass 输入框。

We used `@callstack/liquid-glass` to add interactive Liquid Glass. By wrapping the glass views with `LiquidGlassContainerView`, we automatically get the view morphing effect.

我们使用 `@callstack/liquid-glass` 添加了可交互的 Liquid Glass 效果。通过将玻璃视图包裹在 `LiquidGlassContainerView` 中，即可自动获得视图形变（morphing）效果。

```tsx
1<LiquidGlassContainerView spacing={8}>

2  <LiquidGlassView interactive>...</LiquidGlassView>

3  <LiquidGlassView interactive>...</LiquidGlassView>

4</LiquidGlassContainerView>
```

```tsx
1<LiquidGlassContainerView spacing={8}>

2  <LiquidGlassView interactive>...</LiquidGlassView>

3  <LiquidGlassView interactive>...</LiquidGlassView>

4</LiquidGlassContainerView>
```

Adding Liquid Glass to the composer

为输入框添加 Liquid Glass 效果

### Make it float

### 让它悬浮起来

After adding the Liquid Glass, the next step was making it float on top of the chat content.

添加完 Liquid Glass 后，下一步是让它悬浮于聊天内容之上。

In order to make the composer float on top of the scrollable content, we took the following steps:

为了使输入框（composer）悬浮在可滚动内容的顶部，我们采取了以下步骤：

1. Add `position: absolute; bottom: 0` to the composer

1. 为输入框添加 `position: absolute; bottom: 0` 样式。

2. Wrap the composer in `KeyboardStickyView` from `react-native-keyboard-controller`

2. 使用 `react-native-keyboard-controller` 提供的 `KeyboardStickyView` 包裹输入框。

3. Synchronously measure the composer, and store its height in context using a shared value

3. 同步测量输入框的高度，并通过共享值（shared value）将其高度存储在上下文中。

4. Add the `composerHeight.get()` to our ScrollView’s native `contentInset.bottom` property

4. 将 `composerHeight.get()` 的值添加到 `ScrollView` 原生的 `contentInset.bottom` 属性中。

```tsx
function Composer() {

2  const { composerHeight } = useComposerHeightContext()

3  const { onLayout, ref } = useSyncLayoutHandler((layout) => {

4    composerHeight.set(layout.height)

5  })
```

6  const insets = useInsets()

6  const insets = useInsets()

8  return (

8  返回（

9    <KeyboardStickyView

9    <KeyboardStickyView>

10      style=&#123;{ position: 'absolute', bottom: 0, left: 0, right: 0 }}

10      样式=&#123;{ position: 'absolute', bottom: 0, left: 0, right: 0 }}

11      offset=&#123;{ closed: -insets.bottom, opened: -8 }}

11      offset=&#123;{ closed: -insets.bottom, opened: -8 }}

12    >

12    >

13      <View

13      <View>

14        ref={ref}

14        ref={ref}

15        onLayout={onLayout}

15        onLayout={onLayout}

16      >

17        {/* ... */}

18      </View>

19    </KeyboardStickyView>

20  )

21}
```

Positioning the composer with KeyboardStickyView

使用 KeyboardStickyView 定位输入框（composer）

However, this was not enough. We are still missing one key behavior.

然而，仅此还不够。我们仍缺少一个关键行为。

As you type, the text input’s height can increase. When you type new lines, we want to simulate the experience of typing in a regular, non-absolute-positioned input. We had to find a way to shift the chat messages upwards, but only if you are scrolled to the end of the chat.

随着用户输入，文本输入框的高度可能增加。当用户输入换行符时，我们希望模拟在普通（非绝对定位）输入框中打字的体验。我们必须找到一种方法，将聊天消息整体向上移动——但仅当用户已滚动至聊天记录底部时才执行该操作。

In the video below, you can see both cases. At the start of the video, content shifts up with new lines since the chat is scrolled to the end. However, after scrolling up in the chat, typing new lines will not shift the content.

在下方视频中，您可以看到这两种情形：视频开始时，由于聊天窗口已滚动至底部，输入新行会导致内容整体上移；但当用户向上滚动聊天记录后，再输入新行则不会引起内容位移。

### `useScrollWhenComposerSizeUpdates`

### `useScrollWhenComposerSizeUpdates`

Enter `useScrollWhenComposerSizeUpdates`. This hook listens to the height of the composer and automatically scrolls to end when needed. To consume it, we simply call it in `MessagesList`:

```tsx
export function MessagesList() {

2  useScrollWhenComposerSizeUpdates()



4  // ...message list code

5}
```

在 `MessagesList` 中使用 `useScrollWhenComposerSizeUpdates`

首先，它使用 `useAnimatedReaction` 设置一个副作用，用于监听 composer 高度的变化。

接着，我们调用 `autoscrollToEnd`。只要当前滚动位置足够接近可滚动区域的底部，系统便会自动将视图滚动至聊天消息的末尾。若不启用此功能，当在 composer 中输入换行时，新内容将与可滚动区域的底部发生重叠。

`useScrollWhenComposerSizeUpdates` lets us conditionally simulate the experience of a view that is not absolute-positioned.

`useScrollWhenComposerSizeUpdates` 允许我们有条件地模拟一个非绝对定位视图的体验。

```tsx
export function useScrollWhenComposerSizeUpdates() {

2  const { listRef, scrollToEnd } = useMessageListContext()

3  const { composerHeight } = useComposerHeightContext()



5  const autoscrollToEnd = () => {

6    const list = listRef.current

7    if (!list) {

8      return

9    }

11    const state = list.getState()

11    const state = list.getState()

12    const distanceFromEnd =

12    const distanceFromEnd =

13      state.contentLength - state.scroll - state.scrollLength

13      state.contentLength - state.scroll - state.scrollLength

15    if (distanceFromEnd < 0) {

15    if (distanceFromEnd < 0) {

16      scrollToEnd({ animated: false })

16      scrollToEnd({ animated: false })

17      // wait a frame for LegendList to update, and fire it again

17      // 等待一帧，待 LegendList 完成更新后，再次触发该操作

18      setTimeout(() => {

18      setTimeout(() => {

19        scrollToEnd({ animated: false })

19        scrollToEnd({ animated: false })

20      }, 16)

20      }, 16)

21    }

21    }

22  }

22  }

24  useAnimatedReaction(

24  useAnimatedReaction（

25    () => composerHeight.get(),

25    () => composerHeight.get(),

26    (height, prevHeight) => {

26    (height, prevHeight) => {

27      if (height > 0 && height !== prevHeight) {

27      如果 height > 0 且 height 不等于 prevHeight，则：

28        scheduleOnRN(autoscrollToEnd)

28        scheduleOnRN(autoscrollToEnd)

29      }

29      }

30    }

30    }

31  )

31  )

32}
```

32}
```

Scrolling to end when the composer grows

输入框高度增加时自动滚动到底部

As we saw in earlier code, we unfortunately relied on a number of `setTimeout` and `requestAnimationFrame` calls to `scrollToEnd`. That code will understandably raise eyebrows, but it was the only way we managed to get scrolling to end working properly. We’re actively collaborating with [Jay](https://github.com/jmeistrich), the maintainer of LegendList, to build a more reliable approach.

如前文代码所示，我们无奈地依赖了多个 `setTimeout` 和 `requestAnimationFrame` 调用来触发 `scrollToEnd`。这段代码难免令人皱眉，但却是当时唯一能让“滚动到底部”功能正常工作的办法。目前，我们正积极与 LegendList 的维护者 [Jay](https://github.com/jmeistrich) 协作，共同开发一种更可靠、更稳健的实现方案。

### Make it feel native

### 让体验更贴近原生

React Native’s built-in `TextInput` felt out of place in a native chat app.

React Native 内置的 `TextInput` 组件在原生聊天应用中显得格格不入。

By default, when you set `multiline={true}`, the `TextInput` shows ugly scroll indicators, which is inconsistent with most chat apps. Swiping up and down on the input will bounce its internal content, even if you haven’t typed any text yet. Additionally, the input doesn't support interactive keyboard dismissal.

默认情况下，当设置 `multiline={true}` 时，`TextInput` 会显示丑陋的滚动指示器，这与绝大多数聊天应用的设计风格不一致。此外，即使尚未输入任何文字，上下滑动输入框也会导致其内部内容发生弹性回弹（bounce）；同时，该输入框也不支持通过交互方式收起键盘（interactive keyboard dismissal）。

To fix these issues, we applied a patch to `RCTUITextView` in native code. This patch disables scroll indicators, removes bounce effects, and enables interactive keyboard dismissal.

为解决上述问题，我们在原生代码中对 `RCTUITextView` 应用了补丁：禁用滚动指示器、移除弹性回弹效果，并启用交互式键盘收起功能。

Our patch also adds support for swiping up to focus the input. We realized we needed this after watching testers frustratingly swipe up expecting the keyboard to open.

我们的补丁还新增了“上滑聚焦输入框”的支持。这一需求是在观察测试人员反复上滑却苦等键盘弹出、倍感挫败后才意识到的。

```bash
diff --git a/Libraries/Text/TextInput/Multiline/RCTUITextView.mm b/Libraries/Text/TextInput/Multiline/RCTUITextView.mm

index 6e9c3841cee19632eaa59ae2dbd541a85ce7cabf..e3f920acbc2bb074582ed2b531ddd90e2017d59c 100644

3--- a/Libraries/Text/TextInput/Multiline/RCTUITextView.mm

4+++ b/Libraries/Text/TextInput/Multiline/RCTUITextView.mm

5@@ -55,6 +55,16 @@ - (instancetype)initWithFrame:(CGRect)frame

6     self.textContainer.lineFragmentPadding = 0;

7     self.scrollsToTop = NO;

8     self.scrollEnabled = YES;

9+

10+    // Fix bouncing, scroll indicator, and keyboard mode gesture

3--- a/Libraries/Text/TextInput/Multiline/RCTUITextView.mm

4+++ b/Libraries/Text/TextInput/Multiline/RCTUITextView.mm

5@@ -55,6 +55,16 @@ - (instancetype)initWithFrame:(CGRect)frame

6     self.textContainer.lineFragmentPadding = 0;

7     self.scrollsToTop = NO;

8     self.scrollEnabled = YES;

9+

10+    // 修复回弹、滚动指示器以及键盘模式下的手势行为
```

11+    self.showsVerticalScrollIndicator = NO;

11+    self.showsVerticalScrollIndicator = NO;

12+    self.showsHorizontalScrollIndicator = NO;

12+    self.showsHorizontalScrollIndicator = NO;

13+    self.bounces = NO;

13+    self.bounces = NO;

14+    self.alwaysBounceVertical = NO;

14+    self.alwaysBounceVertical = NO;

15+    self.alwaysBounceHorizontal = NO;

15+    self.alwaysBounceHorizontal = NO;

16+    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;

16+    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;

17+    [self.panGestureRecognizer addTarget:self action:@selector(_handlePanToFocus:)];

17+    [self.panGestureRecognizer addTarget:self action:@selector(_handlePanToFocus:)];

18+

18+

19     _initialValueLeadingBarButtonGroups = nil;

19     _initialValueLeadingBarButtonGroups = nil;

20     _initialValueTrailingBarButtonGroups = nil;

20     _initialValueTrailingBarButtonGroups = nil;

21   }

21   }

22@@ -62,6 +72,18 @@ - (instancetype)initWithFrame:(CGRect)frame

22@@ -62,6 +72,18 @@ - (instancetype)initWithFrame:(CGRect)frame

23   return self;

23   return self;

24 }



24 }



26+- (void)_handlePanToFocus:(UIPanGestureRecognizer *)g

26+– (void)_handlePanToFocus:(UIPanGestureRecognizer *)g

27+{

27+{

28+    if (self.isFirstResponder) { return; }

28+    如果当前视图已是第一响应者，则直接返回；

29+    if (g.state != UIGestureRecognizerStateBegan) { return; }

29+    如果手势识别器的状态不是 `UIGestureRecognizerStateBegan`，则直接返回；

30+    CGPoint v = [g velocityInView:self];

30+    CGPoint v = [g velocityInView:self];

31+    CGPoint t = [g translationInView:self];

31+    CGPoint t = [g translationInView:self];

32+    // Add pan gesture to focus the keyboard

32+    // 添加拖动手势以聚焦键盘

33+    if (v.y < -250.0 && !self.isFirstResponder) {

33+    if (v.y < -250.0 && !self.isFirstResponder) {

34+        [self becomeFirstResponder];

34+        [self becomeFirstResponder];

35+    }

35+    }

36+}

36+}

37+

37+

38 - (void)setDelegate:(id<UITextViewDelegate>)delegate

38 - (void)setDelegate:(id<UITextViewDelegate>)delegate

39 {

39 {

40   // Delegate is set inside `[RCTBackedTextViewDelegateAdapter initWithTextView]` and

40   // 代理对象在 `[RCTBackedTextViewDelegateAdapter initWithTextView]` 内部设置，且

While maintaining a patch across React Native updates is not ideal, it was the most practical solution we found. We would have preferred an official API for extending native views without patching, and we plan on contributing this patch to React Native core if there is community interest.

虽然在 React Native 版本更新过程中持续维护补丁并非理想方案，但这是我们找到的最切实可行的解决方案。我们更希望官方能提供一套无需打补丁即可扩展原生视图的 API；若社区对此有需求，我们计划将该补丁贡献至 React Native 核心。

## Pasting images

## 粘贴图片

To support pasting images and files in the text input, we used an Expo Module that listens to paste events from the native `UIPasteboard`.

为支持在文本输入框中粘贴图片和文件，我们使用了一个 Expo 模块，该模块监听来自原生 `UIPasteboard` 的粘贴事件。

If you paste long enough text, `onPaste` will automatically turn the pasted content into a `.txt` file attachment.

若粘贴的文本足够长，`onPaste` 回调会自动将粘贴内容转换为一个 `.txt` 文件附件。

```tsx
1<TextInputWrapper onPaste={pasted => ...}>

2  <TextInput />

3</TextInputWrapper>
```

```tsx
1<TextInputWrapper onPaste={pasted => ...}>

2  <TextInput />

3</TextInputWrapper>
```

Wrapping TextInput to handle paste events

通过封装 TextInput 来处理粘贴事件

Since it was difficult to extend the existing `TextInput` in native code, we use a `TextInputWrapper` component which wraps `TextInput` and traverses its `subviews` in Swift. For more in-depth examples of creating native wrapper components, you can watch my 2024 talk, [“Don’t be afraid to build a native library”](https://youtu.be/mG1Lv-RWds8?si=UCSHQQAnfsYGdr4P).

由于在原生代码中直接扩展现有的 `TextInput` 较为困难，我们采用了一个 `TextInputWrapper` 组件——它包裹 `TextInput`，并在 Swift 中遍历其 `subviews`。如需深入了解如何创建原生封装组件，欢迎观看我在 2024 年的演讲：[《别害怕构建原生库》](https://youtu.be/mG1Lv-RWds8?si=UCSHQQAnfsYGdr4P)。

## Fading in streaming content

## 流式内容的淡入效果

When an AI’s assistant message streams in, it needs to feel smooth. To achieve this, we created two components:

当 AI 助理的消息以流式方式输入时，其呈现效果需要显得流畅自然。为实现这一目标，我们开发了两个组件：

1. `<FadeInStaggeredIfStreaming />`

1. `<FadeInStaggeredIfStreaming />`

2. `<TextFadeInStaggeredIfStreaming />`

2. `<TextFadeInStaggeredIfStreaming />`

As long as an element gets wrapped by one of these components, its children will smoothly fade in with a staggered animation.

只要某个元素被这两个组件中的任意一个所包裹，其子元素便会以错落有致的渐显动画形式平滑地逐个呈现。

```tsx
const mdxComponents = {

2  a: function A(props) {

3    return (

4      <Elements.A {...props}>

5        <TextFadeInStaggeredIfStreaming>

6          {props.children}

7        </TextFadeInStaggeredIfStreaming>

7        </TextFadeInStaggeredIfStreaming>

8      </Elements.A>

8      </Elements.A>

9    )

9    )

10  },

10  },

11  // ...other components

11  // ……其他组件

12}
```

12}
```

Using TextFadeInStaggeredIfStreaming in MDX components

在 MDX 组件中使用 TextFadeInStaggeredIfStreaming

Under the hood, these components render a variation of `FadeInStaggered`, which handles the state management:

其底层实现是渲染 `FadeInStaggered` 的一种变体，该变体负责状态管理：

```tsx
const useIsAnimatedInPool = createUsePool()
```

```tsx
const useIsAnimatedInPool = createUsePool()
```

```tsx
function FadeInStaggered({ children }) {

4  const { isActive, evict } = useIsAnimatedInPool()

5  return isActive ? <FadeIn onFadedIn={evict}>{children}</FadeIn> : children

6}
```

```tsx
function FadeInStaggered({ children }) {

4  const { isActive, evict } = useIsAnimatedInPool()

5  return isActive ? <FadeIn onFadedIn={evict}>{children}</FadeIn> : children

6}
```

Managing animation state with a pool

使用池管理动画状态

`useIsAnimatedInPool` is a custom state manager outside of React that allows a limited number of ordered elements to get rendered at once. Elements request to join the pool when they mount, and `isActive` indicates if they should render an animated node.

`useIsAnimatedInPool` 是一个位于 React 之外的自定义状态管理器，它允许一次仅渲染有限数量的、按顺序排列的元素。元素在挂载时请求加入该池，而 `isActive` 则指示其是否应渲染一个带动画效果的节点。

After the `onFadedIn` callback fires, we evict the element from the pool, rendering its children directly without the animated wrapper. This helps us limit the number of animated nodes that are active at once.

当 `onFadedIn` 回调触发后，我们将该元素从池中移出（evict），使其子元素直接渲染，不再包裹于动画组件中。这有助于限制同时处于激活状态的动画节点数量。

Lastly, `FadeIn` renders a staggered animation with a delay of 32 milliseconds between elements. The staggered animations run on a schedule, animating a batch of 2 items at a time. When the queue of staggered items becomes higher than 10, we increase the number of batched items according to the size of the queue.

最后，`FadeIn` 渲染一个交错式（staggered）动画，元素之间的延迟为 32 毫秒。这些交错动画按预定时间表运行，每次对 2 个元素进行批量动画处理。当交错动画队列中的待处理项超过 10 个时，我们将根据队列大小动态增加每批动画处理的元素数量。

```tsx
const useStaggeredAnimation = createUseStaggered(32)
```

```tsx
const useStaggeredAnimation = createUseStaggered(32)
```

```javascript
function FadeIn({ children, onFadedIn, Component }) {

4  const opacity = useSharedValue(0)

函数 FadeIn（{ children, onFadedIn, Component }）{

4  const opacity = useSharedValue(0)

6  const startAnimation = () => {

7    opacity.set(withTiming(1, { duration: 500 }))

8    setTimeout(onFadedIn, 500)

9  }

6  const startAnimation = () => {

7    opacity.set(withTiming(1, { duration: 500 }))

8    setTimeout(onFadedIn, 500)

9  }

11  useStaggeredAnimation(startAnimation)

11  useStaggeredAnimation(startAnimation)
```

13  return <Component style=&#123;{ opacity }}>{children}</Component>

13  返回 `<Component style=&#123;{ opacity }}>{children}</Component>`。

14}
```

14}
```

Staggered fade animation

交错淡入动画

`TextFadeInStaggeredIfStreaming` uses a similar strategy. We first chunk words into individual text nodes, then we create a unique pool for text elements with a limit of 4. This ensures that no more than 4 words will fade in at a time.

`TextFadeInStaggeredIfStreaming` 采用类似的策略：我们首先将单词切分为独立的文本节点，然后为文本元素创建一个容量上限为 4 的专属资源池。这确保了任意时刻最多只有 4 个单词执行淡入动画。

```tsx
const useShouldTextFadePool = createUsePool(4)



function TextFadeInStaggeredIfStreaming(props) {

4  const { isStreaming } = use(MessageContext)

5  const { isActive } = useShouldTextFadePool()

```tsx
const useShouldTextFadePool = createUsePool(4)



function TextFadeInStaggeredIfStreaming(props) {

4  const { isStreaming } = use(MessageContext)

5  const { isActive } = useShouldTextFadePool()

7  const [shouldFade] = useState(isActive && isStreaming)

7  const [shouldFade] = useState(isActive && isStreaming)

9  let { children } = props

9  let { children } = props

10  if (shouldFade && children) {

10  如果 shouldFade 为真且 children 存在：

11    if (Array.isArray(children)) {

11    如果 children 是一个数组：

12      children = Children.map(children, (child, i) =>

12      children = Children.map(children, (child, i) =>

13        typeof child === 'string' ? <AnimatedFadeInText key={i} text={child} /> : child,

13        typeof child === 'string' ? <AnimatedFadeInText key={i} text={child} /> : child,

14      )

14      )

15    } else if (typeof children === 'string') {

15    } else if (typeof children === 'string') {

16      children = <AnimatedFadeInText text={children} />

16      children = <AnimatedFadeInText text={children} />

17    }

17    }

18  }

18  }

20  return children

20  返回 children

21}

21}

function AnimatedFadeInText({ text }) {

function AnimatedFadeInText({ text }) {

24  const chunks = text.split(' ')

24  const chunks = text.split(' ')

26  return chunks.map((chunk, i) => <TextFadeInStaggered key={i} text={chunk + ' '} />)

26  return chunks.map((chunk, i) => <TextFadeInStaggered key={i} text={chunk + ' '} />)

27}



function TextFadeInStaggered({ text }) {

27}



函数 TextFadeInStaggered（{ text }）{

30  const { isActive, evict } = useIsAnimatedInPool()

30  const { isActive, evict } = useIsAnimatedInPool()

31  return isActive ? <FadeIn onFadedIn={evict}>{text}</FadeIn> : text

31  return isActive ? <FadeIn onFadedIn={evict}>{text}</FadeIn> : text

32}
```

32}
```

Chunking text and limiting concurrent animations

文本分块与并发动画限制

One issue we faced with this approach is that it relies heavily on firing animations _on mount_. As a result, if you send a message, go to another chat, and then come back to the original chat before the message is done sending, it will remount and animate once again.

该方案面临的一个问题是，它高度依赖于组件“挂载时（on mount）”触发动画。因此，如果你发送一条消息后切换到另一个聊天窗口，又在该消息尚未发送完成前返回原始聊天窗口，该消息组件将重新挂载，并再次触发动画。

To mitigate this, we implemented a system that keeps track of which content you've already seen animate across chats. The implementation uses a `DisableFadeProvider` towards the top of the message in the tree. We consume it in the root fade component to avoid affecting the pool if needed.

为缓解此问题，我们实现了一套机制，用于跨聊天会话追踪用户已观看过动画的内容。该机制在消息组件树的顶部附近使用 `DisableFadeProvider`。我们在根级淡入（fade）组件中消费该 Provider，以便在必要时避免影响动画池（animation pool）。

```tsx
function TextFadeInStaggeredIfStreaming(props) {
```

```tsx
function TextFadeInStaggeredIfStreaming(props) {
```

2  const { isStreaming } = use(MessageContext)

2  const { isStreaming } = use(MessageContext)

3  const { isActive } = useShouldTextFadePool()

3  const { isActive } = useShouldTextFadePool()

4  const isFadeDisabled = useDisableFadeContext()

4  const isFadeDisabled = useDisableFadeContext()

6  const [shouldFade] = useState(!isFadeDisabled && isActive && isStreaming)

6  const [shouldFade] = useState(!isFadeDisabled && isActive && isStreaming)

8  if (shouldFade) // here we render TextFadeIn...

8  if (shouldFade) // 此处我们渲染 TextFadeIn...

10  return props.children

10  return props.children

11}
```

Disabling fade for already-seen content

禁用已呈现内容的淡入淡出效果

While it might look unusual to explicitly rely on `useState`'s initial value in a non-reactive way, this let us reliably track elements and their animation states based on their mount order.

虽然显式地以非响应式方式依赖 `useState` 的初始值看起来有些非常规，但这使我们能够可靠地根据元素的挂载顺序来追踪元素及其动画状态。

## Sharing code between web and native

## 在 Web 与原生平台之间共享代码

When we started building the v0 iOS app, a natural question arose: how much code should we share between web and native?

在开始构建 v0 iOS 应用时，一个自然的问题随之浮现：Web 与原生平台之间应共享多少代码？

Given how mature the v0 web monorepo was, we decided to share types and helper functions, but not UI or state management. We also made a concerted effort to migrate business logic from client to server, letting the v0 mobile app be a thin wrapper over the API.

鉴于 v0 Web 单体仓库已相当成熟，我们决定共享类型定义（types）和辅助函数（helper functions），但不共享 UI 组件或状态管理逻辑。此外，我们还积极将业务逻辑从客户端迁移至服务端，从而使 v0 移动端应用成为一套轻量级的 API 封装层。

### Building a shared API

### 构建共享的 API 层

Sharing the backend API routes between a mature Next.js app and a new mobile app introduced challenges. The v0 web app is powered by React Server Components and Server Actions, while the mobile app functions more like a single-page React app.

在成熟的 Next.js 应用与全新的移动应用之间共享后端 API 路由带来了若干挑战：v0 Web 应用基于 React Server Components 和 Server Actions 构建，而移动应用则更接近于一个单页式 React 应用。

To address this, we built an API layer using a hand-rolled backend framework. Our framework enforces runtime type safety by requiring input and output types specified with [Zod](https://zod.dev/).

为应对这一挑战，我们基于自研的后端框架构建了一套 API 层。该框架通过强制要求使用 [Zod](https://zod.dev/) 明确声明输入与输出类型，从而保障运行时的类型安全。

After defining the routes, we generate an [openapi.json file](https://api.v0.dev/v1/openapi.json) based on each route’s Zod types. The mobile app consumes the OpenAPI spec using [Hey API](https://heyapi.dev/), which generates helper functions to use with [Tanstack Query](https://tanstack.com/query/latest).

完成路由定义后，我们依据各路由所声明的 Zod 类型，自动生成一份 [openapi.json 文件](https://api.v0.dev/v1/openapi.json)。移动端应用借助 [Hey API](https://heyapi.dev/) 消费该 OpenAPI 规范，并由此生成一系列辅助函数，供 [Tanstack Query](https://tanstack.com/query/latest) 调用。

```tsx
import { termsFindOptions } from '@/api' // this folder is generated

import { termsFindOptions } from '@/api' // 此文件夹为自动生成
```

```javascript
import { useQuery } from '@tanstack/react-query'



export function useTermsQuery({ after }) {

5  return useQuery(termsFindOptions({ after }))

6}
```

```javascript
import { useQuery } from '@tanstack/react-query'



export function useTermsQuery({ after }) {

5  返回 useQuery(termsFindOptions({ after }))

6}
```

Generated API helpers with Tanstack Query

使用 Tanstack Query 生成的 API 辅助函数

This effort led to the development of the [v0 Platform API](https://v0.app/docs/api/platform/quickstart). We wanted to build the ideal API for our own native client, and we ultimately decided to make that same API available to everyone. Thanks to this approach, v0 mobile uses the same routes and logic as v0’s Platform API customers.

这一努力促成了 [v0 平台 API](https://v0.app/docs/api/platform/quickstart) 的开发。我们最初的目标是为自家原生客户端构建最理想的 API，最终我们决定将该 API 向所有开发者开放。得益于此，v0 移动端应用与所有使用 v0 平台 API 的客户共享完全相同的路由和业务逻辑。

On each commit, we run tests to ensure that changes to our OpenAPI spec are compatible with the mobile app.

每次提交代码时，我们都会运行测试，以确保 OpenAPI 规范的变更与移动应用保持兼容。

In the future, we hope to eliminate the code generation step entirely with a type-level RPC wrapper around the Platform API.

未来，我们希望借助一个基于类型的、围绕平台 API 构建的 RPC 封装层，彻底消除代码生成环节。

## Styling

## 样式处理

v0 uses `react-native-unistyles` for styles and theming. My experience with React Native has taught me to be cautious of any work done in render. Unlike other styling libraries we evaluated, Unistyles provides comprehensive theming without re-rendering components or accessing React Context.

v0 使用 `react-native-unistyles` 进行样式定义与主题管理。我在 React Native 开发中的经验让我深知：应谨慎对待任何在渲染（render）过程中执行的操作。与其他我们评估过的样式库不同，Unistyles 在不触发组件重渲染、也不依赖 React Context 的前提下，提供了完备的主题支持。

## Native menus

## 原生菜单

Beyond Unistyles for themes and styles, we did not use a JS-based component library. Instead, we relied on native elements where possible.

除使用 Unistyles 管理主题与样式外，我们未采用任何基于 JavaScript 的组件库；相反，在可行的情况下，我们优先使用原生 UI 元素。

For menus, we used [Zeego](https://zeego.dev/), which relies on [react-native-ios-context-menu](https://github.com/dominicstop/react-native-ios-context-menu) to render the native `UIMenu` under the hood. Zeego automatically renders Liquid Glass menus when you build with Xcode 26.

对于菜单功能，我们采用了 [Zeego](https://zeego.dev/)，其底层依赖 [react-native-ios-context-menu](https://github.com/dominicstop/react-native-ios-context-menu) 来渲染原生的 `UIMenu`。当您使用 Xcode 26 构建项目时，Zeego 会自动呈现 Liquid Glass 风格的菜单。

## Native alerts

## 原生警告弹窗

React Native apps on iOS 26 experienced the `Alert` pop-up rendering offscreen. We reproduced this in our own app and in many popular React Native apps. We patched it locally and worked with developers from Callstack and Meta to [upstream a fix in React Native](https://github.com/facebook/react-native/pull/53500).

运行于 iOS 26 的 React Native 应用出现了 `Alert` 弹窗渲染偏移（显示在屏幕外）的问题。我们在自身应用及众多主流 React Native 应用中均复现了该问题。我们先在本地打补丁修复，并协同 Callstack 与 Meta 的开发者，将修复方案[提交至 React Native 主干仓库](https://github.com/facebook/react-native/pull/53500)。

## Native bottom sheets

## 原生底部表单（Bottom Sheets）

For bottom sheets, we used the built-in React Native modal with `presentationStyle="formSheet"`. However, this came with a few downsides which we addressed with patches.

对于底部表单（bottom sheets），我们使用了 React Native 内置的 Modal 组件，并设置 `presentationStyle="formSheet"`。但该方案存在若干缺陷，我们通过补丁予以修复。

### Modal dragging issues

### 模态框拖拽问题

First, when dragging the sheet down, it temporarily froze in place before properly dismissing. To resolve this, we patched React Native locally. We worked with Callstack to [upstream our patch](https://github.com/facebook/react-native/pull/51483) into React Native, and it’s now live in 0.82.

首先，当向下拖拽底部表单时，它会在完全关闭前短暂卡顿、悬停不动。为解决此问题，我们对 React Native 进行了本地补丁修复。随后，我们与 Callstack 团队协作，将该补丁[提交至 React Native 主干仓库](https://github.com/facebook/react-native/pull/51483)，该修复现已随 React Native v0.82 正式发布。

### Fixing Yoga flickering

### 修复 Yoga 闪烁问题

If you put a `View` with `flex: 1` inside a modal with a background color, and then drag the modal up and down, the bottom of the view flickers aggressively.

如果将一个 `flex: 1` 的 `View` 放入带有背景色的模态框（modal）中，然后上下拖动该模态框，视图底部会出现剧烈的闪烁现象。

To solve this, we patched React Native locally to support synchronous updates for modals in Yoga. We collaborated with developers from Callstack, Expo and Meta to upstream this change into React Native core. [It's now live](https://github.com/facebook/react-native/pull/52604) in React Native 0.82.

为解决此问题，我们本地修改了 React Native，使其在 Yoga 布局引擎中支持模态框的同步更新。我们与 Callstack、Expo 和 Meta 的开发者协作，将这一变更提交至 React Native 核心代码库。该修复现已随 [React Native 0.82 版本正式发布](https://github.com/facebook/react-native/pull/52604)。

## Looking forward

## 展望未来

After building our first app using React Native with Expo, we aren’t looking back. If you haven't tried v0 for iOS yet, [download it](https://apps.apple.com/us/app/v0/id6745097949) and let us know what you think with an App Store review.

在使用 Expo 搭配 React Native 成功构建我们的首个应用后，我们已坚定地选择继续沿此技术路径前行。若您尚未尝试 iOS 版的 v0 应用，欢迎[立即下载](https://apps.apple.com/us/app/v0/id6745097949)，并前往 App Store 留下您的宝贵评价与反馈。

We're hiring developers to join the Vercel Mobile team. If this kind of work excites you, we'd love to [hear from you](https://vercel.com/careers/mobile-engineer-us-5719796004).

Vercel 移动端团队正在招聘开发者。如果您对这类工作充满热情，我们诚挚期待您的加入——欢迎[投递简历](https://vercel.com/careers/mobile-engineer-us-5719796004)。

At Vercel, we're committed to building ambitious products at the highest caliber. We want to make it easy for web and native developers to do the same, and we plan to open-source our findings. Please [reach out on X](https://x.com/fernandorojo) if you would like to beta test an open source library for AI chat apps. We look forward to partnering with the community to continue improving React Native.

在 Vercel，我们致力于以最高标准打造富有雄心的产品。我们希望让 Web 与原生开发者也能轻松实现同等目标，并计划将相关研究成果开源。如果您有兴趣参与一款面向 AI 聊天应用的开源库的早期测试，请[通过 X 平台联系我们](https://x.com/fernandorojo)。我们期待与社区携手合作，持续推动 React Native 的演进与完善。
&#123;% endraw %}
