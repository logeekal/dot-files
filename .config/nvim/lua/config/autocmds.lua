local utils = require('utils')

local opts = { noremap = true, silent = true }
-----------------------
---    AutCmds
-----------------------

vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  pattern = '*.svelte',
  command = 'syntax on | set syntax=html',
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  callback = function(event)
    -- Skip formatting for large files
    if vim.b[event.buf].large_file then
      vim.api.nvim_echo({ { '[LargeFile] Skipping format on save', 'WarningMsg' } }, true, {})
      return
    end

    vim.lsp.buf.format({
      bufnr = event.buf,
      async = false,
    })
  end,
})

local set_override_keymaps = function()
  -- override <C-E> keymap that neoscroll was highjacking
  vim.keymap.set({ 'n', 'i' }, '<c-e>', '<cmd>Yazi<CR>', opts)
end

vim.api.nvim_create_autocmd({
  'BufEnter',
}, {
  pattern = { '*' },
  callback = set_override_keymaps,
})

local addLspBorder = function(event)
  require('lspconfig.ui.windows').default_options.border = 'single'
end

local setFoldMethodForReact = function()
  if
      vim.bo.filetype == 'typescript'
      or vim.bo.filetype == 'javascript'
      or vim.bo.filetype == 'javascriptreact'
      or vim.bo.filetype == 'typescriptreact'
  then
    vim.opt.foldmethod = 'indent'
  end
end

local vimEnterOps = function(event)
  addLspBorder()
  setFoldMethodForReact()
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  callback = function(event)
    vimEnterOps(event)
  end,
})
