import 'package:flutter/material.dart';
import 'package:homii/screens/home/home_screen.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
