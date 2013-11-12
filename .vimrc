" Colorscheme
colorscheme elflord

" Features
"--------------------------------------------------
set nocompatible

" Command line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Usability Options
"---------------------------------------------------

"Use case insensitive search, unless there are capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on
set autoindent

" Stop certain movements from always going to the first character of the line
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of the window
set ruler

" Confirm if we wish to save changed files
set confirm

" Enable the use of a mouse
" set mouse=a

" Set command line window to height of 2 lines
" set cmdheight=2

" Display line numbers
set number

" Indentation options
"----------------------------------------------------

" Use 2 spaces instead of tabs
set shiftwidth=2
set softtabstop=2
set expandtab

syntax on

" Vundle Configuration
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Bundles here:
" Repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'

" non-Github repos
Bundle 'git://git.wincent.com/command-t.git'

" Git repos on the local machine

" End Vundle config
filetype plugin indent on
