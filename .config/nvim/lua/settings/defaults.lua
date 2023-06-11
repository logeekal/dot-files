-- Reference: https://github.com/ismailshak/nvim/
-- TODO
--
-- In memory settings table which can save/persist
-- table details. Checkout above repo for the whole
-- framework
--
--
local M = {
  ---@alias background 'dark' | 'light'
  ---@type background
  background = 'dark',

  ---@alias theme
  ---| 'tokyonight'
  ---| 'carbonfox'
  ---| 'nightfox'
  ---| 'dayfox'
  ---| 'catppuccin'
  --@type theme
  theme = 'tokyonight',

  ---Comma-separated list of directories where formatting should be disabled
  ---@type string
  disable_format = '',
}

return M
