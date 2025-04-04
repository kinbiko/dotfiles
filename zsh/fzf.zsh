export FZF_DEFAULT_COMMAND='rg --files-with-matches --hidden .'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers --line-range=:500 {}"'

source <(fzf --zsh)

function checkout() {
    local git_branches pr_num_title_branch view branch num

    git_branches=$(git branch)
    pr_num_title_branch=$(gh pr list --json 'title,number,headRefName' | jq '.[] | {number: .number|tostring, title, headRefName} | .number + "\t" + .title + "\t" + .headRefName')
    view="$git_branches\n$pr_num_title_branch"
    branch=$(echo $view | fzf --prompt="Select a branch: ")

    if [[ -n "$branch" ]]; then
        num=$(echo "$branch" | cut -f 1)
        if [[ $num =~ ^[0-9]+$ ]] ; then
            gh pr checkout $num
        else
            git checkout $(echo $branch | xargs)
        fi
    fi
}
