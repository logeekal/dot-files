local lsp_servers_ensure_installed = require('utils.lsp').lsp_servers

return {
  {
    'williamboman/mason-lspconfig.nvim',
    cmd = { 'LspInstall', 'LspUninstall' },
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = lsp_servers_ensure_installed,
        automatic_installation = true,
      })
    end,
  },
}
