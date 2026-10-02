" Minimal Vim config without plugins, adapted from the former Neovim setup.
" Colors come from the terminal palette, so Vim follows the active terminal theme.

" ═══ Globals ═════════════════════════════════════════════════

let mapleader = " "
let maplocalleader = " "

filetype plugin indent on
syntax on

" packages bundled with Vim: highlight on yank, gc to comment (like Neovim)
silent! packadd! hlyank
silent! packadd! comment

" ═══ Options ═════════════════════════════════════════════════

" Neovim defaults that Vim lacks
set autoread belloff=all display=lastline laststatus=2 nrformats-=octal
set ruler showcmd wildmenu ttimeout ttimeoutlen=50

" tab / indentation
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set autoindent smartindent breakindent nowrap

set updatetime=250
set mouse=a

" search
set incsearch hlsearch ignorecase smartcase

" appearance
set number relativenumber
set colorcolumn=80,120
set cursorline cursorlineopt=number
set scrolloff=5

set hidden noswapfile nobackup
set splitright splitbelow
set backspace=indent,eol,start

" Save undo history
set undofile undodir=~/.vim/undodir
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p", 0700)
endif

if has("clipboard")
  set clipboard=unnamed
endif

" Folding
set foldmethod=indent foldlevel=99

" :find searches the project, :grep uses ripgrep when installed
set path=.,,**
set wildignore+=*/.git/*,*/node_modules/*
if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case grepformat=%f:%l:%c:%m
endif

augroup vimrc
  autocmd!
  " Tone down the red/yellow accents of the default colorscheme
  autocmd ColorScheme default highlight ColorColumn ctermbg=8
  autocmd ColorScheme default highlight LineNr ctermfg=8
  autocmd ColorScheme default highlight CursorLineNr cterm=bold ctermfg=NONE
  " open the quickfix list after :grep
  autocmd QuickFixCmdPost grep cwindow | redraw!
augroup END
colorscheme default

" ═══ Keymaps ═════════════════════════════════════════════════

" Disable space bar
nnoremap <Space> <Nop>

" tmux session
nnoremap <C-f> <Cmd>call system("tmux neww tmux_session")<CR>

" crazy save
nnoremap <Leader>w <Cmd>w<CR>

" clear highlight like Neovim's <C-l>; mapping <Esc> breaks terminal key codes
nnoremap <C-l> <Cmd>nohlsearch<Bar>diffupdate<CR><C-l>

" save and source file
nnoremap <Leader>xx <Cmd>w<Bar>source %<CR>

" Yank current file path to system clipboard
nnoremap <Leader>fp <Cmd>let @+ = expand("%:p")<Bar>echo "Copied to clipboard: " . @+<CR>

" find and replace word under cursor
nnoremap <Leader>rw :%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>

" dont overwrite paste register
xnoremap p "_dP

" U for Redo
nnoremap U <C-r>

" alternate file
nnoremap <Leader>a <C-^>

" split panes
nnoremap <Leader>% <Cmd>vsplit<CR>
nnoremap <Leader>" <Cmd>split<CR>

" pane navigation
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
nnoremap <Leader>q <C-w>q
nnoremap <Leader>o <C-w>o

" vertical navigation with center
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap { {zz
nnoremap } }zz
nnoremap N Nzz
nnoremap n nzz

" qf list
nnoremap <Leader>co <Cmd>copen<CR>
nnoremap <Leader>cc <Cmd>cclose<CR>
nnoremap <Leader>cn <Cmd>cnext<CR>
nnoremap <Leader>cp <Cmd>cprev<CR>
nnoremap <Leader>ch <Cmd>chistory<CR>

" tabs
nnoremap <Leader>to <Cmd>tabedit %<CR>
nnoremap <Leader>tc <Cmd>tabclose<CR>
nnoremap <Leader>tn <Cmd>tabnext<CR>
nnoremap <Leader>tp <Cmd>tabprevious<CR>

" resize
nnoremap <Leader>+ <Cmd>vertical resize +5<CR>
nnoremap <Leader>- <Cmd>vertical resize -5<CR>
nnoremap <Leader>* <Cmd>resize +5<CR>
nnoremap <Leader>_ <Cmd>resize -5<CR>

" buffer navigation
nnoremap <S-l> <Cmd>bnext<CR>
nnoremap <S-h> <Cmd>bprevious<CR>

" crazy esc
inoremap jk <Esc>
inoremap jj <Esc>
inoremap kk <Esc>

" insert newline stay in normal mode
nnoremap <Leader>nl o<Esc>
nnoremap <Leader>nL O<Esc>

" stay in indent mode
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

" move text up down
xnoremap <silent> J :m '>+1<CR>gv=gv
xnoremap <silent> K :m '<-2<CR>gv=gv

" built-in stand-ins for former plugins: explorer, files, recent, buffers, grep
nnoremap _ <Cmd>Explore<CR>
nnoremap <Leader>ff :find<Space>
nnoremap <Leader>e :browse oldfiles<CR>
nnoremap <Leader>sb :ls<CR>:buffer<Space>
nnoremap <Leader>sg :silent grep!<Space>
