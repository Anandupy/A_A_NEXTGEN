$content = Get-Content "index.html" -Raw
$startTag = '<script id="products-json" type="application/json">'
$endTag = '</script>'
$startIndex = $content.IndexOf($startTag) + $startTag.Length
$endIndex = $content.IndexOf($endTag, $startIndex)
$jsonStr = $content.Substring($startIndex, $endIndex - $startIndex).Trim()

if ($jsonStr.EndsWith(',')) {
    $jsonStr = $jsonStr.Substring(0, $jsonStr.Length - 1)
}

$products = $jsonStr | ConvertFrom-Json

$categoryImages = @{
    'students' = @('1588872657578-7efd1f1555ed', '1517336714731-489689fd1ca8', '1496181133206-80ce9b88a853', '1541807084-5c52b6b3adef', '1611186871348-b1ec696e5238', '1589561084283-930aa7b1ce50')
    'gaming' = @('1603302576837-37561b2e2302', '1544197150-b99a580bb7a8', '1624705002806-5d72df19c3ad', '1593642634315-48f541e24a64', '1511467687858-23d96c32e4ae', '1591488320449-011701bb6704')
    'office' = @('1593642532400-2682810df593', '1541807084-5c52b6b3adef', '1593642632823-8f785ba67e45', '1496181133206-80ce9b88a853', '1517336714731-489689fd1ca8', '1588872657578-7efd1f1555ed')
    'peripherals' = @('1527864550417-7fd91fc51a46', '1511467687858-23d96c32e4ae', '1505740420928-5e560c06d30e', '1527443224154-c4a3942d3acf', '1590602847861-f357a9332bbc', '1587202372775-e229f172b9d7')
    'components' = @('1591488320449-011701bb6704', '1518770660439-4636190af475', '1587202372775-e229f172b9d7', '1597872200349-016042c54a65', '1562976540-1502c2145186', '1511467687858-23d96c32e4ae')
    'services' = @('1563986768609-322da13575f3', '1550751827-4bd374c3f58b', '1451187580459-43490279c0fa', '1581091226825-a6a2a5aee158', '1558494947-3c39236c85e8', '1562408590-e32e08a443f3')
}

$newProducts = @()
for ($i = 0; $i -lt $products.Count; $i++) {
    $p = $products[$i]
    $cat = $p.category
    if (-not $cat) { $cat = 'students' }
    
    $ids = $categoryImages[$cat]
    if (-not $ids) { $ids = $categoryImages['students'] }
    
    $count = $ids.Count
    $id1 = $ids[$i % $count]
    $id2 = $ids[($i + 1) % $count]
    $id3 = $ids[($i + 2) % $count]
    
    $url1 = "https://images.unsplash.com/photo-" + $id1 + "?auto=format&fit=crop&q=80&w=800"
    $url2 = "https://images.unsplash.com/photo-" + $id2 + "?auto=format&fit=crop&q=80&w=800"
    $url3 = "https://images.unsplash.com/photo-" + $id3 + "?auto=format&fit=crop&q=80&w=800"
    
    $p.image = $url1
    $p.images = @($url1, $url2, $url3)
    $p.has360 = ($i % 2 -eq 0)
    
    $newProducts += $p
}

$newJsonStr = $newProducts | ConvertTo-Json -Depth 10
$newJsonStr = $newJsonStr -replace "\\u0026", "&"

$newContent = $content.Substring(0, $startIndex) + "`n" + $newJsonStr + "`n        " + $content.Substring($endIndex)
$newContent | Set-Content "index.html" -Encoding UTF8
Write-Host "Successfully updated products."
