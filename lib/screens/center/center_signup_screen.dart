// lib/screens/client/center_signup_screen.dart
import 'package:flutter/material.dart';
import 'package:findlab/screens/center/center_schedule_screen.dart';
import 'package:findlab/widgets/custom_animated_toggle_tab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import the shared widget

class CenterSignupScreen extends StatefulWidget {
  const CenterSignupScreen({super.key});

  @override
  State<CenterSignupScreen> createState() => _CenterSignupScreenState();
}

class _CenterSignupScreenState extends State<CenterSignupScreen> {
  bool isPatient = false;
  int selectedIndex = 1;
  final _formKey = GlobalKey<FormState>();
  final List<String> selectedTests = [];

  // Mock list of test names (replace with actual test names if available)
  final List<String> testNames = [
    'Analyse de sang',
    'Radiographie',
    'IRM',
    'Échographie',
    'CT Scan',
    'ECG',
    'Bilan lipidique',
    'Test de la thyroïde',
    'Test de glycémie',
    'Fonction hépatique',
    'Fonction rénale',
    'Test de vitamine D',
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
            height: 40.h,
            fit: BoxFit.contain,
            width: 150.w,
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
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 150.h),
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
                    "Veuillez remplir les informations ci-dessous pour créer un compte.",
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
                    width: 200,
                    height: 40,
                    initialIndex: selectedIndex,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 20,
                      right: 20,
                      bottom: 30,
                    ),
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Sélectionnez tous les tests',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Color.fromARGB(255, 20, 12, 70),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                GridView.builder(
                                  padding: const EdgeInsets.only(
                                    top: 0,
                                  ), // Remove any top padding
                                  itemCount: testNames.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 13,
                                        mainAxisSpacing: 13,
                                        childAspectRatio: 2,
                                      ),
                                  itemBuilder: (context, index) {
                                    final testName = testNames[index];
                                    final isSelected = selectedTests.contains(
                                      testName,
                                    );
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            selectedTests.remove(testName);
                                          } else {
                                            selectedTests.add(testName);
                                          }
                                        });
                                      },
                                      child: Container(
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
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            testName,
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
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            const CenterScheduleScreen(),
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
                                  horizontal: 100.h,
                                  vertical: 8.w,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "Suivant",
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
