---
title: "Vercel Terraform Provider now supports Vercel Firewall resources - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-terraform-provider-now-supports-vercel-firewall"
date: "2024-10-04"
scraped_at: "2026-03-02T09:40:41.270364316+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Oct 4, 2024

The [Vercel Terraform Provider](https://registry.terraform.io/providers/vercel/vercel/latest/docs) now allows you to customize and control the [Vercel Firewall](https://vercel.com/docs/security/vercel-firewall) through Infrastructure as Code (IaC).

Key resources and their capabilities include:

- Resource: `vercel_attack_challenge_mode`

  - Toggle [Attack Challenge Mode](https://registry.terraform.io/providers/vercel/vercel/latest/docs/resources/attack_challenge_mode) .
- Resource: `vercel_firewall_config`

  - Attribute block: `rules`—Define and adjust [custom rules](https://registry.terraform.io/providers/vercel/vercel/latest/docs/resources/firewall_config).

  - Attribute block: `ip_rules`—Manage a list of [blocked IP addresses](https://registry.terraform.io/providers/vercel/vercel/latest/docs/resources/firewall_config).

For example, to create a new rule that challenges requests where the `user_agent` contains `curl`:

```text
resource "vercel_firewall_config" "example" {

2  project_id = vercel_project.example.id

3  rules {

4    rule {

5      name = "Challenge curl"

6      description = "Challenge user agents containing 'curl'"

7      condition_group = [{\
\
8        conditions = [{\
\
9          type = "user_agent"\
\
10          op = "sub"\
\
11          value = "curl"\
\
12        }]\
\
13      }]

14      action = {

15        action = "challenge"

16      }

17    }

18  }

19}
```

Get started with the [Terraform provider for Vercel](https://vercel.com/guides/integrating-terraform-with-vercel) today. If you already have Terraform installed, upgrade by running:

Bash

```bash
terraform init -upgrade
```