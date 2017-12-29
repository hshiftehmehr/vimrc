set nocompatible
filetype off

let hostname = substitute(system('hostname'), '\n', '', '')

" set the runtime path to include Vundle and initialize
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'https://github.com/davidhalter/jedi-vim.git'
Plugin 'https://github.com/tpope/vim-fugitive'
Plugin 'https://github.com/tomasr/molokai'
Plugin 'https://github.com/nanotech/jellybeans.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set spell
set path+=**

set relativenumber 
set number
set cursorline

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set formatoptions-=t

syntax on

" set foldmethod=indent
" set foldlevel=1
" set foldcolumn=1
" set foldminlines=25

set hlsearch
set ttyfast
set ttymouse=xterm2
set mouse=a

for scheme in [ 'jellybeans', 'default', 'desert', 'peachpuff', 'pablo' ]
  try
    execute 'colorscheme '.scheme
    break
  catch
    continue
  endtry
endfor

" Further color config is here to avoid being cleared by themes
set background=dark
highlight ColorColumn ctermbg=DarkGray " ctermfg=White
if exists('+colorcolumn')
    set colorcolumn=80
else
    match ColorColumn /\%80v./
endif
highlight clear SpellBad
highlight SpellBad cterm=underline

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

" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

