local function setup_beacon()
  require('beacon').setup({
    enabled = true,                                --- (boolean | fun():boolean) check if enabled
    speed = 1,                                     --- integer speed at wich animation goes
    width = 80,                                    --- integer width of the beacon window
    winblend = 80,                                 --- integer starting transparency of beacon window :h winblend
    fps = 60,                                      --- integer how smooth the animation going to be
    min_jump = 4,                                  --- integer what is considered a jump. Number of lines
    cursor_events = { 'CursorMoved' },             -- table<string> what events trigger check for cursor moves
    window_events = { 'WinEnter', 'FocusGained' }, -- table<string> what events trigger cursor highlight
    highlight = { bg = 'white', ctermbg = 2 },     -- vim.api.keyset.highlight table passed to vim.api.nvim_set_hl
  })
end
return {
  {
    'DanilaMihailov/beacon.nvim',
    config = setup_beacon,
  },
}
