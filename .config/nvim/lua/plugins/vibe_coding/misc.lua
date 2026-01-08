return {
  {
    "ravitemer/codecompanion-history.nvim",
    opts = {
      memory = {
        auto_create_memories_on_summary_generation = true,
        -- path to the `vectorcode` executable
        vectorcode_exe = "vectorcode",
        tool_opts = {
          -- default number of memories to retrieve
          default_num = 10
        },
        -- whether to enable notification
        notify = true,
        -- whether to automatically update the index of all existing memories on startup
        -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
        index_on_startup = false,
      }
    }
  },
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },

  {
    "github/copilot.vim"
  },
  {
    "LunarVim/bigfile.nvim",
    event = { "FileReadPre", "BufReadPre", "User FileOpened" },
    opts = {
      filesize = 1,      -- Size in MB
      pattern = { "*" }, -- Autocmd pattern
      features = {       -- Features to disable for large files
        "indent_blankline",
        "illuminate",
        "lsp",
        "treesitter",
        "syntax",
        "matchparen",
        "vimdiff",
        "filetype",
      },
    },
    config = function(_, opts)
      require("bigfile").setup(opts)

      -- Ensure the buffer variable is set for our custom checks
      vim.api.nvim_create_autocmd("User", {
        pattern = "BigFileDisable",
        callback = function(args)
          vim.b[args.buf].large_file = true
          vim.notify("Large file detected - features disabled", vim.log.levels.WARN)
        end,
      })
    end,
  }
}
