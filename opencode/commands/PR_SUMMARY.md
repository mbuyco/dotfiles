---
description: "Generates a PR summary description based on the changes made in the codebase."
---

## Command

Generate a PR summary changes made in the codebase.

**Rules:**

- If user did not provide a source/target branch, use the current branch as the source and the `main` or `master` branch as the target.
- Do not include unstaged changes in the PR summary, only include staged changes if they exist, otherwise use the current branch changes from target branch as a reference.
- Generate a PR summary with the following sections (including the emojis):
    - ❓ What
    - 🛠️ How
    - 🔑 Key Changes
    - 🧪 QA Guidance (prefer with manual local testing guidance)
    - 📜 Environment/Configuration Changes (if any)
- In the "Key Changes", explain each changes and files modified in a concise way, and include the file path for each change.
- Do not mention any environment variables and configuration values. Always redact when necessary.

**Parameters**

- `source` - The source branch for the PR. If not provided, the current branch will be used.
    - Example: `/PR_SUMMARY.md source=feature-branch`
- `target` - The target branch for the PR. If not provided, the `main` or `master` branch will be used.
    - Example: `/PR_SUMMARY.md target=main`
