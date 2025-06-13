import 'package:flutter/material.dart';

class listePatient {
  final String id;
  final String nom;
  final String prenom;
  final int age;
  final DateTime heureConsultation;

  listePatient({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.age,
    required this.heureConsultation,
  });
}

class PatientsEnConsultationPage extends StatefulWidget {
  const PatientsEnConsultationPage({super.key});

  @override
  State<PatientsEnConsultationPage> createState() =>
      _PatientsEnConsultationPageState();
}

class _PatientsEnConsultationPageState
    extends State<PatientsEnConsultationPage> {
  // Exemple de données statiques, à remplacer par ta source réelle
  final List<listePatient> patientsEnConsultation = [
    listePatient(
      id: 'p1',
      nom: 'Dubreuil',
      prenom: 'Sophie',
      age: 34,
      heureConsultation: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
   listePatient(
      id: 'p2',
      nom: 'Martin',
      prenom: 'Paul',
      age: 29,
      heureConsultation: DateTime.now().subtract(const Duration(minutes: 25)),
    ),
    listePatient(
      id: 'p3',
      nom: 'Nguyen',
      prenom: 'Linh',
      age: 42,
      heureConsultation: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ];

  String formatHeure(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients en consultation'),
        backgroundColor: const Color(0xFF22C0B3),
      ),
      body: patientsEnConsultation.isEmpty
          ? const Center(
              child: Text(
                'Aucun patient en consultation pour le moment.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: patientsEnConsultation.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final patient = patientsEnConsultation[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        patient.prenom[0] + patient.nom[0],
                        style: const TextStyle(
                          color: Color(0xFF22C0B3),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    title: Text(
                      '${patient.prenom} ${patient.nom}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text('Âge: ${patient.age} ans\n'
                        'Consulté à: ${formatHeure(patient.heureConsultation)}'),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: Color(0xFF22C0B3)),
                      onPressed: () {
                        // Action exemple: ouvrir détails patient
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Dossier de ${patient.prenom}'),
                            content: const Text(
                                'Ici tu pourrais afficher les détails complets du patient.'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Fermer'))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
