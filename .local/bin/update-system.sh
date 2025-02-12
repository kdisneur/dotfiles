sudo apt update
sudo apt list --upgradable
sudp apt upgrade
sudo apt install -y curl git make wget gpg gnupg2 jq tmux software-properties-common tree alacritty gcc zlib1g-dev libssl-dev libreadline-dev
command -v pyenv &>/dev/null || curl -fsSL https://pyenv.run | bash
pyenv install --skip-existing

