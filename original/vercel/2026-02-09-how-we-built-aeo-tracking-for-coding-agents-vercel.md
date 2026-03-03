---
title: "How we built AEO tracking for coding agents - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-we-built-aeo-tracking-for-coding-agents"
date: "2026-02-09"
scraped_at: "2026-03-02T09:21:34.927236349+00:00"
language: "en"
translated: false
description: "Learn how we built an AI Engine Optimization system to track coding agents using Vercel Sandbox, AI Gateway, and Workflows for isolated execution."
---




Feb 9, 2026

AI has changed the way that people find information. For businesses, this means it's critical to understand how LLMs search for and summarize their web content.

We're building an AI Engine Optimization (AEO) system to track how models discover, interpret, and reference Vercel and our sites.

![For end users on our marketing team, responses are consistently formatted across coding agents. ](images/how-we-built-aeo-tracking-for-coding-agents-vercel/img_001.jpg)![For end users on our marketing team, responses are consistently formatted across coding agents. ](images/how-we-built-aeo-tracking-for-coding-agents-vercel/img_001.jpg)

For end users on our marketing team, responses are consistently formatted across coding agents.

This started as a prototype focused only on standard chat models, but we quickly realized that wasn’t enough. To get a complete picture of visibility, we needed to track coding agents.

