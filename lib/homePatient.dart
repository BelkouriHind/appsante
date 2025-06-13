import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Homepatient extends StatefulWidget {
  @override
  _HomepatientState createState() => _HomepatientState();
}

class _HomepatientState extends State<Homepatient> {
  File? _profileImage;
  final picker = ImagePicker();

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // L'AppBar est supprimée ici pour éliminer la flèche de retour.
      // Si cette page est affichée après une connexion, il est recommandé
      // d'utiliser Navigator.pushReplacement ou Navigator.pushAndRemoveUntil
      // pour empêcher l'utilisateur de revenir à la page de connexion
      // avec le bouton retour du système.
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16), // Padding général réduit pour mobile
        child: Column(
          children: [
            // Section profil centrée
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20), // Espace en haut
                // Photo de profil
                GestureDetector(
                  onTap: _getImageFromGallery,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFF4285F4),
                        width: 1.5,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 40, // Rayon de la photo de profil réduit
                      backgroundColor: Color(0xFFF5F5F5),
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? Icon(Icons.camera_alt,
                              size: 18, // Taille de l'icône réduite
                              color: Color.fromARGB(255, 16, 186, 192))
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 12), // Espace réduit
                // Nom et email
                Text(
                  'Nom complet',
                  style: TextStyle(
                    fontSize: 20, // Taille du nom réduite
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4), // Espace réduit
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14, // Taille de l'email réduite
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),

            SizedBox(height: 25), // Espace avant la grille

            // Grille d'informations moderne (tailles réduites pour mobile)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8), // Padding horizontal de la grille réduit
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.2, // Rend les cartes plus larges et moins hautes (plus petites)
                crossAxisSpacing: 8, // Espacement réduit
                mainAxisSpacing: 8, // Espacement réduit
                children: [
                  _buildModernInfoCard('Âge', '', Icons.calendar_today),
                  _buildModernInfoCard('Genre', '', Icons.person),
                  _buildModernInfoCard('Taille', '', Icons.straighten),
                  _buildModernInfoCard('Poids', '', Icons.monitor_weight),
                ],
              ),
            ),

            SizedBox(height: 25), // Espace après la grille

            // Section supplémentaire (optionnelle)
            /*
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16), // Padding réduit
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dernières activités',
                    style: TextStyle(
                      fontSize: 16, // Taille réduite
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10), // Espace réduit
                  // Ajouter vos widgets d'activités ici
                ],
              ),
            ),
            */
          ],
        ),
      ),
    );
  }

  Widget _buildModernInfoCard(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8), // Rayon des coins réduit
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.06), // Opacité de l'ombre très légère
            spreadRadius: 0.5, // Rayon de propagation réduit
            blurRadius: 4, // Flou réduit
            offset: Offset(0, 1), // Décalage réduit
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10), // Padding interne de la carte réduit
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22, // Taille de l'icône réduite
              color: Color.fromARGB(255, 16, 186, 192),
            ),
            SizedBox(height: 6), // Espace réduit
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12, // Taille du titre réduite
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 2), // Espace très réduit
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15, // Taille de la valeur réduite
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}