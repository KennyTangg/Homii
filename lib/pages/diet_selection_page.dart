import 'package:flutter/material.dart';

class DietSelectionPage extends StatelessWidget {
  const DietSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      backgroundColor: Colors.deepOrange,
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
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepOrange,
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

  Widget _buildDietChip(String label) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.white.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.white),
      ),
    );
  }
}