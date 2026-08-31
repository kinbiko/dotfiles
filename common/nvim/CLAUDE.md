# nvim — personal config

Single-file Neovim config (`init.lua`), plugin-managed by `lazy.nvim` (self-bootstrapping, see top of `init.lua`). `lazy-lock.json` pins plugin versions — don't hand-edit it, let lazy.nvim manage it.

## Layout

- `init.lua` — everything: options, keymaps, and the full `lazy.nvim` plugin spec.
- `lsp.md` — explainer of how LSP/mason/formatting/linting fit together in this config. Read this before touching LSP-related setup.
- `lazy-lock.json` — plugin version lockfile.

## Keybinding conventions

- Leader is `<space>`.
- LSP/refactor/build/lint actions live under a `<leader>c<x>` prefix via the `code_map` helper in `init.lua`.
- File/finder actions (Snacks picker, alternate file, rename file) live under `<leader>f<x>`.
- When adding a new keybinding, match the existing prefix convention instead of inventing a new one.

## Notes

- Formatting (`conform.nvim`) and linting (`nvim-lint`) are separate from LSP — see `lsp.md` §6 for why they're easy to conflate.
- LSP servers, formatters, and linters are all installed via `mason.nvim` into `~/.local/share/nvim/mason/`.
