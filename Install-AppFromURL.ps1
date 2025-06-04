function Install-AppFromURL {
    param (
        [string]$url,
        [string]$installPath = "C:\InstalledApps"  # Default path if none is provided
    )

    $filename = [System.IO.Path]::GetFileName($url)
    $output = Join-Path -Path $installPath -ChildPath $filename
    $log_date = Get-Date -Format "MM-dd-yyyy-HHmmss"
    $start_time = Get-Date

    Write-Output "Download URL: $url"
    Write-Output "Install path: $installPath"
    Write-Output "Output file: $output"
    Write-Output "Started at: $start_time"

    if (!(Test-Path $installPath)) {
        Write-Output "Creating directory $installPath..."
        New-Item -ItemType Directory -Path $installPath | Out-Null
    }

    Write-Output "Downloading file..."
    (New-Object System.Net.WebClient).DownloadFile($url, $output)

    Write-Output "Download complete."
    exit
}

Install-AppFromURL -url $url -installPath $installPath
