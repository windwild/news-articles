---
title: "A deep dive into Vercel’s build infrastructure - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/a-deep-dive-into-hive-vercels-builds-infrastructure"
date: "2024-10-30"
scraped_at: "2026-03-02T09:39:53.663616193+00:00"
language: "en-zh"
translated: true
description: "Vercel’s low-level untrusted and ephemeral compute platform is designed to give us the control needed to securely and efficiently manage and run builds."
---

render_with_liquid: false
Oct 30, 2024

2024 年 10 月 30 日

Building a compute platform optimized for fast, secure, and reliable builds.

构建一个专为快速、安全、可靠构建而优化的计算平台。

Vercel has a new low-level untrusted and ephemeral compute platform—designed to give us the control needed to securely and efficiently manage and run builds. Since November 2023, this compute platform, internally codenamed "Hive", has powered Vercel’s builds, enabling key improvements like enhanced build machines and a 30% improvement in build performance.

Vercel 推出了一款全新的底层、不可信且临时性的计算平台——旨在赋予我们所需控制能力，以安全、高效地管理与运行构建任务。自 2023 年 11 月以来，该内部代号为 “Hive”（蜂巢）的计算平台已全面支撑 Vercel 的构建流程，带来了关键改进，例如升级版构建机器，以及构建性能提升 30%。

