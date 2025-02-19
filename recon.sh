#!/bin/bash

# Define color variables
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner for Reconx tool
clear
echo -e "${CYAN}"
echo "**************************************************"
echo "*         ____                     __  __        *"
echo "*        |  _ \ ___  ___ ___  _ __ \ \/ /        *"
echo "*        | |_) / _ \/ __/ _ \| '_ \ \  /         *"
echo "*        |  _ <  __/ (_| (_) | | | |/  \         *"
echo "*        |_| \_\___|\___\___/|_| |_/_/\_\        *"
echo "*                                                *"
echo "*                      Created by whitehatboy005 *"
echo "**************************************************"
echo -e "${YELLOW}Follow me on GitHub: ${BLUE}https://github.com/whitehatboy005${NC}"
echo ""

# Prompt for the company name and create the reconnaissance directory
read -p "Enter the company name: " cm
recon_dir=~/recon/$cm
mkdir -p "$recon_dir" || { echo -e "${RED}Failed to create directory $recon_dir${NC}"; exit 1; }
echo -e "${GREEN}Directory $recon_dir created successfully.${NC}"

# Change to the newly created directory
cd "$recon_dir" || { echo -e "${RED}Failed to change directory to $recon_dir${NC}"; exit 1; }

# Prompt for the root domain
read -p "Enter the root Domain: " dm

# Run tools in parallel
echo -e "${CYAN}Starting reconnaissance tools in parallel...${NC}"

# Assetfinder
(assetfinder --subs-only "$dm" > assetfinder.txt && \
echo -e "${GREEN}Assetfinder completed.${NC}") &

# Subfinder
(subfinder -d "$dm" --all -recursive -o subfinder.txt && \
echo -e "${GREEN}Subfinder completed.${NC}") &

# Amass
(amass enum -d "$dm" -o uncleaned_amass.txt && \
awk '{print $1}' uncleaned_amass.txt | sort -u > amass.txt && rm uncleaned_amass.txt && \
echo -e "${GREEN}Amass completed.${NC}") &

# Wait for all background jobs to complete
wait

echo -e "${CYAN}All subdomain tools completed.${NC}"

# Combine all domains into one
echo -e "${CYAN}Combining all domains into one file...${NC}"
cat assetfinder.txt subfinder.txt amass.txt | sort | uniq > subdomains.txt
rm assetfinder.txt subfinder.txt amass.txt
echo -e "${GREEN}Combined domains saved to subdomains.txt.${NC}"

# Live domain detection
echo -e "${CYAN}Finding live domains in parallel...${NC}"

# Run HTTPX and Httprobe in parallel
(cat subdomains.txt | httpx > httpx.txt && \
echo -e "${GREEN}HTTPX completed.${NC}") &

(cat subdomains.txt | httprobe > httprobe.txt && \
echo -e "${GREEN}Httprobe completed.${NC}") &

wait

echo -e "${CYAN}Combining all live domains...${NC}"
cat httpx.txt httprobe.txt | sort | uniq > livedomains.txt
rm httpx.txt httprobe.txt
echo -e "${GREEN}Combined live domains saved to livedomains.txt.${NC}"

# Katana and GAU in parallel
echo -e "${CYAN}Running Katana and GAU...${NC}"

(cat livedomains.txt | katana -d 5 -c 50 -o katana.txt && \
echo -e "${GREEN}Katana completed.${NC}") &

(cat livedomains.txt | waybackurls | tee waybackurls.txt && \
echo -e "${GREEN}Waybackurls completed.${NC}") &

(cat livedomains.txt | gau | tee gau.txt && \
echo -e "${GREEN}GAU completed.${NC}") &

wait

# Combine URLs
echo -e "${CYAN}Combining all URLs...${NC}"
cat katana.txt gau.txt waybackurls.txt| sort | uniq > all_urls.txt
echo -e "${GREEN}Combined URLs saved to all_urls.txt.${NC}"

# Filtering js file URL
echo -e "${CYAN}Filtering js file URL${NC}"
if cat all_urls.txt | grep .js$ >> jsfiles.txt; then
    echo -e "${GREEN}Filtered urls saved to jsfiles.txt${NC}"
    echo -e "${YELLOW}Total URLS:${NC} $(wc -l < jsfiles.txt)"
else
    echo -e "${RED}Failed to Filtering jsfiles files.${NC}"
    exit 1
fi
echo

# Filtering tasks in parallel
echo -e "${CYAN}Filtering URLs for XSS, SQLI, and open redirects...${NC}"

(cat all_urls.txt | grep '=' | sed 's/=.*/=/' | sort | uniq > final.txt && \
echo -e "${GREEN}Parameterized URLs filtered.${NC}") &

(cat final.txt | gf xss | Gxss | kxss | tee xss_output.txt && \
cat xss_output.txt | grep -oP '^URL: \K\S+' | sed 's/=.*/=/' | sort | uniq > xss.txt && rm xss_output.txt && \
echo -e "${GREEN}XSS URLs filtered.${NC}") &

(cat final.txt | gf sqli | tee sqli.txt && \
echo -e "${GREEN}SQLI URLs filtered.${NC}") &

(cat final.txt | gf rce | tee rce.txt && \
echo -e "${GREEN}RCE URLs filtered.${NC}") &

(cat final.txt | gf redirect | tee or.txt && \
echo -e "${GREEN}Open redirect URLs filtered.${NC}") &

(cat final.txt | gf lfi | tee lfi.txt && \
echo -e "${GREEN}LFI URLs filtered.${NC}") &

(cat final.txt | gf ssrf | tee ssrf.txt && \
echo -e "${GREEN}SSRF URLs filtered.${NC}") &

wait

# Cleanup: Remove empty files
echo -e "${CYAN}Cleaning up empty files...${NC}"
find "$recon_dir" -type f -name "*.txt" -empty -delete
echo -e "${YELLOW}Cleanup complete. Empty files removed.${NC}"
echo
# Finished
echo -e "${GREEN}Reconnaissance process completed successfully!${NC}"
echo -e "${GREEN}Results saved on: ${recon_dir}${NC}"
