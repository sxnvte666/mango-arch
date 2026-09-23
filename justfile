ascend:
    just pacman-packages
    just aur-helper
    just aur-packages
    just nix-init
    just final

pacman-packages:
    sudo pacman -S --needed < pacmanpkg.txt
    xdg-user-dirs-update

aur-helper:
    mkdir -p ~/git
    git clone https://aur.archlinux.org/yay.git ~/git/yay
    cd ~/git/yay
    makepkg -si
    sleep 1.5

aur-packages:
    yay -S < aurpkgs.txt

nix-init:
    sudo systemctl enable --now nix-daemon.service
    mkdir -p ~/.config/nix
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
    sudo mkdir -p /nix/store
    sudo chown root:nixbld /nix/store
    sudo chmod 1775 /nix/store
    sudo systemctl restart nix-daemon.service

nix-home:
    nix run home-manager/release-26.05 -- switch --flake ~/mango-arch#arch

final:
    sudo systemctl enable ly@tty2.service
    echo "rebooting in 3s"
    echo "run 'just nix-home' after reboot"
    sleep 3
    reboot
