vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.g.mapleader = " "
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set autoread")

-- Clipboard over SSH (paste to the laptop that ssh'd in).
-- Copy via xclip to the *forwarded* X11 display now (GNOME Terminal can't do
-- OSC 52), AND emit OSC 52 too so it keeps working if you switch to a capable
-- terminal. DISPLAY is fetched fresh from tmux each time so it survives
-- detach/reconnect (the persistent tmux server's own $DISPLAY goes stale).
do
  local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")

  -- Freshest DISPLAY: ask tmux if we're inside it, else fall back to env.
  local function display()
    if vim.env.TMUX then
      local out = vim.fn.system({ "tmux", "show-environment", "DISPLAY" })
      local d = out:match("DISPLAY=([^\n]+)")
      if d and d ~= "" then
        return d
      end
    end
    return vim.env.DISPLAY
  end

  local function make_copy(reg)
    local sel = reg == "*" and "primary" or "clipboard"
    local osc_copy = ok and osc52.copy(reg) or nil
    return function(lines, regtype)
      local disp = display()
      if disp and vim.fn.executable("xclip") == 1 then
        vim.fn.system({ "xclip", "-selection", sel, "-i", "-display", disp }, lines)
      end
      if osc_copy then
        osc_copy(lines, regtype)
      end
    end
  end

  local function make_paste(reg)
    local sel = reg == "*" and "primary" or "clipboard"
    local osc_paste = ok and osc52.paste(reg) or nil
    return function()
      local disp = display()
      if disp and vim.fn.executable("xclip") == 1 then
        local out = vim.fn.systemlist({ "xclip", "-selection", sel, "-o", "-display", disp })
        if vim.v.shell_error == 0 then
          return out
        end
      end
      if osc_paste then
        return osc_paste()
      end
      return { "" }
    end
  end

  vim.g.clipboard = {
    name = "xclip+osc52",
    copy = { ["+"] = make_copy("+"), ["*"] = make_copy("*") },
    paste = { ["+"] = make_paste("+"), ["*"] = make_paste("*") },
  }
end
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

vim.o.exrc = true   -- Enable reading .nvim.lua in project directories
vim.o.secure = true -- Disable unsafe commands in local config (optional safety)
