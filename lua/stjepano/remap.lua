vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- lazy plugins
-- vim.keymap.set("n", "<leader>l", vim.cmd.Lazy)

-- nohlsearch 
vim.keymap.set("n", "<leader>h", vim.cmd.nohlsearch)

-- write and quit
vim.keymap.set("n", "<leader>w", "<cmd>:w!<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>:q<cr>")

-- buffers
vim.keymap.set("n", "<leader>bb", "<cmd>:bp<cr>")
vim.keymap.set("n", "<leader>bn", "<cmd>:bn<cr>")
vim.keymap.set("n", "<leader>bc", "<cmd>:bdelete<cr>")
vim.keymap.set("n", "<leader>c", "<cmd>:bprev<bar>bdelete #<cr>")
--vim.keymap.set("n", "<leader>c", "<cmd>:bd!<cr>")
vim.keymap.set("n", "<leader>bj", "<cmd>:BufferLinePick<cr>")

-- windows
vim.keymap.set("n", "<leader>sh", "<cmd>:sp<cr>")
vim.keymap.set("n", "<leader>sv", "<cmd>:vsp<cr>")
vim.keymap.set("n", "<leader>sc", "<cmd>:close<cr>")
-- window navigation
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- fugitive
vim.keymap.set("n", "<leader>g", vim.cmd.Git)

-- when in insert mode use jj to exit
vim.keymap.set("i", "jj", "<esc>")
