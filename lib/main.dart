import 'package:flutter/material.dart';
import 'login.dart';
import 'DashbordPatient.dart';
import 'Accueil.dart';
import 'DashbordMedecin.dart';

import 'DossierMedical.dart';
import 'Rendez-vous.dart';
import 'notifications_page.dart';
import 'profil_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AccueilPage(),
      routes: {
        '/login_page': (context) => const LoginPage(),
        '/dashboard_patient': (context) => const DashboardPatientPage(),
        '/dashboard_medecin': (context) => const DashboardMedecinPage(),
        '/ajouter_donnees': (context) => const MedicalFormPage(),
        '/demande_rendezvous': (context) => DemandeRendezVousPage(),
        '/notifications': (context) => NotificationsPage(),
        '/profil': (context) => ProfilPage(),
      },
    );
  }
}