set nocompatible
filetype off

let hostname = substitute(system('hostname'), '\n', '', '')

" set the runtime path to include Vundle and initialize
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
if hostname != "CuBox"
    Plugin 'https://github.com/klen/python-mode.git'
endif
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set number
set cursorline

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4

syntax on

" set foldmethod=indent
set foldlevel=1
set foldcolumn=1
set foldminlines=25

set hlsearch
set ttyfast
set ttymouse=xterm2
set mouse=a

for scheme in [ 'default', 'desert', 'peachpuff', 'pablo' ]
  try
    execute 'colorscheme '.scheme
    break
  catch
    continue
  endtry
endfor

" Furthe color config is here to avoid being cleared by themes
set background=dark
highlight ColorColumn ctermbg=white ctermfg=black
if exists('+colorcolumn')
    set colorcolumn=81
else
    match ColorColumn /\%81v.\+/
endif

vnoremap < <gv
vnoremap > >gv

execute ':silent !mkdir -p ~/.vim/swap-files'
set swapfile
set dir=~/.vim/swap-files

" Auto-load vimrc
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC |
        if has('gui_running') | so $MYGVIMRC | endif
augroup END

