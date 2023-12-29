import requests
import json
import os

# Change this to your own path
file_path = "allsub.txt"

with open(file_path, "r") as file:
    lines = file.readlines()

for line in lines:
    url = line.strip()
    try:
        response = requests.get(url)

        # If response status is not 200 OK, skip the URL
        if response.status_code != 200:
            print(f"{url} returned status code {response.status_code}. Skipping...")
            continue

        headers = response.headers
        missing_headers = []

        for header in ["Content-Security-Policy", "X-Content-Type-Options", "X-Frame-Options", "Strict-Transport-Security", "Referrer-Policy"]:
            if header not in headers:
                missing_headers.append(header)

        if missing_headers:
            with open("missing_headers.txt", "a") as missing_file:
                missing_file.write(f"{url}\n")
                for header in missing_headers:
                    missing_file.write(f"{header}\n")
                missing_file.write("\n")

    except requests.exceptions.RequestException as e:
        print(f"An error occurred: {e}")

print("Process completed.")