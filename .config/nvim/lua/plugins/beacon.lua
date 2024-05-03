local function setup_beacon()
  require('beacon').setup({
    enable = true,
    size = 80,
    fade = true,
    minimal_jump = 4,
    show_jumps = true,
    focus_gained = false,
    shrink = true,
    timeout = 500,
    ignore_buffers = {},
    ignore_filetypes = {},
  })
end
return {
  {
    'rainbowhxch/beacon.nvim',
    config = setup_beacon,
  },
}
