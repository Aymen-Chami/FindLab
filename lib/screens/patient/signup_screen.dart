// lib/screens/patient/signup_screen.dart
import 'package:findlab/screens/center/center_signup_screen.dart';
import 'package:findlab/screens/patient/facebook_auth_screen.dart';
import 'package:findlab/screens/patient/google_auth_screen.dart';
import 'package:findlab/screens/patient/login_screen.dart';
import 'package:findlab/screens/patient/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:findlab/widgets/show_auth_dialog.dart';
import 'package:findlab/widgets/custom_animated_toggle_tab.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPatient = true;
  final _formKey = GlobalKey<FormState>();

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
                horizontal: 20.w, // Scale horizontal padding
                vertical: 85.h, // Scale vertical padding
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Créer un compte !",
                    style: TextStyle(
                      fontSize: 30.sp, // Scale font size
                      fontWeight: FontWeight.w900,
                      color: const Color.fromARGB(255, 20, 12, 70),
                    ),
                  ),
                  SizedBox(height: 5.h), // Scale height
                  Text(
                    "Veuillez remplir les informations ci-dessous pour créer un compte.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp, // Scale font size
                      color: const Color.fromARGB(255, 101, 100, 100),
                    ),
                  ),
                  SizedBox(height: 10.h), // Scale height
                  CustomAnimatedToggleTab(
                    callback: (int index) {
                      setState(() {
                        isPatient = index == 0;
                      });
                    },
                    tabTexts: const ['Patient', 'Centre'],
                    width: 200, // Already scaled in the widget
                    height: 40, // Already scaled in the widget
                    initialIndex: isPatient ? 0 : 1,
                  ),
                  SizedBox(height: 20.h), // Scale height
                  Container(
                    padding: EdgeInsets.all(20.w), // Scale padding
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        30.r,
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
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isPatient ? 'Nom et Prénom' : "Centre",
                            style: TextStyle(
                              fontSize: 16.sp, // Scale font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h), // Scale height
                          TextFormField(
                            decoration: InputDecoration(
                              labelText:
                                  isPatient ? "Nom et Prénom" : "Nom du centre",
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer ${isPatient ? "votre nom complet" : "le nom du centre"}';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h), // Scale height
                          Text(
                            'Adresse email',
                            style: TextStyle(
                              fontSize: 16.sp, // Scale font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h), // Scale height
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Adresse email",
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
                                return 'Please enter your email address';
                              }
                              if (!RegExp(
                                r'^[^@]+@[^@]+\.[^@]+',
                              ).hasMatch(value)) {
                                return 'Please enter a valid email address';
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
                            obscureText: true,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h), // Scale height
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (isPatient) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const TabsScreen(),
                                    ),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              const CenterSignupScreen(),
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
                                  vertical: 8.h, // Scale vertical padding
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30.r,
                                  ), // Scale border radius
                                ),
                              ),
                              child: Text(
                                isPatient ? "S'inscrire" : "Suivant",
                                style: TextStyle(
                                  fontSize: 20.sp, // Scale font size
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Vous avez déjà un compte? Connectez-vous",
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    185,
                                    201,
                                    248,
                                  ),
                                  fontSize: 13.sp, // Scale font size
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
                                      "S’inscrire via Google",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp, // Scale font size
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.h), // Scale height
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
                                      "S’inscrire via Facebook",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp, // Scale font size
                                      ),
                                    ),
                                  ],
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
