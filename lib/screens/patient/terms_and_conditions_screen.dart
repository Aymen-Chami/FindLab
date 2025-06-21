import 'package:findlab/screens/patient/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.h),
        child: AppBar(
          title: Image.asset(
            'assets/images/Vector.png',
            height: 40.h,
            fit: BoxFit.contain,
            width: 150.w,
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
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Terms and Conditions",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color.fromARGB(255, 20, 12, 70),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10.r,
                          spreadRadius: 1.r,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bienvenue sur FindLab",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Merci de rejoindre FindLab, votre passerelle digitale vers des services de diagnostic médical fiables et accessibles.\n\n"
                          "Avant de commencer, nous vous invitons à prendre connaissance de notre Charte d’utilisation et de confidentialité. "
                          "Elle garantit votre sécurité, le respect de votre vie privée et un bon usage de l’application.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "1. Ce que vous pouvez faire avec FindLab",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "En utilisant notre application, vous pouvez :\n"
                          "• Chercher un laboratoire (public ou privé) selon vos besoins,\n"
                          "• Prendre un rendez-vous en ligne, simplement et rapidement,\n"
                          "• Recevoir vos résultats d’analyses médicales de manière sécurisée,\n"
                          "• Suivre l’historique de vos rendez-vous et tests.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "2. Ce que nous collectons et pourquoi",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "Pour vous offrir un service personnalisé et sécurisé, nous avons besoin de certaines données :\n"
                          "• Informations personnelles : nom, email, numéro de téléphone.\n"
                          "• Données médicales : uniquement celles nécessaires pour la prise de rendez-vous et la réception sécurisée de vos résultats.\n\n"
                          "Vos données sont stockées de façon sécurisée, jamais revendues, et accessibles uniquement par vous.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "3. Vos droits sont garantis",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "À tout moment, vous avez le droit de :\n"
                          "• Accéder à vos informations,\n"
                          "• Les modifier ou les supprimer,\n"
                          "• Retirer votre consentement à l’utilisation de vos données,\n"
                          "• Nous contacter à tout moment via : support@findlab.dz\n\n"
                          "Nous appliquons les réglementations en vigueur, y compris la loi algérienne sur la protection des données personnelles et les principes du RGPD.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "4. Responsabilités & engagements",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "• FindLab agit comme intermédiaire entre vous et les laboratoires.\n"
                          "• Nous garantissons la fiabilité de notre plateforme, mais la responsabilité médicale incombe aux laboratoires partenaires.\n"
                          "• Vous vous engagez à utiliser l’application de manière honnête et sécurisée, dans le respect des autres utilisateurs et des partenaires.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "5. En continuant, vous acceptez :",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "• Les Conditions Générales d’Utilisation de l’application,\n"
                          "• La Politique de confidentialité liée à vos données personnelles et médicales.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Conditions Générales d’Utilisation de l’Application FindLab",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 20, 12, 70),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10.r,
                          spreadRadius: 1.r,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date de mise à jour : Avril 2025",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontStyle: FontStyle.italic,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "1. Présentation de l’éditeur",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "L'application FindLab est éditée par R. Saidi, située à Boumerdes, en cours d’immatriculation.\n"
                          "Contact : support@findlab.dz\n\n"
                          "FindLab est une plateforme numérique permettant aux utilisateurs de rechercher un laboratoire, prendre un rendez-vous et consulter leurs résultats d’analyses médicales en ligne.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "2. Objet des CGU",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "Les présentes CGU ont pour objet de définir les modalités d’utilisation de l’application FindLab par l’utilisateur. Toute connexion à l’application suppose l’acceptation des présentes conditions.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "3. Accès à l’application",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "• L’application est disponible gratuitement sur les plateformes Android et iOS.\n"
                          "• Une connexion internet est nécessaire pour utiliser ses fonctionnalités.\n"
                          "• L’éditeur se réserve le droit de suspendre temporairement l’accès à des fins de maintenance ou d’évolution technique.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "4. Création et gestion du compte utilisateur",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "• L’utilisateur doit fournir des informations exactes (nom, prénom, email, téléphone).\n"
                          "• Il est responsable de la sécurité de son identifiant et mot de passe.\n"
                          "• Tout usage frauduleux du compte entraîne sa suspension sans préavis.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "5. Services proposés",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "FindLab permet à l’utilisateur de :\n"
                          "• Rechercher un laboratoire (public ou privé) par type d’analyse ou localisation,\n"
                          "• Réserver un rendez-vous en ligne,\n"
                          "• Recevoir et consulter ses résultats médicaux de manière sécurisée,\n"
                          "• Suivre ses rendez-vous passés et à venir.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "6. Obligations de l’utilisateur",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "L’utilisateur s’engage à :\n"
                          "• Ne pas nuire au bon fonctionnement de l’application,\n"
                          "• Ne pas usurper l’identité d’un tiers,\n"
                          "• Utiliser l’application à des fins strictement personnelles et légales.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "7. Propriété intellectuelle",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "L’ensemble des éléments composant l’application (contenus, graphismes, logo, code) sont protégés par le droit de la propriété intellectuelle.\n"
                          "Toute reproduction ou usage non autorisé est interdit.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "8. Protection des données personnelles",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "• Données collectées : nom, email, téléphone, informations médicales relatives aux rendez-vous et résultats d’analyse.\n"
                          "• Utilisation : gestion des rendez-vous, envoi de notifications, affichage sécurisé des résultats.\n"
                          "• Conservation : 3 ans après la dernière activité de l’utilisateur.\n"
                          "• Sécurité : données hébergées sur des serveurs sécurisés et conformes à la réglementation.\n"
                          "• Droits : accès, rectification, suppression, opposition, via l’adresse support@findlab.dz\n\n"
                          "L’application respecte la loi algérienne sur la protection des données personnelles et s’aligne sur les principes du RGPD.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "9. Responsabilité",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "L’éditeur :\n"
                          "• Ne peut être tenu responsable des erreurs, retards ou manquements des laboratoires partenaires,\n"
                          "• Ne garantit pas un fonctionnement continu ou sans erreur de l’application,\n"
                          "• Décline toute responsabilité en cas de mauvaise interprétation des résultats médicaux.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "10. Modifications des CGU",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "Les présentes CGU peuvent être modifiées à tout moment.\n"
                          "Les utilisateurs seront informés via une notification.\n"
                          "L’utilisation continue de l’application vaut acceptation des modifications.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "11. Droit applicable et juridiction",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "Les présentes CGU sont régies par le droit algérien.\n"
                          "En cas de litige, compétence exclusive est donnée aux tribunaux d’Alger.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "12. Acceptation",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 12, 70),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "En installant et en utilisant l’application FindLab, l’utilisateur reconnaît avoir lu, compris et accepté l’ensemble des présentes Conditions Générales d’Utilisation.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Checkbox(
                        value: _isAccepted,
                        onChanged: (bool? value) {
                          setState(() {
                            _isAccepted = value ?? false;
                          });
                        },
                        activeColor: const Color.fromARGB(255, 67, 118, 199),
                      ),
                      Expanded(
                        child: Text(
                          "J’ai lu et j’accepte les conditions d’utilisation et la politique de confidentialité.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: ElevatedButton(
                      onPressed:
                          _isAccepted
                              ? () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          67,
                          118,
                          199,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 11.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Text(
                        "Continuer vers l’application",
                        style: TextStyle(fontSize: 20.sp, color: Colors.white),
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
