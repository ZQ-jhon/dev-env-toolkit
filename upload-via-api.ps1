# upload-via-api.ps1
# Upload all repo files to GitHub via REST API (bypasses git network issues)

$ErrorActionPreference = "Stop"
$repo = "ZQ-jhon/dev-env-toolkit"
$branch = "master"
$token = $(gh auth token 2>&1)
$headers = @{ "Authorization" = "token $token"; "Accept" = "application/vnd.github.v3+json" }
$ProgressPreference = 'SilentlyContinue'

$files = @(
    ".env.example"
    ".env.template"
    ".gitignore"
    "install.ps1"
    "install.sh"
    "npm-global.txt"
    "openclaw-config-template.json"
    "qclaw-skill-installer.ps1"
    "requirements.txt"
    "setup-guide.md"
    "skills-manifest.json"
    "README.md"
)

Write-Host "Uploading $($files.Count) files to $repo (branch: $branch)..." -ForegroundColor Cyan

foreach ($file in $files) {
    $localPath = "C:\Users\Administrator\dev-env-toolkit\$file"
    Write-Host "  Uploading: $file ... " -NoNewline

    $contentBytes  = [System.IO.File]::ReadAllBytes($localPath)
    $contentB64   = [Convert]::ToBase64String($contentBytes)
    # GitHub API needs base64 without line breaks
    $contentB64   = $contentB64 -replace "`r`n","" -replace "`n",""

    $body = @{
        message = "Add $file"
        content = $contentB64
        branch  = $branch
    } | ConvertTo-Json -Compress

    try {
        $url = "https://api.github.com/repos/$repo/contents/$file"
        # Check if file already exists (need sha to update)
        $existing = Invoke-RestMethod -Uri $url -Headers $headers -Method Get -ErrorAction SilentlyContinue
        if ($existing.sha) {
            $bodyObj = $body | ConvertFrom-Json
            $bodyObj | Add-Member -NotePropertyName "sha" -NotePropertyValue $existing.sha -Force
            $body = $bodyObj | ConvertTo-Json -Compress
        }

        $resp = Invoke-RestMethod -Uri $url -Headers $headers -Method Put -Body $body -ContentType "application/json" -TimeoutSec 30
        Write-Host "OK" -ForegroundColor Green
    } catch {
        $errMsg = $_.Exception.Message
        if ($_.Exception.Response) {
            $reader = [System.IO.StreamReader]::new($_.Exception.Response.GetResponseStream())
            $errMsg = $reader.ReadToEnd()
            $reader.Close()
        }
        Write-Host "FAILED: $errMsg" -ForegroundColor Red
    }
}

Write-Host "`nDone! Check: https://github.com/$repo/tree/$branch" -ForegroundColor Green
