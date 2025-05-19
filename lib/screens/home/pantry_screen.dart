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

  // Add this to track keyboard visibility
  bool _isKeyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Update keyboard visibility
    _isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image banner at the top
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withAlpha(25),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Opacity(
                          opacity: 0.9,
                          child: Image.asset(
                            'assets/images/food_corner.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withAlpha(204), // 0.8 opacity
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Your Pantry',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
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
                        hintStyle: TextStyle(color: colorScheme.outline.withAlpha(179)), // 0.7 opacity
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

                    // Pantry items section
                    Container(
                      decoration: BoxDecoration(
                        color: isDarkMode ? colorScheme.surface.withAlpha(128) : colorScheme.onPrimary.withAlpha(128), // 0.5 opacity
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: colorScheme.outline.withAlpha(26), // 0.1 opacity
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Your Items',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              Icon(
                                Icons.sort,
                                color: colorScheme.primary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),

                          // List of pantry items
                          ..._checkedItems.keys.map((name) {
                            return _buildPantryItem(name, _checkedItems[name]!);
                          }),
                        ],
                      ),
                    ),

                    // Only show the button when keyboard is not visible
                    if (!_isKeyboardVisible)
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
            ],
          ),
        ),
      ),
      // Add a floating action button that appears only when keyboard is visible
      floatingActionButton: _isKeyboardVisible
          ? FloatingActionButton(
              onPressed: () {
                // Hide keyboard
                FocusScope.of(context).unfocus();
              },
              backgroundColor: colorScheme.primary,
              child: const Icon(Icons.keyboard_hide),
            )
          : null,
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
            fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
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







