Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
set-executionpolicy unrestricted -s cu

# Utils
scoop install 7zip curl sudo git openssh coreutils ripgrep sed less imagemagick

# Add extras
scoop bucket add extras

# Applications
scoop install cmder vscode vcredist2019

# Languages
scoop install nodejs-lts

# WAMP stack
scoop install apache mariadb php

# PHP Composer
scoop install composer

# Keep shell open
Read-Host "Press Enter to exit..."
