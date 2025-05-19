import 'package:flutter/material.dart';

/// A widget that detects swipe gestures and triggers callbacks.
/// This implementation is optimized for better detection and user experience.
class SwipeDetector extends StatelessWidget {
  final Widget child;
  final Function()? onSwipeRight;
  final Function()? onSwipeLeft;
  final double sensitivity;
  final double minSwipeDistance;

  const SwipeDetector({
    Key? key,
    required this.child,
    this.onSwipeRight,
    this.onSwipeLeft,
    this.sensitivity = 1.0,
    this.minSwipeDistance = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Using onPanUpdate and onPanEnd for more reliable detection
      onHorizontalDragEnd: (details) {
        // Swiping right (back)
        if (details.primaryVelocity != null &&
            details.primaryVelocity! > sensitivity &&
            onSwipeRight != null) {
          onSwipeRight!();
        }
        // Swiping left (forward)
        else if (details.primaryVelocity != null &&
                details.primaryVelocity! < -sensitivity &&
                onSwipeLeft != null) {
          onSwipeLeft!();
        }
      },
      // Make sure the gesture detector doesn't interfere with other interactions
      behavior: HitTestBehavior.translucent,
      // Allow the child to receive touch events
      child: child,
    );
  }
}
