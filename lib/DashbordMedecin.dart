import 'package:flutter/material.dart';
import 'patients_page.dart';
import 'rendezvous_medecin.dart';
import 'envoyer_prescription.dart';
import 'notifications_medecin.dart';
import 'profil_medecin.dart';

class DashboardMedecinPage extends StatefulWidget {
  const DashboardMedecinPage({super.key});

  @override
  State<DashboardMedecinPage> createState() => _DashboardMedecinPageState();
}

class _DashboardMedecinPageState extends State<DashboardMedecinPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    PatientsPage(),            // 📁 Liste de patients
    RendezVousMedecinPage(),   // 📅 Gestion des rendez-vous
    PrescriptionPage(),        // 💊 Envoi des prescriptions
    NotificationsMedecinPage(),// 🔔 Notifications
    ProfilMedecinPage(),       // 👤 Profil
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.folder_shared), label: 'Patients'),
          BottomNavigationBarItem(icon: Icon(Icons.event_available), label: 'Rendez-vous'),
          BottomNavigationBarItem(icon: Icon(Icons.medication), label: 'Prescription'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
