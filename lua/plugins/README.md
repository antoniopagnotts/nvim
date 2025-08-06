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

### ⚙️ Configuration Details

Inside the `nvim-cmp` setup function:

```lua
local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})
```

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

## 🎨 `catpuccin.lua`: Theme Setup

This file configures the [Catppuccin](https://github.com/catppuccin/nvim) color scheme for Neovim using `lazy.nvim`.

### ⚙️ Explanation

- **Repository**: `catppuccin/nvim` - the Catppuccin theme plugin.
- **lazy = false**: Load the theme immediately on startup (no lazy loading).
- **name = "catppuccin"**: Assigns a friendly i

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

#### ⚙️ Setup

The plugin is initialized with the default config:

```lua
require("gitsigns").setup()
```

> You can expand this later with custom keybindings, blame format, or sign icons.
