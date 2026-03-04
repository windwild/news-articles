---
render_with_liquid: false
title: "How we built AEO tracking for coding agents - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-we-built-aeo-tracking-for-coding-agents"
date: "2026-02-09"
scraped_at: "2026-03-02T09:21:34.927236349+00:00"
language: "en-zh"
translated: true
description: "Learn how we built an AI Engine Optimization system to track coding agents using Vercel Sandbox, AI Gateway, and Workflows for isolated execution."
---
render_with_liquid: false
render_with_liquid: false

Feb 9, 2026

2026 年 2 月 9 日

AI has changed the way that people find information. For businesses, this means it's critical to understand how LLMs search for and summarize their web content.

AI 已彻底改变了人们获取信息的方式。对企业而言，这意味着必须深入理解大语言模型（LLM）如何搜索并摘要其网页内容。

We're building an AI Engine Optimization (AEO) system to track how models discover, interpret, and reference Vercel and our sites.

我们正在构建一套 AI 引擎优化（AEO）系统，用于追踪各类模型如何发现、解析并引用 Vercel 及我们旗下网站的内容。

![For end users on our marketing team, responses are consistently formatted across coding agents. ](images/how-we-built-aeo-tracking-for-coding-agents-vercel/img_001.jpg)![For end users on our marketing team, responses are consistently formatted across coding agents. ](images/how-we-built-aeo-tracking-for-coding-agents-vercel/img_001.jpg)

![面向营销团队的终端用户，各编码智能体（coding agents）返回的响应格式始终保持一致。](images/how-we-built-aeo-tracking-for-coding-agents-vercel/img_001.jpg)![面向营销团队的终端用户，各编码智能体（coding agents）返回的响应格式始终保持一致。](images/how-we-built-aeo-tracking-for-coding-agents-vercel/img_001.jpg)

For end users on our marketing team, responses are consistently formatted across coding agents.

面向营销团队的终端用户，各编码智能体（coding agents）返回的响应格式始终保持一致。

This started as a prototype focused only on standard chat models, but we quickly realized that wasn’t enough. To get a complete picture of visibility, we needed to track coding agents.

这一项目最初仅是一个聚焦于标准对话模型的原型；但我们很快意识到，这远远不够。要全面评估内容可见性（visibility），我们必须将编码智能体纳入追踪范围。

