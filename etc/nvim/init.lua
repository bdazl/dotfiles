-- Set leader before lazy.nvim (must match keymap.vim: let mapleader = ",")
vim.g.mapleader = ','

-- Bootstrap lazy.nvim
require('config.lazy')

-- Source shared vim config
local vimdir = vim.fn.expand('~/.etc/etc/vim/vim.d')
vim.cmd('source ' .. vimdir .. '/platform.vim')
vim.cmd('source ' .. vimdir .. '/plugins.vim')
vim.cmd('source ' .. vimdir .. '/general.vim')
vim.cmd('source ' .. vimdir .. '/keymap.vim')

-- LSP configuration
require('config.lsp')
require('config.keymap')
