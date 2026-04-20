---
name: react-tailwind
description: Frontend development skill for React, Tailwind CSS, and JavaScript. Use when building UI components, styling with Tailwind, managing state, improving performance, implementing accessibility, or writing frontend tests.
license: Apache-2.0
metadata:
  category: frontend
  version: "1.0"
  stack: "React Tailwind JavaScript TypeScript"
  level: "comprehensive"
---

# React + Tailwind Frontend Developer

## Overview

This skill provides a practical, production-focused workflow for frontend work using React, Tailwind CSS, and modern JavaScript.

It supports both TypeScript and JavaScript codebases.

It is framework-agnostic by default. Use the guidance for SPA, MPA, and server-enabled React frameworks while avoiding framework-specific assumptions unless the repository already uses one.

Core requirements for this skill:
- Always review the current intended use case before proposing architecture or code.
- Always present tradeoffs to the user before committing to major implementation choices.

## When to use

Use this skill when the user asks for any of the following:
- React component design or refactoring
- Tailwind CSS architecture or design system setup
- State management decisions
- Performance optimization in React UI
- Accessibility improvements or audits
- Frontend testing strategy or implementation
- Migration guidance across frontend patterns

Do not use this skill for:
- Backend-only tasks with no UI impact
- Pure design mockups without implementation concerns
- Non-web runtime code that does not involve React UI

## Operating Model

For every non-trivial request, follow this sequence:

1) Understand intended use case
- Clarify user goal, scope, constraints, and runtime context.
- Confirm target users, interaction patterns, and expected scale.
- Identify whether the request is feature delivery, bug fix, refactor, or optimization.

2) Evaluate existing codebase patterns
- Prefer established project conventions over introducing new patterns.
- Match naming, folder structure, state patterns, and testing style.
- Reuse existing shared UI and utility functions where possible.

3) Present tradeoffs before major decisions
- For architecture-level decisions, show at least 2 viable options.
- Explain pros, cons, and operational cost.
- Recommend one option and explain why it fits the current use case.

4) Implement with safety and maintainability
- Keep components focused and composable.
- Use semantic HTML first; ARIA only when needed.
- Minimize regressions through tests and small, reviewable changes.

5) Verify and report clearly
- Validate build and tests where available.
- Report what changed, why it changed, and what tradeoffs were accepted.

## Decision Framework

Use this lightweight framework for every implementation:

### A) Use Case Check
- What user interaction is being enabled or fixed?
- What are performance, accessibility, and browser constraints?
- Is this a one-off feature or a reusable pattern?
- What existing project conventions must be preserved?

### B) Options and Tradeoffs

For each significant choice, use this table format:

| Option | Pros | Cons | Best when |
|---|---|---|---|
| Option A | ... | ... | ... |
| Option B | ... | ... | ... |

### C) Recommendation
- Choose one option.
- Tie the recommendation to the specific use case constraints.
- State which downside is accepted and why.

## Component Architecture

### Principles
- Prefer composition over inheritance.
- Keep component responsibilities small and explicit.
- Push state down to the smallest owning component that needs it.
- Promote reusable UI only after repeated real usage.

### Recommended structure
- `components/ui/*` for generic primitives
- `components/<feature>/*` for feature-scoped components
- `hooks/*` for reusable logic
- `lib/*` or `utils/*` for pure helpers

### Patterns

1) Controlled vs uncontrolled components

| Pattern | Pros | Cons | Best when |
|---|---|---|---|
| Controlled | Full state control, easier integration | More boilerplate | Forms, validation, synchronized UI |
| Uncontrolled | Simpler internals | Harder orchestration | Lightweight inputs, local-only interactions |

2) Compound components
- Useful for flexible APIs (`Tabs`, `Accordion`, `Menu`).
- Keep shared state in parent and expose subcomponents.
- Document expected hierarchy and keyboard behavior.

3) Headless component approach
- Separate behavior from visual styles.
- Useful for reusable logic with different visual treatments.

4) Render props vs custom hooks

| Pattern | Pros | Cons | Best when |
|---|---|---|---|
| Render props | Explicit composition | Verbose JSX nesting | Legacy code or explicit render control |
| Custom hooks | Concise and reusable | Hook rules must be respected | Modern React logic reuse |

### Anti-patterns to avoid
- Prop drilling beyond 2-3 levels without considering composition or context.
- Components growing past clear ownership boundaries.
- Mixing data fetching, rendering, and side effects in one large component.
- Duplicating variant style logic across files.

## State Management

Choose the simplest model that satisfies current requirements.

### Decision ladder

1) `useState`
- Default for local primitive state.

2) `useReducer`
- Use for complex local transitions.

3) Context + reducer
- Use for shared state with moderate update frequency.

4) External store (for example Zustand/Jotai)
- Use when shared state is broad, frequent, or performance-sensitive.

5) Server state tools (for example TanStack Query)
- Use for caching, synchronization, retries, and stale data policies.

### Tradeoff table

