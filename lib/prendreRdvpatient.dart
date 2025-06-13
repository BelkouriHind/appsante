import 'package:flutter/material.dart';

class EnregistrerRendezVousPage extends StatefulWidget {
  final Function({
    required String dateRdv,
    required String heureRdv,
  }) onSave;

  const EnregistrerRendezVousPage({super.key, required this.onSave});

  @override
  State<EnregistrerRendezVousPage> createState() => _EnregistrerRendezVousPageState();
}

class _EnregistrerRendezVousPageState extends State<EnregistrerRendezVousPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _enregistrer() {
    if (_selectedDate != null && _selectedTime != null) {
      widget.onSave(
        dateRdv: "${_selectedDate!.toLocal()}".split(' ')[0],
        heureRdv: _selectedTime!.format(context),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez choisir une date et une heure.")),
      );
    }
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
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
      appBar: AppBar(
        title: const Text("Prendre un rendez-vous"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Sélectionner la date et l'heure du rendez-vous",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _pickDate,
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Date du rendez-vous",
                    hintText: _selectedDate != null
                        ? "${_selectedDate!.toLocal()}".split(' ')[0]
                        : "Choisir une date",
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pickTime,
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Heure du rendez-vous",
                    hintText: _selectedTime != null
                        ? _selectedTime!.format(context)
                        : "Choisir une heure",
                    prefixIcon: const Icon(Icons.access_time),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _enregistrer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Enregistrer", style: TextStyle(fontSize: 16,color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
