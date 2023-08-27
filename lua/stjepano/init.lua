-- bootstrap lazy (clones it if not installed)
require('stjepano.bootstrap-lazy')
-- needs mapleader before we load lazy
vim.g.mapleader = " "
-- load plugins
require("lazy").setup("stjepano.plugins")

-- basic configuration
require('stjepano.basics')

-- key remaps
require('stjepano.remap')
