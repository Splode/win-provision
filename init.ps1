Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
Set-ExecutionPolicy unrestricted -s cu

# Utils
scoop install 7zip curl sudo git openssh coreutils ripgrep sed less bat wget jq ffmpeg micro vagrant

# Add extras
scoop bucket add extras

# Applications
scoop install cmder firefox heidisql vscode vcredist2019 portable-virtualbox

# Languages
scoop install nodejs-lts php

# PHP Composer
scoop install composer

# Keep shell open
Read-Host "Press Enter to exit..."
