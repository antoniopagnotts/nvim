return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			theme = "tokyonight",
			icons_enabled = true, -- switch to true once you have a Nerd Font (see below)
			component_separators = "|",
			section_separators = "",
			globalstatus = true,
		},
		sections = {
			lualine_c = {
				"filename",
				{
					function()
						local d = vim.b.gitsigns_blame_line_dict
						if not d or not d.author then
							return ""
						end
						if d.author == "Not Committed Yet" then
							return d.author
						end
						return string.format("%s, %s - %s", d.author, os.date("%d %b %Y", d.author_time), d.summary)
					end,
				},
			},
		},
	},
}
