// profile_screen.dart
import 'package:findlab/screens/center/appointments_settings_screen.dart';
import 'package:findlab/screens/center/center_edit_profile_screen.dart';
import 'package:findlab/screens/center/center_security_screen.dart';
import 'package:findlab/screens/patient/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenterProfileScreen extends StatelessWidget {
  const CenterProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45.0),
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
          ListView(
            children: [
              SizedBox(height: 20),
              _buildProfileOption(
                context,
                icon: Icons.calendar_month_outlined,
                title: 'Paramètres des rendez-vous',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppointmentsSettingsScreen(),
                    ),
                  );
                },
              ),

              _buildProfileOption(
                context,
                icon: Icons.edit,
                title: 'Modifier le profil du centre',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CenterEditProfileScreen(),
                    ),
                  );
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.security,
                title: 'Sécurité',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CenterSecurityScreen(),
                    ),
                  );
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.color_lens,
                title: 'Apparence',
                onTap: () {
                  // TODO: Implement Appearance screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Appearance screen not implemented yet'),
                    ),
                  );
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.logout,
                title: 'Se déconnecter',
                color: Colors.red,
                showTrailing: false,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: const Text(
                          'Se déconnecter',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        content: const Text(
                          'Êtes-vous sûr de vouloir vous déconnecter ?',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'Annuler',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.h),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to the login screen and replace the current route
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const LoginScreen(),
                                      ),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.h,
                                      vertical: 10.w,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    'Confirmer',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black,
    bool showTrailing = true,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Icon(icon, color: color, size: 30),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 19,
          color: color,
          fontWeight: FontWeight.w800,
          fontFamily: 'Poppins',
        ),
      ),
      trailing:
          showTrailing ? const Icon(Icons.arrow_forward_ios, size: 19) : null,
      onTap: onTap,
    );
  }
}
