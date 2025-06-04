import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  _navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'HOMII',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.secondary,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Main heading
              Center(
                child: Text(
                  'Home-cooking\nmade simple.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                    height: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Description text - centered as shown in the image
              Center(
                child: Text(
                  'Homii turns your kitchen into a smart, comforting space where great meals start with what you already have-and anything you\'re missing shows up at your doorstep!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.outline,
                    height: 1.5,
                  ),
                ),
              ),

              const Spacer(),

              // Food illustrations and Continue button
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Food illustrations
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        // Carrot on the left
                        Positioned(
                          left: 0,
                          bottom: 80,
                          child: Container(
                            width: 50,
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDF6730), // Orange carrot color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 20,
                                  color: const Color(0xFF457942), // Green carrot top
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Shrimp on the right
                        Positioned(
                          right: 20,
                          bottom: 150,
                          child: Transform.rotate(
                            angle: 0.2,
                            child: Container(
                              width: 100,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xFFDF6730), // Orange shrimp color
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),

                        // Lemon/lime slice at the bottom
                        Positioned(
                          right: 80,
                          bottom: 40,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD724), // Yellow color from the image
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: const Color(0xFF457942), // Green border
                                width: 3,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: colorScheme.onPrimary,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: Center(
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFD724),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Green dots
                        Positioned(
                          left: 100,
                          bottom: 120,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFF457942),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),

                        Positioned(
                          right: 60,
                          bottom: 100,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: const Color(0xFF457942),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),

                        // Pink circle
                        Positioned(
                          left: 20,
                          bottom: 30,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6B8E2), // Pink color from the image
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),

                        // Small orange dots
                        Positioned(
                          right: 40,
                          top: 20,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDF6730),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),

                        Positioned(
                          left: 60,
                          bottom: 180,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDF6730),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Continue button
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        minimumSize: const Size(double.infinity, 56),
                        elevation: 0, // No shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





