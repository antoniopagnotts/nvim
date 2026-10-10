return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Toggle terminal" },
    { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
  opts = {
    direction = "horizontal",
    size = 15,
    open_mapping = nil,   -- keys are defined above
    shade_terminals = false,
  },
}
