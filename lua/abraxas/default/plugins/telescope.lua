return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    {
      "nvim-telescope/telescope-fzy-native.nvim",
    },
  },
  config = function()
    local telescope_setup, telescope = pcall(require, "telescope")
    if not telescope_setup then
      return
    end
    local actions_setup, actions = pcall(require, "telescope.actions")
    if not actions_setup then
      return
    end
    telescope.setup({
      pickers = {
        current_buffer_tags = { fname_width = 100 },
        jumplist = { fname_width = 100 },
        loclist = { fname_width = 100 },
        lsp_definitions = { fname_width = 100 },
        lsp_document_symbols = { fname_width = 100 },
        lsp_dynamic_workspace_symbols = { fname_width = 100 },
        lsp_implementations = { fname_width = 100 },
        lsp_incoming_calls = { fname_width = 100 },
        lsp_outgoing_calls = { fname_width = 100 },
        lsp_references = { fname_width = 100 },
        lsp_type_definitions = { fname_width = 100 },
        lsp_workspace_symbols = { fname_width = 100 },
        quickfix = { fname_width = 100 },
        tags = { fname_width = 100 },
      },
      defaults = {
        path_display = { "truncate" },
        file_ignore_patterns = {
          "node_modules", "dist", "static",
          ".git", ".claude", ".azure",
          "%.dll", "%.exe", "%.bin", "%.cache",
        },
        preview = {
          treesitter = false,
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_cursor({
            hidden = true,
            no_ignore = true,
            previewer = false,
            prompt_title = "",
            preview_title = "",
            results_title = "",
            layout_config = { prompt_position = "top" },
          }),
        },
      },
    })
    telescope.load_extension("fzy_native")
    telescope.load_extension("ui-select")
    local keymap = vim.keymap
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files cwd=%:h<Cr>")
    keymap.set("n", "<leader>;",  "<cmd>Telescope oldfiles<Cr>")
    keymap.set("n", "<leader>:",  "<cmd>Telescope commands<Cr>")
    keymap.set("n", "<leader>.",  "<cmd>Telescope buffers<Cr>")
    keymap.set("n", "<leader>/",  "<cmd>Telescope live_grep cwd=%:h<Cr>")
  end,
}