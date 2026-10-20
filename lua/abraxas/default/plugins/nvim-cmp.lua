return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      -- Windows: usar cmake en vez de make
      build = vim.fn.has("win32") == 1
        and "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        or "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "hrsh7th/cmp-nvim-lsp",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp_status, cmp = pcall(require, "cmp")
    if not cmp_status then return end

    local luasnip_status, luasnip = pcall(require, "luasnip")
    if not luasnip_status then return end

    local lspkind_status, lspkind = pcall(require, "lspkind")
    if not lspkind_status then return end

    local source_mapping = {
      buffer = "[Buffer]",
      nvim_lsp = "[LSP]",
      nvim_lua = "[Lua]",
      copilot = "[COP]",
      path = "[Path]",
      luasnip = "[SNP]",
    }

    require("luasnip/loaders/from_vscode").lazy_load()
    vim.opt.completeopt = "menu,menuone,noselect"

    cmp.setup({
      completion = {
        completeopt = "noselect",
        autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
      },
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.complete(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
        { name = "copilot",  max_item_count = 3,  score = 5 },
        { name = "nvim_lsp", max_item_count = 20, score = 8 },
        { name = "luasnip",  max_item_count = 10, score = 3 },
        { name = "buffer",   max_item_count = 10 },
        { name = "path" },
      }),
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
          vim_item.menu = source_mapping[entry.source.name]
          if entry.source.name == "copilot" then
            vim_item.kind = ""
          end
          local maxwidth = 50
          vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
          return vim_item
        end,
      },
      window = {
        completion = { pumheight = 5 },
      },
    })

    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
  end,
}