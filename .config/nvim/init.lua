vim.g.mapleader = ';' -- Make sure to set `mapleader` before lazy so your mappings are correct

local lazypath = vim.fn.stdpath('data') .. 'lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

local lazyopts = {
  defaults = { lazy = false },
  performance = {
    rtp = {
      disabled_plugins = {},
    },
  },
}

require('lazy').setup('plugins', lazyopts)

require('lsp')
require('config.cmds')
require('config.globals')
require('config.autocmds')
require('config.styles')
require('config.keymaps')
