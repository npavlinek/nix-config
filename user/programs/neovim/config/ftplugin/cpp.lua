vim.bo.cindent = true
vim.bo.cinoptions = table.concat({':0', 'g0', 'l1', 'N-s'}, ',')

vim.cmd('au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
