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

Then it run this script :- [[spfcheck.sh]]