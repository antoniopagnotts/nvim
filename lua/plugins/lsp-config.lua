return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      
      -- Angular
      lspconfig.angularls.setup({
	capabilities = capabilities,
	on_new_config = function(new_config, nre_root_dir)
	  new_config.cmd = {
	    "ngserver",
	    "--stdio",
	    "--tsProbeLocations",
	    new_root_dir,
	    "--ngProbeLocations",
	    new_root_dir,
          }
        end,
      })

      -- Emmet (HTML/CSS JSX snippets)
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = {
          "html", "css", "scss", "javascript", "typescript",
        },
      })

      -- Typescript/JavaScript
      lspconfig.ts_ls.setup({ capabilities = capabilities })
      
      -- HTML
      lspconfig.html.setup({ capabilities = capabilities })
      
      -- CSS 
      lspconfig.cssls.setup({ capabilities = capabilities })
      
      -- JSON
      lspconfig.jsonls.setup({ capabilities = capabilities })
      
      -- YAML
      lspconfig.yamlls.setup({ capabilities = capabilities })
      
      -- GO
      lspconfig.gopls.setup({ capabilities = capabilities })
      
      -- Lua
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
