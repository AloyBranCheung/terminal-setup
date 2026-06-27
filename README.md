# dev-env-setup

A one-shot terminal setup script for Linux (Debian/Ubuntu) that installs a full developer environment.

## Install

Download the script, then run it as a file. (Running a file keeps the script
off of `bash`'s stdin, so installers like Homebrew/Oh-My-Zsh can't accidentally
consume it and skip the rest of the steps.)

```bash
curl -fsSL https://raw.githubusercontent.com/AloyBranCheung/terminal-setup/main/terminal-setup.sh -o terminal-setup.sh
bash terminal-setup.sh
```

> The piped one-liner (`curl ... | bash`) also works now that the script guards
> its stdin, but downloading first is the more robust approach.

## What gets installed

| Tool | Description |
|------|-------------|
| [Homebrew](https://brew.sh) | Package manager for Linux |
| [Rust](https://www.rust-lang.org) + cargo-binstall | Systems language toolchain + fast binary installer |
| [Zellij](https://zellij.dev) | Terminal multiplexer |
| [gitui](https://github.com/extrawurst/gitui) | Git TUI |
| [oxker](https://github.com/mrjackwills/oxker) | Docker TUI |
| [btop](https://github.com/aristocratos/btop) | System resource monitor |
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting |
| [Zsh](https://www.zsh.org) + [Oh My Zsh](https://ohmyz.sh) | Shell + framework |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-style command suggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Real-time syntax highlighting in Zsh |
| [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | Zsh prompt theme |
| [jump](https://github.com/gsamokovarov/jump) | Fuzzy directory navigation |
| [Neovim](https://neovim.io) + [NvChad](https://nvchad.com) | Editor + config framework |

## Post-install steps

After the script finishes, a few manual steps are required:

**1. Update `~/.zshrc`:**
```zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

**2. Enable `jump` in `~/.zshrc`:**
```zsh
eval "$(jump shell)"
```

**3. Add a `bat` alias (Debian/Ubuntu installs it as `batcat`):**
```zsh
alias bat='batcat'
```

**4. Complete NvChad setup:**
```bash
nvim
```

**5. Configure the Powerlevel10k theme:**
```bash
p10k configure
```
