#! /usr/bin/env bash

set -e

echo ""
echo ">>> [1/15] Updating package lists..."
sudo apt update

echo ""
echo ">>> [2/15] Installing Homebrew prerequisites..."
sudo apt-get install -y build-essential procps curl file git

echo ""
echo ">>> [3/15] Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> "$HOME/.bashrc"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >> "$HOME/.bashrc"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
sudo apt-get install -y build-essential bubblewrap

echo ""
echo ">>> [4/15] Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

echo ""
echo ">>> [5/15] Installing cargo-binstall..."
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

echo ""
echo ">>> [6/15] Installing Zellij (terminal multiplexer)..."
cargo binstall --no-confirm zellij

echo ""
echo ">>> [7/15] Installing gitui (git TUI)..."
brew install gitui

echo ""
echo ">>> [8/15] Installing oxker (Docker TUI)..."
cargo install oxker

echo ""
echo ">>> [9/15] Installing btop (system monitor)..."
brew install btop

echo ""
echo ">>> [10/15] Installing bat (better cat)..."
# Note: on Debian/Ubuntu the binary is installed as 'batcat', not 'bat'
sudo apt install -y bat

echo ""
echo ">>> [11/15] Installing Zsh..."
sudo apt install -y zsh

echo ""
echo ">>> [12/15] Installing Oh My Zsh..."
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo ""
echo ">>> [13/15] Installing Zsh plugins and theme..."
echo "    - zsh-autosuggestions"
[ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] || git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "    - zsh-syntax-highlighting"
[ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "    - powerlevel10k theme"
[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo ""
echo ">>> [14/15] Installing jump (directory navigation)..."
brew install jump

echo ""
echo ">>> [15/15] Installing Neovim + NvChad..."
brew install neovim
# Clone the starter config; launch nvim manually afterward to complete setup
[ -d ~/.config/nvim ] || git clone https://github.com/NvChad/starter ~/.config/nvim


# Done!
echo ""
echo "============================================"
echo "  Setup complete! A few manual steps remain:"
echo "============================================"
echo ""
echo "  1. Edit ~/.zshrc and update these lines:"
echo "       ZSH_THEME=\"powerlevel10k/powerlevel10k\""
echo "       plugins=(git zsh-autosuggestions zsh-syntax-highlighting)"
echo ""
echo "  2. Enable jump by adding this line to ~/.zshrc:"
echo '       eval "$(jump shell)"'
echo ""
echo "  3. On Debian/Ubuntu, bat is installed as 'batcat'."
echo "     Add this alias to ~/.zshrc if you want to use 'bat':"
echo "       alias bat='batcat'"
echo ""
echo "  4. Launch nvim to complete NvChad setup:"
echo "       nvim"
echo ""
echo "  5. Run 'p10k configure' to set up the Powerlevel10k theme."
echo ""
echo "============================================"
echo ""