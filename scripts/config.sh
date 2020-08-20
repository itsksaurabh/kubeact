#!/bin/bash
set -Eeuo pipefail
#set -Eeuxo pipefail
# Create a registration token using Github REST API v3
temp=$(curl -XPOST \
-H "Accept: application/vnd.github.v3+json" \
-H "authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
"https://api.github.com/repos/${GITHUB_USERNAME}/${GITHUB_REPO_NAME}/actions/runners/registration-token")
# Extract token value from the response
REGISTRATION_TOKEN=$(echo $temp | grep "token" | awk '{print $3}'| awk -F , '{print $1 }' | sed 's/"//g')
# Create a folder
mkdir actions-runner && cd actions-runner
# Download the latest runner package
curl -O -L https://github.com/actions/runner/releases/download/v2.263.0/actions-runner-linux-x64-2.263.0.tar.gz
# Extract the installer
tar xzf ./actions-runner-linux-x64-2.263.0.tar.gz
# Configure the runner
./config.sh --url https://github.com/${GITHUB_USERNAME}/${GITHUB_REPO_NAME} --token $REGISTRATION_TOKEN <<< $'\n\n' 