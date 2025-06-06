-- lua/plugins/avante.lua

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  -- This build step is crucial to compile the plugin's Rust components.
  -- This will fix the "missing avante_templates" error.
  build = "make", -- For Linux and macOS
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1" -- Uncomment and use this line for Windows

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
    },
  },

  opts = {
    -- Set Gemini as the provider
    provider = "gemini",
    providers = {
      gemini = {
        -- You can change this to other Gemini models like "gemini-1.5-pro"
        model = "gemini-1.5-flash",
        timeout = 30000,
        use_ReAct_prompt = true,
        extra_request_body = {
          generationConfig = {
            temperature = 0.75,
          },
        },
      },
      -- You can keep other provider configurations here if you plan to switch between them
      openai = {
        model = "gpt-4o",
      },
    },
  },

  config = function(_, opts)
    require("avante").setup(opts)

    -- Setup nvim-cmp sources for avante
    local cmp_ok, cmp = pcall(require, "cmp")
    if not cmp_ok then
      return
    end

    cmp.register_source("avante_commands", require("cmp_avante.commands"):new())
    cmp.register_source("avante_mentions", require("cmp_avante.mentions"):new(require("avante.utils").get_chat_mentions))

    cmp.setup.filetype({ "AvanteInput" }, {
      enabled = true,
      sources = {
        { name = "avante_commands" },
        { name = "avante_mentions" },
      },
    })
  end,
}
