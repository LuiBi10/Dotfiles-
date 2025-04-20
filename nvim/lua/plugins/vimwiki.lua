return {
  -- Plugin de Vimwiki
  "vimwiki/vimwiki",
  lazy = false,  -- Asegura que se cargue correctamente
  init = function()
    vim.g.vimwiki_list = {
      {
        path = "~/Documents/Obsidian/Notes/random notes/",
        syntax = "markdown",
        ext = ".md",
      },
    }
    vim.g.vimwiki_ext2syntax = { [".md"] = "markdown" }  -- ← Corrección
  end,
}

