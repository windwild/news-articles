---
render_with_liquid: false
title: "Optimizing secure build infrastructure with Secure Compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/optimizing-secure-builds-with-hive-and-secure-compute"
date: "2024-12-18"
scraped_at: "2026-03-02T09:38:44.406196375+00:00"
language: "en-zh"
translated: true
description: "We built Hive, our general compute platform, after outgrowing off-the-shelf solutions.  See how it's now powering secure connections to private networks, cutting initialization from 90s to 5s and impr..."
---
render_with_liquid: false
render_with_liquid: false

Dec 18, 2024

2024 年 12 月 18 日

In our previous blog post, we [introduced Hive, the internal codename for Vercel’s low-level compute platform](https://vercel.com/blog/a-deep-dive-into-hive-vercels-builds-infrastructure), powering all of our builds. However, some builds come with unique security requirements. For these, Hive integrates seamlessly with Vercel's [Secure Compute](https://vercel.com/docs/security/secure-compute), which enables teams to securely connect with their backends through private connections without compromising performance.

在上一篇博客文章中，我们[介绍了 Hive —— Vercel 底层计算平台的内部代号](https://vercel.com/blog/a-deep-dive-into-hive-vercels-builds-infrastructure)，该平台支撑着我们全部构建任务。然而，部分构建任务具有独特的安全要求。针对此类场景，Hive 与 Vercel 的 [Secure Compute（安全计算）](https://vercel.com/docs/security/secure-compute) 无缝集成，使团队能够通过私有连接安全地访问其后端服务，同时不牺牲性能。

Since [moving Secure Compute to Hive](https://vercel.com/changelog/improvements-to-vercel-secure-compute-builds-provisioning-time), provisioning times have dropped from **90 seconds to 5 seconds** and build performance has improved by an **average of 30%**, delivering both speed and reliability for even the most sensitive workloads.

自 [将 Secure Compute 迁移至 Hive](https://vercel.com/changelog/improvements-to-vercel-secure-compute-builds-provisioning-time) 以来，资源准备时间已从 **90 秒缩短至 5 秒**，构建性能平均提升 **30%**，从而为最敏感的工作负载同时提供速度与可靠性保障。

## **Key components for building secure connections**

## **构建安全连接的关键组件**

To enable the integration between Hive and Secure Compute, several key components work together.

为实现 Hive 与 Secure Compute 的集成，多个关键组件协同工作。

### Connectors

### 连接器（Connectors）

[EC2](https://aws.amazon.com/ec2/) instances running inside the Secure Compute network that terminate [WireGuard](https://www.wireguard.com/) ® connections and securely route network traffic. These connectors behave as if they were part of the Hive network, enabling seamless communication. Each connector runs a daemon that interfaces with the Key Exchange Service to manage key distribution and routing information. Additionally, a WireGuard interface on each connector is responsible for creating secure tunnels with each Hive cell.

部署于 Secure Compute 网络内的 [EC2](https://aws.amazon.com/ec2/) 实例，用于终止 [WireGuard](https://www.wireguard.com/)® 连接并安全地路由网络流量。这些连接器的行为如同 Hive 网络的一部分，从而实现无缝通信。每个连接器均运行一个守护进程（daemon），与密钥交换服务（Key Exchange Service）交互，以管理密钥分发和路由信息；此外，每个连接器上的 WireGuard 接口负责与各个 Hive 单元（cell）建立安全隧道。

The instances are managed by autoscalers with custom [Amazon Machine Images](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html) (AMIs) built by us, ensuring the connectors are ready to handle traffic efficiently as soon as they are instantiated. These instances are set up to be cycle frequently to ensure the system is up to date, and that their keys are short-lived and ephemeral.

这些实例由自动伸缩器（autoscalers）统一管理，并采用我们定制的 [Amazon 机器镜像（AMI）](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html)，确保连接器一经启动即可高效处理流量。实例被配置为高频轮换（cycle frequently），以保障系统始终处于最新状态，且所用密钥具备短时效性与临时性（short-lived and ephemeral）。

### Key Exchange Service

### 密钥交换服务（Key Exchange Service）

Facilitates key distribution across private networks and EC2 instances. It manages tasks such as sharing WireGuard public keys, distributing box and connector IPs, and cleaning up stale resources. This service is internal to us and ensures that all peers in the network are authenticated and authorized to participate.

在私有网络与 EC2 实例之间协调密钥分发。该服务负责多项任务，包括分发 WireGuard 公钥、分发“box”与连接器的 IP 地址，以及清理过期资源。该服务为 Vercel 内部专属，确保网络中所有对等节点（peers）均已通过身份认证与授权，方可参与通信。

### WireGuard

### WireGuard（WireGuard 协议）

Encrypts traffic between [Hive cells](https://vercel.com/blog/a-deep-dive-into-hive-vercels-builds-infrastructure#inside-hive) and Secure Compute networks, ensuring security and privacy. It’s exposed on the connector side but always initiated from the Hive box side, guaranteeing that connections are tracked and secure by default.

该协议对 [Hive 节点（Hive cells）](https://vercel.com/blog/a-deep-dive-into-hive-vercels-builds-infrastructure#inside-hive) 与 Secure Compute 网络之间的通信流量进行加密，从而保障安全性与隐私性。WireGuard 接口在连接器（connector）侧对外暴露，但所有连接始终由 Hive 设备端主动发起，确保连接默认可追踪且安全。

Each Hive cell initiates a secure tunnel with the connector’s WireGuard interface. Keys are generated at instance boot and distributed via the Key Exchange Service, with no persistence or reuse. They are automatically removed when instances shut down, maintaining a secure lifecycle.

每个 Hive 节点均与连接器的 WireGuard 接口建立一条安全隧道。密钥在实例启动时动态生成，并通过密钥交换服务（Key Exchange Service）分发，不持久化存储、也不重复使用；实例关闭时密钥自动销毁，从而维持端到端的安全生命周期。

### Network Routing

### 网络路由

When a Secure Compute connected cell starts up, we move its network resources into a namespace that is associated with the secure tunnel. This allows programmatic access to Linux's netlink layer to set up namespaces, routing, source-based routing, and with custom [CNI plugins](https://www.cni.dev/). This setup ensures traffic flows correctly and securely back through the same path it came from, maintaining reliability and security.

当一个接入 Secure Compute 的节点启动时，我们将它的网络资源迁移至一个与安全隧道关联的 Linux 网络命名空间（namespace）中。此举使系统可通过编程方式访问 Linux 的 netlink 接口，以配置命名空间、路由规则、基于源地址的路由（source-based routing），以及集成自定义的 [CNI 插件](https://www.cni.dev/)。该架构确保流量能准确、安全地沿原路径返回，兼顾可靠性与安全性。

![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_001.jpg)![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_002.jpg)![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_003.jpg)![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_004.jpg)

## **How secure traffic flows through the system**

## **安全流量在系统中的传输路径**

When a cell in a Hive box initiates a network call, the traffic is encrypted by a WireGuard interface configured with a unique private IP for the box. The traffic flows through the appropriate connector in the Secure Compute network, where it’s decrypted and routed to its destination.

当 Hive 设备中的某个节点发起网络请求时，其流量将由一个为该设备分配了唯一私有 IP 地址的 WireGuard 接口进行加密。加密后的流量经由 Secure Compute 网络中对应的连接器（connector）转发，在该连接器处完成解密并路由至最终目标地址。

To handle this routing, we create one namespace per WireGuard interface within the box. Each namespace includes a WireGuard device that serves as the gateway for encrypted traffic. The host-side of the tunnel from a cell is placed inside this namespace, ensuring all cell traffic is encrypted and correctly routed.

为实现上述路由逻辑，我们在 Hive 设备内部为每个 WireGuard 接口创建一个独立的命名空间。每个命名空间内均包含一个 WireGuard 设备，作为加密流量的网关。来自节点的隧道主机端（host-side）被置于该命名空间中，从而确保所有节点流量均被加密并正确路由。

On the connector side, the setup is simpler. A single WireGuard device handles all incoming traffic, configured with the box as a peer. This abstraction ensures the connector doesn’t need to know the specifics of which device generated the traffic—just that it’s coming from an authenticated and authorized peer.

在连接器侧，配置更为简洁：仅需一个 WireGuard 设备即可处理全部入站流量，且该设备将 Hive 设备配置为其对等节点（peer）。这一抽象设计使得连接器无需感知具体是哪个设备发起了流量——只需确认该流量源自一个已认证且获授权的对等节点即可。

![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_005.jpg)![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_006.jpg)![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_007.jpg)![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_008.jpg)

## Starting a new Secure Compute build

## 启动新的 Secure Compute 构建

When a build requiring Secure Compute is created, the build pipeline submits a Secure Compute ID, tied to the Secure Compute network, within the build task payload. The Hive box uses this information to find a network interfaces so that all cell traffic routes through the appropriate connector.

当创建一个需要 Secure Compute 的构建任务时，构建流水线会在构建任务载荷（payload）中提交一个与 Secure Compute 网络绑定的 Secure Compute ID。Hive 节点利用该信息查找网络接口，确保所有单元（cell）流量均经由对应的连接器（connector）路由。

Then, a new cell is provisioned in about 5 seconds. The traffic from the cell is encrypted, routed to the connector, and securely processed within the Secure Compute network.

随后，一个新的单元将在约 5 秒内完成部署。来自该单元的所有流量均经过加密，被路由至连接器，并在 Secure Compute 网络内进行安全处理。

## **Before and after: Securing builds with efficiency**

## **优化前后：高效实现构建安全化**

Before Hive, secure builds were run using [Fargate](https://aws.amazon.com/fargate/) within the private network. While effective for security, Fargate introduced significant delays. Provisioning times took up to 90 seconds before a build could even start. This delay directly impacted iteration velocity.

在 Hive 推出之前，安全构建任务依赖于私有网络内的 [Fargate](https://aws.amazon.com/fargate/) 运行。尽管其安全性表现优异，但 Fargate 带来了显著延迟——资源准备时间最长可达 90 秒，构建任务甚至尚未启动。这一延迟直接影响了开发迭代速度。

By transitioning to Hive, we’ve reduced provisioning times dramatically—from 90 seconds to 5 seconds. Hive’s architecture allows us to spawn cells and quickly provision secure environments, ensuring builds start faster while maintaining the same level of network security. This improvement speeds up workflows and delivers a more consistent and efficient experience for sensitive workloads.

通过迁移到 Hive，我们将资源准备时间大幅缩短——从 90 秒降至 5 秒。Hive 的架构支持快速生成单元并即时配置安全环境，在保持同等网络安全性的同时，显著加快构建启动速度。这一改进提升了工作流效率，为敏感型工作负载提供了更稳定、更高效的操作体验。

## **Build faster and connect securely**

## **更快构建，安全连接**

Hive is more than a compute platform—it’s the backbone of Vercel’s infrastructure, delivering optimal performance, security, and automatic scale. Improved provisioning times and build performance means you can ship quickly, even in the most [demanding and sensitive workflows](https://vercel.com/security).

Hive 不仅仅是一个计算平台——它更是 Vercel 基础设施的核心支柱，提供卓越的性能、安全性与自动扩缩能力。资源准备时间与构建性能的提升，意味着您即使面对最[严苛且敏感的工作负载](https://vercel.com/security)，也能快速交付成果。

[**Want elevated security and control?**\\
\\
Contact us to discuss Secure Compute and see how Vercel Enterprise can improve your secure workflow velocity.\\
\\
Contact us](https://vercel.com/contact/sales/security)

[**需要更高层级的安全性与管控能力？**\\
\\
欢迎联系我们，探讨 Secure Compute 方案，并了解 Vercel Enterprise 如何提升您安全工作流的执行效率。\\
\\
立即联系](https://vercel.com/contact/sales/security)