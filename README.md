# ReconX
[![License](https://img.shields.io/github/license/whitehatboy005/ReconX)](LICENSE.md)

This is a powerful Bash script designed for automating the reconnaissance of websites. It helps security researchers and penetration testers quickly gather subdomains, detect live domains, and discover vulnerabilities in web applications using various tools like Assetfinder, Sublist3r, Subfinder, Amass, HTTPX, Httprobe, Katana, and GAU.

---

### **Features:**

- **Automated Directory Creation:**
  - Automatically creates a reconnaissance directory for storing the results of the analysis based on the provided company name.
  
- **Subdomain Enumeration:**
  - Uses a combination of popular tools (Assetfinder, Sublist3r, Subfinder, and Amass) to gather subdomains for the provided root domain.
  - Results are stored and combined into a single list of subdomains.

- **Live Domain Detection:**
  - Checks the live status of each subdomain using HTTPX and Httprobe.
  - Combines the results into a final list of live domains for further analysis.

- **URL Extraction and Analysis:**
  - Extracts URLs using Katana and GAU, two powerful tools for gathering URLs from web applications.
  - Filters the URLs based on specific file types (e.g., `.js` files).
  
- **Vulnerability Scanning:**
  - Automatically filters URLs for potential vulnerabilities using `gf` (Go-Fuzz) patterns, including XSS, SQL Injection (SQLI), Remote Code Execution (RCE), Open Redirects, Local File Inclusion (LFI), Server-Side Request Forgery (SSRF), and Command Injection (CMDI).
  
- **Parallel Processing:**
  - Runs multiple tools in parallel, greatly speeding up the reconnaissance process.
  
- **Comprehensive Output:**
  - Results are saved in structured text files, including:
    - `subdomains.txt`: A list of all found subdomains.
    - `livedomains.txt`: A list of live domains.
    - `all_urls.txt`: All discovered URLs.
    - `jsfiles.txt`: JavaScript file URLs.
    - Vulnerability-specific files like `xss.txt`, `sqli.txt`, `or.txt` (open redirect), etc.
  
- **Cleanup and Reporting:**
  - Cleans up empty files generated during the reconnaissance process.
  - Final report shows the success of each tool run, with live domain results and filtered URLs.

---

### **Dependencies:**

Make sure the following tools are installed on your system for the script to work correctly:

- **Assetfinder**: A tool for discovering subdomains.
- **Sublist3r**: A fast subdomain enumeration tool.
- **Subfinder**: A subdomain discovery tool.
- **Amass**: An advanced network mapping and attack surface discovery tool.
- **HTTPX**: A fast HTTP toolkit for probing live subdomains.
- **Httprobe**: A tool to check the live status of subdomains.
- **Katana**: A high-speed web crawler for web application reconnaissance.
- **GAU**: A tool to extract URLs from various sources like Wayback and common search engines.
- **gf (Go-Fuzz)**: A tool for filtering URLs based on predefined patterns (e.g., for vulnerabilities).
- **Gxss**: A tool for detecting Cross-Site Scripting (XSS) vulnerabilities.
- **kxss**: A tool for detecting XSS vulnerabilities using a Kubernetes cluster.

You can install them via package managers or from their respective repositories.


## Installation

## Clone the Repository
```bash
git clone https://github.com/whitehatboy005/ReconX
cd ReconX
```
## Setup the Dependencies
```bash
./setup.sh
```
## Run the Program
```bash
./recon.sh
```

## License
This project is licensed under the terms of the [MIT license](LICENSE.md).