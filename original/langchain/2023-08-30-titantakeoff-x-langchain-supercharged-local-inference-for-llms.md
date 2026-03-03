---
title: "TitanTakeoff x LangChain: Supercharged Local Inference for LLMs"
source: "LangChain Blog"
url: "https://blog.langchain.com/titantakeoff-x-langchain-supercharged-local-inference-for-llms-2/"
date: "2023-08-30"
scraped_at: "2026-03-03T08:48:07.225197117+00:00"
language: "en"
translated: false
---

_Editor's Note: This post was written in collaboration with the [TitanML](https://www.titanml.co/?ref=blog.langchain.com) team. The integration between their NLP development platform + LangChain makes inference LLMs super easy!_

# Challenges

With the release of many open source large language models over the past year, developers are increasingly keen to jump on the bandwagon and deploy their own LLMs. However, without specialised knowledge, developers who are experimenting with deploying LLMs on their own hardware may face unexpected technical difficulties. The recent scramble for powerful GPUs has also made it significantly harder to secure sufficient GPU allocation to deploy the best model at the desired latency and scale.

Developers are faced with an unappealing choice between suboptimal applications due to compromises on model size and quality, or costly deployments because of manual optimisations and reliance on expensive GPUs, not to mention wasted time dealing with boring and one-off technical eccentricities.

# Titan Takeoff Server

Falcon-7B-instruct model running on a CPU with Titan Takeoff Server.

That being said, deploying your own models locally doesn’t have to be difficult and frustrating. The Titan Takeoff Server offers a simple solution for the local deployment of open-source Large Language Models (LLMs) even on memory-constrained CPUs. With it, users gain the benefits of on-premises inferencing — reduced latency, enhanced data security, cost savings in the long run, and unparalleled flexibility in model customization and integration without additional complexity, not to mention the ability to deploy larger and more powerful models on memory-constrained hardware.

![](images/titantakeoff-x-langchain-supercharged-local-inference-for-llms/img_001.png)Titan Takeoff Server offers significant performance benefits for deployment and inferencing of LLMs.

With its lightning fast inference speeds and support on low cost, readily available devices, the Titan Takeoff Server is suitable for developers who need to constantly deploy, test and refine their LLMs. Through the use of state of the art memory compression techniques, the Titan Takeoff Server offers a 10x improvement in throughput, a 3-4x improvement in latency and a 4–20x cost saving through the use of smaller GPUs, in comparison with the base model implementation. In an era where control and efficiency are paramount, the Titan Takeoff Server stands out as an optimal solution for deploying and inferencing LLMs.

# Seamless Integration with LangChain

With the recent integration of Titan Takeoff into LangChain, users will be able to inference their LLMs with minimal setup and coding overhead. You can view a short demonstration of how to use the LangChain integration with Titan Takeoff:

Demo of the Titan Takeoff X LangChain integration

Here is how you can start deploying and inferencing your LLMs in these simple steps. Install the Iris CLI, which will allow you to run the Titan Takeoff Server

```python
pip install titan-iris
```

Start the Takeoff Server, specifying the model name on HuggingFace, as well as the device if you’re using a GPU. This will pull the model from the HuggingFace server, allowing you to inference the model locally.

```python
iris takeoff --model tiiuae/falcon-7b-instruct --device cuda
```

The Takeoff server is now ready. You can then initialise the LLM object by providing it with a custom port (if not running the Takeoff server on the default port 8000) or other generation parameters such as temperature. There is also an option to specify a streaming flag.

```python
llm = TitanTakeoff(port=5000, temperature=0.8, streaming=True)output = llm("What is the weather in London in August?")print(output)

# Output: The weather in London in August can vary, with some sunny days and occasional rain showers. The average temperature is around 20-25°C (68-77°F).
```

With these simple steps, you have made your first inference call to an LLM with the Titan Takeoff Server running right on your local machine. For more examples on using the Takeoff x LangChain integration, view our guide [here](https://docs.titanml.co/docs/titan-takeoff/Advanced/langchain?ref=blog.langchain.com).

# Conclusion

The integration of Titan’s Takeoff server with LangChain marks a transformative phase in the development and deployment of language model-powered applications. As developers and enterprises seek faster, more efficient, and cost-effective ways to leverage the capabilities of LLMs, solutions like this pave the way for a smarter, seamless, and supercharged future.

# About TitanML

[TitanML](http://titanml.co/?ref=blog.langchain.com) is an NLP development platform and service focusing on the deployability of LLMs. Our Takeoff Server is a hyper-optimised LLM inference server that ‘just works’, making it the fastest and simplest way to experiment with and deploy LLMs locally.

_Our_ [_documentation_](https://docs.titanml.co/docs/category/titan-takeoff?ref=blog.langchain.com) _and_ [_Discord community_](https://discord.com/invite/gn7FYXxd?ref=blog.langchain.com) _are here to support you._