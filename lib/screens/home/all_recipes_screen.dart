import 'package:flutter/material.dart';
import '../../widgets/custom_search_bar.dart';

class AllRecipesScreen extends StatefulWidget {
  final String category;
  
  const AllRecipesScreen({
    super.key,
    required this.category,
  });

  @override
  State<AllRecipesScreen> createState() => _AllRecipesScreenState();
}

class _AllRecipesScreenState extends State<AllRecipesScreen> {
  String _searchQuery = '';

  // Sample recipe data - in a real app, this would come from a database or API
  final List<Map<String, String>> _allRecipes = [
    {
      'name': 'Pan-Roasted Honey Garlic Chicken Thighs',
      'time': '40 mins',
      'calories': '380 kcals',
      'author': 'Jane Doe',
      'image': 'assets/images/home/honey_garlic.png',
      'category': 'Popular Recipes',
    },
    {
      'name': 'Salmon Croquettes with Dill Sauce',
      'time': '25 mins',
      'calories': '320 kcals',
      'author': 'Caroline Randall',
      'image': 'assets/images/home/salmon.png',
      'category': 'Popular Recipes',
    },
    {
      'name': 'Classic Avocado Toast',
      'time': '10 mins',
      'calories': '220 kcals',
      'author': 'Breakfast Pro',
      'image': 'assets/images/planner/avocado_toast_planner.png',
      'category': 'Popular Recipes',
    },
    {
      'name': 'Creamy Garlic Chicken',
      'time': '35 mins',
      'calories': '420 kcals',
      'author': 'Chef Antonio',
      'image': 'assets/images/planner/garlic_chicken_planner.png',
      'category': 'Popular Recipes',
    },
    {
      'name': 'Roast Bone-In Loin With Potatoes',
      'time': '120 mins',
      'calories': '750 kcals',
      'author': 'Michael Chen',
      'image': 'assets/images/recipes/roast_potatoes_image.png',
      'category': 'Popular Recipes',
    },
    {
      'name': 'Caramelized Onion Carbonara',
      'time': '40 mins',
      'calories': '520 kcals',
      'author': 'Sophia Martinez',
      'image': 'assets/images/recipes/onion_carbonara_image.png',
      'category': 'Popular Recipes',
    },
    {
      'name': 'Oven Risotto With Crispy Roasted Mushrooms',
      'time': '50 mins',
      'calories': '410 kcals',
      'author': 'David Kim',
      'image': 'assets/images/recipes/oven_risotto_image.png',
      'category': 'Popular Recipes',
    },
    {
      'name': 'Breakfast Skillet',
      'time': '25 mins',
      'calories': '520 kcals',
      'author': 'Jane Doe',
      'image': 'assets/images/recipes/breakfast_skillet_image.png',
      'category': 'Popular Recipes',
    },
    {
      'name': 'Greek Yogurt with Berries',
      'time': '5 mins',
      'calories': '180 kcals',
      'author': 'Health Chef',
      'image': 'assets/images/home/oats_greek.png',
      'category': 'Healthy Eats',
    },
    {
      'name': 'Grilled Fish with Herbs',
      'time': '20 mins',
      'calories': '250 kcals',
      'author': 'Chef Maria',
      'image': 'assets/images/home/fish.png',
      'category': 'Healthy Eats',
    },
    {
      'name': 'Braised Beef Stir Fry',
      'time': '30 mins',
      'calories': '350 kcals',
      'author': 'Asian Kitchen',
      'image': 'assets/images/planner/beef_stir_planner.png',
      'category': 'Healthy Eats',
    },
    {
      'name': 'Overnight Oats and Greek Yogurt',
      'time': '5 mins prep',
      'calories': '200 kcals',
      'author': 'Morning Chef',
      'image': 'assets/images/planner/oat_greek_planner.png',
      'category': 'Healthy Eats',
    },
    {
      'name': 'Baked White Fish With Ginger, Scallions',
      'time': '35 mins',
      'calories': '290 kcals',
      'author': 'Angela Chen',
      'image': 'assets/images/recipes/ginger_fish_image.png',
      'category': 'Healthy Eats',
    },
    {
      'name': 'Creamy Homemade Yogurt',
      'time': '20 mins',
      'calories': '210 kcals',
      'author': 'Jane Doe',
      'image': 'assets/images/recipes/creamy_yogurt_image.png',
      'category': 'Healthy Eats',
    },
    // Additional Popular this week recipes
    {
      'name': 'Mediterranean Fish Bowl',
      'time': '25 mins',
      'calories': '340 kcals',
      'author': 'Chef Marina',
      'image': 'assets/images/home/fish.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Crispy Roast Potatoes',
      'time': '45 mins',
      'calories': '280 kcals',
      'author': 'Gordon Smith',
      'image': 'assets/images/home/roast_potato.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Creamy Onion Carbonara',
      'time': '30 mins',
      'calories': '520 kcals',
      'author': 'Italian Chef',
      'image': 'assets/images/home/onion_carbonara.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Fresh Salmon Delight',
      'time': '35 mins',
      'calories': '380 kcals',
      'author': 'Seafood Master',
      'image': 'assets/images/home/salmon.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Honey Garlic Glazed Chicken',
      'time': '40 mins',
      'calories': '420 kcals',
      'author': 'BBQ King',
      'image': 'assets/images/planner/honey_garlic_planner.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Gourmet Avocado Toast',
      'time': '15 mins',
      'calories': '250 kcals',
      'author': 'Brunch Expert',
      'image': 'assets/images/planner/avocado_toast_planner.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Asian Beef Stir Fry',
      'time': '25 mins',
      'calories': '390 kcals',
      'author': 'Wok Master',
      'image': 'assets/images/planner/beef_stir_planner.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Creamy Garlic Chicken Supreme',
      'time': '35 mins',
      'calories': '450 kcals',
      'author': 'Chef Roberto',
      'image': 'assets/images/recipes/garlic_chicken_image.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Gourmet Breakfast Skillet',
      'time': '20 mins',
      'calories': '380 kcals',
      'author': 'Morning Chef',
      'image': 'assets/images/recipes/breakfast_skillet_image.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Roasted Duck with Orange Glaze',
      'time': '90 mins',
      'calories': '650 kcals',
      'author': 'Fine Dining Chef',
      'image': 'assets/images/recipes/roasted_duck_image.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Salmon Croquettes Deluxe',
      'time': '30 mins',
      'calories': '340 kcals',
      'author': 'Seafood Specialist',
      'image': 'assets/images/recipes/salmon_croquettes_image.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Baked White Fish with Ginger',
      'time': '35 mins',
      'calories': '290 kcals',
      'author': 'Asian Fusion Chef',
      'image': 'assets/images/recipes/ginger_fish_image.png',
      'category': 'Popular this week',
    },
  ];

