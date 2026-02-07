# Tokyo Night (Night) theme for VIT
# https://github.com/folke/tokyonight.nvim
#
# Urwid 256-color: #RGB is a 6x6x6 cube (digits 0-5), gN is grayscale (0-100).
# Grayscale reference: g0=#080808 g3=#121212 g7=#1c1c1c g11=#262626
#                      g15=#303030 g19=#3a3a3a g23=#444444 g27=#4e4e4e
#
# Tokyo Night (Night) palette:
#   bg         #1a1b26 -> g7     bg_highlight #292e42 -> g11
#   term_black #414868 -> g23    dark3        #545c7e -> g27
#   fg         #c0caf5 -> #345   fg_dark      #a9b1d6 -> #334
#   blue       #7aa2f7 -> #235   blue0        #3d59a1 -> #113
#   cyan       #7dcfff -> #245   magenta      #bb9af7 -> #325
#   purple     #9d7cd8 -> #324   orange       #ff9e64 -> #531
#   yellow     #e0af68 -> #431   green        #9ece6a -> #341
#   green1     #73daca -> #244   red          #f7768e -> #522
#   red1       #db4b4b -> #411

theme = [
    # Column headers: fg on bg_highlight
    ('list-header', '', '', '', '', ''),
    ('list-header-column', 'white', 'dark gray', '', '#345', 'g11'),
    ('list-header-column-separator', 'white', 'dark gray', '', '#345', 'g11'),

    # Alternating row stripe: fg on bg_highlight
    ('striped-table-row', '', 'dark gray', '', '', 'g15'),

    # Focused/selected row: bg on blue
    ('reveal focus', 'black', 'light blue', 'standout', 'g7', '#235'),

    # Status messages: fg on blue0
    ('message status', 'white', 'dark blue', 'standout', '#345', '#113'),

    # Error messages: fg on red1
    ('message error', 'white', 'dark red', 'standout', '#345', '#411'),

    # Status bar: purple on bg
    ('status', 'light magenta', 'black', '', '#324', 'g7'),

    # Flash effect
    ('flash off', 'black', 'black', 'standout', 'g7', 'g7'),
    ('flash on', 'white', 'black', 'standout', '#345', 'g7'),

    # Popups: fg on bg_highlight
    ('pop_up', 'white', 'black', '', '#345', 'g11'),

    # Buttons: bg on blue / fg on term_black
    ('button action', 'black', 'light blue', '', 'g7', '#235'),
    ('button cancel', 'white', 'dark gray', '', '#345', 'g23'),
]
