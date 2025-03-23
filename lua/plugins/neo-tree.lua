return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true, -- hide filtered items on open
					hide_gitignored = false,
					hide_dotfiles = false,
					hide_by_name = {
						".github",
						".gitignore",
						".changeset",
						".venv",
						"venv",
						"node_modules",
					},
					never_show = { ".git" },
				},
			},
			close_if_last_window = false,
			enable_git_status = true,
			default_component_configs = {
				modified = {
					symbol = "[+]",
					highlight = "NeoTreeModified",
				},
				window = {
					position = "left",
					width = 20,
				},
				type = {
					enabled = false,
					width = 10, -- width of the column
					required_width = 122, -- min width of window required to show this column
				},
			},
		})
		--    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
		vim.keymap.set("n", "<C-n>", ":Neotree reveal toggle <CR>", {})
		vim.keymap.set("n", "<leader>ntb", ":Neotree source=buffers <CR>", {})
		vim.keymap.set("n", "<leader>ntg", ":Neotree source=git_status <CR>", {})
	end,
}
