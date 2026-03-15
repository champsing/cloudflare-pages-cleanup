# 設定編碼
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 這行通常能解決 90% 的互動模式報錯
$env:WRANGLER_SEND_METRICS = "false"
$env:CI = "true"

$projects = @("mercuryland", "time-synced-lyrics", "tsl-editor")

Write-Host "======================================================" -ForegroundColor Cyan
Write-Host "          Cloudflare Pages Deployment Status" -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Cyan

foreach ($p in $projects) {
    Write-Host "`n[ Checking Project: $p ]" -ForegroundColor Yellow
    Write-Host "------------------------------------------------------"
    
    # 移除所有管線過濾，直接執行
    # 這樣 Wrangler 就不會噴 non-interactive 錯誤
    npx wrangler pages deployment list --project-name "$p"
}

Write-Host "`n======================================================" -ForegroundColor Cyan

Write-Host "Complete! Press y to exit..."
while ($true) {
    if ($Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character -eq 'y') {
        break
    }
}
