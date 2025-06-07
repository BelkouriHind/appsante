import 'package:flutter/material.dart';
import'langue.dart';
import 'profilpatient.dart';
import 'notificationsPatient.dart';
import 'conditionspatient.dart';
class parametrePage extends StatelessWidget {
  const parametrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light grey background matching the image
      // L'AppBar est toujours supprimée.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0), // Padding around the main content
        child: Column(
          children: [
            // Main container for the settings items
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1), // Subtle shadow
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5), // Changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingsItem(
                    context,
                    icon: Icons.person_outline, // Icône pour Profil
                    title: 'Profil', // Remplacé "Settings" par "Profil"
                    onTap: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>const  ProfilePage()),
                      );
                      // Action pour la page de profil
                    },
                  ),
                  _buildDivider(), // Divider between items
                  _buildSettingsItem(
                    context,
                    icon: Icons.notifications_none, // Icône pour Notifications
                    title: 'Notifications', // Remplacé "Information personnelle" par "Notifications"
                    onTap: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationsPage()),
                      );
                      // Action pour les notifications
                    },
                  ),
                  _buildDivider(),
                  _buildSettingsItem(
                    context,
                    icon: Icons.language, // Icône pour Langue
                    title: 'Langue', // Remplacé "My products" par "Langue"
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  languePage()),
                      );
                      // Action pour le choix de la langue
                    },
                  ),
                  _buildDivider(),
                  _buildSettingsItem(
                    context,
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy & Policy',
                    onTap: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PrivacySecurityPage()),
                      );
                      // Action pour Privacy & Policy
                    },
                    isLastItem: true, // C'est le dernier élément de ce bloc
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Espace entre le bloc de paramètres et le bouton de déconnexion

            // Bouton de déconnexion séparé
            Container(
              width: double.infinity, // Prend toute la largeur disponible
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    print('Logout tapped');
                    // Implémentez ici votre logique de déconnexion.
                    // Par exemple, rediriger vers la page de connexion:
                    // Navigator.of(context).pushReplacementNamed('/login');
                  },
                  borderRadius: BorderRadius.circular(15.0),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 24,
                          color: Colors.red, // Couleur rouge pour l'icône de déconnexion
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            'Déconnexion', // Texte du bouton de déconnexion
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red, // Couleur rouge pour le texte de déconnexion
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right, // Flèche droite pour le bouton de déconnexion
                          size: 24,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build each settings item
  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLastItem = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.vertical(
          top: title == 'Profil' ? const Radius.circular(15.0) : Radius.zero, // 'Profil' est le premier
          bottom: isLastItem ? const Radius.circular(15.0) : Radius.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: Colors.black87,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 24,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build the divider between settings items
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(
        color: Colors.grey[200],
        height: 1,
        thickness: 1,
      ),
    );
  }
}