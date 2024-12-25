# Variables
$JetBrainsMonoURL = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
$JetBrainsMonoDir = "$HOME\Downloads\JetBrainsMono.zip"
$JetBrainsMonoExtractDir = "$HOME\Downloads\JetBrainsMono"
$GCCURL = "https://github.com/brechtsanders/winlibs_mingw/releases/download/15.0.0-snapshot20240616posix-12.0.0-ucrt-r1/winlibs-i686-posix-dwarf-gcc-15.0.0-snapshot20240616-mingw-w64ucrt-12.0.0-r1.zip"
$PythonInstallerURL = "https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"

$PNPMInstaller = "https://get.pnpm.io/install.ps1"
$YarnInstaller = "https://classic.yarnpkg.com/latest.msi"

$NVChadRepo = "https://github.com/parv141206/nvchad-config.git"
$NVChadDir = "$HOME\AppData\Local\nvim"




try {
    # Download and Install JetBrains Mono Nerd Font
    Write-Host "Downloading JetBrains Mono Nerd Font..."
    Invoke-WebRequest -Uri $JetBrainsMonoURL -OutFile $JetBrainsMonoDir
    Expand-Archive -Path $JetBrainsMonoDir -DestinationPath $JetBrainsMonoExtractDir
    Write-Host "Installing JetBrains Mono Nerd Font..."
    Copy-Item "$JetBrainsMonoExtractDir\*.ttf" -Destination "$Env:WINDIR\Fonts" -Force
} catch {
    Write-Host "Failed to install JetBrains Mono Nerd Font: $_"
}

try {
    # Install GCC
    Write-Host "Downloading GCC..."
    Invoke-WebRequest -Uri $GCCURL -OutFile "$HOME\Downloads\gcc.zip"
    Write-Host "Extracting GCC..."
    Expand-Archive -Path "$HOME\Downloads\gcc.zip" -DestinationPath "$HOME\gcc" -Force
} catch {
    Write-Host "Failed to install GCC: $_"
}

try {
    # Install Python
    Write-Host "Downloading Python..."
    Invoke-WebRequest -Uri $PythonInstallerURL -OutFile "$HOME\Downloads\python.exe"
    Write-Host "Installing Python..."
    Start-Process "$HOME\Downloads\python.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
} catch {
    Write-Host "Failed to install Python: $_"
}



try {
    # Install PNPM
    Write-Host "Installing PNPM..."
    Invoke-Expression "& { $(Invoke-WebRequest -Uri $PNPMInstaller -UseBasicParsing).Content }"
} catch {
    Write-Host "Failed to install PNPM: $_"
}

try {
    # Install Yarn
    Write-Host "Downloading Yarn..."
    Invoke-WebRequest -Uri $YarnInstaller -OutFile "$HOME\Downloads\yarn.msi"
    Write-Host "Installing Yarn..."
    Start-Process "$HOME\Downloads\yarn.msi" -ArgumentList "/quiet" -Wait
} catch {
    Write-Host "Failed to install Yarn: $_"
}

try {
    # Clone NVChad Repo
    Write-Host "Setting up NVChad config..."
    if (-Not (Test-Path -Path $NVChadDir)) {
        New-Item -ItemType Directory -Path $NVChadDir -Force
    }
    git clone $NVChadRepo $NVChadDir
} catch {
    Write-Host "Failed to clone NVChad config: $_"
}

try {
    # Update PATH Environment Variables
    $newPath = "$HOME\gcc\bin;$Env:ProgramFiles\nodejs;$Env:APPDATA\Yarn\bin;$Env:PATH"
    [System.Environment]::SetEnvironmentVariable("PATH", $newPath, [System.EnvironmentVariableTarget]::Machine)
} catch {
    Write-Host "Failed to update environment variables: $_"
}

Write-Host "Setup Complete!"
