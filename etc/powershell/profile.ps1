## KEYBINDINGS

# VI-mode keybindings
Set-PSReadlineOption -EditMode vi
# TODO: map ö ^
# TODO: map ö ^


# Reload the shell
Set-Alias reload Reload-Powershell

Set-Alias unzip Expand-Archive
Set-Alias whereis Get-Command

Set-Alias mv Move-Item
# Set-Alias cp Copy-Item
Set-Alias rm Remove-Item
Set-Alias ls Get-ChildItem
Set-Alias ll Get-ChildItem
Set-Alias cat Get-Content
Set-Alias pwd Get-Location
# Set-Alias touch New-Item -ItemType File
# Set-Alias mkdir New-Item -ItemType Directory
Set-Alias rmdir Remove-Item
Set-Alias grep Select-String
Set-Alias df Get-PSDrive
Set-Alias ps Get-Process

function ga { git add @args }
function gc { git commit --verbose @args }
function gd { git diff @args }
function gs { git status @args }
function gpp { git pull --prune @args }

# Fonts
oh-my-posh init pwsh --config "$HOME/.config/oh-my-posh/theme.json" | Invoke-Expression
