# ZSH configuration ###########################################################

# tmux initialization
# session="main"
# 
# tmux has-session -t "$session" 2> /dev/null
# 
# if [ $? != 0 ]; then
#     tmux new -s "$session"
# fi
# 
# tmux attach-session -t "$session"

# uncomment and reboot shell to be able to push to github
source ~/Bash/sshadd.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Path to your oh-my-zsh installation.
export ZSH="/mnt/c/Arquivos/.oh-my-zsh"

# Plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration ##########################################################

#############################################
### follow one of the following to set    ###
### the DISPLAY environment variable with ###
### the correct IP address on launch.     ###
#############################################

# expands aliases in non-interactive shells
set shell=zsh
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0 #GWSL
# export PULSE_SERVER=tcp:$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}') #GWSL
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1
export GDK_SCALE=2 #GWSL

TERM=alacritty

# TeXlive
PATH=/mnt/c/Arquivos/Code/Latex/texlab/target/release:/usr/local/texlive/2021/bin/x86_64-linux:$PATH

# Run `p10k configure` or edit ~/.p10k.zsh to configure prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## Aliases

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# Run programs
alias open="wslview"
alias anki="wslview 'C:/Program Files/Anki/anki.exe'"
alias rtk="wslview 'C:/Arquivos/Books/Remembering the Kanji 1-3 (ENG + Flashcards)/Remembering the Kanji 1.pdf'"
alias chrome="wslview 'C:/Program Files (x86)/Google/Chrome/Application/chrome.exe'"
alias nnvim="/mnt/c/Arquivos/Neovim/nightly/nvim.appimage"
alias disc="wslview 'C:\Users\Nello\AppData\Local\Discord\Update.exe --processStart Discord.exe'"
alias spot="wslview 'C:\Users\Nello\AppData\Roaming\Spotify\Spotify.exe'"
alias exp="explorer.exe"
alias hexp="explorer.exe ."

# Run bash scripts
alias agenda="bash '/mnt/c/Arquivos/Bash/agenda/agenda.sh'"
alias regexhelp="bash '/mnt/c/Arquivos/Bash/regexhelp.sh'"
alias updatesetup="bash '/mnt/c/Arquivos/Bash/updatesetup.sh'"

# splash screen
alias neof="clear && neofetch"

# Change directory
alias _semester="cd '/mnt/c/Arquivos/UFLA/Disciplinas/_semestre_atual'"
alias _projects="cd /mnt/c/Arquivos/UFLA/DCS/Projects"
alias downloads="cd '/mnt/c/Arquivos/Downloads'"

# ls aliases
alias la="ls -la"
alias ll="ls -og --color=always | sed -re 's/^[ a-z0-9-]*//'" # list without perms
alias lt="ls -ogtr --color=always | sed -re 's/^[ a-z0-9-]*//'" # list without perms/
                                                                # ordered by creation date
