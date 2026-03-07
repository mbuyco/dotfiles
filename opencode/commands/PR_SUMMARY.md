---
description: "Generates a PR summary description based on the changes made in the codebase."
---

## Command

Generate a PR summary changes made in the codebase.

**Rules:**

- If user did not provide a source/target branch, use the current branch as the source and the `main` or `master` branch as the target.
- Only include the staged git changes if it exists, otherwise use the current branch as a reference.
- Generate a PR summary with the following sections (including the emojis):
    - ❓ What
    - 🛠️ How
    - 🔑 Key Changes
    - 🧪 Testing
- In the "Key Changes", explain each changes and files modified in a concise way, and include the file path for each change.
