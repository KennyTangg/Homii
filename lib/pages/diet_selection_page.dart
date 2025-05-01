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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Do you have a specific diet?',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
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
