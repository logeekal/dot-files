#!/bin/bash

# General bash commands
alias ll="ls -la"

# yarn aliases
alias yw="yarn workspace"

# git alias
## gco shows branches based on last commit that was done.
### gco -> git checkout with a lookup list of branches sorted by updated by latest commit dates.
alias gco="git checkout \"\$(git for-each-ref --sort=committerdate refs/heads/ --format='%(color: red)%(committerdate:short) %(color: cyan)%(refname:short)' | awk '{print \$2}'| fzf +s --tac)\""
alias gcb="git checkout -b"
alias ga="git add "
alias grc="git rm --cached \"\$(git diff --cached --name-only | fzf -m --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all)\""
alias gcm="git commit -m"
alias gcmv="git commit --no-verify -m "
alias gst="git status"
alias glog="git log --oneline --graph --first-parent"
alias gbd="git branch -D \"\$(git branch -v | sed \"s/\*/ /\" | awk '{print \$1}' | fzf)\""
alias gpu="git push -u origin \"\$(git branch --show-current)\""
## merge conflicts
alias gmerges="git ls-files -u  | awk '{print \$4}' | sort | uniq"
## checkout previous branch
alias gcop="git checkout -"

# tmux alias
### tmux attach session and select the session with a lookup list with FZF
alias tma="tmux attach -t \"\$(tmux ls | sed \"s/:/ /\"  | awk '{print \$1}' | fzf)\" " ;
alias tmd="tmux detach";

#neovim alias
alias vi=nvim
alias vim=nvim

#diskusage
alias du="du -h --max-depth=1"

alias mkdir="mkdir -p"

#last command
alias fc="fc -e vim"

#dotgit for the bare repo for saving dot files
alias dotgit="git --git-dir=$HOME/dot-files --work-tree=$HOME"

function sshadd {
    eval $(ssh-agent -s)
    ssh-add ${1}
}


# Convert video to gif file.
# Usage: video2gif video_file (scale) (fps)
video2gif() {
    ffmpeg -y -i "${1}" -vf fps=${3:-10},scale=${2:-320}:-1:flags=lanczos,palettegen "${1}.png"
    ffmpeg -i "${1}" -i "${1}.png" -filter_complex "fps=${3:-10},scale=${2:-320}:-1:flags=lanczos[x];[x][1:v]paletteuse" "${1}".gif
    rm "${1}.png"
}
