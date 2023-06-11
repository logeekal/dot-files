local utils = require('utils')

local install_null_ls_formatters = function()
  local formatters_to_install = {
    'stylua',
    'beautysh',
    'codespell',
    'vint',
  }

  utils.mason_install(formatters_to_install)
end

local setup = function()
  local null_ls = require('null-ls')
  local formatting = null_ls.builtins.formatting
  local diag = null_ls.builtins.diagnostics
  install_null_ls_formatters()
  null_ls.setup({
    sources = {
      formatting.stylua,
      formatting.beautysh,
      diag.codespell,
      diag.vint,
    },

    -- This is here to format on save
    on_attach = function(client)
      -- vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.format()')
    end,
  })
end

return {

  {
    'jose-elias-alvarez/null-ls.nvim',
    config = setup,
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
  },
}
