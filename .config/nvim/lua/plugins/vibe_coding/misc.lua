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
  }
}
