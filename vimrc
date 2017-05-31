set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'https://github.com/klen/python-mode.git'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set number
set cursorline
if exists('+colorcolumn')
  set colorcolumn=81
else
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  match OverLength /\%81v.\+/
endif

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

" The following could also be configured in ~/.vim/ftdetect/cpp.vim
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp

for scheme in [ 'default', 'peachpuff', 'pablo' ]
  try
    execute 'colorscheme '.scheme
    break
  catch
    continue
  endtry
endfor
highlight ColorColumn ctermbg=white

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

set swapfile
set dir=~/.vim/swap-files

" Auto-load vimrc
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
