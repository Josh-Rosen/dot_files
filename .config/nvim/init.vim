" Josh Rosen's nvim init.vim

" Use junegunn/vim-plug to manage plugins
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-endwise', { 'for': ['ruby', 'elixir'] }
  Plug 'Yggdroot/indentLine'
  Plug 'wellle/targets.vim'
  Plug 'cloudhead/neovim-fuzzy'
  Plug 'crusoexia/vim-monokai'
  Plug 'w0rp/ale'
  " look into
  " vim-syntastic/syntastic
  " tabular
  " nathanaelkane/vim-indent-guides
  " ap/vim-css-color
call plug#end()

" disable arrow keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor\ --column

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" use Tab instead of Esc in Insert Mode
imap <Tab> <Esc>

" Use <c-p> for file searching
nnoremap <C-p> :FuzzyOpen<CR>

" use ag just like the Terminal
nnoremap ag :Ag<SPACE>

set encoding=utf-8

" show tabs and end of line as characters
set list
set listchars=tab:▸\ ,eol:¬

" using the monokai color scheme
syntax enable
colorscheme monokai

" use terminal background color
hi Normal ctermbg=none

" show indent spaces as
let g:indentLine_char = '│'

" no swapfile
set noswapfile

" set search coloring, must come after colorscheme
hi Search cterm=NONE ctermfg=black ctermbg=yellow

" set line numbers and set colors
set number
set numberwidth=2
" set number lines to terminal background color
hi LineNr term=bold cterm=None ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=DarkGrey

" make tab completion for files/buffers act like bash
set wildmenu

set cursorline
hi CursorLineNr term=bold ctermfg=Yellow ctermbg=None gui=bold guifg=Yellow

" going over 80 characters
set colorcolumn=80
hi ColorColumn ctermbg=DarkGray

" better way to open NERDTree
map <C-n> :NERDTreeToggle<CR>
" beter way to find the file in NERDTree
map <C-f> :NERDTreeFind<CR>

" close NERDTree if it's the only file open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1
" make NERDTree a bit prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" use │ to space vertical tabs
set fillchars=vert:\│
hi VertSplit ctermbg=NONE guibg=NONE

" sete the number of context lines you would like to see above and below the cursor
set scroll=10
" make .js and .jsx file highlighting interchangeable
let g:jsx_ext_required = 0

" Brace completion
inoremap {<CR> {<CR>}<Esc>ko
" Paren + Brace completion
inoremap ({<CR> ({<CR>});<Esc>ko

" Each indentation level is 2 spaces. Tabs are not used
set softtabstop=4 shiftwidth=4 expandtab

" Easily change buffer with direction
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l


" Don't auto lint while typing
let g:ale_lint_on_text_changed = 'never'
" Don't link whena  file opens
let g:ale_lint_on_enter = 0
