"Configure autoclose
let g:AutoClosePairs = "() {} \" `"
"This would have put spaces on both sides inside brackets, but
"breaks vim abbreviations when followed by space.
let g:AutoCloseExpandSpace = 0

"Make jsx syntax show up in .js files
let g:jsx_ext_required = 0
"=== Styles ===
let g:molokai_original=1
let g:rehash256=1

"Supertab context magic
let g:SuperTabDefaultCompletionType = "context"

colorscheme jellyx
let g:javascript_enable_domhtmlcss = 1 "Makes css/html syntax available in .js files(React)

