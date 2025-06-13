import 'package:flutter/material.dart';
import 'prendreRdvpatient.dart'; // Page pour saisir un nouveau RDV

class DemandeRendezVousPage extends StatefulWidget {
  const DemandeRendezVousPage({super.key});

  @override
  State<DemandeRendezVousPage> createState() => _DemandeRendezVousPageState();
}

class _DemandeRendezVousPageState extends State<DemandeRendezVousPage> {
  String? date;
  String? heure;

  // Méthode pour mettre à jour les données
  void mettreAJourRendezVous({
    required String dateRdv,
    required String heureRdv,
  }) {
    setState(() {
      date = dateRdv;
      heure = heureRdv;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Rendez-vous mis à jour avec succès !"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  title: const Text("Rendez-vous à venir"),
  centerTitle: true, // centre le titre
  automaticallyImplyLeading: false, // enlève la flèche de retour
),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: (date == null || heure == null)
            ? const Center(child: Text("Aucun rendez-vous enregistré."))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date : $date", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("Heure : $heure", style: const TextStyle(fontSize: 16)),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EnregistrerRendezVousPage(
                onSave: ({required String dateRdv, required String heureRdv}) {
                  mettreAJourRendezVous(dateRdv: dateRdv, heureRdv: heureRdv);
                },
              ),
            ),
          );
        },
        icon: const Icon(Icons.add, color: Colors.white),
       label: const Text(
  "Prendre un rendez-vous",
  style: TextStyle(color: Colors.white),
),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