For standard models, tracking is relatively straightforward. We use [AI Gateway](https://vercel.com/ai-gateway) to send prompts to dozens of popular models (e.g. GPT, Gemini, and Claude) and analyze their responses, search behavior, and cited sources.

对于标准模型，追踪工作相对直接：我们通过 [AI Gateway](https://vercel.com/ai-gateway) 向数十种主流模型（例如 GPT、Gemini 和 Claude）发送提示词（prompts），并分析其响应内容、搜索行为及所引用的信息来源。

Coding agents, however, behave very differently. Many Vercel users interact with AI through their terminal or IDE while actively working on projects. In early sampling, we found that coding agents perform web searches in roughly 20% of prompts. Because these searches happen inline with real development workflows, it’s especially important to evaluate both response quality and source accuracy.

编码智能体的行为则截然不同。许多 Vercel 用户在实际开发项目过程中，会通过终端（terminal）或集成开发环境（IDE）与 AI 交互。在早期抽样测试中，我们发现约 20% 的提示词会触发编码智能体执行网络搜索。由于这些搜索嵌入在真实的开发流程之中，因此对响应质量与信息来源准确性的双重评估尤为关键。

Measuring AEO for coding agents requires a different approach than model-only testing. Coding agents aren’t designed to answer a single API call. They’re built to operate inside a project and expect a full development environment, including a filesystem, shell access, and package managers.

针对编码智能体开展 AEO 衡量，需采用不同于纯模型测试的新方法。编码智能体并非为响应单次 API 调用而设计；它们被构建为在项目内部运行，并依赖完整的开发环境——包括文件系统、命令行（shell）访问权限以及包管理器等。  

That creates a new set of challenges:

这带来了一系列全新的挑战：

1. **Execution isolation**: How do you safely run an autonomous agent that can execute arbitrary code?  

1. **执行隔离**：如何安全地运行一个能够执行任意代码的自主智能体（autonomous agent）？

2. **Observability**: How do you capture what the agent did when each agent has its own transcript format, tool-calling conventions, and output structure?  

2. **可观测性**：当每个智能体都拥有自己独有的对话记录格式、工具调用规范和输出结构时，你该如何完整捕获该智能体的实际行为？

## The coding agent AEO lifecycle  

## 编程智能体的 AEO 生命周期

Coding agents are typically accessed at some level through CLIs rather than APIs. Even if you’re only sending prompts and capturing responses, the CLI still needs to be installed and executed in a full runtime environment.  

编程智能体通常在某种程度上通过命令行界面（CLI）而非 API 进行访问。即使你仅需发送提示词并捕获响应，该 CLI 仍需被安装，并在一个完整的运行时环境中执行。

[Vercel Sandbox](https://vercel.com/sandbox) solves this by providing ephemeral Linux MicroVMs that spin up in seconds. Each agent run gets its own sandbox and follows the same six-step lifecycle, regardless of the CLI it uses.  

[Vercel Sandbox](https://vercel.com/sandbox) 通过提供可在数秒内启动的临时 Linux 微虚拟机（MicroVM）来解决这一问题。每次智能体运行都独占一个沙箱环境，并严格遵循统一的六步生命周期——无论其底层使用的是哪一种 CLI。

1. **Create the sandbox.** Spin up a fresh MicroVM with the right runtime (Node 24, Python 3.13, etc.) and a timeout. The timeout is a hard ceiling, so if the agent hangs or loops, the sandbox kills it.  

1. **创建沙箱**：启动一台全新的微虚拟机，预装合适的运行时环境（如 Node.js 24、Python 3.13 等），并设置超时限制。该超时为硬性上限——若智能体发生卡死或无限循环，沙箱将强制终止其进程。

2. **Install the agent CLI.** Each agent ships as an npm package (i.e., `@anthropic-ai/claude-code`, `@openai/codex`, etc.). The sandbox installs it globally so it's available as a shell command.  

2. **安装智能体 CLI**：每个智能体均以 npm 包形式分发（例如 `@anthropic-ai/claude-code`、`@openai/codex` 等）。沙箱将其全局安装，使其可作为 Shell 命令直接调用。

3. **Inject credentials.** Instead of giving each agent a direct provider API key, we set environment variables that route all LLM calls through Vercel AI Gateway. This gives us unified logging, rate limiting, and cost tracking across every agent, even though each agent uses a different underlying provider (though the system allows direct provider keys as well).  

3. **注入凭据**：我们不向各智能体直接提供供应商 API 密钥，而是通过设置环境变量，将所有大语言模型（LLM）调用统一经由 Vercel AI Gateway 路由。这使我们得以实现跨所有智能体的统一日志记录、速率限制与成本追踪——即便各智能体实际依赖不同的底层供应商（尽管系统也支持直接配置供应商密钥）。

4. **Run the agent with the prompt.** This is the only step that differs per agent. Each CLI has its own invocation pattern, flags, and config format. But from the sandbox's perspective, it's just a shell command.  

4. **使用提示词运行智能体**：这是唯一因智能体而异的步骤。每个 CLI 拥有各自独特的调用方式、命令行参数与配置格式；但从沙箱视角来看，它仅是一条标准 Shell 命令。

5. **Capture the transcript.** After the agent finishes, we extract a record of what it did, including which tools it called, whether it searched the web, and what it recommended in the response. This is agent-specific (covered below).  

5. **捕获对话记录（transcript）**：智能体运行结束后，我们提取其行为全量记录，包括所调用的工具、是否执行了网页搜索，以及最终响应中提出的建议等内容。该步骤因智能体而异（详见下文）。

6. **Tear down.** Stop the sandbox. If anything went wrong, the `catch` block ensures the sandbox is stopped anyway so we don't leak resources.

6. **清理环境。** 停止沙箱。如果发生任何错误，`catch` 块将确保沙箱仍被停止，从而避免资源泄漏。

In the code, the lifecycle looks like this.

在代码中，其生命周期如下所示。

```typescript
import { Sandbox } from "@vercel/sandbox";



3// Step 1: Create the sandbox

3// 步骤 1：创建沙箱

sandbox = await Sandbox.create({

5  resources: { vcpus: 2 },

5  资源：{ vcpus: 2 },

6  timeout:  10 * 60 * 1000

6  超时时间：10 * 60 * 1000

7});
```

9// Step 2: Install the agent CLI  
9// 第二步：安装 agent CLI  

for (const setupCmd of agent.setupCommands) {  

for (const setupCmd of agent.setupCommands) {  

11  await sandbox.runCommand("sh", ["-c", setupCmd]);  

11  await sandbox.runCommand("sh", ["-c", setupCmd]);  

12}  

12}  

14// Step 3: Inject AI Gateway credentials (via env vars in step 4)  
14// 第三步：注入 AI Gateway 凭据（通过第四步中的环境变量实现）  

16// Step 4: Run the agent  
16// 第四步：运行 agent  

const fullCommand = `AI_GATEWAY_API_KEY='${aiGatewayKey}' ${agent.command}`;  

const fullCommand = `AI_GATEWAY_API_KEY='${aiGatewayKey}' ${agent.command}`;  

const result = await sandbox.runCommand("sh", ["-c", fullCommand]);  

const result = await sandbox.runCommand("sh", ["-c", fullCommand]);

21// Step 5: Capture transcript (agent-specific — see next section)

21// 第五步：捕获转录文本（代理特定——参见下一节）

23// Step 6: Tear down

23// 第六步：清理环境

await sandbox.stop();
```

### Agents as config

### 以配置形式定义的代理

Because the lifecycle is uniform, each agent can be defined as a simple config object. Adding a new agent to the system means adding a new entry, and the sandbox orchestration handles everything else.

由于生命周期统一，每个代理均可定义为一个简单的配置对象。向系统中新增一个代理，只需添加一条新配置项，其余工作均由沙箱编排机制自动完成。

```typescript
export const AGENTS: Agent[] = [\
\
2  {\
\
3    id: "anthropic/claude-code",\
\
4    name: "Claude Code",\
\
5    setupCommands: ["npm install -g @anthropic-ai/claude-code"],\
\
6    buildCommand: (prompt) => `echo '${prompt}' | claude --print`,\
\
7  },\
\
8  {\
\
9    id: "openai/codex",\
\
10    name: "OpenAI Codex",\
\
11    setupCommands: ["npm install -g @openai/codex"],\
\
12    buildCommand: (prompt) => `codex exec -y -S '${prompt}'`,\
\
13  },\
\
14];
```

`runtime` determines the base image for the MicroVM. Most agents run on Node, but the system supports Python runtimes too.

`runtime` 字段用于指定 MicroVM 的基础镜像。大多数代理运行在 Node 环境下，但该系统也支持 Python 运行时。

`setupCommands` is an array because some agents need more than a global install. For example, Codex also needs a TOML config file written to `~/.codex/config.toml`.

`setupCommands` 是一个数组，因为某些智能体（agent）不仅需要全局安装，还需额外的初始化步骤。例如，Codex 还需将一个 TOML 配置文件写入 `~/.codex/config.toml`。

`buildCommand` is a function that takes the prompt and returns the shell command to run. Each agent's CLI has its own flags and invocation style.

`buildCommand` 是一个函数，接收提示词（prompt）作为输入，并返回待执行的 Shell 命令。每个智能体的命令行接口（CLI）均有其专属的参数标志（flags）和调用方式。

## Using the AI Gateway for routing

## 使用 AI 网关实现请求路由

We wanted to use the AI Gateway to centralize management of cost and logs. This required overriding the provider’s base URLs via environment variables inside the sandbox. The agents themselves don’t know this is happening and operate as if they are talking directly to their provider.

我们希望借助 AI 网关统一管理成本与日志。这要求在沙箱环境中通过环境变量覆写各服务商（provider）的基准 URL。智能体自身对此毫不知情，其行为表现如同直接与对应服务商通信。

Here’s what this looks like for Claude Code:

以下是 Claude Code 的具体实现示例：

```typescript
const claudeResult = await sandbox.runCommand(

2  'claude',

3  ['-p', '-m', options.model, '-y', options.prompt]

4  {

5    env: {

6      ANTHROPIC_BASE_URL: AI_GATEWAY.baseUrl,

7      ANTHROPIC_AUTH_TOKEN: options.apiKey,

8      ANTHROPIC_API_KEY: '',  // intentionally blank as AI Gateway handles auth

9    },

10  }

11);
```

`ANTHROPIC_BASE_URL` 指向 AI Gateway，而非 `api.anthropic.com`。代理（agent）发出的 HTTP 请求将发送至 Gateway，再由 Gateway 将其代理转发至 Anthropic。

`ANTHROPIC_API_KEY` 被显式设为空字符串——这是有意为之：Gateway 通过其自身的令牌完成身份认证，因此代理无需（也未持有）直接对接供应商的 API 密钥。

同样的模式也适用于 Codex（通过覆写 `OPENAI_BASE_URL` 实现），以及任何支持通过环境变量指定基础 URL 的代理。当然，提供商的 API 凭据也可直接使用。

## 转录格式问题

## The transcript format problem

Once an agent finishes running in its sandbox, we have a raw transcript, which is a record of everything it did.

当一个智能体（agent）在其沙箱环境中运行完毕后，我们会得到一份原始转录文本（raw transcript），即对其所有操作的完整记录。

The problem is that each agent produces them in a different format. Claude Code writes JSONL files to disk. Codex streams JSON to stdout. OpenCode also uses stdout, but with a different schema. They use different names for the same tools, different nesting structures for messages, and different conventions.

问题在于，每个智能体生成的转录格式各不相同：Claude Code 将转录内容以 JSONL 文件形式写入磁盘；Codex 则通过标准输出（stdout）流式传输 JSON；OpenCode 同样使用 stdout，但采用的是另一套数据结构（schema）。它们对同一工具使用不同名称，消息的嵌套结构各异，且遵循不同的约定规范。

We needed all of this to feed into a single brand pipeline, so we built a four-stage normalization layer:

我们需要将所有这些异构转录统一输入至同一条品牌分析流水线（brand pipeline），因此构建了一个四阶段标准化层（normalization layer）：

1. **Transcript capture:** Each agent stores its transcript differently, so this step is agent-specific.

1. **转录捕获（Transcript capture）**：每个智能体存储转录的方式各不相同，因此该步骤需针对不同智能体定制实现。

2. **Parsing:** Each agent has its own parser that normalizes tool names and flattens agent-specific message structures into a single unified event type.

2. **解析（Parsing）**：每个智能体配备专属解析器，用于统一工具名称，并将智能体特有的消息嵌套结构扁平化，转化为单一、标准化的事件类型。

3. **Enrichment:** Shared post-processing that extracts structured metadata (URLs, commands) from tool arguments, normalizing differences in how each agent names its args.

3. **增强（Enrichment）**：通用的后处理流程，从工具参数中提取结构化元数据（如 URL、命令等），并统一各智能体对参数的命名差异。

4. **Summary and brand extraction:** Aggregate the unified events into stats, then feed into the same brand extraction pipeline used for standard model responses.

4. **汇总与品牌提取（Summary and brand extraction）**：将标准化后的事件聚合为统计指标，再输入至与标准大模型响应所用的同一套品牌提取流水线中。

### Stage 1: Transcript capture

### 第一阶段：转录捕获（Transcript capture）

This happens while the sandbox is still running (step 5 in the lifecycle from the previous section).

该步骤发生在沙箱仍在运行期间（即上一节所述生命周期中的第 5 步）。

**Claude Code** writes its transcript as a JSONL file on the sandbox filesystem. We have to find and read it out after the agent finishes:

**Claude Code** 将其转录内容以 JSONL 文件形式写入沙箱文件系统。智能体运行结束后，我们需要定位并读取该文件：

```typescript
async function captureTranscript(sandbox) {

async function captureTranscript(sandbox) {

2  const workdir = sandbox.getWorkingDirectory();

2  const workdir = sandbox.getWorkingDirectory();

3  const projectPath = workdir.replace(/\\//g, '-');

3  const projectPath = workdir.replace(/\\//g, '-');

4  const claudeProjectDir = `~/.claude/projects/${projectPath}`;

4  const claudeProjectDir = `~/.claude/projects/${projectPath}`;

6  // Find the most recent .jsonl file

6  // 查找最新的 .jsonl 文件

7  const findResult = await sandbox.runShell(

7  const findResult = await sandbox.runShell(

8    `ls -t ${claudeProjectDir}/*.jsonl 2>/dev/null | head -1`

8    `ls -t ${claudeProjectDir}/*.jsonl 2>/dev/null | head -1`

9  );

9  );
```

11  const transcriptPath = findResult.stdout.trim();

11  const transcriptPath = findResult.stdout.trim();

12  return await sandbox.readFile(transcriptPath);

12  return await sandbox.readFile(transcriptPath);

13}

13}

**Codex and OpenCode** both output their transcripts to stdout, so capture is simpler — filter the output for JSON lines:

**Codex 和 OpenCode** 均将转录内容输出到 stdout，因此捕获过程更简单——只需从输出中筛选出 JSON 格式的行：

```typescript
function extractTranscriptFromOutput(output: string) {

```typescript
function extractTranscriptFromOutput(output: string) {

2  const lines = output.split('\\n').filter(line => {

2  const lines = output.split('\\n').filter(line => {

3    const trimmed = line.trim();

3    const trimmed = line.trim();

4    return trimmed.startsWith('{') && trimmed.endsWith('}');

4    return trimmed.startsWith('{') && trimmed.endsWith('}');

5  });

5  });

6  return lines.join('\\n');

6  return lines.join('\\n');

7}
```

此阶段的输出对所有智能体（agent）都相同：一段原始的 JSONL 字符串。但每行 JSON 的结构仍因智能体而异，而下一阶段正是用来统一这些结构的。

### Stage 2: Parsing tool names and message shapes

### 第二阶段：解析工具名称与消息结构

我们为每个智能体构建了专用解析器，该解析器同时完成两项任务：标准化工具名称，并将智能体特有的消息结构扁平化为单一格式化的事件类型。

**Tool name normalization**

**工具名称标准化**

同一操作在不同智能体中具有不同的名称：

|     |     |     |     |
| --- | --- | --- | --- |
| 操作 | Claude Code | Codex | OpenCode |
| 读取文件 | `Read` | `read_file` | `read` |
| 写入文件 | `Write` | `write_file` | `write` |
| 编辑文件 | `StrReplace` | `patch_file` | `patch` |
| 执行命令 | `Bash` | `shell` | `bash` |
| 网络搜索 | `WebFetch` | _(各不相同)_ | _(各不相同)_ |

每个解析器均维护一张查找表，将智能体特定的工具名称映射至约 10 个规范名称：

```typescript
export type ToolName =

2  | 'file_read' | 'file_write' | 'file_edit'

3  | 'shell' | 'web_fetch' | 'web_search'

3  | 'shell'（Shell 命令） | 'web_fetch'（网页抓取） | 'web_search'（网络搜索）

4  | 'glob' | 'grep' | 'list_dir'

4  | 'glob'（通配符匹配） | 'grep'（文本搜索） | 'list_dir'（列出目录内容）

5  | 'agent_task' | 'unknown';

5  | 'agent_task'（智能体任务） | 'unknown'（未知）；

const claudeToolMap = {

8  Read: 'file_read', Write: 'file_write', Bash: 'shell',

8  Read（读取文件）: 'file_read', Write（写入文件）: 'file_write', Bash（Bash 命令）: 'shell',

9  WebFetch: 'web_fetch', Glob: 'glob', Grep: 'grep', /* ... */

9  WebFetch（网页抓取）: 'web_fetch', Glob（通配符匹配）: 'glob', Grep（文本搜索）: 'grep', /* …… */

10};

10};

const codexToolMap = {

const codexToolMap = {

13  read_file: 'file_read', write_file: 'file_write', shell: 'shell',

13  read_file: “file_read”，write_file: “file_write”，shell: “shell”，

14  patch_file: 'file_edit', /* ... */

14  patch_file: “file_edit”，/* …… */

15};



const opencodeToolMap = {

15}；

const opencodeToolMap = {

18  read: 'file_read', write: 'file_write', bash: 'shell',

18  read: “file_read”，write: “file_write”，bash: “shell”，

19  rg: 'grep', patch: 'file_edit', /* ... */

19  rg: “grep”，patch: “file_edit”，/* …… */

20};
```

20}；
```

**Message shape flattening**

**消息结构扁平化**

Beyond naming, the structure of events varies across agents:

除了命名之外，各类智能体（agents）所发出事件的结构也各不相同：

- **Claude Code** nests messages inside a `message` property and mixes `tool_use` blocks into content arrays.

- **Claude Code** 将消息嵌套在 `message` 属性内，并将 `tool_use` 块混合到内容数组中。

- **Codex** has Responses API lifecycle events (`thread.started`, `turn.completed`, `output_text.delta`) alongside tool events.

- **Codex** 提供响应式 API 的生命周期事件（如 `thread.started`、`turn.completed`、`output_text.delta`），并与工具事件并存。

- **OpenCode** bundles tool call + result in the same event via `part.tool` and `part.state`.

- **OpenCode** 通过 `part.tool` 和 `part.state` 在同一事件中打包工具调用及其结果。

The parser for each agent handles these structural differences and collapses everything into a single `TranscriptEvent` type:

每个代理的解析器均能处理上述结构差异，并将所有事件统一归约为单一的 `TranscriptEvent` 类型：

```typescript
export interface TranscriptEvent {

2  timestamp?: string;

3  type: 'message' | 'tool_call' | 'tool_result' | 'thinking' | 'error';

4  role?: 'user' | 'assistant' | 'system';

5  content?: string;

6  tool?: {
```

7    name: ToolName;           // Canonical name

7    名称：ToolName；           // 规范名称

8    originalName: string;     // Agent-specific name (for debugging)

8    原始名称：string；     // 代理专用名称（用于调试）

9    args?: Record<string, unknown>;

9    参数？：Record<string, unknown>；

10    result?: unknown;

10    结果？：unknown；

11  };

11  }；

12}
```

12}
```

The output of this stage is a flat array of `TranscriptEvent[]` , which is the same shape regardless of which agent produced it.

该阶段的输出是一个扁平化的 `TranscriptEvent[]` 数组，其结构与生成该事件的代理无关。

### Stage 3: Enrichment

### 第三阶段：增强处理

After parsing, a shared post-processing step runs across all events. This extracts structured metadata from tool arguments so that downstream code doesn't need to know that Claude Code puts file paths in `args.path` while Codex uses `args.file`:

解析完成后，会对所有事件执行一个统一的后处理步骤。该步骤从工具参数中提取结构化元数据，从而使下游代码无需关心：Claude Code 将文件路径存于 `args.path` 中，而 Codex 则使用 `args.file`：

```typescript
if (['file_read', 'file_write', 'file_edit'].includes(event.tool.name)) {
```

```typescript
if (['file_read', 'file_write', 'file_edit'].includes(event.tool.name)) {
```

2  const path = extractFilePath(args);

2  const path = extractFilePath(args);

3  if (path) event.tool.args = { ...args, _extractedPath: path };

3  若 path 存在，则 event.tool.args 被设为 { ...args, _extractedPath: path };

4}

4}

if (event.tool.name === 'web_fetch') {

if (event.tool.name === 'web_fetch') {

7  const url = extractUrl(args);

7  const url = extractUrl(args);

8  if (url) event.tool.args = { ...args, _extractedUrl: url };

8  若 url 存在，则 event.tool.args 被设为 { ...args, _extractedUrl: url };

9}

9}

### Stage 4: Summary and brand extraction

### 第四阶段：摘要生成与品牌提取

The enriched `TranscriptEvent[]` array gets summarized into aggregate stats (total tool calls by type, web fetches, errors) and then fed into the same brand extraction pipeline used for standard model responses. From this point forward, the system doesn't know or care whether the data came from a coding agent or a model API call.

经增强处理的 `TranscriptEvent[]` 数组被汇总为聚合统计信息（按类型统计的工具调用总数、网页抓取次数、错误数），随后输入至与标准模型响应所用的同一套品牌提取流水线中。自此之后，系统既无需知晓、也不关心这些数据究竟源自编码智能体（coding agent）还是模型 API 调用。

## Orchestration with Vercel Workflow

## 使用 Vercel Workflow 进行编排

This entire pipeline runs as a [Vercel Workflow](https://vercel.com/workflow). When a prompt is tagged as "agents" type, the workflow fans out across all configured agents in parallel and each gets its own sandbox:

整个流水线作为 [Vercel Workflow](https://vercel.com/workflow) 运行。当某个提示（prompt）被标记为 “agents” 类型时，该工作流将并行分发至所有已配置的智能体（agents），每个智能体均运行于独立的沙箱环境中：

```typescript
export async function probeTopicWorkflow(topicId: string) {

2  "use workflow";



4  const agentPromises = AGENTS.map((agent, index) => {

5    const command = agent.buildCommand(topicData.text);

6    return queryAgentAndSave(topicData.text, run.id, {

7      id: agent.id,

8      name: agent.name,
```

9      setupCommands: agent.setupCommands,

9      setupCommands: agent.setupCommands,

10      command,

10      command,

11    }, index + 1, totalQueries);

11    }, index + 1, totalQueries);

12  });



12  });



14  const results = await Promise.all(agentPromises);

14  const results = await Promise.all(agentPromises);

15}
```

15}
```

## What we’ve learned

## 我们学到的经验

- **Coding agents contribute a meaningful amount of traffic from web search**. Early tests on a random sample of prompts showed that coding agents execute search around 20% of the time. As we collect more data we will build a more comprehensive view of agent search behavior, but these results made it clear that optimizing content for coding agents was important.

- 编程智能体（coding agents）为网络搜索贡献了可观的流量。在对一批随机提示词（prompts）开展的早期测试中发现，编程智能体约有 20% 的概率会触发搜索行为。随着我们持续收集更多数据，将逐步构建起对智能体搜索行为更全面的认知；但当前结果已清晰表明：针对编程智能体优化内容至关重要。

- **Agent recommendations have a different shape than model responses.** When a coding agent suggests a tool, it tends to produce working code with that tool, like an `import` statement, a config file, or a deployment script. The recommendation is embedded in the output, not just mentioned in prose.

- 智能体的推荐形式与大语言模型的常规文本回复存在显著差异。当编程智能体推荐某个工具时，它通常会直接生成可运行的代码来使用该工具，例如一条 `import` 语句、一个配置文件，或一段部署脚本。这种推荐是“嵌入式”的——即直接体现在输出代码中，而不仅以自然语言文字形式提及。

- **Transcript formats are a mess.** And they are getting messier as agent CLI tools ship rapid updates. Building a normalization layer early saved us from constant breakage.

- **转录格式一团糟。** 随着各类智能体 CLI 工具快速迭代更新，这一问题正日益加剧。及早构建标准化层，使我们避免了持续不断的系统崩溃。

- **The same brand extraction pipeline works for both models and agents.** The hard part is everything upstream: getting the agent to run, capturing what it did, and normalizing it into a structure you can grade.

- **同一套品牌提取流水线可同时适用于大语言模型与智能体。** 真正的难点在于上游所有环节：确保智能体成功运行、完整捕获其执行行为，并将其归一化为可供评估的结构化格式。

## What’s next

## 下一步计划

- **Open sourcing the tool.** We're planning to release an OSS version of our system so other teams can track their own AEO evals, both for standard models and coding agents.

- **开源该工具。** 我们计划将本系统以开源（OSS）形式发布，以便其他团队也能追踪自身在 AEO 评估中的表现——无论评估对象是通用大语言模型，还是编程智能体。

- **Deep dive on methodology.** We are working on a follow-up post covering the full AEO eval methodology: prompt design, dual-mode testing (web search vs. training data), query-as-first-class-entity architecture, and Share of Voice metrics.

- **方法论深度解析。** 我们正在撰写一篇后续文章，全面介绍 AEO 评估的方法论：提示词设计、双模态测试（网络搜索模式 vs. 训练数据模式）、“查询即头等实体”（query-as-first-class-entity）架构，以及“声量份额”（Share of Voice）指标。

- **Scaling agent coverage.** Adding more agents as the ecosystem grows and expanding the types of prompts we test (not just "recommend a tool" but full project scaffolding, debugging, etc.).

- **扩大智能体覆盖范围。** 随着生态系统的持续演进，我们将接入更多智能体；同时拓展所测试提示词的类型——不仅限于“推荐一个工具”，还将涵盖完整的项目脚手架搭建、代码调试等复杂场景。