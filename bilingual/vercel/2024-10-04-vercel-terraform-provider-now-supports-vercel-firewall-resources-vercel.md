---
title: "Vercel Terraform Provider now supports Vercel Firewall resources - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-terraform-provider-now-supports-vercel-firewall"
date: "2024-10-04"
scraped_at: "2026-03-02T09:40:41.270364316+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Oct 4, 2024

2024 年 10 月 4 日

The [Vercel Terraform Provider](https://registry.terraform.io/providers/vercel/vercel/latest/docs) now allows you to customize and control the [Vercel Firewall](https://vercel.com/docs/security/vercel-firewall) through Infrastructure as Code (IaC).

[ Vercel Terraform Provider ](https://registry.terraform.io/providers/vercel/vercel/latest/docs) 现已支持通过基础设施即代码（Infrastructure as Code，IaC）来自定义和管控 [Vercel 防火墙](https://vercel.com/docs/security/vercel-firewall)。

Key resources and their capabilities include:

关键资源及其功能包括：

- Resource: `vercel_attack_challenge_mode`

  - Resource：`vercel_attack_challenge_mode`

  - Toggle [Attack Challenge Mode](https://registry.terraform.io/providers/vercel/vercel/latest/docs/resources/attack_challenge_mode) .

  - 启用或禁用 [攻击挑战模式（Attack Challenge Mode）](https://registry.terraform.io/providers/vercel/vercel/latest/docs/resources/attack_challenge_mode)。

- Resource: `vercel_firewall_config`

  - Resource：`vercel_firewall_config`

  - Attribute block: `rules`—Define and adjust [custom rules](https://registry.terraform.io/providers/vercel/vercel/latest/docs/resources/firewall_config).

  - 属性块：`rules` — 定义并调整 [自定义规则（custom rules）](https://registry.terraform.io/providers/vercel/vercel/latest/docs/resources/firewall_config)。

  - Attribute block: `ip_rules`—Manage a list of [blocked IP addresses](https://registry.terraform.io/providers/vercel/vercel/latest/docs/resources/firewall_config).

  - 属性块：`ip_rules` — 管理 [被屏蔽的 IP 地址列表](https://registry.terraform.io/providers/vercel/vercel/latest/docs/resources/firewall_config)。

For example, to create a new rule that challenges requests where the `user_agent` contains `curl`:

例如，创建一条新规则，对 `user_agent` 中包含 `curl` 的请求触发挑战验证：

```text
resource "vercel_firewall_config" "example" {

2  project_id = vercel_project.example.id
```

3  rules {

3  规则 {

4    rule {

4    规则 {

5      name = "Challenge curl"

5      名称 = "挑战 curl"

6      description = "Challenge user agents containing 'curl'"

6      描述 = "挑战用户代理（User Agent）中包含 'curl' 的请求"

7      condition_group = [{\
\
7      条件组 = [{\
\
8        conditions = [{\
\
8        条件 = [{\
\
9          type = "user_agent"\
\
9          类型 = "user_agent"\
\
10          op = "sub"\
\
10          操作符 = "sub"\
\
11          value = "curl"\
\
11          值 = "curl"\
\
12        }]\
\
12        }]\
\
13      }]

13      }]

14      action = {

14      动作 = {

15        action = "challenge"

15        动作 = "challenge"

16      }

16      }

17    }

17    }

18  }

18  }

19}
```

立即开始使用 [Vercel 的 Terraform Provider](https://vercel.com/guides/integrating-terraform-with-vercel)。如果您已安装 Terraform，请运行以下命令进行升级：

Bash

```bash
terraform init -upgrade
```