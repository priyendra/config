" Source the minimal vim config file.
source ~/.vimrc.minimal

" indicate has terminal 256 colors
set t_Co=256

" make sure that windows always remain equal in size.
set equalalways

" better tab completion of file names
set wildmode=longest,list,full
set wildmenu

autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
set cursorline

" search related
set incsearch
set hlsearch
set ignorecase
set smartcase

" visual bell
set visualbell

" disable soft line wrapping
set nowrap

" disable backup and swap files
set nobackup
set nowritebackup
set noswapfile

" tab/indenting stuff
set expandtab
set tabstop=8 " 8 so that hard tabs are easy to notice.
set shiftwidth=2
set softtabstop=2
" set textwidth=80
filetype plugin indent on

set cinkeys=0{,0},0),0#,!<Tab>,;,:,o,O,e
set indentkeys=!<Tab>,o,O
map <Tab> i<Tab><Esc>^
filetype indent on
set cinoptions=l1,g0.5s,h0.5s,i2s,+2s,(0,W2s
set cinkeys=0{,0},:,0#,!<Tab>,!^F

" disable auto addition of comments
au FileType * setl fo-=cro

" highlighting/syntax coloring
if &ro
  colorscheme deshwalReadOnly
else
  colorscheme deshwal
endif
syntax enable

" Allow hidden buffers
set hidden

" Show tabline at all times.
set showtabline=2

" Only works with VIM 7.3+
set colorcolumn=81,82,83,84

" Enable persistent undo
set undolevels=10000
set undodir=/home/deshwal/.vimundo
set undofile

let html_no_rendering=1

" Key mappings
nmap <F2> :vsplit<CR>
nmap , <C-w>W
nmap . <C-w>w
nmap < :bprevious<CR>
nmap > :bnext<CR>
nmap :E :e <C-R>=expand("%")<CR>

" Highlight trailing whitespace
syntax match TrailingWhitespace /  *$/ containedin=ALL
au BufRead,BufNewFile * syntax match TrailingWhitespace /  *$/
hi TrailingWhitespace guifg=NONE guibg=#ff9999

" A command to save a vim session to a file
command! SaveSession execute "mksession! /tmp/vimbook.vim"

" A command to disable auto indentation for the current file.
command! NoAutoIndent execute "setl noai nocin nosi inde="

command! GitRevert execute "! git checkout " . shellescape(expand('%', 1))
command! GitDiff   execute "! git vimdiff -- " . shellescape(expand('%', 1))

" Enclose a range in #if 0 ... #endif
command! -range=% CComment :normal `<i#if 0<CR><ESC> `>a<CR>#endif<ESC>

" Custom auto complete behavior.
set complete-=i

" Create custom alias for seeing scons errors inside vim.. We define two of them
" since the two are often mis-typed.
command! SConsErrors execute ":cfile scons/scons.log"
command! SConsErrors execute ":cfile scons/scons.log"

" Set up scons to work from inside vim
set makeprg=/usr/bin/scons

" Enable syntax highlighting for scons files.
autocmd BufReadPre SConstruct set filetype=python
autocmd BufReadPre SConscript set filetype=python

" Enable syntax highlighting for proto files
autocmd BufReadPre *.proto set filetype=proto
