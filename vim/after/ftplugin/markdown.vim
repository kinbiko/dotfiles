au Filetype markdown set spell wrap

nnoremap <localleader>c o```<CR><CR>```<UP>
nmap <localleader>b ysaw*
nmap <localleader>i ysaw_
nmap <localleader>s ysaw~

"{{{plasticboy/vim-markdown
"
"Allow concealing
set conceallevel=2

"For frontmatter in blogs etc.
let g:vim_markdown_frontmatter = 1

"}}}
