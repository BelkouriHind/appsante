import 'package:flutter/material.dart';
import 'prendreRdvpatient.dart'; // page pour saisir un nouveau RDV

class DemandeRendezVousPage extends StatefulWidget {
  const DemandeRendezVousPage({super.key});

  @override
  State<DemandeRendezVousPage> createState() => _DemandeRendezVousPageState();
}

class _DemandeRendezVousPageState extends State<DemandeRendezVousPage> {
  // Simule un rendez-vous déjà enregistré (à remplacer par une vraie source plus tard)
  String? etat;
  String? date;
  String? heure;

  // Cette fonction sera appelée quand on revient de la page de saisie
  void mettreAJourRendezVous({
    required String etatRdv,
    required String dateRdv,
    required String heureRdv,
  }) {
    setState(() {
      etat = etatRdv;
      date = dateRdv;
      heure = heureRdv;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rendez-vous à venir")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: etat == null
            ? Center(child: Text("Aucun rendez-vous enregistré."))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("État : $etat", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text("Date : $date", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text("Heure : $heure", style: TextStyle(fontSize: 16)),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Aller à la page de saisie et attendre les résultats
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>   EnregistrerRendezVousPage(
                onSave: mettreAJourRendezVous,
              ),
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text("Prendre un rendez-vous"),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
