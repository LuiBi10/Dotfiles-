return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      marksman = {
        cmd = { "marksman" }, -- usa el binario del sistema
        filetypes = { "markdown" },
        root_dir = require("lspconfig.util").root_pattern(".git", "."),
        single_file_support = true,
      },
    },
  },
}

