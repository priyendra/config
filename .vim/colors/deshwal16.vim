highlight clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "deshwal16"
set t_Co=16

" Colors used are as follows. The names are not used because we want to
" ensure that colors are controllable from iterm.
" 0 - Black       8 - DarkGray
" 1 - Red         9 - BrightRed
" 2 - Green      10 - BrightGreen
" 3 - Yellow     11 - BrightYellow
" 4 - Blue       12 - LightBlue
" 5 - Magenta    13 - LightMagenta
" 6 - Cyan       14 - LightCyan
" 7 - LightGray  15 - White
hi SpecialKey    ctermfg=7     ctermbg=none  cterm=none
hi TermCursor    ctermfg=none  ctermbg=none  cterm=none
hi NonText       ctermfg=13     ctermbg=none  cterm=none
hi Directory     ctermfg=4     ctermbg=none  cterm=none
hi ErrorMsg      ctermfg=1     ctermbg=none  cterm=none
hi Error         ctermfg=1     ctermbg=none  cterm=none
hi WarningMsg    ctermfg=1     ctermbg=none  cterm=none
hi SpellBad      ctermfg=1     ctermbg=none  cterm=none
hi SpellRare     ctermfg=1     ctermbg=none  cterm=none
hi SpellLocal    ctermfg=1     ctermbg=none  cterm=none
hi SpellCap      ctermfg=1     ctermbg=none  cterm=none
hi IncSearch     ctermfg=none  ctermbg=none  cterm=reverse
hi Search        ctermfg=0     ctermbg=13    cterm=none
hi ModeMsg       ctermfg=none  ctermbg=none  cterm=none
hi CursorLineNr  ctermfg=0     ctermbg=none  cterm=none
hi Title         ctermfg=5     ctermbg=none  cterm=none
hi WildMenu      ctermfg=0     ctermbg=11    cterm=none
hi Conceal       ctermfg=15    ctermbg=15    cterm=none
hi Ignore        ctermfg=15    ctermbg=15    cterm=none
hi PmenuSbar     ctermfg=7     ctermbg=7     cterm=none
hi PmenuThumb    ctermfg=0     ctermbg=0     cterm=none
hi Pmenu         ctermfg=none  ctermbg=7     cterm=none
hi PmenuSel      ctermfg=0     ctermbg=11    cterm=none
hi TabLine       ctermfg=0     ctermbg=15    cterm=none
hi TabLineSel    ctermfg=15    ctermbg=0     cterm=none
hi TabLineFill   ctermfg=8     ctermbg=7     cterm=underline
hi CursorColumn  ctermfg=none  ctermbg=7     cterm=none
hi CursorLine    ctermfg=none  ctermbg=7     cterm=none
hi MatchParen    ctermfg=5     ctermbg=13    cterm=none
hi Constant      ctermfg=1     ctermbg=none  cterm=none
hi Special       ctermfg=5     ctermbg=none  cterm=none
hi Identifier    ctermfg=6     ctermbg=none  cterm=none
hi Statement     ctermfg=3     ctermbg=none  cterm=none
hi PreProc       ctermfg=5     ctermbg=none  cterm=none
hi Type          ctermfg=2     ctermbg=none  cterm=none
hi Underlined    ctermfg=none  ctermbg=none  cterm=underline
hi Todo          ctermfg=1     ctermbg=7     cterm=none
hi DiffAdd       ctermfg=none  ctermbg=10    cterm=none
hi DiffChange    ctermfg=none  ctermbg=14    cterm=none
hi DiffDelete    ctermfg=9     ctermbg=9     cterm=none
hi DiffText      ctermfg=none  ctermbg=7     cterm=none
hi Visual        ctermfg=none  ctermbg=11    cterm=none
hi LineNr        ctermfg=0     ctermbg=none  cterm=none
hi Comment       ctermfg=4     ctermbg=none  cterm=none
hi ColorColumn   ctermfg=none  ctermbg=9     cterm=none
hi Folded        ctermfg=none  ctermbg=11    cterm=none
hi FoldColumn    ctermfg=4     ctermbg=7     cterm=none
hi StatusLine    ctermfg=15    ctermbg=0     cterm=underline
hi StatusLineNC  ctermfg=0     ctermbg=7     cterm=underline
hi VertSplit     ctermfg=8     ctermbg=7     cterm=none
hi SignColumn    ctermfg=none  ctermbg=7     cterm=none
hi MoreMsg       ctermfg=none  ctermbg=none  cterm=none
hi Question      ctermfg=none  ctermbg=none  cterm=none
