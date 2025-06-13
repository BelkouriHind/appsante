import 'package:flutter/material.dart';

class RendezVousMedecinPage extends StatefulWidget {
  @override
  _RendezVousMedecinPageState createState() => _RendezVousMedecinPageState();
}

class _RendezVousMedecinPageState extends State<RendezVousMedecinPage> {
  List<Map<String, dynamic>> rdvs = [
    {'id': 'R001', 'date': '2025-06-02', 'heure': '14:00', 'etat': 'En attente'},
    {'id': 'R002', 'date': '2025-06-03', 'heure': '10:00', 'etat': 'En attente'},
  ];

  void _validerRendezVous(String id) {
    setState(() {
      final index = rdvs.indexWhere((r) => r['id'] == id);
      if (index != -1) {
        rdvs[index]['etat'] = 'Confirmé';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rendez-vous $id confirmé')),
    );
  }

  void _refuserRendezVous(String id) {
    setState(() {
      final index = rdvs.indexWhere((r) => r['id'] == id);
      if (index != -1) {
        rdvs[index]['etat'] = 'Annulé';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rendez-vous $id annulé')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mes Rendez-vous ')),
      body: ListView.builder(
        itemCount: rdvs.length,
        itemBuilder: (context, index) {
          final r = rdvs[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(Icons.event, color: const Color.fromARGB(255, 23, 206, 206)),
              title: Text('${r['date']} à ${r['heure']}'),
              subtitle: Text('État : ${r['etat']}'),
              trailing: r['etat'] == 'En attente' 
                  ? Wrap(
                      spacing: 8,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () => _validerRendezVous(r['id']),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () => _refuserRendezVous(r['id']),
                        ),
                      ],
                    )
                  : Text(
                      r['etat'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: r['etat'] == 'Confirmé' ? Colors.green : Colors.red,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
