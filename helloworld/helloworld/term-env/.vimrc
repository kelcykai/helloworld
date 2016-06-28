map <F3> :execute 'vimgrep /' . expand('<cword>') . '/jg %'  <Bar> cw<CR>

map <F4> :execute "vimgrep /" . expand("<cword>") . "/jg **" <Bar> cw<CR>

map /w :cw<CR>

nmap <F5> :TagbarToggle<CR>

map <F9> <leader>m<cr>

" copy to system clipboard
set clipboard=unnamedplus
vmap <C-c> "+y<CR>
imap <C-v> <ESC>"+pa

map ,q :q!<cr>
map ,wq :wq<cr>

set ls=2
set number

"plugin MRU
nmap ,w :MRU<cr>

"search setting          
set incsearch            
set ignorecase           
nmap cs! :set ignorecase!<cr>


" set fuzzyfinder
let g:fuf_maxMenuWidth = 200
let g:fuf_buffertag_ctagsPath = 'ctags'

map ,v  :FufFile<cr>

map ,f  :FufCoverageFile!<cr>
let g:fuf_enumeratingLimit = 1000
let g:fuf_coveragefile_prompt = '=>'


" delet bookmark ctrl+]
map ,, :FufBookmarkFileAdd<cr><cr>
map ,m :FufBookmarkFile<cr>
map ,j  :FufJumpList!<cr>
map ,c  :FufChangeList!<cr>

if filereadable("cscope.FuzzyFolder")
        source cscope.FuzzyFolder
endif
" end fuzzyfinder 



" start cscope
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE: 
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate
    syntax on

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0
    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif
" end cscope

" start color
" start vim color scheme 
" ansi_blows.vim
" Author:      Brandon Low <lostlogic@lostlogicx.com>
" Last Change: 28 Feb 2009
" License:     as-is

set bg=dark

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

" fg=7
" bg=0
" 0 black
" 1 red
" 2 green
" 3 brown/yellow
" 4 blue
" 5 magenta
" 6 cyan
" 7 white

" Set these colors to the same as your console colors and your gVim and vim
" will be identically schemed.  These colors are selected to render ANSI
" graphics reasonably and to be readable.  I recommend setting your terminal
" emulator to use these colors.  The specific color value that I use in this
" scheme that can be problematic with other color settings is brown.
" Terminals often use an ugly and hard to read dark yellow instead of brown
" and that color makes a couple of my highlight settings here unusable.
let s:black='#000000'
let s:boldBlack='#555555'
let s:red='#b90000'
let s:boldRed='#dc3244'
let s:green='#00aa00'
let s:boldGreen='#44ff44'
let s:brown='#aa5500'
let s:yellow='#ffff44'
let s:blue='#1d28d2'
let s:boldBlue='#5050ff'
let s:magenta='#aa00aa'
let s:boldMagenta='#ff44ff'
let s:cyan='#00aaaa'
let s:boldCyan='#44ffff'
let s:white='#aaaaaa'
let s:boldWhite='#ffffff'

" These are supposedly Rasterman's colors:
" let s:black='#000000'
" let s:boldBlack='#444444'
" let s:red='#aa0000'
" let s:boldRed='#ff4444'
" let s:green='#00d200'
" let s:boldGreen='#44ff44'
" let s:brown='#aa5522'
" let s:yellow='#ffff44'
" let s:boldBlue='#4444ff'
" let s:blue='#0000aa'
" let s:magenta='#aa00aa'
" let s:boldMagenta='#ff44ff'
" let s:cyan='#00aaaa'
" let s:boldCyan='#44ffff'
" let s:white='#aaaaaa'
" let s:boldWhite='#ffffff'
"
" These are the colors specified in vim help for xterm color display:
" let s:black='#000000'
" let s:boldBlack='#808080'
" let s:red='#c00000'
" let s:boldRed='#ff6060'
" let s:green='#008000'
" let s:boldGreen='#00ff00'
" let s:brown='#808000'
" let s:yellow='#ffff00'
" let s:blue='#0000c0'
" let s:boldBlue='#8080ff'
" let s:magenta='#c000c0'
" let s:boldMagenta='#ff40ff'
" let s:cyan='#008080'
" let s:boldCyan='#00ffff'
" let s:white='#c0c0c0'
" let s:boldWhite='#ffffff'
"
" These are the Eterm defaults:
" let s:black='#000000'
" let s:boldBlack='#333333'
" let s:red='#cc0000'
" let s:boldRed='#ff0000'
" let s:green='#00cc00'
" let s:boldGreen='#00ff00'
" let s:blue='#0000cc'
" let s:boldBlue='#0000ff'
" let s:cyan='#00cccc'
" let s:boldCyan='#00ffff'
" let s:magenta='#cc00cc'
" let s:boldMagenta='#ff00ff'
" let s:brown='#cccc00'
" let s:yellow='#ffff00'
" let s:white='#faebd7'
" let s:boldWhite='#ffffff'
"
" These are gnome-terminal's defaults:
" let s:black='#000000'
" let s:boldBlack='#555555'
" let s:red='#aa0000'
" let s:boldRed='#ff5555'
" let s:green='#00aa00'
" let s:boldGreen='#55ff55'
" let s:blue='#0000aa'
" let s:boldBlue='#5555ff'
" let s:cyan='#00aaaa'
" let s:boldCyan='#55ffff'
" let s:magenta='#aa00aa'
" let s:boldMagenta='#ff55ff'
" let s:brown='#aa5500'
" let s:yellow='#ffff55'
" let s:white='#aaaaaa'
" let s:boldWhite='#ffffff'
"
" These are the colors as defined in the simple CGA spec:
" let s:black='#000000'
" let s:boldBlack='#444444'
" let s:red='#aa0000'
" let s:boldRed='#ff4444'
" let s:green='#00aa00'
" let s:boldGreen='#44ff44'
" let s:blue='#0000aa'
" let s:boldBlue='#4444ff'
" let s:cyan='#00aaaa'
" let s:boldCyan='#44ffff'
" let s:magenta='#aa00aa'
" let s:boldMagenta='#ff44ff'
" let s:brown='#aaaa00'
" let s:yellow='#ffff44'
" let s:white='#aaaaaa'
" let s:boldWhite='#ffffff'

