local lsp_servers_with_status = require('utils.lsp').lsp_servers
local requireIfExists = require('utils.module').requireIfExists

vim.lsp.config('*', require('lsp.common'))

local enabled_lsp_servers = {}

for server, status in pairs(lsp_servers_with_status) do
  if not status then
    -- Skip if the server is not enabled
    goto continue
  end
  table.insert(enabled_lsp_servers, server)
  local lspConfig = requireIfExists('lsp.' .. server)
  if lspConfig then
    -- print('Loading LSP config for ' .. server)
    vim.lsp.config[server] = lspConfig
  end
  ::continue::
end


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.diagnostic.config({
  virtual_text = true,
})

vim.lsp.enable(enabled_lsp_servers)
