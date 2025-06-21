// lib/screens/center/center_appointments_screen.dart
import 'package:findlab/models/appointment_data.dart';
import 'package:findlab/screens/center/upgrade_pro_screen.dart';
import 'package:flutter/material.dart';
import 'package:findlab/models/fake_data.dart'; // Import the shared fake data
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'patient_profile_screen.dart'; // Import the new PatientProfileScreen

class CenterAppointmentsScreen extends StatefulWidget {
  final Function(int) onTabChange;

  const CenterAppointmentsScreen({super.key, required this.onTabChange});

  @override
  State<CenterAppointmentsScreen> createState() =>
      _CenterAppointmentsScreenState();
}

class _CenterAppointmentsScreenState extends State<CenterAppointmentsScreen> {
  List<Appointment> appointments = fakeAppointments;
  int currentPage = 1;
  final int itemsPerPage = 5; // Number of appointments per page
  String sortOption = 'plus récent'; // Default sort option

  // Helper method to format time to "09:00 AM" format
  String _formatTime(String time) {
    final parts = time.split(':');
    int hour = int.parse(parts[0]);
    final minute = parts[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    if (hour == 0) hour = 12;
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  // Sort appointments based on the selected option
  List<Appointment> _sortAppointments(List<Appointment> appointments) {
    if (sortOption == 'Newest') {
      return appointments;
    } else {
      return appointments.reversed.toList();
    }
  }

  // Get the appointments for the current page
  List<Appointment> _getPagedAppointments() {
    final sortedAppointments = _sortAppointments(appointments);
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    if (startIndex >= sortedAppointments.length) {
      return [];
    }
    return sortedAppointments.sublist(
      startIndex,
      endIndex > sortedAppointments.length
          ? sortedAppointments.length
          : endIndex,
    );
  }

  // Show the appointment details dialog
  void _showAppointmentDialog(Appointment appointment) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.all(0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: const Text(
                  'Détails des rendez-vous',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 20, 12, 70),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 16),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          content: SizedBox(
            width: 300.w,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Nom complet du patient',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 20, 12, 70),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    appointment.patientName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 20, 12, 70),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Test ${appointment.testName}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Algiers, Algeria',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color:
                              appointment.status == 'En attente'
                                  ? Colors.blue
                                  : appointment.status == 'Annulé'
                                  ? Colors.red
                                  : appointment.status == 'Confirmé'
                                  ? Colors.blue
                                  : Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Thu, Mar 28 at 08:00',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Text(
                        '3000 DZD',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 20, 12, 70),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (appointment.status == 'Terminé')
                    const Center(
                      child: Text(
                        'Le test a été effectué!',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  if (appointment.status == 'Annulé')
                    const Center(
                      child: Text(
                        'Le test a été annulé!',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          actions: [
            if (appointment.status == 'En attente') ...[
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      appointments =
                          appointments.map((a) {
                            if (a.id == appointment.id) {
                              return Appointment(
                                id: a.id,
                                patientName: a.patientName,
                                testName: a.testName,
                                date: a.date,
                                time: a.time,
                                status: 'Confirmé',
                              );
                            }
                            return a;
                          }).toList();
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 10.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Confirmer le rendez-vous',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      appointments =
                          appointments.map((a) {
                            if (a.id == appointment.id) {
                              return Appointment(
                                id: a.id,
                                patientName: a.patientName,
                                testName: a.testName,
                                date: a.date,
                                time: a.time,
                                status: 'Annulé',
                              );
                            }
                            return a;
                          }).toList();
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Annuler le rendez-vous',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
            if (appointment.status == 'Confirmé') ...[
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      appointments =
                          appointments.map((a) {
                            if (a.id == appointment.id) {
                              return Appointment(
                                id: a.id,
                                patientName: a.patientName,
                                testName: a.testName,
                                date: a.date,
                                time: a.time,
                                status: 'Terminé',
                              );
                            }
                            return a;
                          }).toList();
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(158, 223, 208, 1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Le test a été réalisé',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      appointments =
                          appointments.map((a) {
                            if (a.id == appointment.id) {
                              return Appointment(
                                id: a.id,
                                patientName: a.patientName,
                                testName: a.testName,
                                date: a.date,
                                time: a.time,
                                status: 'Annulé',
                              );
                            }
                            return a;
                          }).toList();
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Annuler le rendez-vous',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pagedAppointments = _getPagedAppointments();
    final totalPages = (appointments.length / itemsPerPage).ceil();

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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpgradeProScreen(),
                    ),
                  );
                },
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
                    horizontal: 12,
                    vertical: 5,
                  ),
                  child: const Text(
                    'Passer en PRO',
                    style: TextStyle(
                      color:
                          Colors
                              .white, // Change text color to white for better contrast
                      fontSize: 13,
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
                  vertical: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tous les rendez-vous',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        DropdownButton<String>(
                          value: sortOption,
                          items:
                              <String>[
                                'plus récent',
                                'plus ancien',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              sortOption = newValue!;
                              currentPage =
                                  1; // Reset to first page on sort change
                            });
                          },
                          underline: Container(),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: pagedAppointments.length,
                      itemBuilder: (context, index) {
                        final appointment = pagedAppointments[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color:
                                      appointment.status == 'En attente'
                                          ? Colors.red
                                          : appointment.status == 'Annulé'
                                          ? Colors.red
                                          : appointment.status == 'Confirmé'
                                          ? Colors.blue
                                          : Color.fromRGBO(158, 223, 208, 1),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // Navigate to PatientProfileScreen
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (
                                                              context,
                                                            ) => PatientProfileScreen(
                                                              patientName:
                                                                  appointment
                                                                      .patientName,
                                                              location:
                                                                  'Bab Ezzouar, Algiers',
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    appointment.patientName,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                        255,
                                                        20,
                                                        12,
                                                        70,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    appointment.testName,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  appointment.status ==
                                                          'En attente'
                                                      ? const Color.fromRGBO(
                                                        250,
                                                        225,
                                                        176,
                                                        1,
                                                      )
                                                      : appointment.status ==
                                                          'Annulé'
                                                      ? const Color.fromRGBO(
                                                        255,
                                                        197,
                                                        197,
                                                        1,
                                                      )
                                                      : appointment.status ==
                                                          'Confirmé'
                                                      ? const Color.fromRGBO(
                                                        172,
                                                        197,
                                                        236,
                                                        1,
                                                      )
                                                      : Color.fromRGBO(
                                                        158,
                                                        223,
                                                        208,
                                                        1,
                                                      ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              appointment.status == 'En attente'
                                                  ? 'Programmé'
                                                  : appointment.status,
                                              style: TextStyle(
                                                color:
                                                    appointment.status ==
                                                            'En attente'
                                                        ? const Color.fromRGBO(
                                                          254,
                                                          180,
                                                          44,
                                                          1,
                                                        )
                                                        : appointment.status ==
                                                            'Annulé'
                                                        ? const Color.fromRGBO(
                                                          225,
                                                          16,
                                                          16,
                                                          1,
                                                        )
                                                        : appointment.status ==
                                                            'Confirmé'
                                                        ? const Color.fromRGBO(
                                                          93,
                                                          138,
                                                          208,
                                                          1,
                                                        )
                                                        : Color.fromRGBO(
                                                          40,
                                                          157,
                                                          129,
                                                          1,
                                                        ),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'City',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    '${appointment.date} ${_formatTime(appointment.time)}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    // Show the appointment details dialog
                                    _showAppointmentDialog(appointment);
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    if (pagedAppointments.isNotEmpty)
                      Center(
                        child: ElevatedButton(
                          onPressed:
                              currentPage < totalPages
                                  ? () {
                                    setState(() {
                                      currentPage++;
                                    });
                                  }
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Page Suivante',
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
    );
  }
}
