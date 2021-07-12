vim.cmd('command! -bang -nargs=? -complete=file W w<bang> <args>')
vim.cmd('command! -bang -nargs=? -complete=file Wq wq<bang> <args>')
vim.cmd('command! -bang -nargs=? -complete=file WQ wq<bang> <args>')
vim.cmd('command! -bang Q q<bang>')
vim.cmd('command! -bang Qa qa<bang>')
vim.cmd('command! -bang QA qa<bang>')

local h = require('helper')

h.imap('jk', '<Esc>')
h.nmap('<C-p>', '<Cmd>Files<CR>')
