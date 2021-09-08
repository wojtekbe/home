" vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar.git'
Plugin 'sirtaj/vim-openscad.git'
Plugin 'scrooloose/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'wsdjeg/vim-fetch'
Plugin 'udalov/kotlin-vim'
Plugin 'bogado/file-line'
Plugin 'mileszs/ack.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'whiteinge/diffconflicts'
Plugin 'mglb/vim-indenty.git'
Plugin 'junegunn/fzf.vim'
call vundle#end()

filetype plugin indent on
syntax on

" colors (truecolors)
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum
let g:solarized_termcolors=256
set background=dark
colorscheme gruvbox
let g:airline_theme='gruvbox'
set t_Co=256
set termguicolors

if has("autocmd")
  "au FileType python,c,cpp TagbarOpen
  "jump to the last position when reopening a file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  au BufRead,BufNewFile *.pde set filetype=arduino
  au BufRead,BufNewFile *.ino set filetype=arduino
endif

set showcmd
set showmatch
set ignorecase
set smartcase
set incsearch
set autowrite
set hidden
set mouse=a
set hlsearch
set number
set backspace=indent,eol,start
set pastetoggle=<F9>
set nopaste
set wrap
set linebreak
set nolist
set wildmenu
set wildmode=longest,list
set showmode
set noswapfile
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set cindent
set cinoptions=g-1
set cursorline
set nofixendofline

"status bar info and appearance
set laststatus=2
set cmdheight=1

"powerline/airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" space bar un-highligts search
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

" Tagbar/NERDTree
map <F3> :TagbarToggle<CR>
map <F4> :NERDTreeToggle<CR>

map ; :

" omnicompletion
set ofu=syntaxcomplete#Complete
set completeopt-=preview

" tab navigation
" F2 ->
map <silent> <F2> :tabnext<cr>
imap <F2> <Esc><F2>
" S-F2 <-
map <Esc>[1;2Q <S-F2>
map <silent> <S-F2> :tabprevious<cr>
imap <S-F2> <Esc><S-F2>

" split navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" asterisk highlights only (not jumps)
nnoremap * :keepjumps normal! mi*`i<CR>

" Reload the same file in different encoding F8
function! ChangeFileencoding()
 let encodings = ['utf-8' , 'cp1250', 'iso-8859-2', 'cp852']
 let prompt_encs = []
 let index = 0
 while index < len(encodings)
 call add(prompt_encs, index.'. '.encodings[index])
 let index = index + 1
 endwhile
 let choice = inputlist(prompt_encs)
 if choice >= 0 && choice < len(encodings)
 execute 'e ++enc='.encodings[choice].' %:p'
 endif
endf
nmap <F8> :call ChangeFileencoding()<CR>

"jump to newtab (location or errors)
:set switchbuf+=usetab,newtab

" un/commenting blocks
vnoremap # :s/^/\/\/<cr><space>
vnoremap -# :s/^\/\///<cr><space>

"searching for selected text
vnorem // y/<c-r>"<cr>

" highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" java
autocmd filetype java setlocal omnifunc=javacomplete#Complete

set encoding=utf-8

" Ack uses ag
let g:ackprg = 'ag --nogroup --nocolor --column'
cnoreabbrev ags AckFromSearch!
cnoreabbrev ag Ack! <cword>
noremap & :Ack! <cword><cr>

" use system clipboard by default
set clipboard=unnamed

" ycm
let g:ycm_auto_hover = 0
let g:ycm_show_diagnostics_ui = 0

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" fzf
let g:fzf_preview_window = []
let g:fzf_action = {
  \ 'enter': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
cnoreabbrev ftabe Files
