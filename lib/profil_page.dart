import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  final Map<String, String> utilisateur = {
    'Nom': 'Hind',
    'Prénom': 'El Amrani',
    'Sexe': 'Femme',
    'Date de naissance': '1999-07-14',
    'Email': 'hind@example.com',
    'Téléphone': '+212612345678',
    'Adresse': 'Tamellalt, Maroc',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Profil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ...utilisateur.entries.map((e) => ListTile(
                  leading: Icon(Icons.person),
                  title: Text(e.key),
                  subtitle: Text(e.value),
                )),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Redirection vers une page de modification de profil ou déconnexion
                },
                icon: Icon(Icons.edit),
                label: Text('Modifier mes informations'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login_page');
              },
              child: Text("Se déconnecter", style: TextStyle(color: Colors.red)),
            )
          ],
        ),
      ),
    );
  }
}
