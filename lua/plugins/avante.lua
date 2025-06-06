-- lua/plugins/avante.lua
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make",
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
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          use_absolute_path = (vim.fn.has("win32") > 0),
        },
      },
    },
  },

  opts = {
    -- You can continue to use Gemini for the main chat/planning phase
    provider = "gemini",

    -- This new provider will be used specifically for the code application step.
    -- It's recommended to use a powerful model like gpt-4o or claude-3.5-sonnet for reliability.
    cursor_applying_provider = "gemini",

    behaviour = {
      -- This is the key change to enable the new mode
      enable_cursor_planning_mode = true,
      -- other behaviour settings...
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
    },

    providers = {
      gemini = {
        model = "gemini-1.5-flash",
        timeout = 30000,
        use_ReAct_prompt = false, -- Keep this as false
        extra_request_body = {
          generationConfig = {
            temperature = 0.75,
          },
        },
      },
      -- Define the provider for the 'cursor_applying_provider'
      openai = {
        model = "gpt-4o",
        extra_request_body = {
          temperature = 0.1, -- A lower temperature is often better for direct code application
        },
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
