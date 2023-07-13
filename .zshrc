#########################
# zsh opts              #
#########################
set -o vi
setopt prompt_subst
setopt extendedglob

# Enable ctrl+R searching in zsh
bindkey -v
bindkey '^R' history-incremental-search-backward

#########################
# prompt                #
#########################
# Find and set branch name var if in git repository.
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  unstaged=$(git_unstaged_changes)
  if [[ $branch == "" ]];
  then
    :
  else
    echo ' (%F{220}'$branch$unstaged'%f)'
  fi
}

# Are there unstaged changes?
function git_unstaged_changes()
{
  changes=$(git status --porcelain=v1 2>/dev/null | wc -l)
  if (( $changes >= 1 ));
  then
    echo '*'
  else
  fi
}

# The prompt
function prompt {
  PROMPT="[%F{120}%~%f]$(git_branch_name)"

	if ! [[ -z "$1" ]]; then
		PROMPT="${PROMPT} [${1}]"
	fi

	PROMPT="${PROMPT} » "
}

function zle-line-init zle-keymap-select {
	prompt "${${KEYMAP/vicmd/n}/(main|viins)/i}"
	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

prompt i

#########################
# Aliases               #
#########################
alias vim=nvim
alias vimdiff="nvim -d"
alias ls="ls --color"
alias tf=terraform

#########################
# nvm                   #
#########################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#########################
# Environment variables #
#########################

export XDG_CONFIG_HOME="$HOME/.config"
export HISTFILE=~/.histfile
export HISTSIZE=50000
export SAVEHIST=50000

# default text editor
export EDITOR=nvim

# Golang
export GOPATH=$(go env GOPATH)
export GOBIN=$(go env GOBIN)

# Path extensions
export PATH=$PATH:$HOME/Work/Scribe/scribe/bin
export PATH=$PATH:$HOME/Work/Grafana/grafana-release
export PATH=$PATH:$GOBIN
export PATH=$PATH:$HOME/.bin

source $HOME/.zsh_secrets

source /usr/share/google-cloud-sdk/path.zsh.inc

#########################
# Completion            #
#########################

eval "$(ssh-agent -s)"

# Case-insenstive auto-complete
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit
source /usr/share/google-cloud-sdk/completion.zsh.inc
