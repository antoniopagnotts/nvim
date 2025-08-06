## 🎨 `catpuccin.lua`: Theme Setup

This file configures the [Catppuccin](https://github.com/catppuccin/nvim) color scheme for Neovim using `lazy.nvim`.

### ⚙️ Explanation

- **Repository**: `catppuccin/nvim` - the Catppuccin theme plugin.
- **lazy = false**: Load the theme immediately on startup (no lazy loading).
- **name = "catppuccin"**: Assigns a friendly i

---

## ⚡ `completions.lua`: Autocompletion Setup

This file configures a complete autocompletion system for Neovim, integrating Language Server Protocol (LSP) completions, snippets, and buffer completions using several plugins.

---

### 🧩 Plugin Roles

- **`hrsh7th/cmp-nvim-lsp`**: Enables LSP-based completion sources for `nvim-cmp`.
- **`L3MON4D3/LuaSnip`**: Snippet engine.
  - Depends on:
    - `saadparwaiz1/cmp_luasnip`: Integrates LuaSnip with `nvim-cmp`.
    - `rafamadriz/friendly-snippets`: Collection of ready-to-use snippets.
- **`hrsh7th/nvim-cmp`**: Core completion engine for Neovim.

---

### 🔑 Key Mappings Explanation

| Key          | Action                                     | Description                                         |
|--------------|--------------------------------------------|-----------------------------------------------------|
| `<C-b>`      | Scroll documentation **up**                | Scrolls up 4 lines in the completion docs popup     |
| `<C-f>`      | Scroll documentation **down**              | Scrolls down 4 lines in the completion docs popup   |
| `<C-Space>`  | Trigger completion menu                     | Opens the completion suggestions menu               |
| `<C-e>`      | Abort completion                            | Closes the completion popup without selecting       |
| `<CR>`       | Confirm selection                           | Confirms the currently selected completion item (or first if none selected) |

---

### 🔍 Completion Sources

- `nvim_lsp`: Language Server Protocol completions.
- `luasnip`: Snippet completions from LuaSnip.
- `buffer`: Word completions from the current buffer.

---

### 💡 Summary

This setup combines LSP-powered completion, snippet expansion, and buffer completions into a smooth and user-friendly autocompletion experience. It also includes bordered windows for better UI and intuitive keybindings for easy navigation and selection.

---

## 🔀 `gitsigns.lua`: Git Integration

This file sets up Git integration in Neovim using two powerful plugins:

---

### 🧙‍♂️ `vim-fugitive`

[`vim-fugitive`](https://github.com/tpope/vim-fugitive) is a Git wrapper for Neovim, enabling you to run Git commands directly within the editor.

#### 💡 Common Commands

- `:Git` — Run Git commands (`:Git status`, `:Git commit`, `:Git push`, etc.)
- `:Gdiffsplit` — Show Git diff in a vertical split.
- `:Gblame` — Display `git blame` output for the current file.
- `:Glog` — View Git log (commit history).

---

### 🔍 `gitsigns.nvim`

[`gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim) provides inline Git indicators and utilities using native Lua. It’s fast, customizable, and works well with modern Neovim setups.

#### 🚀 Features

- 📌 Adds Git signs in the **sign column**:
  - `+` → Added lines
  - `~` → Modified lines
  - `-` → Deleted lines
- 🔁 Hunk staging/reset from within Neovim
- 👀 Preview diffs in a floating window
- 🧾 Inline Git blame for each line
- ⚡ Live updates with no noticeable performance hit

---

## 🔀 `git-stuff.lua`: Git Integration with Keybindings

This file provides Git functionality in Neovim using two essential plugins and defines custom key mappings for quick access to Git actions.

---

### 🧙‍♂️ Plugins

- **`tpope/vim-fugitive`**  
  A legendary Git wrapper for Neovim that enables you to execute Git commands directly inside the editor (e.g., `:Git`, `:Gblame`, `:Gdiffsplit`).

- **`lewis6991/gitsigns.nvim`**  
  Displays Git changes in the sign column (gutter), including added, changed, and deleted lines. Also supports staging hunks, previewing diffs, and inline Git blame.

---

### 🔑 Key Mappings Explanation

| Key Combination | Mode   | Command                                | Description                                                                          |
|-----------------|--------|----------------------------------------|--------------------------------------------------------------------------------------|
| `<leader>gp`    | Normal | `:Gitsigns preview_hunk<CR>`           | Preview the current Git hunk (diff) in a floating window.                           |
| `<leader>gt`    | Normal | `:Gitsigns toggle_current_line_blame<CR>` | Toggle inline Git blame annotation for the current line.                            |

---

### 💡 Summary

This plugin setup offers a seamless Git experience inside Neovim — combining command-line-level power with visual inline indicators and handy key mappings.

---


## ⚙️ `lsp-config.lua`: Full Language Server Protocol (LSP) Setup

This plugin configuration sets up Neovim's LSP ecosystem with automatic server management, language-specific server setups, and useful keybindings for developer productivity.

---

### 🧩 Plugins Used

- **`williamboman/mason.nvim`**  
  A package manager for managing external LSP servers, formatters, and linters within Neovim.

- **`williamboman/mason-lspconfig.nvim`**  
  Bridges Mason with `nvim-lspconfig`, automating the setup of LSP servers.

- **`neovim/nvim-lspconfig`**  
  Core LSP configuration plugin that provides easy setup for dozens of language servers.

---

### 🔧 Configuration Overview

#### 🔨 Mason Setup

```lua
require("mason").setup()
```

Initializes the Mason UI.

#### 🔁 Mason-LSPConfig Setup

```lua
opts = {
  auto_install = true,
}
```

Automatically installs LSP servers when configured through `lspconfig`.

---

### 🧠 Language Servers Configured

All servers are initialized with enhanced capabilities via `cmp_nvim_lsp` for completion integration:

```lua
local capabilities = require('cmp_nvim_lsp').default_capabilities()
```

#### 🌐 Language Server List

| Language/Tool       | Server Name   | Notes |
|---------------------|---------------|-------|
| Angular             | `angularls`   | Uses custom `cmd` configuration for Angular CLI |
| Emmet (HTML/CSS)    | `emmet_ls`    | Provides rapid HTML/CSS/JSX snippets |
| TypeScript/JavaScript | `tsserver`  | Default server for JS/TS |
| HTML                | `html`        | Basic HTML support |
| CSS                 | `cssls`       | Stylesheet support |
| JSON                | `jsonls`      | JSON schema-aware support |
| YAML                | `yamlls`      | YAML language support |
| Go                  | `gopls`       | Go Language Server |
| Lua                 | `lua_ls`      | Lua support with proper Neovim config awareness |

---

### 🔑 Key Mappings

| Key Combination | Mode   | Command                      | Description                                           |
|-----------------|--------|------------------------------|-------------------------------------------------------|
| `K`             | Normal | `vim.lsp.buf.hover`          | Show documentation or type info for symbol under cursor |
| `<leader>gd`    | Normal | `vim.lsp.buf.definition`     | Jump to the definition of the symbol                 |
| `<leader>gr`    | Normal | `vim.lsp.buf.references`     | List references to the symbol under the cursor       |
| `<leader>ca`    | Normal | `vim.lsp.buf.code_action`    | Show available code actions (refactors, fixes, etc.) |

---

### 💡 Summary

This configuration provides a powerful development environment in Neovim with:

- Automated LSP server installation and setup
- Integration with autocompletion (`cmp`)
- Angular, Go, Lua, HTML, CSS, JSON, YAML, Emmet support
- Handy key mappings for common LSP actions

---

## 🗂️ `neo-tree.lua`: File Explorer & Buffer Tree

This plugin sets up [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim), a modern and extensible file explorer and buffer viewer for Neovim.

---

### 🧩 Plugin Details

- **`nvim-neo-tree/neo-tree.nvim`**  
  A tree-based file explorer for Neovim.
- **Branch**: `v3.x` — specifies use of the stable v3 version.

#### 🔗 Dependencies

| Plugin | Purpose |
|--------|---------|
| `nvim-lua/plenary.nvim` | Utility functions required by many plugins |
| `nvim-tree/nvim-web-devicons` | Adds file icons |
| `MunifTanjim/nui.nvim` | UI components used by Neo-tree |

---

### 🔑 Key Mappings

| Key Combination | Mode   | Command                                             | Description                               |
|-----------------|--------|-----------------------------------------------------|-------------------------------------------|
| `<C-n>`         | Normal | `:Neotree filesystem reveal left<CR>`              | Open the file system explorer on the left |
| `<leader>bf`    | Normal | `:Neotree buffers reveal float<CR>`                | Open the buffer list in a floating window |

> 💡 Tip: `<C-n>` means you press `Control` + `n`.  

---

### 💡 Summary

Neo-tree offers:

- A slick interface for browsing files and open buffers
- Floating or sidebar views
- Rich icon and UI integration via dependencies
- Fast keyboard navigation for switching and managing files

---

## 🧹 `none-ls.lua`: Linting & Formatting with `null-ls`

This plugin configures [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim) (formerly `null-ls`) to bring external tools like linters and formatters into Neovim's built-in LSP client.

---

### 🧩 Plugin Details

- **`nvimtools/none-ls.nvim`**  
  Provides integration of external formatters/linters into Neovim’s LSP ecosystem.

---

### ⚙️ Configured Sources

The setup includes tools categorized by language and purpose:

#### 🔹 Lua
- `stylua`: Formats Lua code.

#### 🔹 JavaScript / TypeScript / Web
- `prettier`: Formats JS, TS, JSON, YAML, CSS, HTML, Markdown.
- `eslint_d`: Lints and formats JS/TS with fast ESLint daemon.

#### 🔹 YAML
- `yamllint`: Lints YAML files.

#### 🔹 JSON
- `jsonlint`: Lints JSON files.

#### 🔹 Go
- `gofmt`: Formats Go code using Go's standard formatter.
- `goimports`: Formats Go code and manages import statements.
- `golangci_lint`: Runs static analysis via [golangci-lint](https://golangci-lint.run/).

```lua
null_ls.setup({
  sources = {
    formatting.stylua,
    formatting.prettier.with({
      filetypes = {
        "javascript", "typescript", "json", "yaml", "css", "html", "markdown",
      },
    }),
    diagnostics.eslint_d,
    formatting.eslint_d,
    diagnostics.yamllint,
    diagnostics.jsonlint,
    formatting.gofmt,
    formatting.goimports,
    diagnostics.golangci_lint,
  },
})
```

---

### 🔑 Key Mapping

| Key Combination | Mode   | Command                   | Description                        |
|-----------------|--------|---------------------------|------------------------------------|
| `<leader>gf`    | Normal | `vim.lsp.buf.format()`    | Format the current buffer using the appropriate formatter |

> 💡 `<leader>` is typically mapped to `<Space>`.

---

### ✅ Summary

With this configuration, your Neovim is equipped for automatic linting and formatting across many languages — including Lua, JS/TS, YAML, JSON, Go, and more — all powered by fast CLI tools and accessible with one key binding.

---

## 🔁 `nvim-tmux-navigation.lua`: Seamless Navigation Between Neovim & Tmux

This plugin integrates Neovim with [tmux](https://github.com/tmux/tmux), allowing you to move between Neovim splits and tmux panes using the same intuitive keybindings.

---

### 🧩 Plugin Details

- **`alexghergh/nvim-tmux-navigation`**  
  Enables directional navigation between Neovim and tmux windows.

---

### ⚙️ Configuration

The plugin is initialized with:

```lua
require('nvim-tmux-navigation').setup({})
```

This sets up the plugin with default behavior.

---

### 🔑 Key Mappings

| Key Combination | Mode   | Command                       | Description                        |
|-----------------|--------|-------------------------------|------------------------------------|
| `<C-h>`         | Normal | `NvimTmuxNavigateLeft`        | Move to the pane on the **left**   |
| `<C-j>`         | Normal | `NvimTmuxNavigateDown`        | Move to the **bottom** pane        |
| `<C-k>`         | Normal | `NvimTmuxNavigateUp`          | Move to the **top** pane           |
| `<C-l>`         | Normal | `NvimTmuxNavigateRight`       | Move to the pane on the **right**  |

> 💡 `<C-h>` means press `Control` + `h`.  
> These mappings work **across Neovim splits and tmux panes** seamlessly.

---

### 🚀 Summary

This setup is perfect for users working in a tmux + Neovim environment who want **unified navigation controls**. No need to think about whether you're inside Neovim or tmux — the movement keys work the same!

---

## 📁 `oil.lua`: File Explorer as a Buffer

This plugin provides a **modern, minimal file explorer** for Neovim that opens in a buffer or floating window — designed to feel like you're editing a file, not using a separate UI.

---

### 🧩 Plugin Details

- **`stevearc/oil.nvim`**  
  A simple, buffer-based file explorer that integrates directly into the Neovim workflow.

---

### ⚙️ Configuration

```lua
local oil = require("oil")
oil.setup()
```

This loads and sets up the plugin with its default settings.

---

### 🔑 Key Mappings

| Key Combination | Mode   | Command            | Description                                |
|-----------------|--------|--------------------|--------------------------------------------|
| `-`             | Normal | `oil.toggle_float` | Toggle the file explorer in a **floating** window |

> 💡 Pressing `-` opens the file explorer at the current file's directory in a floating window.

---

### 🚀 Summary

`oil.nvim` gives you a **minimalist alternative to tree-style file explorers**, focusing on fast navigation and editing. It's ideal for users who prefer an inline, buffer-like feel over sidebar tools.

---

## 📄 `swagger-preview.lua`: Live Preview for Swagger/OpenAPI Docs

This plugin allows you to **preview Swagger (OpenAPI) documentation** directly in your browser from within Neovim. It watches your Swagger files and provides a live reload experience.

---

### 🧩 Plugin Details

- **`vinnymeller/swagger-preview.nvim`**  
  Enables live Swagger UI previews for `.json` or `.yaml` OpenAPI files.

- **Build Requirement**:  
  Installs the `swagger-ui-watcher` globally via npm:
  ```bash
  npm install -g swagger-ui-watcher
  ```

  > 💡 Make sure Node.js and npm are installed on your system.

---

### ⚙️ Configuration

```lua
config = true
```

This loads the plugin with its default configuration. You can customize it by replacing `config = true` with a configuration table if needed.

---

### 🚀 Usage

To start the preview:

```vim
:SwaggerPreview
```

This opens the Swagger UI in your default browser and watches the OpenAPI file for changes. On save, the browser auto-refreshes.

To stop the preview:

```vim
:SwaggerPreviewStop
```

---

### ✅ Summary

`swagger-preview.nvim` is a **great companion for backend and API developers** who work with OpenAPI specs. It lets you preview and iterate your API documentation live without leaving Neovim.

---

## 🔭 `telescope.nvim`: Fuzzy Finder and More

`Telescope.nvim` is a **highly extendable fuzzy finder** for Neovim that helps you quickly find files, perform live grep searches, browse recent files, and much more — all powered by Lua.

---

### 🧩 Plugin Details

- **`nvim-telescope/telescope.nvim`**  
  The main plugin that provides a framework for fuzzy finding.

- **`nvim-telescope/telescope-ui-select.nvim`**  
  Extension to replace some default Neovim selection UIs (like `vim.ui.select`) with Telescope-powered dropdowns.

- **`nvim-lua/plenary.nvim`**  
  A dependency that provides useful Lua functions required by Telescope.

---

### ⚙️ Configuration

```lua
require("telescope").setup({
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})
```

This setup:
- Configures Telescope.
- Enables and customizes the `ui-select` extension to use a dropdown UI.

Telescope extensions must be explicitly loaded:
```lua
require("telescope").load_extension("ui-select")
```

---

### 🔑 Key Mappings

| Key Combination     | Mode   | Telescope Function    | Description                        |
|---------------------|--------|------------------------|------------------------------------|
| `<C-p>`             | Normal | `find_files`           | Find files in the current project  |
| `<leader>fg`        | Normal | `live_grep`            | Search text across project files   |
| `<leader><leader>`  | Normal | `oldfiles`             | Open recently used files           |

---

### 🚀 Summary

With `telescope.nvim`, you get a **powerful and extensible fuzzy finder** that greatly enhances your navigation and search workflows in Neovim. Combined with `ui-select`, it also integrates seamlessly with built-in selection menus.

---

## 🌳 `nvim-treesitter`: Syntax Highlighting and Code Parsing

`nvim-treesitter` is a **Neovim plugin for better syntax highlighting, code folding, and more**, powered by [Tree-sitter](https://tree-sitter.github.io/), a fast incremental parsing system.

---

### 🧩 Plugin Details

- **`nvim-treesitter/nvim-treesitter`**  
  Provides advanced syntax highlighting and code-aware features using the Tree-sitter parsing engine.

- **Build Step**:  
  Runs `:TSUpdate` automatically after installation to ensure all installed parsers are up to date.

---

### ⚙️ Configuration

```lua
require("nvim-treesitter.configs").setup({
  auto_install = true,       -- Automatically install missing parsers
  highlight = { enable = true },  -- Enables Tree-sitter-based syntax highlighting
  indent = { enable = true },     -- Enables Tree-sitter-based indentation
})
```

- **`auto_install = true`**: When opening a file with an unsupported language, Tree-sitter will attempt to install the parser automatically.
- **`highlight.enable = true`**: Enables more accurate, performant syntax highlighting compared to traditional regex-based methods.
- **`indent.enable = true`**: Uses Tree-sitter’s structural understanding of code for better auto-indentation.

---

### ✅ Summary

With `nvim-treesitter`, your Neovim becomes **smarter and more language-aware**. It delivers rich syntax highlighting and smart indentation, helping you better understand and navigate code with precision.

---

## 🧪 `vim-test`: Unified Testing Interface for Neovim

This plugin setup integrates **[vim-test](https://github.com/vim-test/vim-test)** with **[vimux](https://github.com/preservim/vimux)** to run tests directly from within Neovim and display results in a split terminal or Tmux pane.

---

### 🧩 Plugin Details

- **`vim-test/vim-test`**  
  A powerful testing plugin that supports many languages and frameworks.
  
- **`preservim/vimux`**  
  Used to run test output inside a Tmux pane using the `vimux` strategy.

---

### ⚙️ Configuration

```lua
vim.cmd("let test#strategy = 'vimux'")
```

This line sets the strategy to use **Tmux** as the output window for running tests, keeping your workflow seamless within Neovim + Tmux.

---

### ⌨️ Key Mappings

| Keybinding      | Command            | Description                          |
|-----------------|--------------------|--------------------------------------|
| `<leader>t`     | `:TestNearest`     | Run the test nearest to the cursor   |
| `<leader>T`     | `:TestFile`        | Run all tests in the current file    |
| `<leader>a`     | `:TestSuite`       | Run the entire test suite            |
| `<leader>l`     | `:TestLast`        | Rerun the last executed test         |
| `<leader>g`     | `:TestVisit`       | Reopen the last test file            |

> 💡 These mappings allow you to quickly run tests and see results **without leaving Neovim**.

---

### ✅ Summary

With `vim-test` and `vimux`, you get a **robust and flexible testing setup** integrated into your Neovim + Tmux workflow. Easily test individual functions, files, or entire suites and view results live in a Tmux pane.
