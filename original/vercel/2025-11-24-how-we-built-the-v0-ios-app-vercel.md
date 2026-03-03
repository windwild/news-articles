---
title: " How we built the v0 iOS app - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-we-built-the-v0-ios-app"
date: "2025-11-24"
scraped_at: "2026-03-02T09:25:04.284296657+00:00"
language: "en"
translated: false
description: "The v0 engineering team breaks down the challenges and decisions behind building the v0 app for iOS."
---




Nov 24, 2025

We recently released [v0 for iOS](https://apps.apple.com/us/app/v0/id6745097949), Vercel’s first mobile app. As a company focused on the web, building a native app was new territory for us.

Our goal was to build an app worthy of an Apple Design Award, and we were open-minded on the best tech stack to get there. To that end, we built dozens of iterations of the product prior to our public beta. We experimented with drastically different tech stacks and UI patterns.

We took inspiration from apps which speak the iPhone’s language, such as Apple Notes and iMessage. v0 had to earn a spot on your Home Screen among the greats.

After weeks of experimentation, we landed on React Native with Expo to achieve this. We are pleased with the results, and our customers are too. In fact, the influx of messages from developers asking how the app feels so native compelled us to write a technical breakdown of how we did it.

## Table of contents

- [How we built the v0 chat experience](https://vercel.com/blog/how-we-built-the-v0-ios-app#how-we-built-the-v0-chat-experience)

  - [Building a composable chat](https://vercel.com/blog/how-we-built-the-v0-ios-app#building-a-composable-chat)

  - [Sending your first message](https://vercel.com/blog/how-we-built-the-v0-ios-app#sending-your-first-message)

  - [Fading in the first assistant message](https://vercel.com/blog/how-we-built-the-v0-ios-app#fading-in-the-first-assistant-message)

  - [Sending messages in an existing chat](https://vercel.com/blog/how-we-built-the-v0-ios-app#sending-messages-in-an-existing-chat)

  - [How we solved messages scrolling to the top](https://vercel.com/blog/how-we-built-the-v0-ios-app#how-we-solved-it)
- [Taming the keyboard](https://vercel.com/blog/how-we-built-the-v0-ios-app#taming-the-keyboard)

- [Scrolling to end initially](https://vercel.com/blog/how-we-built-the-v0-ios-app#scrolling-to-end-initially)

- [Floating composer](https://vercel.com/blog/how-we-built-the-v0-ios-app#floating-composer)

  - [Make it float](https://vercel.com/blog/how-we-built-the-v0-ios-app#make-it-float)

  - [Make it native](https://vercel.com/blog/how-we-built-the-v0-ios-app#make-it-native)

  - [Pasting images](https://vercel.com/blog/how-we-built-the-v0-ios-app#pasting-images)
- [Fading in content](https://vercel.com/blog/how-we-built-the-v0-ios-app#fading-in-streaming-content)

- [Sharing code between web and native](https://vercel.com/blog/how-we-built-the-v0-ios-app#sharing-code-between-web-and-native)

- [Styling](https://vercel.com/blog/how-we-built-the-v0-ios-app#styling)

  - [Native menus](https://vercel.com/blog/how-we-built-the-v0-ios-app#native-menus)

  - [Native alerts](https://vercel.com/blog/how-we-built-the-v0-ios-app#native-alerts)

  - [Native bottom sheets](https://vercel.com/blog/how-we-built-the-v0-ios-app#native-bottom-sheets)
- [Looking forward](https://vercel.com/blog/how-we-built-the-v0-ios-app#looking-forward)


## How we built the v0 chat experience

When you’re away from your computer, you might have a quick idea you want to act on. Our goal was to let you turn that idea into something tangible, without requiring context switching. v0 for iOS is the next generation of your Notes app, where your ideas get built in the background.

We did not set out to build a mobile IDE with feature parity with our website. Instead, we wanted to build a simple, delightful experience for using AI to make things on the go. The centerpiece of that experience is the chat.

To build a great chat, we set the following requirements:

- New messages animate in smoothly

- New user messages scroll to the top of the screen

- Assistant messages fade in with a staggered transition as they stream

- The composer uses Liquid Glass and floats on top of scrollable content

- Opening existing chats starts scrolled to the end

- Keyboard handling feels natural

- The text input lets you paste images and files

- The text input supports pan gestures to focus and blur it

- Markdown is fast and supports dynamic components


While a number of UI patterns have emerged for AI chat in mobile apps, there is no equivalent set of patterns for AI code generation on mobile.

We hadn’t seen these features in existing React Native apps, so we found ourselves inventing patterns on the fly. It took an extraordinary amount of work, testing, and coordination across each feature to make it meet our standards.

## Building a composable chat

To meet our requirements, we structured our chat code to be [composable](https://www.youtube.com/watch?v=4KvbVq3Eg5w) on a per-feature basis.

Our chat is powered by a few open source libraries: [LegendList](https://legendapp.com/open-source/list/), [React Native Reanimated](https://docs.swmansion.com/react-native-reanimated/), and [React Native Keyboard Controller](https://kirillzyusko.github.io/react-native-keyboard-controller/). To start, we set up multiple context providers.

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

11}
```

The provider wraps the `MessagesList`:

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

11      onScroll={onScroll}

12      enableAverages={false}

13      data={messages}

14      keyExtractor={(item) => item.id}

15      renderItem={({ item, index }) => {

16        if (item.role === 'user') {

17          return <UserMessage message={item} index={index} />

18        }

19        if (item.role === 'assistant') {

20          return <AssistantMessage message={item} index={index} />

21        }

22        if (item.role === 'optimistic-placeholder') {

23          return <OptimisticAssistantMessage index={index} />

24        }

25      }}

26    />

27  )

28}
```

The following sections break down each hook to demonstrate how they work together.

## Sending your first message

When you send a message on v0, the message bubble smoothly fades in and slides to the top. Immediately after the user message is done animating, the assistant messages fade in.

When the user sends a message, we set a Reanimated shared value to indicate the animation should begin. Shared values let us update state without triggering re-renders.

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

Setting the animation state on submit

With our state tracked in Reanimated, we can now animate our `UserMessage`.

```tsx
export function UserMessage({ message, index }) {

2  const isFirstUserMessage = index === 0



4  const { style, ref, onLayout } = useFirstMessageAnimation({

5    disabled: !isFirstUserMessage,

6  })



8  return (

9    <Animated.View style={style} ref={ref} onLayout={onLayout}>

10      <UserMessageContent message={message} />

11    </Animated.View>

12  )

13}
```

Wrapping the user message in an animated view

Notice that `UserMessageContent` is wrapped with an `Animated.View` which receives props from `useFirstMessageAnimation`.

### How `useFirstMessageAnimation` works

This hook is responsible for 3 things:

1. Measure the height of the user message with `itemHeight`, a Reanimated shared value

2. Fade in the message when `isMessageSendAnimating`

3. Signal to the assistant message that the animation is complete


```tsx
export function useFirstMessageAnimation({ disabled }) {

2  const { keyboardHeight } = useKeyboardContextState()

3  const { isMessageSendAnimating } = useNewMessageAnimation()

4  const windowHeight = useWindowDimensions().height

5  const translateY = useSharedValue(0)

6  const progress = useSharedValue(-1)

7  const { itemHeight, ref, onLayout } = useMessageRenderedHeight()



9  useAnimatedReaction(

10    () => {

11      const didAnimate = progress.get() !== -1



13      if (disabled || didAnimate || !isMessageSendAnimating.get()) {

14        return -1

15      }



17      return itemHeight.get()

18    },

19    (messageHeight) => {

20      if (messageHeight <= 0) return



22      const animatedValues = getAnimatedValues({

23        itemHeight: messageHeight,

24        windowHeight,

25        keyboardHeight: keyboardHeight.get(),

26      })

27      const { start, end, duration, easing, config } = animatedValues



29      translateY.set(

30        // initialize values at the "start" state with duration 0

31        withTiming(start.translateY, { duration: 0 }, () => {

32          // next, transition to the "end" state

33          translateY.set(withSpring(end.translateY, config))

34        })

35      )

36      progress.set(

37        withTiming(start.progress, { duration: 0 }, () => {

38          progress.set(withTiming(end.progress, { duration, easing }), () => {

39            isMessageSendAnimating.set(false)

40          })

41        })

42      )

43    }

44  )



46  const style = useAnimatedStyle(...)

47  const didUserMessageAnimate = useDerivedValue(() => progress.get() === 1)



49  return { style, ref, onLayout, didUserMessageAnimate }

50}
```

The useFirstMessageAnimation hook

Thanks to React Native’s New Architecture, `ref.current.measure()` in `useLayoutEffect` is synchronous, giving us height on the first render. Subsequent updates fire in `onLayout`.

Based on the message height, window height, and current keyboard height, `getAnimatedValues` constructs the easing, `start`, and `end` states for `translateY` and `progress`. The resulting shared values are passed to `useAnimatedStyle` as `transform` and `opacity` respectively.

And there we have it. Our first message fades in using Reanimated. Once it’s done animating, we’re ready to fade in the first assistant message response.

## Fading in the first assistant message

Similar to `UserMessage`, the assistant message content is wrapped in an animated view that fades in after the user message animation completes.

```tsx
function AssistantMessage({ message, index }) {

2  const isFirstAssistantMessage = index === 1



4  const { didUserMessageAnimate } = useFirstMessageAnimation({

5    disabled: !isFirstAssistantMessage,

6  })



8  const style = useAnimatedStyle(() => ({

9    opacity: didUserMessageAnimate.get() ? withTiming(1, { duration: 350 }) : 0,

10  }))



12  return (

13    <Animated.View style={style}>

14      <AssistantMessageContent message={message} />

15    </Animated.View>

16  )

17}
```

Fading in after the user message animation completes

This fade in behavior is only enabled for the first assistant message in the chat, where `index === 1`. Messages in existing chats will have different behavior than messages in new chats.

What happens if you open an existing chat that has one user message and one assistant message? Will it animate in again? No, because the animations here only apply if `isMessageSendAnimating` is `true`, which gets set `onSubmit` and cleared when you change chats.

## Sending messages in an existing chat

We’ve covered how v0 handles animating in messages for new chats. For existing chats, however, the logic is entirely distinct. Rather than rely on Reanimated animations, such as the one in `useFirstMessageAnimation`, we rely on an implementation of `scrollToEnd()`.

So all we need to do is scroll to end if we’re sending a message in an existing chat, right?

```tsx
useEffect(function onNewMessage() {

2  const didNewMessageSend = // ...some logic

3  if (didNewMessageSend) {

4    listRef.current?.scrollToEnd()

5  }

6}, ...)
```

The naive approach

In a perfect world, this is all the logic we’d need. Let’s explore why it’s not enough.

If you recall from the introduction, one of our requirements is that new messages have to scroll to the top of the screen. If we simply call `scrollToEnd()`, then the new messages will show at the bottom of the screen.

![](images/how-we-built-the-v0-ios-app-vercel/img_001.jpg)![](images/how-we-built-the-v0-ios-app-vercel/img_002.jpg)

We needed a strategy to push the user message to the top of the chat. We referred to this as “blank size”: the distance between the bottom of the last assistant message, and the end of the chat.

![](images/how-we-built-the-v0-ios-app-vercel/img_003.jpg)![](images/how-we-built-the-v0-ios-app-vercel/img_004.jpg)

To float the content to the top of the chat, we had to push it up by the amount equal to the blank size. Thanks to synchronous height measurements in React Native's New Architecture, this was possible to do on each frame without a flicker. But it still required a lot of trickery and coordination.

In the image above, you’ll notice that the blank size is dynamic. Its height depends on the keyboard’s open state. And it can change on every render, since the assistant message streams in quickly and with unpredictable sizes.

Dynamic heights are a common challenge in virtualized lists. The frequently-updating blank size took that challenge to a new level. Our list items have dynamic, unknown heights that update frequently, and we need them to float to the top.

For long enough assistant messages, the blank size could be zero, which introduced a new set of edge cases.

![](images/how-we-built-the-v0-ios-app-vercel/img_005.jpg)![](images/how-we-built-the-v0-ios-app-vercel/img_006.jpg)

## How we solved it

We tried many different approaches to implementing blank size. We tried a `View` at the bottom of the `ScrollView` with height, bottom padding on the `ScrollView` itself, `translateY` on the scrollable content, and minimum height on the last system message. All of these ended up with strange side effects and poor performance, often due to the need for a layout with Yoga.

We ultimately landed on a solution that uses the `contentInset` property on `ScrollView` to handle the blank size without jitters. `contentInset` maps directly to the native property on `UIScrollView` in UIKit.

We then paired `contentInset` together with `scrollToEnd({ offset })` when you send a message.

An assistant message’s blank size is determined by the combination of its own height, the height of the user message that comes before it, and the height of the chat container.

![](images/how-we-built-the-v0-ios-app-vercel/img_007.jpg)![](images/how-we-built-the-v0-ios-app-vercel/img_008.jpg)

### Implementing `useMessageBlankSize`

To implement blank size, we start with a hook called `useMessageBlankSize` in the assistant message:

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

1. Synchronously measure the assistant message

2. Measure the user message before it

3. Calculate the minimum distance for the blank size below the assistant message

4. Keep track of what the blank size should be when the keyboard is opened or closed

5. Set the `blankSize` shared value at the root context provider


Lastly, we consume `blankSize` and pass it to the `contentInset` of our `ScrollView`:

```tsx
export function MessagesList(props) {

2  const { blankSize, composerHeight, keyboardHeight } = useMessageListContext()



4  const animatedProps = useAnimatedProps(() => {

5    return {

6      contentInset: {

7        bottom: blankSize.get() + composerHeight.get() + keyboardHeight.get(),

8      },

9    }

10  })



12  return <AnimatedLegendList {...props} animatedProps={animatedProps} />

13}
```

Passing blankSize to contentInset

`useAnimatedProps` from Reanimated lets us update props on the UI thread on each frame without triggering re-renders. `contentInset` saw great performance and worked far better than every previous attempt.

## Taming the keyboard

Building a good chat experience hinges on elegant keyboard handling. Achieving [native feel](https://x.com/fernandorojo/status/1857403323738927329) in this area was tedious and challenging with React Native. When v0 iOS was in public beta, Apple released iOS 26. Every time a new iOS beta version came out, our chat seemingly broke entirely. Each iOS release turned into a game of cat-and-mouse of reproducing tiny discrepancies and jitters.

Luckily, [Kiryl](https://github.com/kirillzyusko), the maintainer of `react-native-keyboard-controller`, helped us address these issues, often updating the library within 24 hours of Apple releasing a new beta.

### **Building** **`useKeyboardAwareMessageList`**

We used many of the hooks provided by React Native Keyboard Controller to build our own keyboard management system tailored to v0’s chat.

`useKeyboardAwareMessageList` is our custom React hook responsible for all of our keyboard handling logic. We render it alongside our chat list, and it abstracts away everything we need to make the keyboard feel right.

```tsx
function MessagesList() {

2  useKeyboardAwareMessageList()



4  // ...rest of the message list

5}
```

Consuming useKeyboardAwareMessageList

While the consumption is a one liner, its internals are about 1,000 lines of code with many unit tests. `useKeyboardAwareMessageList` primarily relies on the upstream `useKeyboardHandler`, handling events like `onStart`, `onEnd`, and `onInteractive`, together with a number of Reanimated `useAnimatedReaction` calls to retry events in particular edge cases.

`useKeyboardAwareMessageList` also handles a number of strange behaviors in iOS. For example, if you send an app to the background when the keyboard is open and then refocus the app, iOS will inexplicably fire the keyboard `onEnd` event three times. Because we relied on imperative behavior when events fired, we came up with tricks to dedupe repeat events and track app state changes.

`useKeyboardAwareMessageList` implements the following features:

1. Shrink the `blankSize` when the keyboard opens

2. If you’re scrolled to the end of the chat, and there’s no blank size, shift content up when the keyboard opens

3. If you have scrolled high up enough, and there’s no blank size, show the keyboard on top of the content, without shifting the content itself

4. When the user interactively dismisses the keyboard via the scroll view or text input, drag it down smoothly

5. If you’re scrolled to the end of the chat, and the blank size is bigger than the keyboard, the content should stay in place

6. If you’re scrolled to the end of the chat and the blank size is greater than zero, but it should be zero when the keyboard is open, shift content up so that it lands above the keyboard


There was no single trick to get this all working. We spent dozens of hours using the app, noticing imperfections, tracing issues, and rewriting the logic until it felt right.

## Scrolling to end initially

When you open an existing chat, v0 starts the chat scrolled to end. This is similar to using the `inverted` prop on React Native’s `FlatList` , which is common for bottom-to-top chat interfaces.

However, we decided not to use `inverted` since it felt incompatible with an AI chat where messages stream in multiple times per second. We opted notto autoscroll as the assistant message streams. Instead, we let the content fill in naturally under the keyboard, together with a button to scroll to the end. This follows the same behavior as ChatGPT’s iOS app.

That said, we wanted an inverted-list-style experience when you first opened an existing chat. To make this work, we call `scrollToEnd` when a chat first becomes visible.

Due to a complex combination of dynamic message heights and blank size, we had to call `scrollToEnd` multiple times. If we didn’t, our list would either not scroll properly, or scroll too late. Once the content has scrolled, we call `hasScrolledToEnd.set(true)` to fade in the chat.

```tsx
import { scheduleOnRN } from 'react-native-worklets'



export function useInitialScrollToEnd(blankSize, scrollToEnd, hasMessages) {

4  const hasStartedScrolledToEnd = useSharedValue(false)

5  const hasScrolledToEnd = useSharedValue(false)

6  const scrollToEndJS = useLatestCallback(() => {

7    scrollToEnd({ animated: false })

8    // Do another one just in case because the list may not have fully laid out yet

9    requestAnimationFrame(() => {

10      scrollToEnd({ animated: false })



12      // and another one again in case

13      setTimeout(() => {

14        scrollToEnd({ animated: false })



16        // and yet another!

17        requestAnimationFrame(() => {

18          hasScrolledToEnd.set(true)

19        })

20      }, 16)

21    })

22  })



24  useAnimatedReaction(

25    () => {

26      if (hasStartedScrolledToEnd.get() || !hasMessages) {

27        return false

28      }

29      return blankSize.get() > 0

30    },

31    (shouldScroll) => {

32      if (shouldScroll) {

33        hasStartedScrolledToEnd.set(true)

34        scheduleOnRN(scrollToEndJS)

35      }

36    }

37  )



39  return hasScrolledToEnd

40}
```

Calling scrollToEnd multiple times to handle dynamic heights

## Floating composer

Inspired by iMessage’s bottom toolbar in iOS 26, we built a Liquid Glass composer with a progressive blur.

We used `@callstack/liquid-glass` to add interactive Liquid Glass. By wrapping the glass views with `LiquidGlassContainerView`, we automatically get the view morphing effect.

```tsx
1<LiquidGlassContainerView spacing={8}>

2  <LiquidGlassView interactive>...</LiquidGlassView>

3  <LiquidGlassView interactive>...</LiquidGlassView>

4</LiquidGlassContainerView>
```

Adding Liquid Glass to the composer

### Make it float

After adding the Liquid Glass, the next step was making it float on top of the chat content.

In order to make the composer float on top of the scrollable content, we took the following steps:

1. Add `position: absolute; bottom: 0` to the composer

2. Wrap the composer in `KeyboardStickyView` from `react-native-keyboard-controller`

3. Synchronously measure the composer, and store its height in context using a shared value

4. Add the `composerHeight.get()` to our ScrollView’s native `contentInset.bottom` property


```tsx
function Composer() {

2  const { composerHeight } = useComposerHeightContext()

3  const { onLayout, ref } = useSyncLayoutHandler((layout) => {

4    composerHeight.set(layout.height)

5  })

6  const insets = useInsets()



8  return (

9    <KeyboardStickyView

10      style={{ position: 'absolute', bottom: 0, left: 0, right: 0 }}

11      offset={{ closed: -insets.bottom, opened: -8 }}

12    >

13      <View

14        ref={ref}

15        onLayout={onLayout}

16      >

17        {/* ... */}

18      </View>

19    </KeyboardStickyView>

20  )

21}
```

Positioning the composer with KeyboardStickyView

However, this was not enough. We are still missing one key behavior.

As you type, the text input’s height can increase. When you type new lines, we want to simulate the experience of typing in a regular, non-absolute-positioned input. We had to find a way to shift the chat messages upwards, but only if you are scrolled to the end of the chat.

In the video below, you can see both cases. At the start of the video, content shifts up with new lines since the chat is scrolled to the end. However, after scrolling up in the chat, typing new lines will not shift the content.

### `useScrollWhenComposerSizeUpdates`

Enter `useScrollWhenComposerSizeUpdates`. This hook listens to the height of the composer and automatically scrolls to end when needed. To consume it, we simply call it in `MessagesList`:

```tsx
export function MessagesList() {

2  useScrollWhenComposerSizeUpdates()



4  // ...message list code

5}
```

Consuming useScrollWhenComposerSizeUpdates

First, it sets up an effect using `useAnimatedReaction` to track composer height changes.

Next, we call `autoscrollToEnd`. As long as you’re close enough to the end of the scrollable area, we automatically scroll to the end of the chat. Without this, entering new lines in the composer would overlap the bottom of the scrollable area.

`useScrollWhenComposerSizeUpdates` lets us conditionally simulate the experience of a view that is not absolute-positioned.

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

12    const distanceFromEnd =

13      state.contentLength - state.scroll - state.scrollLength



15    if (distanceFromEnd < 0) {

16      scrollToEnd({ animated: false })

17      // wait a frame for LegendList to update, and fire it again

18      setTimeout(() => {

19        scrollToEnd({ animated: false })

20      }, 16)

21    }

22  }



24  useAnimatedReaction(

25    () => composerHeight.get(),

26    (height, prevHeight) => {

27      if (height > 0 && height !== prevHeight) {

28        scheduleOnRN(autoscrollToEnd)

29      }

30    }

31  )

32}
```

Scrolling to end when the composer grows

As we saw in earlier code, we unfortunately relied on a number of `setTimeout` and `requestAnimationFrame` calls to `scrollToEnd`. That code will understandably raise eyebrows, but it was the only way we managed to get scrolling to end working properly. We’re actively collaborating with [Jay](https://github.com/jmeistrich), the maintainer of LegendList, to build a more reliable approach.

### Make it feel native

React Native’s built-in `TextInput` felt out of place in a native chat app.

By default, when you set `multiline={true}`, the `TextInput` shows ugly scroll indicators, which is inconsistent with most chat apps. Swiping up and down on the input will bounce its internal content, even if you haven’t typed any text yet. Additionally, the input doesn't support interactive keyboard dismissal.

To fix these issues, we applied a patch to `RCTUITextView` in native code. This patch disables scroll indicators, removes bounce effects, and enables interactive keyboard dismissal.

Our patch also adds support for swiping up to focus the input. We realized we needed this after watching testers frustratingly swipe up expecting the keyboard to open.

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

11+    self.showsVerticalScrollIndicator = NO;

12+    self.showsHorizontalScrollIndicator = NO;

13+    self.bounces = NO;

14+    self.alwaysBounceVertical = NO;

15+    self.alwaysBounceHorizontal = NO;

16+    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;

17+    [self.panGestureRecognizer addTarget:self action:@selector(_handlePanToFocus:)];

18+

19     _initialValueLeadingBarButtonGroups = nil;

20     _initialValueTrailingBarButtonGroups = nil;

21   }

22@@ -62,6 +72,18 @@ - (instancetype)initWithFrame:(CGRect)frame

23   return self;

24 }



26+- (void)_handlePanToFocus:(UIPanGestureRecognizer *)g

27+{

28+    if (self.isFirstResponder) { return; }

29+    if (g.state != UIGestureRecognizerStateBegan) { return; }

30+    CGPoint v = [g velocityInView:self];

31+    CGPoint t = [g translationInView:self];

32+    // Add pan gesture to focus the keyboard

33+    if (v.y < -250.0 && !self.isFirstResponder) {

34+        [self becomeFirstResponder];

35+    }

36+}

37+

38 - (void)setDelegate:(id<UITextViewDelegate>)delegate

39 {

40   // Delegate is set inside `[RCTBackedTextViewDelegateAdapter initWithTextView]` and
```

While maintaining a patch across React Native updates is not ideal, it was the most practical solution we found. We would have preferred an official API for extending native views without patching, and we plan on contributing this patch to React Native core if there is community interest.

## Pasting images

To support pasting images and files in the text input, we used an Expo Module that listens to paste events from the native `UIPasteboard`.

If you paste long enough text, `onPaste` will automatically turn the pasted content into a `.txt` file attachment.

```tsx
1<TextInputWrapper onPaste={pasted => ...}>

2  <TextInput />

3</TextInputWrapper>
```

Wrapping TextInput to handle paste events

Since it was difficult to extend the existing `TextInput` in native code, we use a `TextInputWrapper` component which wraps `TextInput` and traverses its `subviews` in Swift. For more in-depth examples of creating native wrapper components, you can watch my 2024 talk, [“Don’t be afraid to build a native library”](https://youtu.be/mG1Lv-RWds8?si=UCSHQQAnfsYGdr4P).

## Fading in streaming content

When an AI’s assistant message streams in, it needs to feel smooth. To achieve this, we created two components:

1. `<FadeInStaggeredIfStreaming />`

2. `<TextFadeInStaggeredIfStreaming />`


As long as an element gets wrapped by one of these components, its children will smoothly fade in with a staggered animation.

```tsx
const mdxComponents = {

2  a: function A(props) {

3    return (

4      <Elements.A {...props}>

5        <TextFadeInStaggeredIfStreaming>

6          {props.children}

7        </TextFadeInStaggeredIfStreaming>

8      </Elements.A>

9    )

10  },

11  // ...other components

12}
```

Using TextFadeInStaggeredIfStreaming in MDX components

Under the hood, these components render a variation of `FadeInStaggered`, which handles the state management:

```tsx
const useIsAnimatedInPool = createUsePool()



function FadeInStaggered({ children }) {

4  const { isActive, evict } = useIsAnimatedInPool()

5  return isActive ? <FadeIn onFadedIn={evict}>{children}</FadeIn> : children

6}
```

Managing animation state with a pool

`useIsAnimatedInPool` is a custom state manager outside of React that allows a limited number of ordered elements to get rendered at once. Elements request to join the pool when they mount, and `isActive` indicates if they should render an animated node.

After the `onFadedIn` callback fires, we evict the element from the pool, rendering its children directly without the animated wrapper. This helps us limit the number of animated nodes that are active at once.

Lastly, `FadeIn` renders a staggered animation with a delay of 32 milliseconds between elements. The staggered animations run on a schedule, animating a batch of 2 items at a time. When the queue of staggered items becomes higher than 10, we increase the number of batched items according to the size of the queue.

```tsx
const useStaggeredAnimation = createUseStaggered(32)



function FadeIn({ children, onFadedIn, Component }) {

4  const opacity = useSharedValue(0)



6  const startAnimation = () => {

7    opacity.set(withTiming(1, { duration: 500 }))

8    setTimeout(onFadedIn, 500)

9  }



11  useStaggeredAnimation(startAnimation)



13  return <Component style={{ opacity }}>{children}</Component>

14}
```

Staggered fade animation

`TextFadeInStaggeredIfStreaming` uses a similar strategy. We first chunk words into individual text nodes, then we create a unique pool for text elements with a limit of 4. This ensures that no more than 4 words will fade in at a time.

```tsx
const useShouldTextFadePool = createUsePool(4)



function TextFadeInStaggeredIfStreaming(props) {

4  const { isStreaming } = use(MessageContext)

5  const { isActive } = useShouldTextFadePool()



7  const [shouldFade] = useState(isActive && isStreaming)



9  let { children } = props

10  if (shouldFade && children) {

11    if (Array.isArray(children)) {

12      children = Children.map(children, (child, i) =>

13        typeof child === 'string' ? <AnimatedFadeInText key={i} text={child} /> : child,

14      )

15    } else if (typeof children === 'string') {

16      children = <AnimatedFadeInText text={children} />

17    }

18  }



20  return children

21}



function AnimatedFadeInText({ text }) {

24  const chunks = text.split(' ')



26  return chunks.map((chunk, i) => <TextFadeInStaggered key={i} text={chunk + ' '} />)

27}



function TextFadeInStaggered({ text }) {

30  const { isActive, evict } = useIsAnimatedInPool()

31  return isActive ? <FadeIn onFadedIn={evict}>{text}</FadeIn> : text

32}
```

Chunking text and limiting concurrent animations

One issue we faced with this approach is that it relies heavily on firing animations _on mount_. As a result, if you send a message, go to another chat, and then come back to the original chat before the message is done sending, it will remount and animate once again.

To mitigate this, we implemented a system that keeps track of which content you've already seen animate across chats. The implementation uses a `DisableFadeProvider` towards the top of the message in the tree. We consume it in the root fade component to avoid affecting the pool if needed.

```tsx
function TextFadeInStaggeredIfStreaming(props) {

2  const { isStreaming } = use(MessageContext)

3  const { isActive } = useShouldTextFadePool()

4  const isFadeDisabled = useDisableFadeContext()



6  const [shouldFade] = useState(!isFadeDisabled && isActive && isStreaming)



8  if (shouldFade) // here we render TextFadeIn...



10  return props.children

11}
```

Disabling fade for already-seen content

While it might look unusual to explicitly rely on `useState`'s initial value in a non-reactive way, this let us reliably track elements and their animation states based on their mount order.

## Sharing code between web and native

When we started building the v0 iOS app, a natural question arose: how much code should we share between web and native?

Given how mature the v0 web monorepo was, we decided to share types and helper functions, but not UI or state management. We also made a concerted effort to migrate business logic from client to server, letting the v0 mobile app be a thin wrapper over the API.

### Building a shared API

Sharing the backend API routes between a mature Next.js app and a new mobile app introduced challenges. The v0 web app is powered by React Server Components and Server Actions, while the mobile app functions more like a single-page React app.

To address this, we built an API layer using a hand-rolled backend framework. Our framework enforces runtime type safety by requiring input and output types specified with [Zod](https://zod.dev/).

After defining the routes, we generate an [openapi.json file](https://api.v0.dev/v1/openapi.json) based on each route’s Zod types. The mobile app consumes the OpenAPI spec using [Hey API](https://heyapi.dev/), which generates helper functions to use with [Tanstack Query](https://tanstack.com/query/latest).

```tsx
import { termsFindOptions } from '@/api' // this folder is generated

import { useQuery } from '@tanstack/react-query'



export function useTermsQuery({ after }) {

5  return useQuery(termsFindOptions({ after }))

6}
```

Generated API helpers with Tanstack Query

This effort led to the development of the [v0 Platform API](https://v0.app/docs/api/platform/quickstart). We wanted to build the ideal API for our own native client, and we ultimately decided to make that same API available to everyone. Thanks to this approach, v0 mobile uses the same routes and logic as v0’s Platform API customers.

On each commit, we run tests to ensure that changes to our OpenAPI spec are compatible with the mobile app.

In the future, we hope to eliminate the code generation step entirely with a type-level RPC wrapper around the Platform API.

## Styling

v0 uses `react-native-unistyles` for styles and theming. My experience with React Native has taught me to be cautious of any work done in render. Unlike other styling libraries we evaluated, Unistyles provides comprehensive theming without re-rendering components or accessing React Context.

## Native menus

Beyond Unistyles for themes and styles, we did not use a JS-based component library. Instead, we relied on native elements where possible.

For menus, we used [Zeego](https://zeego.dev/), which relies on [react-native-ios-context-menu](https://github.com/dominicstop/react-native-ios-context-menu) to render the native `UIMenu` under the hood. Zeego automatically renders Liquid Glass menus when you build with Xcode 26.

## Native alerts

React Native apps on iOS 26 experienced the `Alert` pop-up rendering offscreen. We reproduced this in our own app and in many popular React Native apps. We patched it locally and worked with developers from Callstack and Meta to [upstream a fix in React Native](https://github.com/facebook/react-native/pull/53500).

## Native bottom sheets

For bottom sheets, we used the built-in React Native modal with `presentationStyle="formSheet"`. However, this came with a few downsides which we addressed with patches.

### Modal dragging issues

First, when dragging the sheet down, it temporarily froze in place before properly dismissing. To resolve this, we patched React Native locally. We worked with Callstack to [upstream our patch](https://github.com/facebook/react-native/pull/51483) into React Native, and it’s now live in 0.82.

### Fixing Yoga flickering

If you put a `View` with `flex: 1` inside a modal with a background color, and then drag the modal up and down, the bottom of the view flickers aggressively.

To solve this, we patched React Native locally to support synchronous updates for modals in Yoga. We collaborated with developers from Callstack, Expo and Meta to upstream this change into React Native core. [It's now live](https://github.com/facebook/react-native/pull/52604) in React Native 0.82.

## Looking forward

After building our first app using React Native with Expo, we aren’t looking back. If you haven't tried v0 for iOS yet, [download it](https://apps.apple.com/us/app/v0/id6745097949) and let us know what you think with an App Store review.

We're hiring developers to join the Vercel Mobile team. If this kind of work excites you, we'd love to [hear from you](https://vercel.com/careers/mobile-engineer-us-5719796004).

At Vercel, we're committed to building ambitious products at the highest caliber. We want to make it easy for web and native developers to do the same, and we plan to open-source our findings. Please [reach out on X](https://x.com/fernandorojo) if you would like to beta test an open source library for AI chat apps. We look forward to partnering with the community to continue improving React Native.