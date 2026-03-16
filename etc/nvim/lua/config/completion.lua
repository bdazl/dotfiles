local cmp = require('cmp')

cmp.setup({
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    }),
    mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
    }),
})
