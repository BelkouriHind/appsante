import 'package:flutter/material.dart';

class RendezVousMedecinPage extends StatelessWidget {
  final List<Map<String, dynamic>> rdvs = [
    {'id': 'R001', 'date': '2025-06-02', 'heure': '14:00', 'etat': 'En attente'},
    {'id': 'R002', 'date': '2025-06-03', 'heure': '10:00', 'etat': 'En attente'},
  ];

  void _validerRendezVous(BuildContext context, String id) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rendez-vous $id confirmé')),
    );
  }

  void _refuserRendezVous(BuildContext context, String id) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rendez-vous $id annulé')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rendez-vous à valider')),
      body: ListView.builder(
        itemCount: rdvs.length,
        itemBuilder: (context, index) {
          final r = rdvs[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(Icons.event, color: Colors.blue),
              title: Text('${r['date']} à ${r['heure']}'),
              subtitle: Text('État : ${r['etat']}'),
              trailing: Wrap(
                spacing: 8,
                children: [
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    onPressed: () => _validerRendezVous(context, r['id']),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () => _refuserRendezVous(context, r['id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