For standard models, tracking is relatively straightforward. We use [AI Gateway](https://vercel.com/ai-gateway) to send prompts to dozens of popular models (e.g. GPT, Gemini, and Claude) and analyze their responses, search behavior, and cited sources.

Coding agents, however, behave very differently. Many Vercel users interact with AI through their terminal or IDE while actively working on projects. In early sampling, we found that coding agents perform web searches in roughly 20% of prompts. Because these searches happen inline with real development workflows, it’s especially important to evaluate both response quality and source accuracy.

Measuring AEO for coding agents requires a different approach than model-only testing. Coding agents aren’t designed to answer a single API call. They’re built to operate inside a project and expect a full development environment, including a filesystem, shell access, and package managers.

That creates a new set of challenges:

1. **Execution isolation**: How do you safely run an autonomous agent that can execute arbitrary code?

2. **Observability**: How do you capture what the agent did when each agent has its own transcript format, tool-calling conventions, and output structure?


## The coding agent AEO lifecycle

Coding agents are typically accessed at some level through CLIs rather than APIs. Even if you’re only sending prompts and capturing responses, the CLI still needs to be installed and executed in a full runtime environment.

[Vercel Sandbox](https://vercel.com/sandbox) solves this by providing ephemeral Linux MicroVMs that spin up in seconds. Each agent run gets its own sandbox and follows the same six-step lifecycle, regardless of the CLI it uses.

1. **Create the sandbox.** Spin up a fresh MicroVM with the right runtime (Node 24, Python 3.13, etc.) and a timeout. The timeout is a hard ceiling, so if the agent hangs or loops, the sandbox kills it.

2. **Install the agent CLI.** Each agent ships as an npm package (i.e., `@anthropic-ai/claude-code`, `@openai/codex`, etc.). The sandbox installs it globally so it's available as a shell command.

3. **Inject credentials.** Instead of giving each agent a direct provider API key, we set environment variables that route all LLM calls through Vercel AI Gateway. This gives us unified logging, rate limiting, and cost tracking across every agent, even though each agent uses a different underlying provider (though the system allows direct provider keys as well).

4. **Run the agent with the prompt.** This is the only step that differs per agent. Each CLI has its own invocation pattern, flags, and config format. But from the sandbox's perspective, it's just a shell command.

5. **Capture the transcript.** After the agent finishes, we extract a record of what it did, including which tools it called, whether it searched the web, and what it recommended in the response. This is agent-specific (covered below).

6. **Tear down.** Stop the sandbox. If anything went wrong, the `catch` block ensures the sandbox is stopped anyway so we don't leak resources.


In the code, the lifecycle looks like this.

```typescript
import { Sandbox } from "@vercel/sandbox";



3// Step 1: Create the sandbox

sandbox = await Sandbox.create({

5  resources: { vcpus: 2 },

6  timeout:  10 * 60 * 1000

7});



9// Step 2: Install the agent CLI

for (const setupCmd of agent.setupCommands) {

11  await sandbox.runCommand("sh", ["-c", setupCmd]);

12}



14// Step 3: Inject AI Gateway credentials (via env vars in step 4)



16// Step 4: Run the agent

const fullCommand = `AI_GATEWAY_API_KEY='${aiGatewayKey}' ${agent.command}`;

const result = await sandbox.runCommand("sh", ["-c", fullCommand]);





21// Step 5: Capture transcript (agent-specific — see next section)



23// Step 6: Tear down

await sandbox.stop();
```

### Agents as config

Because the lifecycle is uniform, each agent can be defined as a simple config object. Adding a new agent to the system means adding a new entry, and the sandbox orchestration handles everything else.

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

`setupCommands` is an array because some agents need more than a global install. For example, Codex also needs a TOML config file written to `~/.codex/config.toml`.

`buildCommand` is a function that takes the prompt and returns the shell command to run. Each agent's CLI has its own flags and invocation style.

## Using the AI Gateway for routing

We wanted to use the AI Gateway to centralize management of cost and logs. This required overriding the provider’s base URLs via environment variables inside the sandbox. The agents themselves don’t know this is happening and operate as if they are talking directly to their provider.

Here’s what this looks like for Claude Code:

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

`ANTHROPIC_BASE_URL` points to AI Gateway instead of `api.anthropic.com`. The agent's HTTP calls go to Gateway, which proxies them to Anthropic.

`ANTHROPIC_API_KEY` is set to empty string on purpose — Gateway authenticates via its own token, so the agent doesn't need (or have) a direct provider key.

This same pattern works for Codex (override `OPENAI_BASE_URL`) and any other agent that respects a base URL environment variable. Provider API credentials can also be used directly.

## The transcript format problem

Once an agent finishes running in its sandbox, we have a raw transcript, which is a record of everything it did.

The problem is that each agent produces them in a different format. Claude Code writes JSONL files to disk. Codex streams JSON to stdout. OpenCode also uses stdout, but with a different schema. They use different names for the same tools, different nesting structures for messages, and different conventions.

We needed all of this to feed into a single brand pipeline, so we built a four-stage normalization layer:

1. **Transcript capture:** Each agent stores its transcript differently, so this step is agent-specific.

2. **Parsing:** Each agent has its own parser that normalizes tool names and flattens agent-specific message structures into a single unified event type.

3. **Enrichment:** Shared post-processing that extracts structured metadata (URLs, commands) from tool arguments, normalizing differences in how each agent names its args.

4. **Summary and brand extraction:** Aggregate the unified events into stats, then feed into the same brand extraction pipeline used for standard model responses.


### Stage 1: Transcript capture

This happens while the sandbox is still running (step 5 in the lifecycle from the previous section).

**Claude Code** writes its transcript as a JSONL file on the sandbox filesystem. We have to find and read it out after the agent finishes:

```typescript
async function captureTranscript(sandbox) {

2  const workdir = sandbox.getWorkingDirectory();

3  const projectPath = workdir.replace(/\\//g, '-');

4  const claudeProjectDir = `~/.claude/projects/${projectPath}`;



6  // Find the most recent .jsonl file

7  const findResult = await sandbox.runShell(

8    `ls -t ${claudeProjectDir}/*.jsonl 2>/dev/null | head -1`

9  );



11  const transcriptPath = findResult.stdout.trim();

12  return await sandbox.readFile(transcriptPath);

13}
```

**Codex and OpenCode** both output their transcripts to stdout, so capture is simpler — filter the output for JSON lines:

```typescript
function extractTranscriptFromOutput(output: string) {

2  const lines = output.split('\\n').filter(line => {

3    const trimmed = line.trim();

4    return trimmed.startsWith('{') && trimmed.endsWith('}');

5  });

6  return lines.join('\\n');

7}
```

The output of this stage is the same for all agents: a string of raw JSONL. But the structure of each JSON line is still completely different per agent, and that's what the next stage handles.

### Stage 2: Parsing tool names and message shapes

We built a dedicated parser for each agent that does two things at once: normalizes tool names and flattens agent-specific message structures into a single formatted event type.

**Tool name normalization**

The same operation has different names across agents:

|     |     |     |     |
| --- | --- | --- | --- |
| Operation | Claude Code | Codex | OpenCode |
| Read a file | `Read` | `read_file` | `read` |
| Write a file | `Write` | `write_file` | `write` |
| Edit a file | `StrReplace` | `patch_file` | `patch` |
| Run a command | `Bash` | `shell` | `bash` |
| Search the web | `WebFetch` | _(varies)_ | _(varies)_ |

Each parser maintains a lookup table that maps agent-specific names to ~10 canonical names:

```typescript
export type ToolName =

2  | 'file_read' | 'file_write' | 'file_edit'

3  | 'shell' | 'web_fetch' | 'web_search'

4  | 'glob' | 'grep' | 'list_dir'

5  | 'agent_task' | 'unknown';



const claudeToolMap = {

8  Read: 'file_read', Write: 'file_write', Bash: 'shell',

9  WebFetch: 'web_fetch', Glob: 'glob', Grep: 'grep', /* ... */

10};



const codexToolMap = {

13  read_file: 'file_read', write_file: 'file_write', shell: 'shell',

14  patch_file: 'file_edit', /* ... */

15};



const opencodeToolMap = {

18  read: 'file_read', write: 'file_write', bash: 'shell',

19  rg: 'grep', patch: 'file_edit', /* ... */

20};
```

**Message shape flattening**

Beyond naming, the structure of events varies across agents:

- **Claude Code** nests messages inside a `message` property and mixes `tool_use` blocks into content arrays.

- **Codex** has Responses API lifecycle events (`thread.started`, `turn.completed`, `output_text.delta`) alongside tool events.

- **OpenCode** bundles tool call + result in the same event via `part.tool` and `part.state`.


The parser for each agent handles these structural differences and collapses everything into a single `TranscriptEvent` type:

```typescript
export interface TranscriptEvent {

2  timestamp?: string;

3  type: 'message' | 'tool_call' | 'tool_result' | 'thinking' | 'error';

4  role?: 'user' | 'assistant' | 'system';

5  content?: string;

6  tool?: {

7    name: ToolName;           // Canonical name

8    originalName: string;     // Agent-specific name (for debugging)

9    args?: Record<string, unknown>;

10    result?: unknown;

11  };

12}
```

The output of this stage is a flat array of `TranscriptEvent[]` , which is the same shape regardless of which agent produced it.

### Stage 3: Enrichment

After parsing, a shared post-processing step runs across all events. This extracts structured metadata from tool arguments so that downstream code doesn't need to know that Claude Code puts file paths in `args.path` while Codex uses `args.file`:

```typescript
if (['file_read', 'file_write', 'file_edit'].includes(event.tool.name)) {

2  const path = extractFilePath(args);

3  if (path) event.tool.args = { ...args, _extractedPath: path };

4}



if (event.tool.name === 'web_fetch') {

7  const url = extractUrl(args);

8  if (url) event.tool.args = { ...args, _extractedUrl: url };

9}
```

### Stage 4: Summary and brand extraction

The enriched `TranscriptEvent[]` array gets summarized into aggregate stats (total tool calls by type, web fetches, errors) and then fed into the same brand extraction pipeline used for standard model responses. From this point forward, the system doesn't know or care whether the data came from a coding agent or a model API call.

## Orchestration with Vercel Workflow

This entire pipeline runs as a [Vercel Workflow](https://vercel.com/workflow). When a prompt is tagged as "agents" type, the workflow fans out across all configured agents in parallel and each gets its own sandbox:

```typescript
export async function probeTopicWorkflow(topicId: string) {

2  "use workflow";



4  const agentPromises = AGENTS.map((agent, index) => {

5    const command = agent.buildCommand(topicData.text);

6    return queryAgentAndSave(topicData.text, run.id, {

7      id: agent.id,

8      name: agent.name,

9      setupCommands: agent.setupCommands,

10      command,

11    }, index + 1, totalQueries);

12  });



14  const results = await Promise.all(agentPromises);

15}
```

## What we’ve learned

- **Coding agents contribute a meaningful amount of traffic from web search**. Early tests on a random sample of prompts showed that coding agents execute search around 20% of the time. As we collect more data we will build a more comprehensive view of agent search behavior, but these results made it clear that optimizing content for coding agents was important.

- **Agent recommendations have a different shape than model responses.** When a coding agent suggests a tool, it tends to produce working code with that tool, like an `import` statement, a config file, or a deployment script. The recommendation is embedded in the output, not just mentioned in prose.

- **Transcript formats are a mess.** And they are getting messier as agent CLI tools ship rapid updates. Building a normalization layer early saved us from constant breakage.

- **The same brand extraction pipeline works for both models and agents.** The hard part is everything upstream: getting the agent to run, capturing what it did, and normalizing it into a structure you can grade.


## What’s next

- **Open sourcing the tool.** We're planning to release an OSS version of our system so other teams can track their own AEO evals, both for standard models and coding agents.

- **Deep dive on methodology.** We are working on a follow-up post covering the full AEO eval methodology: prompt design, dual-mode testing (web search vs. training data), query-as-first-class-entity architecture, and Share of Voice metrics.

- **Scaling agent coverage.** Adding more agents as the ecosystem grows and expanding the types of prompts we test (not just "recommend a tool" but full project scaffolding, debugging, etc.).