---
title: "LangChain 🤝 DemoGPT: New Era for Gen-AI Applications"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-demogpt-new-era-for-gen-ai-applications/"
date: "2023-08-21"
scraped_at: "2026-03-03T08:52:25.066727488+00:00"
language: "en"
translated: false
---

_Editor's Note: This post was written in collaboration with the [DemoGPT](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) team. We're excited about what they're doing to make it easier to not only build LLM applications, but also get them in the hands of users and build community in the process. We also thought way they built the platform on top of LangChain and Streamlit is really neat–their under-the-hood walkthrough offers some cool ideas for anyone using a language model to generate an app._

Today we’re happy to announce the collaboration of [DemoGPT](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) with LangChain to make generative ai application creation easier. In this blog post, we’ll dig deeper into the details of this collaboration and how to use DemoGPT to build scalable LLM-powered applications with LangChain.

**DemoGPT: Emerging Marketplace for LangChain Applications**

DemoGPT is [an open-source project](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) that aspires to keep pushing the boundaries of Large Language Model (LLM) based application development. At its core, DemoGPT synergizes the capabilities of various Foundation Models, enabling the auto-generation of LangChain x Streamlit applications with just a prompt.

Here’s a look under the hood at how it works and where we see it going in the future.

**Unpacking DemoGPT: A Glimpse into its Technical Core**

