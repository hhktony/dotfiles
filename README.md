# Tony Xu's Dotfiles

个人开发环境配置，覆盖 Shell、编辑器、终端、窗口管理器等工具。

## 包含配置

| 类别 | 配置文件 |
|------|---------|
| **Shell** | `zshrc`, `bashrc`, `shrc` |
| **终端** | `tmux.conf`, `config/wezterm/`, `config/ghostty/`, `config/alacritty/` |
| **Git** | `gitconfig`, `gitmessage`, `config/gitui/` |
| **Prompt** | `config/starship.toml` |
| **macOS 自动化** | `hammerspoon/`, `osx.sh` |
| **CLI 工具** | `ripgreprc`, `ctags`, `inputrc`, `tigrc`, `sqliterc`, `curlrc`, `ackrc`, `agignore` |
| **Linux 窗口管理** | `i3/`, `config/openbox/`, `conkyrc`, `Xresources`, `Xmodmap`, `xinitrc` |
| **媒体** | `mpdconf`, `ncmpcpp/`, `config/mpv/`, `mplayer/`, `apvlvrc` |
| **其他** | `bin/` (自定义脚本), `config/bottom/`, `config/htop/`, `config/yazi/` |

## 安装

```bash
git clone https://github.com/hhktony/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

### 选项

| 参数 | 说明 |
|------|------|
| `-n, --dry-run` | 预览变更，不实际执行 |
| `-v, --verbose` | 显示详细输出 |
| `-r, --rollback` | 回滚到备份文件 |
| `-h, --help` | 显示帮助信息 |

安装脚本会：
1. 创建必要目录（`~/workspace`, `~/software` 等）
2. 将配置文件符号链接到 `$HOME`
3. 将 `config/` 下的配置链接到 `~/.config/`
4. 安装 oh-my-zsh 及插件（F-Sy-H、zsh-autosuggestions、alias-tips）

### 工具安装

```bash
./install-pkgs.sh    # 跨平台 CLI 工具和 GUI 应用
./osx.sh     # macOS 系统偏好设置
```

## 依赖

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) - ZSH 框架
- [Starship](https://starship.rs/) - 跨平台 Prompt
- [Homebrew](https://brew.sh/) - macOS 包管理

## License

MIT
