import 'package:flutter/material.dart';

class MealPlanModel extends ChangeNotifier {
  // Singleton pattern
  static final MealPlanModel _instance = MealPlanModel._internal();
  
  factory MealPlanModel() => _instance;
  
  MealPlanModel._internal() {
    // Initialize with sample data
    _mealPlan = [
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
        date: 'Tomorrow, 19 March',
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
  }
  
  List<DayPlan> _mealPlan = [];
  
  List<DayPlan> get mealPlan => _mealPlan;
  
  void updateMeal(int dayIndex, String mealType, bool isChecked) {
    if (dayIndex < _mealPlan.length) {
      final meal = _mealPlan[dayIndex].meals[mealType];
      if (meal != null) {
        meal.isChecked = isChecked;
        notifyListeners();
      }
    }
  }
  
  void updateDayMeals(int dayIndex, bool isChecked) {
    if (dayIndex < _mealPlan.length) {
      _mealPlan[dayIndex].toggleAllMeals(isChecked);
      notifyListeners();
    }
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
  
  List<MealItem> getFilledMeals() {
    return meals.entries
        .where((entry) => entry.value.name.isNotEmpty)
        .map((entry) => MealItem(
              name: entry.value.name,
              isChecked: entry.value.isChecked,
              mealType: entry.key,
            ))
        .toList();
  }
}

class MealItem {
  String name;
  bool isChecked;
  String? mealType;

  MealItem({
    required this.name,
    required this.isChecked,
    this.mealType,
  });
}