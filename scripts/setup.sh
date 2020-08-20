#!/bin/bash
set -Eeuo pipefail
#set -Eeuxo pipefail

# Add non-root user non-interactively if not present
# Use the --gecos option to skip the chfn interactive part.
id -u kubeactuser &>/dev/null || adduser --disabled-password --gecos "" kubeactuser

# give permission to user to access /root
#setfacl -Rm u:kubeactuser:rwx /kubeact
