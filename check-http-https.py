import requests
from tqdm import tqdm
import concurrent.futures

def check_subdomain(subdomain):
    # Try https first
    url_https = f"https://{subdomain}"
    try:
        response = requests.get(url_https, timeout=5)
        if response.status_code == 200:
            return url_https
    except requests.RequestException:
        pass

    # If https fails, try http
    url_http = f"http://{subdomain}"
    try:
        response = requests.get(url_http, timeout=5)
        if response.status_code == 200:
            return url_http
    except requests.RequestException:
        pass

    return None

def check_subdomains(subdomains):
    valid_subdomains = []
    total = len(subdomains)

    with concurrent.futures.ThreadPoolExecutor() as executor:
        futures = [executor.submit(check_subdomain, subdomain) for subdomain in subdomains]

        for future in tqdm(concurrent.futures.as_completed(futures), total=total, desc="Checking subdomains", unit="subdomain"):
            result = future.result()
            if result:
                valid_subdomains.append(result)

    return valid_subdomains

def main():
    input_file = "subdomain.txt"
    output_file = "allsub.txt"

    with open(input_file, "r") as infile:
        subdomains = [line.strip() for line in infile]

    valid_subdomains = check_subdomains(subdomains)

    with open(output_file, "w") as outfile:
        for valid_subdomain in valid_subdomains:
            outfile.write(valid_subdomain + "\n")

if __name__ == "__main__":
    main()
