-- Set leader before lazy.nvim (must match keymap.vim: let mapleader = ",")
vim.g.mapleader = ','

-- Lite mode: NVIM_LITE=1 disables heavy plugins (LSP, treesitter, mason)
vim.g.lite = vim.env.NVIM_LITE == '1'

-- Disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Bootstrap lazy.nvim
require('config.lazy')

-- Source shared vim config
local vimdir = vim.fn.expand('~/.etc/etc/vim/vim.d')
vim.cmd('source ' .. vimdir .. '/platform.vim')
vim.cmd('source ' .. vimdir .. '/plugins.vim')
vim.cmd('source ' .. vimdir .. '/general.vim')
vim.cmd('source ' .. vimdir .. '/keymap.vim')

-- LSP configuration
if not vim.g.lite then
    require('config.lsp')
    require('config.keymap')
end
