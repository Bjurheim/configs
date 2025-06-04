set -o vi

parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(`printf "\033[00;35m"`\1`printf "\033[01;30m"`)─/"
}

export PS1="\[\e[01;30m\]┌(\[\e[00;32m\]^.^\[\e[01;30m\])─(\[\e[36m\]\u@\h\[\e[01;30m\])─\$(parse_git_branch)(\[\e[00;34m\]\w\[\e[01;30m\])\n\[\e[01;30m\]└─»\[\e[00m\] "

function ssh() {
  if [ $# -ge 1 ]; then
    host=${1#*@}
    host=${host%%.*}

    if command -v tmux &>/dev/null && [ -n "$TMUX" ]; then
      old_name=$(tmux display-message -p '#W')
      tmux rename-window "$host"
    else
      printf '\033]0;%s\007' "$host"
    fi

    command ssh "$@"

    # After SSH ends, restore original title
    if [ -n "$TMUX" ]; then
      tmux rename-window "$old_name"
    else
      printf '\033]0;%s\007' "$old_name"
    fi
  else
    command ssh "$@"
  fi
}
