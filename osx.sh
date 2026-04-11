# 参考: https://macos-defaults.com
echo "Finder: 显示所有文件扩展名"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "默认显示隐藏文件"
defaults write com.apple.Finder AppleShowAllFiles -bool false

echo "默认展开保存对话框"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# echo "在 Finder 中显示 ~/Library 文件夹"
chflags nohidden ~/Library

# echo "全局禁用恢复功能"
# defaults write NSGlobalDomainNSQuitAlwaysKeepWindows -bool false

echo "启用所有控件的完整键盘访问（例如在模态对话框中启用 Tab）"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "在非 Apple LCD 屏幕上启用亚像素字体渲染"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# echo "启用 2D Dock 样式"
# defaults write com.apple.dock no-glass -bool true

echo "自动隐藏和显示 Dock"
defaults write com.apple.dock autohide -bool true

#echo "使已隐藏应用的 Dock 图标变为半透明"
#defaults write com.apple.dock showhidden -bool true

#echo "在 Dock 中启用 iTunes 歌曲通知"
#defaults write com.apple.dock itunes-notifications -bool true

# 禁用菜单栏透明度
#defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# 显示剩余电池时间；隐藏百分比
# defaults write com.apple.menuextra.battery ShowPercent -string "NO"
# defaults write com.apple.menuextra.battery ShowTime -string "YES"

# echo "始终显示滚动条"
# defaults write NSGlobalDomain AppleShowScrollBars -string "Auto"

#echo "允许通过 ⌘ + Q 退出 Finder；同时会隐藏桌面图标"
#defaults write com.apple.finder QuitMenuItem -bool true

echo "禁用 Finder 中的窗口动画和获取信息动画"
defaults write com.apple.finder DisableAllAnimations -bool true

echo "在 Finder 中显示路径栏"
defaults write com.apple.finder ShowPathbar -bool true

echo "在 Finder 中显示状态栏"
defaults write com.apple.finder ShowStatusBar -bool true

# echo "默认展开打印面板"
# defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

#echo "禁用「你确定要打开此应用吗？」对话框"
#defaults write com.apple.LaunchServices LSQuarantine -bool false

#echo "禁用截图阴影"
#defaults write com.apple.screencapture disable-shadow -bool true

# echo "启用 Dock 栈网格视图的高亮悬停效果"
# defaults write com.apple.dock mouse-over-hilte-stack -bool true

# echo "为所有 Dock 项目启用弹簧加载"
# defaults write enable-spring-load-actions-on-all-items -bool true

# echo "在 Dock 中显示已打开应用的指示灯"
# defaults write com.apple.dock show-process-indicators -bool true

echo "禁用从 Dock 打开应用时的动画"
defaults write com.apple.dock launchanim -bool false

#echo "在标准文本视图中使用脱字符 notation 显示 ASCII 控制字符"
# 尝试例如 `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
#defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

#echo "禁用按键按住功能，改用按键重复"
#defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

#echo "设置极快的键盘重复速率"
defaults write NSGlobalDomain KeyRepeat -int 2

#echo "缩短按键重复的初始延迟"
defaults write NSGlobalDomain InitialKeyRepeat -int 15

#echo "禁用自动纠错"
#defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "禁用窗口打开和关闭动画"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# echo "禁用磁盘镜像验证"
# defaults write com.apple.frameworks.diskimages skip-verify -bool true
# defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
# defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# echo "挂载卷时自动打开新的 Finder 窗口"
# defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
# defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
# defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# echo "在 Finder 窗口标题中显示完整 POSIX 路径"
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# 加快 Cocoa 应用的窗口调整速度
# defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# echo "避免在网络卷上创建 .DS_Store 文件"
# defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# echo "禁用更改文件扩展名时的警告"
# defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# echo "在桌面图标下方显示项目信息"
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# echo "启用桌面图标的自动对齐网格"
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# echo "禁用清空废纸篓前的警告"
# defaults write com.apple.finder WarnOnEmptyTrash -bool false

# 默认安全清空废纸篓
# defaults write com.apple.finder EmptyTrashSecurely -bool true

#echo "睡眠或屏幕保护程序启动后立即要求输入密码"
#defaults write com.apple.screensaver askForPassword -int 1
#defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "启用触控板轻触点击"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

#echo "将触控板右下角映射为右键点击"
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# echo "禁用 Safari 的历史记录和常用站点的缩略图缓存"
# defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

echo "启用 Safari 的调试菜单"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# echo "将 Safari 的搜索栏默认改为「包含」而非「开头是」"
# defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# 从 Safari 书签栏移除无用图标
# defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# echo "在 Web 视图中添加显示 Web 检查器的上下文菜单项"
# defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

#echo "在 Terminal.app 中仅使用 UTF-8"
#defaults write com.apple.terminal StringEncodings -array 4

# echo "禁用 iTunes 中的 Ping 侧边栏"
# defaults write com.apple.iTunes disablePingSidebar -bool true

# echo "禁用 iTunes 中所有其他 Ping 功能"
# defaults write com.apple.iTunes disablePing -bool true

# echo "使 ⌘ + F 在 iTunes 中聚焦搜索输入框"
# defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add "Target Search Field" "@F"

# 禁用 Mail.app 中的发送和回复动画
# defaults write com.apple.Mail DisableReplyAnimations -bool true
# defaults write com.apple.Mail DisableSendAnimations -bool true

# 全局禁用恢复功能
# defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# echo "禁用「重新登录时重新打开窗口」选项"
# 此方法有效，但复选框仍会显示为选中状态
# defaults write com.apple.loginwindow TALLogoutSavesState -bool false
# defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false

# echo "启用 Dashboard 开发者模式（允许将小组件保留在桌面上）"
# defaults write com.apple.dashboard devmode -bool true

#echo "重置 Launchpad"
#[ -e ~/Library/Application\ Support/Dock/*.db ] && rm ~/Library/Application\ Support/Dock/*.db

# echo "禁用本地 Time Machine 备份"
# hash tmutil &> /dev/null && sudo tmutil disablelocal

#echo "移除 Finder 中 Dropbox 的绿色勾号图标"
#file=/Applications/Dropbox.app/Contents/Resources/check.icns
#[ -e "$file" ] && mv -f "$file" "$file.bak"
#unset file

# 修复 QuickLook 中古老的 UTF-8 bug (http://mths.be/bbo)
# 已注释掉，已知在 Adobe Illustrator CS5 中保存文件时会导致问题
#echo "0x08000100:0" > ~/.CFUserTextEncoding

echo "重启受影响的应用"
for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done
