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
