-- utils.root_has_file(".prettierrc")
-- utils.root_has_file(".prettierrc")
-- utils.root_has_file(".prettierrc")
return {
  "nvimtools/none-ls.nvim",  -- reemplaza jose-elias-alvarez/null-ls.nvim
  config = function()
    local setup, null_ls = pcall(require, "null-ls")
    if not setup then
      return
    end

    vim.diagnostic.config({
      virtual_text = false,
      underline = false,
    })

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        formatting.prettier.with({
          condition = function(utils)
            return
              utils.root_has_file(".prettierrc.js")
                or utils.root_has_file("prettier.config.js")
                or utils.root_has_file(".prettierrc.json")
                or utils.root_has_file(".prettierrc.yaml")
                or utils.root_has_file(".prettierrc.yml")
                or utils.root_has_file(".prettierrc.toml")
          end,
          filetypes = {
            "html",
            "json",
            "svelte",
            "markdown",
            "css",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
        }),

        formatting.phpcsfixer.with({ exta_args = { "--rules", "@Symfony" } }),
        formatting.stylua,
        -- diagnostics.flake8.with({
        --   command = "C:/Users/oresc/AppData/Local/Programs/Python/Python311/Scripts/flake8.exe",
        -- }),
        null_ls.builtins.formatting.black.with({ extra_args = { "--line-length", "80" } }),
      --   diagnostics.eslint.with({
      --   condition = function(utils)
      --     return utils.root_has_file(".eslintrc.js")
      --       or utils.root_has_file("eslint.config.js")
      --       or utils.root_has_file("eslint.config.mjs")
      --   end,
      -- }),
      },
      on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                filter = function(client)
                  return client.name == "null-ls"
                end,
                bufnr = bufnr,
              })
            end,
          })
        end
      end,
    })
  end,
}