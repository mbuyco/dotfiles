# agent-skills

Reusable, markdown-based “skills” for LLM agents (e.g., OpenCode). Each skill is a self-contained guide the agent can load to follow consistent practices for a specific domain (security reviews, performance analysis, framework best practices, system design, etc.).

## Repository Layout

Each skill lives in its own directory:

```text
<skill-slug>/
  SKILL.md
```

`SKILL.md` starts with YAML frontmatter that describes the skill and any constraints:

```yaml
---
name: <skill-id>
description: <one-line description>
compatibility: <optional>
license: <SPDX id>
metadata: <optional map>
allowed-tools: <optional list>
---
```

## Included Skills

- `laravel-12-best-pratices/` - Best practices for Laravel 12.x (architecture, Eloquent, testing, security, performance).
- `performance-analysis/` - Structured performance reasoning: bottlenecks, caching, validation/measurement.
- `security-review/` - Threat modeling and security review guidance (STRIDE-style analysis, mitigations).
- `software-engineer/` - Generalized software engineering guidance for security, cost, performance, reliability, and pragmatic delivery.
- `system-design/` - System design reasoning and documentation templates (requirements, components, trade-offs).

## Using These Skills

How you load/apply a skill depends on the agent host. In general:

1. Pick a skill by its `name` in the frontmatter.
2. Load it into the agent runtime.
3. Ask the agent to perform work “using” that skill.

If your host expects a specific directory structure or index, keep the layout above and point it at this repository root.

## Adding a New Skill

1. Create a new folder named with a kebab-case slug (e.g., `api-design/`).
2. Add `SKILL.md` with frontmatter (`name`, `description`, `license` at minimum).
3. Write the skill content as clear instructions the agent can follow (when to use, steps, examples).
4. Add it to the list in this README.

## License

Skills declare their license in `SKILL.md` frontmatter. The currently included skills use `Apache-2.0`.
