import 'package:flutter/material.dart';
import 'bmi_tracker_page.dart';

class CalorieTrackerPage extends StatefulWidget {
  final int dailyCalorieGoal;

  const CalorieTrackerPage({
    super.key,
    required this.dailyCalorieGoal,
  });

  @override
  State<CalorieTrackerPage> createState() => _CalorieTrackerPageState();
}

class _CalorieTrackerPageState extends State<CalorieTrackerPage> {
  static const Color textColor = Color(0xFF0F172A);
  static const Color backgroundColor = Color(0xFFF0F9FF);
  static const Color buttonColor = Color(0xFF6CA1CE);

  int consumedCalories = 0;
  List<int> history = [];

  int selectedTab = 0;

  void addCalories(int calories) {
    setState(() {
      consumedCalories += calories;
      history.add(calories);
    });
  }

  void showAddCaloriesDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Calories'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter calories',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final int value = int.tryParse(controller.text) ?? 0;
                if (value > 0) {
                  addCalories(value);
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // 📊 CALORIE VIEW
  Widget calorieTrackerView() {
    double progress = consumedCalories / widget.dailyCalorieGoal;
    if (progress > 1) progress = 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        const Text(
          'Daily Calories',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),

        const SizedBox(height: 20),

        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white,
          color: buttonColor,
          minHeight: 12,
        ),

        const SizedBox(height: 10),

        Text(
          '$consumedCalories / ${widget.dailyCalorieGoal} kcal',
          style: const TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: Colors.white,
            ),
            onPressed: showAddCaloriesDialog,
            child: const Text('Add Calories'),
          ),
        ),

        const SizedBox(height: 30),

        const Text(
          'History',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),

        const SizedBox(height: 10),

        Expanded(
          child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '+ ${history[index]} kcal',
                  style: const TextStyle(color: textColor),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // 🧠 BMI TAB (REAL)
  Widget bmiView() {
    return BMITrackerPage(
      bmi: _calculateBMI(),
    );
  }

  // ⚙️ TEMP BMI CALC (later vervangen met echte user data)
  double _calculateBMI() {
    double weight = 75; // kg (placeholder)
    double height = 1.75; // meters (placeholder)

    return weight / (height * height);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: selectedTab == 0 ? calorieTrackerView() : bmiView(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        selectedItemColor: buttonColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: 'Calories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight),
            label: 'BMI',
          ),
        ],
      ),
    );
  }
}