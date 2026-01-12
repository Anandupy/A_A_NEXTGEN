import re

with open('index.html', 'r', encoding='utf-8') as f:
    content = f.read()

with open('renderProducts.js', 'r', encoding='utf-8') as f:
    render_new = f.read()

with open('openProductDetail.js', 'r', encoding='utf-8') as f:
    detail_new = f.read()

# Regex for renderProducts
render_regex = r'(?s)\s+function renderProducts\(items\) \{.*?\}\.join\(\'\'\)\;\s+\}'
# Regex for openProductDetail
detail_regex = r'(?s)\s+function openProductDetail\(id\) \{.*?productModal\.classList\.remove\(\'hidden\'\)\;\s+document\.body\.style\.overflow \= \'hidden\'\;\s+\}'

content = re.sub(render_regex, '\n' + render_new, content)
content = re.sub(detail_regex, '\n' + detail_new, content)

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("Successfully updated UI logic.")
