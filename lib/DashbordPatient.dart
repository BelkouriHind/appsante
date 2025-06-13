import 'package:flutter/material.dart';
import 'homePatient.dart';
import 'DossierMedical.dart';
import 'Rendez-vous.dart';
import 'settingspatient.dart'; // Assurez-vous que DemandeRendezVousPage est bien là

class DashboardPatientPage extends StatefulWidget {
  const DashboardPatientPage({super.key});

  @override
  State<DashboardPatientPage> createState() => _DashboardPatientPageState();
}

class _DashboardPatientPageState extends State<DashboardPatientPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Homepatient(),                       // Accueil
    const MedicalFormPage(),            // Dossier médical
    const DemandeRendezVousPage(),      // Rendez-vous
    const parametrePage(),              // Paramètres
  ];

  final List<Map<String, dynamic>> _bottomNavBarItems = [
    {'label': 'Accueil', 'icon': Icons.home},
    {'label': 'Dossier Médical', 'icon': Icons.medical_services},
    {'label': 'Rendez-vous', 'icon': Icons.calendar_today},
    {'label': 'Paramètres', 'icon': Icons.settings},
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    if (_pages.length != _bottomNavBarItems.length) {
      throw 'Erreur: Les listes _pages et _bottomNavBarItems doivent avoir la même longueur.';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _bottomNavBarItems[_selectedIndex]['label'] ?? 'Tableau de Bord',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item['icon']),
            label: item['label'],
          );
        }).toList(),
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 58, 201, 158),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 11),
      ),
    );
  }
}
