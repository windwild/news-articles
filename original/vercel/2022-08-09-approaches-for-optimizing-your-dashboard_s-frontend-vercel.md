---
title: "Approaches for optimizing your dashboard's frontend - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-we-made-the-vercel-dashboard-twice-as-fast"
date: "2022-08-09"
scraped_at: "2026-03-02T10:01:00.869932163+00:00"
language: "en"
translated: false
description: "Let’s review the techniques and strategies we used to improve the Vercel Dashboard so you can make a data-driven impact on your application. "
---




Aug 9, 2022

Techniques and strategies we used to optimize your Dashboard for better UX.

We want to keep the Vercel Dashboard fast for every customer, especially as we add and improve features. Aiming to lift our [Core Web Vitals](https://vercel.com/blog/core-web-vitals), our Engineering Team took the Lighthouse score for our Dashboard from 51 to 94.

We were able to confirm that our improvements had a real impact on our users over time using [Vercel Analytics](https://vercel.com/analytics), noting that our Vercel Analytics scores went from 90 to 95 on average (desktop). Let’s review the techniques and strategies we used so you can make a data-driven impact on your application.

## Optimize what matters most

Your users expect pages to load quickly. Certain parts of your application will have an outsized impact on performance depending on how frequently they are executed or how heavy their workload is. Let’s refer to these as “hot paths.”

On frontend applications, the hot path typically performs initial page loads. Cutting down time on your hot path means faster page loads, better UX, and better Core Web Vitals. We were able to improve [First Contentful Paint (FCP), Largest Contentful Paint (LCP), and First Input Delay (FID)s](https://web.dev/metrics/) using a few powerful tools.

![Improving page performance leads to better user experience and lifts SEO.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_001.jpg)![Improving page performance leads to better user experience and lifts SEO.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_002.jpg)![Improving page performance leads to better user experience and lifts SEO.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_001.jpg)![Improving page performance leads to better user experience and lifts SEO.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_002.jpg)Improving page performance leads to better user experience and lifts SEO.

## Tools to guide you

To find out what code lives on your hot path, use [Chrome's Devtools](https://developer.chrome.com/docs/devtools/evaluate-performance/) and [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en). Chrome Devtools are great for debugging any web application, while React Developer Tools specifically diagnose React applications. These tools will produce flame graphs, charts, and timelines that allow you to take a deeper look at your application.

But Devtools will only tell you part of the story—a single point in time. You can diagnose the page that you just loaded—but what if we had a way to determine which paths are the most important to our application over time?

With Vercel, [Top Paths](https://vercel.com/docs/concepts/limits/usage#top-paths) answers this question. Top Paths shows you which assets your site’s users are downloading most often and how heavy those paths are.

You’ll be able to quickly find which images, static data, and other assets are the most important ones for you to optimize, focusing your efforts where they matter most. Top Paths is currently available for all Vercel plans.

![Vercel Top Paths show the heaviest asset payloads being used in your project.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_005.jpg)![Vercel Top Paths show the heaviest asset payloads being used in your project.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_006.jpg)![Vercel Top Paths show the heaviest asset payloads being used in your project.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_005.jpg)![Vercel Top Paths show the heaviest asset payloads being used in your project.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_006.jpg)Vercel Top Paths show the heaviest asset payloads being used in your project.

## Your page–faster

Now that we know where to look, let’s figure out how to get those paths shorter.

After identifying the hot path on the Dashboard, we were able to find plenty of high value opportunities. Here are some of the strategies we used to improve the performance of the Vercel Dashboard.

### JavaScript

JavaScript gives the page interactivity, but is also the heaviest, slowest asset we send to the browser in modern applications. For performance, the less JavaScript, the better.

**Be mindful of your utility functions.**

Our `isLoggedIn()` utility checks for a user's authentication by reading a `document.cookie` value. This is quick when it happens once - but we were calling `isLoggedIn()` over 400 times in one render pass.

With some rearchitecting, we were able to remove many of these calls, bringing a ~270ms render time down to just ~90ms.

**Leverage the effects of caching.**

On the Vercel Dashboard, we are using a `slugify` function that takes 1-3ms to evaluate. While that’s fast only once, we were calling this function hundreds of times for our initial render. Once we cached the computed results, we made the render process ~200ms faster.

```javascript
1// Create a cache using an empty object

const slugifyCache = { }



const cachedSlugify = (text: string) => {

5  // If this value has already been computed,

6  // it will be a property on the cache object.

7  if (slugifyCache[text]) {

8    return slugifyCache[text]

9  }



11  // If this is the first time we are seeing this string,

12  // we will store it in our cache and return the slug.

13  return (slugifyCache[text] = slugify(text))

14}
```

**Know your imported code.**

Libraries often have to cover all sorts of edge cases to take care of thousands of developers. While that provides for a generally safe experience, that safety often means more code to execute.

Does your use case of the library need to cover those edge cases? If not, can you write your own function in a more efficient way?

**Strategically lazy load heavy components**.

Elements that aren’t in your user’s viewport on page load can have their render delayed. First, let's build a hook for detecting if an element is in the viewport.

```jsx
const useInViewport = (ref: any) => {

2  const [isInViewport, setIsInViewport] = useState(false)

3  const [isLoaded, setIsLoaded] = useState(false)



5  useEffect(() => {

6    const observer = new IntersectionObserver(

7      ([entry]) => {

8        if (entry.isIntersecting) {

9          setIsLoaded(true)

10        }



12        setIsInViewport(entry.isIntersecting)

13      }

14    )



16    if (ref.current) {

17      observer.observe(ref.current)

18    }

19  }, [ref])



21  return  isInViewport || isLoaded

22}
```

Now, let's use it. The `200vh` element will push the `<HeavyChildComponent />` below our viewport on page load. Before you scroll down, check your browser's Devtools. You'll notice that the HTML markup for this React component hasn't loaded into the DOM yet.

```jsx
const HeavyChildComponent = () => {

2  return (

3    <div>

4      <p>I am a heavy component!</p>

5    </div>

6  )

7}



const ParentComponent = () => {

10  const childRefContainer = useRef(false)

11  const isRendered = useInViewport(childRefContainer)



13  return (

14    <>

15      <div style={{height: "200vh"}}></div>

16        <div ref={childRefContainer as any}>

17          { isRendered && <HeavyChildComponent /> }

18        </div>

19    </>

20  )

21}
```

**Third-party scripts**

You’ll often need to introduce third-party scripts for analytics, A/B testing, and more. While these scripts can have negative impacts on page performance, we can minimize their effects on LCP and FID with the right techniques.

- Most popular packages use “tree-shaking” to remove unused code automatically for the smallest JavaScript bundles. Ensure you’re using correct ES Modules imports as shown below.


```javascript
1// Before

2// This line imports the entire Sentry package!

import Sentry from '@sentry/nextjs'



5// After

6// Only bring in the code that it needs.

import { captureException } from '@sentry/nextjs'
```

- Some packages ( [like Stripe](https://github.com/stripe/stripe-js#importing-loadstripe-without-side-effects)) have the ability to lazy load their `script` until your user needs it. Less initial code, quicker page loads.

- Choosing the right `next/script` strategy is crucial to improving the performance of your third party scripting. For example, Google Tag Manager can be lazily loaded to noticeably improve LCP and FID. Check [the strategies included in the next/script documentation for more](https://nextjs.org/docs/basic-features/script#strategy).


### HTML + CSS

Optimizing HTML and CSS offers us the smallest performance gains because of how quickly modern browsers parse the DOM. But we can still find small wins that add up to meaningful change.

**Find needless markup duplications.**

React makes it easy to reuse code. This is great—but has a dark side since we can also reuse _unoptimized_ code. If you’re introducing purposeless tags in your JSX, eliminate them. If you’re writing the same CSS multiple times, think about some reusable CSS class declarations.

```jsx
1// Before

const Paragraph = (props) => {

3  return (

4    <div>

5      <p>{ props.children }</p>

6    </div>

7  )

8}



10// After

const Paragraph = (props) => {

12  return (

13    // No more wrapper div! The p tag already defaults to display: block;

14    // so this change won't change the final render.

15    <p style={{ props.style }}>{ props.children }</p>

16  )

17}
```

**Leverage Next.js optimizations.**

`<Image />` will deliver the optimal image size for your user’s device, ensuring minimal image processing, and, in turn, speeding up page loads. Additionally, Next.js will [automatically inline font CSS](https://nextjs.org/docs/basic-features/font-optimization) at build time, eliminating an extra fetch for font declarations.

```jsx
1// Before

const ImageWithCaption = (props) =>  {

3  return (

4    <figure>

5      // Image source is way too large for mobile!

6      <img src="./images/sample-img.png" alt="This is a sample image!" />

7      <figcaption>{props.figCaption}</figcaption>

8    </figure>

9  )

10}



12// After

import Image from "next/image"



const ImageWithCaption = (props) =>  {

16  return (

17    <figure>

18      // Delivers correct size for user

19      <Image

20        src="./images/sample-img.png"

21        alt="This is a sample image!"

22        layout="responsive"

23        width={200}

24        height={100}

25      />

26      <figcaption>{props.figCaption}</figcaption>

27    </figure>

28  )

29}
```

**Use variable fonts.**

Traditional font files contain only one font face—but you'll need many variations to create beautiful typefaces for your application. Variable fonts can load **just one file** to define a `@font-face` rule for _every_ variation of your font.

```javascript
1@font-face {

2  font-family:'Inter';

3  src:url('Inter.woff2')format('woff2')tech('variations'),

4  url('Inter')format('woff2-variations');

5  font-weight: 100 1000; // Range for declarations of the property

6  font-stretch: 25% 150%;

7}
```

**Let the browser work for you.**

Assigning properties to their browser defaults can add up over time—without bringing any new styles to the page. Continue reducing the size of your markup by letting the browser use its defaults rather than declaring those CSS properties yourself.

```jsx
1// Before

const ReusableSection = ( props ) => {

3  return (

4    // Setting 0 for the margin is the browser default.

5    // This will have no styling effect,

6    // but it will add bloat to your final HTML.

7    <div style={{ marginTop: props.marginTop || 0 }}>

8      <p style={{ paddingBottom: props.paragraphBottomPad || 0 }}>

9        {props.paragraph}

10      </p>

11    </div>

12  )

13}



15// After

const ReusableSection = (props) => {

17  return (

18    // This style tag will no longer be a part of your final HTML.

19    <div style={{ marginTop: props.marginTop || undefined }}>

20      <p style={{ paddingBottom: props.paragraphBottomPad || undefined }}>

21        {props.paragraph}

22      </p>

23    </div>

24  )

25}
```

## Use data to improve user experience

As your application grows, it can be hard to maintain performance. Scaling can be difficult. New features are often in high demand. And the needs of a growing business can take the focus off of application performance.

[Vercel Analytics](https://vercel.com/docs/concepts/analytics) and [Top Paths](https://vercel.com/docs/concepts/limits/usage#top-paths) allowed us to quickly peek into our Dashboard and find where it was underperforming. That meant less time diagnosing, and a better opportunity for our developers to focus on performance.

As a part of our continued effort to help developers improve their application performance, we're looking to add automated reporting on regressions for your Vercel Analytics data.

![Vercel Analytics show how your application is performing over time for real users.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_009.jpg)![Vercel Analytics show how your application is performing over time for real users.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_010.jpg)![Vercel Analytics show how your application is performing over time for real users.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_009.jpg)![Vercel Analytics show how your application is performing over time for real users.](images/approaches-for-optimizing-your-dashboard_s-frontend-vercel/img_010.jpg)Vercel Analytics show how your application is performing over time for real users.

Enable [Analytics](https://vercel.com/analytics) today by visiting the Analytics tab in your project dashboard or [try it free with a team on Vercel Pro](https://vercel.com/signup?next=/dashboard?createTeam=true).