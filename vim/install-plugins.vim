set nocompatible  "required
filetype off      "required

call plug#begin('~/.vim/plugged')

"=== Themes and looks ===
Plug 'flazz/vim-colorschemes'
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pangloss/vim-javascript' "Makes syntax highlighting etc. more sane for js.
Plug 'mxw/vim-jsx'
Plug 'ap/vim-css-color' "Make css colours appear in editor in that colour

"=== Navigation ===
Plug 'scrooloose/nerdtree' "File tree on the left hand side
Plug 'Xuyuanp/nerdtree-git-plugin' "Nerdtree + git highlighting
Plug 'ctrlpvim/ctrlp.vim' "Makes an index of all files available on ctrl+p
Plug 'majutsushi/tagbar' "Creates an outline of the tags in the file on the right
Plug 'fholgado/minibufexpl.vim' "Get me a buffer overview. WANT:2
Plug 'wincent/terminus' "Cursor changes in different modes, mouse support

"=== Git ===
Plug 'airblade/vim-gitgutter' "Makes the git gutter with +, ~, and - available
Plug 'tpope/vim-fugitive' "Most git features available through :G*

"=== Surrounding syntax ===
Plug 'Townk/vim-autoclose' "Adds matching quotes, bracets etc.
Plug 'tmhedberg/matchit' "Makes % sane with e.g. <tags></tags>
Plug 'mattn/emmet-vim' "Shortcuts for creating html boilerplate
Plug 'tpope/vim-surround' "Introduce the surround syntax to vim language
Plug 'tpope/vim-repeat' "Make vim-surround things repeatable with .

"=== Linting ===
Plug 'vim-syntastic/syntastic' "Linting engine
Plug 'mtscout6/syntastic-local-eslint.vim'

"=== Misc. ===
Plug 'ervandew/supertab' "Tab completion. TODO:1
Plug 'scrooloose/nerdcommenter' "Comment with leader + c + c. TODO:2
Plug 'sickill/vim-pasta' "Context aware pasting. E.g. intentation TODO:1
Plug 'tpope/vim-unimpaired' "Goodies using the [] keys. TODO:2 
Plug 'christoomey/vim-tmux-navigator' "Work better with tmux
Plug 'godlygeek/tabular.git' "Make aligning nice and pretty

call plug#end()
"====================== TODO numbering =====================
"1: Learn more about/investigate. This plugin/feature looks promising, but
"needs more configuration before I can use it confidently in my workflow.
"
"2: Introduce into workflow. This tool is great, but I haven't actually
"started using it yet.
