import 'package:flutter/material.dart';
import 'dart:math';

class BMITrackerPage extends StatelessWidget {
  final double bmi;

  const BMITrackerPage({super.key, required this.bmi});

  static const Color textColor = Color(0xFF0F172A);

  // Segment colors
  static const Color red = Color(0xFFFABBBD);
  static const Color yellow = Color(0xFFFFF08C);
  static const Color green = Color(0xFFCBEAC8);

  String getBmiStatus() {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal weight";
    if (bmi < 30) return "Overweight";
    return "Obese";
  }

  double getIndicatorPosition(double width) {
    // Clamp BMI between 15 - 35 for visualization
    double clamped = bmi.clamp(15, 35);
    return ((clamped - 15) / (35 - 15)) * width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              const Text(
                "Your BMI",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),

              const SizedBox(height: 40),

              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  final position = getIndicatorPosition(width);

                  return Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Container(height: 20, color: red)),
                          Expanded(child: Container(height: 20, color: yellow)),
                          Expanded(child: Container(height: 20, color: green)),
                          Expanded(child: Container(height: 20, color: yellow)),
                          Expanded(child: Container(height: 20, color: red)),
                        ],
                      ),
                      Positioned(
                        left: max(0, position - 2),
                        child: Container(
                          width: 4,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 30),

              Text(
                bmi.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                getBmiStatus(),
                style: const TextStyle(
                  fontSize: 18,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "BMI is a measure of body fat based on height and weight.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
