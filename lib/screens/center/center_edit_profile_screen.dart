// edit_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenterEditProfileScreen extends StatefulWidget {
  const CenterEditProfileScreen({super.key});

  @override
  State<CenterEditProfileScreen> createState() =>
      _CenterEditProfileScreenState();
}

class _CenterEditProfileScreenState extends State<CenterEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _firstName = '';
  // ignore: unused_field
  String _lastName = '';
  // ignore: unused_field
  String _email = '';
  // ignore: unused_field
  String _address = '';
  // ignore: unused_field
  String _contactNumber = '';
  String _city = 'Bab Ezzouar'; // Set a default value from the items list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(49.0),
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
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MODIFIER LE PROFIL',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Nom du centre',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _buildTextField(
                      label: 'Nom',
                      onChanged: (value) => setState(() => _firstName = value),
                    ),

                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _buildTextField(
                      label: 'EMAIL',
                      onChanged: (value) => setState(() => _email = value),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _buildTextField(
                      label: 'ADDRESS',
                      onChanged: (value) => setState(() => _address = value),
                    ),
                    const Text(
                      'Numéro de contact',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _buildTextField(
                      label: 'Numéro de contact',
                      onChanged:
                          (value) => setState(() => _contactNumber = value),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownField(
                            label: 'VILLE',
                            value: _city,
                            items: [
                              'Bab Ezzouar',
                              'Algiers',
                              'Oran',
                              'Constantine',
                            ],
                            onChanged: (value) {
                              setState(() {
                                _city = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: _buildDropdownField(
                            label: 'Commune ',
                            value: _city,
                            items: [
                              'Bab Ezzouar',
                              'Algiers',
                              'Oran',
                              'Constantine',
                            ],
                            onChanged: (value) {
                              setState(() {
                                _city = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profil enregistré'),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              67,
                              118,
                              199,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'ENREGISTRER',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color.fromARGB(255, 67, 118, 199),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                                vertical: 12.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'ANNULER',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 67, 118, 199),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildTextField({
    required String label,
    required ValueChanged<String> onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez saisir $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          border: const OutlineInputBorder(),
        ),
        items:
            items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez sélectionner $label';
          }
          return null;
        },
      ),
    );
  }
}
