import 'package:flutter/material.dart';

import 'login.dart';
import 'DashbordPatient.dart';
import 'Accueil.dart';
import 'DashbordMedecin.dart';
// import 'DossierMedical.dart'; // Uncomment if you intend to use this route
// import 'Rendez-vous.dart'; // Uncomment if you intend to use this route

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical App', // Added a title for your app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // Recommended for modern Flutter apps
      ),
      home: const AccueilPage(), // Your starting page
      routes: {
        '/login_page': (context) => const LoginPage(),
        '/dashboard_patient': (context) => const DashboardPatientPage(),
        '/dashboard_medecin': (context) => const DashboardMedecinPage(),
        // Add other routes here if you have them, e.g.:
        // '/dossier_medical': (context) => const DossierMedicalPage(),
        // '/rendez_vous': (context) => const RendezVousPage(),
      },
    );
  }
}