exe 'hi Normal       guifg=' . s:white . ' guibg=' . s:black
exe 'hi SpecialKey   guifg=' . s:boldBlue
exe 'hi NonText      guifg=' . s:boldBlue . ' gui=none'
exe 'hi Directory    guifg=' . s:boldCyan
exe 'hi ErrorMsg     guifg=' . s:boldWhite . ' guibg=' . s:red
exe 'hi IncSearch    cterm=reverse gui=reverse'
exe 'hi Search       guifg=bg guibg=' . s:brown
exe 'hi MoreMsg      guifg=' . s:boldGreen . ' gui=none'
exe 'hi ModeMsg      guifg=' . s:boldWhite . ' gui=none'
exe 'hi LineNr       guifg=' . s:white
exe 'hi Question     guifg=' . s:boldGreen . ' gui=none'
exe 'hi StatusLine   cterm=reverse gui=reverse'
exe 'hi StatusLineNC cterm=reverse gui=reverse'
exe 'hi VertSplit    cterm=reverse gui=reverse'
exe 'hi Title        guifg=' . s:boldMagenta . ' gui=none'
exe 'hi Visual       cterm=reverse gui=reverse guibg=bg'
exe 'hi VisualNOS    guifg=' . s:boldWhite . ' gui=underline'
exe 'hi WarningMsg   guifg=' . s:boldRed
exe 'hi WildMenu     ctermbg=3 guifg=bg guibg=' . s:brown
exe 'hi Folded       ctermfg=3 ctermbg=7 guifg=' . s:brown . ' guibg=' . s:boldBlack
exe 'hi FoldColumn   ctermfg=3 ctermbg=7 guifg=' . s:brown . ' guibg=' . s:boldBlack
exe 'hi DiffAdd      guibg=' . s:blue
exe 'hi DiffChange   guibg=' . s:magenta
exe 'hi DiffDelete   cterm=none guifg=' . s:blue . ' guibg=' . s:cyan . ' gui=none'
exe 'hi DiffText     cterm=bold guifg=' . s:boldWhite . ' guibg=' . s:boldRed
exe 'hi SignColumn   ctermfg=3 ctermbg=7 guifg=' . s:brown . ' guibg=' . s:boldBlack
exe 'hi SpellBad     cterm=bold guifg=' . s:boldWhite . ' guisp=' . s:boldRed . ' gui=undercurl'
exe 'hi SpellCap     cterm=bold guifg=' . s:boldWhite . ' guisp=' . s:boldBlue . ' gui=undercurl'
exe 'hi SpellRare    cterm=bold guifg=' . s:boldWhite . ' guisp=' . s:boldMagenta . ' gui=undercurl'
exe 'hi SpellLocal   cterm=bold guifg=' . s:boldWhite . ' guisp=' . s:boldCyan . ' gui=undercurl'
exe 'hi Pmenu        guibg=' . s:magenta
exe 'hi PmenuSel     guibg=bg'
exe 'hi PmenuSbar    ctermfg=3 guifg=' . s:brown . ' guibg=fg'
exe 'hi PmenuThumb   cterm=reverse gui=reverse'
exe 'hi TabLine      cterm=underline guifg=fg guibg=bg gui=underline'
exe 'hi TabLineSel   cterm=bold guifg=' . s:boldWhite
exe 'hi TabLineFill  cterm=reverse gui=reverse'
exe 'hi CursorColumn ctermfg=7 ctermbg=7 cterm=bold guifg=' . s:boldWhite . ' guibg=fg'
exe 'hi CursorLine   cterm=underline gui=underline guibg=bg'
exe 'hi Cursor       cterm=reverse guifg=bg guibg=fg'
exe 'hi lCursor      cterm=reverse guifg=bg guibg=fg'
exe 'hi MatchParen   cterm=bold guifg=' . s:boldWhite . ' guibg=' . s:cyan
exe 'hi Comment      guifg=' . s:boldCyan
exe 'hi Constant     guifg=' . s:boldMagenta
exe 'hi Special      guifg=' . s:boldRed
exe 'hi Identifier   cterm=bold guifg=' . s:boldCyan . ' gui=bold'
exe 'hi Statement    guifg=' . s:yellow . ' gui=none'
exe 'hi PreProc      guifg=' . s:boldBlue
exe 'hi Type         guifg=' . s:boldGreen . ' gui=none'
exe 'hi Underlined   cterm=bold,underline guifg=' . s:boldBlue . ' gui=underline'
exe 'hi Ignore       guifg=bg'
exe 'hi Error        guifg=' . s:boldWhite . ' guibg=' . s:boldRed
exe 'hi Todo         guifg=bg guibg=' . s:brown

let colors_name = "ansi_blows"

" vim: sw=2

" end vim color scheme
" end color

set cursorline
hi CursorLine   cterm=NONE ctermbg=darkgray ctermfg=NONE
