#! /usr/bin/env bash

apt-get update
apt-get upgrade
apt-get install -y zsh curl wget git vim neovim python zip make cmake build-essential "linux-headers-$(uname -r)"

chsh --shell /bin/zsh vagrant

cd /home/vagrant
USER_SCRIPT=$(cat <<'END'
echo "Install ohmyzsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="avit"/g' /home/vagrant/.zshrc

touch .aliases

echo "Setup vimrc for neovim"
wget -q -P .config/nvim/ https://gist.githubusercontent.com/artronics/171b1d00342687814a3effd31138b790/raw/0fb3f34049d1cef97ef101cefdaaf271acb98393/vimrc
mv .config/nvim/vimrc .config/nvim/init.vim

echo "Install vim plugins"
curl -sfLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +PlugInstall +qall > /dev/null

echo "Done!"
END
)
/bin/su -s /bin/bash -c "$USER_SCRIPT" - vagrant