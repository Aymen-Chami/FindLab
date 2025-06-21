// lib/screens/center/appointments_settings_screen.dart
import 'package:flutter/material.dart';

class AppointmentsSettingsScreen extends StatefulWidget {
  const AppointmentsSettingsScreen({super.key});

  @override
  State<AppointmentsSettingsScreen> createState() =>
      _AppointmentsSettingsScreenState();
}

class _AppointmentsSettingsScreenState
    extends State<AppointmentsSettingsScreen> {
  final List<String> selectedTests = [];
  final List<String> selectedDays = [];
  String fromHour = '09:00';
  String toHour = '18:00';

  final List<String> availableTests = [
    'Analyse de sang',
    'IRM',
    'Échographie',
    'Radiographie',
    'ECG',
    'CT Scan',
  ];

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35.0),
        child: AppBar(
          title: Image.asset(
            'assets/images/Vector.png',
            height: 50,
            fit: BoxFit.contain,
            width: 135,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 1),
              child: ElevatedButton(
                style: ButtonStyle(
                  // Set the background color to transparent
                  backgroundColor: WidgetStateProperty.all(Colors.transparent),
                  // Remove the default elevation to avoid a shadow conflict with the gradient
                  elevation: WidgetStateProperty.all(0),
                  // Optional: Define the shape of the button (e.g., rounded corners)
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  // Optional: Add padding to match the design
                ),
                onPressed: () {},
                child: Container(
                  // Define the gradient for the button's background
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 62, 145, 227), // End color
                        Color.fromARGB(255, 26, 215, 200), // Start color
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(
                      10,
                    ), // Match the button's shape
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 6,
                  ),
                  child: const Text(
                    'Passer en PRO',
                    style: TextStyle(
                      color:
                          Colors
                              .white, // Change text color to white for better contrast
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.contact_support_outlined,
                color: Color.fromARGB(255, 67, 118, 199),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Paramètres des rendez-vous',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 20, 12, 70),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Sélectionner tous les tests',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          availableTests.map((test) {
                            final isSelected = selectedTests.contains(test);
                            return ChoiceChip(
                              label: Text(test),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedTests.add(test);
                                  } else {
                                    selectedTests.remove(test);
                                  }
                                });
                              },
                              selectedColor: Color.fromRGBO(67, 118, 198, 1),
                              labelStyle: TextStyle(
                                color:
                                    isSelected
                                        ? Colors.white
                                        : Color.fromRGBO(67, 118, 198, 1),
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Sélectionner les jours ouvrables',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          daysOfWeek.map((day) {
                            final isSelected = selectedDays.contains(day);
                            return ChoiceChip(
                              label: Text(day),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedDays.add(day);
                                  } else {
                                    selectedDays.remove(day);
                                  }
                                });
                              },
                              selectedColor: Color.fromRGBO(67, 118, 198, 1),
                              labelStyle: TextStyle(
                                color:
                                    isSelected
                                        ? Colors.white
                                        : Color.fromRGBO(67, 118, 198, 1),
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Sélectionner les heures de travail',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: fromHour,
                            items:
                                hours.map((hour) {
                                  return DropdownMenuItem<String>(
                                    value: hour,
                                    child: Text(hour),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                fromHour = value!;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'De',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: toHour,
                            items:
                                hours.map((hour) {
                                  return DropdownMenuItem<String>(
                                    value: hour,
                                    child: Text(hour),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                toHour = value!;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'A',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(67, 118, 198, 1),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Sauvegarder',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Reset or cancel logic here
                            setState(() {
                              selectedTests.clear();
                              selectedDays.clear();
                              fromHour = '09:00';
                              toHour = '18:00';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(
                              232,
                              240,
                              254,
                              1,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Annuler',
                            style: TextStyle(
                              color: Color.fromRGBO(67, 118, 198, 1),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
