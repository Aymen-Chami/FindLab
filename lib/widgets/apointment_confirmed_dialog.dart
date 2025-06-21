// appointment_confirmed_dialog.dart
import 'package:findlab/data/appointment_data.dart';
import 'package:findlab/widgets/book_appointment_dialog.dart';
import 'package:findlab/screens/patient/appointments_screen.dart';
import 'package:flutter/material.dart';

class AppointmentConfirmedDialog extends StatelessWidget {
  final String testName;
  final String centerName;
  final String location;
  final String date;
  final String time;
  final String price;

  const AppointmentConfirmedDialog({
    super.key,
    required this.testName,
    required this.centerName,
    required this.location,
    required this.date,
    required this.time,
    required this.price,
  });

  // Method to handle adding the appointment and navigating to AppointmentsScreen
  void _handleViewAppointments(BuildContext context) {
    // Add the appointment to the list
    AppointmentData.addAppointment(
      Appointment(
        testName: testName,
        location: location,
        centerName: centerName,
        date: '$date 2025',
        time: time,
        status: 'Scheduled',
      ),
    );
    // Debug print to confirm the appointment is added
    print(
      'Appointment added: ${AppointmentData.appointments.last.testName}, '
      '${AppointmentData.appointments.last.date}, '
      '${AppointmentData.appointments.last.time}',
    );
    print('Total appointments: ${AppointmentData.appointments.length}');
    // Navigate to the AppointmentsScreen
    Navigator.of(context).pop(); // Close the confirmation dialog
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AppointmentsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  textAlign: TextAlign.center,
                  'Rendez-vous confirmé!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              testName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              centerName,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              location,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              '$date at $time',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              price,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Reopen the BookAppointmentDialog for editing
                    showDialog(
                      context: context,
                      builder:
                          (context) => BookAppointmentDialog(
                            testName: testName,
                            centerName: centerName,
                            location: location,
                            price: price,
                          ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    'Modifier mon rendez-vous',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _handleViewAppointments(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 67, 118, 199),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    'voir mon rendez-vous',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Add the "View More Appointments" button
          ],
        ),
      ),
    );
  }
}
