set nocompatible              " be iMproved, required
filetype off                  " required


" VUNDLE
" Command 'PluginInstall' to install 

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Trww view
Plugin 'scrooloose/nerdtree'
" Alignment
Plugin 'godlygeek/tabular'
" Markdown enable
Plugin 'plasticboy/vim-markdown'
" Tab completions
Plugin 'ervandew/supertab'
" Minimap
Plugin 'severin-lemaignan/vim-minimap'
" sublime text style multiple cursors
Plugin 'terryma/vim-multiple-cursors'
" View indent guides (:IndentGuides*)
Plugin 'nathanaelkane/vim-indent-guides'
" Better status bar
Plugin 'bling/vim-airline'
" Git wrapper
Plugin 'tpope/vim-fugitive'
" Python autocomplete
Plugin 'davidhalter/jedi-vim'
" Git line modification ui
Plugin 'airblade/vim-gitgutter'
" Syntax checking
Plugin 'vim-syntastic/syntastic'
" NERDTree git ui
Plugin 'Xuyuanp/nerdtree-git-plugin'
" Enhanced C++ highlighting
Plugin 'octol/vim-cpp-enhanced-highlight'
" airline themes
" Plugin 'vim-airline/vim-airline-themes'
" Distraction free writing
Plugin 'junegunn/goyo.vim'
" Pyhsics based scrolling
Plugin 'yuttie/comfortable-motion.vim'


" Disable folding in vim-markdown
let g:vim_markdown_folding_disabled = 1

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required



" VIM PLUG

call plug#begin()
Plug 'JuliaEditorSupport/julia-vim'
Plug 'rust-lang/rust.vim'
call plug#end()


" NERDTree

" NERDTree autostart on directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" NERDTree exit vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" COLOR THEME

syntax on
colorscheme monokai



" OTHER SETTINGS

set tabstop=4
set expandtab
set softtabstop=4 "make <tab> and <bs> insert and del 4 spaces
set shiftwidth=4
set cursorline
set mouse=a
" incremental 'live' search
set incsearch
" invisible chars
scriptencoding utf-8
set encoding=utf-8
set list listchars=tab:»·,trail:·

au FileType cpp,c setl mp=make\ %:t:r


"vim-airline view
set laststatus=2

let g:minimap_highlight='Visual'
" set spell spelllang=en_us

" run in browser
nnoremap <F12>f :exe ':silent !firefox %'<CR>


nnoremap <silent> <PageDown> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <PageUp> :call comfortable_motion#flick(-100)<CR>

" Keybindings
map <C-\> :NERDTreeToggle<CR>
map <C-m> :MinimapToggle<CR>
nnoremap ; :
