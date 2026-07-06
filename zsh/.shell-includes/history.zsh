# Durable, shared zsh history.
# HISTSIZE deliberately > SAVEHIST so HIST_EXPIRE_DUPS_FIRST trims dups
# from memory before unique entries get dropped from the file.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1100000
SAVEHIST=1000000

setopt EXTENDED_HISTORY        # record timestamp + duration for each entry
setopt SHARE_HISTORY           # append as you go and import from other sessions
setopt HIST_FCNTL_LOCK         # lock the histfile so concurrent shells don't corrupt it
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE       # leading space = keep the command out of history
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY             # expand ! history before running, don't execute blind
