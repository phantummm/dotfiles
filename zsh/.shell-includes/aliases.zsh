alias rdots="git -C ~/dot-files reset --hard HEAD"
alias sdots="git -C ~/dotfiles add -A;git -C ~/dotfiles commit -m 'Saving dots.';git -C ~/dotfiles push origin master"
alias zz='source ~/.zshrc'
alias val='vi ~/.shell-includes/aliases.zsh'
alias cda='cd ~/s/apps/apps/'
alias cdapp='cd ~/s/apps/apps/employers/'
alias cdui='cd ~/s/apps/packages/ui/'
alias cdadv='cd ~/s/apps/packages/advisors-frontend/'
alias cdemp='cd ~/s/apps/packages/employers-frontend/'
alias cde2e='cd ~/s/apps/packages/employers-e2e/'
alias cde2a='cd ~/s/apps/packages/advisors-e2e/'
alias gbrm='git branch | grep -v "main" | xargs git branch -D'
alias rof="bin/rspec --only-failures"
alias gdm="git diff origin/main...HEAD"
alias chu='bin/chusaku -c "packs/*/app/controllers/**/*_controller.rb"'
alias capp='code ~/s/apps/apps.code-workspace'
alias pwc='rm -rf ~/s/apps/apps/employers/public/vite-test/'
alias ttr='touch ~/s/apps/apps/employers/tmp/restart.txt'
alias plog='tail -f ~/Library/Logs/puma-dev.log'
alias dbnuke='docker-compose down && docker-compose up -d && bin/rails db:reset'
alias anno='bundle exec annotaterb models'
