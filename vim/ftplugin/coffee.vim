"Run mocha test
nnoremap ,1 :w<CR>yi':! clear;npm run testlog -- -g "<C-r>0"<CR>
nnoremap ,2 :w<CR>yi":! clear;npm run testlog -- -g "<C-r>0"<CR>

"Make cl. insert a console log statement
inoremap cl. console.log()<ESC>jkha

"=== Folding ===
set foldmethod=indent "Fold based on indentation.
set foldnestmax=10 "You're writing bad code if you need to up this one, even for coffeescript promise chains

"=== Indentation ===
set noautoindent "Manually handling indentation for this filetype
set tabstop=2 "columns per tab character
set softtabstop=2 "columns per tab key press in insert mode. Also on backspace
set shiftwidth=2 "columns per 'indent', used for <, >, and =
set expandtab "converts tabs to spaces

