return { {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim"
  },
  opts = {
    opts = {
      log_level = "TRACE"
    },
    extensions = {
      history = {
        enabled = true, -- defaults to true
        opts = {
          history_file = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
          max_history = 10, -- maximum number of chats to keep
          save_chat_keymap = "cs",
          summary = {
            create_summary_keymap = "<leader>gcs",
          }
        },
        memory = {
          auto_create_memories_on_summary_generation = true,
          vectorcode_exe = "vectorcode",
          notify = true,
          tool_opts = {
            default_num = 10,
          },
          index_on_startup = false,
        },
      },
      vectorcode = {
        ---@type VectorCode.CodeCompanion.ExtensionOpts
        opts = {
          tool_group = {
            -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
            enabled = true,
            -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
            -- if you use @vectorcode_vectorise, it'll be very handy to include
            -- `file_search` here.
            extras = {},
            collapse = false, -- whether the individual tools should be shown in the chat
          },
          tool_opts = {
            ---@type VectorCode.CodeCompanion.ToolOpts
            ["*"] = {},
            ---@type VectorCode.CodeCompanion.LsToolOpts
            ls = {},
            ---@type VectorCode.CodeCompanion.VectoriseToolOpts
            vectorise = {},
            ---@type VectorCode.CodeCompanion.QueryToolOpts
            query = {
              max_num = { chunk = -1, document = -1 },
              default_num = { chunk = 50, document = 10 },
              include_stderr = false,
              use_lsp = true,
              no_duplicate = true,
              chunk_mode = false,
              ---@type VectorCode.CodeCompanion.SummariseOpts
              summarise = {
                ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
                enabled = false,
                adapter = nil,
                query_augmented = true,
              }
            },
            files_ls = {},
            files_rm = {}
          }
        }
      }
    },
    strategies = {
      -- chat = {
      --   adapter = {
      --     name = "gemini",
      --     model = "gemini-2.5-pro"
      --   }
      -- },
    },
    adapters = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            api_key = "cmd:gpg -q --decrypt --batch ~/.gnupg/gemini_elastic_dev.gpg"
          },
        })
      end,
    },
  },
} }
