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
" Plugin 'flazz/vim-colorschemes'
Plugin 'https://github.com/nanotech/jellybeans.vim'
Plugin 'https://github.com/Yggdroot/indentLine'
Plugin 'https://github.com/vim-syntastic/syntastic.git'
Plugin 'https://github.com/davidhalter/jedi-vim.git'
Plugin 'https://github.com/tpope/vim-fugitive'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

autocmd FileType python call SetPythonOptions()

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
for scheme in [ 'molokai', 'jellybeans', 'default' ]
  try
    execute 'colorscheme '.scheme
    break
  catch
    continue
  endtry
endfor
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

    " highlight! ExtraWhitespace ctermbg=red guibg=red
    " match ExtraWhitespace /\s\+$/

    let g:syntastic_python_checkers=['flake8']
    let g:syntastic_python_flake8_post_args="--enable-extensions=G --max-line-length=120 --inline-quotes=double"

    let g:syntastic_always_populate_loc_list = 1
    " Toggle loc_list with 'Errors' and 'lclose'
    " let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
endfunction
