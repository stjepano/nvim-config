local lsp = require('lsp-zero')
lsp.preset('recommended')

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
--[[
local cmp_select_opts = {behavior = cmp.SelectBehaviorSelect}
]]

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
  sources = {
    {name = 'nvim_lsp', group_index = 1},
    {name = 'buffer', group_index = 2},
    {name = 'path', group_index = 2},
  },
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    --[[
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehaviorInsert}),
    ['<Tab>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehaviorInsert}),
    ]]
    ['<Shift-Tab>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item({behavior = cmp.SelectBehaviorInsert})
      else
        cmp.complete()
      end
    end),
    --[[
    ['<Tab>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item({behavior = cmp.SelectBehaviorInsert})
      else
        cmp.complete()
      end
    end),
    ]]
    ['<Tab>'] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({behavior = cmp.SelectBehaviorInsert})
      else
        fallback()
      end
    end),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = {'abbr', 'menu', 'kind'},
    format = function(entry, item)
      local short_name = {
        nvim_lsp = 'LSP',
        nvim_lua = 'nvim',
      }

      local menu_name = short_name[entry.source.name] or entry.source.name

      item.menu = string.format('>> [%s]', menu_name)
      return item
    end,
  },
})


lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	lsp.default_keymaps(opts)
	vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
end)

lsp.setup()


