vim.g.mapleader = " "

local keymap = vim.keymap
vim.o.foldenable = true

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
keymap.set("n", "zR", require("ufo").openAllFolds)
keymap.set("n", "zM", require("ufo").closeAllFolds)
keymap.set("n", "<leader>fs", ":w<CR>")
keymap.set("n", "<leader>,<CR>", "<C-^>")

vim.api.nvim_set_keymap(
  "n",
  "<leader>fh",
  "vi{:! prettier --parser html --stdin-filepath<CR>vi{>",
  { noremap = true }
)
--mias
keymap.set("n", "<leader>mdl", "Vyp")
keymap.set("v", "<leader>mdl", "y}p")
keymap.set("n", "gnf", "]m")
keymap.set("n", "gef", "]M")
keymap.set("n", "gpf", "[m")
keymap.set("v", "gnf", "]m")
keymap.set("v", "gef", "]M")
keymap.set("v", "gpf", "[m")

--window
keymap.set("n", "<leader>wv", "<C-w>v")
keymap.set("n", "<leader>wc", ":close<CR>")
keymap.set("n", "<leader>ws", "<C-w>s")
keymap.set("n", "<leader>ww", ":MaximizerToggle<CR>")
keymap.set("n", "<leader>wl", "<C-w>l")
keymap.set("n", "<leader>wh", "<C-w>h")
keymap.set("n", "<leader>wj", "<C-w>j")
keymap.set("n", "<leader>wk", "<C-w>k")
keymap.set("n", "<leader>x", ":x<CR>", { silent = true })

--buffer
keymap.set("n", "<leader>bk", ":bd!<CR>", { silent = true })
keymap.set("n", "<leader>bq", ":q!<CR>", { silent = true })
keymap.set("n", "<leader>bn", ":bnext<CR>", { silent = true })
keymap.set("n", "<leader>bp", ":bprev<CR>", { silent = true })

--open
keymap.set("n", "<leader>op", ":NvimTreeToggle<CR>")
keymap.set("n", "<leader>fop", ":NvimTreeFindFile<CR>")

--Git
keymap.set("n", "<leader>gw", "<cmd>Gwrite<Cr>")
keymap.set("n", "<leader>gc", "<cmd>G commit<Cr>")
keymap.set("n", "<leader>gt", "<cmd>diffget //2<Cr>")
keymap.set("n", "<leader>gy", "<cmd>diffget //3<Cr>")
keymap.set("n", "<leader>gv", "<cmd>Gvdiffsplit!<Cr>")
keymap.set("n", "<leader>gs", vim.cmd.Git)

keymap.set("n", "<esc>", ":noh<CR><esc>", { silent = true })
keymap.set("n", "<leader>wo", ":only<CR>", { silent = true })

keymap.set("t", "<esc>", [[<C-\><C-n>]])

-- terminal
keymap.set("n", "<leader>tc", ":ToggleTerm<CR>", { silent = true }) -- toggle terminal
keymap.set("n", "<leader>t1", ":ToggleTerm 1<CR>", { silent = true }) -- terminal 1
keymap.set("n", "<leader>t2", ":ToggleTerm 2<CR>", { silent = true }) -- terminal 2
keymap.set("n", "<leader>t3", ":ToggleTerm 3<CR>", { silent = true }) -- terminal 3
keymap.set("n", "<leader>t4", ":ToggleTerm 4<CR>", { silent = true }) --t4
keymap.set("n", "<leader>t5", ":ToggleTerm 5<CR>", { silent = true }) --t5
keymap.set("t", "<C-k>", "<C-\\><C-n>:bd!<CR>", { silent = true }) --kill terminal

-- Copiar / pegar / cortar estilo Windows
keymap.set("n", "<C-a>", "ggVG", { silent = true }) -- Ctrl+A selecciona todo
keymap.set("v", "<C-c>", '"+y', { silent = true }) -- Ctrl+C copia
keymap.set("n", "<C-v>", '"+p', { silent = true }) -- Ctrl+V pega en normal
keymap.set("i", "<C-v>", "<C-r>+", { silent = true }) -- Ctrl+V pega en insert
keymap.set("v", "<C-x>", '"+d', { silent = true }) -- Ctrl+X corta
keymap.set("n", "<leader>vb", "<C-v>", { silent = true, desc = "Visual Block mode" })

-- Moverse entre palabras estilo Windows
keymap.set("n", "<C-Left>", "b", { silent = true }) -- Ctrl+← palabra anterior
keymap.set("n", "<C-Right>", "w", { silent = true }) -- Ctrl+→ siguiente palabra
keymap.set("i", "<C-Left>", "<C-o>b", { silent = true }) -- Ctrl+← en insert
keymap.set("i", "<C-Right>", "<C-o>w", { silent = true }) -- Ctrl+→ en insert

-- Seleccionar palabras estilo Windows
keymap.set("n", "<C-S-Left>", "vb", { silent = true }) -- Ctrl+Shift+← selecciona
keymap.set("n", "<C-S-Right>", "vw", { silent = true }) -- Ctrl+Shift+→ selecciona

-- Markdown preview en browser
keymap.set(
  "n",
  "<leader>mr",
  ":MarkdownPreviewToggle<CR>",
  { silent = true, desc = "Toggle markdown preview" }
)
