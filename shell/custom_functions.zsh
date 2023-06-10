# extract can decompress most compressed files, assuming the correct tool is installed.
# Cred to DevRant user Jilano: https://devrant.com/users/Jilano
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1;;
            *.tar.gz) tar xvzf $1;;
            *.bz2) bunzip2 $1;;
            *.rar) unrar x $1;;
            *.gz) gunzip $1;;
            *.tar) tar xvf $1;;
            *.tbz2) tar xvjf $1;;
            *.tgz) tar xvzf $1;;
            *.zip) unzip $1;;
            *.Z) uncompress $1;;
            *.7z) 7z x $1;;
            *) echo "No idea how to extract this filetype";;
        esac
    else
        "'$1' is not a valid file!"
    fi
}

# The following kubernetes command was stolen from @eqyiel.
# Onto @eqyiel the glory
kubectl() {
  if ! type __start_kubectl >/dev/null 2>&1; then
    source <(command kubectl completion zsh)
    compdef k=kubectl
  fi
  command kubectl "$@"
}
