local opt = vim.opt

opt.number = true
opt.relativenumber = false
opt.fillchars = "eob: "

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true
opt.conceallevel = 2
opt.cursorline = true -- highlight the current cursor line

opt.termguicolors = true
opt.signcolumn = "yes"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

vim.cmd([[set foldlevel=20]])
vim.cmd([[set foldmethod=expr]])
vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])

vim.cmd([[set hidden]])
vim.cmd([[set noswapfile]])
vim.cmd([[set nobackup]])

-- Windows: undodir en AppData en vez de ~/.vim/undodir
local undodir = vim.fn.stdpath("data") .. "/undodir"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.cmd("set undodir=" .. undodir)
vim.cmd([[set undofile]])

vim.cmd([[set scrolloff=10]])
opt.background = "dark"

vim.cmd([[autocmd FileType markdown set syntax=markdown]])

vim.filetype.add({ extension = { templ = "templ" } })

vim.opt.shell = "C:/PROGRA~1/Git/bin/bash.exe"
vim.opt.shellcmdflag = "-c"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

-- Python path para nvim
vim.g.python3_host_prog = "C:/Users/oresc/AppData/Local/Programs/Python/Python311/python.exe"
vim.g.mapleader = " "
