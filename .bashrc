set -o vi

parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(`printf "\033[00;35m"`\1`printf "\033[01;30m"`)─/"
}

export PS1="\[\e[01;30m\]┌(\[\e[00;32m\]^.^\[\e[01;30m\])─(\[\e[36m\]\u@\h\[\e[01;30m\])─\$(parse_git_branch)(\[\e[00;34m\]\w\[\e[01;30m\])\n\[\e[01;30m\]└─»\[\e[00m\] "
