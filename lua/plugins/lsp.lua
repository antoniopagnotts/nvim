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
      ensure_installed = { "gopls", "lua_ls", "ts_ls", "angularls", "html", "cssls", "jsonls" },
      automatic_enable = true,   -- enables every installed server via vim.lsp.enable()
    },
  },
  { "neovim/nvim-lspconfig", lazy = true },
    {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = { "prettier", "stylua" },
    },
  },
}
