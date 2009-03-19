" Vim color file
" markus schnalke -- http://marmaro.de
"
" This is meillo's own color scheme.
"


" First remove all existing highlighting.
set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif


" my code from here
let colors_name = "meillo_self"





"##   GUI   ###################################################################
" Globals

  hi Normal                         guifg=#000000  guibg=#d8d0c8  " Standard-Farben

  hi LineNr                         guifg=#666666  guibg=#aaaaaa  " Bereich der Zeilennummern

  hi FoldColumn                     guifg=#cccccc  guibg=#666666  " Bereich der Faltungen
  hi Folded                         guifg=#000000  guibg=#e3c1a5  " Gefaltete Zeile

  hi StatusLine      gui=bold       guifg=#ffffff  guibg=#000000  " Statusleiste des aktiven Frames
  hi StatusLineNC    gui=bold       guifg=#666666  guibg=#333333  " Statusleiste der anderen Frames

  hi SpecialKey                     guifg=Blue
  hi NonText                        guifg=#000000                 " ~ and @ at the end of the file
  hi Directory                      guifg=Blue
  hi ErrorMsg        gui=bold       guifg=White    guibg=Red

  hi IncSearch       gui=reverse                                  " Waehrend der Suchbegriffseingabe
  hi Search                                        guibg=#ffeeaa  " Abgeschlossene Suche

  hi MoreMsg         gui=bold       guifg=SeaGreen
  hi ModeMsg         gui=bold
  hi Question        gui=bold       guifg=SeaGreen

  hi VertSplit       gui=bold       guifg=#000000  guibg=#000000

  hi Title           gui=bold       guifg=DeepPink3
  hi Visual                         guifg=#666666  guibg=#eeeedd  " visual-Markierung
  hi VisualNOS       gui=bold,underline
  hi WarningMsg      gui=bold       guifg=Red
  hi WildMenu                       guifg=Black    guibg=Yellow

  hi DiffAdd                                       guibg=White
  hi DiffChange                                    guibg=#edb5cd
  hi DiffDelete      gui=bold       guifg=#6666ff  guibg=#f6e8d0
  hi DiffText        gui=bold                      guibg=#ff8060

  hi Cursor                         guifg=bg       guibg=fg       " der char unter dem Cursor
  hi CursorLine                                    guibg=#cccccc  " the line that the cursor is
  hi lCursor                        guifg=bg       guibg=fg       "??

  hi MatchParen                                    guibg=#aacc00

  hi Pmenu                          guifg=#aaaaaa  guibg=#333333
  hi PmenuSel       gui=bold        guifg=#cccccc  guibg=#666666

" syntax
  hi Comment                        guifg=#008000
  hi Constant                       guifg=#800000
  hi Special         gui=bold       guifg=#000000                  " php-tags, Sonderzeichen, Klammern
  hi Identifier                     guifg=#000080
  hi Statement       gui=bold       guifg=#000080                  " reservierte Worte
  hi PreProc                        guifg=#800000
  hi Type            gui=none       guifg=#0000aa                  " attribute (z.B. style, title, name)
  hi Igrore                         guifg=bg
  hi Error           gui=bold       guifg=#ffffff  guibg=#ff0000
  hi Todo                           guifg=#000000  guibg=#eecc00





"##    COLOR-TERM    ##########################################################

" Globals
  hi FoldColumn      ctermfg=0      ctermbg=0     cterm=bold
  hi Folded          ctermfg=0      ctermbg=0     cterm=bold
  hi LineNr          ctermfg=0      ctermbg=0     cterm=bold

  hi StatusLine                                   cterm=reverse 
  hi StatusLineNC    ctermfg=0      ctermbg=7     cterm=bold,reverse
  hi VertSplit       ctermfg=0      ctermbg=0     cterm=bold

  hi SpecialKey      ctermfg=4 
  hi NonText         ctermfg=4                    cterm=bold
  hi Directory       ctermfg=4 
  hi ErrorMsg        cterm=bold     ctermfg=7     ctermbg=1 
  hi IncSearch       cterm=reverse 
  hi Search          ctermbg=3
  hi MoreMsg         ctermfg=2 
  hi ModeMsg         cterm=bold 
  hi Question        ctermfg=2 
  hi Title           ctermfg=5 

  hi Visual          cterm=reverse 
  hi VisualNOS       cterm=bold,underline 

  hi WarningMsg      ctermfg=1 

  hi WildMenu        ctermfg=0      ctermbg=7

  hi DiffAdd         ctermbg=4 
  hi DiffChange      ctermbg=5 
  hi DiffDelete      cterm=bold     ctermfg=4      ctermbg=6 
  hi DiffText        cterm=bold     ctermbg=1 


" syntax
  hi Comment         cterm=bold    ctermfg=2
  hi Constant        ctermfg=1
  hi Special         ctermfg=5
  hi Identifier      cterm=bold    ctermfg=4 
  hi Statement       ctermfg=3
  hi PreProc         ctermfg=7
  hi Type            ctermfg=6
  hi Ignore          cterm=bold     ctermfg=7
  hi Error           cterm=bold     ctermfg=7      ctermbg=1
  hi Todo            ctermfg=0      ctermbg=3

" 0 = black
" 1 = red
" 2 = green
" 3 = yellow
" 4 = blue
" 5 = magenta
" 6 = cyan
" 7 = white






"##   TERM   ##################################################################

" Globals
  hi LineNr          term=underline 
  hi FoldColumn      term=standout 
  hi Folded          term=standout
  hi StatusLine      term=bold,reverse
  hi StatusLineNC    term=reverse   
  hi SpecialKey      term=bold     
  hi NonText         term=bold    
  hi Directory       term=bold   
  hi ErrorMsg        term=standout
  hi IncSearch       term=reverse 
  hi Search          term=reverse 
  hi MoreMsg         term=bold     
  hi ModeMsg         term=bold    
  hi Question        term=standout 
  hi VertSplit       term=reverse  
  hi Title           term=bold     
  hi Visual          term=reverse 
  hi VisualNOS       term=bold,underline
  hi WarningMsg358878      term=standout 
  hi WildMenu        term=standout 
  hi DiffAdd         term=bold    
  hi DiffChange      term=bold   
  hi DiffDelete      term=bold  
  hi DiffText        term=reverse 


" syntax 
  hi Comment         term=bold      
  hi Constant        term=underline
  hi Special         term=bold     
  hi Identifier      term=underline
  hi Statement       term=bold     
  hi PreProc         term=underline
  hi Type            term=underline
 " hi Ignore         
  hi Error           term=reverse  
  hi Todo            term=standout 











"" Set 'background' back to the default.  The value can't always be estimated
"" and is then guessed.
"hi clear Normal
"set bg&
"" Remove all existing highlighting and set the defaults.
"hi clear
"" Load the syntax highlighting defaults, if it's enabled.
"if exists("syntax_on")
"  syntax reset
"endif
"" vim: sw=2

