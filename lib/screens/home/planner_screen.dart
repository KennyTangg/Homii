import 'package:flutter/material.dart';
import 'edit_meal_plan_screen.dart';

class PlannerMeal {
  final String name;
  final String mealType;
  final String imagePath;
  final bool isCompleted;

  PlannerMeal({
    required this.name,
    required this.mealType,
    required this.imagePath,
    this.isCompleted = false,
  });
}

class PlannerDay {
  final String date;
  final List<PlannerMeal> meals;

  PlannerDay({
    required this.date,
    required this.meals,
  });
}

class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});

  List<PlannerDay> get mealPlan => [
    PlannerDay(
      date: 'Today, 18 March',
      meals: [
        PlannerMeal(
          name: 'Overnight Oats and Greek Yogurt',
          mealType: 'Breakfast',
          imagePath: 'assets/images/planner/oat_greek_planner.png',
          isCompleted: false,
        ),
        PlannerMeal(
          name: 'Pan-Roasted Honey Garlic Chicken Thighs',
          mealType: 'Lunch',
          imagePath: 'assets/images/planner/honey_garlic_planner.png',
          isCompleted: true,
        ),
      ],
    ),
    PlannerDay(
      date: 'Tomorrow, 19 March',
      meals: [
        PlannerMeal(
          name: 'Classic Avocado Toast',
          mealType: 'Breakfast',
          imagePath: 'assets/images/planner/avocado_toast_planner.png',
          isCompleted: true,
        ),
        PlannerMeal(
          name: 'Creamy Garlic Chicken',
          mealType: 'Lunch',
          imagePath: 'assets/images/planner/garlic_chicken_planner.png',
          isCompleted: true,
        ),
        PlannerMeal(
          name: 'Braised Beef Stir Fry',
          mealType: 'Dinner',
          imagePath: 'assets/images/planner/beef_stir_planner.png',
          isCompleted: true,
        ),
      ],
    ),
    PlannerDay(
      date: '20 March',
      meals: [
        PlannerMeal(
          name: 'Overnight Oats and Greek Yogurt',
          mealType: 'Breakfast',
          imagePath: 'assets/images/planner/oat_greek_planner.png',
          isCompleted: true,
        ),
        PlannerMeal(
          name: 'Pan-Roasted Honey Garlic Chicken Thighs',
          mealType: 'Lunch',
          imagePath: 'assets/images/planner/honey_garlic_planner.png',
          isCompleted: true,
        ),
        PlannerMeal(
          name: 'Braised Beef Stir Fry',
          mealType: 'Dinner',
          imagePath: 'assets/images/planner/beef_stir_planner.png',
          isCompleted: true,
        ),
      ],
    ),
    PlannerDay(
      date: '21 March',
      meals: [
        PlannerMeal(
          name: 'Classic Avocado Toast',
          mealType: 'Breakfast',
          imagePath: 'assets/images/planner/avocado_toast_planner.png',
          isCompleted: false,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
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
              const SizedBox(height: 20),

              // Action buttons
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
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Edit meal plan'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Auto-add meals'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.secondary,
                        side: BorderSide(color: colorScheme.secondary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Display meal plan days
              ...mealPlan.map((day) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: _buildDaySection(context, day),
                );
              }),

              // Floating Action Button positioned at bottom right
              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDaySection(BuildContext context, PlannerDay day) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day.date,
          style: TextStyle(
            fontSize: 0,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 15),
        ...day.meals.map((meal) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildMealCard(context, meal),
        )),
      ],
    );
  }

  Widget _buildMealCard(BuildContext context, PlannerMeal meal) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Meal image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              meal.imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: colorScheme.outline.withValues(alpha: 0.3),
                  child: Icon(
                    Icons.restaurant,
                    color: colorScheme.outline,
                    size: 30,
                  ),
                );
              },
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
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  meal.mealType,
                  style: TextStyle(
                    color: colorScheme.outline,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Right icons
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Icon(
                    Icons.drag_handle,
                    color: colorScheme.outline.withValues(alpha: 0.6),
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Icon(
                    meal.isCompleted ? Icons.check_circle : Icons.check_circle_outline,
                    color: meal.isCompleted
                        ? colorScheme.primary
                        : colorScheme.outline.withValues(alpha: 0.6),
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



