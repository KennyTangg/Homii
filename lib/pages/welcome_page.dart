import 'package:flutter/material.dart';
import 'diet_selection_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  double dragDistance = 0.0;
  bool isDragging = false;
  bool isNavigating = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCubic,
    );
    _animation.addListener(() {
      if (!isDragging) {
        setState(() {
          final width = MediaQuery.of(context).size.width;
          dragDistance = isNavigating ? -width * _animation.value : dragDistance * (1 - _animation.value);
        });
      }
    });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed && isNavigating) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const DietSelectionPage(),
            transitionDuration: Duration.zero,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      dragDistance += details.delta.dx;
      if (dragDistance > 0) dragDistance = 0;
      final width = MediaQuery.of(context).size.width;
      if (dragDistance < -width) dragDistance = -width;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    isDragging = false;
    final width = MediaQuery.of(context).size.width;
    isNavigating = dragDistance.abs() > width / 2 || (details.primaryVelocity ?? 0) < -500;
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Stack(
        children: [
          Transform.translate(
            offset: Offset(width + dragDistance, 0),
            child: const DietSelectionPage(),
          ),
          GestureDetector(
            onHorizontalDragStart: (_) => isDragging = true,
            onHorizontalDragUpdate: _handleDragUpdate,
            onHorizontalDragEnd: _handleDragEnd,
            child: Transform.translate(
              offset: Offset(dragDistance, 0),
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
        ],
      ),
    );
  }
}


