#!/bin/bash

# echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
# echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
# echo 'eval "$(pyenv init -)"' >> ~/.zshrc
# 
# pip install --no-cache-dir -r requirements.txt
# python3 -m pip install --user ansible
# pip install jupyterlab iterm2

## Define the paths to the scripts
# SCRIPTS=("bc-tabs" "safe-ops" "update-kubeconfigs")

## Define the directory containing these scripts
SCRIPT_DIR="$(pwd)"

## Update .zshrc to include the SCRIPT_DIR in PATH
if ! grep -q "$SCRIPT_DIR" ~/.zshrc; then
    echo "Adding $SCRIPT_DIR to PATH in ~/.zshrc..."
    echo "export PATH=\"\$PATH:$SCRIPT_DIR\"" >> ~/.zshrc
else
    echo "$SCRIPT_DIR is already in PATH in ~/.zshrc."
fi

## Add aliases for Terraform commands
echo "Adding Terraform aliases to ~/.zshrc..."

## Aliases to add
ALIASES=(
    "alias ti='terraform init -backend-config envs/\${ENVIRONMENT}/\${AWS_REGION}/backend.tfvars -reconfigure'"
    "alias tp='terraform plan -var-file envs/\${ENVIRONMENT}/\${AWS_REGION}/variables.tfvars'"
    "alias ta='terraform apply -var-file envs/\${ENVIRONMENT}/\${AWS_REGION}/variables.tfvars'"
)

## Add each alias if it doesn't already exist in .zshrc
for alias_cmd in "${ALIASES[@]}"; do
    alias_name=$(echo "$alias_cmd" | awk '{print $2}') ## Extracts 'ti', 'tp', 'ta'
    if ! grep -q "$alias_name=" ~/.zshrc; then
        echo "$alias_cmd" >> ~/.zshrc
        echo "Added alias: $alias_name"
    else
        echo "Alias $alias_name already exists in ~/.zshrc."
    fi
done

## Source the updated .zshrc file
echo "Sourcing ~/.zshrc to apply changes..."
source ~/.zshrc

echo "Setup complete. The specified scripts are now in your PATH, and Terraform aliases are configured."
