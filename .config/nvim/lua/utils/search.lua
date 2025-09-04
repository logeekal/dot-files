local M = {}


local function get_fzf_lua_cmd()
  local fzf_lua = require('fzf-lua')

  return {
    search_files = fzf_lua.files,
    git_files = fzf_lua.git_files,
    buffers = fzf_lua.buffers,
    lsp_references = fzf_lua.lsp_references,
    lsp_document_symbols = fzf_lua.lsp_document_symbols,
    lsp_code_actions = fzf_lua.lsp_code_actions,
    grep_string = fzf_lua.grep_cword,
    live_grep = fzf_lua.live_grep,
    grep_string_input = function()
      fzf_lua.grep_cword({
        prompt = 'Grep > ',
        search = vim.fn.input('Grep > '),
      })
    end,
  }
end

local function get_telescope_cmd()
  local telescope = require('telescope.builtin')
  local dropDownTheme = require('telescope.themes').get_dropdown({
    layout_config = {
      width = 0.9,
      preview_cutoff = 1,
      height = 0.5,
      mirror = true,
      anchor = 'N',
      prompt_position = 'top',
    },
  })
  return {
    search_files = function()
      telescope.find_files(dropDownTheme)
    end,
    git_files = function()
      telescope.git_files(dropDownTheme)
    end,
    buffers = function()
      telescope.buffers(dropDownTheme)
    end,
    lsp_references = function()
      telescope.lsp_references(dropDownTheme)
    end,
    lsp_document_symbols = function()
      telescope.lsp_document_symbols(dropDownTheme)
    end,
    lsp_code_actions = function()
      telescope.lsp_code_actions(dropDownTheme)
    end,
    grep_string = function()
      telescope.grep_string(dropDownTheme)
    end,
    grep_string_input = function()
      telescope.grep_string(vim.tbl_extend('force', dropDownTheme, {
        search = vim.fn.input('Grep > '),
        theme = 'dropdown',
      }))
    end,
    live_grep = function()
      telescope.live_grep(dropDownTheme)
    end,
  }
end


-- Returns a table with search commands based on the provided search tool.
-- If no tool is specified, it defaults to 'fzf'.
-- If 'fzf' is specified, it uses fzf-lua commands.
-- @param search_tool: string (optional) - The search tool to use ('fzf' or 'telescope').
function M.get_search_cmd(search_tool)
  if not search_tool or search_tool == 'fzf' then
    return get_fzf_lua_cmd()
  else
    return get_telescope_cmd()
  end
end

return M
