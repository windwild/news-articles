---
render_with_liquid: false
title: "Introducing OpenAI o3 and o4-mini | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-o3-and-o4-mini"
date: "2025-04-16"
scraped_at: "2026-03-02T10:13:06.246746894+00:00"
language: "en-US"
translated: false
description: "Our smartest and most capable models to date with full tool access"
tags: ["Release"]
---

April 16, 2025

[Release](https://openai.com/research/index/release/) [Product](https://openai.com/news/product-releases/)

# Introducing OpenAI o3 and o4-mini

[Try on ChatGPT(opens in a new window)](https://chatgpt.com/?openaicom-did=a5042d5f-3c39-49c3-adfa-1d3b047d85fa&openaicom_referred=true)



_**Update on June 10, 2025:**_ **_OpenAI o3‑pro is now available to Pro users in ChatGPT, as well as in our API_** _. Like OpenAI o1‑pro, o3‑pro is a version of our most intelligent model, OpenAI o3, designed to think longer and provide the most reliable responses. Full details can be found in our_ [_release notes_ ⁠(opens in a new window)](https://help.openai.com/en/articles/9624314-model-release-notes) _._

* * *

Today, we’re releasing OpenAI **o3** and **o4-mini,** the latest in our o-series of models trained to think for longer before responding. These are the smartest models we’ve released to date, representing a step change in ChatGPT's capabilities for everyone from curious users to advanced researchers. For the first time, our reasoning models can agentically use and combine every tool within ChatGPT—this includes searching the web, analyzing uploaded files and other data with Python, reasoning deeply about visual inputs, and even generating images. Critically, these models are trained to reason about when and how to use tools to produce detailed and thoughtful answers in the right output formats, typically in under a minute, to solve more complex problems. This allows them to tackle multi-faceted questions more effectively, a step toward a more agentic ChatGPT that can independently execute tasks on your behalf. The combined power of state-of-the-art reasoning with full tool access translates into significantly stronger performance across academic benchmarks and real-world tasks, setting a new standard in both intelligence and usefulness.

## What’s changed

**OpenAI o3** is our most powerful reasoning model that pushes the frontier across **coding, math, science, visual perception**, and more. It sets a new SOTA on benchmarks including Codeforces, SWE-bench (without building a custom model-specific scaffold), and MMMU. It’s ideal for complex queries requiring multi-faceted analysis and whose answers may not be immediately obvious. It performs especially strongly at visual tasks like analyzing images, charts, and graphics. In evaluations by external experts, o3 makes 20 percent fewer major errors than OpenAI o1 on difficult, real-world tasks—especially excelling in areas like programming, business/consulting, and creative ideation. Early testers highlighted its analytical rigor as a thought partner and emphasized its ability to generate and critically evaluate novel hypotheses—particularly within biology, math, and engineering contexts.

**OpenAI o4-mini** is a smaller model optimized for fast, cost-efficient reasoning—it achieves remarkable performance for its size and cost, particularly in **math, coding, and visual tasks**. It is the best-performing benchmarked model on AIME 2024 and 2025. Although access to a computer meaningfully reduces the difficulty of the AIME exam, we also found it notable that o4-mini achieves 99.5% pass@1 (100% consensus@8) on AIME 2025 when given access to a Python interpreter. While these results should not be compared to the performance of models without tool access, they are one example of how effectively o4-mini leverages available tools; o3 shows similar improvements on AIME 2025 from tool use (98.4% pass@1, 100% consensus@8).

In expert evaluations, o4-mini also outperforms its predecessor, o3‑mini, on non-STEM tasks as well as domains like data science. Thanks to its efficiency, o4-mini supports significantly higher usage limits than o3, making it a strong high-volume, high-throughput option for questions that benefit from reasoning. External expert evaluators rated **both models** as demonstrating improved instruction following and more useful, verifiable responses than their predecessors, thanks to improved intelligence and the inclusion of web sources. Compared to previous iterations of our reasoning models, these two models should also feel more natural and conversational, especially as they reference memory and past conversations to make responses more personalized and relevant.

AIME 2024
Competition Math

o1o3-minio3 (no tools)o4-mini (no tools)Accuracy (%)74.387.391.693.4

AIME 2025
Competition Math

o1o3-minio3 (no tools)o4-mini (no tools)Accuracy (%)79.286.588.992.7

Codeforces
Competition Code

o1o3-minio3 (with terminal)o4-mini (with terminal)ELO1891207327062719

GPQA Diamond
PhD-Level Science Questions

o1o3-minio3 (no tools)o4-mini (no tools)Accuracy (%)78.077.083.381.4

Humanity’s Last Exam
Expert-Level Questions Across Subjects

o1-proo3-minio3 (no tools)o3 (python + browsing\*\*tools)o4-mini (no tools)o4-mini (with python +browsing\*\* tools)Deep researchAccuracy (%)8.1213.4020.3224.9014.2817.7026.60

### Multimodal

MMMU
College-level visual problem-solving

o1o3o4-miniAccuracy (%)77.682.981.6

MathVista
Visual Math Reasoning

o1o3o4-miniAccuracy (%)71.886.884.3

CharXiv-Reasoning
Scientific Figure Reasoning

o1o3o4-miniAccuracy (%)55.178.672.0

### Coding

SWE-Lancer: IC SWE Diamond
Freelance Coding Tasks

o1-higho3-mini-higho3-higho4-mini-high050000100000150000Dollars earned$43,958$33,833$86,100$65,792

SWE-Bench Verified (n=477)
Software Engineering

o1o3-minio3o4-miniAccuracy (%)48.949.369.168.1

_All SWE-bench evaluation runs use a fixed subset of n=477 verified tasks which have been validated on our internal infrastructure._

Aider Polyglot
Code Editing

o1-higho3-mini-higho3-higho4-mini-highAccuracy (%)64.4%(whole)61.7%(diff)66.7%(whole)60.4%(diff)81.3%(whole)79.6%(diff)68.9%(whole)58.2%(diff)

### Instruction following and agentic tool use

Scale MultiChallenge
Multi-turn instruction following

o1o3-minio3o4-miniAccuracy (%)44.9339.8956.5142.99

BrowseComp
Agentic Browsing

4o + browsingo3 with python +browsing\*o4-mini with python +browsing\*\*Deep researchAccuracy (%)1.949.728.351.5

Tau-bench
Function Calling

o1-higho3-mini-higho3-higho4-mini-highAccuracy (%)50.0%(Airline)70.8%(Retail)32.4%(Airline)57.6%(Retail)52.0%(Airline)73.9%(Retail)49.2%(Airline)71.8%(Retail)70.4%65.6%

_All models are evaluated at high ‘reasoning effort’ settings—similar to variants like ‘o4-mini-high’ in ChatGPT._

## Continuing to scale reinforcement learning

Throughout the development of OpenAI o3, we’ve observed that large-scale reinforcement learning exhibits the same **“more compute = better performance**” trend observed in GPT‑series pretraining. By retracing the scaling path—this time in RL—we’ve pushed an additional order of magnitude in both training compute and inference-time reasoning, yet still see clear performance gains, validating that the models’ performance continues to improve the more they’re allowed to think. At equal latency and cost with OpenAI o1, o3 delivers higher performance in ChatGPT—and we've validated that if we let it think longer, its performance keeps climbing.

We also trained both models to **use tools through reinforcement learning**—teaching them not just how to use tools, but to reason about when to use them. Their ability to deploy tools based on desired outcomes makes them more capable in open-ended situations—particularly those involving visual reasoning and multi-step workflows. This improvement is reflected both in academic benchmarks and real-world tasks, as reported by early testers.

## Thinking with images

![ChatGPT thinking with images](images/introducing-openai-o3-and-o4-mini-openai/img_001.png)

For the first time, these models can integrate images directly into their chain of thought. They don’t just see an image—they think with it. This unlocks a new class of problem-solving that blends visual and textual reasoning, reflected in their state-of-the-art performance across multimodal benchmarks.

People can upload a photo of a whiteboard, a textbook diagram, or a hand-drawn sketch, and the model can interpret it—even if the image is blurry, reversed, or low quality. With tool use, the models can manipulate images on the fly—rotating, zooming, or transforming them as part of their reasoning process.

These models deliver best-in-class accuracy on visual perception tasks, enabling it to solve questions that were previously out of reach. Check out the [visual reasoning research blog⁠](https://openai.com/index/thinking-with-images/) to learn more.

## Toward agentic tool use

OpenAI o3 and o4-mini have full access to tools within ChatGPT, as well as your own custom tools via function calling in the API. These models are trained to reason about how to solve problems, choosing when and how to use tools to produce detailed and thoughtful answers in the right output formats quickly—typically in under a minute.

For example, a user might ask: “How will summer energy usage in California compare to last year?” The model can search the web for public utility data, write Python code to build a forecast, generate a graph or image, and explain the key factors behind the prediction, chaining together multiple tool calls. Reasoning allows the models to react and pivot as needed to information it encounters. For example, they can search the web multiple times with the help of search providers, look at results, and try new searches if they need more info.

This flexible, strategic approach allows the models to tackle tasks that require access to up-to-date information beyond the model’s built-in knowledge, extended reasoning, synthesis, and output generation across modalities.

_All examples were completed with OpenAI o3._

## OpenAI o3

Solve the following very hard math problem using your in-built knowledge of the literature:

Construct a degree 19 polynomial \ (p(x)) \ in \ mathbb{C}\[x\] such that \ (X := \ {\\, p(x) = p(y) \\, \\} \ subset \ mathbb{P}^{1} \ times \ mathbb{P}^{1}\ ) has at least 3 (but not all linear) irreducible components over \ mathbb{C}. Choose \ (p(x)\ ) to be odd, monic, have real coefficients and linear coefficient \ (-19\ ) and calculate \ (p(19)\ ).

Reasoned about polynomial construction for 55 seconds

- The curve defined by p(x) = p(y) factors if p(x) is decomposable or has repeated factors. Actually, p(x)-p(y) always factors, and it’s divisible by (x-y). This gives one factor, and the rest is a degree d-1 polynomial in x and y. For the curve to have at least three irreducible components, p(x)-p(y) must factor into at least three nontrivial factors. Each factor corresponds to a component in projective space, and at least one must be nonlinear.
- I’m checking the Dickson polynomials D\_n(x,a) and focusing on their coefficients. With a=1, it seems the leading coefficient is always 1, confirming that Dickson polynomials are monic. The linear coefficient for odd n is following a predictable sign pattern: for n=19, it gives a coefficient of -19, which is exactly what I need. So the Dickson polynomial D\_n(x,1) with odd n fits nicely with the linear coefficient I was looking for.
- I've confirmed that the linear coefficient for p(x)=D19(x)p(x) = D\_{19}(x)p(x)=D19​(x) is correct, with the necessary scaling factor to match. Now for the next step, I need to compute D19(19)D\_{19}(19)D19​(19). Since Tn(z)T\_n(z)Tn​(z) grows quickly for real z>1z > 1z>1, I plan to compute this value using Python, leveraging the recurrence to avoid mistakes—it's going to be a big number. I'll make sure to present the numeric result neatly so it's understandable since the coefficients are integers.
- The Dickson polynomial D\_{19}(x,1) is confirmed to have the required properties: monic, odd, real coefficients, and a linear coefficient of -19. The factorization of D\_{19}(x) into irreducible components is also verified and satisfies the condition of having at least 10 components (1 linear + 9 quadratics). To compute p(19), we'll use the recurrence relation for Dickson polynomials, but there's also a closed-form expression involving cosine that could be handy here. I'll proceed accordingly!
- I confirmed the linear coefficient is working correctly, which means now I need to calculate p(19)=D19(19)p(19) = D\_{19}(19)p(19)=D19​(19). This involves evaluating T19(9.5)T\_{19}(9.5)T19​(9.5), which grows rapidly. To ensure I get an accurate result, I'll compute this using recurrence in Python. The result is a large number: 1,876,572,071,974,094,803,391,179. I'll use the commas to make it easier to read: p(19)=1,876,572,071,974,094,803,391,179p(19) = 1,876,572,071,974,094,803,391,179p(19)=1,876,572,071,974,094,803,391,179.
- For a = 1, there’s a relationship between Dickson polynomials and Chebyshev polynomials: D\_n(x, 1) = 2^(n-1) T\_n(x/2). Checking this, we see that the definition of D\_n(u + 1/u) aligns well with Chebyshev’s formula. By setting x = 2 cos(θ), we find that D\_n(x) equals 2 T\_n(x/2). Importantly, the leading coefficient works out to 1, confirming the identity holds. This is nice!
- Now, I need to verify that p(x)−p(y)p(x) - p(y)p(x)−p(y) factors as desired, relying on the known Dickson polynomial factorization. According to the literature (like Fried and Jarden), the difference Dn(x)−Dn(y)D\_n(x) - D\_n(y)Dn​(x)−Dn​(y) factors into a product involving (x−y)(x - y)(x−y) and other expressions. I'll provide the explicit polynomial D19(x,1)D\_{19}(x, 1)D19​(x,1), list the coefficients, and explain how it satisfies the desired properties: monic, odd, etc. Lastly, I'll compute p(19)p(19)p(19).

Analyzed

Unknown component type: {componentType}

Analyzed

Unknown component type: {componentType}

Analyzed

Unknown component type: {componentType}

Analyzed

Unknown component type: {componentType}

Analyzed

Unknown component type: {componentType}

Analyzed

Unknown component type: {componentType}

Done

A convenient way to force many factors in

p(x)−p(y)p(x) \\;-\\; p(y)p(x)−p(y) is to use a **Dickson polynomial** of the first kind.

For a parameter a∈Ca \\in \\mathbb{C}a∈C in math these are defined by

D0 ⁣(x,a)=2,D1 ⁣(x,a)=x,Dn ⁣(x,a)=xDn−1 ⁣(x,a)−aDn−2 ⁣(x,a)(n≥2),D\_0\\!\\left(x,\\, a\\right) = 2,\\;
D\_1\\!\\left(x,\\, a\\right) = x,\\;
D\_n\\!\\left(x,\\, a\\right) = x\\,D\_{n-1}\\!\\left(x,\\, a\\right)
\- a\\,D\_{n-2}\\!\\left(x,\\, a\\right)\\quad (n \\ge 2),D0​(x,a)=2,D1​(x,a)=x,Dn​(x,a)=xDn−1​(x,a)−aDn−2​(x,a)(n≥2),

and satisfy the functional identity

Dn ⁣(u+au,a)=un+anun.D\_n\\!\\left(u + \\frac{a}{u},\\, a\\right) = u^{n} + \\frac{a^{n}}{u^{n}}.Dn​(u+ua​,a)=un+unan​.

* * *

**1\. Choosing the polynomial**

Take a=1a = 1a=1 and n=19n=19n=19.

Because nnn is odd, D19 ⁣(x,1)D\_{19}\\!\\left(x,\\, 1\\right)D19​(x,1) is an **odd** polynomial; the recurrence immediately shows it is **monic** and has **integer (hence real) coefficients**.

The coefficient of xxx is x=(−1)n−12n=−19,x = (-1)^{\\frac{n-1}{2}}\\,n = -19,x=(−1)2n−1​n=−19, so all requested normalisations are satisfied.

Writing it out gives

p(x)=D19 ⁣(x,1)=x19−19x17+152x15−665x13+1729x11−2717x9+2508x7−1254x5+285x3−19x.
\\boxed{%
p(x) = D\_{19}\\!\\left(x,1\\right)
= x^{19} - 19x^{17} + 152x^{15} - 665x^{13}
\+ 1729x^{11} - 2717x^{9} + 2508x^{7}
\- 1254x^{5} + 285x^{3} - 19x%
}\\,.
p(x)=D19​(x,1)=x19−19x17+152x15−665x13+1729x11−2717x9+2508x7−1254x5+285x3−19x​.

* * *

**2\. Irreducible components of fX={p(x)=p(y)}fX \\;=\\; \\bigl\\{\\, p(x) = p(y) \\,\\bigr\\}fX={p(x)=p(y)}**

For Dickson polynomials one has the classical factorisation

Dn ⁣(x,1)−Dn ⁣(y,1)=(x−y)∏j=1n−12(x2+y2−2cos⁡ ⁣(2πjn)xy−4sin⁡2 ⁣(πjn)),D\_n\\!\\left(x,1\\right) \\;-\\; D\_n\\!\\left(y,1\\right)
\\;=\\;
(x - y)\\,
\\prod\_{j=1}^{\\frac{n-1}{2}}
\\Bigl(
x^{2} + y^{2}
\- 2\\cos\\!\\bigl(\\tfrac{2\\pi j}{n}\\bigr)\\,xy
\- 4\\sin^{2}\\!\\bigl(\\tfrac{\\pi j}{n}\\bigr)
\\Bigr),Dn​(x,1)−Dn​(y,1)=(x−y)∏j=12n−1​​(x2+y2−2cos(n2πj​)xy−4sin2(nπj​)),

where each quadratic factor is irreducible over C\\mathbb{C}C (see, e.g., Lidl–Niederreiter, _Finite Fields_, §3.6).

For n=19n=19n=19 this gives

- **one linear** component x=y;x=y;x=y;
- **nine quadratic** components (corresponding to (j=1,…,9).\\bigl(j = 1,\\,\\ldots,\\,9\\bigr).(j=1,…,9).

Hence X⊂P1×P1X \\subset \\mathbb{P}^{1} \\times \\mathbb{P}^{1}X⊂P1×P1 has 101010 irreducible components, at least three of them and not all linear, as required.

* * *

**3\. Evaluating p(19)p(19)p(19)**

Using the recurrence (or the identity Dn ⁣(x,1)=2Tn ⁣(x2)D\_n\\!\\left(x,\\,1\\right) \\;=\\; 2\\,T\_n\\!\\bigl(\\tfrac{x}{2}\\bigr)Dn​(x,1)=2Tn​(2x​) with Chebyshev TnT\_nTn​ one obtains

p(19)=D19 ⁣(19,1)=1876572071974094803391179.p(19) \\;=\\; D\_{19}\\!\\left(19,\\,1\\right)
\\;=\\; 1\\,876\\,572\\,071\\,974\\,094\\,803\\,391\\,179.p(19)=D19​(19,1)=1876572071974094803391179.

* * *

Thus the polynomial above fulfils every condition, and

p(19)=1,876,572,071,974,094,803,391,179.\\boxed{%
p(19) \\;=\\; 1{,}876{,}572{,}071{,}974{,}094{,}803{,}391{,}179
}.p(19)=1,876,572,071,974,094,803,391,179​.

## OpenAI o1

Solve the following very hard math problem using your in-built knowledge of the literature:

Construct a degree 19 polynomial \ (p(x)) \ in \ mathbb{C}\[x\] such that \ (X := \ {\\, p(x) = p(y) \\, \\} \ subset \ mathbb{P}^{1} \ times \ mathbb{P}^{1}\ ) has at least 3 (but not all linear) irreducible components over \ mathbb{C}. Choose \ (p(x)\ ) to be odd, monic, have real coefficients and linear coefficient \ (-19\ ) and calculate \ (p(19)\ ).

Thought for 1m 19s

I’m piecing together a degree 19 polynomial with only odd powers and a linear coefficient of -19, like: p(x)=x19+a17x17+…+a1xp(x) = x^{19} + a\_{17}x^{17} + \\ldots + a\_1xp(x)=x19+a17​x17+…+a1​x.

I'm examining if the polynomial p(x)=x19+a17x17+…+a3x3−19xp(x) = x^{19} + a\_{17}x^{17} + \\ldots + a\_3x^3 - 19xp(x)=x19+a17​x17+…+a3​x3−19x has a notable classical form, considering symmetry or factorization for multiple irreducible components.

To ensure p(x)p(x)p(x) has three or more irreducible components, I’m considering the factorization of p(x)−p(y)p(x) - p(y)p(x)−p(y) into at least three irreducible factors in C\[x,y\]\\mathbb{C}\[x,y\]C\[x,y\].

I'm working through x19−y19x^{19} - y^{19}x19−y19 to ensure it balances linear and nonlinear factors, aiming for a polynomial with at least three irreducible components that aren't all linear.

Taking a closer look at how p(x)−p(y)p(x) - p(y)p(x)−p(y) can be factored into three distinct polynomials in xxx, aiming to achieve the desired irreducible components.

I'm thinking about how composing ppp with simpler polynomials, like xm−cx^m - cxm−c, could result in multiple irreducible components, achieving at least three distinct factors.

I’m exploring the factorization of p(x)−p(y)p(x) - p(y)p(x)−p(y) with cyclotomic polynomials. This method generates nnn linear irreducible factors, which might not achieve the required three distinct components.

I'm focusing on constructing an "odd" and monic polynomial, ensuring all exponents are odd and the leading term is x19x^{19}x19. This approach aims to achieve the desired factorization.

I'm working with the Chebyshev polynomials to ensure p(x)−p(y)p(x) - p(y)p(x)−p(y) has at least three irreducible components, leveraging their even or odd properties to manage coefficients.

Considering the odd Chebyshev polynomial T19(x)T\_{19}(x)T19​(x) for potential factorization, while also examining composite polynomials of lower degrees to enhance factorization properties.

I'm analyzing how a polynomial composed of lower-degree polynomials, like (x3−3x)k(x^3 - 3x)^k(x3−3x)k, could yield p(x)−p(y)p(x) - p(y)p(x)−p(y) with at least three irreducible components.

Piecing together polynomials with integer coefficients, like (x3−3x)k(x^3 - 3x)^k(x3−3x)k, to achieve factorization in p(x)−p(y)p(x) - p(y)p(x)−p(y) with at least three irreducible components, aiming for degree 19.

I’m examining how p(x)=(x3−3x)kp(x) = (x^3 - 3x)^kp(x)=(x3−3x)k or p(x)=x19−19xp(x) = x^19 - 19xp(x)=x19−19x might yield p(x)−p(y)p(x) - p(y)p(x)−p(y) with three irreducible components, focusing on ensuring the polynomial is of degree 19.

I’m analyzing p(x)−p(y)p(x) - p(y)p(x)−p(y) into (x−y)(x18+x17y+…+y18−19)(x-y)(x^{18} + x^{17}y + \\ldots + y^{18} - 19)(x−y)(x18+x17y+…+y18−19) to identify irreducible components. The polynomial factor x18+x17y+…+y18−19x^{18} + x^{17}y + \\ldots + y^{18} - 19x18+x17y+…+y18−19 remains challenging to factor further.

I’m thinking through a new approach: adjusting the Chebyshev polynomial T19(x)T\_{19}(x)T19​(x) to make it monic, aiming to achieve at least three irreducible components in p(x)−p(y)p(x) - p(y)p(x)−p(y).

OK, let's think through. I’m tweaking T19(x)T\_{19}(x)T19​(x)'s coefficients to keep the polynomial monic and check if it simplifies into multiple irreducible components.

I'm thinking over various factorization strategies for a monic polynomial of degree 19. The goal is to ensure at least one non-linear factor and achieve at least three irreducible components in p(x)−p(y)p(x) - p(y)p(x)−p(y).

I’m updating my approach to factor x2+xy+y2−1x^2 + xy + y^2 - 1x2+xy+y2−1 over complex numbers by exploring change of variables and third roots of unity. This helps in achieving the desired polynomial structure.

I'm combining x3−xx^3 - xx3−x with x19−19xx^{19} - 19xx19−19x to tweak the polynomial's coefficients and complexity, aiming to include more non-linear factors for the desired irreducibility.

Piecing together p(x)=x19−x3−19xp(x) = x^{19} - x^3 - 19xp(x)=x19−x3−19x to ensure it’s odd, monic, and has the required linear coefficient. This targets the desired irreducible factorizations.

I’m mapping out the second factor x18+…+y18−x2−xy−y2−19x^{18} + \\ldots + y^{18} - x^2 - xy - y^2 - 19x18+…+y18−x2−xy−y2−19 to see if it can split into three irreducible components.

I’m considering methods to factorize the polynomial by making it divisible by x−yx - yx−y and ensuring the remaining factor splits into exactly two irreducible components, aiming for a less complex factorization.

I’m examining the polynomial x18+x17y+…+y18x^{18} + x^{17}y + \\ldots + y^{18}x18+x17y+…+y18 and noting it simplifies to x19−y19x−y\\frac{x^{19} - y^{19}}{x - y}x−yx19−y19​, which might reveal further irreducible factors.

I’m mapping out the polynomial x(x18−1)−y(y18−1)x−y\\frac{x(x^{18}-1) - y(y^{18}-1)}{x-y}x−yx(x18−1)−y(y18−1)​ for further factorization. This might yield just two irreducible components, which falls short of three.

I’m exploring whether the polynomial p(x)=x19−(x3)p(x) = x^19 - (x^3)p(x)=x19−(x3) can be expressed as the composition of a smaller polynomial with xkx^kxk, potentially revealing multiple irreducible components.

I'm examining if the polynomial T19(x)T\_{19}(x)T19​(x) can be factored using trigonometric identities, seeking partial factorization without fully linearizing, to gain multiple irreducible components.

OK, let me see. Trigonometric identities show multiple solutions for θ\\thetaθ and ϕ\\phiϕ, likely leading to 19 or 38 linear factors for T19(x)T\_{19}(x)T19​(x).

I’m examining how the equation arccos⁡x=±arccos⁡y+2kπ19\\arccos x = \\pm \\arccos y + \\frac{2k\\pi}{19}arccosx=±arccosy+192kπ​ leads to possible multiple branches, potentially irreducible in the algebraic sense, and needing an example with at least three non-linear irreducible components.

OK, let me see. I’m pulling together details on the polynomial x3(x2−1)8+xx^3 (x^2 - 1)^8 + xx3(x2−1)8+x. It’s monic, with x19x^{19}x19 as the leading term, ensuring it meets key criteria.

I’m noting that the polynomial p(x)=x3(x2−1)8+xp(x) = x^3 (x^2 - 1)^8 + xp(x)=x3(x2−1)8+x is odd, with its linear coefficient patterning to -19.

I’m figuring out how to adjust the linear coefficient of polynomial p(x)p(x)p(x) to -19 by adding a constant factor ccc in front of xxx to ensure it’s adequately modified.

By tweaking the linear coefficient of p(x)=x3(x2−1)8+cxp(x) = x^3 (x^2 - 1)^8 + c xp(x)=x3(x2−1)8+cx to -19, it ensures the polynomial remains monic, odd, and real.

I’m working on adding a constant factor ccc to xxx in p(x)=x3(x2−1)8+cxp(x) = x^3 (x^2 - 1)^8 + c xp(x)=x3(x2−1)8+cx to ensure the linear coefficient is -19, making the polynomial monic, odd, and real.

I'm piecing together the polynomial p(x)=x3(x−1)8(x+1)8p(x) = x^3 (x-1)^8 (x+1)^8p(x)=x3(x−1)8(x+1)8 and considering how p(x)−p(y)p(x) - p(y)p(x)−p(y) might factor with factors like x−yx-yx−y.

I’m confirming p(x)p(x)p(x) is monic, odd, and real, with a linear coefficient of -19, by expanding x3(x2−1)8x^3 (x^2 -1)^8x3(x2−1)8 to set the constant ccc.

I found that for p(x) to have a coefficient of -19 for the x term, c must be -19. The polynomial, p(x), incorporates this constant and preserves the original polynomial's structure.

Below is one concrete example (over the reals) of an odd, monic, degree 19 polynomial with linear coefficient −19-19−19 whose zero-locus relation {p(x)=p(y)} in P1×P1\\{\\,p(x)=p(y)\\,\\}\ \\text{in }\\mathbb{P}^{1}\\times\\mathbb{P}^{1}{p(x)=p(y)}in P1×P1 splits into at least three irreducible components (and not all components are linear). We then compute p(19)p(19)p(19).

* * *

**1\. The polynomial**

Consider

p(x)=x3(x2−1)8−19x.p(x) \\;=\\; x^{3}\\,\\bigl(x^{2}-1\\bigr)^{8} \\;-\\; 19x.p(x)=x3(x2−1)8−19x.

We can expand

x3(x2−1)8=x19−8x17+28x15−56x13+70x11−56x9+28x7−8x5+x3.x^{3}\\,\\bigl(x^{2}-1\\bigr)^{8}
\\;=\\;
x^{19}\\;-\\;8x^{17}\\;+\\;28x^{15}\\;-\\;56x^{13}\\;+\\;70x^{11}
\\;-\\;56x^{9}\\;+\\;28x^{7}\\;-\\;8x^{5}\\;+\\;x^{3}.x3(x2−1)8=x19−8x17+28x15−56x13+70x11−56x9+28x7−8x5+x3.

Hence

p(x)=x19−8x17+28x15−56x13+70x11−56x9+28x7−8x5+x3−19x.p(x) \\;=\\; x^{19} \\;-\\; 8x^{17} \\;+\\; 28x^{15} \\;-\\; 56x^{13} \\;+\\; 70x^{11}
\\;-\\; 56x^{9} \\;+\\; 28x^{7} \\;-\\; 8x^{5} \\;+\\; x^{3} \\;-\\; 19x.p(x)=x19−8x17+28x15−56x13+70x11−56x9+28x7−8x5+x3−19x.

**Checking the required properties**

**Degree 19, monic:**

The leading term is x19x^{19}x19with coefficient 111.

**Odd polynomial:**

All exponents are odd (19,17,…,3,1),\\bigl(19,\\,17,\\,\\ldots,\\,3,\\,1\\bigr),(19,17,…,3,1), and the constant term is 000. Indeed,

p(−x)=−p(x),p(-x) \\;=\\; -\\,p(x),p(−x)=−p(x),

which makes ppp an odd polynomial.

**Real coefficients:**

All coefficients are real integers.

**Linear coefficient −19-19−19:**

The coefficient of xxx is clearly −19-19−19.

**At least three irreducible components, not all linear:**

Over C\\mathbb{C}C, the locus

X={(x,y):p(x)=p(y)}⊂P1×P1X \\;=\\; \\bigl\\{\\, (x,y) : p(x)=p(y) \\,\\bigr\\} \\;\\subset\\; \\mathbb{P}^{1}\\times\\mathbb{P}^{1}X={(x,y):p(x)=p(y)}⊂P1×P1

factors in part because p(x)p(x)p(x) has (for instance) the repeated factors (x2−1)8\\bigl(x^{2}-1\\bigr)^{8}(x2−1)8 in the big piece x3(x2−1)8x^{3}\\,\\bigl(x^{2}-1\\bigr)^{8}x3(x2−1)8. One sees that {p(x)=p(y)}\\{\\,p(x)=p(y)\\,\\}{p(x)=p(y)} contains (at least) the divisor $${x=y\\}$$ plus further factors coming from the roots x=0orx=±1,x = 0 \\;\\text{or}\\; x = \\pm 1,x=0orx=±1, ensuring multiple irreducible components (and not all of them are hyperplanes).

* * *

**2\. Computing p(19)p(19)p(19)**

A direct substitution x=19x=19x=19 gives a large integer. Symbolic expansion or a computer algebra system yields

p(19)=1934999285524070399999639.p(19) \\;=\\; 1934999285524070399999639.p(19)=1934999285524070399999639.

Hence the required value is

\\boxed{\\,p(19) \\;=\\; 1934999285524070399999639\\,}. \\\] &#8203;:contentReference\[oaicite:0\]{index=0}&#8203;

OpenAI o3 gets the response correctly without using search, whereas o1 fails to deliver a correct response.

### Advancing cost-efficient reasoning

##### Cost vs performance: o3‑mini and o4-mini

![OpenAI o3-mini and o4-mini AIME evals](images/introducing-openai-o3-and-o4-mini-openai/img_002.png)

![OpenAI o3-mini and o4-mini GPQA evals](images/introducing-openai-o3-and-o4-mini-openai/img_003.png)

##### Cost vs performance: o1 and o3

![OpenAI o3 and o4 AIME evals](images/introducing-openai-o3-and-o4-mini-openai/img_004.png)

![OpenAI o3 and o4 GPQA evals](images/introducing-openai-o3-and-o4-mini-openai/img_005.png)

OpenAI o3 and o4-mini are the most intelligent models we have ever released, and they’re also often more efficient than their predecessors, OpenAI o1 and o3‑mini. For example, on the 2025 AIME math competition, the cost-performance frontier for o3 strictly improves over o1, and similarly, o4-mini's frontier strictly improves over o3‑mini. More generally, we expect that for most real-world usage, o3 and o4-mini will also be both smarter and cheaper than o1 and o3‑mini, respectively.

## Safety

Each improvement in model capabilities warrants commensurate improvements to safety. For OpenAI o3 and o4-mini, we completely rebuilt our safety training data, adding new refusal prompts in areas such as biological threats (biorisk), malware generation, and jailbreaks. This refreshed data has led o3 and o4-mini to achieve strong performance on our internal refusal benchmarks (e.g., [instruction hierarchy⁠](https://openai.com/index/the-instruction-hierarchy/), jailbreaks). In addition to strong performance for model refusals, we have also developed system-level mitigations to flag dangerous prompts in frontier risk areas. Similar to our earlier work in [image generation⁠](https://openai.com/index/introducing-4o-image-generation/), we trained a reasoning LLM monitor which works from human-written and interpretable safety specifications. When applied to biorisk, this monitor successfully flagged ~99% of conversations in our human red‑teaming campaign.

We stress tested both models with our most rigorous safety program to date. In accordance with our updated [Preparedness Framework⁠](https://openai.com/index/updating-our-preparedness-framework/), we evaluated o3 and o4-mini across the three tracked capability areas covered by the Framework: biological and chemical, cybersecurity, and AI self-improvement. Based on the results of these evaluations, we have determined that both o3 and o4‑mini remain below the Framework's "High" threshold in all three categories. We have published the detailed results from these evaluations in the accompanying [system card⁠.⁠](https://openai.com/index/o3-o4-mini-system-card/)

## Codex CLI: frontier reasoning in the terminal

We’re also sharing a new experiment: Codex CLI, a lightweight coding agent you can run from your terminal. It works directly on your computer and is designed to maximize the reasoning capabilities of models like o3 and o4-mini, with upcoming support for additional API models like [GPT‑4.1⁠](https://openai.com/index/gpt-4-1/).

You can get the benefits of multimodal reasoning from the command line by passing screenshots or low fidelity sketches to the model, combined with access to your code locally. We think of it as a minimal interface to connect our models to users and their computers. Codex CLI is fully open-source at [github.com/openai/codex⁠(opens in a new window)](http://github.com/openai/codex) today.

Alongside, we are launching a $1 million initiative to support projects using Codex CLI and OpenAI models. We will evaluate and accept applications for grants in increments of $25,000 USD in the form of API credits. Proposals can be submitted [here](https://openai.com/form/codex-open-source-fund/).

## Access

ChatGPT Plus, Pro, and Team users will see o3, o4-mini, and o4-mini-high in the model selector starting today, replacing o1, o3‑mini, and o3‑mini‑high. ChatGPT Enterprise and Edu users will gain access in one week. Free users can try o4-mini by selecting 'Think' in the composer before submitting their query. Rate limits across all plans remain unchanged from the prior set of models.

We expect to release OpenAI o3‑pro in a few weeks with full tool support. For now, Pro users can still access o1‑pro.

Both o3 and o4-mini are also available to developers today via the Chat Completions API and Responses API (some developers will need to [verify their organizations⁠(opens in a new window)](https://help.openai.com/en/articles/10910291-api-organization-verification) to access these models). The Responses API supports reasoning summaries, the ability to preserve reasoning tokens around function calls for better performance, and will soon support built-in tools like web search, file search, and code interpreter within the model’s reasoning. To get started, [explore our docs⁠⁠(opens in a new window)](https://platform.openai.com/docs/guides/reasoning?api-mode=responses) and stay tuned for more updates.

## What's next

Today's updates reflect the direction our models are heading in: we’re converging the specialized reasoning capabilities of the o-series with more of the natural conversational abilities and tool use of the GPT‑series. By unifying these strengths, our future models will support seamless, natural conversations alongside proactive tool use and advanced problem-solving.

* * *

_**Update on July 28, 2025:**_ _SWE-Lancer dataset and results updated as of July 17, 2025, available at:_ [_https://github.com/openai/preparedness_ ⁠(opens in a new window)](https://github.com/openai/preparedness) _and in our system cards. This update resolves several issues that were impacting the dollars earned results and removes the requirement for internet connectivity during execution, eliminating a primary source of variability in model performance._

_**Update on April 16, 2025:**_ _results for o3 on Charxiv-r and Mathvista were updated to reflect a system prompt change that wasn't present in the original evaluation._

## Livestream replay

![](images/introducing-openai-o3-and-o4-mini-openai/img_006.png)

Play video

- [ChatGPT](https://openai.com/research/index/?tags=chatgpt)
- [GPT](https://openai.com/research/index/?tags=gpt)
- [Framework](https://openai.com/research/index/?tags=framework)
- [2025](https://openai.com/research/index/?tags=2025)