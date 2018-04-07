set nocompatible  "required
filetype off      "required

call plug#begin('~/.vim/plugged')

"{{{ Themes and looks
Plug 'vim-airline/vim-airline'
Plug 'arcticicestudio/nord-vim' "Nord theme
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
Plug 'mattn/emmet-vim' "Shortcuts for creating html/jsx boilerplate
Plug 'tpope/vim-surround' "ysiw syntax for surrounding
Plug 'tpope/vim-repeat' "Make vim-surround things repeatable with .
Plug 'cohama/lexima.vim' "Like autoclose + endwise
"}}}

"{{{ Linting
Plug 'bronson/vim-trailing-whitespace' "Mark trailing whitespace
Plug 'w0rp/ale' "Async linting engine
"}}}

"{{{ Tmux
Plug 'christoomey/vim-tmux-navigator' "Work better with tmux
Plug 'benmills/vimux' "Integrate with tmux easily
"}}}

"{{{ Misc.
Plug 'sickill/vim-pasta' "Context aware pasting + intentation
Plug 'godlygeek/tabular' "Make aligning nice and pretty. Must be before plasticboy/vim-markdown
Plug 'metakirby5/codi.vim' "in-vim coding scratchpad/repl
Plug 'AndrewRadev/switch.vim'
"}}}

"{{{ Languages
Plug 'fatih/vim-go' "Make vim good with go
Plug 'ap/vim-css-color' "Make css colours appear in editor in that colour
Plug 'prettier/vim-prettier' "prettier formatter
Plug 'kchmck/vim-coffee-script' "Coffescript support
Plug 'pangloss/vim-javascript' "Makes syntax highlighting etc. more sane for js.
Plug 'elzr/vim-json' "JSON highlighting + concealment
Plug 'mxw/vim-jsx' "Support for JSX
Plug 'plasticboy/vim-markdown' "Amazing markdown support
Plug 'tbastos/vim-lua' "Lua support. Entirely redundant if it wasn't for Redis...
Plug 'uarun/vim-protobuf' "Mmmm protobuf files.
Plug 'vim-python/python-syntax' "Self explanatory really. Supports both python 2 and 3
Plug 'keith/rspec.vim' "Make _spec.rb files nicer
Plug 'slim-template/vim-slim' "Syntax highlighting for slim
Plug 'keith/tmux.vim' "For when I finally get around to fixing my tmux bugs
Plug 'cespare/vim-toml' "For as long as I use dep when writing go
Plug 'stephpy/vim-yaml' "Delete this if there's no real use for it
"""}}}

call plug#end()
