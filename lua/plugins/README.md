## 🔀 `gitsigns.lua`: Git Integration

This file sets up Git integration in Neovim using two powerful plugins:

### 📦 Plugins

```lua
{
  "tpope/vim-fugitive"
},
{
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()
  end,
}
```

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
