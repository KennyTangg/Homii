import 'package:flutter/material.dart';
import 'sign_in_screen.dart';
import '../user_preferences/intro_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  Widget _buildSocialButton({
    required VoidCallback onPressed,
    required String iconPath,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            height: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E9), // Cream background for the top part
      body: Column(
        children: [
          // Food illustrations at top - outside SafeArea to extend to status bar
          Expanded(
            flex: 1,
            child: Image.asset(
              'assets/images/food_corner.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // White container with rounded top corners
          Expanded(
            flex: 5, // Make this larger to ensure it takes most of the screen
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello there!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Let\'s get started by entering your name, email address and creating a strong password.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Name field
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF8F3E9),
                        hintText: 'Name',
                        hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
                        prefixIcon: const Icon(Icons.person_outline, color: Colors.black54, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      style: const TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    const SizedBox(height: 12),

                    // Email field
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF8F3E9),
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
                        prefixIcon: const Icon(Icons.email_outlined, color: Colors.black54, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      style: const TextStyle(color: Colors.black87, fontSize: 14),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),

                    // Password field
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF8F3E9),
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.black54, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      style: const TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    const SizedBox(height: 12),

                    // Confirm Password field
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF8F3E9),
                        hintText: 'Confirm Password',
                        hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.black54, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      style: const TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // OR CONTINUE WITH divider
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR CONTINUE WITH',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Social sign-in buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          onPressed: () {},
                          iconPath: 'assets/images/google_icon.png',
                        ),
                        const SizedBox(width: 16),
                        _buildSocialButton(
                          onPressed: () {},
                          iconPath: 'assets/images/facebook_icon.png',
                        ),
                        const SizedBox(width: 16),
                        _buildSocialButton(
                          onPressed: () {},
                          iconPath: 'assets/images/apple_icon.png',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Sign in text
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(color: Colors.black54, fontSize: 13),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignInScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Sign up button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const IntroScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
