return {
    {
        'neovim/nvim-lspconfig',
    },
    {
        'mason-org/mason-lspconfig.nvim',
        opts = {
            ensure_installed = { 'pyright', 'gopls', 'terraformls' },
        },
        dependencies = {
            { 'mason-org/mason.nvim', opts = {} },
            'neovim/nvim-lspconfig',
        },
    },
}
