nnoremap <silent> <C-P> :FZF<CR>

let g:lsc_server_commands = {
      \ 'cpp': 'clangd',
      \ 'go': {
      \   'command': 'gopls serve',
      \   'log_level': -1,
      \   'suppress_stderr': v:true,
      \ },
      \ 'javascript': 'typescript-language-server --stdio',
      \ 'typescript': 'typescript-language-server --stdio',
      \ }
let g:lsc_auto_map = v:true

augroup PluginAC
  autocmd!

  autocmd CompleteDone * silent! pclose
augroup END
