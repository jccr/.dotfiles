export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.local/bin:$PATH"

# Start zsh setup profiling if it was enabled
if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi

# files to source in priority
source ~/.zgen.zsh

# load zsh config files
config_files=(~/.zsh/**/*.zsh(N))
for file in ${config_files}
do
  source $file
done

eval "$(direnv hook zsh)"

zstyle ':completion:*' menu select

# End zsh setup profiling if it was enabled
if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

