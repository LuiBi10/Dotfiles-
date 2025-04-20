-- This file contains the configuration for the nvim-dap plugin in Neovim.

return {
  {
    -- Plugin: nvim-dap
    -- URL: https://github.com/mfussenegger/nvim-dap
    -- Description: Debug Adapter Protocol client implementation for Neovim.
    "mfussenegger/nvim-dap",
    recommended = true, -- Recommended plugin
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {
      -- Plugin: nvim-dap-ui
      -- URL: https://github.com/rcarriga/nvim-dap-ui
      -- Description: A UI for nvim-dap.
      "rcarriga/nvim-dap-ui",

      -- Plugin: nvim-dap-virtual-text
      -- URL: https://github.com/theHamsta/nvim-dap-virtual-text
      -- Description: Virtual text for the debugger.
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {}, -- Default options
      },

      -- Plugin: nvim-dap-python
      -- URL: https://github.com/mfussenegger/nvim-dap-python
      -- Description: Python adapter for nvim-dap.
      {
        "mfussenegger/nvim-dap-python",
      },
    },

    -- Keybindings for nvim-dap
    keys = { ... }, -- Keeping existing keybindings unchanged

    config = function()
      local dap = require("dap")
      local dap_python = require("dap-python")
      local dapui = require("dapui")

      -- Load mason-nvim-dap if available
      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end

      -- Set highlight for DapStoppedLine
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- Define signs for DAP
      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- Setup DAP configuration using VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      if vim.fn.filereadable(".vscode/launch.json") then
        vscode.load_launchjs()
      end

      -- Function to load environment variables
      local function load_env_variables()
        local variables = {}
        for k, v in pairs(vim.fn.environ()) do
          variables[k] = v
        end

        local env_file_path = vim.fn.getcwd() .. "/.env"
        local env_file = io.open(env_file_path, "r")
        if env_file then
          for line in env_file:lines() do
            for key, value in string.gmatch(line, "([%w_]+)=([%w_]+)") do
              variables[key] = value
            end
          end
          env_file:close()
        else
          print("Error: .env file not found in " .. env_file_path)
        end
        return variables
      end

      -- Python DAP Configuration using nvim-dap-python
      dap_python.setup("python") -- Adjust this if using a virtualenv

      -- Ensure dap-ui remains open when debugging starts and does not close on termination
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        -- Commented out to keep dap-ui open
        -- dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        -- Commented out to keep dap-ui open
        -- dapui.close()
      end
    end,
  },
}
