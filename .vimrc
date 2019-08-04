" source the minimal vim config file.
source ~/.vimrc.minimal

set t_Co=256  " 256 color terminal
set wildmenu wildmode=longest,list,full  " better tab completion of file name
set backspace=indent,eol,start  " enable backspacing over everything
set ruler  " show line/column numbers
set showtabline=2  " show tabline at all times
set nowrap " disable soft/visual line wrapping
syntax enable  " enable syntax highlighting
colorscheme whitebg  " pick the customized whitebg theme
set nobackup nowritebackup noswapfile " disable backup and swap files
set hidden " Allow hidden buffers
set complete-=i  " Custom auto complete behavior.

" highlight the current line, the 81st column and trailing white space.
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
set cursorline colorcolumn=79
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" tab/indenting stuff
filetype plugin indent on
set expandtab tabstop=2 shiftwidth=2 softtabstop=2 indentkeys=<Tab>
set autoindent smartindent cindent

function! ToggleRelativeNumbering()
  if (&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
command! SaveSession execute "mksession! /tmp/vimbook.vim"
command! NoAutoIndent execute "setl noai nocin nosi inde="
command! GitDiff execute "! git vdiff -- " . shellescape(expand('%', 1))

" Key mappings
nmap * g*
map <Tab> ^i<Tab><Esc>^
nmap r :call ToggleRelativeNumbering()<CR>
noremap < :bprevious<CR>
noremap > :bnext<CR>
nmap :E :e <C-R>=expand("%")<CR>
nmap :D :e <C-R>=fnamemodify(expand("%"), ":p:h")."/"<CR>

" Misc language-specific settings
let c_no_curly_error=1
let html_no_rendering=1

" Custom detection of certain file types.
autocmd BufReadPre,BufNewFile *.proto set filetype=proto
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Clang format for occasional C++ coding
map <C-K> :pyf ~/.vim/plugin/clang-format.py<cr>
imap <C-K> <c-o>:pyf ~/.vim/plugin/clang-format.py<cr>

" Experimental settings
set wrap
set showbreak=▸▸
" set relativenumber
set matchpairs+=<:>  " for matching c++ template brackets.
set splitbelow
set splitright

let macvim_skip_colorscheme=1
command! Markdown execute "silent !mdless 2>/dev/null ".expand('%:p') | execute ":redraw!"
command! -nargs=+ -complete=file Grep silent execute "grep! <args>" | execute ":redraw!" | execute ":botright cwindow"
command! -nargs=+ -complete=file Bzl silent execute "!devdocker exec bazel <args> 2>&1 | tee /tmp/mybazel.out" | silent execute ":cfile /tmp/mybazel.out" | execute ":redraw!" | execute ":botright cwindow"
command! -complete=file BzlErrors silent execute ":cfile /tmp/mybazel.out" | execute ":redraw!" | execute ":botright cwindow"
command! -nargs=+ -complete=file CodeGrep silent execute "!tools/codegrep <args> 2>&1 | tee /tmp/mycodegrep.out" | | silent execute ":cfile /tmp/mycodegrep.out" | execute ":redraw!" | execute ":botright cwindow"
command! FuzzyOpen call fzf#run(fzf#wrap({'source': 'find -L . -type d \( -name "bazel-*" -o -name .git \) -prune -o -print'}))
nmap ;fo :FuzzyOpen<CR>
