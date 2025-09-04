return {
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },

    opts = {
      winopts = {
        border = "rounded",
        preview = {
          border = "rounded",
          layout = "vertical",
          vertical = "down:60%",
          title = 'file',
        },
      },
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        }
      },
      actions = {
        true,
      }
    }
  } }
