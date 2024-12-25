## BEFORE EXECUTING :
Inside powershell (as Admin), RUN : 
```sh
iwr -useb https://christitus.com/win | iex
```

# Script to get : 
1. Brave
2. CMake *
3. Git
4. GitHub CLI
5. NVIM
6. NodeJS
7. Node Version Manager
8. Oh My Posh *
9. Postman *
10. Python Version Manager
11. Python3
12. VS Code
13. Obsidian
14. Windows Terminal
15. Bat
16. FastFetch
17. Fzf

## Setup font : 
Link : https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
How to install : extract zip, select all files with (.ttf) extention, right-click and `Install`

## After that : 
- run powershell as admin and then run : 
```ps1
Set-ExecutionPolicy Bypass -Scope Process -Force
```

## THEN RUN
```
.\setup.ps1
```
 ### This will install the following : 
 1. PNPM
 2. Yarn
 3. python
 4. nvim-config (neovim not included, install seperately)

## Setup windows terminal : 
Inside settings > goto Default > Appearence > font > SET TO JETBRAINS MONO > SAVE

## POST Install : 
1. open terminal, run nvim, let the packages install, run :MasonInstallALl
2. run Lazy Sync
3. run TSInstall <NAME_OF_LANG> for whatever language you want support for. 
