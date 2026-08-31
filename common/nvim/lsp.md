# How LSP works in this config

LSP feels complicated because what looks like one feature is actually several plugins cooperating. This file untangles them.

---

## 1. What is LSP, really?

LSP is just a **protocol** — a JSON message format spoken between two processes:

```mermaid
sequenceDiagram
    participant nvim as nvim (client)
    participant server as gopls (server)
    nvim->>server: "what's at line 12, col 4?"
    server-->>nvim: "type: func(int) error"
    nvim->>server: "rename `foo` to `bar` across project"
    server-->>nvim: "edits: [file1.go:12, file2.go:48, ...]"
```

The **server** is a separate executable per language (`gopls`, `lua-language-server`, `rust-analyzer`, etc.).
It parses your code, keeps an in-memory index, and answers questions about it.

The **client** is nvim itself.
nvim has LSP support built in — it knows how to speak the protocol natively (since v0.5+).

---

## 2. The piece nvim doesn't give you

nvim's built-in LSP client needs to know:

- **Where the server binary lives** on disk
- **What command to launch it with**
- **Which filetypes** to attach it to
- **What workspace settings** it expects

You could write all this yourself (it's a few lines per server).
Most people don't, because someone already did, in **nvim-lspconfig**.

```mermaid
flowchart TD
    A[nvim-lspconfig<br/>preset configs for 300+ servers] -->|registers| B[vim.lsp.config&lpar;name&rpar;<br/>nvim's built-in registry]
    B -->|attaches on filetype| C[vim.lsp.enable&lpar;name&rpar;]
```

nvim-lspconfig is a giant lookup table.
It registers configs with nvim under names like `gopls`, `lua_ls`, `ts_ls`.
You then call `vim.lsp.enable("gopls")` and nvim attaches it on the right filetypes.

---

## 3. But how do the *server binaries* get installed?

Each LSP server is a separate program.
`gopls` is a Go binary; `lua-language-server` is a Lua/C++ project; `rust-analyzer` is a massive Rust binary.
You'd normally install each via `brew install`, `go install`, `cargo install`, `npm i -g`, etc.

That's tedious and inconsistent.
**mason.nvim** solves it: it's a package manager that installs LSP servers (plus formatters and linters) into a single directory nvim already knows about (`~/.local/share/nvim/mason/`).

```mermaid
flowchart LR
    M[mason.nvim] -->|installs into| D["~/.local/share/nvim/mason/bin/"]
    D --> g[gopls]
    D --> l[lua-language-server]
    D --> s[stylua]
    D --> sc[shellcheck]
    D --> etc[...]
```

This directory is on nvim's PATH, so `vim.lsp.enable("gopls")` just finds the binary.

---

## 4. The bridge: mason-lspconfig

mason knows binaries.
nvim-lspconfig knows configs.
They use different naming (`lua-language-server` vs `lua_ls`).

**mason-lspconfig.nvim** bridges them:

```mermaid
flowchart LR
    subgraph ML[mason-lspconfig]
        direction LR
        M["mason name<br/>lua-language-server"] -.translates.-> L["lspconfig name<br/>lua_ls"]
    end
    ensure["ensure_installed = { lua_ls, gopls, ... }"] --> ML
    ML -->|installs missing| Mason[mason.nvim]
    ML -->|enables| LSP[vim.lsp.enable]
```

In our config:

```lua
require("mason-lspconfig").setup({
  ensure_installed = { "gopls", "lua_ls", ... },
  automatic_enable = true,
})
```

This does two things:

1. **Installs** any listed server that's missing (via mason)
2. **Enables** them with nvim (via `vim.lsp.enable()`)

So one line per server in `ensure_installed` is all you need.

---

## 5. Putting it together: what happens when you open `foo.go`

```mermaid
sequenceDiagram
    actor you
    participant nvim
    participant mlsp as mason-lspconfig
    participant gopls

    Note over mlsp: at startup
    mlsp->>nvim: vim.lsp.enable("gopls")

    you->>nvim: :edit foo.go
    nvim->>nvim: detect filetype = "go"
    nvim->>gopls: spawn ~/.local/share/nvim/mason/bin/gopls
    nvim->>gopls: initialize (LSP handshake)
    gopls-->>nvim: capabilities response
    gopls->>gopls: index workspace (slow on first open)
    gopls-->>nvim: publishDiagnostics
    Note over nvim,gopls: hover, completion, goto-def<br/>now flow over the LSP channel
```

You can confirm the server is attached with `:LspInfo`.

---

## 6. LSP ≠ formatting ≠ linting

LSP gives you **interactive intelligence**: hover, diagnostics, goto-def, rename, completion.

But many things people lump under "LSP" actually aren't:

| What you want    | LSP? | Plugin               | How it works            |
| ---------------- | ---- | -------------------- | ----------------------- |
| Hover, diagnostics, goto-def, rename | yes  | nvim-lspconfig + LSP server | LSP protocol |
| Completion menu  | yes (uses LSP) | blink.cmp     | LSP + extra sources |
| Format on save   | no   | conform.nvim         | Runs CLI: `gofmt`, `prettier`, ... |
| Inline lint warnings (extra rules) | no   | nvim-lint | Runs CLI: `golangci-lint`, `eslint_d`, ... |
| `vim.*` autocomplete in Lua | no | lazydev.nvim | Library injection for lua_ls |

Formatters and linters are **separate CLI tools** that nvim shells out to.
They have nothing to do with LSP. mason installs them too, which is why it all *feels* like one system.

---

## 7. The full picture in this config

```mermaid
flowchart TB
    subgraph nvim["nvim"]
        LSPClient["Built-in LSP client"]
        Blink["blink.cmp<br/>(completion)"]
        Conform["conform.nvim<br/>(formatting)"]
        Lint["nvim-lint<br/>(linting)"]
        Lazydev["lazydev.nvim<br/>(Lua API injection<br/>for lua_ls)"]
    end

    subgraph Servers["LSP servers (separate processes)"]
        gopls
        ts_ls
        lua_ls
        rust_analyzer["rust-analyzer"]
        more["..."]
    end

    subgraph MasonStack["mason ecosystem"]
        Mason["mason.nvim<br/>(binary installer)"]
        MLsp["mason-lspconfig<br/>(servers)"]
        MTool["mason-tool-installer<br/>(formatters/linters)"]
    end

    LSPClient <-->|LSP protocol| Servers
    Blink -->|capabilities| LSPClient
    Blink -.suggestions.-> LSPClient
    Conform -->|shells out to| Formatters["gofmt, stylua,<br/>prettier, ..."]
    Lint -->|shells out to| Linters["golangci-lint,<br/>eslint_d, ..."]
    Lazydev -->|library config| lua_ls

    Mason -->|installs| Servers
    Mason -->|installs| Formatters
    Mason -->|installs| Linters
    MLsp -->|drives| Mason
    MTool -->|drives| Mason
```

Each plugin has one job:

- **nvim-lspconfig** — preset configs for LSP servers
- **mason.nvim** — installs server/formatter/linter binaries
- **mason-lspconfig** — bridges mason naming ↔ lspconfig naming, and auto-enables installed servers
- **mason-tool-installer** — same as ensure_installed, but for non-LSP tools (formatters, linters)
- **blink.cmp** — completion menu; pulls suggestions from LSP and other sources
- **conform.nvim** — orchestrates formatters on save
- **nvim-lint** — runs linters on save / on InsertLeave
- **lazydev.nvim** — tells `lua_ls` where to find nvim's Lua API and plugin sources so editing this config gives proper completions

---

## 8. Useful commands

| Command          | What it shows                                    |
| ---------------- | ------------------------------------------------ |
| `:LspInfo`       | Which LSP servers are attached to current buffer |
| `:Mason`         | UI to view/install/uninstall mason packages      |
| `:ConformInfo`   | Which formatter conform will run for this file   |
| `:checkhealth`   | Nvim health report (LSP, treesitter, etc.)       |
| `K`              | Hover docs for symbol under cursor               |
| `gd`             | Goto definition                                  |
| `grr`            | List references                                  |
| `grn`            | Rename symbol (project-wide via LSP)             |
| `gra`            | Code actions                                     |
| `]d` / `[d`      | Next/prev diagnostic                             |
| `<C-s>` (insert) | Signature help                                   |
| `<C-y>` (insert) | Accept completion                                |
| `<C-space>` (insert) | Open completion / docs                       |

---

## 9. Troubleshooting

**A server isn't attaching:**

1. `:LspInfo` — is the server listed? If not, mason-lspconfig didn't enable it.
2. `:Mason` — is the binary installed?
3. `:checkhealth vim.lsp` — config errors here.

**Diagnostics seem wrong / outdated:** restart the server with `:LspRestart`.

**Completion isn't appearing:** check `:ConformInfo` isn't blocking (format-on-save eating keystrokes), and that blink.cmp's Rust build succeeded — `:checkhealth blink.cmp`.

**Lua `vim.*` shows as undefined:** lazydev should fix this.
If it doesn't, `:LazyDev` to inspect what library paths it injected.
