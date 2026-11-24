# ZSH Config
HISTSIZE=100000
SAVEHIST=50000

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git)
plugins=(
  git
  colored-man-pages
  colorize
  docker
  kubectl
  kubectx
  aws
  terraform
  opentofu
  mvn
  gradle
  jenv
  mise
  sops
)

eval "$($HOME/.local/bin/mise activate zsh)" # added by https://mise.run/zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Starship.rs
eval "$(starship init zsh)"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

## Zinit Setting

# Recover OMZ history configuration for history management (like file `.oh-my-zsh/lib/history.zsh`)
# without ice to avoid lose history in case perform commands befure prompt is loaded
zinit snippet OMZL::history.zsh

# Recover OMZ git plugin functionality
zinit ice wait"0" lucid
zinit snippet OMZL::git.zsh

# Recover OMZ key bindings. Load before history-substring-search
zinit ice wait"0" lucid
zinit snippet OMZL::key-bindings.zsh

# Recover OMZ aliases like `l`, `..`, `la`
zinit ice wait"0" lucid
zinit snippet OMZL::directories.zsh

# Load fzf plugin from OMZ to show deferred completion loading (Ctrl+R, Ctrl+T)
zinit ice wait"0" lucid
zinit snippet OMZP::fzf

zinit ice blockf
zinit light zsh-users/zsh-completions

# from $plugins of oh-my-zsh
for plugin in $plugins; do
  # zinit ice wait"0" lucid
  zinit ice wait"1" lucid
  zinit snippet "OMZP::$plugin"
done

# Interactive menu for fzf when press TAB (must be before highlighting)
# Load it after zsh-completions
zinit ice wait"0" lucid
zinit light Aloxaf/fzf-tab

# zcompinit and zicdreplay for completion system initialization using autoload compinit; compinit
zinit ice wait"0" lucid atinit"zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait"0" lucid atload"!_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions
