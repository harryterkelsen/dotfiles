-- /Users/het/dotfiles/nvim/.config/nvim/lua/plugins/gemini-integration.lua

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = function(_, opts) -- Register our custom Gemini completion source with nvim-cmp
      table.insert(opts.sources, { name = "gemini" })
    end,
  },

  -- Our custom Gemini completion source
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local cmp = require("cmp")
      local plenary_job = require("plenary.job")

      local GeminiSource = {}

      -- The core completion function
      GeminiSource.complete = function(params, callback)
        local api_key = os.getenv("GEMINI_API_KEY")
        if not api_key or api_key == "" then
          vim.notify("GEMINI_API_KEY not set", vim.log.levels.WARN)
          callback({})
          return
        end

        -- Get the text before the cursor to use as a prompt
        local line_to_cursor = vim.api.nvim_buf_get_text(0, params.offset - 1, 0, params.offset - 1, 9999, {})[1]
        if not line_to_cursor or #line_to_cursor == 0 then
          callback({})
          return
        end

        local prompt = [[Complete the following code: 
]] .. line_to_cursor

        -- Asynchronously call the Gemini API
        plenary_job
          :new({
            command = "curl",
            args = {
              "-s",
              "-X",
              "POST",
              "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=" .. api_key,
              "-H",
              "Content-Type: application/json",
              "-d",
              vim.fn.json_encode({
                contents = {
                  {
                    parts = {
                      { text = prompt },
                    },
                  },
                },
              }),
            },
            on_exit = function(job, return_val)
              if return_val == 0 then
                local result = vim.fn.json_decode(job:result()[1])
                local completions = {}
                if
                  result.candidates
                  and result.candidates[1]
                  and result.candidates[1].content
                  and result.candidates[1].content.parts[1]
                then
                  local text = result.candidates[1].content.parts[1].text
                  -- Simple split by newline for now. Can be improved.
                  for _, line in ipairs(vim.split(text, "\n")) do
                    table.insert(completions, {
                      label = line,
                      kind = cmp.lsp.CompletionItemKind.Text,
                    })
                  end
                end
                callback(completions)
              else
                vim.notify("Gemini API request failed", vim.log.levels.ERROR)
                callback({})
              end
            end,
          })
          :start()
      end

      -- Register the source with nvim-cmp
      cmp.register_source("gemini", GeminiSource)
    end,
  },
}
