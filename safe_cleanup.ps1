# ==========================================
# Script: safe_cleanup.ps1
# Muc dich: Loc WARNING va xoa tep .tmp
# ==========================================

# 1. Khoanh vung thu muc du an
$projectPath = "C:\LanSmart"
$logsPath = Join-Path $projectPath "logs"
$logFile = Join-Path $logsPath "system.log"
$reportFile = Join-Path $logsPath "issues.txt"

# Kiem tra duong dan truoc khi thao tac
if (-not (Test-Path $projectPath -PathType Container)) {
    Write-Host "Loi: Khong tim thay thu muc du an!" -ForegroundColor Red
    exit
}

if (-not (Test-Path $logFile -PathType Leaf)) {
    Write-Host "Loi: Khong tim thay system.log!" -ForegroundColor Red
    exit
}

# 2. Di chuyen den thu muc logs
Set-Location -Path $logsPath
Write-Host "Dang loc dong WARNING..." -ForegroundColor Yellow

# 3. Loc WARNING va ghi vao issues.txt
Select-String -Path ".\system.log" -Pattern "WARNING" |
    ForEach-Object { $_.Line } |
    Set-Content -Path ".\issues.txt"

# 4. Chi xoa tep .tmp truc tiep trong thu muc du an
Write-Host "Dang don dep tep .tmp..." -ForegroundColor Yellow

Get-ChildItem -Path $projectPath -Filter "*.tmp" -File |
    Remove-Item -Force

Write-Host "Da hoan tat xu ly log!" -ForegroundColor Green