import 'package:findlab/data/dummy_data.dart';
import 'package:findlab/widgets/build_card.dart';
import 'package:findlab/data/appointment_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestSearchScreen extends StatefulWidget {
  final String? testName;
  final String? location;
  final String? date;

  const TestSearchScreen({super.key, this.testName, this.location, this.date});

  @override
  State<TestSearchScreen> createState() => _TestSearchScreenState();
}

class _TestSearchScreenState extends State<TestSearchScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final TextEditingController _testNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final int clinicsPerPage = 3;

  int get totalPages {
    final filteredCenters = _getFilteredCenters();
    return (filteredCenters.length / clinicsPerPage).ceil();
  }

  List<Map<String, dynamic>> _getFilteredCenters() {
    List<Map<String, dynamic>> filteredCenters = centersData;
    if (_testNameController.text.isNotEmpty) {
      filteredCenters =
          filteredCenters.where((center) {
            final testName = center['testName']?.toString() ?? '';
            return testName.toLowerCase() ==
                _testNameController.text.toLowerCase();
          }).toList();
    }
    if (_locationController.text.isNotEmpty) {
      filteredCenters =
          filteredCenters.where((center) {
            final location = center['location']?.toString() ?? '';
            return location.toLowerCase() ==
                _locationController.text.toLowerCase();
          }).toList();
    }
    return filteredCenters;
  }

  void _nextPage() {
    if (_currentPage < totalPages - 1) {
      setState(() {
        _currentPage++;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _testNameController.text = widget.testName ?? '';
    _locationController.text = widget.location ?? '';
  }

  @override
  void dispose() {
    _pageController.dispose();
    _testNameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

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
            padding: EdgeInsets.symmetric(vertical: 75.h),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: ValueListenableBuilder<List<Appointment>>(
                    valueListenable: AppointmentData.appointmentsNotifier,
                    builder: (context, appointments, _) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40.h,
                              child: Autocomplete<String>(
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
                                        height: 150,
                                        width:
                                            MediaQuery.of(context).size.width -
                                            40,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
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
                                    onChanged: (value) {
                                      setState(() {
                                        _testNameController.text = value;
                                      });
                                    },
                                    onTapOutside: (event) {
                                      focusNode.unfocus();
                                    },
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(fontSize: 14),
                                      prefixIcon: Icon(Icons.search, size: 35),
                                      labelText: "Nom du test",
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.zero,
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                onSelected: (String selection) {
                                  setState(() {
                                    _testNameController.text = selection;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: Autocomplete<String>(
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
                                        height: 150,
                                        width:
                                            MediaQuery.of(context).size.width -
                                            40,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
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
                                    onChanged: (value) {
                                      setState(() {
                                        _locationController.text = value;
                                      });
                                    },
                                    onTapOutside: (event) {
                                      focusNode.unfocus();
                                    },
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(fontSize: 14),
                                      labelText: "rechercher un lieu",
                                      prefixIcon: Icon(
                                        Icons.location_on_outlined,
                                        size: 28,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.zero,
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                onSelected: (String selection) {
                                  setState(() {
                                    _locationController.text = selection;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(color: Colors.black, thickness: 0.9),
                      Row(
                        children: [
                          Text(
                            widget.date ??
                                DateTime.now().toString().substring(0, 10),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: 190.h),
                          GestureDetector(
                            onTap: _previousPage,
                            child: const Icon(Icons.arrow_back_ios, size: 20),
                          ),
                          GestureDetector(
                            onTap: _nextPage,
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 1),
                      SizedBox(
                        height: 478.h,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: totalPages,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, pageIndex) {
                            final filteredCenters = _getFilteredCenters();
                            int startIndex = pageIndex * clinicsPerPage;
                            int endIndex = (pageIndex + 1) * clinicsPerPage;
                            if (endIndex > filteredCenters.length) {
                              endIndex = filteredCenters.length;
                            }

                            return Column(
                              children: [
                                for (int i = startIndex; i < endIndex; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: buildResultCard(
                                      context,
                                      filteredCenters[i]['name']?.toString() ??
                                          '',
                                      filteredCenters[i]['location']
                                              ?.toString() ??
                                          '',
                                      filteredCenters[i]['about']?.toString() ??
                                          '',
                                      filteredCenters[i]['distance']
                                              ?.toString() ??
                                          '',
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
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 207, 49, 52),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 45,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Page suivante",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
