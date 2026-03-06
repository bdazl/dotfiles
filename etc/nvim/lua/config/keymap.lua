vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspKeymaps', { clear = true }),
    callback = function(ev)
        local opts = { buffer = ev.buf }

        -- Matching existing YCM keymaps
        vim.keymap.set('n', '<leader>t', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<leader>f', vim.lsp.buf.references, opts)

        -- Standard LSP keymaps
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    end,
})
