# SKILL.md

## Name
VimReaper

## Description
VimReaper is a dead‑code cleanup skill that systematically scans a codebase to identify and safely remove unused code—dead functions, unreachable blocks, obsolete variables, redundant imports, and leftover comments—while preserving the intended logic and test suite.
As its name suggests, VimReaper wields the **vim editor** as its primary scalpel: code removal is performed using vim’s precise ex commands, search patterns, and scripted editing modes, making the cleanup fast, reproducible, and respectful of file formatting. When a task exceeds simple pattern deletion, the agent consults vim’s built‑in manual (`:help`) to find the optimal surgical command.

## When to Use
- A user requests “clean up dead code”, “remove unused code”, or “purge stale logic”.
- A codebase has grown organically and contains vestigial functions, unused imports, or commented‑out blocks that need pruning.
- Pre‑release hygiene: removing debug helpers, feature flags that are fully rolled out, or legacy compatibility shims.
- After a major refactor, to strip out the old implementations that are no longer reachable.

## Core Capabilities
1. **Identification** – locate dead code via:
   - Unused imports / requires / includes.
   - Functions/methods/classes that are never called or instantiated.
   - Unreachable code after return, throw, break, or continue.
   - Variables that are assigned but never read.
   - Commented‑out blocks of source code.
   - Redundant conditional branches that can never be taken.
   - Deprecated modules or polyfills that are no longer needed.
2. **Analysis** – determine the safety of removal using:
   - Call graph analysis (if tooling available) or conservative grep/rg searches.
   - Detection of dynamic references (eval, reflection, __getattr__) that may hide usages.
   - Test coverage mapping: highlight code not exercised by any test.
3. **Removal** – perform the actual deletion using **vim** as the editor, with:
   - Language‑specific syntax awareness via vim’s syntax highlighting and indent settings.
   - File encoding and line ending preservation.
   - Source control integration: vim’s diff mode or command-line git wrappers.
4. **Verification** – after removal:
   - Run the existing test suite; report any failures and roll back if needed.
   - Perform a dry‑run diff so the user can review changes before they are applied.
5. **Documentation** – generate a summary report listing each removed item, its location, and the reason for removal.

## Instructions (Agent Workflow)
1. **Understand Scope**
   - Ask the user which directories/files to scan, or default to the entire project if unspecified.
   - Clarify any exclusions (e.g., third‑party code, generated files, certain glob patterns).
   - Confirm the primary programming language(s) involved.

2. **Setup Tooling**
   - For Python: leverage `vulture`, `autoflake`, `dead`.
   - For JavaScript/TypeScript: `ts-prune`, `knip`, ESLint rules (`no-unused-vars`, `no-unreachable`).
   - For other languages: fall back to `rg` / `grep` with pattern matching, plus AST traversal if a suitable parser exists.
   - Ensure tools are installed or guide the user to install them.
   - **Verify vim availability**: `vim --version` (or `nvim --version`). Vim 8.0+ is recommended; if missing, install it before proceeding.

3. **Initial Scan**
   - Run the dead‑code detection tool(s) on the target codebase.
   - Collect all candidates: file, line number, item name, and confidence level (certain / probable / possible false positive).
   - Produce a machine‑readable list (e.g., JSON) for further processing.

4. **Human‑in‑the‑Loop Review**
   - Present the candidate list to the user in a clear, grouped format (e.g., “Unused imports”, “Unused functions”, “Commented‑out code blocks”).
   - Allow the user to deselect items they want to keep, or mark items for “safe auto‑removal”.
   - For high‑confidence items (e.g., imports flagged by the compiler), offer a batch approval.

