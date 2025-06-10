function Install-AppFromURL {
    param (
        # These parameters will be populated by Datto RMM's environment variables
        # No need to explicitly declare them in the function param block if they're coming from env vars
    )

    # Access the input variables as environment variables
    $url = $env:url_input 
    $installPath = $env:installPath_input
    
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

# Call the function (the parameters will be populated by Datto RMM as environment variables)
Install-AppFromURL
