return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      marksman = {
        -- 🔒 usa la ruta exacta del binario instalado por Nix
        cmd = { "/run/current-system/sw/bin/marksman" },
        filetypes = { "markdown" },
        root_dir = require("lspconfig.util").root_pattern(".git", "."),
        single_file_support = true,
      },
    },
  },
}

