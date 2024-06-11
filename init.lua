require('charles')
vim.g.mapleader = " "
vim.opt.guicursor = ""
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
vim.cmd [[colorscheme vim]]
vim.opt.scrolloff = 5
require'lspconfig'.tsserver.setup {
  settings = {
    files = {
      -- Include paths for both src and test directories
      include = {
        "src/**",
        "test/**"
      }
    }
  }
}
