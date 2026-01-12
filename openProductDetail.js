function openProductDetail(id) {
    const product = products.find(p => p.id === id);
    const modalBody = document.getElementById('modal-body');

    modalBody.innerHTML = `
                <div class="space-y-6">
                    <div class="aspect-square rounded-3xl overflow-hidden glass border border-brand-gold/10 relative">
                        <img id="main-product-img" src="${product.images[0]}" class="w-full h-full object-cover transition-all duration-500">
                        ${product.has360 ? `
                            <div id="view-360-container" class="absolute inset-0 bg-brand-dark/80 flex items-center justify-center hidden">
                                <div class="text-center">
                                    <i class="fa-solid fa-rotate text-5xl text-brand-gold animate-spin-slow mb-4"></i>
                                    <p class="text-brand-gold font-bold uppercase tracking-widest">360° Interactive View</p>
                                    <p class="text-gray-400 text-xs mt-2">Drag to rotate (Simulation)</p>
                                </div>
                            </div>
                        ` : ''}
                    </div>
                    <div class="grid grid-cols-4 gap-4">
                        ${product.images.map((img, idx) => `
                            <div class="aspect-square rounded-xl glass border border-brand-gold/10 p-1 cursor-pointer hover:border-brand-gold/50 transition-all" onclick="changeMainImage('${img}', this)">
                                <img src="${img}" class="w-full h-full object-cover rounded-lg">
                            </div>
                        `).join('')}
                        ${product.has360 ? `
                            <div class="aspect-square rounded-xl glass border border-brand-gold/20 p-1 cursor-pointer flex items-center justify-center text-brand-gold text-xs font-bold hover:bg-brand-gold/10 transition-all" onclick="toggle360View()">
                                <i class="fa-solid fa-rotate mr-1"></i>360°
                            </div>
                        ` : ''}
                    </div>
                </div>
                <div class="flex flex-col">
                    <div class="mb-6">
                        <span class="text-brand-gold font-bold uppercase tracking-[0.3em] text-xs">${product.brand}</span>
                        <h2 class="text-3xl font-heading font-bold mt-2">${product.title}</h2>
                        <div class="flex items-center mt-4 space-x-4">
                            <div class="flex text-yellow-500">
                                <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half-stroke"></i>
                            </div>
                            <span class="text-gray-500 text-sm">${product.reviews} Verified Mumbai Reviews</span>
                        </div>
                    </div>

                    <div class="bg-brand-gray/50 rounded-2xl p-6 mb-8 border border-brand-gold/5">
                        <div class="flex items-baseline space-x-4 mb-2">
                            <span class="text-4xl font-bold text-white">₹${product.price.toLocaleString()}</span>
                            <span class="text-xl text-gray-500 line-through">₹${product.originalPrice.toLocaleString()}</span>
                            <span class="text-green-500 font-bold">${product.discount}% OFF</span>
                        </div>
                        <p class="text-brand-gold font-medium">EMI starts at ₹${product.emi.toLocaleString()}/mo*</p>
                    </div>

                    <div class="grid grid-cols-2 gap-4 mb-8">
                        <div class="glass p-4 rounded-xl border-brand-gold/10">
                            <span class="text-[10px] text-gray-500 uppercase block mb-1">Processor</span>
                            <span class="font-bold text-sm">${product.specs.processor}</span>
                        </div>
                        <div class="glass p-4 rounded-xl border-brand-gold/10">
                            <span class="text-[10px] text-gray-500 uppercase block mb-1">Memory</span>
                            <span class="font-bold text-sm">${product.specs.ram}</span>
                        </div>
                        <div class="glass p-4 rounded-xl border-brand-gold/10">
                            <span class="text-[10px] text-gray-500 uppercase block mb-1">Storage</span>
                            <span class="font-bold text-sm">${product.specs.storage}</span>
                        </div>
                        <div class="glass p-4 rounded-xl border-brand-gold/10">
                            <span class="text-[10px] text-gray-500 uppercase block mb-1">Display</span>
                            <span class="font-bold text-sm">${product.specs.display}</span>
                        </div>
                    </div>

                    <div class="flex gap-4 mt-auto">
                        <button onclick="addToCart('${product.id}')" class="flex-1 gold-bg-gradient text-brand-dark py-5 rounded-2xl font-bold text-lg hover:shadow-[0_0_30px_rgba(212,175,55,0.3)] transition-all">
                            Add to Cart
                        </button>
                        <button class="px-8 glass border border-brand-gold/20 rounded-2xl text-brand-gold hover:bg-brand-gold/10 transition-all">
                            <i class="fa-regular fa-heart text-xl"></i>
                        </button>
                    </div>
                    
                    <div class="mt-6 flex items-center justify-center space-x-6 text-[10px] text-gray-500 uppercase font-bold tracking-widest">
                        <span class="flex items-center"><i class="fa-solid fa-truck-fast mr-2 text-brand-gold"></i> Fast Mumbai Delivery</span>
                        <span class="flex items-center"><i class="fa-solid fa-shield-halved mr-2 text-brand-gold"></i> 1 Year Warranty</span>
                    </div>
                </div>
            `;

    productModal.classList.remove('hidden');
    document.body.style.overflow = 'hidden';
}

function changeMainImage(src, el) {
    document.getElementById('main-product-img').src = src;
    document.getElementById('view-360-container')?.classList.add('hidden');
    // Update active state of thumbnails
    el.parentElement.querySelectorAll('.border-brand-gold\\/50').forEach(thumb => {
        thumb.classList.remove('border-brand-gold/50');
        thumb.classList.add('border-brand-gold/10');
    });
    el.classList.remove('border-brand-gold/10');
    el.classList.add('border-brand-gold/50');
}

function toggle360View() {
    const container = document.getElementById('view-360-container');
    if (container) {
        container.classList.toggle('hidden');
    }
}
