set nocompatible              " be iMproved, required
filetype off                  " required


" VUNDLE
" Installation:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" 'PluginInstall' to run installer
 

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'ervandew/supertab'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'davidhalter/jedi-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-syntastic/syntastic'

" Disable folding in vim-markdown
let g:vim_markdown_folding_disabled = 1

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required



" VIM PLUG
" Installation:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

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
" https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim

syntax on
colorscheme monokai



" OTHER SETTINGS

set tabstop=4
set shiftwidth=4
set cursorline
set mouse=a
" incremental 'live' search
set incsearch

"vim-airline view
set laststatus=2

let g:minimap_highlight='Visual'
" set spell spelllang=en_us

" run in browser
nnoremap <F12>f :exe ':silent !firefox %'<CR>

" Keybindings
map <C-\> :NERDTreeToggle<CR>
map <C-m> :MinimapToggle<CR>
