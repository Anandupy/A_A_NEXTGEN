const fs = require('fs');
const path = 'index.html';

let content = fs.readFileSync(path, 'utf8');

// Extract the JSON
const startTag = '<script id="products-json" type="application/json">';
const endTag = '</script>';
const startIndex = content.indexOf(startTag) + startTag.length;
const endIndex = content.indexOf(endTag, startIndex);
let jsonStr = content.substring(startIndex, endIndex).trim();

// Fix the trailing comma issue if any
if (jsonStr.endsWith(',')) {
    jsonStr = jsonStr.slice(0, -1);
}

let products = JSON.parse(jsonStr);

const categoryImages = {
    'students': [
        '1588872657578-7efd1f1555ed', '1517336714731-489689fd1ca8', '1496181133206-80ce9b88a853',
        '1541807084-5c52b6b3adef', '1611186871348-b1ec696e5238', '1589561084283-930aa7b1ce50'
    ],
    'gaming': [
        '1603302576837-37561b2e2302', '1544197150-b99a580bb7a8', '1624705002806-5d72df19c3ad',
        '1593642634315-48f541e24a64', '1511467687858-23d96c32e4ae', '1591488320449-011701bb6704'
    ],
    'office': [
        '1593642532400-2682810df593', '1541807084-5c52b6b3adef', '1593642632823-8f785ba67e45',
        '1496181133206-80ce9b88a853', '1517336714731-489689fd1ca8', '1588872657578-7efd1f1555ed'
    ],
    'peripherals': [
        '1527864550417-7fd91fc51a46', '1511467687858-23d96c32e4ae', '1505740420928-5e560c06d30e',
        '1527443224154-c4a3942d3acf', '1590602847861-f357a9332bbc', '1587202372775-e229f172b9d7'
    ],
    'components': [
        '1591488320449-011701bb6704', '1518770660439-4636190af475', '1587202372775-e229f172b9d7',
        '1597872200349-016042c54a65', '1562976540-1502c2145186', '1511467687858-23d96c32e4ae'
    ],
    'services': [
        '1563986768609-322da13575f3', '1550751827-4bd374c3f58b', '1451187580459-43490279c0fa',
        '1581091226825-a6a2a5aee158', '1558494947-3c39236c85e8', '1562408590-e32e08a443f3'
    ]
};

products = products.map((p, index) => {
    const category = p.category || 'students';
    const ids = categoryImages[category] || categoryImages['students'];

    // Pick 3 unique IDs from the category list
    const mainId = ids[index % ids.length];
    const secondId = ids[(index + 1) % ids.length];
    const thirdId = ids[(index + 2) % ids.length];

    return {
        ...p,
        images: [
            `https://images.unsplash.com/photo-${mainId}?auto=format&fit=crop&q=80&w=800`,
            `https://images.unsplash.com/photo-${secondId}?auto=format&fit=crop&q=80&w=800`,
            `https://images.unsplash.com/photo-${thirdId}?auto=format&fit=crop&q=80&w=800`
        ],
        has360: (index % 2 === 0) // 50% of products have 360 view
    };
});

const newJsonStr = JSON.stringify(products, null, 12);
const newContent = content.substring(0, startIndex) + '\n' + newJsonStr + '\n        ' + content.substring(endIndex);

fs.writeFileSync(path, newContent);
console.log('Successfully updated products with multiple images and 360 view status.');
