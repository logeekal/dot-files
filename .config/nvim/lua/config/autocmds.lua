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
    if
      vim.bo.filetype == 'typescript'
      or vim.bo.filetype == 'javascript'
      or vim.bo.filetype == 'javascriptreact'
      or vim.bo.filetype == 'typescriptreact'
    then
      vim.cmd('EslintFixAll')
      local client =
        vim.lsp.get_active_clients({ bufnr = event.buf, name = 'eslint' })[1]
      if client then
        local diag = vim.diagnostic.get(
          event.buf,
          { namespace = vim.lsp.diagnostic.get_namespace(client.id) }
        )
        local diag_result = #diag
        if diag_result ~= 0 then
          vim.cmd('EslintFixAll')
          return
        else
          print('Not running EslintFixAll')
          return
        end
        vim.lsp.buf.format()
      else
        vim.lsp.buf.format()
      end
      return
    else
      --require("lvim.lsp.utils").format { timeout_ms = 2000, filter = require("lvim.lsp.utils").format_filter }
      vim.lsp.buf.format() -- careful, this overrides null-ls preferences
      return
    end
  end,
})

local set_override_keymaps = function()
  -- override <C-E> keymap that neoscroll was highjacking
  vim.keymap.set({ 'n', 'i' }, '<c-e>', '<cmd>NvimTreeToggle %:p:h<CR>', opts)
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

-- Large files
--
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*',
  desc = 'Disable syntax highlighting in files larger than 1MB',
  callback = function(args)
    local highlighter = require('vim.treesitter.highlighter')
    local ts_was_active = highlighter.active[args.buf]
    local file_size = vim.fn.getfsize(args.file)
    local max_file_size = 10 * 1024 * 1024
    if file_size > max_file_size then
      utils.disableSyntaxLargeFile()
      if ts_was_active then
        vim.notify('File larger than 1MB, turned off syntax highlighting')
      end
    end
  end,
})
