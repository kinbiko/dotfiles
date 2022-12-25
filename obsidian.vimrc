" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

nmap <up> {
nmap <down> }

nmap 0 ^

nmap + <C-a>
nmap - <C-x>

nmap ; :

nmap Q @@

imap jk <C-c>

vmap p "_dP

exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }
exmap surround_backticks surround ` `
exmap surround_latex surround $ $
exmap surround_latex_paragraph surround $$ $$

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
nunmap S
vunmap S

map S" :surround_double_quotes
map S' :surround_single_quotes
map Sb :surround_brackets
map S( :surround_brackets
map S) :surround_brackets
map S[ :surround_square_brackets
map S[ :surround_square_brackets
map S{ :surround_curly_brackets
map S} :surround_curly_brackets
map SB :surround_curly_brackets
map S` :surround_backticks
map Sl :surround_latex
map SL :surround_latex_paragraph
