# ReconX
[![License](https://img.shields.io/github/license/whitehatboy005/Virtual-Assistant-Jarvis)](LICENSE.md)

This is a powerful Bash script designed for automating the reconnaissance of websites. It helps security researchers and penetration testers quickly gather subdomains, detect live domains, and discover vulnerabilities in web applications using various tools like Assetfinder, Sublist3r, Subfinder, Amass, HTTPX, Httprobe, Katana, and GAU.

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

---

| Features                          | About                                                                       |
|-----------------------------------|-----------------------------------------------------------------------------|
| `Automated Directory Creation`    | Automatically creates a reconnaissance directory for storing the results based on the provided company name. |
| `Subdomain Enumeration`           | Uses tools like Assetfinder, Sublist3r, Subfinder, and Amass to gather subdomains for a root domain and combines the results into one list. |
| `Live Domain Detection`           | Checks the live status of subdomains using HTTPX and Httprobe. Combines the results into a final list of live domains. |
| `URL Extraction and Analysis`     | Extracts URLs using Katana and GAU, filters them based on specific file types such as `.js`. |
| `Vulnerability Scanning`          | Filters URLs for vulnerabilities using gf patterns including XSS, SQL Injection (SQLI), Remote Code Execution (RCE), Open Redirects, Local File Inclusion (LFI), SSRF, and Command Injection (CMDI). |
| `Parallel Processing`             | Runs multiple tools in parallel to speed up the reconnaissance process. |
| `Comprehensive Output`            | Saves results in structured text files such as subdomains.txt, livedomains.txt, all_urls.txt, jsfiles.txt, and vulnerability-specific files (e.g., xss.txt, sqli.txt). |
| `Cleanup and Reporting`           | Cleans up empty files and generates a final report showing the success of each tool run, live domain results, and filtered URLs. |


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
