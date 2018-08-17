"{{{ AUTOCLOSE
"Configure autoclose
let g:AutoClosePairs = "() {} \" `"
"This would have put spaces on both sides inside brackets, but
"breaks vim abbreviations when followed by space.
let g:AutoCloseExpandSpace = 0
"}}}
"{{{ NERDTREE
let NERDTreeIgnore=['node_modules$', '\~$', '\.git$', '\.DS_Store$', '\.meta$']
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1

"let g:NERDTreeDisableFileExtensionHighlight = 1
"let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" you can add these colors to your .vimrc to help customizing
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = s:orange
let g:NERDTreeExtensionHighlightColor['js'] = s:blue
let g:NERDTreeExtensionHighlightColor['go'] = s:orange
let g:NERDTreeExtensionHighlightColor['java'] = s:darkBlue
let g:NERDTreeExtensionHighlightColor['groovy'] = s:green
let g:NERDTreeExtensionHighlightColor['rb'] = s:red
let g:NERDTreeExtensionHighlightColor['json'] = s:blue
let g:NERDTreeExtensionHighlightColor['vim'] = s:white
let g:NERDTreeExtensionHighlightColor['xml'] = s:beige
let g:NERDTreeExtensionHighlightColor['gradle'] = s:beige

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
let g:NERDTreeExactMatchHighlightColor['Dockerfile'] = s:red " sets the color for .gitignore files

let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb
"}}}

"{{{ ALE
let g:ale_sign_error = '嫌'
let g:ale_sign_warning = '臭'

let g:ale_fixers = {
\  'ruby': ['rubocop'],
\}
"}}}

"Make jsx syntax show up in .js files
let g:jsx_ext_required = 0
let g:javascript_enable_domhtmlcss = 1 "Makes css/html syntax available in .js files(React)

"{{{ Tagbar
let g:tagbar_autoclose = 1
"}}}

" {{{ VIM-GO

" Only use quickfix windows
let g:go_list_type = "quickfix"

" }}}
