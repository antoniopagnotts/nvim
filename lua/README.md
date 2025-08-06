## ⚙️ Neovim Basic Settings & Keymaps

This Lua snippet configures **Neovim editor behavior**, **leader key**, **UI preferences**, and **pane navigation shortcuts** to improve usability and ergonomics.

---

### 🛠 Editor Settings

```lua
vim.cmd("set expandtab")        -- Use spaces instead of tabs
vim.cmd("set tabstop=2")        -- Number of spaces that a <Tab> in the file counts for
vim.cmd("set softtabstop=2")    -- Number of spaces inserted/deleted when pressing <Tab>/<BS>
vim.cmd("set shiftwidth=2")     -- Number of spaces for auto-indenting
vim.opt.swapfile = false        -- Disable swap file creation
```

These settings enforce **2-space indentation using spaces** and **disable swap files** for a cleaner workflow.

---

### 🌈 UI Preferences

```lua
vim.g.mapleader = " "           -- Set the <leader> key to space
vim.g.background = "light"      -- Use a light background theme
vim.wo.number = true            -- Enable line numbers
```

Sets up visual preferences, like **line numbering** and **light color scheme**, and assigns the **spacebar as the leader key** for custom mappings.

---

### 🔁 Pane Navigation Keybindings

```lua
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')  -- Move to pane above
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')  -- Move to pane below
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')  -- Move to left pane
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')  -- Move to right pane
```

| Keybinding | Action                |
|------------|------------------------|
| `<C-k>`    | Move to upper pane     |
| `<C-j>`    | Move to lower pane     |
| `<C-h>`    | Move to left pane      |
| `<C-l>`    | Move to right pane     |

Makes pane navigation in split windows **faster and more intuitive**.

---

### 🔍 Additional Mapping

```lua
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
```

| Keybinding   | Action               |
|--------------|----------------------|
| `<leader>h`  | Clear search highlight |

Lets you clear search highlights **quickly** using `<leader>h`.

---

### ✅ Summary

This configuration improves:
- **Indentation consistency**
- **Pane navigation**
- **Search UX**
- **Visual clarity**
- And sets a solid foundation for further customization.
