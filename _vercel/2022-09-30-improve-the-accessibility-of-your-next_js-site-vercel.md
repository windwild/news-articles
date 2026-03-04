---
title: "Improve the accessibility of your Next.js site - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site"
date: "2022-09-30"
scraped_at: "2026-03-02T10:00:22.595542422+00:00"
language: "en-zh"
translated: true
description: "Let's make the Web. Accessible."
---
{% raw %}

Sep 30, 2022

2022 年 9 月 30 日

Fitts 定律、如何真正实现完整的表单错误提示、如何让基于网页的游戏对所有人可玩，以及其他相关内容。

We believe the Web should be accessible for everyone. Part of achieving this goal is using best practices on our own work, so we took extra care in making the highly dynamic, WebGL-driven [Next.js Conf registration website](https://nextjs.org/conf) as accessible as possible.

我们坚信，Web 应当为所有人所用。实现这一目标的重要一环，是在我们自身的工作中践行无障碍最佳实践。因此，我们在构建高度动态、由 WebGL 驱动的 [Next.js Conf 注册网站](https://nextjs.org/conf) 时格外用心，力求使其尽可能无障碍。

We also ensure that we enable other developers to ship accessibility by default with [Next.js' built-in accessibility features](https://nextjs.org/docs/accessibility). Whether you're working on a hobby project or are part of a large organization, more people can enjoy your project when you follow proper accessibility practices.

我们还通过 [Next.js 内置的无障碍功能](https://nextjs.org/docs/accessibility)，确保其他开发者能够默认交付具备无障碍支持的产品。无论你是在开发个人兴趣项目，还是隶属于大型组织，只要遵循恰当的无障碍实践，就能让更多人顺畅地使用你的项目。

- [Increase element target size for better usability](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site#increase-element-target-size-for-better-usability)

- [增大元素点击目标区域以提升可用性](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site#increase-element-target-size-for-better-usability)

- [Build with semantic HTML](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site#build-with-semantic-html)

- [使用语义化 HTML 构建](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site#build-with-semantic-html)

- [Be delightful with alternative text](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site#be-delightful-with-alternative-text)

- [用优质的替代文本提升体验](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site#be-delightful-with-alternative-text)

- [Inform with input error messages](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site#inform-with-input-error-messages)

- [通过输入错误消息提供清晰反馈](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site#inform-with-input-error-messages)

- [Reduce motion according to user preferences](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site#reduce-motion-according-to-user-preferences)

- [依据用户偏好减少动画效果](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site#reduce-motion-according-to-user-preferences)

- [Making word games accessible](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site#making-vordle-accessible)

- [让文字类游戏具备无障碍支持](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site#making-vordle-accessible)

- [面向开发者的无障碍工具](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site#accessibility-tooling-for-developers)


## 增大元素目标尺寸以提升可用性

并非所有用户都能精准操控鼠标，因此我们必须确保交互控件无需精细操作即可使用。我们可点击元素的目标尺寸必须足够大，以便用户轻松激活并与其交互。

让我们以 Next.js Conf 官网中自动展开的页脚为例进行说明。

Next.js Conf 注册页面页脚的演示效果：鼠标悬停于页脚区域，触发一个自动展开的区块，其中显示若干实用链接。

我们最初的实现方式是将目标尺寸设为字体大小加上少量内边距，结果导致目标高度仅为 `36px`——对部分用户而言，这一尺寸过小。

为解决该问题，我们应用了[Fitts 定律](https://zh.wikipedia.org/wiki/Fitts%E5%AE%9A%E5%BE%8B)（Fitts’ Law）：击中目标所需的时间，取决于目标与起始点之间的距离以及目标本身的尺寸。

我们的页脚位于屏幕右下角，且高度仅有 `36px`，因此用户需要花费较长时间才能准确点击。我们发现的一个具体问题是：用户尝试登出时，菜单会意外收起。

若用红色背景高亮显示目标区域，我们便能直观理解页脚为何会意外收起。

鼠标在页脚区域上方悬停并移动，却难以始终停留在页脚容器那高仅 `36px` 的红色矩形区域内。

We shouldn’t expect the user to have precise control of their cursor. To improve this, we increased the touch target size by `12px` to make a total target height size of `60px`.

我们不应期望用户能对其光标进行精确控制。为改善这一体验，我们将触控目标尺寸增加了 `12px`，使目标总高度达到 `60px`。

A mouse hover the footer, expanding it to the left and revealing more useful links. The mouse travels over the 60px tall background, easily staying within the bounds of the red container.

鼠标悬停于页脚区域时，页脚向左展开，显示更多实用链接。鼠标在高度为 `60px` 的背景区域内移动，可轻松保持在红色容器的边界范围内。

**Takeaway**: Make sure your target sizes are large enough so they’re easily reachable and interactable.

**关键要点**：请确保交互目标的尺寸足够大，以便用户轻松触达并操作。

## Build with semantic HTML

## 使用语义化 HTML 构建

Screen readers are software that allow non-sighted users to understand and interact with their device. For web applications, they’re able to parse and convey actions and information available for the page.

屏幕阅读器（screen reader）是一类辅助软件，帮助视障用户理解并与其设备进行交互。对于网页应用而言，屏幕阅读器能够解析页面内容，并向用户传达当前页面所支持的操作与可用信息。

Because screen readers rely on HTML semantics, poorly constructed HTML will make your pages difficult to interact with for some of your visitors. As the complexity of a page increases, the fundamentals of an HTML document become increasingly more important for handicapped users.

由于屏幕阅读器依赖 HTML 的语义结构，HTML 结构不规范将导致部分访客（尤其是残障用户）难以与您的网页进行交互。随着页面复杂度提升，HTML 文档的基础语义规范对残障用户而言愈发重要。

On our website, we built a control that allows attendees to pick the theme for their ticket.

在我们的网站上，我们构建了一个控件，供参会者为其电子票选择主题样式。

![A screenshot of the ticket theme picker from the Next.js Conf website. It shows 3 buttons with each button having a different color theme.](images/improve-the-accessibility-of-your-next_js-site-vercel/img_001.jpg)  
![Next.js Conf 网站上的电子票主题选择器截图：显示三个按钮，每个按钮对应一种不同的配色主题。](images/improve-the-accessibility-of-your-next_js-site-vercel/img_001.jpg)

A simple implementation for this control could look like this:

该控件的一种简单实现方式如下所示：

```jsx
const THEMES = ["a", "b", "c"];
```

```javascript
const TicketThemePicker = () => {

4  const [activeTheme, setActiveTheme] = useState(THEMES[0]);

4  const [当前选中主题, 设置当前选中主题] = useState(THEMES[0]);

6  return THEMES.map((theme) => (

6  return THEMES.map((theme) => (

7    <button

7    <button

8      key={theme}

8      key={theme}

9      onClick={() => {

9      onClick={() => {

10        setActiveTheme(theme);

10        设置当前选中主题(theme);

11      }}

11      }}
```

12    >

12    >

13      <Image src={getImage(theme)} />

13      <Image src={getImage(theme)} />

14      {activeTheme === theme && <CheckmarkIcon />}

14      {activeTheme === theme && <CheckmarkIcon />}

15    </button>

15    </button>

16  ));

16  ));

17};

17};

```

```

Mapping over array elements to create button images. This code is missing HTML attributes that would improve accessibility.

遍历数组元素以生成按钮图像。此代码缺少可提升可访问性的 HTML 属性。

Most developers will go through a quick mental checklist like this one:

大多数开发者会快速在脑海中核对如下清单：

- Uses semantic elements (`<button>`)

- 使用语义化元素（`<button>`）

- Navigating with `TAB`

- 使用 `TAB` 键进行导航

- Visually fits design specifications  
- 在视觉上符合设计规范  

They’re able to understand and use this control themselves so it feels like it’s ready to be shipped. But, according to [WebAIM](https://webaim.org/projects/screenreadersurvey6) and [US Census](https://www.census.gov/newsroom/releases/archives/facts_for_features_special_editions/cb12-ff16.html) data, up to 20% of the people who visit our website are not able to use this control.  
用户能够自行理解并操作该控件，因此它给人的感觉是已具备上线条件。然而，根据 [WebAIM](https://webaim.org/projects/screenreadersurvey6) 和 [美国人口普查局（US Census）](https://www.census.gov/newsroom/releases/archives/facts_for_features_special_editions/cb12-ff16.html) 的数据，访问我们网站的用户中，最多有 20% 无法使用该控件。

### A more robust control  
### 更健壮的控件  

The [W3 ARIA group has defined patterns](https://www.w3.org/WAI/ARIA/apg/patterns/) for many complex controls. We picked [Radio Group](https://www.w3.org/WAI/ARIA/apg/patterns/radiobutton/) because it satisfies all six parameters of our extended checklist. Here’s the implementation we landed on:  
[W3C ARIA 工作组已为多种复杂控件定义了设计模式](https://www.w3.org/WAI/ARIA/apg/patterns/)。我们选择了 [单选按钮组（Radio Group）](https://www.w3.org/WAI/ARIA/apg/patterns/radiobutton/)，因为它满足我们扩展版检查清单中的全部六项参数。以下是最终采用的实现方案：

```jsx
const THEMES = ["a", "b", "c"];



const TicketThemePicker = () => {

4  const [activeTheme, setActiveTheme] = useState(THEMES[0]);



6  return THEMES.map((theme) => (  
```

7    `<React.Fragment key={theme}>`

7    `<React.Fragment key={theme}>`

8      `<input`

8      `<input`

9        `checked={activeTheme === theme}`

9        `checked={activeTheme === theme}`

10        `id={`ticket-theme-${theme}`}`

10        `id={`ticket-theme-${theme}`}`

11        `onChange={() => {`

11        `onChange={() => {`

12          `setActiveTheme(theme);`

12          `setActiveTheme(theme);`

13        `}}`

13        `}}`

14        `type="radio"`

14        `type="radio"`

15        `value={theme}`

15        `value={theme}`

16      `/>`

16      `/>`

17      <label htmlFor={`ticket-theme-${theme}`}>

17      <label htmlFor={`ticket-theme-${theme}`}>

18        <Image alt={getDescription(theme)} src={getImage(theme)} />

18        <Image alt={getDescription(theme)} src={getImage(theme)} />

19        {activeTheme === theme && <CheckmarkIcon aria-hidden="true" />}

19        {activeTheme === theme && <CheckmarkIcon aria-hidden="true" />}

20      </label>

20      </label>

21    </>

21    </>

22  ));

22  ));

23};

23};

An array of controls using inputs with accessibility improvements including type, alt, and aria attributes.

一组使用输入控件的组件，已通过添加 `type`、`alt` 和 `aria` 等属性提升了可访问性。

Keyboard interactions meet the specification and we’ve improved the information available to assistive technologies.

键盘交互符合规范，且我们已增强向辅助技术提供的信息。

**Takeaway**: When implementing complex controls, refer to the [ARIA Patterns for accessible controls](https://www.w3.org/WAI/ARIA/apg/patterns/) to make sure you’re using proven patterns.

**经验总结**：在实现复杂控件时，请参考 [面向可访问控件的 ARIA 设计模式](https://www.w3.org/WAI/ARIA/apg/patterns/)，确保采用经过验证的最佳实践模式。

## Be delightful with alternative text

## 用富有表现力的替代文本提升体验

It can be easy for a well-sighted developer to forget that the amazing visuals on their screen cannot be enjoyed by low-sighted web visitors. But we can still make sure that our non-visual users have a pleasant experience using descriptive language.

视力正常的开发者很容易忽略这样一个事实：屏幕上那些令人惊叹的视觉效果，低视力的网页访问者却无法欣赏。但我们仍可通过使用生动、细致的描述性语言，确保非视觉用户也能获得愉悦的体验。

![The 3 Next.js Conf ticket themes side-by-side.](images/improve-the-accessibility-of-your-next_js-site-vercel/img_002.jpg)The 3 Next.js Conf ticket themes side-by-side.

![三款 Next.js Conf 门票主题并排展示。](images/improve-the-accessibility-of-your-next_js-site-vercel/img_002.jpg)三款 Next.js Conf 门票主题并排展示。

For the descriptions for the ticket themes, we could quickly add some alt text by doing something like:

针对门票主题的描述，我们可快速添加如下替代文本（alt text）：

1. Ticket theme #1

1. 门票主题 #1

2. Ticket theme #2

2. 门票主题 #2

3. Ticket theme #3

3. 门票主题 #3


### Better descriptions

### 更优的描述

While this naively fulfills the basics of the alt text requirement for image, these descriptions don't match the visual interest of the graphics. Instead, we can make sure that our descriptions ensure a similar experience for non-visual users:

虽然上述写法粗略满足了图像替代文本的基本要求，但这些描述远未体现原图所具有的视觉趣味性。相反，我们应精心撰写描述，力求为非视觉用户提供与观图者相近的体验：

1. A black and white theme featuring an image of light rays exiting a prism in three directions. The light rays are not vertical but leave the prism at various angles, creating a dynamic composition.

1. 黑白配色主题，主视觉为一束光经棱镜折射后向三个方向发散的图像：光线并非垂直射出，而是以不同角度离开棱镜，从而构成一幅富于动感的画面。

2. 一种彩色主题，展示一束光线穿过棱镜后向三个方向发散的图像。光线经棱镜折射后分离成一道彩虹，充分展现光的完整动态范围。

2. 一种彩色主题，展示一束光线穿过棱镜后向三个方向发散的图像。光线经棱镜折射后分离成一道彩虹，充分展现光的完整动态范围。

3. 一种纯粹的照明形态：全白棱镜配以三条出射光束，实属罕见景象。这一特别版本突显了白光本身的简洁性与璀璨光芒。

3. 一种纯粹的照明形态：全白棱镜配以三条出射光束，实属罕见景象。这一特别版本突显了白光本身的简洁性与璀璨光芒。

**核心要点（Takeaway）**: 您的替代文本（alt text）应准确描述视觉用户所见的图像，从而为非视觉用户提供同等质量的信息体验。

**核心要点（Takeaway）**: 您的替代文本（alt text）应准确描述视觉用户所见的图像，从而为非视觉用户提供同等质量的信息体验。

## 借助输入错误提示传递信息

## 借助输入错误提示传递信息

屏幕阅读器（Screen readers）是一类辅助软件，帮助视障用户理解并操作其设备。对于网页应用而言，屏幕阅读器能够解析页面内容，并将当前可执行的操作与可用信息传达给用户。由于屏幕阅读器高度依赖 HTML 的语义结构，若表单实现方式过于简单粗略（naive），可能导致部分访客难以与其正常交互。

屏幕阅读器（Screen readers）是一类辅助软件，帮助视障用户理解并操作其设备。对于网页应用而言，屏幕阅读器能够解析页面内容，并将当前可执行的操作与可用信息传达给用户。由于屏幕阅读器高度依赖 HTML 的语义结构，若表单实现方式过于简单粗略（naive），可能导致部分访客难以与其正常交互。

如果您的设计未对表单错误提示的呈现方式施加限制，那么建议采用 [原生表单验证](https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation#what_is_form_validation)，因为其默认具备良好的可访问性。然而，在许多实际场景中，我们希望自主控制错误提示的显示方式。

如果您的设计未对表单错误提示的呈现方式施加限制，那么建议采用 [原生表单验证](https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation#what_is_form_validation)，因为其默认具备良好的可访问性。然而，在许多实际场景中，我们希望自主控制错误提示的显示方式。

![A screenshot of the email input on the Next.js Conf website with an error message saying “Please enter a valid email address”.](images/improve-the-accessibility-of-your-next_js-site-vercel/img_003.jpg)  
Next.js Conf 网站上邮箱输入框的截图，其中显示错误提示：“请输入有效的电子邮件地址”。

![A screenshot of the email input on the Next.js Conf website with an error message saying “Please enter a valid email address”.](images/improve-the-accessibility-of-your-next_js-site-vercel/img_003.jpg)  
Next.js Conf 网站上邮箱输入框的截图，其中显示错误提示：“请输入有效的电子邮件地址”。

您很可能已多次见过此类输入框设计——但它们是否始终以尽可能高的可访问性标准构建？让我们来看一个基础、未经优化（naive）的实现示例：

您很可能已多次见过此类输入框设计——但它们是否始终以尽可能高的可访问性标准构建？让我们来看一个基础、未经优化（naive）的实现示例：

```jsx
const EmailForm = () => {

2  const [errorMessage, setErrorMessage] = useState(null);
```

4  const onChangeHandler = () => { /* Code to handle change */ }

4  const onChangeHandler = () => { /* 处理变更的代码 */ }

5  const onSubmitHandler = () => { /* Code to handle success or error */ }

5  const onSubmitHandler = () => { /* 处理成功或错误的代码 */ }

7  return (

7  return (

8    <form onSubmit={onSubmitHandler}>

8    <form onSubmit={onSubmitHandler}>

9      <label htmlFor="email">Email</label>

9      <label htmlFor="email">邮箱</label>

10      <input id="email" name="email" onChange={onChangeHandler} />

10      <input id="email" name="email" onChange={onChangeHandler} />

11        {

11        {

12          errorMessage && <p>{errorMessage}</p>

12          errorMessage && <p>{errorMessage}</p>

13        }

14    </form>

15  )

16}
```

这一实现看似正确，因为它在发生错误时会显示错误消息。

然而，辅助技术用户在错误消息出现时并不会收到通知。他们只有在浏览页面时偶然遇到该消息，才会意识到错误的存在。

屏幕阅读器（screen reader）是一种软件，可帮助视障用户理解并与其设备进行交互。对于网页应用而言，屏幕阅读器能够解析并传达页面上可用的操作与信息。由于屏幕阅读器依赖 HTML 的语义结构，我们下面这种简单的实现无法让屏幕阅读器将错误消息与其对应的输入框关联起来。让我们对错误消息所在代码行做几处细微调整：

```jsx
const EmailForm = () => {

2  const [errorMessage, setErrorMessage] = useState(null);
```

4  const onChangeHandler = () => { /* Code to handle change */ }

4  const onChangeHandler = () => { /* 处理变更的代码 */ }

5  const onSubmitHandler = () => { /* Code to handle success or error */ }

5  const onSubmitHandler = () => { /* 处理成功或错误的代码 */ }

7  return (

7  return (

8    <form onSubmit={onSubmitHandler}>

8    <form onSubmit={onSubmitHandler}>

9      <input onChange={onChangeHandler} />

9      <input onChange={onChangeHandler} />

10        <p role="alert" aria-atomic="true">{errorMessage}</p>

10        <p role="alert" aria-atomic="true">{errorMessage}</p>

11      </form>

11      </form>

12  )

12  )

13}
```
13}
```

First, we’ve made sure the `<p>` tag is always rendered and has the `role="alert"` attribute. For screen readers to announce changes, the element needs to already be on the DOM and have an `alert` role. Now, if the content of the `<p>` tag changes, assistive technologies will be able to call out this change.

首先，我们确保 `<p>` 标签始终被渲染，并带有 `role="alert"` 属性。为了让屏幕阅读器播报内容变化，该元素必须已存在于 DOM 中，且具有 `alert` 角色。现在，当 `<p>` 标签的内容发生变化时，辅助技术便能及时播报这一变更。

Last, we’ve added the `aria-atomic="true"` attribute. This tells assistive technologies to announce the full contents of the `<p>` tag when a change is detected. Without this, an assistive technology will only announce the difference between the last and current contents.

最后，我们添加了 `aria-atomic="true"` 属性。该属性指示辅助技术在检测到变化时，播报 `<p>` 标签的全部内容；否则，辅助技术仅会播报当前内容与上一次内容之间的差异部分。

**Takeaway**: Make sure error messages notify assistive technology users by using the correct HTML semantics.

**要点总结**：请务必通过正确的 HTML 语义化标记，确保错误信息能够有效通知使用辅助技术的用户。

## Reduce motion according to user preferences

## 根据用户偏好减少动画效果

It is important to respect a user’s preference for reduced motion, a setting that all major browsers and operating systems support. For some users, excessive motion can cause motion sickness. For others, it can be distracting.

尊重用户的“减少动画”偏好至关重要——该设置已获得所有主流浏览器和操作系统的支持。对部分用户而言，过度的动画可能引发晕动症；对另一些用户，则可能造成注意力分散。

We can use the CSS media query `prefers-reduced-motion` to detect this preference. On the Next.js Conf registration page, we do a few things when we see this :

我们可以使用 CSS 媒体查询 `prefers-reduced-motion` 来检测该偏好设置。在 Next.js Conf 注册页面中，一旦检测到该设置，我们会执行以下几项操作：

1. Decrease the brightness intensity of the prism

1. 降低棱镜（prism）的亮度强度

2. Pause looping animations after 5 seconds

2. 循环动画播放 5 秒后暂停

3. Disable transform and layout animations while keeping animations for other properties like `opacity` and `background-color`.

3. 禁用 `transform` 和布局相关的动画，但保留其他属性（如 `opacity` 和 `background-color`）的动画效果。

**Takeaway**: Animations don’t enhance the user experience for everyone. Because of that, we need to provide an opt-out mechanism for animations.

**要点总结**：动画并非对所有用户都有助于提升体验；因此，我们必须为动画提供可关闭（opt-out）的机制。

## Making Vordle accessible

## 让 Vordle 具备无障碍访问能力

The registration page also features a word game, Vordle, that gives players six chances to guess a five letter word, giving feedback about letters that were correct after each attempt.

注册页面还包含一款文字游戏——Vordle，玩家共有六次机会猜出一个五字母单词，每次尝试后都会获得关于字母是否正确的反馈。

Building an accessible game is similar to building an accessible static site—but with a few extra considerations. We had three goals when developing Vordle’s accessibility:

构建一款具备无障碍访问能力的游戏，与构建一个具备无障碍访问能力的静态网站类似——但需额外考虑若干因素。我们在开发 Vordle 的无障碍功能时设定了三个目标：

1. Complete keyboard, mouse, and touch support  
   1. 完整支持键盘、鼠标和触控操作  

2. _Look_ fantastic for visual users  
   2. _视觉效果_ 对明眼用户而言惊艳出众  

3. _Sound_ fantastic for auditory ones  
   3. _听觉体验_ 对听觉型用户而言同样出色  

The `<table>` element works well with screen readers and visual users alike and fits our design perfectly. This meets our first goal well: providing a standardized structure and navigation for both display and screen reader users.

`<table>` 元素对屏幕阅读器用户和视觉用户均友好，且完美契合我们的设计。这很好地实现了我们的第一个目标：为视觉界面用户和屏幕阅读器用户同时提供标准化的结构与导航方式。

![A screenshot of the Vordle board, showing six rows containing the following five letter words, one per row: SMOKE, REACT, TRIED, EXITS, EPOCH, SCARE. Letters have orange, green, or gray borders around them. ](images/improve-the-accessibility-of-your-next_js-site-vercel/img_004.jpg)  
![Vordle 游戏板截图：共六行，每行显示一个五字母单词，依次为：SMOKE、REACT、TRIED、EXITS、EPOCH、SCARE；每个字母外围分别带有橙色、绿色或灰色边框。](images/improve-the-accessibility-of-your-next_js-site-vercel/img_004.jpg)  
A screenshot of the Vordle board, showing six rows containing the following five letter words, one per row: SMOKE, REACT, TRIED, EXITS, EPOCH, SCARE. Letters have orange, green, or gray borders around them.  
Vordle 游戏板截图：共六行，每行显示一个五字母单词，依次为：SMOKE、REACT、TRIED、EXITS、EPOCH、SCARE；每个字母外围分别带有橙色、绿色或灰色边框。

For sighted users, visual clues like animations and colors provide context on the game’s progress and current state. However, to meet our second goal, we also needed an equally descriptive representation of the game state for screen reader users. We used a few strategies to accomplish this:

对于明眼用户而言，动画、颜色等视觉线索能清晰传达游戏进度与当前状态。然而，为实现我们的第二个目标，我们也需要为屏幕阅读器用户提供同等详尽的游戏状态描述。为此，我们采用了以下几种策略：

- Each row in the table contains a table heading element with descriptive text of their word's score. For example, the first row containing `SCARE` above would read:  
  - 表格中的每一行均包含一个表格标题元素（`<th>`），其中以描述性文字说明该行单词的评分结果。例如，上方包含 `SCARE` 的第一行将被读作：

> _猜词游戏（6选1）：你猜的是“smoke”，但答案不正确。你所猜的字母中，部分存在于目标单词中：“s”不在目标单词中，“m”不在目标单词中，“o”不在目标单词中，“k”不在目标单词中，“e”在目标单词中，但位置错误。_

> _猜词游戏（六选一）：你猜测的单词是“smoke”，但答案不正确。你所猜的字母中，部分确实存在于目标单词中：“s”不在目标单词中，“m”不在目标单词中，“o”不在目标单词中，“k”不在目标单词中；而“e”存在于目标单词中，但位置错误。_

- 页面上有一个视觉上隐藏的 `<h1>` 元素（该元素将由 [Next.js 路由播报器（route announcer）在页面跳转时自动播报](https://nextjs.org/docs/accessibility#route-announcements)），用于向用户说明游戏规则、输入框自动聚焦机制，以及前述表格的功能。该 `<h1>` 同时也作为语义化地标（landmark），便于辅助技术用户快速定位与导航。

- 我们使用一个视觉上隐藏的表格 `<caption>` 元素，向屏幕阅读器用户清晰解释游戏玩法。

- 页面上设有一个视觉隐藏的 `<h1>` 元素（该元素将由 [Next.js 路由播报器（route announcer）在页面跳转时自动播报](https://nextjs.org/docs/accessibility#route-announcements)），用于说明游戏规则、输入框自动聚焦机制，以及前述表格的功能。该 `<h1>` 同时也作为语义化地标（landmark），便于辅助技术用户快速定位与导航。

- 我们使用一个视觉隐藏的表格 `<caption>` 元素，向屏幕阅读器用户清晰说明游戏玩法。

这些细节确保了游戏本身具备良好的可访问性；此外，我们还实现了一项额外的无障碍友好功能：当你通过 OpenGraph 图像分享你的游戏成绩时，可以利用 `og:image:alt` 属性来描述图像所表达的内容。

例如，下方所示的游戏截图将在 OpenGraph 描述中包含如下文字：

> _……Vordle 游戏棋盘界面，玩家共有六次机会猜测一个秘密的五字母单词。棋盘由六行、每行五个圆圈组成。在第一次猜测中……_

一张 Guillermo Rauch（@rauchg）发布的推文截图，文字内容为：“Vordle 2 5/6 😅 动态无界。#nextjsconf”，其下方附有一张 OpenGraph 图像。

**关键要点**：若希望你自己的 OpenGraph 图像具备可访问性，请务必在 `og:image:alt` 元标签中添加准确、详实的替代文本（alt text）。部分网站（如 Twitter）还支持自有标签（例如 `twitter:image:alt`），但在解析优先级上，会优先采用 `<title>` 标签内容，其次才是 `image:alt`。

### 倾听用户的声音

用户是让网站真正惠及所有人的最宝贵资源。理想情况下，我们希望能在问题发生前就发现并修复所有缺陷——然而，现实中数以十万计的用户各自以独特方式体验网页，这种多样性几乎无法被完全模拟或复现。因此，真实用户的反馈至关重要。

### 倾听用户的声音

用户是让网站真正惠及所有人的最宝贵资源。理想情况下，我们希望能在问题发生前就发现并修复所有缺陷——然而，现实中数以十万计的用户各自以独特方式体验网页，这种多样性几乎无法被完全模拟或复现。因此，真实用户的反馈至关重要。

After the registration site was released to the public, several individuals on Twitter and one of our own engineers reached out about the Vordle game being unplayable for them. In our work to make the game accessible for screen-readers, we fell short for those with color-blindness.

注册网站向公众开放后，几位推特用户以及我们自己的一名工程师联系了我们，反映 Vordle 游戏对他们而言无法正常游玩。在致力于提升游戏对屏幕阅读器的可访问性过程中，我们却忽略了色觉障碍用户的使用需求。

To help well-sighted developers, browsers provide some tools for emulating vision deficiencies. We will discuss tooling more deeply in a moment—but first here’s what the Vordle game board looks like when emulating Deuteranopia, a form of red-green color-blindness:

为帮助视力正常的开发者，主流浏览器提供了一些模拟视觉缺陷的工具。我们稍后将更深入地探讨这些工具——但首先，请看下图：这是在模拟“绿色盲”（Deuteranopia，一种红绿色觉障碍）时的 Vordle 游戏界面：

![A screenshot of a Vordle gameboard emulating red-green color-blindness. The green colors to indicate exactly correct letters are now impossible to see.](images/improve-the-accessibility-of-your-next_js-site-vercel/img_005.jpg)  
![模拟红绿色盲的 Vordle 游戏界面截图：用于标示字母完全正确的绿色现已完全不可见。](images/improve-the-accessibility-of-your-next_js-site-vercel/img_005.jpg)

A screenshot of a Vordle gameboard emulating red-green color-blindness. The green colors to indicate exactly correct letters are now impossible to see.

一张模拟红绿色盲的 Vordle 游戏界面截图：用于标示字母完全正确的绿色现已完全不可见。

To remedy the situation, we introduced some iconography that provides users with an additional way to perceive the state of the game.

为解决这一问题，我们引入了图标系统，为用户提供另一种感知游戏状态的方式。

![A Vordle board showing how we added icons to indicate correct guesses. Previously, only colors were being used so users with red-green colorblindness could not play the game.](images/improve-the-accessibility-of-your-next_js-site-vercel/img_006.jpg)  
![一张 Vordle 游戏界面图，展示我们如何添加图标来标示正确猜测：此前仅依赖颜色，导致红绿色盲用户无法游玩该游戏。](images/improve-the-accessibility-of-your-next_js-site-vercel/img_006.jpg)

A Vordle board showing how we added icons to indicate correct guesses. Previously, only colors were being used so users with red-green colorblindness could not play the game.

一张 Vordle 游戏界面图，展示我们如何添加图标来标示正确猜测：此前仅依赖颜色，导致红绿色盲用户无法游玩该游戏。

With this change, Vordle is now enjoyable for every user—no matter their form of sightedness.

通过这一改进，Vordle 现在已能为所有用户带来愉悦体验——无论其视力状况如何。

- Sighted users can enjoy a fully visual experience.  
- Color blind users have iconography to indicate the accuracy of their guesses.  
- Low or unsighted users can follow audio cues to make their way to correct answers.

- 视力正常的用户可享受完整的视觉体验；  
- 色觉障碍用户可通过图标识别猜测结果的准确性；  
- 视力低下或全盲用户则可借助语音提示逐步获得正确答案。

**Takeaway**: Don’t use color as the only signifier for state.

**关键要点**：切勿仅依赖颜色作为状态的唯一标识方式。

## Accessibility tooling for developers

## 面向开发者的无障碍工具

There are many tools and plenty of documentation to help us build accessible applications today. Here’s a list of what we used during our process:

如今，有大量工具和丰富的文档可帮助我们构建无障碍应用。以下是我们在开发过程中所使用的工具列表：

1. **The axe Browser Extension**: Audits and teaches you about best practices. Enable automated checks to walk you through the spec in plain language. [Visit the extension's home page](https://www.deque.com/axe/browser-extensions/) to add it to your workflow.

1. **axe 浏览器扩展程序**：执行无障碍审计，并指导你掌握最佳实践。启用自动化检测功能，即可用通俗易懂的语言引导你逐步理解相关规范。[访问该扩展程序的主页](https://www.deque.com/axe/browser-extensions/)，将其添加至你的开发工作流中。

2. **Screen readers**: A great way to tell if you’ve built an accessible UI is by using a screen reader yourself. [Here’s a list of screen readers based on your OS](https://www.a11yproject.com/resources/#screen-readers).

2. **屏幕阅读器**：亲自使用屏幕阅读器，是检验你所构建的用户界面是否真正无障碍的最佳方式之一。[此处按操作系统分类列出了常用屏幕阅读器](https://www.a11yproject.com/resources/#screen-readers)。

3. **Browsers devtools:** Modern browsers have built-in tools for working on accessibility. For example, Chrome’s visual deficiency emulation is great for making sure that the colors you’re using are accessible to folks with different types of vision deficiencies.

3. **浏览器开发者工具**：现代浏览器内置了专用于无障碍开发的工具。例如，Chrome 提供的视觉缺陷模拟功能，能有效帮助你验证所选颜色是否对各类视觉障碍用户均具备可访问性。

[Here’s a guide on how to use it](https://addyosmani.com/blog/emulate-vision-deficiencies-devtools/). Additionally, [the accessibility pane](https://developer.chrome.com/docs/devtools/accessibility/reference/#pane) helps you debug for information that assistive technologies use.

[此处是一份使用指南](https://addyosmani.com/blog/emulate-vision-deficiencies-devtools/)。此外，[无障碍面板（Accessibility Pane）](https://developer.chrome.com/docs/devtools/accessibility/reference/#pane) 可协助你调试辅助技术所依赖的信息。

4. **Web Accessibility Documentation**: [a11y Project,](https://www.a11yproject.com/) [the MDN accessibility area](https://developer.mozilla.org/en-US/docs/Learn/Accessibility), and [the WCAG website](https://www.w3.org/WAI/standards-guidelines/wcag/) all provide extensive information on web accessibility.

4. **网页无障碍文档资源**：[a11y Project](https://www.a11yproject.com/)、[MDN 的无障碍专题页面](https://developer.mozilla.org/en-US/docs/Learn/Accessibility)，以及 [WCAG 官网](https://www.w3.org/WAI/standards-guidelines/wcag/) 均提供了关于网页无障碍的详尽资料。

There are many tools that will help us build accessible websites, but the best way is to have real developers and users who rely on assistive technologies build and use your website. Building empathy for assistive technology users takes time and the best way to build that relationship is by talking to your users.

尽管有许多工具可助力我们构建无障碍网站，但最有效的方式，仍是让真正依赖辅助技术的开发者与用户参与网站的设计、开发与使用。培养对辅助技术使用者的共情能力需要时间，而建立这种关系的最佳途径，就是与你的用户直接交流。

## Headed to Next.js Conf?

## 即将参加 Next.js Conf 吗？

[Visit the Next.js Conf registration page](https://nextjs.org/conf) to see our accessibility changes in action—and sign up to get your free ticket if you haven’t yet! We’re looking forward to the most popular, most accessible Next.js Conf we’ve ever held. See you there.

[访问 Next.js Conf 注册页面](https://nextjs.org/conf)，亲身体验我们所实施的无障碍改进——若您尚未注册，欢迎立即报名领取您的免费入场券！我们期待举办迄今为止人气最高、无障碍体验最佳的一届 Next.js Conf。现场见！

Want to get started with Next.js on Vercel? [Here's a trial](https://vercel.com/signup?next=/dashboard?createTeam=true) to get you deploying on the only infrastructure that will always support the latest Next.js features the moment they release.

想在 Vercel 上快速开始使用 Next.js？[点击此处试用](https://vercel.com/signup?next=/dashboard?createTeam=true)，立即在唯一能够于新功能发布第一时间即提供支持的基础设施上部署应用。

[![Guillermo Rauch](images/improve-the-accessibility-of-your-next_js-site-vercel/img_007.jpg)](https://x.com/rauchg/status/1566083702836170754)

[![吉列尔莫·劳赫](images/improve-the-accessibility-of-your-next_js-site-vercel/img_007.jpg)](https://x.com/rauchg/status/1566083702836170754)

[Guillermo Rauch](https://x.com/rauchg/status/1566083702836170754)

[吉列尔莫·劳赫](https://x.com/rauchg/status/1566083702836170754)


· [关注](https://x.com/intent/follow?screen_name=rauchg)

· [关注](https://x.com/intent/follow?screen_name=rauchg)

[View on Twitter](https://x.com/rauchg/status/1566083702836170754)

在 Twitter 上查看

Vordle 2 5/6 😅

Vordle 第2关，5/6 😅

Dynamic without limits. [#nextjsconf](https://x.com/hashtag/nextjsconf) [nextjs.org/conf/tickets/o…](https://nextjs.org/conf/tickets/oct22/rauchg/20220903)

无限动态能力。[#nextjsconf](https://x.com/hashtag/nextjsconf) [nextjs.org/conf/tickets/o…](https://nextjs.org/conf/tickets/oct22/rauchg/20220903)

[11:20 AM · Sep 3, 2022](https://x.com/rauchg/status/1566083702836170754) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[上午11:20 · 2022年9月3日](https://x.com/rauchg/status/1566083702836170754) [Twitter 网站工具、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[41](https://x.com/intent/like?tweet_id=1566083702836170754) [Reply](https://x.com/intent/tweet?in_reply_to=1566083702836170754)

[41 次点赞](https://x.com/intent/like?tweet_id=1566083702836170754) [回复](https://x.com/intent/tweet?in_reply_to=1566083702836170754)


[Read 2 replies](https://x.com/rauchg/status/1566083702836170754)

阅读 2 条回复
{% endraw %}
