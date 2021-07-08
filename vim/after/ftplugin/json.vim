" Allow comments to show up in JSON files in case you're editing a jsonc file
" with a .json file-ending, like coc-settings.json
autocmd FileType json syntax match Comment +\/\/.\+$+
