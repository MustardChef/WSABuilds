import os
from bs4 import BeautifulSoup

# Load the README.md file
with open('README.md', 'r') as file:
    readme_content = file.read()

# Parse the content with BeautifulSoup
soup = BeautifulSoup(readme_content, 'html.parser')

# Define the headers to locate the table
headers = ['Download Variant', 'Image', 'Image']

# Initialize target_table
target_table = None

# Find the table with the specified headers
for table in soup.find_all('table'):
    ths = table.find_all('th')
    if len(ths) == 3:
        th_texts = [th.get_text(strip=True) if th.img is None else (th.img['alt'] if 'alt' in th.img.attrs else '') for th in ths]
        if all(header_text == header for header_text, header in zip(th_texts, headers)):
            target_table = table
            break

# Check if a matching table was found
if target_table is None:
    print("No table with the specified headers found in README.md")
    exit(1)

# Get the GitHub ENV variables
github_env_var = os.getenv('TEXT_TO_REPLACE_WITH')
row_num = int(os.getenv('ROW_NUM'))
col_num = int(os.getenv('COLUMN_NUM'))

# Replace the cell content with the GitHub ENV variable
target_table.find_all('tr')[row_num].find_all('td')[col_num].string = github_env_var

# Write the updated content back to the README.md file
with open('README.md', 'w') as file:
    file.write(str(soup))