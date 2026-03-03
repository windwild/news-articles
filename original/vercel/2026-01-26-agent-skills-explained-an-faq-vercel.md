---
title: "Agent skills explained: An FAQ - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/agent-skills-explained-an-faq"
date: "2026-01-26"
scraped_at: "2026-03-02T10:47:55.654529231+00:00"
language: "en"
translated: false
description: "A plainspoken Skills FAQ with a ready-to-use guide: what skill packages are, how agents load them, what skills-ai.dev is, how Skills compare to MCP, plus security and alternatives."
---




Jan 26, 2026

Learn what agents skills are, how to install them, how agents use them, and best practices for implementation.

Agents lack the same context as you and your team. Even when an agent scans your codebase or connects with your document management system, it doesn't know your team's process, quality standards, or goals. To improve responses and clean up mistakes, people use repeated prompts to provide the right context.

Agent skills fix this. They are a simple, open format that packages instructions, scripts, and resources LLMs and agents can discover and use automatically, increasing output accuracy.

Think of skills as centralized, on-demand expertise. Write it once, and the agent will have access to critical information right when it needs it. Skills give you a path from "the agent kind of works" to "the agent actually knows how we do things here".

## What are skills?

Skills are packaged, reusable instructions for AI agents. Skills are built on an [open standard](https://agentskills.io/) adopted by many of the top providers and agent platforms.

You install skills packages once, and your agent can load them when they match the task. Skills work with any type of agent, whether it is writing code, analyzing data, managing workflows, or handling customer support.

While coding agents are driving much of the current adoption, skills apply to any agent use case. The same packaging format and ecosystem work across domains.

## How do skills compare to MCP servers, tools, rules, and system prompts?

Skills, MCP servers, tools, rules, and system prompts each solve different aspects of AI agent configuration and provide different types of agent capabilities.

Skills excel at packaging complete workflows with context and guardrails. MCP servers provide standardized tool access. Tools provide specific functionality. Rules and system prompts offer foundational behavior control.

The approaches work together. Skills can reference MCP servers, build on system prompts, and incorporate rule-based logic.

### Skills

Skills package complete workflows that combine instructions, context, and decision-making logic. They tell agents not just what tools are available, but when to use them, how to sequence actions, and what success looks like.

They work best for complex, multi-step processes with repetitive, domain-specific tasks. These scenarios require contextual decision-making about tool usage and output handling, and skills provide the task-specific expertise needed to make the best choice.

### MCP servers

Model Context Protocol (MCP) servers provide standardized interfaces for AI agents to access external tools and services. They handle the technical integration between AI systems and third-party APIs.

They work best for tool integration, API access, and providing agents with reliable interfaces to external services like databases, file systems, or web services.

### Tools

Tools provide individual functions that agents can call to perform specific actions. Each tool handles a discrete operation like making an API call, performing a web search, reading a file, or processing data.

They work best for single-purpose operations, API integrations, and providing agents with specific capabilities they can use as building blocks for larger workflows.

### Rules

Rules define specific constraints and logic for AI behavior. They are used by both teams and individuals to consistently apply security policies, data handling standards, and operational constraints, regardless of the task or agent persona.

They work best for enforcing compliance requirements, setting access controls, and defining specific behavioral boundaries that need consistent application.

### System prompts

System prompts establish the AI's foundational behavior and personality. They set the initial context for how an agent should respond, what tone to use, and basic capabilities to emphasize.

They work best for defining core behavior, setting communication style, and establishing baseline operational parameters that apply across all interactions (whereas rules act as narrower constraints that restrict or require specific actions within that baseline).

## What problems do skills solve?

Skills solve problems that emerge when teams rely on agents for complex workflows.

Prompts drift. Two people can ask for the same thing and get different results because they used different words, or because the agent chose to focus on different context. This can happen even within the same step-by-step process. Without consistent instructions, agent behavior varies even when performing the same task.

Workflow conventions get lost. Every process has its own patterns for quality checks, validations, approval flows, data formats, and decision criteria. Agents do not infer these correctly without guidance, and it is impossible to restate them for every task at scale.

Instruction sprawl bloats context. Copying detailed playbooks into prompts competes with everything else the agent needs to reason about, and critical workflow context gets buried.

Skills extract those instructions from ad hoc prompts and put them in a centralized place and format you can version, review, and reuse across your agentic workflows.

## What are examples of skills?

- [Vercel React Best Practices](https://skills.sh/vercel-labs/agent-skills/vercel-react-best-practices): When an agent is writing or reviewing React or Next.js code, it loads this skill to ensure components follow performance patterns like proper memoization, bundle optimization, and server component usage.

- [Supabase Postgres Best Practices](https://skills.sh/supabase/agent-skills/supabase-postgres-best-practices): When an agent needs to write database queries or design schemas, it applies this skill to ensure proper indexing, efficient query patterns, and optimal table structures.

- [Copywriting](https://skills.sh/coreyhaines31/marketingskills/copywriting): When an agent is creating marketing content, landing pages, or social copy, it uses this skill to apply conversion-focused writing patterns, persuasive frameworks, and brand voice consistency.

- [Remotion Best Practices](https://skills.sh/remotion-dev/agent-skills/remotion-best-practices): When an agent is generating video with the Remotion SDK, it uses this skill to apply domain-specific knowledge about animations, audio, 3D content, charts, captions, and other video production patterns.


These examples show how skills work across different domains. Development teams get code that follows performance best practices, database teams get optimized queries, marketing teams get copy that converts, and video teams get production-ready Remotion code. The same packaging format works whether you're writing SQL or sales content.

## What is a skill package?

A skill package is a shareable collection of one or more skills that teams can adopt and install where needed.

Each package contains components that make skills work. The only required component is the SKILL.md file. Everything else is optional.

The SKILL.md files contain instructions that tell the agent what the skill does and how to use it. The scripts directory holds executable helpers and automation scripts. The references directory contains supporting documentation, examples, and context files. Configuration files define setup and dependency requirements.

You do not need one giant instruction set for every repo. You can install a package where it fits and keep the rest of your agent setup unchanged. This modular approach lets teams adopt specific capabilities without overhauling their entire workflow.

A package might contain a single focused skill or multiple related skills that work together, and you can add supporting files as needed to make them useful in your development environment.

## How do I install a skill package?

To install a skill package, you can place the skill files in your project's `skills/` directory or global user scope. You can also use the `skills` command-line utility.

**Installing skills from the command line**

Use the [skills CLI](https://www.npmjs.com/package/skills) to add skills directly from the command line:

`npx skills add <owner/repo>`

## How do I find skills packages?

Skills have their own ecosystem with a consistent format and public directory at [skills.sh](https://skills.sh/), where you can discover new skills.

## What happens after installation?

Once installed, skills appear in your agent's available skills list. The agent loads them when needed based on the skill metadata and the current context.

## Can I create my own skills?

Yes, you can create custom skills. Skills are folders containing a `SKILL.md` file, and other files if needed, that define the skill's purpose and implementation.

You can create skills locally without external hosting. Create a folder, add a `SKILL.md` file with the required YAML frontmatter and skill definition, and the agent can use it immediately.

To understand the structure and implementation patterns, [explore existing skills as examples](https://vercel.com/blog/How%20do%20I%20find%20skills%20packages?%20Skills%20have%20their%20own%20ecosystem%20with%20a%20consistent%20format%20and%20public%20directory%20at%20skills.sh%20for%20discovery.). This helps you build skills that integrate effectively with agentic systems.

## Where do skills packages show up in real workflows?

Skills are most useful when they map to repeatable work patterns across any domain and represent specific domain expertise or organizational knowledge:

- A development team might have skills that explain how to add a new route, run tests, write clear PR descriptions, and confirm which checks must pass before merging.

- A content team could have skills for writing headlines, following brand guidelines, structuring blog posts, and optimizing for SEO.

- Customer support teams might create skills for triaging tickets, following tone guidelines, resolving common issues, and escalating when needed.

- Data analysts might create skills for cleaning datasets, running specific queries, creating visualizations, and documenting methodology.


Teams also build shared skill packages for processes they use across their organization. For example, engineering teams might standardize how to structure database migrations, write logging, or handle incidents.

The main shift agent skills bring is that specific instructions and expertise are no longer buried in someone's notes from last week or hidden in a prompt. They live in a central, reviewable place where teams can iterate on them together.

## How do skills get used by an agent?

Most agents that support skills follow the same pattern.

At startup, the agent loads a lightweight index of what skills are available. It sees names and descriptions, not the full instruction bodies.

When a task looks like a match, the agent loads the full content of the relevant skill. This keeps the default context small, while still making detailed guidance available when it matters.

Some agent platforms also support explicit invocation. That is useful when you want to force a workflow, or when you are debugging why a skill did or did not apply.

## What is in SKILL.md?

`SKILL.md` has two parts, YAML frontmatter and markdown content.

### YAML frontmatter

The frontmatter is used for agent discovery and metadata. It must include `name` and `description` fields.

The `name` field requirements include 1–64 characters, lowercase letters and numbers with single hyphens, must match the directory name, and must match `^[a-z0-9]+(-[a-z0-9]+)*$`.

The `description` field requirements are 1–1024 characters.

Unknown frontmatter fields are ignored, making the format forward compatible.

### Markdown content

The markdown content section contains the actual instructions for the agent. This is where you define what the agent should do, how it should behave, and any specific guidelines it should follow when using this skill.

## Which SKILL.md frontmatter fields are optional?

Optional frontmatter fields include `license`, `compatibility` (max 500 characters), `metadata` (arbitrary string-to-string key-value mappings), and `allowed-tools`.

These fields let a team communicate constraints and environment requirements without baking them into the prose.

## What else can a skill include?

A skill can be more than a single instruction file.

Alongside `SKILL.md`, a skill directory can include a `scripts/` directory for executable helpers, which are useful when you want a step to run the same way every time. A `references/` directory holds longer supporting docs the agent can load only when it needs them. An `assets/` directory contains files that support the skill's output, like templates, examples, or other artifacts.

These are optional, but they add advanced functionality, simplify `SKILL.md`, and keep long reference material out of the default context.

## What is the scripts directory for?

`scripts/` can contain executable helpers.

This can make skills more token-efficient and more deterministic, because the agent can run a script instead of re-deriving a multi-step procedure in natural language.

Scripts also make review easier. If there is a step that must be correct every time, a script is often more auditable than a paragraph.

## What is the references directory for?

`references/` is for supporting documents that are designed to be loaded on demand.

This fits a progressive disclosure model. An agent can see summaries first, then load full content only when it needs the details.

One practical best practice is to avoid duplicating the same information in both `SKILL.md` and `references/`.

If a reference file is huge, include grep search patterns in `SKILL.md` so an agent can locate the right section quickly.

## Other common questions about skills

**Are skills secure?**

A useful mental model is that skills change how an agent behaves. Like any AI tool, they do not magically make the agent trustworthy. If a skill package includes scripts, treat them like any other code you run. Review what it does, pin versions where you can, and prefer packages that are designed to be auditable.

**What are alternatives to skills?**

You can also use prompt libraries, repo-level instruction files like `AGENTS.md`, or custom agent wrappers. The industry is converging on skills as a shared standard, so they are the recommended approach for most teams.

## Why skills matter

Teams are going to spend more time supervising agents.

If the only place your context and conventions live is in someone's chat history, you cannot review them, update them systematically, or debug them when something goes wrong.

Skills make agent behavior easier to standardize.

They also make it easier to improve over time. You can ship a better workflow as a change to a skill package, not as a new prompt someone has to remember.

## Skills resources

- [Agent Skills](https://agentskills.io/home): Learn about the open standard for skills

- [Skills.sh](https://skills.sh/): Search for and discover agent skills

- [npx skills](https://www.npmjs.com/package/skills): The CLI for the open agent skills ecosystem