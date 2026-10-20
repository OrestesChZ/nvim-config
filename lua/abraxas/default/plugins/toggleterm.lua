return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,
      direction = "horizontal",
      shell = "C:/PROGRA~1/Git/bin/bash.exe",
    })

    vim.keymap.set("n", "<leader>tc", ":ToggleTerm<CR>", { silent = true })
  end,
}