# Include git tab-completion file.
if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
    source `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# I'm using solarized: http://ethanschoonover.com/solarized
# Be sure to change your terminal's color scheme too.
export CLICOLOR=1
export TERM=xterm-256color
export FIN_HOME=~/code/fin-core-beta

#how current git/svn project info in prompt
parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}
parse_svn_branch() {
    svn info 2> /dev/null | grep URL | sed -e "s/.*\/\(.*\)$/(\1)/"
}

# set up colors
txtblack='\[\033[0;30m\]'
txtred='\[\033[0;31m\]'
txtgreen='\[\033[0;32m\]'
txtorange='\[\033[0;33m\]'
txtpurple='\[\033[0;35m\]'
txtwhite='\[\033[0;37m\]'
txtend='\[\033[0m\]'

# Set the prompt
PROMPT_COMMAND='CUR_DIR=`pwd|sed -e "s!$HOME!~!"|sed -E "s!([^/])[^/]+/!\1/!g"`'
#${txtgreen}\u$DIM${txtend} ${txtwhite}@${txtend} ${txtorange}\h${txtend}
PS1="${txtpurple}\$CUR_DIR${txtend} ${txtwhite}\$(parse_git_branch)\$(parse_svn_branch)\$ "  # don't end color, I want my text white
export PS1

alias bp="vim ~/.bash_profile"
alias bps="vim ~/.bash_profile_secrets"
alias vrc="vim ~/.vimrc"
alias desk="cd ~/Desktop"
alias gg="git g"
alias sc="source ~/.bash_profile"
alias json='pbpaste | python -mjson.tool'
alias ox='openx'

# Git autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Opens an xcworkspace file if it exists, then will try to open an xcodeproj if it exists, otherwise ends.
openx() {
    fileToOpen='';
    for file in `find . -maxdepth 1 -name *.xcworkspace`; do
        fileToOpen=$file
    done

    if [ -n "$fileToOpen" ]
    then
        echo $fileToOpen
        open $fileToOpen
    else
        for file in `find . -maxdepth 1 -name *.xcodeproj`; do
            fileToOpen=$file
        done

        if [ -n "$fileToOpen" ]
        then
            echo $fileToOpen
            open $fileToOpen  
        else
            echo "No xcode files to open."
        fi
    fi
}

# gsr = Git Search Replace
gsr() {
    search_string=$1
    replace_string=$2
    if [ -z $search_string ] || [ -z $replace_string ]
    then
        echo "-- Git Search & Replace (gsr)"
        echo "-- usage: gsr search_string replace_string"
    else
        git grep -l $search_string | xargs sed -i '' "s/$search_string/$replace_string/g"
        echo "Crushed it."
    fi
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Source bashrc so you don't have to manage both
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

# AFTER THIS LINE IS NOT STORED 
if [ -f ~/.bash_profile_secrets ] ; then source ~/.bash_profile_secrets; fi
