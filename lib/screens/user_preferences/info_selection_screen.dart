import 'package:flutter/material.dart';
import 'package:homii/screens/home/home_screen.dart';
import 'package:homii/screens/user_preferences/health_data_screen.dart';
import 'package:homii/utils/swipe_detector.dart';

class InfoSelectionScreen extends StatefulWidget {
  const InfoSelectionScreen({super.key});

  @override
  State<InfoSelectionScreen> createState() => _InfoSelectionScreenState();
}

class _InfoSelectionScreenState extends State<InfoSelectionScreen> {
  final List<String> diets = [
    'Calories','Time to cook','Missing ingredients','Recipe Rating',
    'Cuisine','Dietary restrictions','Meal type','Cooking method',
  ];

  String? selectedInfo;

  Widget _buildDietChip(String label) {
    final isSelected = selectedInfo == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedInfo = isSelected ? null : label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.transparent, // Set to transparent
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: isSelected ? 2.0 : 1.0
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: SwipeDetector(
        onSwipeRight: () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) => HealthDataScreen(),
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
          if (selectedInfo != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
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
              Text(
                'Choose the information you would like to be shown first.',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.primary,
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
                        color: i == 4
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.primary.withAlpha(102), // 0.4 opacity
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedInfo != null
                      ? () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    disabledBackgroundColor: Theme.of(context).colorScheme.primary.withAlpha(77), // 0.3 opacity
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
                      color: selectedInfo != null
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.tertiary.withAlpha(128), // 0.5 opacity
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
