import 'package:flutter/material.dart';

class EditMealPlanScreen extends StatefulWidget {
  const EditMealPlanScreen({super.key});

  @override
  State<EditMealPlanScreen> createState() => _EditMealPlanScreenState();
}

class _EditMealPlanScreenState extends State<EditMealPlanScreen> {
  // Sample data - in a real app, this would come from a database
  final List<DayPlan> _mealPlan = [
    DayPlan(
      date: 'Today, 18 March',
      meals: {
        'Breakfast': MealItem(name: 'Overnight Oats and Greek Yogurt', isChecked: true),
        'Lunch': MealItem(name: 'Pan-Roasted Honey Garlic Chicken Thighs', isChecked: true),
        'Dinner': MealItem(name: '', isChecked: false),
      },
      isExpanded: true,
    ),
    DayPlan(
      date: '19 March',
      meals: {
        'Breakfast': MealItem(name: 'Overnight Oats and Greek Yogurt', isChecked: true),
        'Lunch': MealItem(name: 'Pan-Roasted Honey Garlic Chicken Thighs', isChecked: true),
        'Dinner': MealItem(name: 'Braised Beef Stir Fry', isChecked: true),
      },
      isExpanded: true,
    ),
    DayPlan(
      date: '20 March',
      meals: {
        'Breakfast': MealItem(name: 'Overnight Oats and Greek Yogurt', isChecked: true),
        'Lunch': MealItem(name: 'Pan-Roasted Honey Garlic Chicken Thighs', isChecked: true),
        'Dinner': MealItem(name: 'Braised Beef Stir Fry', isChecked: true),
      },
      isExpanded: true,
    ),
    DayPlan(
      date: '21 March',
      meals: {
        'Breakfast': MealItem(name: 'Overnight Oats and Greek Yogurt', isChecked: true),
        'Lunch': MealItem(name: '', isChecked: false),
        'Dinner': MealItem(name: '', isChecked: false),
      },
      isExpanded: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Meal Plan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Save changes
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mealPlan.length,
        itemBuilder: (context, index) {
          final day = _mealPlan[index];
          return _buildDaySection(context, day);
        },
      ),
    );
  }

  Widget _buildDaySection(BuildContext context, DayPlan day) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Day header with checkbox
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day.date,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: day.date.contains('Today') 
                        ? colorScheme.secondary 
                        : colorScheme.onSurface,
                  ),
                ),
                Checkbox(
                  value: day.isAllChecked(),
                  onChanged: (value) {
                    setState(() {
                      day.toggleAllMeals(value ?? false);
                    });
                  },
                  activeColor: colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          // Meal items
          ...day.meals.entries.map((entry) {
            final mealType = entry.key;
            final meal = entry.value;
            
            return _buildMealItem(context, mealType, meal, day);
          }).toList(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildMealItem(BuildContext context, String mealType, MealItem meal, DayPlan day) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool isEmpty = meal.name.isEmpty;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meal type column
          SizedBox(
            width: 80,
            child: Text(
              mealType,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isEmpty ? Colors.grey : colorScheme.onSurface,
              ),
            ),
          ),
          
          // Meal name column with vertical line
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    meal.name.isEmpty ? 'Add meal' : meal.name,
                    style: TextStyle(
                      fontSize: 14,
                      color: meal.name.isEmpty 
                          ? Colors.grey 
                          : Colors.grey[600],
                    ),
                  ),
                ),
                
                // Vertical dotted line
                if (mealType != 'Dinner' || day.meals['Dinner']!.name.isNotEmpty)
                  Container(
                    height: 24,
                    width: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Checkbox
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: meal.isChecked,
              onChanged: (value) {
                setState(() {
                  meal.isChecked = value ?? false;
                });
              },
              activeColor: colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DayPlan {
  final String date;
  final Map<String, MealItem> meals;
  bool isExpanded;

  DayPlan({
    required this.date,
    required this.meals,
    this.isExpanded = true,
  });

  bool isAllChecked() {
    return meals.values.every((meal) => meal.isChecked || meal.name.isEmpty);
  }

  void toggleAllMeals(bool value) {
    for (var meal in meals.values) {
      if (meal.name.isNotEmpty) {
        meal.isChecked = value;
      }
    }
  }
}

class MealItem {
  String name;
  bool isChecked;

  MealItem({
    required this.name,
    required this.isChecked,
  });
}