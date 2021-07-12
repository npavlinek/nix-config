local lsp_config = require('lspconfig')

local function on_attach(client, bufnr)
  local function buffer_map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = {silent = true, noremap = true}

  buffer_map('n', '<Leader>D', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buffer_map('n', '<Leader>d', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buffer_map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buffer_map('n', '<Leader>i', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buffer_map('n', '<Leader>r', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  buffer_map('n', '<Leader>w', '<Cmd>lua vim.lsp.diagnostic.get_prev()<CR>', opts)
  buffer_map('n', '<Leader>s', '<Cmd>lua vim.lsp.diagnostic.get_next()<CR>', opts)
end

local servers = {
  'clangd',
  'cmake',
  'tsserver'
}

for _, s in ipairs(servers) do
  lsp_config[s].setup {
    on_attach = on_attach
  }
end
