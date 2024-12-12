#!/bin/bash

# Define color variables
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Update system and install dependencies
echo -e "${CYAN}Updating system and installing dependencies...${NC}"

# Update package lists
sudo apt update -y

# Install essential packages
sudo apt install -y git curl wget python3 python3-pip gcc make build-essential \
                    jq parallel python3-venv python3-dev python3-setuptools

# Install Go (if not already installed)
echo -e "${CYAN}Checking if Go is installed...${NC}"

if ! command -v go &> /dev/null
then
    echo -e "${CYAN}Go is not installed. Installing Go...${NC}"
    wget https://golang.org/dl/go1.19.5.linux-amd64.tar.gz
    sudo tar -C /usr/local -xvzf go1.19.5.linux-amd64.tar.gz
    echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
    source ~/.bashrc
    echo -e "${GREEN}Go installed successfully!${NC}"
else
    echo -e "${GREEN}Go is already installed.${NC}"
fi

# Install tools using 'go install' and move binaries to /bin
echo -e "${CYAN}Installing tools using 'go install'...${NC}"

# Install Assetfinder
echo -e "${CYAN}Installing Assetfinder...${NC}"
go install github.com/tomnomnom/assetfinder@latest
sudo cp $HOME/go/bin/assetfinder /usr/local/bin/
echo -e "${GREEN}Assetfinder installed.${NC}"

# Install Subfinder
echo -e "${CYAN}Installing Subfinder...${NC}"
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
sudo cp $HOME/go/bin/subfinder /usr/local/bin/
echo -e "${GREEN}Subfinder installed.${NC}"

# Install Amass
echo -e "${CYAN}Installing Amass...${NC}"
go install github.com/OWASP/Amass/v3/cmd/amass@latest
sudo cp $HOME/go/bin/amass /usr/local/bin/
echo -e "${GREEN}Amass installed.${NC}"

# Install gf (GitHub tool for finding XSS, SQLI, etc.)
echo -e "${CYAN}Installing gf...${NC}"
go install github.com/tomnomnom/gf@latest
sudo cp $HOME/go/bin/gf /usr/local/bin/
echo -e "${GREEN}gf installed.${NC}"

# Install gf patterns
echo -e "${CYAN}Installing gf patterns...${NC}"

# Clone the gf patterns repository
git clone https://github.com/1ndianl33t/Gf-Patterns.git $HOME/Gf-Patterns

# Move gf patterns to the correct directory
mkdir -p $HOME/.gf
cd ~/Gf-Patterns/
cp *.json ~/.gf/
# Clean up the cloned repository
rm -rf $HOME/Gf-Patterns

echo -e "${GREEN}gf patterns installed successfully!${NC}"

# Install Httpx-Toolkit
echo -e "${CYAN}Installing Httpx...${NC}"
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
sudo cp $HOME/go/bin/httpx /usr/local/bin/
echo -e "${GREEN}Httpx installed.${NC}"

# Install Httprobe
echo -e "${CYAN}Installing Httprobe...${NC}"
go install github.com/tomnomnom/httprobe@latest
sudo cp $HOME/go/bin/httprobe /usr/local/bin/
echo -e "${GREEN}Httprobe installed.${NC}"

# Install Gxss
echo -e "${CYAN}Installing Gxss...${NC}"
go install github.com/KathanP19/Gxss@latest
sudo cp $HOME/go/bin/Gxss /usr/local/bin/
echo -e "${GREEN}Gxss installed.${NC}"

# Install Kxss
echo -e "${CYAN}Installing Kxss...${NC}"
go install github.com/Emoe/kxss@latest
sudo cp $HOME/go/bin/Kxss /usr/local/bin/
echo -e "${GREEN}Kxss installed.${NC}"

# Install Katana
echo -e "${CYAN}Installing Katana...${NC}"
go install github.com/projectdiscovery/katana/cmd/katana@latest
sudo cp $HOME/go/bin/katana /usr/local/bin/
echo -e "${GREEN}Katana installed.${NC}"

# Install GAU (GitHub Archive Utility)
echo -e "${CYAN}Installing GAU...${NC}"
go install github.com/lc/gau/v2/cmd/gau@latest
sudo cp $HOME/go/bin/gau /usr/local/bin/
echo -e "${GREEN}GAU installed.${NC}"


echo -e "${CYAN}All necessary dependencies and tools have been installed.${NC}"

# Finished
echo -e "${GREEN}Setup completed successfully! Now you can run your recon script.${NC}"
