return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup({
      sources = {
	-- Lua
        formatting.stylua,
        
	formatting.prettier.with({
          filetypes = {
	    "javascript",
	    "typescript",
	    "json",
	    "yaml",
	    "css",
	    "html",
	    "markdown",
	  },
	}),
        
	-- ESLint for JS/TS
        diagnostics.eslint_d,
        formatting.eslint_d,
        
	-- YAML
	diagnostics.yamllint,

	--JSON
	diagnostics.jsonlint,

	-- Go
	formatting.gofmt,
	formatting.goimports,
	diagnostics.golangci_lint,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
