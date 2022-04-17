# Basic reference for powershell script
# Running:
#     powershell.exe -ExecutionPolicy bypass -file "C:\path\to\powershell-reference-script.ps1"

# Emulate 'set -e'
Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

# Set working directory to directory of this script
Set-Location -Path "$PSScriptRoot"
