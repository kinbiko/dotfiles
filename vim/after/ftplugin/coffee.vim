"Run mocha test, based on which type of quotes are used for the `it ''`
nnoremap tt :w<CR>yi':! clear;npm run testlog -- -g "<C-r>0"<CR>
nnoremap TT :w<CR>yi":! clear;npm run testlog -- -g "<C-r>0"<CR>

set foldmethod=indent "Fold based on indentation.

set noautoindent "Manually handling indentation for this filetype
set tabstop=2 "columns per tab character
set softtabstop=2 "columns per tab key press in insert mode. Also on backspace
set shiftwidth=2 "columns per 'indent', used for <, >, and =
set expandtab "converts tabs to spaces
