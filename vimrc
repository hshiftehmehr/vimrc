set nocompatible
set encoding=utf-8
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
Plugin 'flazz/vim-colorschemes'
Plugin 'https://github.com/pangloss/vim-javascript.git'
Plugin 'https://github.com/vim-syntastic/syntastic.git'
Plugin 'https://github.com/davidhalter/jedi-vim.git'
Plugin 'https://github.com/tpope/vim-fugitive'
Plugin 'https://github.com/scrooloose/nerdtree'
Plugin 'https://github.com/Xuyuanp/nerdtree-git-plugin'
" Plugin 'https://github.com/tomasr/molokai'
" Plugin 'https://github.com/nanotech/jellybeans.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

for scheme in [ 'jellybeans', 'molokai', 'default']
  try
    execute 'colorscheme '.scheme
    break
  catch
    continue
  endtry
endfor

" Further color config is here to avoid being cleared by themes
set background=dark
highlight ColorColumn ctermbg=DarkGray guibg=DarkGray ctermfg=White
if exists('+colorcolumn')
    set colorcolumn=80
else
    match ColorColumn /\%80v./
endif
highlight clear SpellBad
highlight SpellBad cterm=underline

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

syntax on

augroup NERD
    autocmd!
    autocmd VimEnter * NERDTree
    autocmd VimEnter * wincmd p
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_python_pylint_post_args="--max-line-length=120"
let g:syntastic_python_flake8_post_args="--max-line-length=120"
if exists('+colorcolumn')
    set colorcolumn=120
endif
let g:syntastic_always_populate_loc_list = 1
" Toggle loc_list with 'Errors' and 'lclose'
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" set foldmethod=indent
" set foldlevel=1
" set foldcolumn=1
" set foldminlines=25

set hlsearch
set ttyfast
set ttymouse=xterm2
set mouse=a

vnoremap < <gv
vnoremap > >gv

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

execute ':silent !mkdir -p ~/.vim/swap-files'
set swapfile
set dir=~/.vim/swap-files

" Auto-load vimrc
augroup MYVIMRC
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC |
        if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

