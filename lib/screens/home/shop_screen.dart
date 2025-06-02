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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Allow proper keyboard handling
      backgroundColor: const Color(0xFFF8F3E9), // Cream background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Shop',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            color: Theme.of(context).colorScheme.secondary,
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
                  // Handle search functionality for ingredients
                },
                onSubmitted: (value) {
                  // Handle search submission for ingredients
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.85,
                  children: [
                    _buildProductCard(
                      context,
                      'Greenfields Milk\n800 ml',
                      'Rp 20.000',
                      'assets/images/cart/milk_image_shop.png',
                    ),
                    _buildProductCard(
                      context,
                      '8-pack Carton Eggs',
                      'Rp 32.000',
                      'assets/images/cart/egg_image_shop.png',
                    ),
                    _buildProductCard(
                      context,
                      'Wholegrain Bread\n370 gr',
                      'Rp 17.000',
                      'assets/images/cart/bread_image_shop.png',
                    ),
                    _buildProductCard(
                      context,
                      'Button Mushrooms\n150 gr',
                      'Rp 15.000',
                      'assets/images/cart/mushrooms_image_shop.png',
                    ),
                    _buildProductCard(
                      context,
                      'Cooking Oil\n1 L',
                      'Rp 25.000',
                      'assets/images/cart/oil_image_shop.png',
                    ),
                    _buildProductCard(
                      context,
                      'Sweet Soy Sauce\n275 ml',
                      'Rp 18.000',
                      'assets/images/cart/kecap_image_shop.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String name, String price, String imagePath) {
    // Create a unique ID for the product
    final productId = name.toLowerCase().replaceAll(' ', '_');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
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
                    color: Colors.grey[600],
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black,
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
                        color: Colors.grey[700],
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
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
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





