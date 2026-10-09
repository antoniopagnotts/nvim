return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  build = "BUILD_FROM_SOURCE=true make",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    "ColinKennedy/mega.cmdparse",
    "ColinKennedy/mega.logging",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
  opts = {
    provider = "copilot",
    windows = {
      position = "right",
      width = 35,
    },
  },
}