| Option | Pros | Cons | Best when |
|---|---|---|---|
| `useState` | Minimal API, low overhead | Hard to scale for complex transitions | Local UI state |
| `useReducer` | Predictable transitions, testable reducer | More boilerplate | Complex local state machine |
| Context | Built-in, no dependency | Broad re-renders if mis-scoped | Low-frequency shared config |
| External store | Fine-grained subscriptions | Additional dependency and API | High-frequency shared state |

### Rules
- Co-locate state with the component that owns behavior.
- Derive state during render when possible instead of duplicating it.
- Avoid `useEffect` for purely derived values.
- Use optimistic updates only when rollback behavior is defined.

### Anti-patterns
- Globalizing state too early.
- Storing derived values that can be computed cheaply.
- Using context for frequently changing granular data without selectors.

## Tailwind CSS Patterns

### Core styling principles
- Use design tokens (semantic names), not hardcoded brand hex in component markup.
- Prefer utility composition over custom CSS blocks.
- Keep class application explicit and local to components.

### Recommended patterns

1) `cn()` helper for class composition
- Merge conditional classes safely.
- Resolve utility conflicts deterministically.

2) Variant systems via `cva`
- Model `variant`, `size`, and state combinations centrally.
- Keep component APIs typed in TS and predictable in JS.

3) Tokenized design system
- Define color, spacing, and typography tokens in your theme layer.
- Use semantic tokens like `bg-primary`, `text-muted-foreground`, `border-input`.

4) Responsive and state handling
- Prefer mobile-first utility composition.
- Keep hover/focus/disabled classes grouped and visible.

### Tailwind v3 and v4 compatibility guidance
- Support existing project setup first.
- If project uses config-based setup, keep config-based conventions.
- If project uses CSS-first setup, keep token and source config in CSS.
- Avoid forcing migrations unless requested.

### Tailwind tradeoff examples

| Choice | Pros | Cons | Best when |
|---|---|---|---|
| Inline utility classes | Co-located styles, fast iteration | Can get verbose | Small to medium components |
| Extracted component + variants | Reusable, consistent | Initial setup cost | Shared primitives with many variants |
| Custom CSS `@apply` heavy usage | Familiar to CSS-first teams | Hidden abstractions, harder scaling | Rarely; only for constrained legacy cases |

### Anti-patterns
- Overusing `@apply` to recreate custom CSS architecture.
- Copy-pasting long class strings across many files.
- Hardcoding color codes in JSX where tokens exist.
- Building one-off utility abstractions with no clear reuse.

## Performance Optimization

Performance work should be measured, not guessed.

### Workflow
1) Identify bottleneck using profiler and runtime metrics.
2) Confirm hot path (render cost, network, bundle, layout).
3) Apply smallest effective change.
4) Re-measure and keep only proven improvements.

### Render optimization tradeoffs

| Technique | Pros | Cons | Best when |
|---|---|---|---|
| `React.memo` | Skips unnecessary child renders | Can hide stale props bugs and add complexity | Expensive pure children with stable props |
| `useMemo` | Caches expensive calculations | Memory and cognitive overhead | Expensive deterministic computations |
| `useCallback` | Stabilizes function identity | Boilerplate, often unnecessary | Callback props to memoized children |

### Additional practices
- Split large routes/components with dynamic import and suspense boundaries.
- Defer non-critical UI and scripts.
- Keep list rendering efficient with stable keys and virtualization for large lists.
- Optimize image loading strategy and avoid layout shifts.

### Anti-patterns
- Blanket memoization without profiling.
- Recomputing expensive transforms on every render.
- Shipping large unused dependency bundles for small features.

## Accessibility (A11y)

### Principles
- Use semantic HTML first. ARIA is a fallback, not a default.
- Ensure keyboard-only and screen reader workflows are complete.
- Accessibility is part of feature definition, not a post-processing step.

### Baseline checklist
- Logical heading structure
- Landmarks (`header`, `nav`, `main`, `footer`)
- Visible focus styles
- Keyboard-operable interactive elements
- Form labels and error association
- Sufficient color contrast

### Common component guidance

1) Forms
- Every field has a programmatically associated label.
- Error messages are discoverable and announced.
- Required state is explicit and consistent.

2) Dialogs and overlays
- Focus enters dialog on open and returns on close.
- Escape key closes when appropriate.
- Background content is not focusable while modal is open.

3) Menus and custom controls
- Use established ARIA patterns when semantics are not native.
- Prefer existing accessible primitives over hand-rolled widgets.

### Accessibility tradeoffs

| Choice | Pros | Cons | Best when |
|---|---|---|---|
| Native HTML controls | Lowest risk, best compatibility | Less custom visual control | Most form and button interactions |
| Custom ARIA widget | Flexible UI behavior | High implementation/test burden | Native semantics cannot satisfy UX need |

### Testing accessibility
- Add automated checks (for example axe in test and browser tooling).
- Run manual keyboard traversal for core user journeys.
- Validate with at least one screen reader for critical flows.

## Testing Strategy

