// appointment_data.dart
import 'package:flutter/foundation.dart';

class Appointment {
  final String testName;
  final String centerName;
  final String location;
  final String date;
  final String time;
  final String status;

  Appointment({
    required this.testName,
    required this.centerName,
    required this.location,
    required this.date,
    required this.time,
    required this.status,
  });

  Map<String, String> toJson() {
    return {
      'testName': testName,
      'centerName': centerName,
      'date': date,
      'time': time,
      'status': status,
    };
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      testName: json['testName'],
      centerName: json['centerName'],
      location: json['location'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
    );
  }
}

class AppointmentData {
  static final ValueNotifier<List<Appointment>> appointmentsNotifier =
      ValueNotifier<List<Appointment>>([]);

  static List<Appointment> get appointments => appointmentsNotifier.value;

  static void addAppointment(Appointment appointment) {
    appointmentsNotifier.value = [...appointmentsNotifier.value, appointment];
  }

  static void clearAppointments() {
    appointmentsNotifier.value = [];
  }

  static List<String> getTestNameSuggestions() {
    return appointments
        .map((appointment) => appointment.testName)
        .toSet()
        .toList();
  }

  static List<String> getCenterNameSuggestions() {
    return appointments
        .map((appointment) => appointment.centerName)
        .toSet()
        .toList();
  }

  // In appointment_data.dart or main.dart
}

void initializeSampleAppointments() {
  AppointmentData.addAppointment(
    Appointment(
      testName: "Blood Test",
      centerName: "MediCare Diagnostic Center",
      location: "123 Health St, Cityville",
      date: "2025-04-21",
      time: "10:00",
      status: "Programmé",
    ),
  );
  AppointmentData.addAppointment(
    Appointment(
      testName: "X-Ray",
      centerName: "City Health Clinic",
      location: "456 Wellness Ave, Townsville",
      date: "2025-04-22",
      time: "14:00",
      status: "En attente",
    ),
  );
  AppointmentData.addAppointment(
    Appointment(
      testName: "MRI Scan",
      centerName: "Advanced Medical Center",
      location: "789 Care Blvd, Villagetown",
      date: "2025-04-23",
      time: "09:00",
      status: "Programmé",
    ),
  );
}
