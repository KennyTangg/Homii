import 'package:flutter/material.dart';
import 'home_page.dart';

class DietSelectionPage extends StatefulWidget {
  const DietSelectionPage({super.key});

  @override
  State<DietSelectionPage> createState() => _DietSelectionPageState();
}

class _DietSelectionPageState extends State<DietSelectionPage> {
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

  String? selectedDiet;

  Widget _buildDietChip(String label) {
    final isSelected = selectedDiet == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDiet = isSelected ? null : label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 20,
            color: isSelected ? Colors.deepOrange : Colors.white,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Do you have a\nspecific diet?',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 20,
                  children: diets.map((diet) => _buildDietChip(diet)).toList(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedDiet != null
                      ? () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    disabledBackgroundColor: Colors.white.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      color: selectedDiet != null
                          ? Colors.deepOrange
                          : Colors.white,
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

