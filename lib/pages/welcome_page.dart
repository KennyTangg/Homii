import 'package:flutter/material.dart';
import 'diet_selection_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
  double dragDistance = 0.0;
  bool isDragging = false;

  late AnimationController _slideController;
  late Animation<double> _slideAnimation;

  late AnimationController _arrowController;
  late Animation<double> _arrowAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Arrow bounce animation
    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _arrowAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _arrowController, curve: Curves.easeInOut),
    );
  }

  void _animateTo(double end) {
    final start = dragDistance;

    _slideAnimation = Tween<double>(begin: start, end: end).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ))
      ..addListener(() {
        setState(() {
          dragDistance = _slideAnimation.value;
        });
      });

    _slideController.forward(from: 0);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      dragDistance += details.delta.dy;
      if (dragDistance > 0) dragDistance = 0;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    final height = MediaQuery.of(context).size.height;

    if (dragDistance.abs() > height / 2 || (details.primaryVelocity ?? 0) < -500) {
      _animateTo(-height);
      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const DietSelectionPage(),
            transitionDuration: Duration.zero,
          ),
        );
      });
    } else {
      _animateTo(0);
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _arrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Transform.translate(
            offset: Offset(0, height + dragDistance),
            child: const DietSelectionPage(),
          ),
          GestureDetector(
            onVerticalDragStart: (_) => isDragging = true,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: Transform.translate(
              offset: Offset(0, dragDistance),
              child: Image.asset(
                'assets/images/welcome_page_image.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.white,
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Swipe Down Indicator
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _arrowAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _arrowAnimation.value),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.keyboard_arrow_down, size: 40, color: Colors.green[800]),
                      Text(
                        "Swipe down to continue",
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
