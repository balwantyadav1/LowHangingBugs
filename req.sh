#!/bin/bash

# Check if Go is installed
if command -v go &> /dev/null; then
  echo "Go is already installed."
else
  # Install Go
  sudo apt-get update
  sudo apt-get install -y golang-go
fi

# Install anew using go install
go install -v github.com/tomnomnom/anew@latest

# Get the current username
username=$(whoami)

# Change directory to the Go bin directory
cd /home/"$username"/go/bin || exit

# Copy all files and folders to /usr/local/bin
sudo cp * /usr/local/bin

# Print a message indicating successful completion
echo "Task completed successfully."

