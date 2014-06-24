set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "deshwal"

hi Normal         guifg=#FFFFFF  guibg=#000000   gui=NONE
hi ColorColumn    guifg=NONE     guibg=#3E3E3E   gui=NONE
hi Cursor         guifg=NONE     guibg=NONE      gui=REVERSE
hi CursorColumn   guifg=red      guibg=red       gui=NONE
hi CursorLine     guifg=NONE     guibg=#3E3E3E   gui=NONE
hi DiffAdd        guifg=NONE     guibg=#003300   gui=NONE
hi DiffChange     guifg=NONE     guibg=#000033   gui=NONE
hi DiffDelete     guifg=#330000  guibg=#330000   gui=NONE
hi DiffText       guifg=NONE     guibg=#0A6164   gui=NONE
hi Directory      guifg=#FF9999  guibg=NONE      gui=NONE
hi ErrorMsg       guifg=#000000  guibg=#AAAAAA   gui=NONE
hi FoldColumn     guifg=NONE     guibg=#666666   gui=NONE
hi Folded         guifg=#005555  guibg=#999999   gui=NONE
hi IncSearch      guifg=NONE     guibg=NONE      gui=REVERSE
hi LineNr         guifg=#707070  guibg=NONE      gui=NONE
hi MatchParen     guifg=NONE     guibg=#9264DC   gui=NONE
hi ModeMsg        guifg=NONE     guibg=NONE      gui=NONE
hi MoreMsg        guifg=#B6D471  guibg=NONE      gui=NONE
hi NonText        guifg=#CBA361  guibg=NONE      gui=NONE
hi PMenu          guifg=NONE     guibg=#3E3E3E   gui=NONE
hi PMenuSel       guifg=NONE     guibg=#000088   gui=NONE
hi PMenuSbar      guifg=NONE     guibg=#222222   gui=NONE
hi PMenuThumb     guifg=NONE     guibg=#777777   gui=NONE
hi Question       guifg=#B6D471  guibg=NONE      gui=NONE
hi Search         guifg=#ffff00  guibg=NONE      gui=NONE
hi SignColumn     guifg=#B6D471  guibg=NONE      gui=NONE
hi SpecialKey     guifg=#B6D471  guibg=NONE      gui=NONE
hi StatusLine     guifg=#000000  guibg=#FFFFFF   gui=NONE
hi StatusLineNC   guifg=#FFFFFF  guibg=#666666   gui=NONE
hi TabLine        guifg=#FFFFFF  guibg=#666666   gui=NONE
hi TabLineFill    guifg=#FF0000  guibg=#666666   gui=NONE
hi TabLineSel     guifg=#000000  guibg=#FFFFFF   gui=NONE
hi Title          guifg=#B6D471  guibg=NONE      gui=NONE
hi VertSplit      guifg=#999999  guibg=#666666   gui=NONE
hi Visual         guifg=NONE     guibg=#6A54A7   gui=NONE
hi VisualNOS      guifg=NONE     guibg=#6A54A7   gui=NONE
hi VarningMsg     guifg=#FF9999  guibg=NONE      gui=NONE
hi WildMenu       guifg=NONE     guibg=NONE      gui=NONE

hi Comment        guifg=#ADDFFF  guibg=NONE      gui=NONE
hi Constant       guifg=#82CAFA  guibg=NONE      gui=NONE
hi Error          guifg=#AA0000  guibg=NONE      gui=NONE
hi Identifier     guifg=#43C6DB  guibg=NONE      gui=NONE
hi Ignore         guifg=#888888  guibg=NONE      gui=NONE
hi PreProc        guifg=#6AFB92  guibg=NONE      gui=NONE
hi Special        guifg=NONE     guibg=NONE      gui=NONE
hi Statement      guifg=#92C7C7  guibg=NONE      gui=NONE
hi Todo           guifg=NONE     guibg=NONE      gui=UNDERLINE
hi Type           guifg=#82CAFF  guibg=NONE      gui=NONE
hi Underlined     guifg=NONE     guibg=NONE      gui=UNDERLINE

hi htmlBold                  guifg=NONE     guibg=NONE      gui=NONE
hi htmlBoldUnderline         guifg=NONE     guibg=NONE      gui=NONE
hi htmlUnderline             guifg=NONE     guibg=NONE      gui=NONE
hi htmlBoldUnderlineItalic   guifg=NONE     guibg=NONE      gui=NONE
hi htmlUnderlineItalic       guifg=NONE     guibg=NONE      gui=NONE
hi htmlItalic                guifg=NONE     guibg=NONE      gui=NONE
