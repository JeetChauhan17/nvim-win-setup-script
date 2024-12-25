# Set Execution Policy
Set-ExecutionPolicy Bypass -Scope Process -Force

# Variables
$JetBrainsMonoURL = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
$JetBrainsMonoDir = "$HOME\Downloads\JetBrainsMono.zip"
$JetBrainsMonoExtractDir = "$HOME\Downloads\JetBrainsMono"
$GCCURL = "https://github.com/brechtsanders/winlibs_mingw/releases/download/latest/winlibs-x86_64-posix-seh-gcc-12.2.0-mingw64.7z"
$PNPMInstaller = "https://get.pnpm.io/install.ps1"
$YarnInstaller = "https://classic.yarnpkg.com/latest.msi"
$NodeInstallerURL = "https://nodejs.org/dist/v20.8.1/node-v20.8.1-x64.msi"  # Update to latest LTS version as needed
$NVChadRepo = "https://github.com/parv141206/nvchad-config.git"
$NVChadDir = "$HOME\AppData\Local\nvim"

# Download and Install JetBrains Mono Nerd Font
Write-Host "Downloading JetBrains Mono Nerd Font..."
Invoke-WebRequest -Uri $JetBrainsMonoURL -OutFile $JetBrainsMonoDir
Expand-Archive -Path $JetBrainsMonoDir -DestinationPath $JetBrainsMonoExtractDir
Write-Host "Installing JetBrains Mono Nerd Font..."
Copy-Item "$JetBrainsMonoExtractDir\*.ttf" -Destination "$Env:WINDIR\Fonts" -Force

# Install GCC (refactor later to use actual source.....)
Write-Host "Downloading GCC..."
Invoke-WebRequest -Uri $GCCURL -OutFile "$HOME\Downloads\gcc.7z"
Write-Host "Extracting GCC..."
Expand-Archive -Path "$HOME\Downloads\gcc.7z" -DestinationPath "$HOME\gcc" -Force
[System.Environment]::SetEnvironmentVariable("PATH", "$HOME\gcc\bin;$Env:PATH", [System.EnvironmentVariableTarget]::Machine)

# Install Node.js
Write-Host "Downloading Node.js..."
Invoke-WebRequest -Uri $NodeInstallerURL -OutFile "$HOME\Downloads\node.msi"
Write-Host "Installing Node.js..."
Start-Process "$HOME\Downloads\node.msi" -ArgumentList "/quiet" -Wait
[System.Environment]::SetEnvironmentVariable("PATH", "$Env:ProgramFiles\nodejs;$Env:PATH", [System.EnvironmentVariableTarget]::Machine)

# Install PNPM
Write-Host "Installing PNPM..."
Invoke-Expression "& { $(Invoke-WebRequest -Uri $PNPMInstaller -UseBasicParsing).Content }"

# Install Yarn
Write-Host "Downloading Yarn..."
Invoke-WebRequest -Uri $YarnInstaller -OutFile "$HOME\Downloads\yarn.msi"
Write-Host "Installing Yarn..."
Start-Process "$HOME\Downloads\yarn.msi" -ArgumentList "/quiet" -Wait
[System.Environment]::SetEnvironmentVariable("PATH", "$Env:APPDATA\Yarn\bin;$Env:PATH", [System.EnvironmentVariableTarget]::Machine)

# Clone NVChad Repo (change w/mine later)
Write-Host "Setting up NVChad config..."
if (-Not (Test-Path -Path $NVChadDir)) {
    New-Item -ItemType Directory -Path $NVChadDir
}
git clone $NVChadRepo $NVChadDir

Write-Host "Setup Complete!"
