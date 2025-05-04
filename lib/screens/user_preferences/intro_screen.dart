import 'package:flutter/material.dart';

import 'goals_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Let's get to know your eating habits.",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.secondary,
                height: 1.2,// Orange color
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Container(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute(builder: (context) => GoalsScreen()) 
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ],
      ),
    );
  }
}