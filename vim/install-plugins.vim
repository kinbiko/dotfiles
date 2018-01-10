set nocompatible  "required
filetype off      "required

call plug#begin('~/.vim/plugged')

"{{{ Themes and looks
Plug 'vim-airline/vim-airline'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "This can get pretty sluggish for large trees :/ Consider removing
Plug 'ryanoasis/vim-devicons'
Plug 'arcticicestudio/nord-vim'
"}}}

"{{{ Navigation
Plug 'scrooloose/nerdtree' "File tree on the left hand side
Plug 'Xuyuanp/nerdtree-git-plugin' "Nerdtree + git highlighting
Plug 'wincent/terminus' "Cursor changes in different modes, mouse support
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' "fzf in vim
Plug 'rking/ag.vim' "search inside files
Plug 'easymotion/vim-easymotion' "Accurate navigation ala vimium
Plug 'haya14busa/vim-asterisk' "Use * without moving immediately
"}}}

"{{{ Git
Plug 'airblade/vim-gitgutter' "Makes the git gutter with +, ~, and - available
Plug 'tpope/vim-fugitive' "Most git features available through :G*
Plug 'rhysd/committia.vim' "git commit becomes magic
"}}}

"{{{ Surrounding syntax
Plug 'Townk/vim-autoclose' "Adds matching quotes, bracets etc.
Plug 'mattn/emmet-vim' "Shortcuts for creating html boilerplate
Plug 'tpope/vim-surround' "ysiw syntax for surrounding
Plug 'tpope/vim-repeat' "Make vim-surround things repeatable with .
"}}}

"{{{ Linting
Plug 'vim-syntastic/syntastic' "Linting engine
Plug 'mtscout6/syntastic-local-eslint.vim' "uses .eslint.* file to plug into syntastic
Plug 'bronson/vim-trailing-whitespace' "Mark trailing whitespace
"}}}

"{{{ Tmux
Plug 'christoomey/vim-tmux-navigator' "Work better with tmux
Plug 'benmills/vimux' "Integrate with tmux easily
"}}}

"{{{ Languages
"{{{ Frontend
Plug 'pangloss/vim-javascript' "Makes syntax highlighting etc. more sane for js.
Plug 'kchmck/vim-coffee-script' "Coffescript support
Plug 'mxw/vim-jsx' "Support for JSX
Plug 'ap/vim-css-color' "Make css colours appear in editor in that colour
Plug 'prettier/vim-prettier' "prettier formatter
Plug 'slim-template/vim-slim' "Syntax highlighting for slim
"}}}
Plug 'pgr0ss/vimux-ruby-test' "Run ruby specs from within vim
Plug 'fatih/vim-go' "Make vim good with go
Plug 'nelstrom/vim-markdown-folding' "fold by sections in markdown
Plug 'tpope/vim-rails' "Make vim good with rails
"}}}

"{{{ Snippets
Plug 'SirVer/ultisnips'
Plug 'epilande/vim-es2015-snippets'
Plug 'epilande/vim-react-snippets'

"}}}

"{{{ Misc.
Plug 'sickill/vim-pasta' "Context aware pasting + intentation
Plug 'godlygeek/tabular' "Make aligning nice and pretty
"}}}

call plug#end()
