import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:homii/screens/user_preferences/info_selection_screen.dart';
import 'package:homii/screens/user_preferences/diet_selection_screen.dart';
import 'package:homii/utils/swipe_detector.dart';

class HealthDataScreen extends StatefulWidget {
  const HealthDataScreen({super.key});

  @override
  State<HealthDataScreen> createState() => _HealthDataScreenState();
}

class _HealthDataScreenState extends State<HealthDataScreen> {
  // Form data
  String? _selectedSex;
  int? _selectedYear;
  int? _selectedHeight;
  int? _selectedWeight;

  // Controllers for the pickers
  final FixedExtentScrollController _heightController = FixedExtentScrollController(initialItem: 162 - 140);
  final FixedExtentScrollController _weightController = FixedExtentScrollController(initialItem: 60 - 40);

  // Current step in the form (4 out of 5)
  final int _currentStep = 3;

  // List of years for birth year selection (1950-2015)
  final List<int> _years = List.generate(66, (index) => 2015 - index);

  // List of heights in cm (140-200)
  final List<int> _heights = List.generate(61, (index) => 140 + index);

  // List of weights in kg (40-150)
  final List<int> _weights = List.generate(111, (index) => 40 + index);

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _showWeightPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              // Header with cancel and done buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        '×',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text(
                      'Select Weight',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedWeight = _weights[_weightController.selectedItem];
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Weight picker
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: CupertinoPicker(
                        scrollController: _weightController,
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {},
                        children: _weights.map((weight) {
                          return Center(
                            child: Text(
                              weight.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Text(
                      'kg',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showYearPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              // Header with cancel and done buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        '×',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text(
                      'Select Year',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_selectedYear != null) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Year picker
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedYear = _years[index];
                    });
                  },
                  children: _years.map((year) {
                    return Center(
                      child: Text(
                        year.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSexSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Select Sex',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Male'),
                onTap: () {
                  setState(() {
                    _selectedSex = 'Male';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Female'),
                onTap: () {
                  setState(() {
                    _selectedSex = 'Female';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Other'),
                onTap: () {
                  setState(() {
                    _selectedSex = 'Other';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showHeightPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              // Header with cancel and done buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        '×',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text(
                      'Select Height',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedHeight = _heights[_heightController.selectedItem];
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Height picker
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: CupertinoPicker(
                        scrollController: _heightController,
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {},
                        children: _heights.map((height) {
                          return Center(
                            child: Text(
                              height.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Text(
                      'cm',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCCFE7), // Pink background from design
      body: SwipeDetector(
        onSwipeRight: () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) => DietSelectionScreen(),
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
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) => InfoSelectionScreen(),
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
        },
        child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Input your\nhealth data.",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 30),

              // Form fields
              _buildFormField('Sex', _selectedSex ?? '', onTap: () {
                _showSexSelectionDialog();
              }),
              const SizedBox(height: 20),

              _buildFormField('Year of Birth', _selectedYear?.toString() ?? '', onTap: () {
                _showYearPicker();
              }),
              const SizedBox(height: 20),

              _buildFormField('Height', _selectedHeight != null ? '$_selectedHeight cm' : '', onTap: () {
                _showHeightPicker();
              }),
              const SizedBox(height: 20),

              _buildFormField('Weight', _selectedWeight != null ? '$_selectedWeight kg' : '', onTap: () {
                _showWeightPicker();
              }),

              const Spacer(),

              // Progress indicator and continue button
              Column(
                children: [
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
                            color: i == _currentStep
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.secondary.withAlpha(102), // 0.4 opacity
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (context, animation, secondaryAnimation) => InfoSelectionScreen(),
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
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildFormField(String label, String value, {required VoidCallback onTap}) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color orangeColor = colorScheme.secondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(10),
          border: value.isNotEmpty
              ? Border.all(color: orangeColor, width: 1.5)
              : Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: [
            Text(
              value.isEmpty ? label : value,
              style: TextStyle(
                fontSize: 16,
                color: orangeColor, // Orange text to match design
                fontWeight: value.isEmpty ? FontWeight.normal : FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (value.isNotEmpty)
              Icon(
                Icons.check_circle,
                color: orangeColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
