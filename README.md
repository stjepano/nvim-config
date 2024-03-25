# Personal NVIM config

## Installed plugins

* Lazy plugin manager
* Fugitive 
* LSP/Mason via lsp-zero
* Copilot (copilot anc copilot-cmp but configured without cmp)
* Bufferline (defaults)
* Treesitter
* Telescope
* Tokyonight dark theme
* Quickmath

## Basic configuration

```
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

vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.pumheight = 10

vim.g.netrw_banner = false
vim.g.netrw_liststyle = 0
```

## Remaps

The ```<leader>``` key is ```Space```.

When in insert mode you can use ```Escape``` to exit it or press ```jj``` quickly. 
If you actually need to type ```jj``` then you need to wait 1 second between keypresses.

### Basic remaps

| Key combo    | Action              |
|--------------|---------------------|
| \<leader\>g  | Start fugitive      |
| \<leader\>h  | Turn off highlights |
| \<leader\>w  | Save                |
| \<leader\>q  | Quit                |
| \<leader\>pv | Explorer            |

### Telescope

| Key combo     | Action              |
|---------------|---------------------|
| \<leader\>ff  | Git files           |
| \<leader\>fa  | All files           |
| \<leader\>ft  | Grep                |
| \<leader\>fb  | Buffers             |
| \<leader\>fy  | LSP document sym    |
| \<leader\>fda | LSP diagnostics all |
| \<leader\>fdc | LSP diagnostics     |

## Buffers

| Key combo    | Action                      |
|--------------|-----------------------------|
| \<leader\>bb | Prev buffer                 |
| \<leader\>bn | Next buffer                 |
| \<leader\>bc | Close buffer                |
| \<leader\>bj | Pick buffer                 |
| \<leader\>c  | Close buffer without window |

### Windows

| Key combo    | Action              |
|--------------|---------------------|
| \<leader\>sv | Split vertically    |
| \<leader\>sh | Split horizontally  |
| \<leader\>sc | Close current win   |
| \<Ctrl-l\>   | Go left             |
| \<Ctrl-h\>   | Go right            |
| \<Ctrl-j\>   | Go down             |
| \<Ctrl-k\>   | Go up               |

### LSP

| Key combo    | Action              |
|--------------|---------------------|
| gr           | Show references     |
| gd           | Jump to definition  |
| gD           | Jump to declaraion  |
| K            | Hover help          |
| \<Ctrl-k\>   | Signature help      |
| \<leader\>rn | Rename              |
| ]d  , [d     | Next, prev error    |

### LSP autocompetion (cmp)

| Key combo    | Action              |
|--------------|---------------------|
| \<Ctrl-y\>   | Accept              |
| \<Ctrl-e\>   | Abort               |
| \<Ctrl-u\>   | Scroll -4           |
| \<Ctrl-d\>   | Scroll +4           |
| \<Shft-Tab\> | Select+insert prev  |
| \<Tab\>      | Select+insert next  |

### Copilot

| Key combo    | Action              |
|--------------|---------------------|
| \<Alt-l\>    | Accept              |
| \<Alt-]\>    | Next suggestion     |
| \<Alt-[\>    | Prev suggestion     |
| \<Alt-k\>    | Dismiss             |

### DAP

| Key combo      | Action              |
|----------------|---------------------|
| \<leader\>db   | Toggle breakpoint   |
| \<leader\>dB   | Set breakpoint      |
| \<leader\>dlp  | Log point           |
| \<leader\>dr   | Repl open           |
| \<leader\>dl   | Run last            |
| \<leader\>dh   | Hover               |
| \<leader\>dp   | Preview             |
| \<leader\>df   | Frames              |
| \<leader\>ds   | Scope               |
| \<F5\>         | Continue            |
| \<F10\>        | Step over           |
| \<F11\>        | Step into           |
| \<F12\>        | Step out            |

## DAP configuration

Here is an example of DAP adapter and launch configuration using codelldb. I placed these into `.nvim.lua`

```
local dap = require('dap')
dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
        command = '/home/stjepano/.local/share/nvim/mason/bin/codelldb',
        args = {"--port", "${port}"}
    },
}
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
    },
}
dap.configurations.c = dap.configurations.cpp
```
