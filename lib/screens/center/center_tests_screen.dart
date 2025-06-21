// lib/screens/client/center_tests_screen.dart
import 'package:findlab/screens/center/center_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';
// Import the next screen

class CenterTestsScreen extends StatefulWidget {
  const CenterTestsScreen({super.key});

  @override
  State<CenterTestsScreen> createState() => _CenterTestsScreenState();
}

class _CenterTestsScreenState extends State<CenterTestsScreen> {
  bool isPatient = false;
  int selectedIndex = 1;
  final List<String> selectedTests = [];

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
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 150,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Create an account !",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 20, 12, 70),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 101, 100, 100),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppinioAnimatedToggleTab(
                    callback: (int index) {
                      setState(() {
                        selectedIndex = index;
                        isPatient = index == 0;
                      });
                    },
                    tabTexts: const ['Patient', 'Center'],
                    height: 40,
                    boxDecoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 255, 255),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    animatedBoxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 67, 118, 199),
                          spreadRadius: 1,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    activeStyle: const TextStyle(color: Colors.white),
                    inactiveStyle: const TextStyle(
                      color: Color.fromARGB(255, 114, 153, 214),
                    ),
                    width: 200,
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
                          'Select all the tests',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 2,
                              ),
                          itemCount: 12, // Mock 12 tests
                          itemBuilder: (context, index) {
                            const testName = 'Test 01'; // Mock test name
                            final isSelected = selectedTests.contains(testName);
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    testName,
                                    style: TextStyle(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const CenterScheduleScreen(),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 130,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              "Next",
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
