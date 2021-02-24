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
sudo pacman -S htop python termite exa ranger vifm x11vnc openssh fzf
sudo systemctl enable --now sshd

echo "Install fonts"
sudo pacman -S adobe-source-code-pro-fonts cantarell-fonts fontconfig gnu-free-fonts noto-fonts noto-fonts-emoji ttf-font-awesome ttf-dejavu ttf-fira-code ttf-droid ttf-inconsolata ttf-liberation ttf-linux-libertine ttf-roboto ttf-ubuntu-font-family ttf-hack

echo "Installing Xorg and DE"
sudo pacman -S xorg xf86-video-intel mesa xfce4 xfce4-goodies xmonad xmonad-contrib xmobar lightdm lightdm-gtk-greeter arandr picom stalonetray trayer
xmonad --recompile
sudo systemctl enable lightdm

echo "Installing Themes"
sudo pacman -S arc-gtk-theme faenza-icon-theme

echo "Installing apps"
sudo pacman -S parcellite nm-connection-editor network-manager-applet firefox tor-browser transmission-gtk transmission-cli element-desktop speedcrunch pcmanfm lxappearance-gtk3 thunderbird filezilla flameshot gajim gparted playonlinux dunst

echo "Installing multimedia"
sudo pacman -S vlc deadbeef mpv ristretto tumbler xarchiver zathura evince

echo "Installing wine"
sudo pacman -S wine winetricks wine-gecko wine-mono 

echo "Installing editor"
sudo pacman -S libreoffice leafpad nextcloud-client texlive-most

echo "Installing Audio"
sudo pacman -S pulseaudio-alsa pulseaudio-bluetooth pulsemixer pulsemixer bluez bluez-utils blueman playerctl
sudo systemctl enable --now bluetooth.service

echo "Installing yay"
sudo pacman -S --needed base-devel
cd ~ && mkdir aur && cd aur
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

echo "AUR Fonts"
yay -S ttf-ms-fonts ttf-font-awesome-4

echo "AUR Apps"
yay -S teams rocketchat-client-bin clockify-desktop skypeforlinux-stable-bin tidal-hifi-git birdtray bitwarden-bin bitwarden-cli lf

echo "Dev Apps"
sudo pacman -S arduino arduino-builder arduino-cli arduino-ctags dbeaver

echo "Work Apps"
gpg --keyserver keys.gnupg.net --recv-keys 702353E0F7E48EDB
yay -S inkscape pinta remmina truestudio jlink-software-and-documentation

echo "Compiled Apps"
cd ~ && mkdir app && cd app
ln -sf ~/git/dotfiles/home/app/* ~/app/
cd dmenu-4.9 && sudo make install
cd ~/app/dwm-6.2/ && sudo make install
