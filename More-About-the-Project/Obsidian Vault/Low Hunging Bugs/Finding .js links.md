This commad `cat subdomain.txt | httpx -silent | subjs | anew | tee js.txt`  
will check the subdomain.txt and find the .js url link and it will save in `js.txt` file format.

Let Understand in more detail:

1. Reads a list of subdomains from "subdomain.txt."
2. Probes the subdomains for HTTP/HTTPS responses.
3. Finds JavaScript endpoints on those subdomains.
4. Removes duplicate JavaScript endpoints.
5. Appends the unique JavaScript endpoints to "js.txt."
6. Displays the results on the terminal.

Then it run this script :- [[js-cve-finder.py]]