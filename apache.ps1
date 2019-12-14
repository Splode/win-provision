Write-Output "Configuring Apache..."
Set-Executionpolicy unrestricted -s cu

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

# Keep shell open
Read-Host "Press Enter to exit..."
