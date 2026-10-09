return {
  "saghen/blink.cmp",
  version = "1.*",
  lazy = false,
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    keymap = {
      preset = "default",   -- C-y accept, C-n/C-p select, C-space open, C-e close, C-b/C-f scroll docs
    },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 300 },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "lua" },
  },
}
