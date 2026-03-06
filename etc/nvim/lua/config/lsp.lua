vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    root_markers = { '.git' },
})

vim.lsp.enable({ 'pyright', 'gopls', 'terraformls' })
