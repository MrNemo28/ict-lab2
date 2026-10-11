$ErrorActionPreference = 'Stop'

# Пути к папкам лабораторной
$Base = Join-Path $HOME 'ict_lab2'
$Source = Join-Path $Base 'docs'
$Dest = Join-Path $Base 'backup'
$LogDir = Join-Path $Base 'logs'
$Log = Join-Path $LogDir 'backup.log'

# Проверяем наличие исходной папки
if (-not (Test-Path -LiteralPath $Source -PathType Container)) {
    throw "Source directory not found: $Source"
}

New-Item -ItemType Directory -Path $Dest, $LogDir -Force | Out-Null

# Создаём ZIP с датой и временем в имени
$Stamp = Get-Date -Format 'yyyyMMdd_HHmmss_fffffff'
$Archive = Join-Path $Dest "docs_$Stamp.zip"
Compress-Archive -LiteralPath $Source -DestinationPath $Archive

# Записываем результат в журнал
Add-Content -LiteralPath $Log -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') SUCCESS: $Archive"

# Удаляем свои резервные копии старше 7 дней
$Cutoff = (Get-Date).AddDays(-7)
Get-ChildItem -LiteralPath $Dest -Filter 'docs_*.zip' -File |
    Where-Object { $_.LastWriteTime -lt $Cutoff } |
    Remove-Item

Write-Output "Backup created: $Archive"
