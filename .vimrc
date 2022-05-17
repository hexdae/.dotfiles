" :W sudo saves the file when the file is open in readonly mode
command W w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""""""""
" Line
""""""""""""""""""""""""""""""""""""
" show line numbers
set number

"""""""""""""""""""""""""""""""""""""
" Indents
"""""""""""""""""""""""""""""""""""""
" replace tabs with spaces
set expandtab
" 1 tab = 2 spaces
set tabstop=2 shiftwidth=2

" when deleting whitespace at the beginning of a line, delete
" 1 tab worth of spaces (for us this is 2 spaces)
set smarttab

" when creating a new line, copy the indentation from the line above
set autoindent

"""""""""""""""""""""""""""""""""""""
" Search
"""""""""""""""""""""""""""""""""""""
" Ignore case when searching
set ignorecase
set smartcase

" highlight search results (after pressing Enter)
set hlsearch

" highlight all pattern matches WHILE typing the pattern
set incsearch

"""""""""""""""""""""""""""""""""""""
" Mix
"""""""""""""""""""""""""""""""""""""
" show the mathing brackets
set showmatch

" highlight current line
set cursorline

"""""""""""""""""""""""""""""""""""""
" Colorscheme
"""""""""""""""""""""""""""""""""""""
syntax on
colorscheme gruvbox

"""""""""""""""""""""""""""""""""""""
" Dark mode swtch
"""""""""""""""""""""""""""""""""""""
function! SetBackgroundMode(...)
    let s:new_bg = 'light'
    if $TERM_PROGRAM ==? 'Apple_Terminal'
        let s:mode = systemlist("defaults read -g AppleInterfaceStyle")[0]
        if s:mode ==? 'dark'
            let s:new_bg = 'dark'
        else
            let s:new_bg = 'light'
        endif
    else
        " This is for Linux where I use an environment variable for this:
        if $VIM_BACKGROUND ==? 'dark'
            let s:new_bg = 'dark'
        else
            let s:new_bg = 'light'
        endif
    endif
    if &background !=? s:new_bg
        let &background = s:new_bg
    endif
endfunction
call SetBackgroundMode()
"call timer_start(3000, 'SetBackgroundMode', {'repeat': -1})

