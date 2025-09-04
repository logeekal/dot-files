---@type LazySpec
return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<C-e>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  {
    -- example: include a flavor
    "BennyOe/onedark.yazi",
    lazy = true,
    build = function(plugin)
      require("yazi.plugin").build_flavor(plugin)
    end,
  },
  {
    -- example: include a plugin
    "Rolv-Apneseth/starship.yazi",
    lazy = true,
    build = function(plugin)
      require("yazi.plugin").build_plugin(plugin)
    end,
  },
  {
    -- example: include a flavor from a subdirectory. There are lots of flavors
    -- available in https://github.com/yazi-rs/flavors
    "yazi-rs/flavors",
    name = "yazi-flavor-catppuccin-macchiato",
    lazy = true,
    build = function(spec)
      require("yazi.plugin").build_flavor(spec, {
        sub_dir = "catppuccin-macchiato.yazi",
      })
    end,
  },
}
