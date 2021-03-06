set nocompatible              " be iMproved, required
filetype off                  " required

let mapleader = ","
set backspace=2



" VimPlug
"""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-multiple-cursors' " sublime text style multiple cursors
Plug 'bling/vim-airline' " Better status bar
Plug 'airblade/vim-gitgutter' " Git line modification ui
Plug 'octol/vim-cpp-enhanced-highlight' " Enhanced C++ highlighting
Plug 'vim-airline/vim-airline-themes' " airline themes
Plug 'flazz/vim-colorschemes' " Colorscheme Management
Plug 'scrooloose/nerdcommenter' " Quickly comment selections
Plug 'kien/rainbow_parentheses.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'  " Simple tab completions

" Extras
Plug 'nick-paul/aya-vim'
Plug 'scrooloose/nerdtree'  " Tree View
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'Xuyuanp/nerdtree-git-plugin' " NERDTree git ui
Plug 'yuttie/comfortable-motion.vim' " Pyhsics based scrolling
Plug 'alvan/vim-closetag' " Autoclose (X)HTML tags
Plug 'JuliaEditorSupport/julia-vim' " Julia Support
Plug 'dag/vim-fish'     " Fish Support
Plug 'dyng/ctrlsf.vim'  " Async project searching

call plug#end()


" COLOR / THEME
"""""""""""""""""""
syntax on
colorscheme Monokai         " :colorscheme <color>
let g:airline_theme='dark'  " :AirlineTheme <color>


" BASIC SETTINGS
""""""""""""""""""""

set clipboard=unnamedplus   " use system clipboard by default
set tabstop=4               " make tabsize 4 spaces
set expandtab               " use spaces instead of tabs
set softtabstop=4           " make <tab> and <bs> insert and del 4 spaces
set shiftwidth=4            " width when shifting
set cursorline              " Highlight current line
set mouse=a                 " Enable mouse support
set incsearch               " incremental 'live' search
scriptencoding utf-8        " invisible chars
set scrolloff=2             " two lines above and below the cursor when scrolling
set encoding=utf-8          " Unicode support
set spelllang=en_us         " Spellcheck dictionary
set whichwrap+=<,>,h,l,[,]  " Wrap when pressing arrow keys"
set list listchars=tab:»·,trail:·
" Spellcheck highlighting
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
set splitbelow
set splitright
set pumblend=24
set pumheight=10
set termguicolors

" undo files
call mkdir(glob('~/') . '.var/neovim/undofiles', 'p')
set undodir=$HOME/.var/neovim/undofiles " where to save undo histories

" Quickly open/reload vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" When the completion menu is shown, <CR> will select the
"   current item without inserting a newline
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
:set completeopt=longest,menuone

" Searching
" Ignore case by default, if upper is used, it won't match lower
set ignorecase
set smartcase

" Persistant Undo
set undofile                " Save undos after file closes
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo


" PLUGIN SETTINGS
"""""""""""""""""

" Rainbow Parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
" FZF
nnoremap <C-p> :FZF <CR>
" XHTML Autoclose
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.launch,*.js'
let g:closetag_shortcut = '>'
" CtrlSF
nnoremap <leader>F :CtrlSF
let g:ctrlsf_mapping = {"quit" : "Z"}
if has('nvim')
    " NERDTree
    autocmd StdinReadPre * let s:std_in=1   " NERDTree autostart on directory
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
    " NERDTree exit vim if only NERDTree is open
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    let NERDTreeShowHidden=1                " show hidden files
    " Hide certain files
    let NERDTreeIgnore=['\.pyc$']
    let g:NERDTreeGitStatusUpdateOnWrite = 0
    " Comfortable Motion
    nnoremap <silent> <PageDown> :call comfortable_motion#flick(100)<CR>
    nnoremap <silent> <PageUp> :call comfortable_motion#flick(-100)<CR>
    nnoremap <silent> <S-Up> :call comfortable_motion#flick(-100)<CR>
    nnoremap <silent> <S-Down> :call comfortable_motion#flick(100)<CR>
endif



" KEY MAPPINGS
""""""""""""""""

" Quick Settings
nnoremap <leader>n :set number!<CR>
nnoremap <leader>p :set paste<CR>p :set nopaste<CR>
" Window Navigation
map <C-Left> <C-w><Left>
map <C-Right> <C-w><Right>
map <C-Up> <C-w><Up>
map <C-Down> <C-w><Down>
" move selected lines up/down one line
xnoremap <C-Up>  :m-2<CR>gv=gv
xnoremap <C-Down> :m'>+<CR>gv=gv
" Tab / untab lines
vnoremap > >gv
vnoremap < <gv
" Toggle Line Comments
vmap <C-k> <leader>c<space>
nmap <C-k> <leader>c<space>
" Cursor Navigation
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>
" Macros
nnoremap Q @q
" Spell check
nnoremap <leader>; ea<C-X>s
" Quick Tab Movements
nnoremap << gT
nnoremap >> gt

" Remaps
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("W","w")
call SetupCommandAlias("Q","q")
call SetupCommandAlias("Wa","wa")
call SetupCommandAlias("Qa","qa")
call SetupCommandAlias("Wq","wq")

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
end



" OTHER SETTINGS
""""""""""""""""""

" ROS
autocmd BufNewFile,BufRead *.launch setf xml
autocmd BufNewFile,BufRead *.cfg setf python

" Custom Functions
""""""""""""""""""""""

function! WSRemove ()
    :%s/\s\+$//
endfunction
command! WSRemove :call WSRemove()

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
