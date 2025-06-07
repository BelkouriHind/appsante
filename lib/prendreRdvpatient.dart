import 'package:flutter/material.dart';

class EnregistrerRendezVousPage extends StatefulWidget {
  final Function({
    required String etatRdv,
    required String dateRdv,
    required String heureRdv,
  }) onSave;

  const EnregistrerRendezVousPage({super.key, required this.onSave});

  @override
  State<EnregistrerRendezVousPage> createState() => _EnregistrerRendezVousPageState();
}

class _EnregistrerRendezVousPageState extends State<EnregistrerRendezVousPage> {
  String? _etat;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _enregistrer() {
    if (_etat != null && _selectedDate != null && _selectedTime != null) {
      widget.onSave(
        etatRdv: _etat!,
        dateRdv: "${_selectedDate!.toLocal()}".split(' ')[0],
        heureRdv: _selectedTime!.format(context),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veuillez sélectionner tous les champs.")),
      );
    }
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => _selectedTime = time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saisir un rendez-vous")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _etat,
              hint: Text("Choisir l'état du rendez-vous"),
              onChanged: (value) => setState(() => _etat = value),
              items: ['Validé', 'Annulé'].map((etat) {
                return DropdownMenuItem(value: etat, child: Text(etat));
              }).toList(),
            ),
            SizedBox(height: 16),
            TextButton.icon(
              icon: Icon(Icons.date_range),
              label: Text(
                _selectedDate == null
                    ? "Choisir une date"
                    : "${_selectedDate!.toLocal()}".split(' ')[0],
              ),
              onPressed: _pickDate,
            ),
            TextButton.icon(
              icon: Icon(Icons.access_time),
              label: Text(
                _selectedTime == null
                    ? "Choisir une heure"
                    : _selectedTime!.format(context),
              ),
              onPressed: _pickTime,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _enregistrer,
              child: Text("Enregistrer"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
