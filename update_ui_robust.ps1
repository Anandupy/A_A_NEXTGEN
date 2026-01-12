$lines = Get-Content "index.html"
$newLines = @()

$inRender = $false
$inDetail = $false

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    
    if ($line -match "function renderProducts\(items\) \{") {
        $inRender = $true
        $newLines += "        function renderProducts(items) {"
        $newLines += "            productGrid.innerHTML = items.map(product => \`"
        $newLines += "                <div class=`"product-card group glass rounded-2xl overflow-hidden border-brand-gold/5 hover:border-brand-gold/30 transition-all duration-500 flex flex-col h-full`">"
        $newLines += "                    <div class=`"relative aspect-square overflow-hidden cursor-pointer`" onclick=`"openProductDetail('\${product.id}')`">"
        $newLines += "                        <img src=`"\${product.image}\`" alt=`"\${product.title}\`" class=`"product-image w-full h-full object-cover transition-transform duration-700`">"
        $newLines += "                        <div class=`"absolute top-4 left-4 flex flex-col gap-2`">"
        $newLines += "                            <span class=`"bg-brand-gold text-brand-dark text-[10px] font-bold px-2 py-1 rounded-full uppercase`">\${product.discount}% OFF</span>"
        $newLines += "                            \${product.stock < 5 ? \`<span class=`"bg-red-600 text-white text-[10px] font-bold px-2 py-1 rounded-full uppercase`">Low Stock</span>\` : ''}"
        $newLines += "                            \${product.has360 ? \`<span class=`"bg-blue-600 text-white text-[10px] font-bold px-2 py-1 rounded-full uppercase`"><i class=`"fa-solid fa-rotate mr-1`"></i>360° View</span>\` : ''}"
        $newLines += "                        </div>"
        $newLines += "                        <button onclick=`"event.stopPropagation(); toggleWishlist('\${product.id}')`" class=`"absolute top-4 right-4 w-10 h-10 rounded-full glass flex items-center justify-center text-gray-400 hover:text-brand-gold transition-colors`">"
        $newLines += "                            <i class=`"\${wishlist.includes(product.id) ? 'fa-solid' : 'fa-regular'} fa-heart`"></i>"
        $newLines += "                        </button>"
        $newLines += "                    </div>"
        $newLines += "                    <div class=`"p-6 flex flex-col flex-1`">"
        $newLines += "                        <div class=`"flex justify-between items-start mb-2`">"
        $newLines += "                            <span class=`"text-[10px] text-brand-gold font-bold uppercase tracking-widest`">\${product.brand}</span>"
        $newLines += "                            <div class=`"flex items-center text-yellow-500 text-xs`">"
        $newLines += "                                <i class=`"fa-solid fa-star`"></i>"
        $newLines += "                                <span class=`"ml-1 text-gray-400`">(\${product.reviews})</span>"
        $newLines += "                            </div>"
        $newLines += "                        </div>"
        $newLines += "                        <h3 class=`"font-bold text-lg mb-4 line-clamp-2 group-hover:text-brand-gold transition-colors cursor-pointer`" onclick=`"openProductDetail('\${product.id}')`">\${product.title}</h3>"
        $newLines += "                        "
        $newLines += "                        <div class=`"grid grid-cols-2 gap-2 mb-6 text-[10px] text-gray-500 uppercase tracking-tighter`">"
        $newLines += "                            <div class=`"flex items-center`"><i class=`"fa-solid fa-microchip mr-2 text-brand-gold/50`"></i>\${product.specs.processor.split(' ')[0]}</div>"
        $newLines += "                            <div class=`"flex items-center`"><i class=`"fa-solid fa-memory mr-2 text-brand-gold/50`"></i>\${product.specs.ram}</div>"
        $newLines += "                        </div>"
        $newLines += ""
        $newLines += "                        <div class=`"mt-auto`">"
        $newLines += "                            <div class=`"flex items-baseline space-x-2 mb-4`">"
        $newLines += "                                <span class=`"text-2xl font-bold text-white`">₹\${product.price.toLocaleString()}</span>"
        $newLines += "                                <span class=`"text-sm text-gray-500 line-through`">₹\${product.originalPrice.toLocaleString()}</span>"
        $newLines += "                            </div>"
        $newLines += "                            <div class=`"flex gap-2`">"
        $newLines += "                                <button onclick=`"addToCart('\${product.id}')`" class=`"flex-1 gold-bg-gradient text-brand-dark py-3 rounded-xl font-bold text-sm hover:shadow-lg transition-all active:scale-95`">"
        $newLines += "                                    Add to Cart"
        $newLines += "                                </button>"
        $newLines += "                                <button onclick=`"openProductDetail('\${product.id}')`" class=`"w-12 h-12 glass border border-brand-gold/20 rounded-xl flex items-center justify-center text-brand-gold hover:bg-brand-gold/10 transition-all`">"
        $newLines += "                                    <i class=`"fa-solid fa-eye`"></i>"
        $newLines += "                                </button>"
        $newLines += "                            </div>"
        $newLines += "                        </div>"
        $newLines += "                    </div>"
        $newLines += "                </div>"
        $newLines += "            \`).join('');"
        $newLines += "        }"
        continue
    }
    
    if ($inRender) {
        if ($line -match "\}\.join\(''\)\;") {
            # Skip until the closing brace
        } elseif ($line -trim -eq "}") {
            $inRender = $false
        }
        continue
    }

    if ($line -match "function openProductDetail\(id\) \{") {
        $inDetail = $true
        $newLines += "        function openProductDetail(id) {"
        $newLines += "            const product = products.find(p => p.id === id);"
        $newLines += "            const modalBody = document.getElementById('modal-body');"
        $newLines += ""
        $newLines += "            modalBody.innerHTML = \`"
        $newLines += "                <div class=`"space-y-6`">"
        $newLines += "                    <div class=`"aspect-square rounded-3xl overflow-hidden glass border border-brand-gold/10 relative`">"
        $newLines += "                        <img id=`"main-product-img`" src=`"\${product.images[0]}\`" class=`"w-full h-full object-cover transition-all duration-500`">"
        $newLines += "                        \${product.has360 ? \`"
        $newLines += "                            <div id=`"view-360-container`" class=`"absolute inset-0 bg-brand-dark/80 flex items-center justify-center hidden`">"
        $newLines += "                                <div class=`"text-center`">"
        $newLines += "                                    <i class=`"fa-solid fa-rotate text-5xl text-brand-gold animate-spin-slow mb-4`"></i>"
        $newLines += "                                    <p class=`"text-brand-gold font-bold uppercase tracking-widest`">360° Interactive View</p>"
        $newLines += "                                    <p class=`"text-gray-400 text-xs mt-2`">Drag to rotate (Simulation)</p>"
        $newLines += "                                </div>"
        $newLines += "                            </div>"
        $newLines += "                        \` : ''}"
        $newLines += "                    </div>"
        $newLines += "                    <div class=`"grid grid-cols-4 gap-4`">"
        $newLines += "                        \${product.images.map((img, idx) => \`"
        $newLines += "                            <div class=`"aspect-square rounded-xl glass border border-brand-gold/10 p-1 cursor-pointer hover:border-brand-gold/50 transition-all`" onclick=`"changeMainImage('\${img}', this)`">"
        $newLines += "                                <img src=`"\${img}\`" class=`"w-full h-full object-cover rounded-lg`">"
        $newLines += "                            </div>"
        $newLines += "                        \`).join('')}"
        $newLines += "                        \${product.has360 ? \`"
        $newLines += "                            <div class=`"aspect-square rounded-xl glass border border-brand-gold/20 p-1 cursor-pointer flex items-center justify-center text-brand-gold text-xs font-bold hover:bg-brand-gold/10 transition-all`" onclick=`"toggle360View()`">"
        $newLines += "                                <i class=`"fa-solid fa-rotate mr-1`"></i>360°"
        $newLines += "                            </div>"
        $newLines += "                        \` : ''}"
        $newLines += "                    </div>"
        $newLines += "                </div>"
        $newLines += "                <div class=`"flex flex-col`">"
        $newLines += "                    <div class=`"mb-6`">"
        $newLines += "                        <span class=`"text-brand-gold font-bold uppercase tracking-[0.3em] text-xs`">\${product.brand}</span>"
        $newLines += "                        <h2 class=`"text-3xl font-heading font-bold mt-2`">\${product.title}</h2>"
        $newLines += "                        <div class=`"flex items-center mt-4 space-x-4`">"
        $newLines += "                            <div class=`"flex text-yellow-500`">"
        $newLines += "                                <i class=`"fa-solid fa-star`"></i><i class=`"fa-solid fa-star`"></i><i class=`"fa-solid fa-star`"></i><i class=`"fa-solid fa-star`"></i><i class=`"fa-solid fa-star-half-stroke`"></i>"
        $newLines += "                            </div>"
        $newLines += "                            <span class=`"text-gray-500 text-sm`">\${product.reviews} Verified Mumbai Reviews</span>"
        $newLines += "                        </div>"
        $newLines += "                    </div>"
        $newLines += ""
        $newLines += "                    <div class=`"bg-brand-gray/50 rounded-2xl p-6 mb-8 border border-brand-gold/5`">"
        $newLines += "                        <div class=`"flex items-baseline space-x-4 mb-2`">"
        $newLines += "                            <span class=`"text-4xl font-bold text-white`">₹\${product.price.toLocaleString()}</span>"
        $newLines += "                            <span class=`"text-xl text-gray-500 line-through`">₹\${product.originalPrice.toLocaleString()}</span>"
        $newLines += "                            <span class=`"text-green-500 font-bold`">\${product.discount}% OFF</span>"
        $newLines += "                        </div>"
        $newLines += "                        <p class=`"text-brand-gold font-medium`">EMI starts at ₹\${product.emi.toLocaleString()}/mo*</p>"
        $newLines += "                    </div>"
        $newLines += ""
        $newLines += "                    <div class=`"grid grid-cols-2 gap-4 mb-8`">"
        $newLines += "                        <div class=`"glass p-4 rounded-xl border-brand-gold/10`">"
        $newLines += "                            <span class=`"text-[10px] text-gray-500 uppercase block mb-1`">Processor</span>"
        $newLines += "                            <span class=`"font-bold text-sm`">\${product.specs.processor}</span>"
        $newLines += "                        </div>"
        $newLines += "                        <div class=`"glass p-4 rounded-xl border-brand-gold/10`">"
        $newLines += "                            <span class=`"text-[10px] text-gray-500 uppercase block mb-1`">Memory</span>"
        $newLines += "                            <span class=`"font-bold text-sm`">\${product.specs.ram}</span>"
        $newLines += "                        </div>"
        $newLines += "                        <div class=`"glass p-4 rounded-xl border-brand-gold/10`">"
        $newLines += "                            <span class=`"text-[10px] text-gray-500 uppercase block mb-1`">Storage</span>"
        $newLines += "                            <span class=`"font-bold text-sm`">\${product.specs.storage}</span>"
        $newLines += "                        </div>"
        $newLines += "                        <div class=`"glass p-4 rounded-xl border-brand-gold/10`">"
        $newLines += "                            <span class=`"text-[10px] text-gray-500 uppercase block mb-1`">Display</span>"
        $newLines += "                            <span class=`"font-bold text-sm`">\${product.specs.display}</span>"
        $newLines += "                        </div>"
        $newLines += "                    </div>"
        $newLines += ""
        $newLines += "                    <div class=`"flex gap-4 mt-auto`">"
        $newLines += "                        <button onclick=`"addToCart('\${product.id}')`" class=`"flex-1 gold-bg-gradient text-brand-dark py-5 rounded-2xl font-bold text-lg hover:shadow-[0_0_30px_rgba(212,175,55,0.3)] transition-all`">"
        $newLines += "                            Add to Cart"
        $newLines += "                        </button>"
        $newLines += "                        <button class=`"px-8 glass border border-brand-gold/20 rounded-2xl text-brand-gold hover:bg-brand-gold/10 transition-all`">"
        $newLines += "                            <i class=`"fa-regular fa-heart text-xl`"></i>"
        $newLines += "                        </button>"
        $newLines += "                    </div>"
        $newLines += "                    "
        $newLines += "                    <div class=`"mt-6 flex items-center justify-center space-x-6 text-[10px] text-gray-500 uppercase font-bold tracking-widest`">"
        $newLines += "                        <span class=`"flex items-center`"><i class=`"fa-solid fa-truck-fast mr-2 text-brand-gold`"></i> Fast Mumbai Delivery</span>"
        $newLines += "                        <span class=`"flex items-center`"><i class=`"fa-solid fa-shield-halved mr-2 text-brand-gold`"></i> 1 Year Warranty</span>"
        $newLines += "                    </div>"
        $newLines += "                </div>"
        $newLines += "            \`;"
        $newLines += ""
        $newLines += "            productModal.classList.remove('hidden');"
        $newLines += "            document.body.style.overflow = 'hidden';"
        $newLines += "        }"
        $newLines += ""
        $newLines += "        function changeMainImage(src, el) {"
        $newLines += "            document.getElementById('main-product-img').src = src;"
        $newLines += "            document.getElementById('view-360-container')?.classList.add('hidden');"
        $newLines += "            // Update active state of thumbnails"
        $newLines += "            el.parentElement.querySelectorAll('.border-brand-gold\\\\/50').forEach(thumb => {"
        $newLines += "                thumb.classList.remove('border-brand-gold/50');"
        $newLines += "                thumb.classList.add('border-brand-gold/10');"
        $newLines += "            });"
        $newLines += "            el.classList.remove('border-brand-gold/10');"
        $newLines += "            el.classList.add('border-brand-gold/50');"
        $newLines += "        }"
        $newLines += ""
        $newLines += "        function toggle360View() {"
        $newLines += "            const container = document.getElementById('view-360-container');"
        $newLines += "            if (container) {"
        $newLines += "                container.classList.toggle('hidden');"
        $newLines += "            }"
        $newLines += "        }"
        continue
    }
    
    if ($inDetail) {
        if ($line -match "document\.body\.style\.overflow \= 'hidden'\;") {
            # Skip until the closing brace
        } elseif ($line -trim -eq "}") {
            $inDetail = $false
        }
        continue
    }

    $newLines += $line
}

$newLines | Set-Content "index.html" -Encoding UTF8
Write-Host "Successfully updated UI logic."
