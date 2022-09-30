# Some startup applications
# if [ -f /usr/bin/neofetch ]; then neofetch; fi
if [ -f "/tmp/weather_today" ]; then cat /tmp/weather_today; fi
if [ -f "$(which todo.txt)" ]; then $HOME/scripts/todo; fi
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

fpath=($HOME/.config/zsh/completion $fpath)
# Added to allow TRAMP to connect without hanging
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

# Enable colors and change prompt:
autoload -U colors && colors

# History in cache directory:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history

if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|tmux*|xterm*) ]]
then
    precmd()
    {
        # output on which level (%L) this shell is running on.
        # append the current directory (%~), substitute home directories with a tilde.
        # "\a" bell (man 1 echo)
        # "print" must be used here; echo cannot handle prompt expansions (%L)
        print -Pn "\e]0;$(id --user --name)@$(hostnamectl hostname): zsh[%L] %~\a"
    }

    preexec()
    {
        # output current executed command with parameters
        echo -en "\e]0;$(id --user --name)@$(hostnamectl hostname): ${1}\a"
    }
fi

# autoload -Uz add-zsh-hook

# function xterm_title_precmd () {
#   print -Pn -- '\\e\]2;%n@%m %\~\\a' \[\[ "$TERM" == 'screen'\* \]\] && print -Pn -- '\\e\_\\005{g}%n\\005{-}@\\005{m}%m\\005{-} \\005{B}%\~\\005{-}\\e\\\\'
# }

# function xterm_title_preexec () {
#   print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a" \[\[ "$TERM" == 'screen'\* \]\] && { print -Pn -- '\\e\_\\005{g}%n\\005{-}@\\005{m}%m\\005{-} \\005{B}%\~\\005{-} %# ' && print -n -- "${(q)1}\\e\\\\"; }
# }

# if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then

#   add-zsh-hook -Uz precmd xterm\_title\_precmd

#   add-zsh-hook -Uz preexec xterm\_title\_preexec
# fi

autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Enable searching through history
bindkey '^R' history-incremental-pattern-search-backward

# Edit line in vim buffer ctrl-v
# autoload edit-command-line; zle -N edit-command-line
# bindkey '^v' edit-command-line
# Enter vim buffer from normal mode
autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

echo -ne '\e[5 q' # Use beam shape cursor on startup.
precmd() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Control bindings for programs
# bindkey -s "^g" "lc\n"
# bindkey -s "^h" "history 1\n"
bindkey -s "^l" "clear\n"
# bindkey -s "^d" "dlfile\n"
bindkey -s "^f" "tmux-sessionizer\n"


#Rebind HOME and END to do the decent thing:
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
case $TERM in (xterm*)
bindkey '\eOH' beginning-of-line
bindkey '\eOF' end-of-line
esac

#To discover what keycode is being sent, hit ^v
#and then the key you want to test.
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

#And DEL too, as well as PGDN and insert:
bindkey '\e[3~' delete-char
bindkey '^[[P' delete-char
bindkey '\e[6~' end-of-history
bindkey '\e[2~' redisplay

#Now bind pgup to paste the last word of the last command,
bindkey '\e[5~' insert-last-word

if [ -f "$HOME/.config/aliasrc" ]; then source "$HOME/.config/aliasrc"; fi
if [ -f "$HOME/.config/local_aliasrc" ]; then source "$HOME/.config/local_aliasrc"; fi

# Load zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# Load zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source $HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
# Suggest aliases for commands
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh 2>/dev/null
# Search repos for programs that can't be found
source /usr/share/doc/pkgfile/command-not-found.zsh 2>/dev/null
# Load autojump
source /usr/share/autojump/autojump.zsh 2>/dev/null
source $HOME/.autojump/etc/profile.d/autojump.sh 2>/dev/null

# load custom executable functions
for function in $HOME/.config/zsh/functions/*.zsh; do
  source $function
done

if [ -f "$(which starship)" ]; then
  eval "$(starship init zsh)"
else
  source $HOME/.config/zsh/themes/awesomepanda.zsh-theme
fi

if [ -f "/usr/share/fzf/key-bindings.zsh" ]; then
  source "/usr/share/fzf/key-bindings.zsh"
elif [ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]; then
  source "/usr/share/doc/fzf/examples/key-bindings.zsh"
fi
if [ -f "/usr/share/fzf/completion.zsh" ]; then
  source "/usr/share/fzf/completion.zsh"
elif [ -f "/usr/share/doc/fzf/examples/completion.zsh" ]; then
  source "/usr/share/doc/fzf/examples/completion.zsh"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
