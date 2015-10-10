Configuration/convenience miscellany made portable.

## vim
Vim config requires [vundler](https://github.com/gmarik/Vundle.vim). So:
* Install Vundler...

    `$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
* Copy `.vimrc` and `.vimrc.bundles` to `~/`, or symlink them.
* Open vim and type `:PluginInstall`

## bin/
These are some handy scripts that I've collected for various dev needs. I find it convenient to put symlinks in my `~/bin` to these scripts located in my local repo.

## aliases/
Aliases, oddly. I use symlinks for these too, though I add a period before the link-name (e.g. `~/.aliases.home`) to keep them hidden ala horry convention. The files in the repo do not have said periods.
