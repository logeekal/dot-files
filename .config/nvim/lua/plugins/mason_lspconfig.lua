local lsp_utils = require('utils.lsp')
local lsp_servers_with_status = lsp_utils.lsp_servers



local mason_utils = require('utils.mason')
local mason_style_providers = lsp_utils.style_providers
local enabled_style_providers = lsp_utils.get_enabled_keys(mason_style_providers)
mason_utils.install_packages(enabled_style_providers)


local lsp_servers = {}

for server, status in pairs(lsp_servers_with_status) do
  if not status then
    -- Skip if the server is not enabled
    goto continue
  end
  table.insert(lsp_servers, server)

  ::continue::
end

return {
  {
    'mason-org/mason-lspconfig.nvim',
    cmd = { 'LspInstall', 'LspUninstall' },
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
      -- 'hrsh7th/cmp-nvim-lsp',
    },
    opts = {
      ensure_installed = lsp_servers,
      automatic_installation = true,
      automatic_enable = true
    },
    event = { 'VimEnter' }
  },
}
