// lib/models/appointment.dart
class Appointment {
  final String id;
  final String patientName;
  final String testName;
  final String date;
  final String time;
  final String status; // "Pending", "Confirmed", "Cancelled"

  Appointment({
    required this.id,
    required this.patientName,
    required this.testName,
    required this.date,
    required this.time,
    required this.status,
  });
}
