---
title: "Introducing DeepAgents CLI"
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-deepagents-cli/"
date: "2025-11-03"
scraped_at: "2026-03-03T07:20:41.168140493+00:00"
language: "en"
translated: false
---

_By_ [_Vivek Trivedy_](https://www.linkedin.com/in/vivek-trivedy-433509134/?ref=blog.langchain.com)

We're excited to introduce **DeepAgents CLI** for coding, research, and building agents with persistent memory. Now you can easily create and run custom DeepAgents directly from the terminal. It supports:

- **Read, write, and edit files** in your project
- **Execute shell commands** with human approval
- **Search the web** for current information
- **Make HTTP requests** to APIs
- **Learn and remember** information across sessions
- **Plan tasks** with visual todo lists

## Installation

Install DeepAgents with CLI support:

```bash

pip install deepagents-cli
```

Or if you're using `uv`:

```bash

uv pip install deepagents-cli
```

## Quick Start

### 1\. Set Up Your API Keys

DeepAgents CLI supports both Anthropic (Claude) and OpenAI models. **Anthropic Claude Sonnet 4 is the default** model and Tavily is used for web search. Add these to your `.env` file in your project root, and DeepAgents will automatically load them:

```bash

export ANTHROPIC_API_KEY=your_api_key_here
export OPENAI_API_KEY=your_api_key_here
export TAVILY_API_KEY=your_tavily_key_here
```

### 2\. Launch the CLI

Start DeepAgents in your project directory:

```bash

deepagents
```

Or, if you’re using `uv`:

```jsx
uv run deepagents
```

### 3\. Your First Task

Try asking the agent to help with a simple task:

```

You: Add type hints to all functions in src/utils.py
```

The agent will:

1. Read the file
2. Analyze the functions
3. Show you a diff of proposed changes
4. Ask for your approval before writing

There's also an option to Auto-Accept Edits to speed up development

## Learning Through Memory

One of DeepAgents' most powerful features is its **persistent memory system**. The agent can learn information and recall it across sessions. Each agent stores its knowledge in `~/.deepagents/AGENT_NAME/memories/`:

By default, if you spin up DeepAgents it will create an agent with the name `agent` and use that by default. You can change the agent used (and therefor what memories are used) by specifying an agent name, eg `deepagents --agent foo`. See next section for more details.

The agent automatically follows a **Memory-First Protocol**:

1. **During Research** \- Checks `/memories/` for relevant knowledge
2. **Before answering** \- Searches memory files in case of uncertainty
3. **When learning** \- Saves new information to `/memories/`

### Example: Teaching API Patterns

```

You: Remember that our API endpoints follow this pattern:
- Use /api/v1/ prefix
- All POST requests return 201 on success
- Error responses include a "code" and "message" field

Save this as our API conventions.

Agent: I'll save these API conventions to memory.
⚙ write_file(/memories/api-conventions.md)
```

Because this memory is persistent, the agent can use this information across future conversations.

```
You: Create a new endpoint for user registration
Agent: Based on our API conventions, I'll create an endpoint at
/api/v1/users that returns 201 on success and follows
our error format.
⚙ read_file(/memories/api-conventions.md)
⚙ write_file(src/routes/users.py)
```

### Memory Best Practices

**1\. Use descriptive filenames** ✓ /memories/deployment-checklist.md ✗ /memories/notes.md

**2\. Organize by topic**

```
/memories/
├── backend/

│ ├── tools_to_use.md

│ └── api-design.md

├── frontend/

│ ├── component-patterns.md

└── security-setup.md
```

**3\. Verify saved knowledge** Because memory is just a set of files, you can always inspect and validate its content manually or with the agent.

```
You: Check what you know about our database

Agent: Let me check my memories...
⚙ ls /memories/
⚙ read_file(/memories/backend/database-schema.md)

Based on my memory, we use PostgreSQL with these tables...
```

You can also inspect the memory files manually by just looking at `~/.deepagents/AGENT_NAME/memories/`

### Managing Multiple Agents

You can create specialized agents for different projects or roles: From the DeepAgents CLI you can list existing agents, create new agents, or reset an agent to its default state (system prompts, memories, etc).

```bash
deepagents list
```

```bash
deepagents agent backend-dev
```

```bash
deepagents reset backend-dev
```

## Get Started Today

Get started with DeepAgents and the DeepAgent CLI today! We're excited to see what you build.

Join the community and contribute:

- **GitHub**: [https://github.com/langchain-ai/deepagents](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com)
- **Documentation**: [docs.langchain.com/oss/python/deepagents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com)
- **YouTube:** [https://youtu.be/IrnacLa9PJc](https://youtu.be/IrnacLa9PJc?ref=blog.langchain.com)