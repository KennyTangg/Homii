import 'package:flutter/material.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  final Map<String, bool> _checkedItems = {
    'Eggs': false,
    'Milk': false,
    'Butter': false,
    'Cheese': false,
    'Yogurt': false,
    'Bread': false,
    'Rice': false,
    'Pasta': false,
    'Flour': false,
    'Sugar': false,
    'Salt': false,
    'Pepper': false,
    'Olive Oil': false,
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pantry',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Track what you have at home',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search pantry items...',
                  hintStyle: TextStyle(color: colorScheme.outline.withOpacity(0.7)),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: _checkedItems.keys.map((name) {
                    return _buildPantryItem(name, _checkedItems[name]!);
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Add new item'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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

  Widget _buildPantryItem(String name, bool isChecked) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
          ),
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                _checkedItems[name] = value ?? false;
              });
            },
            fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return colorScheme.secondary; // Use secondary color when checked
              }
              return Colors.transparent; // Transparent background when unchecked
            }),
            side: BorderSide(color: Colors.grey), // Border color when unchecked
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}




