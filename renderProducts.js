function renderProducts(items) {
    productGrid.innerHTML = items.map(product => `
                <div class="product-card group glass rounded-2xl overflow-hidden border-brand-gold/5 hover:border-brand-gold/30 transition-all duration-500 flex flex-col h-full">
                    <div class="relative aspect-square overflow-hidden cursor-pointer" onclick="openProductDetail('${product.id}')">
                        <img src="${product.image}" alt="${product.title}" class="product-image w-full h-full object-cover transition-transform duration-700">
                        <div class="absolute top-4 left-4 flex flex-col gap-2">
                            <span class="bg-brand-gold text-brand-dark text-[10px] font-bold px-2 py-1 rounded-full uppercase">${product.discount}% OFF</span>
                            ${product.stock < 5 ? `<span class="bg-red-600 text-white text-[10px] font-bold px-2 py-1 rounded-full uppercase">Low Stock</span>` : ''}
                            ${product.has360 ? `<span class="bg-blue-600 text-white text-[10px] font-bold px-2 py-1 rounded-full uppercase"><i class="fa-solid fa-rotate mr-1"></i>360° View</span>` : ''}
                        </div>
                        <button onclick="event.stopPropagation(); toggleWishlist('${product.id}')" class="absolute top-4 right-4 w-10 h-10 rounded-full glass flex items-center justify-center text-gray-400 hover:text-brand-gold transition-colors">
                            <i class="${wishlist.includes(product.id) ? 'fa-solid' : 'fa-regular'} fa-heart"></i>
                        </button>
                    </div>
                    <div class="p-6 flex flex-col flex-1">
                        <div class="flex justify-between items-start mb-2">
                            <span class="text-[10px] text-brand-gold font-bold uppercase tracking-widest">${product.brand}</span>
                            <div class="flex items-center text-yellow-500 text-xs">
                                <i class="fa-solid fa-star"></i>
                                <span class="ml-1 text-gray-400">(${product.reviews})</span>
                            </div>
                        </div>
                        <h3 class="font-bold text-lg mb-4 line-clamp-2 group-hover:text-brand-gold transition-colors cursor-pointer" onclick="openProductDetail('${product.id}')">${product.title}</h3>
                        
                        <div class="grid grid-cols-2 gap-2 mb-6 text-[10px] text-gray-500 uppercase tracking-tighter">
                            <div class="flex items-center"><i class="fa-solid fa-microchip mr-2 text-brand-gold/50"></i>${product.specs.processor.split(' ')[0]}</div>
                            <div class="flex items-center"><i class="fa-solid fa-memory mr-2 text-brand-gold/50"></i>${product.specs.ram}</div>
                        </div>

                        <div class="mt-auto">
                            <div class="flex items-baseline space-x-2 mb-4">
                                <span class="text-2xl font-bold text-white">₹${product.price.toLocaleString()}</span>
                                <span class="text-sm text-gray-500 line-through">₹${product.originalPrice.toLocaleString()}</span>
                            </div>
                            <div class="flex gap-2">
                                <button onclick="addToCart('${product.id}')" class="flex-1 gold-bg-gradient text-brand-dark py-3 rounded-xl font-bold text-sm hover:shadow-lg transition-all active:scale-95">
                                    Add to Cart
                                </button>
                                <button onclick="openProductDetail('${product.id}')" class="w-12 h-12 glass border border-brand-gold/20 rounded-xl flex items-center justify-center text-brand-gold hover:bg-brand-gold/10 transition-all">
                                    <i class="fa-solid fa-eye"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            `).join('');
}
