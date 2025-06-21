// lib/screens/clinic/clinic_appointments_screen.dart
import 'package:findlab/data/appointment_data.dart';
import 'package:flutter/material.dart';

class ClinicAppointmentsScreen extends StatelessWidget {
  const ClinicAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for now (replace with actual data from a backend)
    final appointments = [
      Appointment(
        testName: 'Test was done!',
        centerName: 'Patient Full Name',
        date: '2000',
        time: '',
        status: 'Terminé',
        location: 'Location',
      ),
      Appointment(
        testName: 'Test was cancelled!',
        centerName: 'Patient Full Name',
        date: '2000',
        time: '',
        status: 'Annulé',
        location: 'Location',
      ),
    ];

    return Scaffold(
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
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Appointments',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(appointment.centerName),
                        subtitle: Text(
                          '${appointment.testName} ${appointment.date}',
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color:
                                appointment.status == 'Terminé'
                                    ? Colors.green
                                    : Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            appointment.status,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          // Navigate to patient details screen (to be implemented)
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
