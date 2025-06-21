// lib/screens/patient/login_screen.dart
import 'package:findlab/screens/patient/forgot_pass_screen.dart';
import 'package:findlab/screens/patient/signup_screen.dart';
import 'package:findlab/screens/patient/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import flutter_screenutil
import 'package:findlab/screens/patient/google_auth_screen.dart';
import 'package:findlab/screens/patient/facebook_auth_screen.dart';
import '../../widgets/show_auth_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Added for form validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.h), // Scale app bar height
        child: AppBar(
          title: Image.asset(
            'assets/images/Vector.png',
            height: 40.h, // Scale image height
            fit: BoxFit.contain,
            width: 150.w, // Scale image width
          ),
          centerTitle: true,
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
              padding: EdgeInsets.symmetric(
                horizontal: 25.w, // Scale horizontal padding
                vertical: 120.h, // Scale vertical padding
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Connectez-vous maintenant !",
                    style: TextStyle(
                      fontSize: 23.sp, // Scale font size
                      fontWeight: FontWeight.w900,
                      color: const Color.fromARGB(255, 20, 12, 70),
                    ),
                  ),
                  SizedBox(height: 5.h), // Scale height
                  Text(
                    "Veuillez remplir les informations ci-dessous pour vous connecter",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp, // Scale font size
                      color: const Color.fromARGB(255, 101, 100, 100),
                    ),
                  ),
                  SizedBox(height: 20.h), // Scale height
                  Container(
                    padding: EdgeInsets.all(20.w), // Scale padding
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        25.r,
                      ), // Scale border radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10.r, // Scale blur radius
                          spreadRadius: 1.r, // Scale spread radius
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey, // Added for form validation
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Adresse e-mail',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16.sp, // Scale font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h), // Scale height
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Adresse e-mail',
                              labelStyle: TextStyle(
                                fontSize: 14.sp,
                              ), // Scale label font size
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  40.r,
                                ), // Scale border radius
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                            ), // Scale text field font size
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ' Veuillez entrer votre adresse e-mail';
                              }
                              if (!RegExp(
                                r'^[^@]+@[^@]+\.[^@]+',
                              ).hasMatch(value)) {
                                return ' Veuillez entrer une adresse e-mail valide';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h), // Scale height
                          Text(
                            'Mot de passe',
                            style: TextStyle(
                              fontSize: 16.sp, // Scale font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h), // Scale height
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Mot de passe",
                              labelStyle: TextStyle(
                                fontSize: 14.sp,
                              ), // Scale label font size
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  40.r,
                                ), // Scale border radius
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                            ), // Scale text field font size
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre mot de passe';
                              }
                              if (value.length < 6) {
                                return 'Le mot de passe doit contenir au moins 6 caractères';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h), // Scale height
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const TabsScreen(),
                                    ),
                                  );
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
                                  horizontal: 100.w, // Scale horizontal padding
                                  vertical: 10.h, // Scale vertical padding
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30.r,
                                  ), // Scale border radius
                                ),
                              ),
                              child: Text(
                                "Se connecter",
                                style: TextStyle(
                                  fontSize: 14.sp, // Scale font size
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ForgotPass(),
                                  ),
                                );
                              },
                              child: Text(
                                'Mot de passe oublié ?',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 219, 11, 11),
                                  fontSize: 16.sp, // Scale font size
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'ou',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ), // Scale font size
                            ),
                          ),
                          SizedBox(height: 10.h), // Scale height
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 14.h, // Scale vertical padding
                                    horizontal:
                                        30.w, // Scale horizontal padding
                                  ),
                                ),
                                onPressed: () {
                                  showAuthDialog(
                                    context,
                                    const GoogleAuthScreen(),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/google.png',
                                      height: 30.h, // Scale image height
                                    ),
                                    SizedBox(width: 10.w), // Scale width
                                    Text(
                                      "Se connecter avec Google",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp, // Scale font size
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h), // Scale height
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 14.h, // Scale vertical padding
                                    horizontal:
                                        30.w, // Scale horizontal padding
                                  ),
                                ),
                                onPressed: () {
                                  showAuthDialog(
                                    context,
                                    const FacebookAuthScreen(),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/facebook.png',
                                      height: 30.h, // Scale image height
                                    ),
                                    SizedBox(width: 10.w), // Scale width
                                    Text(
                                      "Se connecter avec Facebook",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp, // Scale font size
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.h), // Scale height
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const SignupScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Vous n'avez pas de compte ? Inscrivez-vous",
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      139,
                                      169,
                                      220,
                                    ),
                                    fontSize: 13.sp, // Scale font size
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
          ),
        ],
      ),
    );
  }
}
