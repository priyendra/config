scriptencoding utf-8
set encoding=utf-8

colorscheme deshwal16 " pick the customized deshwal16 theme
set background=light " ironically, light works better in dark mode also!

set equalalways " make sure that windows always remain equal in size.
set incsearch hlsearch ignorecase smartcase " search related

" Key mappings
noremap , <C-w>W
noremap . <C-w>w

set t_Co=256  " 256 color terminal
set wildmenu wildmode=longest,list,full  " better tab completion of file name
set backspace=indent,eol,start  " enable backspacing over everything
set ruler  " show line/column numbers
set showtabline=2  " show tabline at all times
set nowrap " disable soft/visual line wrapping
syntax enable  " enable syntax highlighting
set nobackup nowritebackup noswapfile " disable backup and swap files
set hidden " Allow hidden buffers
set complete-=i  " Custom auto complete behavior.

" highlight the current line, the 81st column and trailing white space.
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
set cursorline colorcolumn=76
set list listchars=tab:\│\ ,trail:·
set list

" tab/indenting stuff
filetype plugin indent on
set tabstop=2 shiftwidth=2 softtabstop=2 indentkeys=<Tab>
set autoindent

command! SaveSession execute "mksession! /tmp/vimbook.vim"
command! NoAutoIndent execute "setl noai nocin nosi inde="

" Key mappings
nmap * g*
map <Tab> ^i<Tab><Esc>^
" noremap < :bprevious<CR>
" noremap > :bnext<CR>
noremap < :wincmd R<CR>
noremap > :wincmd r<CR>
nmap :E :e <C-R>=expand("%")<CR>
nmap :D :e <C-R>=fnamemodify(expand("%"), ":p:h")."/"<CR>

" Misc language-specific settings
let c_no_curly_error=1
let html_no_rendering=1

" Custom detection of certain file types.
autocmd BufReadPre,BufNewFile *.proto set filetype=proto
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Clang format for supported file types.
autocmd FileType go nmap <buffer> <C-K> :GoFmt<CR>
autocmd FileType cpp map <buffer> <C-K> :pyf ~/.vim/plugin/clang-format.py<CR>
autocmd FileType proto map <buffer> <C-K> :pyf ~/.vim/plugin/clang-format.py<CR>
autocmd FileType java map <buffer> <C-K> :pyf ~/.vim/plugin/clang-format.py<CR>

" Experimental settings
set wrap
set showbreak=▸▸
set relativenumber
set numberwidth=2
set matchpairs+=<:>  " for matching c++ template brackets.
set splitbelow
set splitright

" Open quickfix window automatically if there are valid errors/locations.
augroup myvimrc
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END
" Always open the quickfix window at the bottom of the screen and increase
" its default height.
:autocmd FileType qf wincmd J
:autocmd FileType qf resize 15

let macvim_skip_colorscheme=1

function! ArgsOrWordUnderCursor(args)
  if len(a:args) == 0
    return expand('<cword>')
  endif
  return a:args
endfunction
command! BzlBuild AsyncRun tools/vimbazel buildfile %
command! BzlTest AsyncRun tools/vimbazel testfile %

command! -nargs=* -complete=file JavaFind cgetexpr system("git grep -E -n '((class)\|(interface)\|(enum)) '".ArgsOrWordUnderCursor(<q-args>))
command! -nargs=* -complete=file GitGrep cgetexpr system("git grep -E -n ".ArgsOrWordUnderCursor(<q-args>))
command! GitDiff execute "! git difftool -d -- " . shellescape(expand('%', 1))

command! FuzzyOpen call fzf#run(fzf#wrap({'source': 'find -L . -type d \( -name "bazel-*" -o -name .git \) -prune -o -print'}))
let g:fzf_colors =
  \ { 'fg':    ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'fg+':     ['fg', 'TODO'],
  \ 'bg+':     ['bg', 'CursorLine'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'hl+':     ['fg', 'Comment'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
nmap ;bt :BzlTest<CR>
nmap ;bb :BzlBuild<CR>
nmap ;fo :FuzzyOpen<CR>
" jsi = java skip imports i.e. positions cursor at the last import declaration
nmap ;jsi gg?^import <CR>:noh<CR>zt
nmap ;jctor gg/<C-R>=expand("%:t:r")<CR>(<CR>
nmap ;qfl :copen<CR>35<C-w>_
nmap ;gray :highlight Normal ctermbg=254<CR>
nnoremap <Space> :
nnoremap q<Space> q:

" By default, Vim's go mode shows an annoying error on tabs until some text
" is added to the current line. We disable that behavior here.
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
function! GoFmtFn()
  silent write
  execute system("gofmt -e ".expand("%")." > /tmp/gofmt.out 2>/tmp/gofmt.err")
  if v:shell_error
    cgetexpr system("cat /tmp/gofmt.err")
  else
    let save_pos = getpos(".")
    1,$!cat /tmp/gofmt.out
    silent write
    call setpos('.', save_pos)
  endif
endfunction
command! GoFmt call GoFmtFn()

" Always default to bash mode for filetype=sh syntax highlighting.
let g:is_bash=1

" Add an errorformat that works well with JUnit
set errorformat+=%m{{{%f:%l}}}

let g:asyncrun_open=20
let g:asyncrun_bell=1

" Helpful alias for debugging syntax highlighting issues
map ;syn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'. synIDattr(synID(line("."),col("."),0),"name") . "> lo<". synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

let g:netrw_banner=0
let g:netrw_liststyle = 3
let g:netrw_browse_split=4
let g:netrw_winsize=40
let g:netrw_altv=1

" Change the cursor mode to be horizontal bar in normal mode.
set guicursor=n-v-c-sm:hor20,i-ci-ve:ver25,r-cr-o:block
