return {
  { "github/copilot.vim" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },                    -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                       -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- comfig = function()
    --   vim.keymap.set("n", "<leader>cp", ":CopilotChat<CR>", { noremap = true, silent = true })
    --   vim.keymap.set("v", "<leader>cp", ":CopilotChat<CR>", { noremap = true, silent = true })
    --   vim.keymap.set("n", "<leader>cr", ":CopilotChatReset<CR>", { noremap = true, silent = true })
    --   vim.keymap.set("n", "<leader>ce", ":CopilotChatExplain<CR>", { noremap = true, silent = true })
    -- end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
