vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { border = "rounded" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local map = function(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gr", vim.lsp.buf.references, "References")
    map("gi", vim.lsp.buf.implementation, "Implementation")
    map("K", vim.lsp.buf.hover, "Hover docs")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>d", vim.diagnostic.open_float, "Line diagnostics")
    map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev diagnostic")
    map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")
  end,
})
-- Tell every LSP server about blink.cmp's completion capabilities
local ok, blink = pcall(require, "blink.cmp")
if ok then
  vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities() })
end
-- Angular: let ts_ls handle rename, avoid duplicate rename prompts
vim.lsp.config("angularls", {
  on_init = function(client)
    client.server_capabilities.renameProvider = false
  end,
})
