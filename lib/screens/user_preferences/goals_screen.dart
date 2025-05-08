import 'package:flutter/material.dart';
import 'package:homii/screens/user_preferences/diet_selection_screen.dart';
import '../home/home_screen.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final List<String> goals = [
    'Lose-weight', 'Gain-muscle', 'Eat healthy', 'Easy recipes',
    'Meal prep', 'Quick meals', 'Budget-friendly', 'Low-calorie',
  ];

  String? selectedGoal;

  Widget _buildDietChip(String label) {
    final isSelected = selectedGoal == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGoal = isSelected ? null : label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
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
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'What are your home-cooking goals?',
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
                  children: goals.map((diet) => _buildDietChip(diet)).toList(),
                ),
              ),
              // Progress indicator dots at bottom
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
                        color: i == 1 
                            ? Colors.white 
                            : Colors.white.withOpacity(0.4),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedGoal != null
                      ? () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (context, animation, secondaryAnimation) => DietSelectionScreen(),
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
                    foregroundColor: Color.fromRGBO(69, 121, 66, 1),
                    disabledBackgroundColor: Colors.white.withOpacity(0.7),
                    disabledForegroundColor: Color.fromRGBO(69, 121, 66, 0.5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
