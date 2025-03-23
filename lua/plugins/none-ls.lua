return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        --				null_ls.builtins.formatting.ruff.with({
        --                  command = ruff_executeable
        --}),
        --				null_ls.builtins.diagnostics.ruff.with({
        --                  command = ruff_executeable
        --}),
        null_ls.builtins.formatting.prettier,
      },
    })

    -- vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    local function format_and_save()
      vim.lsp.buf.format()
      vim.cmd("w")
    end

    vim.keymap.set("n", "<leader>gf", format_and_save, {})
  end,
}
