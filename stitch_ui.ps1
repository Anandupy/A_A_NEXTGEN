$content = Get-Content "index.html" -Raw
$renderNew = Get-Content "renderProducts.js" -Raw
$detailNew = Get-Content "openProductDetail.js" -Raw

# Regex for renderProducts
$renderRegex = '(?s)\s+function renderProducts\(items\) \{.*?\}\.join\('''\)\;\s+\}'
$detailRegex = '(?s)\s+function openProductDetail\(id\) \{.*?productModal\.classList\.remove\(''hidden''\)\;\s+document\.body\.style\.overflow \= ''hidden''\;\s+\}'

# Use a more robust way to replace in PowerShell to avoid parser issues with complex strings
$content = [regex]::Replace($content, $renderRegex, "`n" + $renderNew)
$content = [regex]::Replace($content, $detailRegex, "`n" + $detailNew)

$content | Set-Content "index.html" -Encoding UTF8
Write-Host "Successfully updated UI logic."
