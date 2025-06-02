import 'package:flutter/material.dart';

class PatientsPage extends StatelessWidget {
  final List<Map<String, String>> patients = [
    {'nom': 'Amine Benali', 'id': 'P001'},
    {'nom': 'Sara El Idrissi', 'id': 'P002'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des Patients')),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final p = patients[index];
          return ListTile(
            leading: Icon(Icons.person, color: Colors.deepPurple),
            title: Text(p['nom'] ?? ''),
            subtitle: Text('ID Patient : ${p['id']}'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // TODO : Afficher le dossier du patient
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Dossier de ${p['nom']}')),
              );
            },
          );
        },
      ),
    );
  }
}
