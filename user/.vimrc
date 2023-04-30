" Commands
command W w !sudo tee % > /dev/null

" Options
set noswapfile              " remove swap file
set number                  " line numbers
set expandtab               " spaces for tab
set tabstop=2 shiftwidth=2  " 1 tab = 2 spaces
set smarttab                " smart tabs
set autoindent              " python like indent
set ignorecase              " ignore case in search
set smartcase               " smart case in search
set hlsearch
set incsearch
set showmatch
set backspace=2

" Theme
syntax on
hi CursorLine term=bold cterm=bold
hi Normal guibg=NONE ctermbg=NONE

