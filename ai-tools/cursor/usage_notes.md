# Cursor Usage Notes

A practical guide to using Cursor effectively. Covers hotkeys, modes, planning, worktrees, and AI-assisted my coding with cursor philosophy.

## Table of Contents

- [Project Setup](#project-setup)
- [Modes & Hotkeys](#modes--hotkeys)
- [Planning Workflow](#planning-workflow)
- [Worktrees](#worktrees)
- [Review & Navigation](#review--navigation)
- [Working with Models](#working-with-models)
- [Testing & Verification](#testing--verification)
- [Workflow Summary](#workflow-summary)

---

## Project Setup

**Initialize your project manually.** Install dependencies, set up your environment, and configure your project structure yourself before engaging the agent.

Why this matters:
- AI can run terminal commands, but manual setup avoids version conflicts and unexpected dependency choices
- You maintain control over your stack decisions (package versions, config files, folder structure)
- Easier to debug issues when you understand the foundation
In other words, keep your hands on the reigns. Then giddy up. 

**Before engaging the agent, have ready:**
- Project initialized with your package manager 
- Core dependencies installed
- Environment variables configured (`.env` files)
- Basic folder structure in place
- Any external services running (databases, APIs)

---

## Modes & Hotkeys

### Quick Reference

| Hotkey | Action |
|--------|--------|
| `CMD+E` | Switch between Agent and Editor mode |
| `CMD+Shift+V` | Copy content with file back-reference |

### Agent Mode
Best for implementation tasks. I lean towards **Opus 4.5** for planning-heavy work where you need the model to reason through architecture or complex logic.

When to use:
- Implementing features from a plan
- Refactoring code
- Debugging with full context

### Editor Mode
Lighter touch, good for quick edits and targeted changes. When you're fed up with the agents hitting a roadblock code it yourself!

When to use:
- Small, scoped changes
- When you want more control over what gets modified
- Quick fixes where you don't need full agent reasoning

### Planning Mode
Dedicated mode for generating and refining plans before implementation.

When to use:
- Starting a new feature or project
- When you know which tools/frameworks you want (set them up in planning mode)
- Discussing architecture before writing code

---

## Planning Workflow

### The Core Cycle

1. **Make a prompt** - Describe what you want to build
2. **Generate a plan** - Let the model create a `.md` plan file
3. **Review thoroughly** - Read the entire plan, don't skim
4. **Answer questions** - The model will ask clarifying questions, answer them
5. **Edit the plan** - Request "Changes:" followed by bullet points for modifications
6. **Run the plan** - Switch to agent mode and implement
7. **Inspect & adjust** - Review output, refine the plan if needed
8. **Re-run** - Iterate until complete

### The Three Pillars of Smart Agents

To make your agent more effective, provide:

1. **A Plan** - Clear, structured breakdown of the task
2. **A Verification Harness** - Tests, examples, or expected outputs to validate against
3. **Context** - Relevant tools, documentation, code examples, external repo tests

### When to Pump the Brakes

If the agent is way off after a couple iterations:
- Stop iterating on broken code
- Write tests or examples to constrain the problem
- Stub out the structure yourself, then let the agent fill in details
- Sometimes it's faster to just write it yourself

### Requesting Plan Changes

In planning mode, use this format:
```
Changes:
- Add error handling for the API calls
- Use Redis instead of in-memory cache
- Split the user service into auth and profile modules
```

---

## Worktrees

Worktrees let you split work into separate directories that can be merged independently. They're a middle ground between single-task agent work and full background agents.

### Complexity Levels

| Level | Approach | When to Use |
|-------|----------|-------------|
| **L1** | Agent in editor, one task | Simple features, bug fixes, focused work |
| **L2** | Worktrees - split tasks into directories | Multiple related tasks, avoiding PR bloat, parallel exploration |
| **L3** | Full background agent | Large autonomous tasks (often overkill) |

### Why Worktrees Over Background Agents

- More control over each task's progress
- Easier to review and merge incrementally
- Avoids massive PRs with unrelated changes
- Can tackle small additions without disrupting main work

### Worktree Configuration

Worktrees are configured in `.cursor/worktrees.json`. You can set up actions that run for each instance. See theofficial docs for details.

Common setup actions:
- Copy `.env` files from root
- Install dependencies
- Run build scripts

### Parallel Instances

Worktrees allow you to:
- Run multiple instances working on different paths (visible in `.cursor`)
- Compare different models on the same task
- Test different approaches simultaneously
- Select the number of instances based on task parallelizability

---

## Review & Navigation

### Review Tab

The Review tab shows a **full diff of all files** changed in your session. Use it to:
- Inspect everything before committing
- Catch unintended changes
- Understand the full scope of modifications
- Verify the agent didn't touch files it shouldn't have

### Copying with Context

`CMD+Shift+V` copies content **with a back-reference to the specific file**. Useful for:
- Sharing code snippets that maintain their source
- Creating documentation with traceable references
- Pasting into other tools while preserving context

---

## Working with Models

### Tight Feedback Loops

Models perform better with tight feedback loops. This means:
- Run code frequently, don't let the agent write for too long without validation
- Provide immediate feedback on what's working vs. what's not
- Smaller iterations > large batches of changes

### Code is Cheap, Prompts are Expensive

Your prompt and plan are what you're maintaining long-term. Code can be:
- Thrown away if it's going in a weird direction
- Regenerated from a good prompt
- Rewritten faster than debugged (sometimes)

Don't get attached to bad code. If you're 3 iterations deep and it's still broken, restart with a better prompt.

### Leveraging External Context

For projects building on existing libraries/frameworks:
- Clone the repo you're building around
- Give the model access to tests from that repo
- Reference documentation and examples

Resource: [Better Coding Agents](https://github.com/bmdavis419/.better-coding-agents)

### Writing the Skeleton First

Sometimes the best approach:
1. Write the aspect you know you want (even if nothing works yet)
2. Stub out the structure and interfaces
3. Let the agent build out the implementation to match your structure

This gives the agent a target to hit rather than open-ended generation.

---

## Testing & Verification

### Dry Run Tests

Give models dry run tests - lightweight checks that validate behavior without full integration. These help the model:
- Understand expected inputs/outputs
- Self-correct before you review
- Catch obvious errors early

### Tests as Guardrails

Tests aren't just for validation after the fact. They're **guardrails during development**:
- Write tests before asking for implementation
- The model can run tests to verify its own work
- Failed tests give clear feedback for iteration

### When to Write Harnesses

Write a verification harness when:
- The task is complex enough that you can't eyeball correctness
- You'll be iterating multiple times
- The agent keeps making the same mistakes
- You need reproducible validation

Skip the harness when:
- It's a simple, one-shot change
- Visual inspection is sufficient
- The cost of writing tests exceeds the cost of manual verification

### MCPs and Tooling

MCPs (Model Context Protocols) aren't necessary for most workflows. Focus first on:
- Getting better at writing instructions
- Building good verification harnesses
- Providing clear context

Add tooling complexity only when you've maxed out the basics.

---

## Workflow Summary

### The Iteration Loop

```
Prompt → Plan → Edit Plan → Run → Inspect → Adjust → Re-run
                    ↑                              |
                    └──────────────────────────────┘
```

### Decision Point: Iterate or Harness?

After running your plan, ask yourself:

| Situation | Action |
|-----------|--------|
| Output is close, minor issues | Iterate - adjust and re-run |
| Output is off but fixable | Add context, clarify the plan, re-run |
| Output is fundamentally wrong | **Stop.** Write tests/examples, or code it yourself |
| Same mistake multiple times | Add a verification harness |
| You're 3+ iterations deep with no progress | Restart with a new approach |

### The Golden Rule

When in doubt: **more harness, less iteration.** A few minutes writing a test saves hours of debugging AI-generated spaghetti.
