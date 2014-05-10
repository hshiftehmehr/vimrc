set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'davidhalter/jedi-vim'

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
" Optional:
Bundle "honza/vim-snippets"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set number
set colorcolumn=80

set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4

syntax on

set foldmethod=indent
set foldlevel=1
set foldcolumn=1
set foldminlines=5

set hlsearch
set mouse=a

if has('gui_running')
    if has("gui_macvim")
        set background=dark
        colorscheme desert
    else
        set background=light
    endif
else
    set background=dark
endif

vnoremap < <gv
vnoremap > >gv

" Auto-load vimrc
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
