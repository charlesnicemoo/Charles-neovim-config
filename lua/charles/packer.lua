-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- USE :so to get this "shouted out" then run packer
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
--   use {
--     'nvim-telescope/telescope.nvim', tag = '0.1.2',
--     -- or                            , branch = '0.1.x',
--     requires = { {'nvim-lua/plenary.nvim'} }
--   }
--  use('nvim-treesitter/nvim-treesitter', {run =  ':TSUpdate'})
  use {'theprimeagen/harpoon', requires = {{ 'nvim-lua/plenary.nvim' }} }
  use('theprimeagen/vim-be-good')
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.api.nvim_command, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }
  use('artur-shaik/vim-javacomplete2')
  -- use ('mfussenegger/nvim-jdtls')
end)
