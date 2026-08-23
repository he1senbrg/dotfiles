export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
	git
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

alias c="clear"

alias mc="$HOME/Documents/PollyMC/PollyMC & disown && exit"
alias cmcs="cd $HOME/Documents/CobbleServer/ && java -Xmx6G -jar fabric-server-mc.1.21.1-loader.0.16.14-launcher.1.1.0.jar nogui"

alias ptest="picocom -b 115200 /dev/ttyUSB0"

alias chrin="chromium --incognito & disown && exit"
alias repipe="systemctl --user restart wireplumber pipewire"

alias cfmt="find . -not -path '*/.*' -type f \( -name '*.cpp' -o -name '*.h' \) -exec clang-format -i -style=Chromium {} +"
alias gd="git diff | bat"
alias gdib="git diff --staged | bat"
alias get_esprs='. $HOME/export-esp.sh'
alias get-idf='source "/home/loki/.espressif/tools/activate_idf_v6.0.2.sh"'

alias win='sudo grub-reboot "Memory test (memtest86+)" && sudo reboot'

export PATH=$HOME/.local/bin:$PATH

FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
