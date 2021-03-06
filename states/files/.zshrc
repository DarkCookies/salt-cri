#zsh config file by nému & nico

export EDITOR="vim"
export HISTFILE=~/.zsh_history
export HISTSIZE=4096
export LANG=en_US.UTF-8
export SAVEHIST=4096

if command most 2> /dev/null
then
    export PAGER="most"
elif command less 2> /dev/null
then
    export PAGER="less"
fi

export LESSCHARSET="utf-8"
export LESS_TERMCAP_mb=$(printf "\e[1;37m")
export LESS_TERMCAP_md=$(printf "\e[1;31m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;47;30m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")

setopt appendhistory nomatch
setopt extended_glob
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt sh_word_split # Do not quote expanded vars
unsetopt beep notify


if [ "`uname`" = "FreeBSD" ]; then
  export CLICOLOR="YES"
  export LSCOLORS="ExGxFxdxCxDxhbadExEx"
  alias ls='ls -I'
else
  alias ls='ls --color=auto -F -h'
fi
alias ll='ls -l'
alias l='ll'
alias la='ls -la'
alias lla='ls -la'
alias df='df -h'
alias reload="source ~/.zshrc"

autoload -U compinit colors && compinit && colors

zstyle ':completion:*:default' list-colors ''

case `echo $(hostname) | grep -oE '^[0-9a-f]'` in
    "b"|"6")
	HOST_COLOR="red" ;;
    "1"|"8"|"7")
	HOST_COLOR="magenta" ;;
    "5"|"4"|"a")
	HOST_COLOR="yellow" ;;
    "2"|"9"|"d")
	HOST_COLOR="blue" ;;
    "f"|"c"|"e")
	HOST_COLOR="cyan" ;;
    "3"|"0"|"f")
	HOST_COLOR="green" ;;
    *)
	HOST_COLOR="white" ;;
esac

PROMPT="%(!.%F{red}%B.%F{white})%n@%F{${HOST_COLOR}}%m%(!.%b.)%f:%F{cyan}%~%f%(?.%F{green}.%B%F{red})%#%f%b "
RPROMPT='%F{blue}%T%f %(?.%F{green}.%F{red}%B)%?%f'
setopt nopromptcr

# Fix keyboard

bindkey -e
case $TERM in (rxvt*) #urxvt
  bindkey "\e[7~"  beginning-of-line
  bindkey "\e[8~"  end-of-line
esac    
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey '^?' backward-delete-char
bindkey "\e[3~" delete-char

for confFiles in ~/.myzsh ~/.zshrc.local ~/.zshrc_functions; do
    [ -r "$confFiles" ] && source "$confFiles"
done