### Principles
- Test behavior users observe, not implementation details.
- Prefer integration-level confidence for feature workflows.
- Keep unit tests for pure logic and utility functions.

### React Testing Library priorities
- Prefer `getByRole` and accessible-name queries first.
- Use `userEvent` for realistic interactions.
- Use `findBy*` and `waitFor` for async assertions.

### Test coverage expectations

For new UI behavior, include:
- happy path
- loading state
- error state
- accessibility-critical behavior (labels, roles, keyboard flow)

### Mocking guidance
- Mock network boundaries, not internal component details.
- Prefer stable test fixtures over broad fragile mocks.

### Tradeoffs

| Testing style | Pros | Cons | Best when |
|---|---|---|---|
| Unit-heavy | Fast and isolated | Lower end-to-end confidence | Pure functions and reducers |
| Integration-heavy | Better real behavior confidence | Slower and broader setup | Component-feature workflows |
| E2E-heavy | Full user-path validation | Highest maintenance/runtime cost | Critical business flows |

### Anti-patterns
- Asserting internal state instead of rendered behavior.
- Using `data-testid` as first-choice selector.
- Ignoring loading and error branches in async UI.

## TypeScript and JavaScript Guidance

Use the same architectural guidance for TS and JS.

### TypeScript-first recommendations
- Type component props, variant contracts, and public utility signatures.
- Use inferred types for simple local values; avoid noisy over-typing.
- Export reusable domain types from feature boundaries.

### JavaScript compatibility notes
- Apply the same patterns without type syntax.
- Keep runtime validation where input boundaries are uncertain.
- Add JSDoc on shared utilities when clarity is needed.

## React 19 and Server Components Note

This skill is framework-agnostic. Do not assume server components are available unless the repository explicitly supports them.

If the project supports React Server Components, apply this decision rule:

| Component need | Suggested side |
|---|---|
| Requires browser APIs, interaction, local hooks | Client |
| Pure rendering and data preparation without client interaction | Server |

Always present tradeoffs around bundle size, interactivity needs, and operational complexity before choosing boundaries.

## Recommended Response Format

When applying this skill, structure your response in this order:

1) Use case understanding
- Restate intended use case and constraints.

2) Options and tradeoffs
- Provide 2 or more viable approaches with tradeoffs.

3) Recommendation
- Name the preferred option and justify it.

4) Implementation plan
- Give clear, small steps mapped to files/components.

5) Verification
- List exact checks (build, tests, a11y validation, perf sanity).

6) Risks and follow-ups
- Mention known risks and practical next actions.

## Practical Examples

### Example 1: Button variant system

**Input:** "Create a reusable button system with primary, secondary, and danger variants."

**Expected approach:**
- Confirm use cases (forms, dialogs, destructive actions, icon buttons).
- Present options: inline class strings vs centralized variant helper.
- Recommend `cva` + `cn()` for reuse and consistency.
- Implement typed props in TS or clean prop contract in JS.
- Add tests for keyboard focus, disabled behavior, and variant rendering.

### Example 2: Shared state across dashboard widgets

**Input:** "Several widgets need synchronized filters and date range state."

**Expected approach:**
- Clarify update frequency and scope (single page vs app-wide).
- Present options: lifted state, context+reducer, external store.
- Recommend the simplest option that meets update frequency needs.
- Validate render behavior to avoid unnecessary updates.
- Add tests for state propagation and reset behavior.

### Example 3: Slow table rendering

**Input:** "Data table feels laggy when users type in search."

**Expected approach:**
- Profile first (render count, expensive transforms, list size).
- Present options: memoization, debouncing, virtualization, query caching.
- Recommend measured, minimal set of changes.
- Re-measure and report quantified improvement.
- Add regression test for search behavior and loading states.

### Example 4: Accessibility audit for form flow

**Input:** "Review and fix accessibility issues in signup flow."

**Expected approach:**
- Run baseline checks for labels, role structure, focus order, and error messaging.
- Present tradeoffs when custom controls conflict with native semantics.
- Prefer native controls or accessible primitives.
- Add automated accessibility checks and manual keyboard script.
- Report remaining known limitations clearly.

## Edge Cases

### Legacy CSS-heavy codebase
- Avoid big-bang rewrite.
- Introduce Tailwind patterns incrementally behind stable interfaces.

### Conflicting team preferences
- Compare options on maintainability, onboarding cost, and production risk.
- Recommend a default plus an explicit migration path if needed.

### Incomplete requirements
- Implement safe defaults and call out assumption boundaries.
- Keep abstractions minimal until requirements stabilize.

### Tight deadlines
- Prioritize user-visible correctness, accessibility, and regression safety.
- Defer non-critical refactors with documented follow-up items.

## Quick Quality Checklist

Before finalizing work, verify:
- Use case and constraints are clearly captured.
- Tradeoffs were presented for major decisions.
- Accessibility baseline is met for changed UI.
- Performance-sensitive areas were measured, not guessed.
- Tests cover behavior, including loading and error paths.
- Solution aligns with existing project conventions.
