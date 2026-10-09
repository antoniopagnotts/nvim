return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,            -- this plugin doesn't support lazy-loading
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "go", "gomod", "gosum", "gowork",
      "typescript", "tsx", "javascript",
      "html", "css", "scss", "json", "yaml", "toml",
      "lua", "vim", "vimdoc", "query",
      "bash", "c", "cpp", "dockerfile",
      "markdown", "markdown_inline", "regex",
    })

    -- Angular templates (*.component.html) use the "angular" parser
    vim.treesitter.language.register("angular", "htmlangular")

    -- Enable highlighting for any filetype that has a parser
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
