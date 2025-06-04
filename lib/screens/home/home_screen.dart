import 'package:flutter/material.dart';
import 'package:homii/screens/profile/profile_screen.dart';
import 'saved_recipes_screen.dart';
import 'planner_screen.dart';
import 'pantry_screen.dart';
import 'shop_screen.dart';
import 'all_recipes_screen.dart'; // Import the new all recipes screen
import '../notifications/notifications_screen.dart'; // Import the notifications screen
import '../../widgets/custom_search_bar.dart';
import '../../widgets/slide_page_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const SavedRecipesScreen(),
    const PlannerScreen(),
    const ShopScreen(),
    const PantryScreen(),
  ];

  Widget _getCurrentPage() {
    if (_selectedIndex == 0) {
      return _buildHomeContent();
    } else {
      return _pages[_selectedIndex - 1];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorScheme.surface,
      body: _getCurrentPage(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: colorScheme.onSurface.withAlpha(26), // 0.1 opacity
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorScheme.surface,
          selectedItemColor: colorScheme.secondary,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_outlined),
              activeIcon: Icon(Icons.bookmark),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Planner',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.kitchen_outlined),
              activeIcon: Icon(Icons.kitchen),
              label: 'Pantry',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Enhanced profile picture with visual cues
                    Material(
                      elevation: 4,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colorScheme.primary.withAlpha(128), // 0.5 opacity
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: colorScheme.primary,
                                child: const Icon(Icons.person, color: Colors.white, size: 28),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: colorScheme.secondary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: colorScheme.surface,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 10,
                                    color: colorScheme.onSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning,',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Lana.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                      Icons.notifications_outlined,
                      color: colorScheme.onSurface,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        SlidePageRoute(
                          child: const NotificationsScreen(),
                          direction: SlideDirection.rightToLeft,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomSearchBar(
              hintText: 'Search for recipes, meals, or groceries...',
              onChanged: (value) {
                // Handle search functionality
              },
              onSubmitted: (value) {
                // Handle search submission
              },
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildFeaturedSection(),
                    const SizedBox(height: 30),
                    _buildSection(
                      'Popular Recipes',
                      [
                        _buildRecipeCard(
                          'Pan-Roasted Honey Garlic Chicken Thighs',
                          '40 mins',
                          '380 kcals',
                          'Jane Doe',
                          'assets/images/home/honey_garlic.png',
                        ),
                        _buildRecipeCard(
                          'Salmon Croquettes with Dill Sauce',
                          '25 mins',
                          '320 kcals',
                          'Caroline Randall',
                          'assets/images/home/salmon.png',
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    _buildSection(
                      'Healthy Eats',
                      [
                        _buildRecipeCard(
                          'Greek Yogurt with Berries',
                          '5 mins',
                          '180 kcals',
                          'Health Chef',
                          'assets/images/home/oats_greek.png',
                        ),
                        _buildRecipeCard(
                          'Grilled Fish with Herbs',
                          '20 mins',
                          '250 kcals',
                          'Chef Maria',
                          'assets/images/home/fish.png',
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    _buildSection(
                      'Recommended for you',
                      [
                        _buildRecipeCard(
                          'Creamy Onion Carbonara',
                          '30 mins',
                          '420 kcals',
                          'Italian Chef',
                          'assets/images/home/onion_carbonara.png',
                        ),
                        _buildRecipeCard(
                          'Crispy Roast Potatoes',
                          '45 mins',
                          '280 kcals',
                          'Home Cook',
                          'assets/images/home/roast_potato.png',
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    _buildSection(
                      'Popular this week',
                      [
                        _buildRecipeCard(
                          'Pan-Roasted Honey Garlic Chicken',
                          '35 mins',
                          '380 kcals',
                          'Chef Gordon',
                          'assets/images/home/honey_garlic.png',
                        ),
                        _buildRecipeCard(
                          'Fresh Salmon Delight',
                          '25 mins',
                          '320 kcals',
                          'Seafood Master',
                          'assets/images/home/salmon.png',
                        ),
                        _buildRecipeCard(
                          'Mediterranean Fish Bowl',
                          '20 mins',
                          '250 kcals',
                          'Healthy Kitchen',
                          'assets/images/home/fish.png',
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

  Widget _buildFeaturedSection() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Check out what\'s for lunch!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/images/home/honey_garlic.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pan-Roasted Honey Garlic Chicken Thighs',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: colorScheme.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '40 mins',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.local_fire_department,
                      color: colorScheme.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '380 kcals',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllRecipesScreen(category: title),
                  ),
                );
              },
              child: Text(
                'See More',
                style: TextStyle(color: colorScheme.secondary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: items),
        ),
      ],
    );
  }

  Widget _buildRecipeCard(String title, String time, String calories, String author, String imagePath) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.1),
            blurRadius: 8,
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: _buildFavoriteIcon(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '$time · $calories',
                  style: TextStyle(
                    color: colorScheme.primary, // Green color for time and calories
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  author,
                  style: TextStyle(
                    color: colorScheme.outline,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteIcon() {
    return _FavoriteIcon();
  }
}

class _FavoriteIcon extends StatefulWidget {
  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<_FavoriteIcon> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary.withValues(alpha: 0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : colorScheme.outline,
          size: 18,
        ),
      ),
    );
  }
}












