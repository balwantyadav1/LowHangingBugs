
# How-it-works

**check-http-https.py**
This Python script (check-http-https.py) is designed to check the validity of subdomains listed in a text file (`subdomain.txt`). It attempts to access each subdomain using both HTTPS and HTTP protocols and checks if the HTTP response status code is 200 (OK). If a subdomain is reachable and returns a status code of 200, it is considered valid, and the script records the valid subdomains in an output file (`allsub.txt`).

Let Understand in more detail:

1. **Importing Libraries:**
   - `requests`: Used for making HTTP requests.
   - `tqdm`: Provides a progress bar for the concurrent execution of tasks.
   - `concurrent.futures`: Part of the `concurrent.futures` module for concurrent execution of tasks.

2. **`check_subdomain` Function:**
   - Takes a subdomain as an argument.
   - Tries to access the subdomain using HTTPS. If successful (status code 200), it returns the URL.
   - If HTTPS fails, it tries HTTP. If successful, it returns the URL.
   - If both attempts fail, it returns `None`.

3. **`check_subdomains` Function:**
   - Takes a list of subdomains as an argument.
   - Utilizes a thread pool for concurrent execution of the `check_subdomain` function on each subdomain.
   - Uses the `tqdm` library to display a progress bar for the subdomain checking process.
   - Collects and returns a list of valid subdomains.

4. **`main` Function:**
   - Defines input and output file names (`input_file` and `output_file`).
   - Reads subdomains from the input file (`subdomain.txt`).
   - Calls the `check_subdomains` function to obtain a list of valid subdomains.
   - Writes the valid subdomains to an output file (`allsub.txt`).

5. **`if __name__ == "__main__":`**
   - Ensures that the `main` function is executed only if the script is run directly (not imported as a module).

#
**login_page_finder.py**
This script used for checking the existence of login or registration pages, as well as admin panels, on a list of URLs. It utilizes a wordlist (`login_wordlist.txt`) containing potential paths or keywords for login, registration, and admin pages.

Let Understand in more detail:

1. **Command-Line Arguments:**
   - The script uses the `argparse` module to parse command-line arguments. It expects the user to provide the output file (`-f` or `--file`) where the found URLs will be saved.


2. **`read_wordlist` Function:**
   - Reads the wordlist from the file `login_wordlist.txt` and returns a list of words. These words are likely paths or keywords associated with login, registration, or admin pages.

3. **Wordlist Initialization:**
   - Reads the wordlist using the `read_wordlist` function.

4. **`search_login` Coroutine Function:**
   - Takes an `aiohttp` session, a URL, and a word from the wordlist as arguments.
   - Sends an asynchronous GET request to the URL with the provided word.
   - Handles different HTTP response status codes and prints corresponding colored messages.
   - If the status code is 200, it indicates a successful discovery of a login, registration, or admin page, and the URL is added to the list of found URLs.

5. **`main` Coroutine Function:**
   - Reads previously found URLs from the specified output file.
   - Iterates over each domain in the `allsub.txt` file, which presumably contains a list of subdomains or URLs.
   - For each domain, it initializes an asynchronous session using `aiohttp` and then asynchronously executes the `search_login` coroutine for each word in the wordlist.
   - Writes the found URLs to the output file.
   - Prints the total number of found URLs.

6. **Script Execution:**
   - Checks if the script is being run directly (`if __name__ == "__main__":`) and runs the `asyncio.run(main())` function to start the asynchronous event loop.

#
**clickjack.sh**

This Bash  tool designed for testing whether a list of URLs is vulnerable to clickjacking. 
If the URLs are Vulnerable the it create a POC using the help for `poc.html` 

Let Understand in more detail:


1. **`single_url` Function:**
   - Clears the terminal and displays a banner.
   - Reads a list of URLs from the file `login-auto.txt`.
   - Iterates through each URL and sends a `HEAD` request using `curl`.
   - Checks the response headers for the presence of security-related headers (`X-Frame-Options` or `Content-Security-Policy`).
   - If these headers are not present, it considers the URL vulnerable to clickjacking.
   - Creates a proof-of-concept (POC) HTML file (`vuln$counter.html`) and opens it in the default web browser.
   - The counter variable increments for each vulnerable URL.
   - If the POC file already exists, it is removed before creating a new one.

2. **`ctrl_c` Function:**
   - Interrupt handler function (triggered by Ctrl+C).
   - Cleans up temporary files (`temp.txt`).
   - Displays a message and exits the script.

3. **`menu` Function:**
   - Clears the terminal and displays a menu.
   - Asks the user if they are ready to start the attack.
   - Options:
     - Option 1: Calls the `single_url` function to start the attack.
     - Option 2: Exits the script.

4. **Trap Signal (`ctrl_c`):**
   - Sets up a trap to catch the interrupt signal (Ctrl+C) and invoke the `ctrl_c` function.

5. **Script Execution:**
   - Calls the `menu` function to start the interactive menu.

#
**spfcheck.sh**
This Bash tool designed to check if domains have proper SPF (Sender Policy Framework) and DMARC (Domain-based Message Authentication, Reporting, and Conformance) records. The script can be used to identify vulnerable domains that lack these email authentication mechanisms.

Let Understand in more detail:

1. **Output File:**
   - The variable `output_file` is set to "SPFvulnerable.txt," which will store the list of vulnerable domains.

