import 'package:flutter/material.dart';
import 'cart_screen.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/custom_notification.dart';
import '../../services/cart_service.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final CartService _cartService = CartService();
  String _searchQuery = '';

  // All available products
  final List<Map<String, String>> _allProducts = [
    {
      'name': 'Greenfields Milk\n800 ml',
      'price': 'Rp 20.000',
      'image': 'assets/images/cart/milk_image_shop.png',
      'keywords': 'milk dairy greenfields 800ml beverage drink',
    },
    {
      'name': '8-pack Carton Eggs',
      'price': 'Rp 32.000',
      'image': 'assets/images/cart/egg_image_shop.png',
      'keywords': 'eggs protein carton 8pack breakfast cooking',
    },
    {
      'name': 'Wholegrain Bread\n370 gr',
      'price': 'Rp 17.000',
      'image': 'assets/images/cart/bread_image_shop.png',
      'keywords': 'bread wholegrain 370gr carbohydrate breakfast',
    },
    {
      'name': 'Button Mushrooms\n150 gr',
      'price': 'Rp 15.000',
      'image': 'assets/images/cart/mushrooms_image_shop.png',
      'keywords': 'mushrooms button 150gr vegetable fungi cooking',
    },
    {
      'name': 'Cooking Oil\n1 L',
      'price': 'Rp 25.000',
      'image': 'assets/images/cart/oil_image_shop.png',
      'keywords': 'oil cooking 1l liter frying kitchen',
    },
    {
      'name': 'Sweet Soy Sauce\n275 ml',
      'price': 'Rp 18.000',
      'image': 'assets/images/cart/kecap_image_shop.png',
      'keywords': 'soy sauce sweet kecap 275ml seasoning condiment',
    },
  ];

  @override
  void initState() {
    super.initState();
    _cartService.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {});
  }

  List<Map<String, String>> get _filteredProducts {
    if (_searchQuery.isEmpty) {
      return _allProducts;
    }

    return _allProducts.where((product) {
      final query = _searchQuery.toLowerCase();
      final name = product['name']!.toLowerCase();
      final keywords = product['keywords']!.toLowerCase();

      return name.contains(query) || keywords.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent keyboard from affecting layout
      backgroundColor: colorScheme.surface,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: colorScheme.surface,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shop',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colorScheme.onPrimary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.onSurface.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: colorScheme.secondary,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(),
                                ),
                              );
                            },
                            iconSize: 24,
                          ),
                        ),
                        if (_cartService.totalItems > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${_cartService.totalItems}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomSearchBar(
                  hintText: 'Search ingredient eg. milk',
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  onSubmitted: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Results count
                if (_searchQuery.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      '${_filteredProducts.length} ${_filteredProducts.length == 1 ? 'product' : 'products'} found',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                Expanded(
                  child: _filteredProducts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No products found',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try adjusting your search terms',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.85,
                          ),
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = _filteredProducts[index];
                            return _buildProductCard(
                              context,
                              product['name']!,
                              product['price']!,
                              product['image']!,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String name, String price, String imagePath) {
    // Create a unique ID for the product
    final productId = name.toLowerCase().replaceAll(' ', '_');
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.more_vert,
                    color: colorScheme.outline,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color: colorScheme.outline,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final cartItem = CartItem(
                          id: productId,
                          name: name,
                          price: price,
                          imagePath: imagePath,
                        );
                        _cartService.addItem(cartItem);

                        // Show custom notification with slide animation
                        CustomNotification.show(
                          context,
                          message: '$name added to cart',
                          duration: const Duration(seconds: 2),
                          icon: Icons.shopping_cart,
                          backgroundColor: colorScheme.primary,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.add,
                          color: colorScheme.onPrimary,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





