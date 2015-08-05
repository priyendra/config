#! /bin/bash

FILENAME=$(mktemp)
cat << EOF >> $FILENAME
function! DiffNext()
  DirDiffNext
  wincmd t
endfunction
function! DiffPrev()
  DirDiffPrev
  wincmd t
endfunction

map <c-n> <c-[>:call DiffNext()<cr>
map <c-p> :DirDiffPrev<cr>wincmd t<cr>
map <c-j> ]c
map <c-k> [c

colorscheme deshwalReadOnly
set diffopt=filler,context:100000  " disable folding in diff windows
EOF
vim -R -f -c "source $FILENAME" \
          -c "DirDiff $1 $2"    \
          -c "wincmd t"
rm -f $FILENAME
