import 'package:flutter/material.dart';
import 'homePatient.dart';

import 'DossierMedical.dart';
import 'Rendez-vous.dart';
import 'notifications_page.dart';
import 'profil_page.dart';

class DashboardPatientPage extends StatefulWidget {
  const DashboardPatientPage({super.key});

  @override
  State<DashboardPatientPage> createState() => _DashboardPatientPageState();
}

class _DashboardPatientPageState extends State<DashboardPatientPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Homepatient(),
    const MedicalFormPage(),
    DemandeRendezVousPage(),
    NotificationsPage(),
    ProfilPage(),
  ];

  final List<Map<String, dynamic>> _menuItems = [
    {'label': 'Accueil', 'icon': Icons.home},
    {'label': 'Dossier medical', 'icon': Icons.medical_services},
    {'label': 'Mes RendezVous', 'icon': Icons.calendar_today},
    {'label': 'Notifications', 'icon': Icons.notifications},
    {'label': 'Profil', 'icon': Icons.person},
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _menuItems[_selectedIndex]['icon'],
                    size: 30,
                    color: const Color.fromARGB(255, 58, 201, 158),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _menuItems.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        final isSelected = _selectedIndex == index;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: isSelected 
                                ? const Color.fromARGB(255, 58, 201, 158) 
                                : const Color.fromARGB(255, 10, 10, 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => _onItemTapped(index),
                            child: Text(
                              item['label'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected 
                                  ? FontWeight.bold 
                                  : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}