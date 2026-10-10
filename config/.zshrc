# ~/.zshrc

# ---------------------------------------------------------------------------
# Oh My Zsh
# ---------------------------------------------------------------------------
# Install (once):
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#
# These two plugins are NOT bundled with Oh My Zsh, so clone them (once):
#   git clone https://github.com/zsh-users/zsh-autosuggestions \
#     ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#   git clone https://github.com/zsh-users/zsh-syntax-highlighting \
#     ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#
# Same for the doas plugin (replaces the bundled sudo one):
#   git clone https://github.com/anatolykopyl/doas-zsh-plugin \
#     ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/doas

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="minimal"

plugins=(
  colored-man-pages
  copyfile
  zoxide
  git
  doas
  extract
  zsh-autosuggestions
  zsh-syntax-highlighting # keep this one last
)

source "$ZSH/oh-my-zsh.sh"
export EDITOR="nvim"
export VISUAL="nvim"


# ---------------------------------------------------------------------------
# Aliases
# (defined after sourcing OMZ so they override plugin aliases, e.g. git's `lg`)
# ---------------------------------------------------------------------------

# nix related
alias nixcleanup="nix-collect-garbage && sleep 1 && nix store optimise"

alias zshcfg="nvim ~/.zshrc"

alias homeupdate="home-manager switch --flake ~/mango-arch/#arch"
# cli
alias ls="lsd"
alias nv="nvim"
alias ff="fastfetch"
alias fff="fetch" # cool
alias amix="wiremix"
alias yy="yazi"
alias lg="lazygit"
alias d="doas"
alias p="doas pacman"

fsize() {
    du -ch -- "$@" | rg 'total$'
}

# udiskie
alias usbmount="udisksctl mount -b /dev/sdb1"
alias usbumount="udisksctl unmount -b /dev/sdb1"
alias usboff="udisksctl power-off -b /dev/sdb1"

# Added by vibez installer
export PATH="${HOME}/.local/bin:${PATH}"
