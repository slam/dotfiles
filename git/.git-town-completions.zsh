#compdef git-town

# zsh completion for git-town                             -*- shell-script -*-

_git-town() {
    local state
    local -a completions

    if completions=("${(@f)$(git-town __complete "${words[@]:1}" 2>/dev/null)}"); then
        _arguments -C \
            '1: :->subcmd' \
            '*:: :->args'
        
        case $state in
            subcmd)
                local -a subcommands
                for comp in "${completions[@]}"; do
                    if [[ "${comp[1]}" != ":" ]]; then
                        subcommands+=("${comp%%[[:space:]]*}:${comp#*[[:space:]]}")
                    fi
                done
                _describe -t commands 'git-town subcommands' subcommands
            ;;
            args)
                # Complete options and arguments for git-town subcommands
                local -a opts
                for opt in "${completions[@]}"; do
                    if [[ "${opt[1]}" == "-" ]]; then
                        opts+=("${opt%%[[:space:]]*}:${opt#*[[:space:]]}")
                    fi
                done
                _describe -t options 'git-town options' opts
            ;;
        esac
    fi
}

compdef _git-town git-town

