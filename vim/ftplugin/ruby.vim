"Inspired by keeganlow's settings
"regenerate the tags file, including project gems
map <Leader>rv :!ctags --tag-relative --exclude=.git --languages=ruby -R * `rvm gemdir`/gems/*<CR><CR>
map <Leader>rb :!ctags --tag-relative --exclude=.git --languages=ruby -R * `rbenv prefix`/*<CR><CR>

" configure vimux-ruby-test so ruby tests can run in 20% horizontal pane.
let g:vimux_ruby_cmd_unit_test = "bundle exec ruby"
let g:vimux_ruby_cmd_all_tests = "rake test:parallel"

inoremap >> <space>=><space>

if filereadable("ruby.local.vim")
  source "ruby.local.vim"
endif
