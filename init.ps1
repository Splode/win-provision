Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
set-executionpolicy unrestricted -s cu

# Utils
scoop install 7zip curl sudo git openssh coreutils ripgrep sed less bat wget jq

# Add extras
scoop bucket add extras

# Applications
scoop install cmder firefox heidisql vscode vcredist2019

# Languages
scoop install nodejs-lts python rust

# Keep shell open
Read-Host "Press Enter to exit..."
