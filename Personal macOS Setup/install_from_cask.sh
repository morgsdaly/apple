#!/bin/bash
# https://brew.sh

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile &&
eval "$(/opt/homebrew/bin/brew shellenv)"

brew=/opt/homebrew/bin/brew
echo $brew

# Install non-mas apps from Cask: https://formulae.brew.sh/cask/

$brew install --cask microsoft-edge
$brew install dockutil
$brew install --cask rectangle
$brew install mas
$brew install --cask powershell
$brew install --cask angry-ip-scanner
$brew install --cask sublime-text
$brew install --cask textmate
$brew install --cask mds
$brew install --cask omnidisksweeper
$brew install --cask shuttle
$brew install --cask textexpander
$brew install --cask cyberduck
$brew install --cask airtool
$brew install --cask wifi-explorer-pro
$brew install --cask microsoft-auto-update
$brew install --cask microsoft-office

# Beta Versions of Apps
$brew tap homebrew/cask-versions		# https://github.com/Homebrew/homebrew-cask-versions
$brew install --cask vmware-fusion-tech-preview
$brew install --cask 1password-beta


# NOT M1 YET 	$BREW install --cask miro 
# NOT M1 YET 	$BREW brew install --cask github