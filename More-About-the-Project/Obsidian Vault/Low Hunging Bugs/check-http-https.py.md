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

Then it run this script :- [[login_page_finder.py]]

see in Graph :- [[Graph LHB-Tools.canvas|Graph LHB-Tools]]