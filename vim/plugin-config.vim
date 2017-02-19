
"Configure autoclose
let g:AutoClosePairs = "() {} \" `"

"Make jsx syntax show up in .js files
let g:jsx_ext_required = 0
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
"=== Styles ===
let g:molokai_original=1
let g:rehash256=1

colorscheme molokai
let g:javascript_enable_domhtmlcss = 1 "Makes css/html syntax available in .js files(React)

"====================== TODO numbering =====================
"The line lengths are capped at 80 characters, so rather than inlining the
"TODO comments I've assembled them all here.
"
"1: Learn more about/investigate. This plugin/feature looks promising, but
"needs more configuration before I can use it confidently in my workflow.
"
"2: Introduce into workflow. This tool is great, but I haven't actually
"started using it yet.
"

"====================== WANT =====================
"This is a list of all the plugin functions I want.
"1: A veritcal bar running down the screen at 121 characters by default,
"80 characters for e.g. vimscript.
"
"2: Customise this buffer to work with NERDTree. Ideally as a list of buffers
"aligned as vertically, taking up [one line, half the screen height] depending
"on how many buffers there are, and with NERDTree using the rest.
"This is likely a task that'll require learning Vimscript and implementing
"this plugin myself.
