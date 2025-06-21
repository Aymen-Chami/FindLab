import 'package:findlab/data/dummy_data.dart';
import 'package:findlab/screens/patient/test_search_screen.dart';
import 'package:findlab/widgets/chat_bot_bottom_sheet.dart';
import 'package:findlab/data/appointment_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _testNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 67, 118, 199),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 67, 118, 199),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _onSearchPressed() {
    if (_dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner une date.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => TestSearchScreen(
              testName: _testNameController.text,
              location: _locationController.text,
              date: _dateController.text,
            ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _testNameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 90.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ValueListenableBuilder<List<Appointment>>(
                      valueListenable: AppointmentData.appointmentsNotifier,
                      builder: (context, appointments, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/Maps.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'De quel test avez-vous besoin ?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Autocomplete<String>(
                              optionsBuilder: (
                                TextEditingValue textEditingValue,
                              ) {
                                final testNames =
                                    centersData
                                        .map(
                                          (center) =>
                                              center['testName'] as String,
                                        )
                                        .toSet()
                                        .toList();
                                if (textEditingValue.text.isEmpty) {
                                  return testNames;
                                }
                                return testNames.where((String option) {
                                  return option.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase(),
                                  );
                                });
                              },
                              optionsViewBuilder: (
                                context,
                                onSelected,
                                options,
                              ) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    color: Colors.white,
                                    elevation: 4.0,
                                    child: Container(
                                      height: 150, // Smaller height
                                      width:
                                          MediaQuery.of(context).size.width -
                                          40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: options.length,
                                        itemBuilder: (context, index) {
                                          final String option = options
                                              .elementAt(index);
                                          return ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 0,
                                                ),
                                            title: Text(
                                              option,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            onTap: () => onSelected(option),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                              fieldViewBuilder: (
                                context,
                                controller,
                                focusNode,
                                onEditingComplete,
                              ) {
                                _testNameController.text = controller.text;
                                return TextFormField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  onEditingComplete: onEditingComplete,
                                  onTapOutside: (event) {
                                    focusNode.unfocus();
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search, size: 35),
                                    labelText: "Nom du test",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                );
                              },
                              onSelected: (String selection) {
                                _testNameController.text = selection;
                              },
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Où?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Autocomplete<String>(
                              optionsBuilder: (
                                TextEditingValue textEditingValue,
                              ) {
                                final locations =
                                    centersData
                                        .map(
                                          (center) =>
                                              center['location'] as String,
                                        )
                                        .toSet()
                                        .toList();
                                if (textEditingValue.text.isEmpty) {
                                  return locations;
                                }
                                return locations.where((String option) {
                                  return option.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase(),
                                  );
                                });
                              },
                              optionsViewBuilder: (
                                context,
                                onSelected,
                                options,
                              ) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    color: Colors.white,
                                    elevation: 4.0,
                                    child: Container(
                                      height: 150, // Smaller height
                                      width:
                                          MediaQuery.of(context).size.width -
                                          40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: options.length,
                                        itemBuilder: (context, index) {
                                          final String option = options
                                              .elementAt(index);
                                          return ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 0,
                                                ),
                                            title: Text(
                                              option,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            onTap: () => onSelected(option),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                              fieldViewBuilder: (
                                context,
                                controller,
                                focusNode,
                                onEditingComplete,
                              ) {
                                _locationController.text = controller.text;
                                return TextFormField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  onEditingComplete: onEditingComplete,
                                  onTapOutside: (event) {
                                    focusNode.unfocus();
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Rechercher une localisation",
                                    prefixIcon: Icon(
                                      Icons.location_on_outlined,
                                      size: 28,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                );
                              },
                              onSelected: (String selection) {
                                _locationController.text = selection;
                              },
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              textAlign: TextAlign.left,
                              'Quand?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: _dateController,
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              decoration: InputDecoration(
                                labelText: "Choisissez une date",
                                prefixIcon: Icon(
                                  Icons.calendar_month_outlined,
                                  size: 28,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: _onSearchPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    67,
                                    118,
                                    199,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 70,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  "Recherche",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => const ChatBotBottomSheet(),
            );
          },
          backgroundColor: const Color.fromARGB(255, 218, 0, 0),
          child: const Icon(Icons.chat_bubble, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
