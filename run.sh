#!/bin/bash

# Delete existing files and folders
rm -f subdomain.txt allsub.txt login-auto.txt vuln*.html SPFvulnerable.txt missing_headers.txt java_libraries.txt
rm -rf reports

# Display Terms and Conditions
echo -e "\033[1mTerms and Conditions:\033[0m"
echo "Usage is solely for educational and ethical purposes. Any unauthorized or malicious actions are strictly prohibited. The tool developers are not responsible for any misuse or damage caused by the tool."

# Ask for user agreement
read -p "Do you agree to the Terms and Conditions? (yes/no): " agreement

if [ "$agreement" != "yes" ]; then
    echo "Exiting..."
    exit 1
fi

# Setup message
echo -e "\033[1mSetting up your unlimited hacking toolkit...\033[0m"
for i in 3 2 1; do
    echo -e "\033[1m$i\033[0m"
    sleep 1
done

# Run commands
chmod +x *
./req.sh
pip3 install -r requirements.txt
sudo cp subjs /usr/local/bin
pip install --upgrade fake_useragent

# ASCII art
clear
cat << "EOF"

██╗      ██████╗ ██╗    ██╗      ██╗  ██╗ █████╗ ███╗   ██╗ ██████╗ ██╗███╗   ██╗ ██████╗       ██████╗ ██╗   ██╗ ██████╗ ███████╗
██║     ██╔═══██╗██║    ██║      ██║  ██║██╔══██╗████╗  ██║██╔════╝ ██║████╗  ██║██╔════╝       ██╔══██╗██║   ██║██╔════╝ ██╔════╝
██║     ██║   ██║██║ █╗ ██║█████╗███████║███████║██╔██╗ ██║██║  ███╗██║██╔██╗ ██║██║  ███╗█████╗██████╔╝██║   ██║██║  ███╗███████╗
██║     ██║   ██║██║███╗██║╚════╝██╔══██║██╔══██║██║╚██╗██║██║   ██║██║██║╚██╗██║██║   ██║╚════╝██╔══██╗██║   ██║██║   ██║╚════██║
███████╗╚██████╔╝╚███╔███╔╝      ██║  ██║██║  ██║██║ ╚████║╚██████╔╝██║██║ ╚████║╚██████╔╝      ██████╔╝╚██████╔╝╚██████╔╝███████║
╚══════╝ ╚═════╝  ╚══╝╚══╝       ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝       ╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝


EOF
echo -e "\nLet's hack Ethically\n"

# User input for Domain name
read -p "Enter the domain name: " domain_name

# Tool options
echo -e "\033[1mWhich tools do you want to use?\033[0m"
echo -e "1) \033[91msubfinder (recommended)\033[0m"
echo "2) Amass"
echo "3) Findomain"
echo "4) Install Reconnaissance Tool"
read -p "Enter your choice (1-4): " tool_choice

# Tool execution
case $tool_choice in
    1)
        subfinder -d "$domain_name" -t 100 -v -o subdomain.txt
        ;;
    2)
        amass enum -src -ip -brute -d "$domain_name" -o subdomain.txt
        ;;
    3)
        findomain -t "$domain_name" | tee subdomain.txt
        ;;
    4)
        xdg-open https://github.com/balwantyadav1/BugHunterKit.git
        # Install Reconnaissance Tool (add installation command here)
        ;;
    *)
        echo "Invalid choice. Exiting..."
        exit 1
        ;;
esac

# Additional checks
echo -e "\033[1mChecking the Domain name...\033[0m"
python3 check-http-https.py

echo -e "\033[1mChecking Admin/Login & Registrations Panels...\033[0m"
for i in 3 2 1; do
    echo -e "\033[1m$i\033[0m"
    sleep 1
done
python3 login_page_finder.py -f login-auto.txt

echo -e "\033[1mChecking for Clickjacking Attack...\033[0m"
for i in 3 2 1; do
    echo -e "\033[1m$i\033[0m"
    sleep 1
done
./clickjack.sh

echo -e "\033[1mChecking the SPF bug...\033[0m"
for i in 3 2 1; do
    echo -e "\033[1m$i\033[0m"
    sleep 1
done
./spfcheck.sh -t subdomain.txt --verbose

echo -e "\033[1mCheck security Headers are Set or Not...\033[0m"
for i in 3 2 1; do
    echo -e "\033[1m$i\033[0m"
    sleep 1
done
python3 HeadersChecker.py

echo -e "\033[1mFinding .js URL links...\033[0m"
cat subdomain.txt | httpx -silent | subjs | anew | tee js.txt

echo -e "\033[1mScan all the Java Libraries, check Versions and Finding the CVE and Exploit...\033[0m"
python3 js-cve-finder.py
./copyandpst.sh

# Generating
echo -e "\033[1mGenerating...\033[0m"
for i in 3 2 1; do
    echo -e "\033[1m$i\033[0m"
    sleep 1
done
python3 update_index.py

# Report message
echo -e "\033[1mThe Domain $domain_name you are testing may be vulnerable. To see the report, open index.html file in a browser.\033[0m"
