"Run mocha test
nnoremap ,1 :w<CR>yi':! clear;npm run testlog -- -g "<C-r>0"<CR>
nnoremap ,2 :w<CR>yi":! clear;npm run testlog -- -g "<C-r>0"<CR>

"Make cl. insert a console log statement
inoremap cl. console.log()<ESC>jkha

