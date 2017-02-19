set nocompatible  "required
filetype off      "required

"=== Vundle ===
set rtp+=~/.vim/bundle/Vundle.vim "Set the runtime path to include Vundle
call vundle#begin() "aaaand initialise
Plugin 'VundleVim/Vundle.vim' "Add Vundle to the dependencies

"=== Themes and looks ===
Plugin 'flazz/vim-colorschemes'
Plugin 'tomasr/molokai'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'pangloss/vim-javascript' "Makes syntax highlighting etc. more sane for js.
Plugin 'mxw/vim-jsx'

"=== Navigation ===
Plugin 'scrooloose/nerdtree' "File tree on the left hand side
Plugin 'Xuyuanp/nerdtree-git-plugin' "Nerdtree + git highlighting
Plugin 'ctrlpvim/ctrlp.vim' "Makes an index of all files available on ctrl+p
Plugin 'majutsushi/tagbar' "Creates an outline of the tags in the file on the right
Plugin 'fholgado/minibufexpl.vim' "Get me a buffer overview. WANT:2

"=== Git ===
Plugin 'airblade/vim-gitgutter' "Makes the git gutter with +, ~, and - available
Plugin 'tpope/vim-fugitive' "Most git features available through :G*

"=== Surrounding syntax ===
Plugin 'Townk/vim-autoclose' "Adds matching quotes, bracets etc.
Plugin 'tmhedberg/matchit' "Makes % sane with e.g. <tags></tags>
Plugin 'mattn/emmet-vim' "Shortcuts for creating html boilerplate
Plugin 'tpope/vim-surround' "Introduce the surround syntax to vim language
Plugin 'tpope/vim-repeat' "Make vim-surround things repeatable with .

"=== Linting ===
Plugin 'vim-syntastic/syntastic' "Linting engine
Plugin 'mtscout6/syntastic-local-eslint.vim'

"=== Misc. ===
Plugin 'ervandew/supertab' "Tab completion. TODO:1
Plugin 'scrooloose/nerdcommenter' "Comment with leader + c + c. TODO:2
Plugin 'sickill/vim-pasta' "Context aware pasting. E.g. intentation TODO:1
Plugin 'tpope/vim-unimpaired' "Goodies using the [] keys. TODO:2 
Plugin 'christoomey/vim-tmux-navigator' "Work better with tmux
Plugin 'godlygeek/tabular.git' "Make aligning nice and pretty

call vundle#end() "Signify that there are no more Plugins

"====================== TODO numbering =====================
"The line lengths are capped at 80 characters, so rather than inlining the
"TODO comments I've assembled them all here.
"
"1: Learn more about/investigate. This plugin/feature looks promising, but
"needs more configuration before I can use it confidently in my workflow.
"
"2: Introduce into workflow. This tool is great, but I haven't actually
"started using it yet.
