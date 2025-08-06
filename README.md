## All the commands

| Key          | Action                                     | Description                                         |
|--------------|--------------------------------------------|-----------------------------------------------------|
| `<C-b>`      | Scroll documentation **up**                | Scrolls up 4 lines in the completion docs popup     |
| `<C-f>`      | Scroll documentation **down**              | Scrolls down 4 lines in the completion docs popup   |
| `<C-Space>`  | Trigger completion menu                     | Opens the completion suggestions menu               |
| `<C-e>`      | Abort completion                            | Closes the completion popup without selecting       |
| `<CR>`       | Confirm selection                           | Confirms the currently selected completion item (or first if none selected) |

---

| Key Combination | Mode   | Command                                | Description                                                                          |
|-----------------|--------|----------------------------------------|--------------------------------------------------------------------------------------|
| `<leader>gp`    | Normal | `:Gitsigns preview_hunk<CR>`           | Preview the current Git hunk (diff) in a floating window.                           |
| `<leader>gt`    | Normal | `:Gitsigns toggle_current_line_blame<CR>` | Toggle inline Git blame annotation for the current line.                            |

---

| Key Combination | Mode   | Command                      | Description                                           |
|-----------------|--------|------------------------------|-------------------------------------------------------|
| `K`             | Normal | `vim.lsp.buf.hover`          | Show documentation or type info for symbol under cursor |
| `<leader>gd`    | Normal | `vim.lsp.buf.definition`     | Jump to the definition of the symbol                 |
| `<leader>gr`    | Normal | `vim.lsp.buf.references`     | List references to the symbol under the cursor       |
| `<leader>ca`    | Normal | `vim.lsp.buf.code_action`    | Show available code actions (refactors, fixes, etc.) |

---

| Key Combination | Mode   | Command                                             | Description                               |
|-----------------|--------|-----------------------------------------------------|-------------------------------------------|
| `<C-n>`         | Normal | `:Neotree filesystem reveal left<CR>`              | Open the file system explorer on the left |
| `<leader>bf`    | Normal | `:Neotree buffers reveal float<CR>`                | Open the buffer list in a floating window |

---

| Key Combination | Mode   | Command                   | Description                        |
|-----------------|--------|---------------------------|------------------------------------|
| `<leader>gf`    | Normal | `vim.lsp.buf.format()`    | Format the current buffer using the appropriate formatter |

---

| Key Combination | Mode   | Command                       | Description                        |
|-----------------|--------|-------------------------------|------------------------------------|
| `<C-h>`         | Normal | `NvimTmuxNavigateLeft`        | Move to the pane on the **left**   |
| `<C-j>`         | Normal | `NvimTmuxNavigateDown`        | Move to the **bottom** pane        |
| `<C-k>`         | Normal | `NvimTmuxNavigateUp`          | Move to the **top** pane           |
| `<C-l>`         | Normal | `NvimTmuxNavigateRight`       | Move to the pane on the **right**  |

---

| Key Combination | Mode   | Command            | Description                                |
|-----------------|--------|--------------------|--------------------------------------------|
| `-`             | Normal | `oil.toggle_float` | Toggle the file explorer in a **floating** window |

---

| Key Combination     | Mode   | Telescope Function    | Description                        |
|---------------------|--------|------------------------|------------------------------------|
| `<C-p>`             | Normal | `find_files`           | Find files in the current project  |
| `<leader>fg`        | Normal | `live_grep`            | Search text across project files   |
| `<leader><leader>`  | Normal | `oldfiles`             | Open recently used files           |

---

| Keybinding      | Command            | Description                          |
|-----------------|--------------------|--------------------------------------|
| `<leader>t`     | `:TestNearest`     | Run the test nearest to the cursor   |
| `<leader>T`     | `:TestFile`        | Run all tests in the current file    |
| `<leader>a`     | `:TestSuite`       | Run the entire test suite            |
| `<leader>l`     | `:TestLast`        | Rerun the last executed test         |
| `<leader>g`     | `:TestVisit`       | Reopen the last test file            |
