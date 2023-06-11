local utils = require('utils')
vim.opt.termguicolors = true -- True color support

local options = {
  options = {
    modified_icon = '✥',
    show_close_icon = false,
    always_show_bufferline = true,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diag)
      local icons = utils.icons.diagnostics
      local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
      return vim.trim(ret)
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = false -- use a "true" to enable the default, or set your own character
      }
    },
    name_formatter = function(buff)
      local user_home_dir = vim.loop.os_homedir()
      -- replace home dir with ~
      local new_path = buff.path:gsub(user_home_dir, '~')
      return new_path
    end,
    max_name_length = 1800, -- helps in displaying the full path of buffer
  },
  -- TODO - sample highlights
  highlights = {
    buffer_selected = {
      bold = true,
      underline = false,
      italic = false,
    },
    numbers_selected = {
      underline = false,
      bold = false,
    },
    diagnostic_selected = {
      underline = false,
      bold = false,
    },
    hint_selected = {
      underline = false,
      bold = false,
    },
    hint_diagnostic_selected = {
      underline = false,
      bold = false,
    },
    info_selected = {
      underline = false,
      bold = false,
    },
    info_diagnostic_selected = {
      underline = false,
      bold = false,
    },
    warning_selected = {
      underline = false,
      bold = false,
    },
    warning_diagnostic_selected = {
      underline = false,
      bold = false,
    },
    error_selected = {
      underline = false,
      bold = false,
    },
    error_diagnostic_selected = {
      underline = false,
      bold = true,
    },
    pick_selected = {
      underline = false,
      bold = false,
    },
    pick_visible = {
      bold = false,
    },
    pick = {
      bold = false,
    },
  },

}
return {
  {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup(options)
    end
  }
}
