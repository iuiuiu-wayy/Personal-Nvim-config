vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.g.mapleader = " "
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set autoread")
-- vim.cmd("set noexpandtab")
-- vim.cmd("set tabstop=4")
-- vim.cmd("set shiftwidth=4")
-- vim.cmd("set softtabstop=4")
-- vim.api.nvim_set_keymap("n", "<leader>pdb", "oimport pdb; pdb.set_trace()<Esc>:w<CR>", { noremap = true, silent = true })
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.api.nvim_set_keymap(
      "n",
      "<leader>pdb",
      "oimport ipdb; ipdb.set_trace()<Esc>:w<CR>",
      { noremap = true, silent = true }
    )
    -- vim.api.nvim_set_keymap("n", "<leader>yf", "bvwhy", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>yf", "?def <CR>wvf(hy", { noremap = true, silent = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "javascript" },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
})
