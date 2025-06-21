// book_appointment_dialog.dart
import 'package:findlab/widgets/apointment_confirmed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BookAppointmentDialog extends StatefulWidget {
  final String testName;
  final String centerName;
  final String location;
  final String price;

  const BookAppointmentDialog({
    super.key,
    required this.testName,
    required this.centerName,
    required this.location,
    required this.price,
  });

  @override
  State<BookAppointmentDialog> createState() => _BookAppointmentDialogState();
}

class _BookAppointmentDialogState extends State<BookAppointmentDialog> {
  int _selectedDateIndex = 0;
  int? _selectedTimeIndex; // Change to store the index instead of the time
  bool _showMoreTimes = false;
  bool _showErrorMessage = false; // Flag to control error message visibility
  DateTime _baseDate = DateTime.now();

  // List of dates (dynamically generated based on the selected date)
  List<Map<String, String>> _dates = [];

  // List of time slots (initially show 5, more on "More" button press)
  final List<String> timeSlots = [
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
  ];

  @override
  void initState() {
    super.initState();
    _updateDates(_baseDate);
  }

  // Update the dates list based on the selected base date
  void _updateDates(DateTime baseDate) {
    _dates = List.generate(5, (index) {
      final date = baseDate.add(Duration(days: index));
      return {
        'day': DateFormat('E').format(date), // e.g., "Thu"
        'date': DateFormat('MMM d').format(date), // e.g., "Mar 28"
      };
    });
  }

  // Format the date range for display (e.g., "Fri, Mar 28th-Tue, Apr 1st")
  String _getDateRange() {
    final startDate = _baseDate;
    final endDate = _baseDate.add(const Duration(days: 4));
    return '${DateFormat('E, MMM d').format(startDate)}th-${DateFormat('E, MMM d').format(endDate)}st';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white, // Background color as previously set
      child: Container(
        padding: EdgeInsets.all(10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with centered "Book an appointment" and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text(
                    'Prendre un rendez-vous',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
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
            // Test Name
            Text(
              widget.testName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            // Center Name
            Text(
              widget.centerName,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            // Location
            Text(
              widget.location,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            // Price
            Text(
              widget.price,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Date Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_dates[_selectedDateIndex]['day']}, ${_dates[_selectedDateIndex]['date']} en',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    _getDateRange(),
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ),

                Expanded(
                  child: IconButton(
                    icon: const Icon(Icons.calendar_today, size: 20),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _baseDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null && picked != _baseDate) {
                        setState(() {
                          _baseDate = picked;
                          _updateDates(picked);
                          _selectedDateIndex = 0; // Reset to the first date
                          _selectedTimeIndex = null; // Reset selected time
                          _showErrorMessage = false; // Reset error message
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _dates.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedDateIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDateIndex = index;
                        _selectedTimeIndex =
                            null; // Reset selected time when date changes
                        _showErrorMessage = false; // Reset error message
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? Color.fromARGB(255, 67, 118, 199)
                                : Color.fromARGB(255, 233, 241, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _dates[index]['day']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.black : Colors.grey,
                            ),
                          ),
                          Text(
                            _dates[index]['date']!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.black : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Time Slots
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2,
              ),
              itemCount:
                  _showMoreTimes
                      ? timeSlots.length + 1
                      : 5 + 1, // +1 for the "More" button
              itemBuilder: (context, index) {
                if (index == (_showMoreTimes ? timeSlots.length : 5)) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _showMoreTimes = !_showMoreTimes;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Plus',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ),
                  );
                }
                final time = timeSlots[index];
                final isSelected =
                    _selectedTimeIndex ==
                    index; // Compare index instead of time
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTimeIndex =
                          index; // Store the index of the selected time
                      _showErrorMessage =
                          false; // Reset error message when a time is selected
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Color.fromARGB(255, 67, 118, 199)
                              : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Confirm Appointment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedTimeIndex == null) {
                    setState(() {
                      _showErrorMessage = true;
                    });
                  } else {
                    // Use the selected time based on the index
                    final selectedTime = timeSlots[_selectedTimeIndex!];
                    // Show the appointment confirmed popup
                    showDialog(
                      context: context,
                      builder:
                          (context) => AppointmentConfirmedDialog(
                            testName: widget.testName,
                            centerName: widget.centerName,
                            location: widget.location,
                            date:
                                '${_dates[_selectedDateIndex]['day']}, ${_dates[_selectedDateIndex]['date']}',
                            time: selectedTime,
                            price: widget.price,
                          ),
                    ).then((_) {
                      // Close the BookAppointmentDialog after the confirmation dialog is dismissed
                      Navigator.of(context).pop();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 67, 118, 199),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Confirmer le rendez-vous',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            if (_showErrorMessage)
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Veuillez choisir l'heure avant de confirmer",
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
