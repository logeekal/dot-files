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
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          -- MCP Tools
          make_tools = true,                   -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
          show_server_tools_in_chat = true,    -- Show individual tools in chat completion (when make_tools=true)
          add_mcp_prefix_to_tool_names = true, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
          show_result_in_chat = true,          -- Show tool results directly in chat buffer
          format_tool = nil,                   -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          -- MCP Resources
          make_vars = true,                    -- Convert MCP resources to #variables for prompts
          -- MCP Prompts
          make_slash_commands = true,          -- Add MCP prompts as /slash commands
        }
      },
      history = {
        enabled = true, -- defaults to true
        opts = {
          history_file = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
          max_history = 10, -- maximum number of chats to keep
          save_chat_keymap = "cs",
          summary = {
            -- create_summary_keymap = "gb",
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
              chunk_mode = true,
              ---@type VectorCode.CodeCompanion.SummariseOpts
              summarise = {
                ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
                enabled = true,
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
    prompt_library = {
      ["Siem Migration New Feature"] = require('plugins.vibe_coding.prompts.siem_migrations')
    },
    strategies = {
      chat = {
        adapter = {
          name = "copilot",
          model = "claude-sonnet-4.5"
        }
      },
    }
  },
} }
