#!/bin/bash 
cd /home/davis

git config --global user.name "Davis Sanders"
git config --global user.email "davisrsanders@gmail.com"

ssh-keygen -t ed25519 -C "davisrsanders@gmail.com"

./nvm.sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/catppuccin/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes 

git clone https://github.com/davisthedev/.dotfiles.git

rm .zshrc

cd .dotfiles/
stow zsh
stow kitty
stow lvim

cd /home/davis

font_dir="${HOME}/.local/share/fonts/JetBrainsMono"

mkdir -p "${font_dir}"

font_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"

curl -fLo "${font_dir}/JetBrainsMono.zip" --create-dirs "${font_url}" && \
unzip -o "${font_dir}/JetBrainsMono.zip" -d "${font_dir}" && \
rm "${font_dir}/JetBrainsMono.zip"

fc-cache -fv

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

curl -sS https://starship.rs/install.sh | sh

LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update
