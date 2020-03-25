source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/exports.zsh
source $ZDOTDIR/setopt.zsh
source $ZDOTDIR/git.zsh
source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/path.zsh


# Initialize colors
autoload -U colors
colors

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    eval "$("$BASE16_SHELL/profile_helper.sh")"
