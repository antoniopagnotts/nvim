return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = { "gopls", "lua_ls" },
      automatic_enable = true,   -- enables every installed server via vim.lsp.enable()
    },
  },
  { "neovim/nvim-lspconfig", lazy = true },
}
