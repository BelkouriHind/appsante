import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DemandeRendezVousPage extends StatefulWidget {
  @override
  _DemandeRendezVousPageState createState() => _DemandeRendezVousPageState();
}

class _DemandeRendezVousPageState extends State<DemandeRendezVousPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _formKey = GlobalKey<FormState>();

  String get formattedDate {
    if (_selectedDate == null) return 'Choisir une date';
    return DateFormat('yyyy-MM-dd').format(_selectedDate!);
  }

  String get formattedTime {
    if (_selectedTime == null) return 'Choisir une heure';
    return _selectedTime!.format(context);
  }

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  void _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => _selectedTime = time);
  }

  void _demanderRendezVous() {
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez choisir la date et l\'heure')),
      );
      return;
    }

    // Exemple de traitement logique (appel à l’API, enregistrement local, etc.)
    final date = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    final heure = _selectedTime!.format(context);
    final etat = "En attente";

    print("Demande de rendez-vous enregistrée :");
    print("Date : $date");
    print("Heure : $heure");
    print("État : $etat");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rendez-vous demandé avec succès')),
    );

    // Tu peux ajouter ici : envoi à Firebase, base locale SQLite, ou API Laravel
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demander un rendez-vous')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Date du rendez-vous :", style: TextStyle(fontSize: 16)),
              ElevatedButton(
                onPressed: _pickDate,
                child: Text(formattedDate),
              ),
              SizedBox(height: 16),
              Text("Heure du rendez-vous :", style: TextStyle(fontSize: 16)),
              ElevatedButton(
                onPressed: _pickTime,
                child: Text(formattedTime),
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _demanderRendezVous,
                  child: Text('Demander un rendez-vous'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
