import 'package:flutter/material.dart';
import '../../widgets/custom_search_bar.dart';
import 'recipe_details.dart';

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

  // Map recipe names to IDs
  Map<String, String> titleToId = {
    'Pan-Roasted Honey Garlic Chicken Thighs': 'honey-garlic-chicken',
    'Salmon Croquettes with Dill Sauce': 'salmon-croquettes',
    'Caramelized Onion Carbonara': 'onion-carbonara',
    'Roast Bone-In Loin With Potatoes': 'roast-bone-in-loin',
    'Oven Risotto With Crispy Roasted Mushrooms': 'oven-risotto',
    'Baked White Fish With Ginger, Scallions': 'ginger-fish',
    'Duck a l\'Orange': 'duck-orange',
    'Crisp Roasted Duck': 'roasted-duck',
    'Breakfast Skillet': 'breakfast-skillet',
    'Creamy Homemade Yogurt': 'creamy-yogurt',
    'Classic Avocado Toast': 'avocado-toast',
    'Creamy Garlic Chicken': 'garlic-chicken',
    'Asian-Style Beef Stir Fry': 'beef-stir-fry',
    'Crispy Roast Potatoes': 'roast-potatoes',
    'Spicy Honey Garlic Shrimp': 'spicy-honey-shrimp',
    'Mediterranean Fish Platter': 'mediterranean-fish',
    'Truffle Mushroom Pasta': 'truffle-pasta',
    'Gourmet Breakfast Bowl': 'gourmet-breakfast',
    'Citrus Duck Breast': 'citrus-duck',
  };

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
      'category': 'Healthy Eats',
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
      'image': 'assets/images/home/onion_carbonara.png',
      'category': 'Popular Recipes',
    },
    {
      'name': 'Oven Risotto With Crispy Roasted Mushrooms',
      'time': '50 mins',
      'calories': '410 kcals',
      'author': 'David Kim',
      'image': 'assets/images/recipes/oven_risotto_image.png',
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
      'name': 'Asian-Style Beef Stir Fry',
      'time': '25 mins',
      'calories': '320 kcals',
      'author': 'Chef Ming',
      'image': 'assets/images/planner/beef_stir_planner.png',
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
    {
      'name': 'Crispy Roast Potatoes',
      'time': '45 mins',
      'calories': '280 kcals',
      'author': 'Gordon Smith',
      'image': 'assets/images/home/roast_potato.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Duck a l\'Orange',
      'time': '90 mins',
      'calories': '680 kcals',
      'author': 'Pierre Dubois',
      'image': 'assets/images/recipes/duck_orange_image.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Crisp Roasted Duck',
      'time': '120 mins',
      'calories': '780 kcals',
      'author': 'Thomas Lee',
      'image': 'assets/images/recipes/roasted_duck_image.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Breakfast Skillet',
      'time': '25 mins',
      'calories': '520 kcals',
      'author': 'Jane Doe',
      'image': 'assets/images/recipes/breakfast_skillet_image.png',
      'category': 'Popular this week',
    },
    {
      'name': 'Spicy Honey Garlic Shrimp',
      'time': '20 mins',
      'calories': '280 kcals',
      'author': 'Chef Maria',
      'image': 'assets/images/home/honey_garlic.png',
      'category': 'Recommended for you',
    },
    {
      'name': 'Mediterranean Fish Platter',
      'time': '30 mins',
      'calories': '310 kcals',
      'author': 'Chef Marco',
      'image': 'assets/images/recipes/ginger_fish_image.png',
      'category': 'Recommended for you',
    },
    {
      'name': 'Truffle Mushroom Pasta',
      'time': '35 mins',
      'calories': '480 kcals',
      'author': 'Chef Isabella',
      'image': 'assets/images/recipes/oven_risotto_image.png',
      'category': 'Recommended for you',
    },
    {
      'name': 'Gourmet Breakfast Bowl',
      'time': '20 mins',
      'calories': '420 kcals',
      'author': 'Chef Sarah',
      'image': 'assets/images/recipes/breakfast_skillet_image.png',
      'category': 'Recommended for you',
    },
    {
      'name': 'Citrus Duck Breast',
      'time': '45 mins',
      'calories': '520 kcals',
      'author': 'Chef Jean',
      'image': 'assets/images/recipes/duck_orange_image.png',
      'category': 'Recommended for you',
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

    return GestureDetector(
      onTap: () {
        String recipeId = titleToId[recipe['name']] ?? '';
        if (recipeId.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailPage(recipeId: recipeId),
            ),
          );
        }
      },
      child: Container(
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
      ),
    );
  }
}
