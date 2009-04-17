# Some of this file is mine, some is take from spider's zshrc, and some from
# guckes's zshrc. Some stuff is totally random. Most of this mutated
# over time and eventually went to separate files, like xterminus has.

git_prompt_info() {
  # return the name of the git branch we're on
  local ref
  ref=$(git symbolic-ref -q HEAD 2>/dev/null \
     || git-name-rev --name-only HEAD 2>/dev/null) || return 1
  echo " ${ref#refs/heads/} "
}

PROMPT=$'%{\e[1;32m%}%n@%m%{\e[0;37m%}$(git_prompt_info):: '
RPROMPT=$'%{\e[0;37m%}[$green%.%{\e[0;37m%}]'

# SCREENDIR will screw screen up
unset SCREENDIR

# Make sure no cores can be dumped while zsh is in charge. I don't know if
# this limit thing uses ulimit or what, but it seems to work..
limit coredumpsize 0

# History things
HISTFILE=$HOME/.zsh/history
SAVEHIST=500
HISTSIZE=800
TMPPREFIX=/tmp

. ~/.zsh/completion
. ~/.zsh/opts
. ~/.zsh/colours
. ~/.zsh/functions
. ~/.zsh/zstyle
. ~/.zsh/aliases
. ~/.zsh/exports
. ~/.zsh/terms

. ~/.zsh/j.sh

autoload -U zmv
alias mmv='zmv -W'

if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/vc/1 ]]; then
    xinit
    logout
fi

#if [[ -n $DISPLAY ]]; then
#    alias vim="gvim -v"
#fi
