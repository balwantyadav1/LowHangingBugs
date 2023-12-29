import re
import os
import webbrowser

# Read content from repo.txt
with open('repo.txt', 'r') as repo_file:
    repo_content = repo_file.read()

# Generate list items for HTML files in the main folder
html_files = [file for file in os.listdir('.') if file.endswith('.html') and file.startswith('vuln')]
html_list_items = ['<li><a href="{}" target="_blank">POC-{}</a></li><br>'.format(file, idx + 1) for idx, file in enumerate(html_files)]

# Combine Click Jacking POC and HTML list items
repo_content = "Click Jacking POC:- <br>" + ''.join(html_list_items) + repo_content

# Read content from index.html
with open('index.html', 'r') as index_file:
    index_content = index_file.read()

# Find the insertion point in index.html
insertion_point = re.search(r'<div class="text-justify mt-5">', index_content)

# Insert the repo_content at the identified point
if insertion_point:
    updated_index_content = index_content[:insertion_point.end()] + '\n' + repo_content + '\n' + index_content[insertion_point.end():]

    # Save the updated content back to index.html
    with open('index.html', 'w') as index_file:
        index_file.write(updated_index_content)

    print("Index.html updated successfully.")

    # Open index.html in Firefox
    webbrowser.get("firefox").open("index.html")

else:
    print("Insertion point not found in index.html. Check the HTML structure.")
