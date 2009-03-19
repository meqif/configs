" meqif's .vimrc file. Some stuff added by me, most stuff cannibalized
" from rezza's config and various sources around the net. Feel free to
" rip this apart and use it to your own nefarious ends.


""""""""""""""""""""""""""""""""""""""""""
" GUI options, and colorscheme selection "
""""""""""""""""""""""""""""""""""""""""""

"color darktango

if (&term =~ 'linux')
    set t_Co=16
    set termencoding=utf-8
    set nocursorline
    colorscheme darktango
else
    set t_Co=256
    set mouse=a
    colorscheme jellybeans
    set termencoding=utf-8
endif

"""""""""""""
" Functions "
"""""""""""""

" Add timestamp to rc files
fun! <SID>UpdateRcHeader()
    let l:c=col(".")
    let l:l=line(".")
    1,10s-\(Most recent update:\).*-\="Most recent update: ".strftime("%c")-
    call cursor(l:l, l:c)
endfun

" Set up the status line
fun! <SID>SetStatusLine()
    let l:s1="%-3.3n\\ %f\\ %h%m%r%w"
    let l:s2="[%{strlen(&filetype)?&filetype:'?'},%{&encoding},%{&fileformat}]"
    let l:s3="%=\\ 0x%-8B\\ \\ %-14.(%l,%c%V%)\\ %<%P"
    execute "set statusline=" . l:s1 . l:s2 . l:s3
endfun


""""""""""""
" Settings "
""""""""""""

" Encoding
if ($TERM == "rxvt-unicode") && (&termencoding == "")
    set termencoding=utf-8
endif
set encoding=utf-8

" Basic options
set nocompatible
set history=50
set viminfo='1000,f1,:1000,/1000
set shortmess+=aI
set showmode
set showcmd
set modeline
set wildmenu

:inoremap ( ()<ESC>i
:inoremap { {}<ESC>i
:inoremap [ []<ESC>i

" Indent, tab, and wrap settings
""set noexpandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set shiftround
set autoindent
set smartindent
"set textwidth=72
set textwidth=80
""set nowrap
set formatoptions+=nl
set whichwrap=h,l,~,[,]
set backspace=eol,start,indent

set number

" Search options
set nohlsearch
set ignorecase
set incsearch
set gdefault
set showmatch

" Set a toggle for pasting input
set pastetoggle=<F10>

" Set special characters
" set listchars+=tab:»·,trail:·,extends:<80>

" Set bracket matching and comment formats
set matchpairs+=<:>
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*
set comments+=b:\"
set comments+=n::

" Use less space for line numbering if possible
if v:version >= 700
    try
        setlocal numberwidth=3
    catch
    endtry
endif

" Use css for generated html files
let html_use_css=1

" Setup a funky statusline
set laststatus=2
call <SID>SetStatusLine()

" Set taglist plugin options
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Compact_Format = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Inc_Winwidth = 1

" Set minibufxpl plugin options
let g:miniBufExplModSelTarget = 1
let g:miniBufExplModSelTarget = 1

" Basic abbreviations
abbreviate teh the
iab DATE <C-R>=strftime("%B %d, %Y (%A, %H:%Mh)")<CR>

" Enable filetype detection
filetype on
filetype plugin on
filetype indent on


""""""""""""""""
" Autocommands "
""""""""""""""""

" Clear previous autocmds, stops a few errors creeping in.
autocmd!

" C file specific options
autocmd FileType c,cpp set cindent
autocmd FileType c,cpp set formatoptions+=ro
"autocmd FileType c,cpp set makeprg=gcc\ -Wall\ -O2\ -o\ %<\ %

" HTML abbreviations
autocmd FileType html,php imap bbb <br />

" Compile and run keymappings
autocmd FileType c,cpp map <F5> :!./%:r<CR>
autocmd FileType sh,php,perl,python map <F5> :!./%<CR>
autocmd FileType c,cpp map <F6> :make %:r<CR>
autocmd FileType php map <F6> :!php &<CR>
autocmd FileType python map <F6> :!python %<CR>
autocmd FileType perl map <F6> :!perl %<CR>
autocmd FileType html,xhtml map <F5> :!firefox %<CR>
autocmd FileType java map <F6> :!javac %<CR>
autocmd FileType tex map <F5> :!evince "%:r".pdf<CR>
autocmd FileType tex map <F6> :!pdflatex %<CR>

" MS Word document reading
autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"

" Arduino stuff
autocmd BufReadPre *.pde set filetype=c

" nasm
autocmd BufReadPre *.nasm set filetype=asm

" SVG
autocmd BufReadPre *.svg set filetype=svg

" Ragel
au BufRead,BufNewFile *.rl set filetype=ragel

"""""""""""""""
" Keymappings "
"""""""""""""""

" Easy pasting from the X clipboard
"map <C-V> <ESC>:r!xsel -b<CR>i
imap <C-V> <ESC>:r!xsel -b<CR>i

" Easy help
map! <F1> <C-C><F1>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
nnoremap <F1> :help<Space>
map <F7> :!python -c 'help()'<left><left>

" Show nonprinting characters
map <F2> :set list!<CR>
inoremap <F2> <ESC>:set list!<CR>a

" Toggle between windows
nnoremap <F3> <C-W>W
nnoremap <F4> <C-W>w

" Toggle taglist script
map <F8> :Tlist<CR>

" Toggle line numbers
map <F9> :set number!<CR>

" Toggle dark/light default colour theme for shitty terms
map <F11> :let &background = ( &background == "dark" ? "light" : "dark" )<CR>

" Swap around between buffers
nnoremap <C-N> :bn<CR>
nnoremap <C-I> :bn<CR>
nnoremap <C-P> :bp<CR>

" Convert to html
nnoremap <C-L> :runtime<Space>my2html.vim<CR>

" Fast quit
"map q :q<CR>

" Leave insert mode without reaching for the esc key
"imap ii <esc>

" Cursor keys suck. Use ctrl with home keys to move in insert mode.
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" Use o in insert mode
imap <C-O> <end><cr>

" Easy tabswitch
map <C-Tab> :tabNext<cr>

""""""""""""""""""""""""""""
" Enable syntax hilighting "
""""""""""""""""""""""""""""

syntax on

" My stuff "

"Tab vs. space autodetection
function Kees_settabs()
    if len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^\t"')) > len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^ "'))
        set noet ts=4 sw=4
    endif
endfunction
autocmd BufReadPost * call Kees_settabs()

"Clean trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.*/

":au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
:au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
