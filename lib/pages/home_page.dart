import 'package:flutter/material.dart';
import 'saved_recipes_page.dart';
import 'planner_page.dart';
import 'pantry_page.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  double _dragDistance = 0.0;
  bool _isDragging = false;
  bool _isNavigating = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Remove HomePage from pages to prevent recursion
  final List<Widget> _pages = [
    const SavedRecipesPage(),
    const PlannerPage(),
    const PantryPage(),
    const CartPage(),
  ];

  Widget _getCurrentPage() {
    if (_selectedIndex == 0) {
      return _buildHomeContent();
    } else {
      return _pages[_selectedIndex - 1];
    }
  }

  Widget? _getNextPage() {
    if (_selectedIndex >= _pages.length) return null;
    return _selectedIndex == 0 ? _pages[0] : _pages[_selectedIndex];
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animation.addListener(() {
      if (!_isDragging) {
        setState(() {
          final width = MediaQuery.of(context).size.width;
          _dragDistance = _isNavigating 
              ? width * _animation.value 
              : _dragDistance * (1 - _animation.value);
        });
      }
    });

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_isNavigating) {
          setState(() {
            _selectedIndex++;
            _dragDistance = 0.0;
            _isNavigating = false;
          });
        }
        _animationController.reset();
      }
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_selectedIndex >= _pages.length) return;
    setState(() {
      _dragDistance += details.delta.dx;
      final width = MediaQuery.of(context).size.width;
      if (_dragDistance < 0) _dragDistance = 0;
      if (_dragDistance > width) _dragDistance = width;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_selectedIndex >= _pages.length) return;
    _isDragging = false;
    final width = MediaQuery.of(context).size.width;
    _isNavigating = _dragDistance > width / 2 || (details.primaryVelocity ?? 0) > 500;
    _animationController.forward(from: 0);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _dragDistance = 0.0;
      _isNavigating = false;
      _animationController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final nextPage = _getNextPage();
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // Next page preview
          if (nextPage != null)
            Transform.translate(
              offset: Offset(width - _dragDistance, 0),
              child: nextPage,
            ),
          // Current page
          GestureDetector(
            onHorizontalDragStart: (_) => _isDragging = true,
            onHorizontalDragUpdate: _handleDragUpdate,
            onHorizontalDragEnd: _handleDragEnd,
            child: Transform.translate(
              offset: Offset(-_dragDistance, 0),
              child: _getCurrentPage(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              activeIcon: Icon(Icons.bookmark),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Planner',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.kitchen_outlined),
              activeIcon: Icon(Icons.kitchen),
              label: 'Pantry',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Good morning,',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Lana.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.notifications_outlined),
              ],
            ),
            const SizedBox(height: 20),
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for recipes, meals, or groceries...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Popular Recipes section
                    _buildSection(
                      'Popular Recipes',
                      [
                        _buildRecipeCard(
                          'Pan-Roasted Honey Garlic Chicken Thighs',
                          '40 mins',
                          '380 kcals',
                          'Jane Doe',
                        ),
                        _buildRecipeCard(
                          'Pan-Roasted Chicken Thighs',
                          '35 mins',
                          '350 kcals',
                          'Jane Doe',
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Healthy Eats section
                    _buildSection(
                      'Healthy Eats',
                      [
                        _buildRecipeCard(
                          'Grilled Salmon with Vegetables',
                          '25 mins',
                          '300 kcals',
                          'John Doe',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See More'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeCard(
    String title,
    String time,
    String calories,
    String author,
  ) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                ),
              ),
              const Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  '$time · $calories',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 5),
                Text(
                  author,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}






