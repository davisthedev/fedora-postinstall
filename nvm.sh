#!/bin/bash
#
echo "Fetching the latest version of NVM..."

# Fetch the latest release from GitHub
latest_nvm_version=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep 'tag_name' | cut -d\" -f4)

if [ -z "$latest_nvm_version" ]; then
    echo "Failed to fetch the latest NVM version."
    exit 1
fi

echo "Latest version of NVM is $latest_nvm_version"
echo "Installing NVM..."

# Download and execute the install script
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$latest_nvm_version/install.sh" | bash

# Load NVM into the current session
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Verify the installation
if command -v nvm &> /dev/null
then
    echo "NVM successfully installed."
    nvm --version
else
    echo "NVM installation failed."
    exit 1
fi

nvm install --lts
nvm use --lts
