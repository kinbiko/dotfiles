if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "dockerfile"

syntax case ignore

syntax match dockerfileKeyword /\v^\s*(ONBUILD\s+)?(ADD|ARG|CMD|COPY|ENTRYPOINT|ENV|EXPOSE|FROM|HEALTHCHECK|LABEL|MAINTAINER|RUN|SHELL|STOPSIGNAL|USER|VOLUME|WORKDIR)\s/
highlight link dockerfileKeyword Keyword

syntax region dockerfileString start=/\v"/ skip=/\v\\./ end=/\v"/
highlight link dockerfileString String

syntax match dockerfileComment "\v^\s*#.*$"
highlight link dockerfileComment Comment

set commentstring=#\ %s

" match "RUN", "CMD", and "ENTRYPOINT" lines, and parse them as shell
let s:current_syntax = b:current_syntax
unlet b:current_syntax
syntax include @SH syntax/sh.vim
let b:current_syntax = s:current_syntax
syntax region shLine matchgroup=dockerfileKeyword start=/\v^\s*(RUN|CMD|ENTRYPOINT)\s/ end=/\v$/ contains=@SH

