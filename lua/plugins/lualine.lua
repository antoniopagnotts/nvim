return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "tokyonight",
      icons_enabled = true,   -- switch to true once you have a Nerd Font (see below)
      component_separators = "|",
      section_separators = "",
      globalstatus = true,
    },
  },
}
