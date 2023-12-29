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


Then it run this script :- [[clickjack.sh]]
