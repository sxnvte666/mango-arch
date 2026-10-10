ascend: pacman-packages user-dirs misc wallpaper aur-helper aur-packages nix-init final

pacman-packages:
    sudo pacman -Syu --needed - < pacmanpkg.txt

user-dirs:
    mkdir -p ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Videos
    mkdir -p ~/.config
    printf '%s\n' \
        'XDG_DESKTOP_DIR="$HOME/Desktop"' \
        'XDG_DOCUMENTS_DIR="$HOME/Documents"' \
        'XDG_DOWNLOAD_DIR="$HOME/Downloads"' \
        'XDG_MUSIC_DIR="$HOME/Music"' \
        'XDG_PICTURES_DIR="$HOME/Pictures"' \
        'XDG_VIDEOS_DIR="$HOME/Videos"' \
        'XDG_PUBLICSHARE_DIR="$HOME"' \
        'XDG_TEMPLATES_DIR="$HOME"' \
        > ~/.config/user-dirs.dirs

wallpaper:
    cp {{justfile_directory()}}/wallpaper.png ~/Pictures/wallpaper-dithered.png

polishing:
    sudo echo "permit persist :wheel as root" >> /etc/doas.conf
     mkdir -p ~/.config/gtk-4.0/ ~/.config/gtk-3.0/
      cp -r {{justfile_directory()}}/gtk-theme/gtk.css ~/.config/gtk-4.0/
    cp -r {{justfile_directory()}}/gtk-theme/gtk.css ~/.config/gtk-3.0/

aur-helper:
    mkdir -p ~/git
    [ -d ~/git/yay ] || git clone https://aur.archlinux.org/yay.git ~/git/yay
    cd ~/git/yay && makepkg -si

aur-packages:
    yay -S --needed $(cat aurpkgs.txt)

nix-init:
    sudo systemctl enable --now nix-daemon.service
    mkdir -p ~/.config/nix
    grep -qs experimental-features ~/.config/nix/nix.conf || echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
    sudo mkdir -p /nix/store
    sudo chown root:nixbld /nix/store
    sudo chmod 1775 /nix/store
    sudo systemctl restart nix-daemon.service

nix-home:
    nix run home-manager/release-26.05 -- switch --flake {{justfile_directory()}}#arch

final:
    sudo systemctl enable ly@tty2.service
    echo "rebooting in 3s"
    echo "run 'just nix-home' after reboot"
    sleep 3
    reboot
