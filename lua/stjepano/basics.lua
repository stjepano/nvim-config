vim.opt.exrc = true
vim.opt.secure = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.cursorline = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

--vim.opt.undodir = os.getenv("HOME") .. "/nvim/undodir"
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.pumheight = 10

vim.g.netrw_banner = false
vim.g.netrw_liststyle = 0

vim.cmd[[colorscheme tokyonight-night]]
