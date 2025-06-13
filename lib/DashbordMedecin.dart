import 'package:flutter/material.dart';
import 'MedecinHome.dart';
import 'rendezvous_medecin.dart';
import 'DossierPatient.dart';
import 'MedecinSettings.dart';

class DashboardMedecinPage extends StatefulWidget {
  const DashboardMedecinPage({super.key});

  @override
  State<DashboardMedecinPage> createState() => _DashboardMedecinPageState();
}

class _DashboardMedecinPageState extends State<DashboardMedecinPage> {
  int _selectedIndex = 0;

  // Pour le moment, on garde seulement HomeMedecin pour éviter les erreurs
  final List<Widget> _pages = [
    HomeMedecin(),
    // Placeholder pages à remplacer par les vraies pages plus tard
    RendezVousMedecinPage() ,
     const FormMedicalSimple(), 
    ParametreMedecinPage(),
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
        selectedItemColor: const Color.fromARGB(255, 58, 201, 158),
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.folder_shared), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.event_available), label: 'Mes Rendez-vous'),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: 'Dossier Patient'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Paramètres'),
        ],
      ),
    );
  }
}
