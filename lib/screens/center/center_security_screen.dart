// security_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenterSecurityScreen extends StatefulWidget {
  const CenterSecurityScreen({super.key});

  @override
  State<CenterSecurityScreen> createState() => _CenterSecurityScreenState();
}

class _CenterSecurityScreenState extends State<CenterSecurityScreen> {
  final _formKey = GlobalKey<FormState>();

  String _newPassword = '';

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
                    fit: BoxFit.fill,
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
                      'SÉCURITÉ',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Mot de passe actuel',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _buildTextField(
                      label: 'Mot de passe actuel',
                      onChanged: (value) => value,
                      obscureText: true,
                    ),
                    Text(
                      'Nouveau mot de passe',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _buildTextField(
                      label: 'Nouveau mot de passe',
                      onChanged: (value) => _newPassword = value,
                      obscureText: true,
                    ),
                    Text(
                      'Ressaisissez le nouveau mot de passe',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _buildTextField(
                      label: 'Ressaisissez le nouveau mot de passe',
                      onChanged: (value) => value,
                      obscureText: true,
                      validator: (value) {
                        if (value != _newPassword) {
                          return 'Les mots de passe ne correspondent pas';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 50.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // TODO: Save password changes
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Mot de passe mis à jour'),
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.w,
                              vertical: 12.h,
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
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
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
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          border: const OutlineInputBorder(),
        ),
        obscureText: obscureText,
        onChanged: onChanged,
        validator:
            validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir $label';
              }
              return null;
            },
      ),
    );
  }
}
