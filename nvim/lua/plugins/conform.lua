return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
    },
    formatters = {
      stylua = {
        command = "/run/current-system/sw/bin/stylua",
        args = { "-" },
        stdin = true,
      },
    },
  },
}

