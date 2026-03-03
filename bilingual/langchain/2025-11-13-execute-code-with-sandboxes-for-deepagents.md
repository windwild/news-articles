---
title: "Execute Code with Sandboxes for DeepAgents"
source: "LangChain Blog"
url: "https://blog.langchain.com/execute-code-with-sandboxes-for-deepagents/"
date: "2025-11-13"
scraped_at: "2026-03-03T07:19:01.869602285+00:00"
language: "en-zh"
translated: true
---

By Vivek Trivedy

作者：Vivek Trivedy

Today we're excited to launch Sandboxes for DeepAgents, a new set of integrations that allow you to safely execute arbitrary DeepAgent code in remote sandboxes. We currently support sandboxes from 3 of our partners: [Runloop](https://www.runloop.ai/?ref=blog.langchain.com), [Daytona](https://www.daytona.io/?ref=blog.langchain.com), and [Modal](https://modal.com/?ref=blog.langchain.com). Below, we dive into what you can do with sandboxes and how to use them with with the DeepAgents-CLI.

今天我们很高兴地推出面向 DeepAgents 的沙箱（Sandboxes）功能——这是一组全新集成，支持您在远程沙箱中安全执行任意 DeepAgent 代码。目前我们已支持来自三家合作伙伴的沙箱：[Runloop](https://www.runloop.ai/?ref=blog.langchain.com)、[Daytona](https://www.daytona.io/?ref=blog.langchain.com) 和 [Modal](https://modal.com/?ref=blog.langchain.com)。下文将深入介绍沙箱能为您做什么，以及如何通过 DeepAgents-CLI 使用它们。

## Why Do We Need Sandboxes?

## 为何需要沙箱？

Sandboxes give us a simple, configurable environment to execute code and do work outside of our local machine. Here are some scenarios where this may be useful:

沙箱为我们提供了一个简单且可配置的环境，用于在本地机器之外执行代码和完成任务。以下是一些典型应用场景：

1. **Safety**: Your agent is executing arbitrary code which could be harmful to your local machine (ex: `rm -rf`). Running in a sandbox means your machine is safe from potentially malicious code.  
   **安全性**：您的智能体正在执行任意代码，而这些代码可能对本地机器造成危害（例如：`rm -rf`）。在沙箱中运行可确保您的本地机器免受潜在恶意代码的影响。

2. **Clean Environments**: You need specific dependencies, languages, or OS configurations without polluting your local setup. Spin up a sandbox with exactly what you need, use it, then terminate it.  
   **纯净环境**：您需要特定的依赖项、编程语言或操作系统配置，但又不想污染本地开发环境。只需按需启动一个具备全部所需组件的沙箱，使用完毕后即可终止。

3. **Parallel Execution**: Run multiple agents simultaneously, each in their own isolated environment, without resource conflicts or interference.  
   **并行执行**：同时运行多个智能体，每个智能体均在独立隔离的环境中运行，避免资源冲突与相互干扰。

4. **Long-Running Tasks**: Let agents work on time-intensive operations without blocking your local machine.  
   **长时间运行任务**：让智能体处理耗时较长的操作，而不会阻塞您的本地机器。

5. **Reproducibility**: Guarantee consistent execution environments across your team.  
   **可复现性**：确保团队内所有成员拥有完全一致的执行环境。

## How It Works

## 工作原理

The sandbox integration has three main steps:

沙箱集成包含三个主要步骤：

1. Setup the sandbox (with an optional setup script)  
   1. 配置沙箱（可选：通过初始化脚本进行预配置）

2. The agent wants to execute a command  
   2. 智能体发起命令执行请求

3. The remote sandbox runs the command and sends it back to the user  
   3. 远程沙箱执行该命令，并将结果返回给用户

![](images/execute-code-with-sandboxes-for-deepagents/img_001.png)_Easily attach, configure, and use sandboxes with DeepAgents to safely execute code_

![](images/execute-code-with-sandboxes-for-deepagents/img_001.png)_借助 DeepAgents，轻松接入、配置并使用沙箱，安全执行代码_

Your DeepAgent runs locally (or wherever you want), but when it needs to execute code, create files, or run commands, those operations happen in the remote sandbox. The agent maintains full visibility into the sandbox filesystem and command outputs, so it can iterate naturally. The setup script can be used to load in environment variables, clone git repos, prepare your environment, and more.

您的 DeepAgent 在本地（或您指定的任意位置）运行；但当它需要执行代码、创建文件或运行命令时，这些操作均在远程沙箱中完成。智能体可完整访问沙箱的文件系统及命令输出，从而实现自然的迭代开发。初始化脚本可用于加载环境变量、克隆 Git 仓库、准备运行环境等更多操作。

## How to Get Started

## 如何快速开始

To use Daytona and Runloop sandboxes, simply create an account and store the API key as an environment variable (`DAYTONA_API_KEY` and `RUNLOOP_API_KEY`). To use Modal sandboxes, follow the setup instructions found [here](https://modal.com/docs/guide?ref=blog.langchain.com#getting-started) and run `modal setup`.

要使用 Daytona 和 Runloop 沙箱，只需注册一个账户，并将 API 密钥分别保存为环境变量（`DAYTONA_API_KEY` 和 `RUNLOOP_API_KEY`）。若要使用 Modal 沙箱，请参考[此处](https://modal.com/docs/guide?ref=blog.langchain.com#getting-started)的设置说明，并运行 `modal setup` 命令。

After completing the setup, the DeepAgents CLI provides simple commands to get started with sandboxes in minutes with convenient `sandbox` and `sandbox-setup` commands.

完成配置后，DeepAgents CLI 提供了简洁易用的命令，仅需几分钟即可通过便捷的 `sandbox` 和 `sandbox-setup` 命令启动沙箱。

**Note:** we have context managers to automatically clean up sandboxes but we recommend checking your provider dashboard to be sure there’s no agent or sandbox that’s accidentally left running.

**注意：** 我们提供了上下文管理器以自动清理沙箱；但为确保万无一失，我们仍建议您登录服务商控制台，检查是否意外遗留了正在运行的智能体或沙箱。

For example, the following command can be used to attach a runloop sandbox to your DeepAgent with a custom setup script located in your current directory: `uvx deepagents-cli --sandbox runloop --sandbox-setup ./setup.sh`

例如，以下命令可将当前目录下的自定义 setup 脚本（`./setup.sh`）与 Runloop 沙箱绑定，并将其接入您的 DeepAgent：`uvx deepagents-cli --sandbox runloop --sandbox-setup ./setup.sh`

### Note: Using Sandboxes Securely

### 注意：安全地使用沙箱

> While the sandbox is isolated, when working with untrusted inputs, agents are still prone to prompt injection. To mitigate the risks of having secrets present in the sandbox, we recommend running trusted setup scripts, using human-in-the-loop, and assigning short lived secrets. Sandbox APIs are evolving rapidly, and we expect more providers to support proxies that help mitigate prompt injection and secrets management concerns.

> 尽管沙箱本身具备隔离性，但在处理不可信输入时，智能体仍可能遭受提示注入（prompt injection）攻击。为降低沙箱中敏感信息泄露的风险，我们建议：仅运行可信的初始化脚本、引入人工审核环节（human-in-the-loop），以及为密钥等敏感凭证设置较短的有效期。沙箱相关 API 正在快速演进，我们预计未来将有更多服务商支持代理机制（proxy），从而更有效地缓解提示注入与密钥管理方面的安全隐患。

Here's an example of a simple setup script that adds local environment variables like a GitHub token or OpenAI key into the sandbox, and pulls down a repository. The pre-requisites to run this script is that your local `.env` file contains the keys and tokens you need:

以下是一个简单的初始化脚本示例：它将本地环境变量（如 GitHub Token 或 OpenAI Key）注入沙箱，并拉取指定代码仓库。运行该脚本的前提是，您的本地 `.env` 文件中已包含所需的所有密钥和令牌：

```bash
#!/bin/bash
set -e  # Exit on any error

echo "Configuring sandbox environment..."
```

# 1. Clone your repository using GitHub token

# 1. 使用 GitHub Token 克隆您的代码仓库

echo "Cloning repository..."
git clone <https://x-access-token:${GITHUB_TOKEN}@github.com/username/repo.git> $$HOME/workspace
cd $$HOME/workspace
echo "✓ Repository cloned"

echo "正在克隆代码仓库..."
git clone <https://x-access-token:${GITHUB_TOKEN}@github.com/username/repo.git> $$HOME/workspace
cd $$HOME/workspace
echo "✓ 代码仓库克隆完成"

# 2. Make environment variables persistent for all future commands

# 2. 使环境变量对所有后续命令持久生效

echo "Setting up environment variables..."
cat >> ~/.bashrc <<'EOF'

# Add selected env variables to sandbox from local
export GITHUB_TOKEN="${GITHUB_TOKEN}"
export FAL_API_KEY="${FAL_API_KEY}"

# Auto-navigate to workspace
cd $$HOME/workspace
EOF

echo "正在配置环境变量..."
cat >> ~/.bashrc <<'EOF'

# 从本地向沙箱中添加选定的环境变量
export GITHUB_TOKEN="${GITHUB_TOKEN}"
export FAL_API_KEY="${FAL_API_KEY}"

# 自动进入工作区目录
cd $$HOME/workspace
EOF

# 3. Activate the environment

# 3. 激活环境

source ~/.bashrc
echo "✓ Environment configured"

source ~/.bashrc
echo "✓ 环境配置完成"

```

## What's Next?

## 接下来是什么？

We're excited to see how builders will use sandboxes with their DeepAgents. We'll be adding more configuration options for sandboxes and sharing more examples on integrating sandboxes to do real work.

我们非常期待看到开发者如何将沙箱与他们的 DeepAgents 结合使用。我们将为沙箱增加更多配置选项，并分享更多关于如何集成沙箱以执行实际任务的示例。

If you want to watch a tutorial on how to get started with sandboxes, get check our tutorial [here](https://youtu.be/CejntUP3muU?ref=blog.langchain.com).

如果您希望观看沙箱入门教程，请点击此处查看我们的教学视频：[链接](https://youtu.be/CejntUP3muU?ref=blog.langchain.com)。

Ready to start building? Get started with our [DeepAgents](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com) documentation and [GitHub](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com) repository today.

准备开始构建了吗？立即查阅我们的 [DeepAgents 文档](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com) 和 [GitHub 代码仓库](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com) 吧！