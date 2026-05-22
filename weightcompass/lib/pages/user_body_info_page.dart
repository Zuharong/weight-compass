import 'package:flutter/material.dart';
import 'calorie_tracker_page.dart';

class UserBodyInfoPage extends StatefulWidget {
  const UserBodyInfoPage({super.key});

  @override
  State<UserBodyInfoPage> createState() => _UserBodyInfoPageState();
}

class _UserBodyInfoPageState extends State<UserBodyInfoPage> {
  static const Color textColor = Color(0xFF0F172A);
  static const Color backgroundColor = Color(0xFFF0F9FF);
  static const Color buttonColor = Color(0xFF6CA1CE);

  String? gender;
  DateTime? birthDate;

  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  bool get isFormValid {
    return gender != null &&
        birthDate != null &&
        heightController.text.isNotEmpty &&
        weightController.text.isNotEmpty;
  }

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        birthDate = picked;
      });
    }
  }

  Widget genderButton(String value, String label) {
    final bool isSelected = gender == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            gender = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? buttonColor : Colors.transparent,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField({
    required String hint,
    required TextEditingController controller,
    TextInputType type = TextInputType.number,
  }) {
    return TextField(
      controller: controller,
      keyboardType: type,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tell us about yourself',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Gender',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  genderButton('male', 'Male'),
                  genderButton('female', 'Female'),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                'Date of Birth',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: pickDate,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    birthDate == null
                        ? 'Select your birth date'
                        : '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}',
                    style: const TextStyle(color: textColor),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Height (cm)',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
              const SizedBox(height: 10),

              inputField(
                hint: 'Enter your height',
                controller: heightController,
              ),

              const SizedBox(height: 20),

              const Text(
                'Weight (kg)',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
              const SizedBox(height: 10),

              inputField(
                hint: 'Enter your weight',
                controller: weightController,
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFormValid ? buttonColor : Colors.grey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: isFormValid
                    ? () {
                        int age = DateTime.now().year - birthDate!.year;

                        double bmr;

                        if (gender == 'male') {
                          bmr = 10 * double.parse(weightController.text) +
                              6.25 * double.parse(heightController.text) -
                              5 * age +
                              5;
                        } else {
                          bmr = 10 * double.parse(weightController.text) +
                              6.25 * double.parse(heightController.text) -
                              5 * age -
                              161;
                        }

                        // simpele multiplier (later uitbreiden met goal)
                        double tdee = bmr * 1.4;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalorieTrackerPage(
                              dailyCalorieGoal: tdee.round(),
                            ),
                          ),
                        );
                      }
                    : null,
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}