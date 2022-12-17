local snr = {noremap = true, silent = true}
local function bufmap(...) vim.api.nvim_buf_set_keymap(0, ...) end
bufmap('n', '<leader>a', '<cmd>GoAlternate<cr>', snr) -- Switch between test and production files
bufmap('n', '<leader>i', '<cmd>GoImports<cr>', snr) -- Run goimports
bufmap('n', '<leader>l', '<cmd>GoMetaLinter<cr>', snr) -- Run the linter
bufmap('n', '<leader>t', '<cmd>GoTest!<cr>', snr) -- Run all the tests in the current package
bufmap('n', '<leader>T', '<cmd>GoTestFunc!<cr>', snr) -- Run the test function the curser is currently {o,i}n
bufmap('n', '<leader>c', '<cmd>GoCoverageToggle<cr>', snr) -- Run the test function the curser is currently {o,i}n

-- Most other snippets are handled by luasnip
bufmap('i', '\\e', '<cmd>GoIfErr<cr>', snr) -- if err != nil shorthand that returns the error & any default values
bufmap('i', '\\f', '<cmd>GoFillStruct<cr>i', snr) -- Populate struct with all its default values
bufmap('i', ',=', ' := ', snr) -- Insert variable assignment without needing to find :

-- Play nice with gofmt
-- Make tabs just show up as spaces without any further clutter
vim.bo.tabstop = 4 -- columns per tab character
vim.bo.softtabstop = 4 -- columns per tab key press in insert mode. Also on backspace
vim.bo.shiftwidth = 4 -- columns per 'indent', used for <, >, and =
vim.bo.expandtab = false -- converts tabs to spaces

vim.wo.listchars='tab:  ,trail:·,extends:>,precedes:<'

vim.g.go_test_show_name = 1 -- Show the name of the test that's being run
vim.g.go_jump_to_error = 0 -- Don't automatically jump to the first error in the quickfix window

-- Highlight some more stuff
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_extra_types = 1

vim.g.go_metalinter_deadline = "5s" -- In case the linter runs for too long

-- Make sure we run the right linter command
vim.g.go_metalinter_command='golangci-lint run --print-issued-lines=false'

-- Print info of the type under the cursor
vim.g.go_def_mode = 'gopls'
vim.g.go_def_mapping_enabled = 0

-- If a buffer is already open with the file that would be opened with GoDef,
-- then use this window instead of duplicating.
vim.g.go_def_reuse_buffer = 0

-- Use a quickfix window for compilation errors, lint issues etc. that can
-- easily be closed by fixing the errors instead of haivng to close the window
-- manually.
vim.g.go_list_type = 'quickfix'

vim.g.go_test_timeout = '7s' -- The default of 10 seconds is too long

vim.g.go_metalinter_autosave_enabled = {'vet', 'golint'} -- The metalinter linters to run on save
vim.g.go_metalinter_enabled = {} -- Let the metalinter run all linters when manually invoked

vim.g.go_info_mode = 'gopls' -- Use the LSP to show info
vim.g.go_rename_command='gopls' -- Use the LSP for renaming rename
vim.g.go_implements_mode='gopls' -- Use the LSP for GoImplements
vim.g.go_gopls_complete_unimported = 1 -- Include suggestions from unimported packages
vim.g.go_diagnostics_level = 2 -- Treat both warnings and errors in diagnostics.
vim.g.go_doc_popup_window = 1 -- Use a floating window for docs :GoDoc and K instead of a preview window.
