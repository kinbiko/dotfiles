"=== Indentation ===

set tabstop=4 "number of VISUAL SPACES per tab
set softtabstop=4 "Number of spaces per tab when editing
set shiftwidth=4 "Indenting is 4 spaces
set expandtab "converts tabs to spaces

"=== Folding ===

set foldlevel=2 "Show complete method signatures by default
set foldmethod=syntax "Fold based on indentation.

inoremap sout System.out.println();<left><left>
"For .cs/.js muscle memory sanity
inoremap <localleader>l System.out.println();<left><left>

"=== Abbreviations ===

iabbrev pubic public
iabbrev psf private static final
iabbrev pusf public static final

onoremap q i"
