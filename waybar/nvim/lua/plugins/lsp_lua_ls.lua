return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lua_ls = {
        cmd = { "lua-language-server" }, -- usa el binario del sistema
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

