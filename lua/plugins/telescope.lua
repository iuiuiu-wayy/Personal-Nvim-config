return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    config = function()
      local builtin = require("telescope.builtin")
      local function find_files_with_args()
        builtin.find_files({
          prompt_title = "Custom Find Files",
          hidden = true, -- Include hidden files
          follow = false, -- Follow symbolic links
        })
      end

      vim.keymap.set("n", "<C-p>", find_files_with_args, {})
      vim.keymap.set(
        "n",
        "<leader>fg",
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        {}
      )
      vim.keymap.set(
        "n",
        "<leader>fc",
        '<cmd>lua require("telescope.builtin").live_grep({ glob_pattern = "!{spec,test}"})<CR>',
        { desc = "Live Grep Code" }
      )
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      vim.keymap.set("n", "<leader>fbf", builtin.current_buffer_fuzzy_find, {})
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
      --     vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      --      vim.keymap.set('n', '<leader>fg', "
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          fzf = {},
        },
        defaults = {
          file_ignore_patterns = {
            "node_modules/",
            "build/",
            "dist/",
            ".venv/",
            "venv/",
            ".git/",
            ".vscode/",
            "specification/",
          },
        },
      })
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("fzf")
    end,
  },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
}
