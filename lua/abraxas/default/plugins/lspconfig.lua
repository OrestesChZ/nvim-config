return {
  "neovim/nvim-lspconfig",
  dependencies = { "ray-x/lsp_signature.nvim", "jose-elias-alvarez/typescript.nvim" },
  config = function()
    -- Silencia warning de API deprecada hasta migrar a nvim-lspconfig v3.0
    vim.deprecate = function() end

    local lspconfig_status, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status then
      return
    end

    local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if not cmp_nvim_lsp_status then
      return
    end
    local capabilities = cmp_nvim_lsp.default_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = nil
      local opts = { noremap = true, silent = true, buffer = bufnr }

      vim.keymap.set("n", "<leader>dd", "<Cmd>Telescope diagnostics bufnr=0<CR>", opts)
      vim.keymap.set(
        "n",
        "<leader>dD",
        "<Cmd>Telescope diagnostics<CR>",
        { noremap = true, silent = true }
      )
      vim.keymap.set("n", "gD", ":lua require'telescope.builtin'.lsp_references()<CR>", opts)
      vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
      vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      vim.keymap.set("n", "<leader>D", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
      vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
      vim.keymap.set("i", "<C-b>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      vim.keymap.set("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
      vim.keymap.set("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    end

    local signs = { Warn = "", Hint = "", Error = "", Info = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        signs = true,
        update_in_insert = true,
        virtual_text = false,
      })

    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "templ" },
    })

    lspconfig["ts_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.cmd([[
augroup FileTypeSpecificAutocommands
    autocmd!
    autocmd FileType typescript  setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType javascript  setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType svelte      setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup end
    ]])

    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    require("lspconfig").tailwindcss.setup({
      capabilities = capabilities,
      filetypes = {
        "css",
        "scss",
        "sass",
        "postcss",
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "svelte",
        "vue",
        "rust",
        "templ",
      },
      init_options = {
        userLanguages = {
          rust = "html",
          templ = "html",
        },
      },
      root_dir = require("lspconfig").util.root_pattern(
        "tailwind.config.js",
        "tailwind.config.ts",
        "postcss.config.js",
        "postcss.config.ts",
        "windi.config.ts"
      ),
    })

    lspconfig["gopls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.cmd([[
augroup GoFormatAutogroup
  autocmd!
  autocmd BufWritePre *.go lua vim.lsp.buf.format()
augroup END
]])

    -- lspconfig.htmx.setup({
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   filetypes = { "html", "templ" },
    -- })

    lspconfig["templ"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.api.nvim_create_autocmd(
      { "BufWritePre" },
      { pattern = { "*.templ" }, callback = vim.lsp.buf.format }
    )

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { "rustup", "run", "stable", "rust-analyzer" },
      settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true },
        },
      },
    })
    vim.cmd([[
augroup RustFormatAutogroup
  autocmd!
  autocmd BufWritePre *.rs lua vim.lsp.buf.format()
augroup END
]])

    lspconfig["pylsp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["solidity"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["svelte"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["yamlls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { yaml = { keyOrdering = false } },
    })

    lspconfig["jsonls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["dockerls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- C# OmniSharp
    local omnisharp_extended = require("omnisharp_extended")
    local pid = vim.fn.getpid()
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/omnisharp.cmd"
    lspconfig["omnisharp"].setup({
      cmd = { mason_bin, "--languageserver", "--hostPID", tostring(pid) },
      capabilities = capabilities,
      on_attach = on_attach,
      handlers = {
        ["textDocument/definition"] = omnisharp_extended.handler,
      },
    })
    vim.cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePre *.cs lua vim.lsp.buf.format()
augroup END
]])

    lspconfig["clangd"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.cmd([[
augroup CFormatAutogroup
  autocmd!
  autocmd BufWritePre *.cpp lua vim.lsp.buf.format()
augroup END
]])

    lspconfig.perlnavigator.setup({
      cmd = { "perlnavigator", "--stdio" },
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["intelephense"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- SQL
    lspconfig["sqlls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- eslint para Next.js y TypeScript
    lspconfig["eslint"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
