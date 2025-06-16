-- This file contains the configuration for various UI-related plugins in Neovim.

-- Set highlight for Snacks dashboard header
vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#8bd5ca", bold = true }) -- Kanagawa dragon red color

return {
  -- Plugin: snacks.nvim (with image preview)
  -- URL: https://github.com/folke/snacks.nvim
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
        preset = {
          header = [[
█████                   ███  █████      ███ 
░░███                   ░░░  ░░███      ░░░  
 ░███        █████ ████ ████  ░███████  ████ 
 ░███       ░░███ ░███ ░░███  ░███░░███░░███ 
 ░███        ░███ ░███  ░███  ░███ ░███ ░███ 
 ░███      █ ░███ ░███  ░███  ░███ ░███ ░███ 
 ███████████ ░░████████ █████ ████████  █████
]],
          -- Key mappings for the dashboard
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      -- Enable image preview for Snacks
      image = {
        doc = {
          enabled = true,
          inline = true,
          float = true,
          max_width = 80,
          max_height = 40,
        },
      },
      picker = {
        enabled = true,
      },
    },
  },

  -- Plugin: noice.nvim
  -- URL: https://github.com/folke/noice.nvim
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        cmdline = {
          view = "cmdline_popup",
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          lsp_doc_border = true,
        },
      })
    end,
  },

  -- Plugin: zen-mode.nvim
  -- URL: https://github.com/folke/zen-mode.nvim
  -- {
  --   "folke/zen-mode.nvim",
  --   cmd = "ZenMode",
  --   opts = {
  --     plugins = {
  --       gitsigns = true,
  --       tmux = true,
  --       kitty = { enabled = false, font = "+2" },
  --       twilight = { enabled = true },
  --     },
  --   },
  --   keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  -- },
  --
  -- Plugin: nvim-docs-view
  -- URL: https://github.com/amrbashir/nvim-docs-view
  {
    "amrbashir/nvim-docs-view",
    lazy = true,
    cmd = "DocsViewToggle",
    opts = {
      position = "right",
      width = 60,
    },
  },

  -- Plugin: lualine.nvim
  -- URL: https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    opts = {
      options = {
        theme = "tokyonight",
        icons_enabled = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = "󱗞",
          },
        },
      },
    },
  },

  -- Plugin: incline.nvim
  -- URL: https://github.com/b0o/incline.nvim
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = { cursorline = true },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- Plugin: mini.nvim
  -- URL: https://github.com/echasnovski/mini.nvim
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.animate").setup({
        resize = { enable = false },
        open = { enable = false },
        close = { enable = false },
        scroll = { enable = false },
      })
    end,
  },
}
