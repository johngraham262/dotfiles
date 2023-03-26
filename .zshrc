# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load environment variables (e.g. awscli keys) from ~/.env
if [ -f ~/.env ]; then
  set -a; source ~/.env; set +a
fi

# Praise Allah 🙏
setopt NO_BEEP

# Autocomplete
# https://dev.to/rossijonas/how-to-set-up-history-based-autocompletion-in-zsh-k7o
autoload -U compinit && compinit
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

##################### 
# EXAMPLE ZSH TUTORIAL THAT I USED
# https://scriptingosx.com/2019/07/moving-to-zsh-part-4-aliases-and-functions/
##################### 

# I'm using solarized: http://ethanschoonover.com/solarized
# Be sure to change your terminal's color scheme too.
export CLICOLOR=1
export TERM=xterm-256color
export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"

# Git prompts
source ~/.zsh/plugins/git/git-prompt.sh

# git prompt options
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_STATESEPARATOR=' '
GIT_PS1_HIDE_IF_PWD_IGNORED=true
GIT_PS1_COMPRESSSPARSESTATE=true

# USER PROMPT
# Prompt -- https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
# https://alldrops.info/posts/cli-drops/2021-07-26_customize-zsh-part-2/
  
# enable command-subsitution in PS1
setopt PROMPT_SUBST
# PROMPT='%~% > '
NL=$'\n'
PS1='%F{cyan}%~%f%F{magenta}$(__git_ps1 "  %s")%f %B%(?.%F{green}.%F{red})%(!.#.>)%f%b '
# PS1='%B%F{cyan}%~%f%b%B%(?.%F{green}.%F{red})%(!.#.>)%f%b '

setopt NO_CASE_GLOB
setopt AUTO_CD # smart directory changing if you forget 'cd'

# zsh history 
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY # share history across multiple zsh sessions
setopt APPEND_HISTORY # append to history
setopt INC_APPEND_HISTORY # adds commands as they are typed, not at shell exit
SAVEHIST=5000
HISTSIZE=2000
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history # save history across tabs

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Aliases
alias vi='/usr/local/bin/vim' Mac's vim doesn't have +clipboard
alias vim='/usr/local/bin/vim' Mac's vim doesn't have +clipboard
alias ctags='/usr/local/bin/ctags' # idk why brew's ctags isn't the default
# alias vi="nvim"
# alias vim="nvim"
alias ll='ls -al'
alias bp="echo '[Error] Use nvim ~/.zshrc (zrc)'"
alias zrc='nvim ~/.zshrc'
alias zc='source ~/.zshrc'
# alias vrc="echo '[Error] Use nvim ~/.config/nvim/init.vim (nrc)'"
alias vrc="vim ~/.vimrc"
alias nrc="nvim ~/.config/nvim/init.vim"
alias desk="cd ~/Desktop"
alias gg="git g"
# alias sc="source ~/.bash_profile"
alias json='pbpaste | python -mjson.tool'
alias ox='openx'
alias dk='docker-compose'
alias sshadd='ssh-add ~/id_rsa'

# add-zsh-hook load-nvmrc

function load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"
  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
