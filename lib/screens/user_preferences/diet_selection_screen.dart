import 'package:flutter/material.dart';
import 'package:homii/screens/user_preferences/health_data_screen.dart';
import 'package:homii/screens/user_preferences/goals_screen.dart';
import 'package:homii/utils/swipe_detector.dart';

class DietSelectionScreen extends StatefulWidget {
  const DietSelectionScreen({super.key});

  @override
  State<DietSelectionScreen> createState() => _DietSelectionScreenState();
}

class _DietSelectionScreenState extends State<DietSelectionScreen> {
  final List<String> diets = [
    'Low-Carb',
    'Gluten-free',
    'Vegan',
    'Vegetarian',
    'Dairy-free',
    'Keto',
    'Mediterranean',
    'Ovo Vegetarian',
    'Ovo-Lacto Vegetarian',
    'Paleo',
    'Pescetarian',
    'Lacto Vegetarian',
  ];

  // List to store selected diets (up to 3)
  final List<String> selectedDiets = [];

  Widget _buildDietChip(String label) {
    final isSelected = selectedDiets.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            // If already selected, remove it
            selectedDiets.remove(label);
          } else if (selectedDiets.length < 3) {
            // If not selected and less than 3 items are selected, add it
            selectedDiets.add(label);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.transparent, // Set to transparent
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white,
            width: isSelected ? 2.0 : 1.0
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color:Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: SwipeDetector(
        onSwipeRight: () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) => GoalsScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1.0, 0.0); // Coming from left
                const end = Offset.zero;
                const curve = Curves.ease;

                final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                final offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },
        onSwipeLeft: () {
          if (selectedDiets.isNotEmpty) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) => HealthDataScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0); // Coming from right
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  final offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          }
        },
        child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Do you have a specific diet?',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 5,
                  children: diets.map((diet) => _buildDietChip(diet)).toList(),
                ),
              ),
              // Progress indicator dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == 2
                            ? Colors.white
                            : Colors.white.withAlpha(102), // 0.4 opacity
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedDiets.isNotEmpty
                      ? () {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (context, animation, secondaryAnimation) => HealthDataScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.ease;

                                final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                final offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    disabledBackgroundColor: Colors.white.withAlpha(179), // 0.7 opacity
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: selectedDiets.isNotEmpty
                          ? Colors.deepOrangeAccent
                          : Colors.deepOrangeAccent.withAlpha(128), // 0.5 opacity
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}



