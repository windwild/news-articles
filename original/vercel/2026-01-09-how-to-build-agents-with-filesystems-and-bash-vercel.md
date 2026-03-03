---
title: "How to build agents with filesystems and bash - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-to-build-agents-with-filesystems-and-bash"
date: "2026-01-09"
scraped_at: "2026-03-02T09:23:00.901292203+00:00"
language: "en"
translated: false
description: "How to build agents with filesystems and bash, production agents, context management, template, bash"
---




Jan 9, 2026

The best agent architecture is already sitting in your terminal

Many of us have built complex tooling to feed our agents the right information. It's brittle because we're guessing what the model needs instead of letting it find what it needs. We've found a simpler approach. We replaced most of the custom tooling in our internal agents with a filesystem tool and a bash tool. Our sales call summarization agent went from ~$1.00 to ~$0.25 per call on Claude Opus 4.5, and the output quality improved. [We used the same approach for d0](https://vercel.com/blog/we-removed-80-percent-of-our-agents-tools), our text-to-SQL agent.

The idea behind this is that LLMs have been trained on massive amounts of code. They've spent countless hours navigating directories, grepping through files, and managing state across complex codebases. If agents excel at filesystem operations for code, they'll excel at filesystem operations for anything. Agents already understand filesystems.

Customer support tickets, sales call transcripts, CRM data, conversation history. Structure it as files, give the agent bash, and the model brings the same capabilities it uses for code navigation.

## How agents read filesystems

The agent runs in a sandbox with your data structured as files. When it needs context, it explores the filesystem using Unix commands, pulls in what's relevant, and sends that to the LLM.

```markdown
Agent receives task

2    ↓

Explores filesystem (ls, find)

4    ↓

Searches for relevant content (grep, cat)

6    ↓

Sends context + request to LLM

8    ↓

Returns structured output
```

The agent and its tool execution run on separate compute. You trust the agent's reasoning, but the sandbox isolates what it can actually do.

## Why filesystems work for context management

The typical approach to agent context is either stuffing everything into the prompt or using vector search. Prompt stuffing hits token limits. Vector search works for semantic similarity but returns imprecise results when you need a specific value from structured data.

Filesystems offer a different tradeoff.

**Structure matches your domain.** Customer records, ticket history, CRM data. These have natural hierarchies that map directly to directories. You're not flattening relationships into embeddings.

**Retrieval is precise.**`grep -r "pricing objection" transcripts/` returns exact matches. When you need one specific value, you get that value.

**Context stays minimal.** The agent loads files on demand. A large transcript doesn't go into the prompt upfront. The agent reads the metadata, greps for relevant sections, then pulls only what it needs.

## Mapping your domain to files

Let's look at some concrete examples of how different domains map to filesystem structures.

**Example 1: Customer support system**

Instead of throwing raw JSON into your agent, structure it:

```bash
1/customers/

2  /cust_12345/

3    profile.json          # High-level info

4    tickets/

5      ticket_001.md       # Each ticket

6      ticket_002.md

7    conversations/

8      2024-01-15.txt      # Daily conversation logs

9    preferences.json
```

When a customer asks "What was the resolution to my issue?", the agent can `ls` the tickets directory, `grep` for "resolved", and read only the relevant file.

**Example 2: Document analysis system**

```bash
1/documents/

2  /uploaded/

3    contract_abc123.pdf

4    invoice_def456.pdf

5  /extracted/

6    contract_abc123.txt

7    invoice_def456.txt

8  /analysis/

9    contract_abc123/

10      summary.md

11      key_terms.json

12      risk_assessment.md



14/templates/

15  contract_analysis_prompt.md

16  invoice_validation_rules.md
```

Raw inputs in one place, processed outputs in structured directories. The agent can reference previous analysis without reprocessing.

## Case study: Sales call summary agent

We built a [sales call summary template](https://vercel.com/templates/ai/call-summary-agent) using this architecture. The agent analyzes sales call transcripts and generates structured summaries with objections, action items, and insights.

The agent sees this file structure:

```bash
gong-calls/

2  demo-call-001-companyname-product-demo.md     # Current call transcript

3  metadata.json                                 # Call metadata

4  previous-calls/

5    demo-call-000-discovery-call.md             # Prior discovery call

6    demo-call-intro-initial-call.md             # Initial intro call



salesforce/

9  account.md                                    # CRM account record

10  opportunity.md                                # Deal/opportunity details

11  contacts.md                                   # Contact profiles



slack/

14  slack-channel.md                              # Slack history



research/

17  company-research.md                           # Company background

18  competitive-intel.md                          # Competitor analysis



playbooks/

21  sales-playbook.md                             # Internal sales playbook


```

The agent explores this like a codebase:

```bash
1# Explore what's available

2$ ls sales-calls/

customer-call-123456-q4.md

metadata.json



6# Read the metadata

7$ cat sales-calls/metadata.json



9# Look for objections

10$ grep -i "concern\|worried\|issue\|problem" sales-calls/*.md
```

The intuition is that the agent treats the transcript like a codebase. It searches for patterns, reads sections, and builds context just like it would debug code. No custom retrieval logic. The agent decides what context it needs using tools it already knows how to use. It handles edge cases we never anticipated because it's working with the raw information, not parameters we defined.

We'll have another post diving deeper into the sales call summary agent.

## Why you should use bash and filesystems

**Native model capabilities.** grep, cat, find, awk. These aren't new skills we're teaching. LLMs have seen these tools billions of times during training. They're native operations, not bolted on behaviors.

**Future-proof architecture.** As models get better at coding, your agent gets better. Every improvement in code understanding translates directly. You're leveraging the training distribution instead of fighting against it.

**Debuggability.** When the agent fails, you see exactly what files it read and what commands it ran. The execution path is visible. No black box.

**Security through isolation.** The sandbox lets the agent explore files without access to production systems. You trust the reasoning, not the execution environment.

**Less code to maintain.** Instead of building retrieval pipelines for each data type, you write files to a directory structure. The agent handles the rest.

## Get started

Every agent needs filesystem and bash. If you're building an agent, resist the urge to create custom tools. Instead, ask: can I represent this as files?

We recently open-sourced [bash-tool](https://vercel.com/changelog/introducing-bash-tool-for-filesystem-based-context-retrieval), a dedicated tool that powers this pattern.

1. [**AI SDK**](https://ai-sdk.dev/docs/introduction) for tool execution and model calls

2. [**bash-tool**](https://www.npmjs.com/package/bash-tool) for sandboxed filesystem access

3. [**Sales Call Summary template**](https://vercel.com/templates/ai/call-summary-agent) to see the full pattern and to get started with one-click


The future of agents might be surprisingly simple. Maybe the best architecture is almost no architecture at all. Just filesystems and bash.

[**Get started with filesystem agents**\\
\\
The Sales Call Summary template shows the filesystem and bash pattern in production. Deploy it on Vercel and watch the agent explore files in real time.\\
\\
Deploy the template](https://vercel.com/templates/ai/call-summary-agent)