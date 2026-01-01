return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "bashls", "sqls", "ts_ls" },
      })
    end,
  },
  {
    "jayp0521/mason-null-ls.nvim",
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "prettier" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    config = function()
      -- local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- lspconfig.lua_ls.setup({ capabilities = capabilities })
      vim.lsp.config("lua_ls", { capabilities = capabilities })
      -- lspconfig.pyright.setup({
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = false, --RUff import sometimes doesn't work
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              -- ignore = { "*" },

              -- Ignore types
              -- autoImportCompletions = true,
              typeCheckingMode = "off",
              diagnosticSeverityOverrides = {
                reportUnusedImport = "warning",
                reportUnusedClass = "warning",
                reportUnusedFunction = "warning",
                reportUnusedVariable = "warning",
              },
            },
          },
        },
      })
      -- lspconfig.bashls.setup({ capabilities = capabilities })
      vim.lsp.config("bashls", { capabilities = capabilities })
      -- lspconfig.ruff.setup({
      vim.lsp.config("ruff", {
        capabilities = capabilities,
        init_options = {
          settings = {
            -- Ruff language server settings go here
          },
        },
      })
      vim.lsp.enable("ruff")
      -- lspconfig.sqls.setup({ capabilities = capabilities })
      vim.lsp.config("sqls", { capabilities = capabilities })

      -- lspconfig.eslint.setup({
      vim.lsp.config("eslint", {
        capabilities = capabilities,
        settings = {},

        -- nodePath = "frontend",
        -- on_attach = function(client, bufnr)
        --   vim.api.nvim_create_autocmd("BufWritePre", {
        --     buffer = bufnr,
        --     command = "EslintFixAll",
        --   })
        -- end,
      })

      -- lspconfig.ts_ls.setup({
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})  -- replaced by C-]
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "grr", require("telescope.builtin").lsp_references, {}) -- replaced by grr
      vim.keymap.set("n", "grn", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
      vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
