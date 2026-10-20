return {
  "tpope/vim-dadbod",
  dependencies = {
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion",
  },
  cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
  config = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_save_location = "C:/Users/oresc/AppData/Local/nvim-data/db_ui"

    local keymap = vim.keymap
    keymap.set("n", "<leader>db", ":DBUIToggle<CR>", { silent = true }) -- abrir/cerrar DB UI
  end,
}