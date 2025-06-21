import 'package:findlab/screens/patient/google_auth_screen.dart';
import 'package:findlab/screens/patient/terms_and_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 0;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 670.h),
                child: Image.asset(
                  'assets/images/Vector.png',
                  height: 40.h,
                  fit: BoxFit.contain,
                  width: 190.w,
                ),
              ),
            ),
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              children: [
                _buildPage(
                  image: 'assets/images/doc.png',
                  title: "Bienvenue chez FindLab \nVotre partenaire Medical",
                  subtitle:
                      "\nTrouvez, comparez et réservez des tests de laboratoire",
                ),
                _buildPage(
                  image: 'assets/images/med.png',
                  title: "Réservez vos examens médicaux en toute simplicité",
                  subtitle:
                      "\nGagnez du temps grâce à une prise de rendez-vous rapide et sécurisée",
                ),
                _buildPage(
                  image: 'assets/images/test.png',
                  title: "Évitez l'attente Réservez en toute confiance",
                  subtitle:
                      "\nAccès instantané à des laboratoires de confiance — rapide, simple, fiable",
                ),
              ],
            ),
            Positioned(
              bottom: 179.h,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 8.h,
                    dotWidth: 8.w,
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50.h,
              left: 20.w,
              right: 20.w,
              child:
                  currentPage < 2
                      ? Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 150.w,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 35.h),
                            child: ElevatedButton(
                              onPressed: () {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  210,
                                  32,
                                  19,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                              ),
                              child: Text(
                                "Suivant",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      : Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top: 11.h),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              const TermsAndConditionsScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    67,
                                    118,
                                    199,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 40.w,
                                  ),
                                ),
                                child: Text(
                                  "Commencez maintenant",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Align(
                            alignment: Alignment.center,
                            child: FittedBox(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const GoogleAuthScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    45,
                                    55,
                                    72,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8.h,
                                    horizontal: 25.w,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                      child: Image.asset(
                                        'assets/images/google.png',
                                        height: 20.h,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "Inscrivez-vous avec Google",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required String subtitle,
    required String image,
  }) {
    return Padding(
      padding: EdgeInsets.all(30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 280.h, fit: BoxFit.contain),
          SizedBox(height: 20.h),
          Text(
            title,
            style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
