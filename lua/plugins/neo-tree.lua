return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,   -- so `nvim .` opens the tree
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>",       desc = "Explorer toggle" },
    { "<leader>E", "<cmd>Neotree reveal<cr>",       desc = "Explorer: reveal current file" },
  },
  opts = {
    close_if_last_window = true,
    window = { width = 35 },
    filesystem = {
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_default",
      filtered_items = {
        visible = true,         -- show hidden files dimmed instead of hiding them
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
}
