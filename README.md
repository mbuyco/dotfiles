# dotfiles

Personal dotfiles and configuration for a Linux (Fedora/Ubuntu) workstation.

Covers the shell (zsh + fish), editors (vim), terminal emulators (ghostty, alacritty, windows-terminal), window manager (i3), tmux, ranger, and a fairly extensive [OpenCode](https://opencode.ai) AI-coding-agent setup (plugins, slash commands, and reusable skills).

## Installation

> **Note:** the installer targets a fresh Fedora/Ubuntu system. It does not hard-code these files at their final destinations for every component (e.g. some configs assume `~/dotfiles` and are linked manually), so review it before running.

```bash
# 1. clone the repo
git clone https://github.com/<you>/dotfiles ~/dotfiles
cd ~/dotfiles

# 2. run the bootstrap
./install.sh
```

`install.sh` detects `dnf` vs `apt`, then:

1. Installs prerequisites (`curl`, `git`, `vim`, `tmux`, `zsh`, `xclip`, powerline fonts).
2. Installs [nvm](https://github.com/nvm-sh/nvm) + the latest Node LTS if not already present.
3. Sets up tmux — clones [tpm](https://github.com/tmux-plugins/tpm), symlinks `tmux/.tmux.conf`, and installs all plugins.
4. Sets up vim — installs [vim-plug](https://github.com/junegunn/vim-plug), symlinks `vim/.vimrc`, and runs `:PlugInstall`.
5. Sets up zsh — installs [oh-my-zsh](https://ohmyz.sh), symlinks `zsh/.zshrc` + `zsh/.zsh_aliases`, and sets zsh as the login shell.

Symlinks are created with `sudo ln -s "$HOME/dotfiles/<component>..."`, so the repo stays the single source of truth.

## Contents

### Shell

- **zsh** (`zsh/`) — oh-my-zsh (`minimal` theme), completions, and `$PATH` additions for bun, grok, and devbox.
  - `zsh/.zsh_aliases` — aliases & helper functions: dotfiles/config shortcuts (`godot`, `zshr`, `als`, `zshc`, `vimc`, `tmc`), tmux helpers (`tm`, `tmk`), `notes` (daily note file + open in vim), the `ide` tmux workspace, git helpers (`gdff`, `gdc`), neovim background/colorscheme switchers (`nvb`, `nvc`, `nvd`, `nvl`), and CLI shortcuts (`cl` → claude, `oc` → opencode, `ghc` → GitHub Copilot, `gi` → Gemini CLI, `cr` → coderabbit).
- **fish** (`fish/`, `omf/`) — [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish) config: `bass`-sourced bash aliases, rbenv, and a custom prompt. `omf/bundle` lists the installed packages/themes (bass, foreign-env, nvm; robbyrussell theme).
- **aliases/** — plain `bash` alias files (`main`, `docker`, `git`) that fish sources via `bass`.

### Editors

- **vim** (`vim/.vimrc`) — vim-plug managed, bundled with a large plugin set (fugitive, coc.nvim, nerdtree, vimwiki, emmet, vim-blade, vim-startify, nerdcommenter) and many colorschemes (tokyonight, onedark, gruvbox, everforest, NeoSolarized, ...).
- **.SpaceVim.d/init.toml** — legacy [SpaceVim](https://spacevim.org) layer config.

### Terminal & windowing

- **ghostty** (`ghostty/`) — config (Ubuntu Mono Nerd Font, war2-dark theme, block cursor) plus a full set of gruvbox-material and war2 themes in `ghostty/themes/`.
- **alacritty** (`.alacritty.yml` at repo root).
- **windows-terminal** (`windows-terminal/.profile`) — WSL/Windows profile.
- **i3** (`i3/config`) — window-manager keybindings, workspace layout, status bar.
- **tmux** (`tmux/`) —
  - `.tmux.conf` — `C-a` prefix, `|`/`-` pane splits, mouse mode, vi keybindings, Wayland/X11-aware clipboard, catppuccin (mocha) status bar with weather/CPU/battery/date.
  - Plugins: tpm, tmux-sensible, tmux-yank, tmux-battery, tmux-cpu, tmux-weather, tmux-which-key, vim-tmux-navigator, catppuccin.
  - `layout-1.sh` — one-key tmux dev workspace: opens a `notes` window + a split `dev` window, kills other sessions first.
- **ranger** (`ranger/rc.conf`) — file-manager config.

### VS Code

- `vscode/settings.windows.json` — Windows-side settings (Solarized Dark, Operator Mono, Git Bash as the integrated shell).

### OpenCode (AI coding agent)

`opencode/` is a full [OpenCode](https://opencode.ai) setup:

- **`opencode/opencode.json`** — routes model traffic through an **OmniRoute** gateway (`localhost:20128`, key from `OMNIROUTE_API_KEY`) exposing a large model family (`auto/best-*`, `auto/coding:*`, `auto/chaos`, `auto/gemini`, `free-stack`, ...). Enables LSP, wires the `superpowers` + `oh-my-opencode-slim` plugins, and disables the built-in `explore`/`general` agents.
- **`opencode/tui.json`** — TUI theme (gruvbox) + the oh-my-opencode-slim plugin.
- **`opencode/oh-my-opencode-slim.json`** — preset for [oh-my-opencode-slim](https://unpkg.com/oh-my-opencode-slim) with a fleet of specialized agents (orchestrator, oracle, explorer, librarian, designer, fixer, observer), each pinned to specific models/temperatures, plus a configurable companion UI.
- **`opencode/plugins/`** — custom plugins:
  - `notification.js` — `notify-send` + sound on session completion.
  - `rtk.ts` — rewrites bash/shell commands through the [`rtk`](https://github.com/.../rtk) binary to save tokens (auto-disables if `rtk` isn't installed).
- **`opencode/commands/`** — slash commands: `COMMIT.md` (conventional-commit messages) and `PR_SUMMARY.md` (structured PR summaries).
- **`opencode/AGENTS.md`** — agent rules: prompt before fixing, TDD-first, prefer the `tdd`/`caveman` skills, security/performance-aware reviews.
- **`opencode/skills/`** — a large library of reusable, markdown-based agent skills, including: `caveman`, `tdd`, `code-reviewer`, `deepwork`, `verification-planning`, `simplify`, `worktrees`, `clonedeps`, `codemap`, `reflect`, `vim-reaper`, `grill-me`, `web-performance-optimization`, and a design family (`brand`, `banner-design`, `design`, `design-system`, `slides`, `ui-styling`, `ui-ux-pro-max`).
  - Each skill is a directory with a `SKILL.md` (YAML frontmatter + instructions) and optional `references/`, `scripts/`, `data/`, and `templates/`.

### Misc

- `.xsession` — X session startup.
- `aliases/` — shared bash aliases (see [Shell](#shell)).

## Project layout

```text
.
├── .alacritty.yml          # alacritty terminal config
├── .SpaceVim.d/init.toml   # legacy SpaceVim layers
├── .xsession               # X session startup
├── aliases/                # bash aliases (main, docker, git)
├── fish/                   # fish shell config (conf.d, functions)
├── ghostty/                # ghostty terminal + gruvbox-material/war2 themes
├── i3/                     # i3 window manager
├── install.sh              # bootstrap installer
├── omf/                    # Oh My Fish packages/themes
├── opencode/               # OpenCode AI agent: config, plugins, commands, skills
├── ranger/                 # ranger file manager
├── tmux/                   # tmux config + dev-workspace script
├── vim/                    # vimrc + vim-plug setup
├── vscode/                 # VS Code settings (Windows)
├── windows-terminal/       # Windows Terminal profile
└── zsh/                    # zshrc + zsh aliases
```