  List<Map<String, String>> get _filteredRecipes {
    return _allRecipes.where((recipe) {
      final matchesCategory = recipe['category'] == widget.category;
      final matchesSearch = _searchQuery.isEmpty ||
          recipe['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          recipe['author']!.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.category,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search bar
              CustomSearchBar(
                hintText: 'Search recipes...',
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${_filteredRecipes.length} recipes found',
                  style: TextStyle(
                    color: colorScheme.outline,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Recipe grid
              Expanded(
                child: _filteredRecipes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: colorScheme.outline,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No recipes found',
                              style: TextStyle(
                                fontSize: 18,
                                color: colorScheme.outline,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try adjusting your search terms',
                              style: TextStyle(
                                fontSize: 14,
                                color: colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.8, // Increased to give more height
                        ),
                        itemCount: _filteredRecipes.length,
                        itemBuilder: (context, index) {
                          return _buildRecipeCard(context, _filteredRecipes[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext context, Map<String, String> recipe) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withAlpha(26),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipe image
          SizedBox(
            height: 120, // Fixed height for image
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    recipe['image']!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: isDarkMode ? colorScheme.primary.withAlpha(50) : colorScheme.primary.withAlpha(25),
                        child: Center(
                          child: Icon(
                            Icons.restaurant,
                            size: 40,
                            color: colorScheme.primary.withAlpha(150),
                          ),
                        ),
                      );
                    },
                  ),
                  // Favorite button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(200),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border),
                        iconSize: 20,
                        color: colorScheme.primary,
                        onPressed: () {
                          // Handle favorite toggle
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Recipe details
          Container(
            height: 80, // Fixed height to prevent overflow
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    recipe['name']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  recipe['author']!,
                  style: TextStyle(
                    color: colorScheme.outline,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${recipe['time']} · ${recipe['calories']}',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
