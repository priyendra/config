hi clear
if exists("syntax_on")
  syntax reset
endif

"Load the 'base' colorscheme - the one you want to alter
runtime colors/default.vim

"Override the name of the base colorscheme with the name of this custom one
let g:colors_name = "whitebg"

"Clear the colors for any items that you don't like
hi clear StatusLine
hi clear StatusLineNC
hi clear CursorLine
hi clear Error
hi clear TabLine
hi clear TabLineFill
hi clear TabLineSel
hi clear VertSplit
hi clear Visual

" The color codes used here are standard 256 color indices.
" These were taken from https://jonasjacek.github.io/colors/
hi StatusLine       ctermfg=white ctermbg=240  cterm=none
hi StatusLineNC     ctermfg=black ctermbg=251  cterm=none
hi CursorLine       ctermfg=none  ctermbg=255  cterm=none
hi Error            ctermfg=198   ctermbg=none cterm=reverse
hi TabLine          ctermfg=black ctermbg=251  cterm=none
hi TabLineFill      ctermfg=black ctermbg=251  cterm=none
hi TabLineSel       ctermfg=white ctermbg=240  cterm=none
hi VertSplit        ctermfg=251   ctermbg=251  cterm=none
hi Visual           ctermfg=none  ctermbg=229  cterm=none
hi MatchParen       ctermfg=none  ctermbg=224  cterm=none
hi Search           ctermfg=none  ctermbg=224  cterm=none
" hi ExtraWhitespace  ctermfg=198   ctermbg=none cterm=reverse
hi Todo             ctermfg=198   ctermbg=none cterm=none
hi DiffAdd          ctermfg=none  ctermbg=158 cterm=none
hi DiffDelete       ctermfg=none  ctermbg=224 cterm=none
hi DiffChange       ctermfg=none  ctermbg=195 cterm=none
hi DiffText         ctermfg=none  ctermbg=230 cterm=none
hi Folded           ctermfg=none  ctermbg=229  cterm=none
hi SpecialKey       ctermfg=252   ctermbg=none cterm=none
hi NonText          ctermfg=251  ctermbg=none cterm=none
