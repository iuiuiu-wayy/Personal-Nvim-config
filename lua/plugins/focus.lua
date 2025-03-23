return {
  "nvim-focus/focus.nvim",
  version = "*",
  config = function()
    require("focus").setup({
      enable = true,
      commands = true,
      autoresize = {
        enable = false,
      },
      ui = {
        -- winhighlight = true,
      },
    })
  end,
}
