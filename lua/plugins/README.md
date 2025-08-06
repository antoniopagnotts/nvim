# 🔀 gitsigns.lua: Git Integration
This file provides Git integration features inside Neovim using two plugins:

## 🔧 Features
### 🧙‍♂️ vim-fugitive
Powerful Git wrapper for Neovim.

Useful commands:

- **:Git**: Run Git commands like :Git status, :Git commit, :Git push, etc.

- **:Gdiffsplit**: View diff in split window.

- **:Gblame**: Git blame in vertical split.

- **:Glog**: View Git commit log.

### 🔍 gitsigns.nvim
Adds Git change indicators (signs) in the sign column:

- \+ → added lines

- \~ → modified lines

- \- → removed lines

Lightweight and fast thanks to native Lua implementation.

Also supports:

- Inline Git blame

- Stage/reset hunks or buffer

- Preview diffs in a floating window

- Live line blame

This file loads gitsigns.nvim with its default settings. You can customize it further by adding keymaps or tweaking the appearance in the setup() block.
