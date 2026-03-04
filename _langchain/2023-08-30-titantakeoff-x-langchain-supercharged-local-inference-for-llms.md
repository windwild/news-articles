---
render_with_liquid: false
title: "TitanTakeoff x LangChain: Supercharged Local Inference for LLMs"
source: "LangChain Blog"
url: "https://blog.langchain.com/titantakeoff-x-langchain-supercharged-local-inference-for-llms-2/"
date: "2023-08-30"
scraped_at: "2026-03-03T08:48:07.225197117+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

_Editor's Note: This post was written in collaboration with the [TitanML](https://www.titanml.co/?ref=blog.langchain.com) team. The integration between their NLP development platform + LangChain makes inference LLMs super easy!_

_编辑注：本文由 [TitanML](https://www.titanml.co/?ref=blog.langchain.com) 团队联合撰写。其 NLP 开发平台与 LangChain 的深度集成，让大语言模型（LLM）推理变得极为简单！_

# Challenges

# 挑战

With the release of many open source large language models over the past year, developers are increasingly keen to jump on the bandwagon and deploy their own LLMs. However, without specialised knowledge, developers who are experimenting with deploying LLMs on their own hardware may face unexpected technical difficulties. The recent scramble for powerful GPUs has also made it significantly harder to secure sufficient GPU allocation to deploy the best model at the desired latency and scale.

过去一年间，大量开源大语言模型相继发布，开发者们愈发热衷于“搭上顺风车”，部署属于自己的 LLM。然而，若缺乏专业知识，尝试在自有硬件上部署 LLM 的开发者，往往面临始料未及的技术难题。近期对高性能 GPU 的激烈争夺，更使得为满足目标延迟与扩展规模而获取充足 GPU 资源变得异常困难。

Developers are faced with an unappealing choice between suboptimal applications due to compromises on model size and quality, or costly deployments because of manual optimisations and reliance on expensive GPUs, not to mention wasted time dealing with boring and one-off technical eccentricities.

开发者被迫陷入两难困境：要么因缩减模型规模、牺牲模型质量而导致应用效果欠佳；要么依赖人工优化与高价 GPU，导致部署成本高昂——更不必说，还要耗费大量时间去应对枯燥且高度定制化的技术细节。

# Titan Takeoff Server

# Titan Takeoff 服务器

Falcon-7B-instruct model running on a CPU with Titan Takeoff Server.

Falcon-7B-instruct 模型在 CPU 上通过 Titan Takeoff 服务器运行。

That being said, deploying your own models locally doesn’t have to be difficult and frustrating. The Titan Takeoff Server offers a simple solution for the local deployment of open-source Large Language Models (LLMs) even on memory-constrained CPUs. With it, users gain the benefits of on-premises inferencing — reduced latency, enhanced data security, cost savings in the long run, and unparalleled flexibility in model customization and integration without additional complexity, not to mention the ability to deploy larger and more powerful models on memory-constrained hardware.

话虽如此，本地部署自有模型未必一定困难重重、令人沮丧。Titan Takeoff 服务器为开源大语言模型（LLM）的本地部署提供了一种简洁高效的解决方案，甚至可在内存受限的 CPU 设备上运行。借助该服务器，用户可充分享受本地推理（on-premises inferencing）的各项优势：更低的延迟、更强的数据安全性、长期来看更具成本效益，以及在模型定制与集成方面的无与伦比的灵活性——且无需额外复杂性；更值得一提的是，它还能让开发者在内存受限的硬件上成功部署更大、更强大的模型。

![](images/titantakeoff-x-langchain-supercharged-local-inference-for-llms/img_001.png)Titan Takeoff Server offers significant performance benefits for deployment and inferencing of LLMs.

![](images/titantakeoff-x-langchain-supercharged-local-inference-for-llms/img_001.png)Titan Takeoff 服务器为 LLM 的部署与推理带来显著的性能提升。

With its lightning fast inference speeds and support on low cost, readily available devices, the Titan Takeoff Server is suitable for developers who need to constantly deploy, test and refine their LLMs. Through the use of state of the art memory compression techniques, the Titan Takeoff Server offers a 10x improvement in throughput, a 3-4x improvement in latency and a 4–20x cost saving through the use of smaller GPUs, in comparison with the base model implementation. In an era where control and efficiency are paramount, the Titan Takeoff Server stands out as an optimal solution for deploying and inferencing LLMs.

凭借闪电般的推理速度，以及对低成本、易获取设备的广泛支持，Titan Takeoff 服务器非常适合需要持续部署、测试与迭代优化其 LLM 的开发者。通过采用业界领先的内存压缩技术，相较于基础模型实现方案，Titan Takeoff 服务器可将吞吐量提升 10 倍、延迟降低 3–4 倍，并借助更小规格的 GPU 实现 4–20 倍的成本节约。在控制力与效率至为关键的时代，Titan Takeoff 服务器无疑是部署与运行 LLM 的理想之选。

# Seamless Integration with LangChain

# 与 LangChain 无缝集成

With the recent integration of Titan Takeoff into LangChain, users will be able to inference their LLMs with minimal setup and coding overhead.  
随着 Titan Takeoff 最近集成到 LangChain 中，用户只需极少的配置和代码开销，即可对自有的大语言模型（LLM）进行推理。

You can view a short demonstration of how to use the LangChain integration with Titan Takeoff:  
您可以观看一段简短演示，了解如何将 Titan Takeoff 与 LangChain 集成使用：

Demo of the Titan Takeoff X LangChain integration  
Titan Takeoff × LangChain 集成演示

Here is how you can start deploying and inferencing your LLMs in these simple steps. Install the Iris CLI, which will allow you to run the Titan Takeoff Server  
以下是开始部署并推理您自有 LLM 的简单步骤：首先安装 Iris CLI 工具，它将使您能够运行 Titan Takeoff 服务器。

```python
pip install titan-iris
```

Start the Takeoff Server, specifying the model name on HuggingFace, as well as the device if you’re using a GPU. This will pull the model from the HuggingFace server, allowing you to inference the model locally.  
启动 Takeoff 服务器，指定 Hugging Face 上的模型名称；若您使用 GPU，还需指定设备类型。该命令将从 Hugging Face 服务器拉取模型，使您可在本地执行模型推理。

```python
iris takeoff --model tiiuae/falcon-7b-instruct --device cuda
```

The Takeoff server is now ready. You can then initialise the LLM object by providing it with a custom port (if not running the Takeoff server on the default port 8000) or other generation parameters such as temperature. There is also an option to specify a streaming flag.  
Takeoff 服务器现已就绪。接下来，您可通过传入自定义端口（若您未在默认端口 8000 上运行 Takeoff 服务器）、温度（temperature）等生成参数来初始化 LLM 对象；您还可选择启用流式响应（streaming）功能。

```python
llm = TitanTakeoff(port=5000, temperature=0.8, streaming=True)output = llm("What is the weather in London in August?")print(output)

# Output: The weather in London in August can vary, with some sunny days and occasional rain showers. The average temperature is around 20-25°C (68-77°F).
```

With these simple steps, you have made your first inference call to an LLM with the Titan Takeoff Server running right on your local machine.  
通过以上几个简单步骤，您已在本地机器上成功运行 Titan Takeoff 服务器，并完成了对大语言模型的首次推理调用。

For more examples on using the Takeoff x LangChain integration, view our guide [here](https://docs.titanml.co/docs/titan-takeoff/Advanced/langchain?ref=blog.langchain.com).  
如需更多关于 Takeoff × LangChain 集成的使用示例，请参阅我们的指南：[此处](https://docs.titanml.co/docs/titan-takeoff/Advanced/langchain?ref=blog.langchain.com)。

# Conclusion

# 结论

The integration of Titan’s Takeoff server with LangChain marks a transformative phase in the development and deployment of language model-powered applications. As developers and enterprises seek faster, more efficient, and cost-effective ways to leverage the capabilities of LLMs, solutions like this pave the way for a smarter, seamless, and supercharged future.

TitanML 的 Takeoff 服务器与 LangChain 的集成，标志着语言模型驱动型应用在开发与部署方面迈入了一个变革性阶段。随着开发者和企业不断寻求更快速、更高效、更具成本效益的方式来利用大语言模型（LLM）的能力，此类解决方案正为更智能、更无缝、更强劲的未来铺平道路。

# About TitanML

# 关于 TitanML

[TitanML](http://titanml.co/?ref=blog.langchain.com) is an NLP development platform and service focusing on the deployability of LLMs. Our Takeoff Server is a hyper-optimised LLM inference server that ‘just works’, making it the fastest and simplest way to experiment with and deploy LLMs locally.

[TitanML](http://titanml.co/?ref=blog.langchain.com) 是一个专注于大语言模型（LLM）可部署性的自然语言处理（NLP）开发平台与服务。我们的 Takeoff Server 是一款高度优化的 LLM 推理服务器，开箱即用（“just works”），是本地实验与部署 LLM 最快速、最简便的方式。

_Our_ [_documentation_](https://docs.titanml.co/docs/category/titan-takeoff?ref=blog.langchain.com) _and_ [_Discord community_](https://discord.com/invite/gn7FYXxd?ref=blog.langchain.com) _are here to support you._

_我们的_[_文档_](https://docs.titanml.co/docs/category/titan-takeoff?ref=blog.langchain.com)_与_[_Discord 社区_](https://discord.com/invite/gn7FYXxd?ref=blog.langchain.com)_随时为您提供支持。_