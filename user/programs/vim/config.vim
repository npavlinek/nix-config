if &compatible == 1
  set nocompatible
endif

set autoindent
set autoread
set backspace=indent,eol,start
set cursorline
set encoding=utf-8
set fileencoding=utf-8
set formatoptions+=j
set formatoptions-=c
set formatoptions-=t
set hidden
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:▸\ ,eol:¬
set mouse=a
set nobackup
set nohlsearch
set nojoinspaces
set nowrap
set ruler
set scrolloff=3
set shortmess+=I
set smartcase
set spelllang=en_us,sl
set splitbelow
set splitright
set textwidth=80
set writebackup

set wildmenu
set wildignore=*.o

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

if has('gui_running')
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  set guifont=Cascadia_Code:h10
endif

" Change the cursor to a line when in INSERT mode, and back to a bar when in
" NORMAL mode. Do this only in xterm and rxvt terminal emulators.
if match(&term, 'xterm') != -1 || match(&term, 'rxvt') != -1
  let &t_EI = "\e[2 q"
  let &t_SI = "\e[6 q"
  let &t_SR = "\e[4 q"
endif

if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

set statusline=%f\                 " Filename
set statusline+=%h                 " Help flag
set statusline+=%m                 " Modified flag
set statusline+=%r                 " Read-only flag
set statusline+=%=                 " Separation point
set statusline+=%y                 " Filetype
set statusline+=[%{&fileformat}]   " File format (line ending)
set statusline+=[%{&fileencoding}] " File encoding
set statusline+=\ [%04l/%04L]      " Line info
set statusline+=[%04c-%04v]        " Column info

syntax on
set background=dark

colorscheme nord

function! HSort()
  let l:curpos = getpos('.')[2]
  let l:str = getline('.')[curpos-1:]
  call append(line('.'), join(sort(split(str, ' ')), ' '))
  execute 'normal! d$J'
endfunction

inoremap jk <ESC>
nnoremap <silent> <leader>s :call HSort()<CR>

" Some common typos...
command! -bang -nargs=? -complete=file W w<bang> <args>
command! -bang -nargs=? -complete=file Wq wq<bang> <args>
command! -bang -nargs=? -complete=file WQ wq<bang> <args>
command! -bang Q q<bang>
command! -bang Qa qa<bang>
command! -bang QA qa<bang>

filetype plugin indent on

augroup CustomAC
  autocmd!

  autocmd BufRead,BufNewFile *.h setl filetype=c
  autocmd FileType c setl cindent et fo-=c fo-=t sts=2 sw=2 ts=2
  autocmd FileType cpp setl cindent cino=:0,g0,l1 et fo-=c fo-=t sts=2 sw=2 ts=2
  autocmd FileType gitcommit setl spell
  autocmd FileType hgcommit setl spell
  autocmd FileType markdown setl spell
augroup END
