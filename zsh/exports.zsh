export LANG=C
export DOTNET_CLI_TELEMETRY_OPTOUT=1

if [ "$TERM" != "xterm-256color" ];
then
  export TERM=xterm-256color
fi

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
