#!/bin/bash

# Remove the existing index.html file
rm -f index.html

# Copy the contents of backupindex.html to index.html and rename backupindex.html
cp backupindex.html index.html

# Extract site links from vulnn files and save in repo.txt
for file in vulnn*.html; do
  grep -oP '(?<=href=")[^"]+' "$file" >> repo.txt
done

# Add SPF Vulnerable link and paste text
echo "SPF Vulnerable: -" >> repo.txt
awk '{print $0 "<br>"}' SPFvulnerable.txt >> repo.txt

# Add Security Headers link and paste text
echo "Security Headers are not set: -" >> repo.txt
awk '{print $0 "<br>"}' missing_headers.txt >> repo.txt

# Add Java Version link and paste text
echo "Java Version: -" >> repo.txt
awk '{print $0 "<br>"}' java_libraries.txt >> repo.txt

# Change directory to 'reports'
cd reports || exit

# Loop through .json files and append content to repo.txt
for file in *.json; do
  echo "$file: -" >> ../repo.txt
  awk '{print $0 "<br>"}' "$file" >> ../repo.txt
  echo "<br><br>" >> ../repo.txt
done

# Go back to the original directory
cd ..

# Print a message indicating successful completion
echo "Task completed successfully. Check 'repo.txt' for the consolidated report."
