set nocompatible  "required
filetype off      "required

call plug#begin('~/.vim/plugged')

"=== Themes and looks ===
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"=== Navigation ===
Plug 'scrooloose/nerdtree' "File tree on the left hand side
Plug 'Xuyuanp/nerdtree-git-plugin' "Nerdtree + git highlighting
Plug 'ctrlpvim/ctrlp.vim' "Makes an index of all files available on ctrl+p
Plug 'wincent/terminus' "Cursor changes in different modes, mouse support
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' "fzf in vim
Plug 'rking/ag.vim' "search inside files

"=== Git ===
Plug 'airblade/vim-gitgutter' "Makes the git gutter with +, ~, and - available
Plug 'tpope/vim-fugitive' "Most git features available through :G*

"=== Surrounding syntax ===
Plug 'Townk/vim-autoclose' "Adds matching quotes, bracets etc.
Plug 'mattn/emmet-vim' "Shortcuts for creating html boilerplate
Plug 'tpope/vim-surround' "ysiw syntax for surrounding
Plug 'tpope/vim-repeat' "Make vim-surround things repeatable with .

"=== Linting ===
Plug 'vim-syntastic/syntastic' "Linting engine
Plug 'mtscout6/syntastic-local-eslint.vim' "Es6 is here to stay
Plug 'bronson/vim-trailing-whitespace' "Mark trailing whitespace

"=== Misc. ===
Plug 'ervandew/supertab' "Tab completion.
Plug 'sickill/vim-pasta' "Context aware pasting + intentation
Plug 'christoomey/vim-tmux-navigator' "Work better with tmux

"=== Languages ===
Plug 'pangloss/vim-javascript' "Makes syntax highlighting etc. more sane for js.
Plug 'kchmck/vim-coffee-script' "Coffescript support
Plug 'mxw/vim-jsx' "Support for JSX
Plug 'ap/vim-css-color' "Make css colours appear in editor in that colour
Plug 'sbdchd/neoformat' "Formatter (that supports prettier)

"The following plugin(s) can't be cloned using the https:// protocol and must
"use the git:// protocol

Plug 'godlygeek/tabular.git' "Make aligning nice and pretty


call plug#end()
