Write-Output "Configuring Apache..."
Set-Executionpolicy unrestricted -s cu

# WAMP stack
scoop install apache mariadb php

# PHP Composer
scoop install composer

# ImageMagick
scoop install imagemagick

Write-Output "Checking Apache and PHP installs..."

# Check for apache
$apache = scoop which httpd
if ($lastexitcode -ne 0) { 'Apache isn''t installed. run ''scoop install apache'''; return }

# Check for php
$php = scoop which php
if ($lastexitcode -ne 0) { 'PHP isn''t installed. run ''scoop install php'''; return }

$conf = "$(Split-Path -Resolve $apache)/../conf/httpd.conf"

Write-Output 'Enabling PHP handler...'
$phpmodule = "$(Split-Path $php -resolve)\php7apache2_4.dll"
if (Test-Path $phpmodule) {
  $phpmodule = $phpmodule -replace '\\', '/'
  "
# php setup
LoadModule php7_module '$phpmodule'
AddHandler application/x-httpd-php .php
PHPIniDir `"$(Split-Path $phpmodule)`"
" | out-file $conf -append -encoding utf8
}
else {
  "error: couldn't find $phpmodule"; return
}

Write-Output "Setting PHP as default Directory Index..."
sed -i "s|DirectoryIndex index.html|DirectoryIndex index.php index.html|g" $conf

Write-Output "Enabling modules..."
sed -i "s|#LoadModule rewrite|LoadModule rewrite|" $conf

Write-Output "Installing Apache as a Service..."
sudo httpd -k install -n apache
sudo net start apache

Write-Output "Configuring PHP..."
Write-Output "Checking PHP install..."

$php = scoop which php
if ($lastexitcode -ne 0) { 'PHP isn''t installed. run ''scoop install php'''; return }

$ini = "$(Split-Path -Resolve $php)/cli/php.ini"

Write-Output "Configuration options..."
sed -i "s|max_execution_time = 30|max_execution_time = 60|" $ini
sed -i "s|memory_limit = 128M|memory_limit = 512M|" $ini
sed -i "s|post_max_size = 8M|post_max_size = 128M|" $ini
sed -i "s|upload_max_filesize = 2M|upload_max_filesize = 128M|" $ini

Write-Output "Enabling extensions..."
sed -i "s|;extension=curl|extension=curl|" $ini
sed -i "s|;extension=fileinfo|extension=fileinfo|" $ini
sed -i "s|;extension=gd2|extension=gd2|" $ini
sed -i "s|;extension=mbstring|extension=mbstring|" $ini
sed -i "s|;extension=exif|extension=exif|" $ini
sed -i "s|;extension=mbstring|extension=mbstring|" $ini
sed -i "s|;extension=openssl|extension=openssl|" $ini
sed -i "s|;extension=pdo_mysql|extension=pdo_mysql|" $ini

Read-Host "Press Enter to exit..."
