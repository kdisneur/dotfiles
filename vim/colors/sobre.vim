highlight clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'sobre'

" Ugly hack to make italic works on iTerm2
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

let s:white = 15
let s:black = 235
let s:red = 197
let s:darkGray = 239
let s:middleGray = 246
let s:lightGray = 254

let s:defaultBackground = s:white
let s:defaultForeground = s:black
let s:keywords = s:middleGray

function! s:highlight(name, ...)
  let l:cterm = get(a:, 1, "none")
  let l:ctermfg = get(a:, 2, s:defaultForeground)
  let l:ctermbg = get(a:, 3, s:defaultBackground)

  execute("highlight " . a:name . " cterm=" . l:cterm . " ctermbg=" . l:ctermbg . " ctermfg=" . l:ctermfg)
endfunction

set background=light

call s:highlight("Boolean")
call s:highlight("Character")
call s:highlight("Conditional")
call s:highlight("Constant")
call s:highlight("CursorLineNr")
call s:highlight("Debug")
call s:highlight("Define", "none", s:keywords)
call s:highlight("Delimiter")
call s:highlight("EndOfBuffer")
call s:highlight("Exception")
call s:highlight("Float")
call s:highlight("Function", "bold")
call s:highlight("Identifier")
call s:highlight("Ignore")
call s:highlight("Include", "italic")
call s:highlight("Keyword")
call s:highlight("Label")
call s:highlight("LineNr")
call s:highlight("Macro")
call s:highlight("ModeMsg")
call s:highlight("MoreMsg")
call s:highlight("NonText")
call s:highlight("Normal")
call s:highlight("Number")
call s:highlight("Operator")
call s:highlight("Pmenu")
call s:highlight("PmenuSbar")
call s:highlight("PreCondit")
call s:highlight("PreProc")
call s:highlight("Question")
call s:highlight("Repeat")
call s:highlight("Special")
call s:highlight("SpecialChar")
call s:highlight("SpecialComment")
call s:highlight("SpecialKey")
call s:highlight("Statement")
call s:highlight("StorageClass")
call s:highlight("String")
call s:highlight("Structure")
call s:highlight("TabLine")
call s:highlight("TabLineFill")
call s:highlight("Tag")
call s:highlight("Terminal")
call s:highlight("Type")
call s:highlight("Typedef")
call s:highlight("Bold", "bold")
call s:highlight("Directory", "bold")
call s:highlight("Title", "bold")
call s:highlight("WildMenu", "bold")
call s:highlight("SpellBad", "undercurl")
call s:highlight("SpellCap", "undercurl")
call s:highlight("SpellLocal", "undercurl")
call s:highlight("SpellRare", "undercurl")
call s:highlight("Cursor", "none", s:defaultBackground, s:defaultForeground)
call s:highlight("FoldColumn", "none", s:defaultBackground, s:defaultForeground)
call s:highlight("Folded", "none", s:defaultBackground, s:defaultForeground)
call s:highlight("IncSearch", "none", s:defaultBackground, s:defaultForeground)
call s:highlight("PmenuSel", "none", s:defaultBackground, s:defaultForeground)
call s:highlight("PmenuThumb", "none", s:defaultBackground, s:defaultForeground)
call s:highlight("SignColumn", "none", s:defaultBackground, s:defaultForeground)
call s:highlight("TermCursor", "none", s:defaultBackground, s:defaultForeground)
call s:highlight("TermCursorNC", "none", s:defaultBackground, s:defaultForeground)
call s:highlight("ToolbarButton", "none", s:defaultBackground, s:defaultForeground)
call s:highlight("ToolbarLine", "none", s:defaultBackground, s:defaultForeground)
call s:highlight("VertSplit", "none", s:defaultBackground, s:defaultForeground)
call s:highlight("Visual", "none", s:defaultForeground, s:lightGray)
call s:highlight("VisualNOS", "none", s:defaultForeground, s:lightGray)
call s:highlight("StatusLine", "bold")
call s:highlight("StatusLineNC")
call s:highlight("StatusLineTerm")
call s:highlight("StatusLineTermNC")
call s:highlight("TabLineSel")
call s:highlight("Conceal")
call s:highlight("Italic", "italic", s:defaultForeground, s:defaultBackground)
call s:highlight("Underlined", "underline", s:defaultForeground, s:defaultBackground)
call s:highlight("ColorColumn", "none", s:defaultForeground, 254)
call s:highlight("Comment", "italic", s:middleGray)
call s:highlight("CursorColumn", "none", s:defaultForeground, 254)
call s:highlight("CursorLine", "none", s:defaultForeground, 254)
call s:highlight("DiffChange", "none", s:defaultForeground, 254)
call s:highlight("QuickFixLine", "none", s:defaultForeground, 254)
call s:highlight("DiffDelete", "none", s:red)
call s:highlight("DiffRemoved", "none", s:red)
call s:highlight("Error", "none", s:red)
call s:highlight("ErrorMsg", "none", s:red)
call s:highlight("TooLong", "none", s:red)
call s:highlight("WarningMsg", "none", s:red)
call s:highlight("DiffChanged", "none", s:defaultForeground, 223)
call s:highlight("DiffText", "none", s:defaultForeground, 223)
call s:highlight("MatchParen", "none", s:defaultForeground, s:lightGray)
call s:highlight("Search", "none", s:defaultForeground, 220)
call s:highlight("Todo", "bold,italic")
call s:highlight("DiffAdd", "none", s:defaultForeground, 151)
call s:highlight("DiffAdded", "none", s:defaultForeground, 151)

" Elixir
call s:highlight("ElixirModuleDefine", "none", s:keywords)
call s:highlight("ElixirModuleDeclaration", "bold")

" Javascript
call s:highlight("jsStorageClass", "none", s:keywords)
call s:highlight("jsGlobalNodeObjects", "italic")
call s:highlight("jsConditional", "none", s:keywords)
call s:highlight("jsOperator", "none", s:keywords)
call s:highlight("jsClassKeyword", "none", s:keywords)
call s:highlight("jsExtendsKeyword", "none", s:keywords)

" VimScript
call s:highlight("vimFunction", "bold")
call s:highlight("vimFuncSID", "bold")
call s:highlight("vimFuncName", "none")

" Elm
call s:highlight("elmFunctionDefine", "bold")
call s:highlight("elmModuleDefine", "bold")
call s:highlight("elmFunctionTypeDefine", "italic", s:middleGray)

" ZSH
call s:highlight("zshFunction", "bold")
call s:highlight("zshVariableDef", "bold")
