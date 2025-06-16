return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      marksman = {
        cmd = { "/run/current-system/sw/bin/marksman" },
        filetypes = { "markdown" },
        root_dir = require("lspconfig.util").root_pattern(".git", "."),
        single_file_support = true,
      },
      lua_ls = {
        cmd = { "/run/current-system/sw/bin/lua-language-server" },
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
          },
        },
      },
    },
  },
}

