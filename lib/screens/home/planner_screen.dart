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
          isCompleted: false,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF8F3E9), // Cream background to match design
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Planner',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Meal Plan: 2,400 kcal',
                style: TextStyle(
                  color: Color(0xFF8B4513), // Brown color to match design
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
                        foregroundColor: const Color(0xFFE67E22), // Orange color
                        side: const BorderSide(color: Color(0xFFE67E22)),
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
                        foregroundColor: const Color(0xFFE67E22), // Orange color
                        side: const BorderSide(color: Color(0xFFE67E22)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new meal functionality
        },
        backgroundColor: const Color(0xFF4CAF50), // Green color from design
        child: const Icon(
          Icons.restaurant,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDaySection(BuildContext context, PlannerDay day) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day.date,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
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
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
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
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.restaurant,
                    color: Colors.grey,
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  meal.mealType,
                  style: const TextStyle(
                    color: Colors.grey,
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
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Icon(
                    meal.isCompleted ? Icons.check_circle : Icons.check_circle_outline,
                    color: meal.isCompleted
                        ? const Color(0xFF4CAF50)
                        : Colors.grey[400],
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



