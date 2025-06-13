import 'package:flutter/material.dart';
import 'langue.dart';
import 'medecinProfil.dart';
import 'envoyer_prescription.dart';
import 'conditionspatient.dart';
import 'listePatient.dart';

class ParametreMedecinPage extends StatelessWidget {
  const ParametreMedecinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Color(0xFF10BAC0),
        elevation: 1,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildCard(
                    context,
                    items: [
                      _buildSettingsItem(
                        context,
                        icon: Icons.person,
                        iconColor: Color(0xFF10BAC0),
                        title: 'Profil',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilemedecinPage(),
                            ),
                          );
                        },
                      ),
                       _buildSettingsItem(
                        context,
                        icon: Icons.people_alt,
                        iconColor: Color(0xFF10BAC0),
                        title: 'listes Patients ',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PatientsEnConsultationPage(),
                            ),
                          );
                        },
                      ),
                      _buildSettingsItem(
                        context,
                        icon: Icons.medical_services_outlined,
                        iconColor: Color(0xFF10BAC0),
                        title: 'Prescription',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrescriptionPage(),
                            ),
                          );
                        },
                      ),
                      _buildSettingsItem(
                        context,
                        icon: Icons.language,
                        iconColor: Color(0xFF10BAC0),
                        title: 'Langue',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => languePage(),
                            ),
                          );
                        },
                      ),
                      _buildSettingsItem(
                        context,
                        icon: Icons.privacy_tip_outlined,
                        iconColor: Color(0xFF10BAC0),
                        title: 'Confidentialité & Politique',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PrivacySecurityPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required List<Widget> items}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ...items.map((item) => Column(
                children: [
                  item,
                  if (item != items.last)
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.1),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO : implémenter la déconnexion
          print('Déconnexion');
        },
        icon: const Icon(Icons.logout, color: Colors.white),
        label: const Text(
  'Déconnexion',
  style: TextStyle(color: Colors.white),
),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF10BAC0),
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