2. **Functions:**
   - `usage`: Displays examples of script usage and exits.
   - `style`: Defines colored output styles for use in printing the results.
   - `print`: Prints the vulnerability status of a domain based on SPF and DMARC records.
   - `log`: Logs additional details if the verbose option is enabled.
   - `version`: Displays the tool version and exits.
   - `spfdmarc_checker`: Checks SPF and DMARC records for a domain and prints the vulnerability status.
   - `target`: Processes a list of domains from a file, checking each one for SPF and DMARC records.
   - `single_domain`: Checks SPF and DMARC records for a single domain.

3. **Command-Line Arguments:**
   - The script accepts the following command-line options:
     - `-h` or `--help`: Displays usage information.
     - `--verbose`: Enables verbose output.
     - `-v` or `--version`: Displays the tool version.
     - `-t` or `--target`: Specifies a file containing a list of domains to check.

4. **Processing Command-Line Arguments:**
   - The script uses a `while` loop to process command-line arguments.
   - It sets variables and calls functions based on the provided options.

5. **Main Execution:**
   - If a target file (`-t` option) is provided, the script reads domains from the file and checks each one.
   - If a single domain is provided without the `-t` option, the script checks that domain.
   - For each domain, it uses `dig` to query SPF and DMARC records and determines their existence.
   - The results (vulnerable or not) are printed, and details are logged if the verbose option is enabled.
   - The list of vulnerable domains is appended to the output file.

6. **Exit:**
   - The script exits with a status of 0, indicating successful execution.

#
**HeaderChecker.py**
This Python script is designed to check a list of URLs (read from the "allsub.txt" file) for the presence of specific security headers `Content-Security-Policy, X-Content-Type-Options, X-Frame-Options, Strict-Transport-Security, Referrer-Policy `  in their HTTP responses. The script focuses on checking whether certain security headers are present in the HTTP responses and logs the URLs that are missing these headers.

Let Understand in more detail:

1. **File Path Setup:**
   - The variable `file_path` is set to "allsub.txt," representing the file from which the script reads a list of URLs.

2. **Read URLs from File:**
   - The script opens the specified file, reads its content line by line, and stores each line (URL) in the `lines` list.

3. **Iterate Over URLs:**
   - For each URL in the `lines` list, the script performs the following steps:

4. **HTTP Request:**
   - It sends an HTTP GET request to the current URL using the `requests.get` method.

5. **Check HTTP Response Status:**
   - If the HTTP response status code is not 200 (OK), it prints a message and skips to the next URL.

6. **Check for Security Headers:**
   - For a successful response (status code 200), the script checks if certain security headers are present in the response.
   - The headers being checked are: "Content-Security-Policy," "X-Content-Type-Options," "X-Frame-Options," "Strict-Transport-Security," and "Referrer-Policy."

7. **Logging Missing Headers:**
   - If any of the specified headers are missing, the script appends the URL and the missing headers to a file called "missing_headers.txt."
   - Each line in "missing_headers.txt" contains a URL followed by the list of missing headers for that URL.

8. **Error Handling:**
   - If an error occurs during the HTTP request (handled by `requests.exceptions.RequestException`), it prints an error message.

9. **Process Completion Message:**
   - After processing all URLs, it prints "Process completed."

#
**Finding .js links**
This commad `cat subdomain.txt | httpx -silent | subjs | anew | tee js.txt`  
will check the subdomain.txt and find the .js url link and it will save in `js.txt` file format.

Let Understand in more detail:

1. Reads a list of subdomains from "subdomain.txt."
2. Probes the subdomains for HTTP/HTTPS responses.
3. Finds JavaScript endpoints on those subdomains.
4. Removes duplicate JavaScript endpoints.
5. Appends the unique JavaScript endpoints to "js.txt."
6. Displays the results on the terminal.

#
**js-cve-finder.py**
This Python script scans a list of JavaScript library URLs `js.txt` to check for version information and associated Common Vulnerabilities and Exposures (CVEs). It utilizes the National Vulnerability Database (NVD) API to find CVEs based on the identified library versions. The results are then organized and saved in individual reports.

Let Understand in more detail:

1. **`scan_libraries` Function:**
   - Iterates through a list of JavaScript URLs.
   - Downloads the content of each JavaScript file.
   - Extracts version information from the JavaScript content.
   - Searches for CVEs associated with the identified version using the NVD API.
   - Generates a report for each library.

2. **`download_js` Function:**
   - Uses the `requests` library to download the content of a JavaScript file.
   - Converts the content to lowercase for case-insensitive matching.
   - Handles exceptions and returns `None` in case of errors.

3. **`extract_version_info_from_js` Function:**
   - Employs regular expressions to extract version information from the JavaScript content.
   - Returns the identified version or `None` if not found.

4. **`find_cves` Function:**
   - Constructs the NVD API endpoint based on the provided API key and version information.
   - Uses the NVD API to search for CVEs related to the identified version.
   - Returns a list of CVEs or `None` if none are found.

5. **`generate_report` Function:**
   - Creates a directory for reports and ensures it exists.
   - Generates a report file for each JavaScript file.
   - Writes JavaScript file URL, version information, and associated CVEs to the report file in JSON format.

6. **Execution Section:**
   - Reads a list of JavaScript URLs from "js.txt."
   - Specifies the NVD API key for CVE lookup.
   - Initiates the scan using the `scan_libraries` function.