5. **Perform Cleanup with Vim**
   *VimReaper’s core editing is done entirely through vim.*
   - For each approved candidate, open the file in vim with the cursor positioned at the target line.
   - **Use vim’s ex commands** to surgically remove the dead code:
     - Delete line(s): `:34d` or `:34,42d` for a range.
     - Remove unused imports: `:g/^import.*unusedModule/d`.
     - Erase a function block: jump to the start (`/function unusedFunc`), then `dap` (delete a paragraph), or use precise line numbers from the scan.
   - When the pattern is complex (e.g., removing a conditional block while preserving surrounding code), consult vim’s manual: `:help delete`, `:help range`, `:help :global`. Use `:help` to learn the safest multi‑line deletion or substitution commands.
   - Apply changes file by file, saving each with `:w`.
   - **If a purely scripted (non‑interactive) approach is needed**, invoke `vim -e -s` with a command script (e.g., `vim -e -s -c "34d | wq" file.py`). Prefer interactive editing when user approval is required per item, scripted batch editing when auto‑approved.
   - After removal, tidy up any leftover blank lines or inconsistent indentation using vim’s `:g/^$/d` (with care) or `=G` to reindent the file.

6. **Validate**
   - Execute the project’s test suite (or a user‑specified subset).
   - If tests fail, use vim’s diff mode (`vim -d original modified`) to inspect the change and offer to revert just that edit.
   - Perform a linter check to ensure no new warnings were introduced.

7. **Report and Finalize**
   - Summarize what was removed: counts by category, and a detailed list.
   - If using Git, create a dedicated branch and commit with a message like `chore: reap dead code (VimReaper)`.
   - Provide the diff or pull request link.

## Vim as the Primary Editing Tool
- VimReaper relies on vim because it is universally available on development machines, provides precise, repeatable text manipulation, and handles large codebases without memory overhead.
- **Always use vim commands for editing**; fall back to other editors or stream editing (sed/awk) **only if vim is not installed** and cannot be installed.
- **Consult the vim manual liberally**: when you need to perform an unfamiliar multi‑line operation or want to ensure you are using the safest syntax, press `:help <topic>` inside vim. Common look‑ups include `:help delete`, `:help range`, `:help :substitute`, and `:help pattern`.
- In scripted mode (`-e -s`), you can pass a series of `-c` commands; always include `:wq` at the end to save and exit.

## Inputs
- **Target Path** (required): directory or file list to scan.
- **Language/Framework Hint** (optional): helps select the best analysis tool.
- **Exclusion Patterns** (optional): glob patterns or folders to ignore (e.g., `**/migrations/**`, `vendor/`).
- **Confidence Threshold** (optional): minimum confidence level for auto‑suggestion (default: `probable`).

## Outputs
- **Summary Report**: markdown list of all removed items with locations.
- **Clean Diff**: unified diff of the applied changes.
- **Test Results**: pass/fail status and any rollbacks performed.

## Example Usage

User: "Clean up dead code in my Flask app."
Agent: Invokes VimReaper, scans ./ with Python tooling, finds 3 unused imports, 2 dead functions, and a commented‑out view.
Agent: "Here’s what I found. Shall I remove the imports automatically and let you decide on the functions?"
User: "Yes, remove imports, but keep the legacy_payment function for now."
Agent: Opens each file in vim, uses :g/^from unused_module import/d for imports, and interactive deletion for other items. Runs pytest (all green), commits to branch reaper/cleanup-2025-03-01.

## Guardrails & Caveats
- **Never delete code without user confirmation**, unless the user has explicitly set an “auto‑approve” mode.
- **Dynamic languages**: detection is heuristic; always flag functions used via `getattr` or string‑based dispatch as “possible false positive”.
- **Configuration files** (JSON, YAML, TOML): dead‑code detection is limited; avoid auto‑removing keys unless referenced from code.
- **Third‑party libraries**: do not modify files inside `node_modules`, `venv`, or similar.
- **Commit history**: always encourage the user to commit or stash before running, so changes are easily reversible.
- **Style consistency**: after removal, adjacent code may need minor reformatting; use vim’s `=G` (if indentation rules are set) or offer to run the project’s formatter (`black`, `prettier`).
- **Vim specifics**: if a file is open in vim and the user needs to interrupt, use `:q!` to abort without saving. For batch operations, test your vim command script on a copy first.

## Dependencies
- **vim** (or neovim) – the core editing tool.
- `ripgrep` (`rg`) for high‑speed text search.
- Language‑specific dead‑code detectors (see Setup Tooling).
- Git: for safe version control operations.

---

*VimReaper – because not all code deserves eternal life, and vim’s blade is the sharpest.*
