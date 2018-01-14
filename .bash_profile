export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:/Users/lxuser/bin
export PATH=$PATH:/Users/lxuser/.pyenv
export PATH=$PATH:/Users/lxuser/Documents/potion/potion/bin
export CLICOLOR=1
eval "$(pyenv init -)"

source /Users/lxuser/Documents/bash-powerline/bash-powerline/bash-powerline.sh
powerline-daemon

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# one all command for brew
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'

# don't include pyenv PATH for brew so we don't get errors
# what this does is a replacement of '/$(pyenv root)/shims:' with nothing
alias brew="env PATH=$(echo $PATH | sed -E 's|'$(pyenv root)'/shims:||g' | sed -E 's|/Users/lxuser/Library/Python/3.6/bin:||g') brew" 

