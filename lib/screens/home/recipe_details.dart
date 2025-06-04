import 'package:flutter/material.dart';

class RecipeDetailPage extends StatefulWidget {
  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  bool isFavorited = false;
  List<String> selectedIngredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Hero Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isFavorited = !isFavorited;
                  });
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1598515213692-d872826bc47a?w=800'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Header
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recipe by Jane Doe',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Pan-Roasted Honey Garlic Chicken Thighs',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < 4 ? Icons.star : Icons.star_border,
                                  color: Colors.orange,
                                  size: 18,
                                );
                              }),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '4.9 (159)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            _buildInfoChip('40 mins', Icons.access_time),
                            SizedBox(width: 16),
                            _buildInfoChip('380 cals', Icons.local_fire_department),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Honey Garlic Chicken Thighs are the perfect weeknight dinner solution. This recipe transforms stress up ordinary chicken in this easy dish. Just toss the ingredients together and bake! This is a family favorite that everyone will love. Mom always ate loves things spicy and simple, so it\'s right up her alley.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Ingredients Section
                  Container(
                    color: Colors.grey[50],
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ingredients',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Serving: 4 people',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 16),
                        
                        // Ingredient chips
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildIngredientChip('Honey', '🍯'),
                            _buildIngredientChip('Milk', '🥛'),
                            _buildIngredientChip('Chicken', '🍗'),
                            _buildIngredientChip('Tomato', '🍅'),
                            _buildIngredientChip('Egg', '🥚'),
                          ],
                        ),
                        
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: Colors.grey[600], size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Add missing ingredients to shopping list',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Directions Section
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Directions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 20),
                        
                        _buildStep(
                          'STEP 1',
                          'Start by patting the chicken thighs dry with paper towels and seasoning generously with salt and pepper. Let them sit at room temperature for about 15 minutes. This will help enhance the flavor and create a nice crust during cooking.',
                        ),
                        
                        _buildStep(
                          'STEP 2',
                          'Heat 2 to 3 tablespoons of oil in a large skillet over medium-high heat. Once hot, place the chicken thighs skin-side down. Cook them completely undisturbed for 6 to 7 minutes until the bottom is nicely browned. Note that chicken may be sticky with paper towels. Once nicely browned, bring the internal temperature reaches 75°C (165°F) and the juices run clear.',
                        ),
                        
                        _buildStep(
                          'STEP 3',
                          'Transfer the cooked chicken thighs to a plate and set aside. In the same skillet, add the minced garlic and cook for 30 seconds until fragrant. This keeps the meat tender.',
                        ),
                        
                        _buildStep(
                          'STEP 4',
                          'Reduce the heat to medium and, using the same skillet, add the honey, soy sauce, and olive oil. Add the minced garlic. Saute for about 30 seconds. Next, bring this mixture to a gentle boil and cook for 2-3 minutes, stirring constantly. The sauce should start to thicken. Return the chicken thighs back to the skillet and add a touch of acidity to balance the sweetness. Let sauce simmer for 1 to 2 minutes and it thickens slightly.',
                        ),
                        
                        _buildStep(
                          'STEP 5',
                          'Return the chicken thighs to the pan and spoon the sauce over them. Let them simmer together for about 2-3 minutes to allow the flavors to meld. The chicken should be glazed and glistening in the sticky honey garlic glaze.',
                        ),
                        
                        _buildStep(
                          'STEP 6',
                          'Remove the pan from heat and serve the chicken thighs immediately, spooning any extra sauce over the top. Garnish with fresh chopped parsley. For a final touch, sprinkle with sesame seeds and serve with steamed rice or vegetables.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientChip(String name, String emoji) {
    bool isSelected = selectedIngredients.contains(name);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedIngredients.remove(name);
          } else {
            selectedIngredients.add(name);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange[100] : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.orange[300]! : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: TextStyle(fontSize: 18)),
            SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.orange[800] : Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String stepNumber, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              stepNumber,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800],
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
