return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    {
      "williamboman/mason.nvim",
      config = function()
        local mason_status, mason = pcall(require, "mason")
        if not mason_status then
          return
        end
        mason.setup()
      end,
    },
    {
      "jayp0521/mason-null-ls.nvim",
      config = function()
        local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
        if not mason_null_ls_status then
          return
        end
        mason_null_ls.setup({
          ensure_installed = {
            "prettier",
            "stylua",
            "black",
            "phpcsfixer",
          },
          automatic_installation = false, -- evita conflictos
        })
      end,
    },
  },
  config = function()
    local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not mason_lspconfig_status then
      return
    end
    mason_lspconfig.setup({
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "gopls",
        "rust_analyzer",
        "pylsp",
        "svelte",
        "yamlls",
        "jsonls",
        "dockerls",
        "intelephense",
        "clangd",
        "omnisharp",
        "sqlls",
      },
    })
  end,
}