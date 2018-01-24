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

if exists('+colorcolumn')
  set colorcolumn=80
endif

let g:syntastic_check_on_open = 1


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
  autocmd BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC |
    if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Return to last edit position when opening files
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   execute "normal! g`\"" |
  \ endif

autocmd FileType python call SetPythonOptions()

function! SetPythonOptions()
  setlocal expandtab
  setlocal tabstop=4
  setlocal softtabstop=4
  setlocal shiftwidth=4
  setlocal formatoptions-=t

  if exists('+colorcolumn')
    setlocal colorcolumn=120
  " else
  "     highlight! ColorColumn ctermbg=DarkGray guibg=DarkGray ctermfg=White
  "     match ColorColumn /\%80v./
  endif

  let b:ale_python_flake8_options="
    \ --enable-extensions=G --max-line-length=120 --inline-quotes=double"

  " highlight! ExtraWhitespace ctermbg=red guibg=red
  " match ExtraWhitespace /\s\+$/

  " let b:syntastic_python_checkers=['flake8']
  " let b:syntastic_python_flake8_post_args="
  "   \ --enable-extensions=G --max-line-length=120 --inline-quotes=double"
  "
  " let b:syntastic_always_populate_loc_list = 1
  " " Toggle loc_list with 'Errors' and 'lclose'
  " " let b:syntastic_auto_loc_list = 1
  " let b:syntastic_check_on_wq = 0
endfunction
