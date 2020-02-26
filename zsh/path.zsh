SYSTEM_PATH=$PATH
unset PATH

PATH=/usr/local/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:$XDG_CONFIG_HOME/npm-global/bin
PATH=$PATH:$(ruby -e 'print Gem.user_dir')/bin
PATH=$PATH:$HOME/.dotnet/tools
export PATH
