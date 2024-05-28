local lsp = require('lsp-zero')

lsp.preset('recommended')

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'eslint',
        'lua_ls',
--        'csharp_ls@0.11.0',
    },
    automatic_installation = true,
    handlers = {
        lsp.default_setup,
    },
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

local navic = require('nvim-navic')

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end)

lsp.set_preferences({
    sign_icons = { }
})

lsp.extend_lspconfig()
lsp.on_attach(function(_, bufnr)
    local opts = {buffer = bufnr, remap = false}

--    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostics.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostics.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostics.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vc", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>vh", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()
