import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_meal_plan_screen.dart';
import '../../models/meal_plan_model.dart';

class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mealPlanModel = Provider.of<MealPlanModel>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Planner',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Meal Plan: 2,400 kcal',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditMealPlanScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.secondary,
                        side: BorderSide(color: colorScheme.secondary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Edit meal plan'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('Auto-add meals'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.secondary,
                        side: BorderSide(color: colorScheme.secondary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              
              // Display meal plan days
              ...mealPlanModel.mealPlan.map((day) {
                final meals = day.getFilledMeals();
                if (meals.isEmpty) return const SizedBox.shrink();
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: _buildDaySection(context, day.date, meals),
                );
              }).toList(),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDaySection(BuildContext context, String date, List<MealItem> meals) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        ...meals.map((meal) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _buildMealCard(context, meal),
        )).toList(),
      ],
    );
  }

  Widget _buildMealCard(BuildContext context, MealItem meal) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Card background color - use surface color in dark mode for better contrast
    final cardColor = isDarkMode 
        ? Color.fromARGB(255, 42, 51, 59)  // Darker surface color for cards
        : Colors.white;
        
    // Text colors
    final titleColor = isDarkMode 
        ? Colors.white 
        : Colors.black87;
    final subtitleColor = isDarkMode 
        ? Colors.grey[400] 
        : Colors.grey[600];
        
    // Image placeholder color
    final placeholderColor = isDarkMode 
        ? Color.fromARGB(255, 30, 38, 44)  // Even darker for placeholder
        : Colors.grey[200];
    
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          if (!isDarkMode) BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left gray area (placeholder for image)
          Container(
            width: 80,
            decoration: BoxDecoration(
              color: placeholderColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          const SizedBox(width: 15),
          // Meal details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  meal.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  meal.mealType ?? 'Meal',
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Right icons
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                child: Icon(
                  Icons.menu,
                  color: colorScheme.secondary,
                  size: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                child: Icon(
                  meal.isChecked ? Icons.check_circle : Icons.check_circle_outline,
                  color: meal.isChecked 
                      ? colorScheme.primary 
                      : isDarkMode ? Colors.grey[500] : Colors.grey[400],
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MealInfo {
  final String recipe;
  final String mealType;

  _MealInfo(this.recipe, this.mealType);
}








