import 'package:flutter/material.dart';

class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final SlideDirection direction;
  final Duration duration;

  SlidePageRoute({
    required this.child,
    this.direction = SlideDirection.rightToLeft,
    this.duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          settings: settings,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: _getSlideAnimation(animation, direction),
              child: child,
            );
          },
        );

  static Animation<Offset> _getSlideAnimation(
    Animation<double> animation,
    SlideDirection direction,
  ) {
    Offset begin;
    const Offset end = Offset.zero;

    switch (direction) {
      case SlideDirection.rightToLeft:
        begin = const Offset(1.0, 0.0);
        break;
      case SlideDirection.leftToRight:
        begin = const Offset(-1.0, 0.0);
        break;
      case SlideDirection.topToBottom:
        begin = const Offset(0.0, -1.0);
        break;
      case SlideDirection.bottomToTop:
        begin = const Offset(0.0, 1.0);
        break;
    }

    return Tween<Offset>(
      begin: begin,
      end: end,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(animation);
  }
}

enum SlideDirection {
  rightToLeft,
  leftToRight,
  topToBottom,
  bottomToTop,
}
