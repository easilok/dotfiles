#!/bin/bash

if [ ! -f /usr/bin/git ]; then 
	echo "Installing git"
	pacman -S git
fi

echo "Install my dotfiles"
cd ~ && mkdir git 
cd git && git clone https://github.com/easilok/dotfiles.git && cd git/dotfiles/home/scripts && ./linking_dotfiles

echo "Install shell"
sudo pacman -S zsh zsh-autosuggestions zsh-syntax-highlighting && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Install vim"
sudo pacman -S vim && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall

echo "Install some shell comands"
sudo pacman -S htop python termite exa ranger vifm x11vnc openssh \
    fzf isync pass wget mpd ncmpcpp mlocate pam-u2f nfs-utils sshpass \
    upower
sudo systemctl enable --now sshd

echo "Install fonts"
sudo pacman -S adobe-source-code-pro-fonts cantarell-fonts fontconfig \
    gnu-free-fonts noto-fonts noto-fonts-emoji ttf-font-awesome \
    ttf-dejavu ttf-fira-code ttf-droid ttf-inconsolata ttf-liberation \
    ttf-linux-libertine ttf-roboto ttf-ubuntu-font-family ttf-hack

echo "Installing Xorg and DE"
sudo pacman -S xorg xf86-video-intel mesa xmonad xmonad-contrib xmobar lightdm \
    lightdm-gtk-greeter arandr picom stalonetray trayer xorg-xinput libinput \
    xf86-input-libinput
xmonad --recompile
sudo systemctl enable lightdm

echo "Installing Themes"
sudo pacman -S arc-gtk-theme faenza-icon-theme

echo "Installing some dependencies"
sudo pacman -S python-tldextract polkit 

echo "Installing apps"
sudo pacman -S xfce4-clipman-plugin nm-connection-editor network-manager-applet \
    firefox transmission-gtk transmission-cli element-desktop \
    speedcrunch pcmanfm lxappearance-gtk3 thunderbird filezilla flameshot \
    gajim gparted playonlinux dunst emacs rofi pamixer xwallpaper dbeaver gnumeric \
    subversion

echo "Installing multimedia"
sudo pacman -S vlc deadbeef mpv ristretto tumbler xarchiver zathura evince

echo "Installing wine"
sudo pacman -S wine winetricks wine-gecko wine-mono 

echo "Installing editor"
sudo pacman -S libreoffice leafpad nextcloud-client texlive-most

echo "Installing Audio"
sudo pacman -S alsa-utils pulseaudio-alsa pulseaudio-bluetooth pulsemixer pulsemixer bluez bluez-utils blueman playerctl
sudo systemctl enable --now bluetooth.service

echo "Installing yay"
sudo pacman -S --needed base-devel
cd ~ && mkdir aur && cd aur
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

echo "AUR Fonts and themes"
yay -S ttf-ms-fonts ttf-font-awesome-4 delft-icon-theme

echo "AUR Apps"
yay -S teams clockify-desktop skypeforlinux-stable-bin tidal-hifi-git birdtray bitwarden-bin lf

echo "Dev Apps"
sudo pacman -S arduino arduino-builder arduino-cli arduino-ctags dbeaver

echo "Work Apps"
gpg --keyserver keys.gnupg.net --recv-keys 702353E0F7E48EDB
yay -S inkscape pinta remmina truestudio jlink-software-and-documentation

echo "Compiled Apps"
cd ~/git/dwm && sudo make install
cd ~/git/dwmblocks && sudo make install
cd ~/git/dmenu && sudo make install
