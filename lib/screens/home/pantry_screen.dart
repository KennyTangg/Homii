import 'package:flutter/material.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class PantryItem {
  final String name;
  final String daysLeft;
  final String emoji;
  final Color color;
  bool isChecked;

  PantryItem({
    required this.name,
    required this.daysLeft,
    required this.emoji,
    required this.color,
    this.isChecked = false,
  });
}

class _PantryScreenState extends State<PantryScreen> {
  String _searchQuery = '';
  String _sortBy = 'Sort by date';

  final List<PantryItem> _pantryItems = [
    PantryItem(
      name: 'Milk',
      daysLeft: '2 days left',
      emoji: '🥛',
      color: const Color(0xFF87CEEB),
    ),
    PantryItem(
      name: 'Bread',
      daysLeft: '14 days left',
      emoji: '🍞',
      color: const Color(0xFFDEB887),
    ),
    PantryItem(
      name: 'Carrots',
      daysLeft: '19 days left',
      emoji: '🥕',
      color: const Color(0xFFFF8C00),
    ),
    PantryItem(
      name: 'Tomato',
      daysLeft: '50 days left',
      emoji: '🍅',
      color: const Color(0xFFFF6347),
    ),
    PantryItem(
      name: 'Eggs',
      daysLeft: '24 days left',
      emoji: '🥚',
      color: const Color(0xFFFFF8DC),
    ),
    PantryItem(
      name: 'Chicken',
      daysLeft: '40 days left',
      emoji: '🍗',
      color: const Color(0xFFDEB887),
    ),
    PantryItem(
      name: 'Potatoes',
      daysLeft: '50 days left',
      emoji: '🥔',
      color: const Color(0xFFD2B48C),
    ),
    PantryItem(
      name: 'Bell pepper',
      daysLeft: '56 days left',
      emoji: '🫑',
      color: const Color(0xFF32CD32),
    ),
  ];

  List<PantryItem> get _filteredItems {
    List<PantryItem> filtered = _pantryItems.where((item) {
      return item.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // Sort the filtered items
    switch (_sortBy) {
      case 'Sort by date':
        filtered.sort((a, b) {
          int aDays = int.tryParse(a.daysLeft.split(' ')[0]) ?? 0;
          int bDays = int.tryParse(b.daysLeft.split(' ')[0]) ?? 0;
          return aDays.compareTo(bDays); // Ascending order (expiring soon first)
        });
        break;
      case 'Sort by name':
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Sort by expiry':
        filtered.sort((a, b) {
          int aDays = int.tryParse(a.daysLeft.split(' ')[0]) ?? 0;
          int bDays = int.tryParse(b.daysLeft.split(' ')[0]) ?? 0;
          return aDays.compareTo(bDays);
        });
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'My Pantry',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),

              // Sort and Search Row
              Row(
                children: [
                  // Sort dropdown button
                  PopupMenuButton<String>(
                    onSelected: (String value) {
                      setState(() {
                        _sortBy = value;
                      });
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem<String>(
                        value: 'Sort by date',
                        child: Text('Sort by date'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Sort by name',
                        child: Text('Sort by name'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Sort by expiry',
                        child: Text('Sort by expiry'),
                      ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: colorScheme.secondary),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _sortBy,
                            style: TextStyle(
                              color: colorScheme.secondary,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: colorScheme.secondary,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Search bar
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: colorScheme.outline.withAlpha(77),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.onSurface.withAlpha(13), // 0.05 opacity
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search Ingredient...',
                          hintStyle: TextStyle(
                            color: colorScheme.outline,
                            fontSize: 12,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: colorScheme.outline,
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 4,
                          ),
                        ),
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Pantry Items List
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = _filteredItems[index];
                    return _buildPantryItem(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item functionality
        },
        backgroundColor: colorScheme.secondary,
        child: Icon(
          Icons.add,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }

  Widget _buildPantryItem(PantryItem item) {
    final colorScheme = Theme.of(context).colorScheme;

    // Determine if item is expiring soon (less than 7 days)
    final daysLeftNumber = int.tryParse(item.daysLeft.split(' ')[0]) ?? 0;
    final isExpiringSoon = daysLeftNumber <= 7;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withAlpha(13), // 0.05 opacity
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: item.color.withAlpha(51), // 0.2 opacity
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                item.emoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Item details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    if (isExpiringSoon) ...[
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.daysLeft,
                  style: TextStyle(
                    fontSize: 14,
                    color: isExpiringSoon ? Colors.red : colorScheme.outline,
                    fontWeight: isExpiringSoon ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          // Checkbox
          Checkbox(
            value: item.isChecked,
            onChanged: (value) {
              setState(() {
                item.isChecked = value ?? false;
              });
            },
            fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return colorScheme.secondary;
              }
              return Colors.transparent;
            }),
            side: BorderSide(
              color: colorScheme.outline.withAlpha(128), // 0.5 opacity
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}







