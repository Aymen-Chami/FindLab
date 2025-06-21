// lib/screens/center/center_home_screen.dart
import 'package:findlab/models/appointment_data.dart';
import 'package:findlab/screens/center/upgrade_pro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenterHomeScreen extends StatefulWidget {
  final Function(int) onTabChange;

  const CenterHomeScreen({super.key, required this.onTabChange});

  @override
  State<CenterHomeScreen> createState() => _CenterHomeScreenState();
}

class _CenterHomeScreenState extends State<CenterHomeScreen> {
  List<Appointment> appointments = fakeAppointments;
  String _selectedPeriod = 'Monthly';

  void _showAppointmentDialog(Appointment appointment) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'détails du rendez-vous',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 20, 12, 70),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Patient Full Name',
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
              Text(
                'Algiers, Algeria',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                              ? const Color.fromRGBO(254, 180, 44, 1)
                              : appointment.status == 'Annulé'
                              ? const Color.fromRGBO(225, 16, 16, 1)
                              : appointment.status == 'Confirmé'
                              ? const Color.fromRGBO(93, 138, 208, 1)
                              : Color.fromRGBO(40, 157, 129, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Thu, Mar 28 at 08:00',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
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
                    'Le test a été fait!',
                    style: TextStyle(
                      fontSize: 18,
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
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'confirmer le rendez-vous',
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
                    'annuler le rendez-vous',
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
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Test effectué',
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

  // Helper method to format time to "09:00 AM" format
  String _formatTime(String time) {
    final parts = time.split(':');
    int hour = int.parse(parts[0]);
    final minute = parts[1];
    final period = hour >= 12 ? '' : '';
    hour = hour % 12;
    if (hour == 0) hour = 12;
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

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
                    fit: BoxFit.cover,
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
                    // Appointments Section
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rendez-vous',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 20, 12, 70),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3, // Show only 3 appointments
                            itemBuilder: (context, index) {
                              final appointment = appointments[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 10,
                                        color:
                                            appointment.status == 'En attente'
                                                ? Colors.red
                                                : appointment.status == 'Annulé'
                                                ? Colors.red
                                                : appointment.status ==
                                                    'Confirmé'
                                                ? Colors.blue
                                                : Colors.green,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Text(
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
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          appointment.testName,
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
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
                                                            : appointment
                                                                    .status ==
                                                                'Annulé'
                                                            ? const Color.fromRGBO(
                                                              255,
                                                              197,
                                                              197,
                                                              1,
                                                            )
                                                            : appointment
                                                                    .status ==
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
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    appointment.status ==
                                                            'En attente'
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
                                                              : appointment
                                                                      .status ==
                                                                  'Annulé'
                                                              ? const Color.fromRGBO(
                                                                225,
                                                                16,
                                                                16,
                                                                1,
                                                              )
                                                              : appointment
                                                                      .status ==
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ), // Space for alignment
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          _showAppointmentDialog(appointment);
                                        },
                                        child: const Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 16,
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
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Switch to the Appointments tab (index 1)
                                widget.onTabChange(1);
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
                                'Voir plus',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Patients Bookings Section
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Réservations des patients',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),

                              SizedBox(width: 10.w),
                              Expanded(
                                child: DropdownButton<String>(
                                  value: _selectedPeriod,
                                  icon: const Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: Colors.black,
                                  ),
                                  underline:
                                      const SizedBox(), // Removes the default underline
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedPeriod = newValue!;
                                    });
                                  },
                                  items:
                                      <String>[
                                        'Monthly',
                                        'Weekly',
                                        'Daily',
                                      ].map<DropdownMenuItem<String>>((
                                        String value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 360),
                          Image.asset('assets/images/chart.png'),
                        ],
                      ),
                    ),

                    // Calendar Section
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 220.w),
                            child: Text(
                              'Calendrier',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 20, 12, 70),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 16,
                                  color: Colors.blue,
                                ),
                                onPressed: () {},
                              ),
                              const Text(
                                'Octobre',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 20, 12, 70),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.blue,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Mon',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Tue',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Wed',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Thu',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Fri',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Sat',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Sun',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

// Fake appointments data
final List<Appointment> fakeAppointments = [
  Appointment(
    id: '1',
    patientName: 'Patient ',
    testName: 'Cholesterol Test',
    date: 'Tue Mar 28',
    time: '10:30',
    status: 'En attente',
  ),
  Appointment(
    id: '2',
    patientName: 'Patient ',
    testName: 'Endoscopy',
    date: 'Tue Mar 28',
    time: '10:30',
    status: 'Annulé',
  ),
  Appointment(
    id: '3',
    patientName: 'Patient ',
    testName: 'Mammogram',
    date: 'Tue Mar 28',
    time: '09:00',
    status: 'Confirmé',
  ),
  Appointment(
    id: '4',
    patientName: 'Patient',
    testName: 'CT Scan',
    date: 'Tue Mar 28',
    time: '10:30',
    status: 'Terminé',
  ),
];
