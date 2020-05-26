# Load zgen only if a user types a zgen command
zgen () {
        if [[ ! -s ${ZDOTDIR:-${HOME}}/.zgen/zgen.zsh ]]; then
                git clone --recursive https://github.com/tarjoilija/zgen.git ${ZDOTDIR:-${HOME}}/.zgen
        fi
        source ${ZDOTDIR:-${HOME}}/.zgen/zgen.zsh
        zgen "$@"
}

# if the init scipt doesn't exist
if ! zgen saved; then

  zgen oh-my-zsh

  # plugins
#  zgen oh-my-zsh plugins/ssh-agent
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/shrink-path
  zgen load zdharma/fast-syntax-highlighting
  zgen load romkatv/powerlevel10k powerlevel10k

  # completions
  zgen load zsh-users/zsh-completions src

  zgen load agkozak/zsh-z

  # generate the init script from plugins above
  zgen save
fi
