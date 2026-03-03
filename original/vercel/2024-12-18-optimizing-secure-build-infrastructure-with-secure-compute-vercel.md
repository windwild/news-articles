---
title: "Optimizing secure build infrastructure with Secure Compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/optimizing-secure-builds-with-hive-and-secure-compute"
date: "2024-12-18"
scraped_at: "2026-03-02T09:38:44.406196375+00:00"
language: "en"
translated: false
description: "We built Hive, our general compute platform, after outgrowing off-the-shelf solutions.  See how it's now powering secure connections to private networks, cutting initialization from 90s to 5s and impr..."
---




Dec 18, 2024

In our previous blog post, we [introduced Hive, the internal codename for Vercel’s low-level compute platform](https://vercel.com/blog/a-deep-dive-into-hive-vercels-builds-infrastructure), powering all of our builds. However, some builds come with unique security requirements. For these, Hive integrates seamlessly with Vercel's [Secure Compute](https://vercel.com/docs/security/secure-compute), which enables teams to securely connect with their backends through private connections without compromising performance.

Since [moving Secure Compute to Hive](https://vercel.com/changelog/improvements-to-vercel-secure-compute-builds-provisioning-time), provisioning times have dropped from **90 seconds to 5 seconds** and build performance has improved by an **average of 30%**, delivering both speed and reliability for even the most sensitive workloads.

## **Key components for building secure connections**

To enable the integration between Hive and Secure Compute, several key components work together.

### Connectors

[EC2](https://aws.amazon.com/ec2/) instances running inside the Secure Compute network that terminate [WireGuard](https://www.wireguard.com/) ® connections and securely route network traffic. These connectors behave as if they were part of the Hive network, enabling seamless communication. Each connector runs a daemon that interfaces with the Key Exchange Service to manage key distribution and routing information. Additionally, a WireGuard interface on each connector is responsible for creating secure tunnels with each Hive cell.

The instances are managed by autoscalers with custom [Amazon Machine Images](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html) (AMIs) built by us, ensuring the connectors are ready to handle traffic efficiently as soon as they are instantiated. These instances are set up to be cycle frequently to ensure the system is up to date, and that their keys are short-lived and ephemeral.

### Key Exchange Service

Facilitates key distribution across private networks and EC2 instances. It manages tasks such as sharing WireGuard public keys, distributing box and connector IPs, and cleaning up stale resources. This service is internal to us and ensures that all peers in the network are authenticated and authorized to participate.

### WireGuard

Encrypts traffic between [Hive cells](https://vercel.com/blog/a-deep-dive-into-hive-vercels-builds-infrastructure#inside-hive) and Secure Compute networks, ensuring security and privacy. It’s exposed on the connector side but always initiated from the Hive box side, guaranteeing that connections are tracked and secure by default.

Each Hive cell initiates a secure tunnel with the connector’s WireGuard interface. Keys are generated at instance boot and distributed via the Key Exchange Service, with no persistence or reuse. They are automatically removed when instances shut down, maintaining a secure lifecycle.

### Network Routing

When a Secure Compute connected cell starts up, we move its network resources into a namespace that is associated with the secure tunnel. This allows programmatic access to Linux's netlink layer to set up namespaces, routing, source-based routing, and with custom [CNI plugins](https://www.cni.dev/). This setup ensures traffic flows correctly and securely back through the same path it came from, maintaining reliability and security.

![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_001.jpg)![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_002.jpg)![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_003.jpg)![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_004.jpg)

## **How secure traffic flows through the system**

When a cell in a Hive box initiates a network call, the traffic is encrypted by a WireGuard interface configured with a unique private IP for the box. The traffic flows through the appropriate connector in the Secure Compute network, where it’s decrypted and routed to its destination.

To handle this routing, we create one namespace per WireGuard interface within the box. Each namespace includes a WireGuard device that serves as the gateway for encrypted traffic. The host-side of the tunnel from a cell is placed inside this namespace, ensuring all cell traffic is encrypted and correctly routed.

On the connector side, the setup is simpler. A single WireGuard device handles all incoming traffic, configured with the box as a peer. This abstraction ensures the connector doesn’t need to know the specifics of which device generated the traffic—just that it’s coming from an authenticated and authorized peer.

![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_005.jpg)![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_006.jpg)![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_007.jpg)![](images/optimizing-secure-build-infrastructure-with-secure-compute-vercel/img_008.jpg)

## Starting a new Secure Compute build

When a build requiring Secure Compute is created, the build pipeline submits a Secure Compute ID, tied to the Secure Compute network, within the build task payload. The Hive box uses this information to find a network interfaces so that all cell traffic routes through the appropriate connector.

Then, a new cell is provisioned in about 5 seconds. The traffic from the cell is encrypted, routed to the connector, and securely processed within the Secure Compute network.

## **Before and after: Securing builds with efficiency**

Before Hive, secure builds were run using [Fargate](https://aws.amazon.com/fargate/) within the private network. While effective for security, Fargate introduced significant delays. Provisioning times took up to 90 seconds before a build could even start. This delay directly impacted iteration velocity.

By transitioning to Hive, we’ve reduced provisioning times dramatically—from 90 seconds to 5 seconds. Hive’s architecture allows us to spawn cells and quickly provision secure environments, ensuring builds start faster while maintaining the same level of network security. This improvement speeds up workflows and delivers a more consistent and efficient experience for sensitive workloads.

## **Build faster and connect securely**

Hive is more than a compute platform—it’s the backbone of Vercel’s infrastructure, delivering optimal performance, security, and automatic scale. Improved provisioning times and build performance means you can ship quickly, even in the most [demanding and sensitive workflows](https://vercel.com/security).

[**Want elevated security and control?**\\
\\
Contact us to discuss Secure Compute and see how Vercel Enterprise can improve your secure workflow velocity.\\
\\
Contact us](https://vercel.com/contact/sales/security)