export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:/Users/lxuser/bin
export PATH=$PATH:/Users/lxuser/.pyenv
export CLICOLOR=1
eval "$(pyenv init -)"

# Powerline
export PATH=$PATH:$HOME/Library/Python/2.7/bin
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
# source /Users/lxuser/.pyenv/versions/3.6.4/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh

. /Users/lxuser/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# one all command for brew
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'

# don't include pyenv PATH for brew so we don't get errors
# what this does is a replacement of '/$(pyenv root)/shims:' with nothing
alias brew="env PATH=$(echo $PATH | sed -E 's|'$(pyenv root)'/shims:||g' | sed -E 's|/Users/lxuser/Library/Python/3.6/bin:||g') brew" 

