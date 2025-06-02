import 'package:flutter/material.dart';

class ProfilMedecinPage extends StatelessWidget {
  final Map<String, String> medecin = {
    'Nom': 'Dr. Samir',
    'Spécialité': 'Généraliste',
    'Email': 'samir@medecin.com',
    'Téléphone': '+212600123456',
    'Adresse': 'Marrakech, Maroc',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mon Profil')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            ...medecin.entries.map((e) => ListTile(
                  title: Text(e.key, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(e.value),
                )),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Action pour modifier ou se déconnecter
              },
              icon: Icon(Icons.logout),
              label: Text('Se déconnecter'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
