// lib/screens/client/center_schedule_screen.dart
import 'package:findlab/screens/center/tabs_screen_center.dart';
import 'package:flutter/material.dart';
import 'package:findlab/widgets/custom_animated_toggle_tab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import the shared widget

class CenterScheduleScreen extends StatefulWidget {
  const CenterScheduleScreen({super.key});

  @override
  State<CenterScheduleScreen> createState() => _CenterScheduleScreenState();
}

class _CenterScheduleScreenState extends State<CenterScheduleScreen> {
  bool isPatient = false;
  int selectedIndex = 1;
  final List<String> selectedDays = [];
  String? workingHoursFrom = '08:00';
  String? workingHoursTo = '18:00';

  final List<String> daysOfWeek = [
    'Dimanche',
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
  ];

  final List<String> hours = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35.0),
        child: AppBar(
          title: Image.asset(
            'assets/images/Vector.png',
            height: 40,
            fit: BoxFit.contain,
            width: 150,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 120.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Créez un compte !",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 20, 12, 70),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Veuillez remplir les informations ci-dessous pour créer un compte.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 101, 100, 100),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomAnimatedToggleTab(
                    callback: (int index) {
                      setState(() {
                        selectedIndex = index;
                        isPatient = index == 0;
                      });
                    },
                    tabTexts: const ['Patient', 'Centre'],
                    width: 200.w,
                    height: 40.h,
                    initialIndex: selectedIndex,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sélectionnez les jours de travail',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children:
                              daysOfWeek.map((day) {
                                final isSelected = selectedDays.contains(day);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedDays.remove(day);
                                      } else {
                                        selectedDays.add(day);
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? const Color.fromARGB(
                                                255,
                                                67,
                                                118,
                                                199,
                                              )
                                              : Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                          255,
                                          67,
                                          118,
                                          199,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      day,
                                      style: TextStyle(
                                        color:
                                            isSelected
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                  255,
                                                  67,
                                                  118,
                                                  199,
                                                ),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Sélectionnez les heures de travail',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'De',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  DropdownButtonFormField<String>(
                                    value: workingHoursFrom,
                                    items:
                                        hours.map((hour) {
                                          return DropdownMenuItem<String>(
                                            value: hour,
                                            child: Text(hour),
                                          );
                                        }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        workingHoursFrom = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'A',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  DropdownButtonFormField<String>(
                                    value: workingHoursTo,
                                    items:
                                        hours.map((hour) {
                                          return DropdownMenuItem<String>(
                                            value: hour,
                                            child: Text(hour),
                                          );
                                        }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        workingHoursTo = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const TabsScreenCenter(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                67,
                                118,
                                199,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 100.w,
                                vertical: 8.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              "S'inscrire",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
