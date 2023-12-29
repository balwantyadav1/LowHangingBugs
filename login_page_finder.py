#!/usr/bin/python
import argparse
import asyncio
import aiohttp

from fake_useragent import UserAgent

ua = UserAgent()

parse = argparse.ArgumentParser()
parse.add_argument('-f', '--file', required=True, type=str, help='Output file to save the found URLs')
args = parse.parse_args()

class ColorPalette:
    G = '\033[92m'  # green
    Y = '\033[93m'  # yellow
    B = '\033[94m'  # blue
    R = '\033[91m'  # red
    W = '\033[0m'   # white
    M = '\u001b[35m'  # magenta

def read_wordlist():
    with open("login_wordlist.txt") as text_file:
        wordlist = text_file.read()
        splitted_wordlist = wordlist.strip().split("\n")
    return splitted_wordlist

word_list = read_wordlist()

async def search_login(session, url, word):
    try:
        async with session.get(url + word, allow_redirects=False, verify_ssl=False, timeout=20) as response:
            status_code = response.status
            if status_code == 200:
                print(f"{url}{word} {ColorPalette.M} --> {ColorPalette.G} Boom! {ColorPalette.W}")
                return url + word
            elif status_code == 403:
                print(f"{url}{word} {ColorPalette.M} --> {ColorPalette.B} Forbidden! {ColorPalette.W}")
            elif status_code == 404:
                print(f"{url}{word} {ColorPalette.M} --> {ColorPalette.R} Not Found! {ColorPalette.W}")
            elif status_code in [302, 301]:
                print(f"{url}{word} {ColorPalette.M} --> {ColorPalette.Y} Redirecting! {ColorPalette.W}")
            else:
                print(f"{ColorPalette.B} {url}{word} {ColorPalette.W}  --> {status_code} ")
    except aiohttp.ClientError as e:
        print(f"Error connecting to {url}{word}: {e}")
    except asyncio.TimeoutError:
        print(f"Timeout connecting to {url}{word}")

async def main():
    founded_url = []

    try:
        with open(args.file, "r") as file:
            founded_url.extend(file.read().splitlines())
    except FileNotFoundError:
        pass

    with open(args.file, "a") as output_file:
        with open("allsub.txt", "r") as domain_file:
            for domain in domain_file:
                url = domain.strip()

                if not url.endswith('/'):
                    url += '/'

                if not url.startswith("http://") and not url.startswith("https://"):
                    print(f"Given URL {url} is not valid.")
                    continue

                headers = {
                    'User-Agent': ua.random
                }

                tasks = []
                async with aiohttp.ClientSession(headers=headers) as session:
                    for word in word_list:
                        tasks.append(search_login(session=session, word=word, url=url))

                    results = await asyncio.gather(*tasks)

                    for result in results:
                        if result:
                            founded_url.append(result)
                            print(result, file=output_file)

    print(f"Found {len(founded_url)}")

if __name__ == "__main__":
    asyncio.run(main())