The platform operates on the fundamental assumption that we’re executing potentially malicious code on multi-tenant machines, requiring it to be safe, reliable, performant, and cost-effective. It’s architected to handle multiple use cases and can be composed in different ways depending on what’s needed. Most recently, Hive allowed us to reduce [provisioning times for Secure Compute](https://vercel.com/docs/security/secure-compute#build-delay) customers from 90 seconds to 5 seconds, while also improving their build speeds.

该平台基于一项根本性假设：我们将在多租户机器上执行潜在恶意代码——因此平台必须兼具安全性、可靠性、高性能与成本效益。其架构支持多种使用场景，并可根据具体需求灵活组合。最近，Hive 成功将 [Secure Compute（安全计算）](https://vercel.com/docs/security/secure-compute#build-delay) 客户的资源准备时间从 90 秒大幅缩短至 5 秒，同时进一步提升了其构建速度。

We built Hive because we needed finer control and more granular management to continuously improve Vercel’s infrastructure, to meet the growing demands of our customers and to fulfill our vision of delivering the best development experience in the world.

我们构建 Hive，是因为我们需要更精细的控制能力和更细粒度的管理能力，以持续优化 Vercel 的基础设施，满足客户日益增长的需求，并践行我们“打造全球最佳开发体验”的愿景。

## **Inside Hive**

## **Hive 内部架构**

Each hive is a cluster running in a specific region. There can be multiple hives per region, designed to efficiently manage and execute customer builds. It’s made up of several key components that work together to handle everything from code execution to scaling.

每个 Hive 是一个部署在特定区域的集群。每个区域可部署多个 Hive，旨在高效地管理与执行客户构建任务。它由若干关键组件构成，协同完成从代码执行到弹性伸缩的全部工作。

- **Hive**: The top-level primitive in the system. We run multiple hives, and each has its own failure boundary, operating independently from the others.

- **Hive**：系统中的顶层基础单元。我们运行多个 Hive，每个 Hive 拥有独立的故障边界，彼此隔离、独立运行。

- **Box**: Refers to the bare metal machines that run the virtual machines in Hive. At this layer, we’ve implemented several optimizations to speed up VM startup times, including Docker image caching, which alone has reduced startup times by around 45 seconds compared to previous solutions which took almost 2 minutes. Additionally, we handle block device snapshotting and other optimizations to ensure each Virtual Machine (VM) starts quickly, avoiding repetitive work.

- **Box**：指承载 Hive 中虚拟机的裸金属服务器。在此层级，我们实施了多项优化措施以加速虚拟机（VM）启动，包括 Docker 镜像缓存——仅此一项便将启动耗时相比此前近 2 分钟的方案缩短了约 45 秒。此外，我们还实现了块设备快照及其他优化机制，确保每台虚拟机均可快速启动，避免重复性工作。

- **Cell**: Is what we call a virtual machine. Inside each cell, we run at least one container. Each cell is assigned dedicated CPUs and memory, while disk and network throughput are rate-limited based on the overall capacity and how the box is divided up.

- **Cell**：即我们所称的虚拟机。每个 Cell 内至少运行一个容器。每个 Cell 被分配独占的 CPU 与内存资源；而磁盘与网络吞吐量则依据整体容量及 Box 的资源划分方式实施速率限制。

- **Control Plane**: Orchestrates the cluster, managing job placement, and handling autoscaling, instance lifecycles, monitoring, and overall cluster health. It ensures each build runs smoothly and efficiently.

- **控制平面（Control Plane）**：负责集群编排，管理任务调度，并处理自动扩缩容、实例生命周期、监控以及整体集群健康状态。它确保每次构建都能平稳、高效地运行。

- **API**: Each Hive has its own API, which is minimal by design. The API primarily handles requests to run cells.

- **API**：每个 Hive 实例都拥有独立的 API，该 API 在设计上极为精简。其主要功能是处理“运行单元（cell）”的请求。

These components together make up Hive, allowing us to manage builds at scale while optimizing for performance, reliability, and resource efficiency.

上述组件共同构成了 Hive，使我们能够在大规模场景下高效管理构建任务，同时兼顾性能、可靠性与资源利用效率。

![Each Hive instance has a dedicated API, control plane, and boxes that spawn cells for running your builds.](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_001.jpg)![Each Hive instance has a dedicated API, control plane, and boxes that spawn cells for running your builds.](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_002.jpg)![Each Hive instance has a dedicated API, control plane, and boxes that spawn cells for running your builds.](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_003.jpg)![Each Hive instance has a dedicated API, control plane, and boxes that spawn cells for running your builds.](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_004.jpg)Each Hive instance has a dedicated API, control plane, and boxes that spawn cells for running your builds.

![每个 Hive 实例均配备专属 API、控制平面，以及用于启动单元（cell）以执行您构建任务的计算节点（boxes）。](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_001.jpg)![每个 Hive 实例均配备专属 API、控制平面，以及用于启动单元（cell）以执行您构建任务的计算节点（boxes）。](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_002.jpg)![每个 Hive 实例均配备专属 API、控制平面，以及用于启动单元（cell）以执行您构建任务的计算节点（boxes）。](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_003.jpg)![每个 Hive 实例均配备专属 API、控制平面，以及用于启动单元（cell）以执行您构建任务的计算节点（boxes）。](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_004.jpg)每个 Hive 实例均配备专属 API、控制平面，以及用于启动单元（cell）以执行您构建任务的计算节点（boxes）。

## **How Hive components work together**

## **Hive 各组件如何协同工作**

The inner workings of Hive is an orchestrated system that ensures secure, isolated, and efficient execution of customer builds. At the core, each box in Hive runs a [Kernel-based Virtual Machine](https://linux-kvm.org/page/Main_Page) (KVM), which is a full virtualization solution for Linux on x86 hardware. By leveraging KVM, we can run multiple virtual machines, each with its own unmodified Linux image, on a single box. This setup allows each VM to have private virtualized hardware, providing isolation and security between tenants.

Hive 的内部运作是一套高度协同的系统，旨在保障客户构建任务的安全性、隔离性与执行效率。其核心在于：Hive 中的每个计算节点（box）均运行一个 [基于内核的虚拟机（Kernel-based Virtual Machine）](https://linux-kvm.org/page/Main_Page)（KVM）——这是面向 x86 硬件平台的 Linux 全虚拟化解决方案。借助 KVM，我们可在单个物理节点上并行运行多个虚拟机，且每个虚拟机均可搭载未经修改的完整 Linux 镜像。该架构为每台虚拟机分配专属的虚拟化硬件资源，从而在不同租户之间实现强隔离与安全保障。

On top of this KVM layer, we run multiple [Firecracker](https://firecracker-microvm.github.io/) processes. Firecracker is an open-source virtualization technology—built for creating and managing secure, multi-tenant containers and function-based services within microVMs. In Hive, these microVMs are called cells. Each cell is mapped directly to a Firecracker process, this 1:1 relationship ensures that each VM is fully managed by its corresponding Firecracker process.

在此 KVM 层之上，我们运行多个 [Firecracker](https://firecracker-microvm.github.io/) 进程。Firecracker 是一款开源虚拟化技术，专为在微虚拟机（microVM）中安全、高效地创建和管理多租户容器及函数型服务而设计。在 Hive 架构中，这些微虚拟机被称为“单元（cells）”。每个单元均与一个 Firecracker 进程严格一一对应；这种 1:1 映射关系确保每个虚拟机均由其专属的 Firecracker 进程进行全生命周期管理。

Managing this complex orchestration is a box daemon that runs on each box. The box daemon is responsible for provisioning block devices, spawning Firecracker processes, and managing communication with the cells. It coordinates the setup and lifecycle of each cell by communicating with a cell daemon inside the cells through a dedicated socket connection.

负责协调这一复杂编排流程的是运行于每个计算节点上的“节点守护进程（box daemon）”。该守护进程负责块设备供给、Firecracker 进程的启动，以及与各单元之间的通信管理。它通过专用套接字（socket）连接，与单元内部运行的“单元守护进程（cell daemon）”交互，从而统筹每个单元的初始化配置与全生命周期管理。

The cell daemon inside each cell plays an equally important role. It maintains communication with the box daemon and controls the build containers that execute customer workloads. When a build request arrives, the cell daemon ensures that the container runtime starts, stops, or runs the necessary containers. This tight integration between the box and cell daemons allows Hive to effectively manage isolated environments and quickly handle customer builds.

单元内部的“单元守护进程（cell daemon）”同样承担关键职责：它持续与节点守护进程保持通信，并管控实际执行客户工作负载的构建容器（build containers）。当收到构建请求时，单元守护进程确保容器运行时（container runtime）准确完成容器的启动、停止或运行等操作。节点守护进程与单元守护进程之间的深度集成，使 Hive 能够高效管理彼此隔离的运行环境，并快速响应客户构建请求。

This entire architecture allows Hive to balance secure isolation, fast startup times, and the scalability required for customer builds—all while minimizing overhead and optimizing performance.

整套架构使 Hive 能在保障安全隔离性的同时，实现极快的启动速度与面向客户构建任务所需的弹性扩展能力——所有这一切均建立在最小化系统开销、最大化性能表现的基础之上。

![A box daemon handles provisioning, spawning Firecracker processes, and managing cell lifecycles via a socket connection with a cell daemon.](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_005.jpg)  
![一个 box daemon 通过与 cell daemon 的套接字连接，负责资源供给、启动 Firecracker 进程以及管理 cell 生命周期。](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_005.jpg)  

![A box daemon handles provisioning, spawning Firecracker processes, and managing cell lifecycles via a socket connection with a cell daemon.](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_006.jpg)  
![一个 box daemon 通过与 cell daemon 的套接字连接，负责资源供给、启动 Firecracker 进程以及管理 cell 生命周期。](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_006.jpg)  

![A box daemon handles provisioning, spawning Firecracker processes, and managing cell lifecycles via a socket connection with a cell daemon.](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_007.jpg)  
![一个 box daemon 通过与 cell daemon 的套接字连接，负责资源供给、启动 Firecracker 进程以及管理 cell 生命周期。](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_007.jpg)  

![A box daemon handles provisioning, spawning Firecracker processes, and managing cell lifecycles via a socket connection with a cell daemon.](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_008.jpg)  
![一个 box daemon 通过与 cell daemon 的套接字连接，负责资源供给、启动 Firecracker 进程以及管理 cell 生命周期。](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_008.jpg)  

A box daemon handles provisioning, spawning Firecracker processes, and managing cell lifecycles via a socket connection with a cell daemon.  

一个 box daemon 通过与 cell daemon 的套接字连接，负责资源供给、启动 Firecracker 进程以及管理 cell 生命周期。

## Life of a build

## 构建任务的生命周期

When a build task is initiated, the build pipeline selects the appropriate hive cluster based on the customer and build configuration. It uses the Hive API to run the build inside a container within a cell. While Hive is responsible for running and scaling the containers' execution, it doesn’t manage each container’s internals. The build pipeline, which uses the Hive API, provides the build container image ready to execute the build.  

当构建任务被触发时，构建流水线会根据客户身份和构建配置，选择最合适的 Hive 集群；再通过 Hive API，在某个 cell 内的容器中执行构建任务。Hive 负责容器的运行与横向伸缩，但不介入每个容器内部的具体逻辑。构建流水线（调用 Hive API）则提供已准备就绪、可直接执行构建任务的容器镜像。

To ensure quick starts, we cache the build container image, as it's a fairly large container, so it’s typically pre-loaded in a cell. Booting the VM and preparing everything takes only a few seconds, so we maintain a pool of pre-warmed cells ready to handle the load. If a pre-warmed cell is available, the build starts immediately. In rare cases, like during traffic spikes or for specific builds such as Secure Compute, a new cell must be provisioned, which takes about 5 seconds. Once the build is complete, the cell is destroyed.  

为确保快速启动，我们对构建容器镜像进行缓存——因其体积较大，通常已预先加载至 cell 中。虚拟机启动及全部环境准备仅需数秒，因此我们维护了一个“预热”（pre-warmed）cell 池，随时应对负载高峰。若存在可用的预热 cell，构建即刻开始；仅在极少数场景下（例如流量激增，或执行 Secure Compute 等特定类型构建），才需新建 cell，耗时约 5 秒。构建完成后，该 cell 即被销毁。

![The Vercel Build Pipeline interfaces with multiple Hive instances globally, each scaling to meet build demands.](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_009.jpg)  
![Vercel 构建流水线在全球范围内对接多个 Hive 实例，各实例均可按需弹性伸缩以满足构建需求。](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_009.jpg)  

![The Vercel Build Pipeline interfaces with multiple Hive instances globally, each scaling to meet build demands.](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_010.jpg)  
![Vercel 构建流水线在全球范围内对接多个 Hive 实例，各实例均可按需弹性伸缩以满足构建需求。](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_010.jpg)  

![The Vercel Build Pipeline interfaces with multiple Hive instances globally, each scaling to meet build demands.](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_011.jpg)  
![Vercel 构建流水线在全球范围内对接多个 Hive 实例，各实例均可按需弹性伸缩以满足构建需求。](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_011.jpg)  

![The Vercel Build Pipeline interfaces with multiple Hive instances globally, each scaling to meet build demands.](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_012.jpg)  
![Vercel 构建流水线在全球范围内对接多个 Hive 实例，各实例均可按需弹性伸缩以满足构建需求。](images/a-deep-dive-into-vercel_s-build-infrastructure-vercel/img_012.jpg)  

The Vercel Build Pipeline interfaces with multiple Hive instances globally, each scaling to meet build demands.  

Vercel 构建流水线在全球范围内对接多个 Hive 实例，各实例均可按需弹性伸缩以满足构建需求。

## **The impact of Hive: before and after**

## **Hive 带来的变革：前后对比**

Since adopting Hive, we’ve seen significant improvements across the board. Overall, there has been a 20% reduction in build times compared to our previous solution. Builds that require spawning a new cell have benefited even more, with provisioning times dropping from nearly 90 seconds to 5 seconds and build times, decreasing by 40%.  

自采用 Hive 以来，我们在各方面均取得了显著提升：整体构建耗时相较原有方案降低了 20%；而需新建 cell 的构建任务获益尤为突出——资源供给时间从近 90 秒缩短至 5 秒，构建总耗时亦下降 40%。

In addition to these speed gains, Hive has delivered more stable performance and flexibility. For example, it's enabled us to offer enhanced machines for customers who need extra memory or disk space.  

除上述性能提升外，Hive 还带来了更稳定的运行表现与更高的灵活性。例如，我们现已能为有更高内存或磁盘空间需求的客户提供增强型计算实例。

## **Start building with Vercel today**

## **立即使用 Vercel 开始构建**

Hive has been powering Vercel builds behind the scenes for over a year, and you can experience the benefits firsthand. By building on Vercel, you’re tapping into a platform that continuously improves and scales with your needs, all backed by Hive’s secure and efficient compute capabilities. Whether you’re deploying small projects or handling large-scale builds, Hive is designed to support your applications.  

Hive 已在幕后驱动 Vercel 构建任务逾一年之久，您现在即可亲身体验其优势。选择 Vercel 进行构建，意味着接入一个持续演进、随需伸缩的平台——其底层由 Hive 提供安全、高效的计算能力支撑。无论您部署的是小型项目，还是处理大规模构建任务，Hive 均专为支撑您的应用而设计。

We’re actively working on making builds even faster by improving caching strategies, optimizing cloning processes, and enhancing overall performance.

我们正积极通过改进缓存策略、优化克隆流程以及提升整体性能，来进一步加快构建速度。

As a general-purpose compute platform, Hive has endless potential beyond builds. We’re investing in exploring new use cases to unlock even more value for developers.

作为通用计算平台，Hive 的潜力远不止于构建任务。我们正投入资源探索更多新应用场景，以期为开发者释放更大价值。

Join us in building a faster, and more scalable web. [Start building on Vercel today, powered by Hive](https://vercel.com/templates/next.js/nextjs-boilerplate).

加入我们，共同构建更快、更具可扩展性的网络。[立即在 Vercel 上开始构建（由 Hive 提供支持）](https://vercel.com/templates/next.js/nextjs-boilerplate)