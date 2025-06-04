import 'package:flutter/material.dart';
import '../../widgets/custom_search_bar.dart';
import 'recipe_details.dart';

class Recipe {
  final String name;
  final String author;
  final String cookTime;
  final String calories;
  final String imagePath;

  Recipe({
    required this.name,
    required this.author,
    required this.cookTime,
    required this.calories,
    required this.imagePath,
  });
}

class SavedRecipesScreen extends StatefulWidget {
  const SavedRecipesScreen({super.key});

  @override
  State<SavedRecipesScreen> createState() => _SavedRecipesScreenState();
}

class _SavedRecipesScreenState extends State<SavedRecipesScreen> {
  String _searchQuery = '';

  List<Recipe> get _allRecipes => [
    Recipe(
      name: 'Pan-Roasted Honey Garlic Chicken',
      author: 'Jane Doe',
      cookTime: '40 mins',
      calories: '380 kcals',
      imagePath: 'assets/images/recipes/garlic_chicken_image.png',
    ),
    Recipe(
      name: 'Salmon Croquettes With Dill Sauce',
      author: 'Caroline Randall',
      cookTime: '45 mins',
      calories: '340 kcals',
      imagePath: 'assets/images/recipes/salmon_croquettes_image.png',
    ),
    Recipe(
      name: 'Roast Bone-In Loin With Potatoes',
      author: 'Michael Chen',
      cookTime: '120 mins',
      calories: '750 kcals',
      imagePath: 'assets/images/recipes/roast_potatoes_image.png',
    ),
    Recipe(
      name: 'Caramelized Onion Carbonara',
      author: 'Sophia Martinez',
      cookTime: '40 mins',
      calories: '520 kcals',
      imagePath: 'assets/images/recipes/onion_carbonara_image.png',
    ),
    Recipe(
      name: 'Oven Risotto With Crispy Roasted Mushrooms',
      author: 'David Kim',
      cookTime: '50 mins',
      calories: '410 kcals',
      imagePath: 'assets/images/recipes/oven_risotto_image.png',
    ),
    Recipe(
      name: 'Baked White Fish With Ginger, Scallions',
      author: 'Angela Chen',
      cookTime: '35 mins',
      calories: '290 kcals',
      imagePath: 'assets/images/recipes/ginger_fish_image.png',
    ),
    Recipe(
      name: 'Duck a l\'Orange\n',
      author: 'Pierre Dubois',
      cookTime: '90 mins',
      calories: '680 kcals',
      imagePath: 'assets/images/recipes/duck_orange_image.png',
    ),
    Recipe(
      name: 'Crisp Roasted Duck\n',
      author: 'Thomas Lee',
      cookTime: '120 mins',
      calories: '780 kcals',
      imagePath: 'assets/images/recipes/roasted_duck_image.png',
    ),
    Recipe(
      name: 'Breakfast Skillet\n',
      author: 'Jane Doe',
      cookTime: '25 mins',
      calories: '520 kcals',
      imagePath: 'assets/images/recipes/breakfast_skillet_image.png',
    ),
    Recipe(
      name: 'Creamy Homemade Yogurt',
      author: 'Jane Doe',
      cookTime: '20 mins',
      calories: '210 kcals',
      imagePath: 'assets/images/recipes/creamy_yogurt_image.png',
    ),
  ];

  List<Recipe> get _filteredRecipes {
    if (_searchQuery.isEmpty) {
      return _allRecipes;
    }
    return _allRecipes.where((recipe) {
      return recipe.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             recipe.author.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Saved Recipes',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              // Search bar
              CustomSearchBar(
                hintText: 'Search by recipe, author...',
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
              const SizedBox(height: 16),
              // Recipe grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: _filteredRecipes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        String recipeId = '';
                        // Map the recipe name to the corresponding ID
                        Map<String, String> recipeNameToId = {
                          'Pan-Roasted Honey Garlic Chicken': 'honey-garlic-chicken',
                          'Salmon Croquettes With Dill Sauce': 'salmon-croquettes',
                          'Caramelized Onion Carbonara': 'onion-carbonara',
                          'Roast Bone-In Loin With Potatoes': 'roast-bone-in-loin',
                          'Oven Risotto With Crispy Roasted Mushrooms': 'oven-risotto',
                          'Baked White Fish With Ginger, Scallions': 'ginger-fish',
                          'Duck a l\'Orange\n': 'duck-orange',
                          'Crisp Roasted Duck\n': 'roasted-duck',
                          'Breakfast Skillet\n': 'breakfast-skillet',
                          'Creamy Homemade Yogurt': 'creamy-yogurt',
                        };
                        
                        print("Trying to match name: ${_filteredRecipes[index].name}"); // Debug print
                        recipeId = recipeNameToId[_filteredRecipes[index].name] ?? '';
                        print("Found recipeId: $recipeId"); // Debug print
                        
                        if (recipeId.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailPage(recipeId: recipeId),
                            ),
                          );
                        }
                      },
                      child: _buildRecipeCard(context, _filteredRecipes[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext context, Recipe recipe) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withAlpha(26),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.asset(
              recipe.imagePath,
              width: double.infinity,
              height: 130,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 115,
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
          ),
          // Recipe details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recipe.author,
                    style: TextStyle(
                      color: colorScheme.outline,
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${recipe.cookTime} · ${recipe.calories}',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



