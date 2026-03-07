---
description: "Generates a PR summary description based on the changes made in the codebase."
---

## Command

Generate a PR summary changes made in the codebase.

**Rules:**

- Only include the staged git changes.
- Generate a PR summary with the following sections (including the emojis):
    - ❓ What
    - 🛠️ How
    - 🔑 Key Changes
    - 🧪 Testing
- In the "Key Changes", explain each changes and files modified in a concise way, and include the file path for each change.
