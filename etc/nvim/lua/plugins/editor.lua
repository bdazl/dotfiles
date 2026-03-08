return {
    { 'simnalamburt/vim-mundo' },
    { 'christoomey/vim-tmux-navigator' },
    { 'francoiscabrol/ranger.vim' },
    { 'tpope/vim-fugitive' },
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
                theme = {
                    normal   = { a = { fg = '#00005f', bg = '#5f87af' }, b = { fg = '#ffffff', bg = '#444444' }, c = { fg = '#9cffd3', bg = '#202020' } },
                    insert   = { a = { fg = '#00005f', bg = '#5f87af' } },
                    visual   = { a = { fg = '#00005f', bg = '#5f87af' } },
                    replace  = { a = { fg = '#00005f', bg = '#5f87af' } },
                    command  = { a = { fg = '#00005f', bg = '#5f87af' } },
                    inactive = { a = { fg = '#00005f', bg = '#5f87af' }, b = { fg = '#ffffff', bg = '#444444' }, c = { fg = '#9cffd3', bg = '#202020' } },
                },
                component_separators = '',
                section_separators = '',
            },
        },
    },
    { 'tpope/vim-surround' },
    { 'junegunn/fzf', build = ':call fzf#install()' },
    { 'junegunn/fzf.vim' },
    {
        'nvim-treesitter/nvim-treesitter',
        enabled = not vim.g.lite,
        build = ':TSUpdate',
        opts = {
            ensure_installed = { 'python', 'go', 'haskell', 'terraform', 'lua', 'bash', 'vim', 'vimdoc', 'yaml', 'json', 'markdown' },
            highlight = { enable = true },
        },
    },
}
