local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>df', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>db', vim.diagnostic.goto_prev, opts)
vim.keymap.set(
  'n',
  '<leader>dl',
  '<cmd>lua vim.diagnostic.setloclist()<CR>',
  opts
)
vim.keymap.set(
  'n',
  '<leader>vd',
  '<cmd>lua vim.diagnostic.open_float()<CR>',
  opts
)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

vim.keymap.set('n', '<leader>gco', '<cmd>Telescope git_branches<CR>', opts)

---------------------
--- General Keymaps
---------------------
vim.keymap.set('n', '<leader>b', '<cmd>Buffers<CR>', opts)

vim.keymap.set('n', '<leader>co', '<cmd>CSToggle<CR>', opts)

-------------------
--  quick fix -----
-------------------

local function quickfix()
  vim.lsp.buf.code_action({
    filter = function(a)
      return a.isPreferred
    end,
    apply = true,
  })
end

vim.keymap.set('n', '<leader>qf', quickfix, opts)


local function set_search_keymaps()
  --- Search Keymaps
  ---
  local search_utils = require('utils.search')
  local search_cmds = search_utils.get_search_cmd()
  -- print('Setting search keymaps : ', vim.inspect(search_cmds))

  vim.keymap.set('n', '<leader>rg',
    search_cmds.live_grep
    , opts)

  vim.keymap.set('n', '<leader>p',
    search_cmds.git_files
    , opts)

  vim.keymap.set('n', '<leader>gss', search_cmds.grep_string_input, opts)

  vim.keymap.set('n', '<leader>gs', search_cmds.grep_string, opts)

  vim.keymap.set(
    'n',
    'gra',
    search_cmds.lsp_code_actions,
    opts
  )

  vim.keymap.set('n', '<leader>pa', search_cmds.search_files, opts)
  vim.keymap.set(
    'n',
    'gr',
    search_cmds.lsp_references,
    opts
  )
  vim.keymap.set(
    'n',
    '<leader>ds',
    search_utils.get_search_cmd().lsp_document_symbols,
    opts
  )
  vim.keymap.set(
    'n',
    '<leader>b',
    search_utils.get_search_cmd().buffers,
    opts
  )
end

set_search_keymaps()
