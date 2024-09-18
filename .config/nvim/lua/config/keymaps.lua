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
