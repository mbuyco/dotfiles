---
name: codebase-explorer
description: "Explore an unfamiliar codebase and report its relevant modules, data flow, and practical gotchas. Use for architecture orientation or codebase walkthroughs, not for implementing changes."
---

# Codebase Explorer

Map the repository sufficiently to explain how it works, while keeping the result proportional to its complexity and the user's question.

## Explore

- Read the repository's top-level documentation and local agent instructions first. Use them to identify the runtime, entry points, package boundaries, and generated or vendored paths.
- Inventory the repository with `rg --files` (honoring ignore rules). Prefer `repomix` when installed and useful for a compact overview; otherwise use targeted file discovery and searches. Do not install tools solely for this task.
- Exclude third-party, generated, build, cache, vendored, dependency, and lockfile content unless it is necessary to explain a dependency boundary or a reported problem. Typical exclusions include dependency directories, package caches, generated API clients, build output, coverage, and minified assets.
- Follow execution from actual entry points through route/command registration, orchestration or service layers, storage/network adapters, and returned output. Inspect configuration, schemas, and tests when they clarify contracts or behavior.
- Search by symbol and import/reference rather than reading every file. Treat directory names and filenames as leads, not proof of responsibility.
- State uncertainty explicitly when a path cannot be established from available code.

## Report

Give the requested answer first. For a general exploration, structure the report as:

1. A short system overview: purpose, runtime, primary entry points, and major boundaries.
2. **Modules and responsibilities:** one concise bullet per relevant module or package. Group repetitive leaf modules; omit unimportant implementation detail.
3. **Data flow:** show the main path from input to output. Use a compact Mermaid flowchart when it makes three or more transitions easier to understand; otherwise use one or two arrow chains. Include important validation, transformation, persistence, and external-service boundaries.
4. **Gotchas:** finish with concrete risks, surprising conventions, security or operational constraints, configuration traps, and unverified assumptions discovered during exploration.

Scale depth to the repository:

- For a small codebase, identify the principal files and give a complete end-to-end path.
- For a large or complex codebase, map only the components needed to understand its main workflows. Keep every module summary and flow label short, and explicitly note excluded subsystems rather than producing exhaustive inventories.
- When the user asks about a particular feature or bug, make that path the primary flow and mention unrelated architecture only when it changes the answer.

Never expose secrets found in configuration, fixtures, logs, or environment files. Do not modify repository files during exploration unless the user separately asks for a change.
