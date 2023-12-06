export ZSH=\"/root/.oh-my-zsh\"
ZSH_THEME=\"robbyrussell\"
plugins=\"(git)\"
source $ZSH/oh-my-zsh.sh
PROMPT='%{$fg_bold[yellow]%}%n %{$fg_bold[white]%}@ %{$fg_bold[cyan]%}%m %{$fg_bold[green]%}➜ %{$fg_bold[cyan]%}%c %{$reset_color%}$(git_prompt_info)'
