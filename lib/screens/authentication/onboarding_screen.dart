import 'package:flutter/material.dart';
import 'sign_in_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background as shown in the image
      body: Stack(
        children: [
          // Food illustrations
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/food_illustrations.png',
              fit: BoxFit.contain,
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Logo centered
                  Center(
                    child: Image.asset(
                      'assets/images/homii_icon.png',
                      height: 30,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Main heading
                  Center(
                    child: Text(
                      'Home-cooking\nmade simple.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
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
                        color: Theme.of(context).colorScheme.outline,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Get started button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

