setopt append_history # Append to history file
setopt extended_history # Write the history file in the ':start:elapsed;command' format
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
setopt hist_find_no_dups # Don't display a previously found event
setopt hist_ignore_all_dups # Delete an old recorded event if a new event is a duplicate
setopt hist_ignore_dups # Don't record an event that was just recorded again
setopt hist_ignore_space # Don't record an event starting with a space
setopt hist_no_store # Don't store history commands
setopt hist_reduce_blanks # Remove superfluous blanks from each command line being added to the history list
setopt hist_save_no_dups # Don't write a duplicate event to the history file
setopt hist_verify # Don't execute immediately upon history expansion
setopt inc_append_history # Write to the history file immediately, not when the shell exits
setopt share_history # Share history between all sessions

setopt always_to_end # Move cursor to the end of a completed word
setopt auto_list # Automatically list choices on ambiguous completion
setopt auto_menu # Show completion menu on a successive tab press
setopt rm_star_silent # Ask for confirmation for `rm *' or `rm path/*'
unsetopt beep # Be quiet!
unsetopt auto_cd # If a command isn't valid, but is a directory, cd to that dir

setopt prompt_subst # Expand parameters in prompt variables
setopt emacs # Use emacs keybindings in the shell

fpath=("${HOME}/.zsh/functions" "${fpath[@]}");
for f in ~/.zsh/functions/*; do autoload -Uz ${f##*/}; done

bindkey -e
autoload -U edit-command-line;
zle -N edit-command-line;
bindkey '^x^e' edit-command-line # Edit current line with C-x+C-e
bindkey "^R" history-incremental-search-backward
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

setopt PROMPT_SUBST
export PROMPT='%F{235}%B%c%b%f %(?.%F{24}❯%f.%F{198}❯%f) '

source ${HOME}/.zsh/aliases;
[[ -r ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local;
[[ -r ${HOME}/.cargo/env ]] && source ${HOME}/.cargo/env;

if uwsm check may-start -q; then
	exec uwsm start hyprland.desktop
fi

true
