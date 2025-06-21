// center_details_screen.dart
import 'package:findlab/widgets/book_appointment_dialog.dart';
import 'package:flutter/material.dart';

class CenterPage extends StatelessWidget {
  final String name;
  final String location;
  final String about;
  final String distance;

  const CenterPage({
    super.key,
    required this.name,
    required this.location,
    required this.about,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(49.0),
        child: AppBar(
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(2.0),
            child: Divider(color: Colors.black, thickness: 0.9),
          ),
          title: Image.asset(
            'assets/images/Vector.png',
            height: 50,
            fit: BoxFit.contain,
            width: 135,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.contact_support_outlined,
                color: Color.fromARGB(255, 67, 118, 199),
              ),
              onPressed: () {},
            ),
          ],
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
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white, // Ensure the background is white
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/icons/C_icon.png'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              location,
                              style: const TextStyle(fontSize: 13),
                            ),
                            Text(
                              distance,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'A propos de nous',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    about,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Map et Directions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/Maps.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 190,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Horaires du centre',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHoursBox('Sun: 09:00 - 18:00'),
                            const SizedBox(height: 10),
                            _buildHoursBox('Wed: 09:00 - 18:00'),
                            const SizedBox(height: 10),
                            _buildHoursBox('Sat: 08:00 - 18:00'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHoursBox('Mon: 09:00 - 18:00'),
                            const SizedBox(height: 10),
                            _buildHoursBox('Thu: 09:00 - 18:00'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHoursBox('Tue: 08:00 - 18:00'),
                            const SizedBox(height: 10),
                            _buildHoursBox('Fri: 09:00 - 18:00'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => BookAppointmentDialog(
                                testName:
                                    'Nom complet du test', // Replace with actual test name
                                centerName: name,
                                location: location,
                                price: '3000 DZD', // Replace with actual price
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
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Voir plus de détails sur le rendez-vous',
                        style: TextStyle(fontSize: 16, color: Colors.white),
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

  // Helper method to build a box around each day's hours
  Widget _buildHoursBox(String hours) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(
          255,
          233,
          241,
          255,
        ), // Light gray background to match the screenshot
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: Text(
        hours,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
      ),
    );
  }
}