![](https://lh3.googleusercontent.com/GcLyXg-t0GXZXnDCAdvTivaujBdkat2MQpWSwVMVn3PeEImffOHp3TRqCqmVnItZyBwVjFVTxqKSt_6FVUPwM4ITHBcWC062rf8MgXSApPZ6fndRfSuVwCxDS9wBG0rOqBSG4lsfs2AjTrCkVAifEfc)

_DemoGPT Architecture_

Navigating through the architecture of DemoGPT reveals a structured approach to code generation operations. This detailed exploration will take you through its core stages: Planning, Task Creation, Code Snippet Generation, Combining the Code Snippets, and DB Saving. Each stage plays a pivotal role in ensuring optimal functionality and efficiency. Let's delve into each of these components to understand the intricacies of DemoGPT's workflow.

**Planning**: DemoGPT starts by generating a plan from the user's instruction.

When a user submits an instruction, its first port of call is the planning module. This segment is the bedrock of the entire DemoGPT structure because the following steps lean heavily on the valid global planning inspired by HuggingGPT. However, unlike HuggingGPT, which goes straight from instruction to task list, DemoGPT first creates a plan in natural language and later creates a task list. This way of processing is more intuitive for LLMs.

The Planning module knows all of the available toolsets to minimize hallucinations. It also uses a self-refining strategy so that planning continues until it is validated by itself.

![](https://lh5.googleusercontent.com/C4WNkha3dxIyw76DW0mDOgtozsBGJdXBKSTToQjbUryr7GXO6VKTnvmWqqBjD9fQF_6gPnNnVxXUfsm_jP7KbrwlDxSbiuLT1sogHu_FWxdmlD6oRjj5y492yQ6Lo4wHz65s18VsIgUncl3gp7u2H0w)

**Task Creation:** It then creates specific tasks using the plan and instruction.

In our experiments, we have seen that using a natural language plan minimizes hallucinations vs. going straight from instruction to task list. Our novel approach reduces the number of refining steps needed in the task creation process. This step also has a self-refining subphase to get rid of hallucinated tasks. During this subphase, the module checks the (input, output) pairs of each task, then according to the result, it gives feedback to itself, then generates the tasks again according to the last iteration and continues until it passes the tests.

![](https://lh3.googleusercontent.com/3HGdnyWZmQWB3iulnlfA3w6K2r3R7Rnus1gmpy277NME8kGi0yXBe-3C6D2k8yA76jpHRvzW1uEk5z871fG2FUGNVwTJli_fQhhAq_-GgvvVqL_aToPX7Uv1Cs9lpnnFAKYeXZpEo8lCxi8rro1rIjc)

**Code Snippet Generation:** Tasks are transformed into Python code snippets.

Each task has its own prompt so that when the corresponding task is converted into a Python code, it uses its custom prompts for this transformation. The transformation process is mindful of previously generated code, so everything works well in tandem.

![](https://lh5.googleusercontent.com/YepUJFuvKwziOpG08WCAYKMZwC4OUEg0EqLzPvDpuHxevzHRoSLEmTVpWUzHWBmnw6e4qwMZeyAj2yZqm_ll6WTzdY4FimrEq70VV7s2CU0kJ38hZmPr4QUidYLLAi6F5lpItCXKYrvWLn12KtrRrG0)

**Combining the Code Snippets:** The code snippets are combined into a final code, resulting in an interactive application.

All code snippets are put into a prompt to combine them together. Here, the final code is made compatible with Streamlit (such as state management). The output of this module is further improved by a self-refining technique to make sure everything is compatible with Streamlit.

![](https://lh5.googleusercontent.com/2jvKC6wfADHd1y5QlFfJOKTeKM7X6XQQ4D7SosHYq6OHRjE53Fka75DYNrg8kyO3-0Zs-P51R4XN_Sh0aAE1CIZ3S6-wbzZHYi9KyvFqFv-Qvbg96F4v-M5gL1UZB2bRavAHWM3bZXtUGHReyxxth20)

**DB Saving (coming in next release):** The generated plan, tasks and code snippets stored in a vector database

In the whole architecture, each phase is applying self-refining to itself to get rid of hallucinated results. In addition, each module has its own examples for few-shot learning and for most applications. This works pretty well and allows applications to be created by lighter models like GPT-3.5 at 10% of the cost of GPT-4. However, to decrease the cost even more and make it more performant, the DB Saving module aims to save the approved results (plans, tasks, and code snippets) to a vector database so that next time, the relevant examples from the vector database will be fetched and used for the few-shot learning to decrease the number of refining steps. This will decrease the cost of application generation and at the same time make generation faster.

**How to Install DemoGPT?**

[Installing DemoGPT](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) is a straightforward process, designed to get you up and running with minimal hassle.

|     |
| --- |
| pip install demogpt |

**How to Use DemoGPT?**

You can use the DemoGPT library either via CLI or by using its Python interface.

1. **As a Command Line Interface (CLI)**

You can run the DemoGPT application as a Streamlit app by simply typing:

|     |
| --- |
| demogpt |

Once running; enter your own API key and choose which base model you want to use.

When everything is ready, you can start creating applications just from a prompt. Let your imagination guide you. You can create a chat with your PDF app in seconds, or create a sentiment analysis tool that takes in a website and returns the tone of text.

Applications are limited only by prompts given, so with longer prompts you too can create sophisticated and unique AI applications.

![](https://lh5.googleusercontent.com/7QkQmarwI4pd7AmqE716lCtzfmUTJiKKvPPQgBCrIdcagX9fxDuiIzfMemb4JLwTB5wDRM67V3qNi3Jipfwfo67kQMmlRm_z0Rm0JNJtI6gbHIKoGTn2IuxLTVFDjk4GAr-N0aclb_5S_8bLe9CXidA)

_Tweet Generator: An application that can generate tweets from given hashtags and tone of the tweet._

![](https://lh5.googleusercontent.com/22Js760o7xfn9G8SIm2mmoubWWNg8NeejibKp6rpZPWVC0jE3lYnK2_nNYb-_BG3_f4aCE_F1mnFZmZQuNZ5mg9QiwMtrWnt7NfR9q_MOuHWrbCawY22KlAUe6eE8zPU9mAEp6oClu0CmMjY1kT4mmk)

_Web Blogger: An application that can generate Medium blog from given website url_

1. **As a Python Library**

You can run the DemoGPT application as a Python library. To incorporate DemoGPT into your Python applications, follow the steps below.

#### Import the necessary module:

|     |
| --- |
| from demogpt import DemoGPT |

#### Instantiate the DemoGPT agent

|     |
| --- |
| agent = DemoGPT(model\_name="gpt-3.5-turbo-0613", openai\_api\_key="YOUR\_API\_KEY", max\_steps=10) |

#### Set your instruction and title

|     |
| --- |
| instruction = "Your instruction here"<br>title = "Your title here" |

#### Iterate through the generation stages and extract the final code

|     |
| --- |
| code = ""<br>for phase in agent(instruction=instruction, title=title):<br>    print(phase)  \# This will display the resulting JSON for each generation stage.<br>if phase\["done"\]:<br>        code = phase\["code"\]  \# Extract the final code.<br>print(code) |

For further information, you can visit [DemoGPT Docs](https://docs.demogpt.io/?ref=blog.langchain.com)

**From Idea to Marketplace: The Journey with LangChain x DemoGPT**

To provide a clearer picture of this collaboration, let's walk through a potential user journey:

Imagine Sarah, an AI enthusiast with a brilliant idea for an application that leverages the power of language models. She visits the LangChain website, where she's introduced to the integrated DemoGPT application generation tool.

![](https://lh3.googleusercontent.com/jdLNjFP8Ek1qILUBef6tr84PHsbHsz1sk76iyeyrgYkl9XfHW_GEM0kl7Hk-rBzB21noOGN--b2vHTOL460p0-LGeYWI8LDJKRe2LU76CM5WRccKpZ33L8q2-G3VJpbPha5UpChBiDHX8n_dHtxckt8)

_As a first step, app generation occurs on LangChain website_

With a few prompts and inputs, Sarah crafts her application, watching it come to life in real-time. Once satisfied with her creation, Sarah is presented with the opportunity to showcase her application on the [DemoGPT Marketplace](https://marketplace.demogpt.io/?ref=blog.langchain.com). With a simple click, her application is listed, making it accessible to a global audience.

![](https://lh5.googleusercontent.com/km9yaKnGI5_cHRk8F1w20UGBTWzx6fxrIvUHxCGFigsAtIrvxjY6y2IaEY_RuVTA6H3-18_iATyQjqKfmEUpRxq7KU1i5pEcbJ4szPJwze5VKQL6tSEwmkwYzgNbJ8dZx1MMYUju0oFieG4lJpN8mJY)

_Once the app is generated, it will be listed on DemoGPT Marketplace_

Other developers, businesses, or AI enthusiasts can now discover Sarah's application, interact with it, provide feedback, or even propose collaborative enhancements.

![](https://lh5.googleusercontent.com/w6MF53bM3HhUTYk4UUb_-okQFUuSkllP4aB6afL2QU3e3IvV4d2hhUIIN6A_VVAJXFHGm71yMxm6Xvoz4c-a-70WMqLMrotRJEsVjzoKEqrSKmA7qsOiMwCEPxG5uX6VojJXtLaR_ctLPrKpnBc5VOE)

_All the generated apps will be listed and used on_ [_DemoGPT Marketplace_](https://marketplace.demogpt.io/?ref=blog.langchain.com)

Furthermore, the marketplace offers Sarah the chance to monetize her application, either through licensing or API sales. As her application gains traction, she receives feedback from the community, leading her back to the LangChain website to iterate and refine her application, ensuring it remains relevant and valuable to its users.

This cyclical process of creation, showcase, feedback, and refinement ensures that the LangChain x DemoGPT ecosystem remains vibrant, innovative, and user-centric.

**The Power of Collaboration: LangChain x DemoGPT**

One of the most exciting prospects of our collaboration is the emergence of the [DemoGPT Marketplace](https://marketplace.demogpt.io/?ref=blog.langchain.com). We envision the DemoGPT Marketplace as a platform where the LangChain community, alongside developers and AI enthusiasts globally, can create, showcase, exchange, and even monetize their auto-generated applications.

This marketplace will be more than just a platform; it will be a vibrant community and a space where LangChain users can collaborate, iterate, and refine applications, ensuring that our ecosystem remains dynamic, user-centric, and on the cutting edge of technological advancements. With the added interactivity and user experience enhancements brought by Streamlit, these applications will promise to be not just functional but truly transformative.

**What’s Next?**

As users craft their unique applications on LangChain, we hope and envision that these innovative creations will find a new home on the [DemoGPT Marketplace](https://marketplace.demogpt.io/?ref=blog.langchain.com). This platform will be set to become a bustling hub where these auto-generated applications are prominently listed and showcased. It will not just be about giving visibility to the applications but also creating a space where a broader audience can discover, interact with, and derive value from these tools.

The vision behind this collaboration is to establish a synergistic ecosystem. By enabling application generation on LangChain and providing a platform for discovery on the DemoGPT Marketplace, we aim to bridge the gap between creators and consumers.

Collaboration between LangChain and DemoGPT can be a really huge step for the LLM world!

We encourage our community to share their feedback, insights, and experiences on [LangChain Discord channel](https://discord.gg/Hc6QyDYr?ref=blog.langchain.com). Your input is invaluable to us, and it will play a pivotal role in shaping the future of this collaboration.

For more detailed information, advanced configurations, or troubleshooting, you can always refer to the [DemoGPT GitHub repository](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) or [DemoGPT Marketplace](https://marketplace.demogpt.io/?ref=blog.langchain.com) and consider giving a star.