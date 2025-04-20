return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
		lazy = true,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { ".git/", "node_modules/" },
				},
				pickers = {
					find_files = {
						hidden = false,
						no_ignore = false,
					},
				},
				-- No cargar la extensión temporalmente
				-- extensions = {
				-- 	["ui-select"] = {
				-- 		require("telescope.themes").get_dropdown({}),
				-- 	},
				-- },
			})
		end,
	},
}
