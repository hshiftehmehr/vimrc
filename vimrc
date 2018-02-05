set nocompatible
set encoding=utf-8
filetype off

let hostname = substitute(system('hostname'), '\n', '', '')

" set the runtime path to include Vundle and initialize
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Vundle manages itself
Plugin 'gmarik/Vundle.vim'
" let Vundle manage Vundle, required
Plugin 'Yggdroot/indentLine'
Plugin 'davidhalter/jedi-vim.git'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'
" NERDTree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
" Plugin 'vim-syntastic/syntastic.git'
" Colors
" Plugin 'flazz/vim-colorschemes'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'morhetz/gruvbox'
Plugin 'nanotech/jellybeans.vim'
Plugin 'tomasr/molokai'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

for scheme in [ 'jellybeans', 'default' ]
  try
    execute 'colorscheme '.scheme
    break
  catch
    continue
  endtry
endfor

" Further color config is here to avoid being cleared by themes
set spell
set cursorline
set hlsearch
set ttyfast
set ttymouse=sgr
set mouse=a
set clipboard=unnamed
set relativenumber
set number
set colorcolumn=80

syntax on
set background=dark
highlight clear SpellBad
highlight SpellBad cterm=underline

vnoremap < <gv
vnoremap > >gv

set path+=**

execute ':silent !mkdir -p ~/.vim/swap-files'
set swapfile
set dir=~/.vim/swap-files

" Auto-load vimrc
augroup MYVIMRC
  autocmd!
  autocmd BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc
    \ source $MYVIMRC |
    \ if has('gui_running') |
    \    source $MYGVIMRC |
    \ endif
augroup END

" Return to last edit position when opening files
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   execute "normal! g`\"" |
  \ endif

" Quit if NERDTree is the only open window
autocmd bufenter *
  \ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) |
  \   quit |
  \ endif
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowIgnoredStatus = 1
map <leader>f :NERDTreeToggle<CR>

autocmd FileType python call SetPythonOptions()

function! SetPythonOptions()
  setlocal expandtab
  setlocal tabstop=4
  setlocal softtabstop=4
  setlocal shiftwidth=4
  setlocal formatoptions-=t
  setlocal colorcolumn=120

  " pip install flake8 flake8-import-order flake8-import-style \
  "     flake8-logging-format flake8-mock flake8-quotes pylint autopep8 yapf
  let b:ale_python_flake8_options="
    \ --enable-extensions=G --max-line-length=120 --inline-quotes=double"
  let b:ale_python_pylint_options="
    \ --max-line-length=120"
endfunction
