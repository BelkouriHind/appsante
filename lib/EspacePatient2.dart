import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'EspacePatient3.dart'; 
import 'EspacePatient.dart';// Make sure to add intl to your pubspec.yaml if you haven't:
                                  // dependencies:
                                  //   flutter:
                                  //     sdk: flutter
                                  //   intl: ^0.18.0 (or latest version)

class BirthdayInputPage extends StatefulWidget {
  const BirthdayInputPage({Key? key}) : super(key: key);

  @override
  State<BirthdayInputPage> createState() => _BirthdayInputPageState();
}

class _BirthdayInputPageState extends State<BirthdayInputPage> {
  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Set initial date as 08/05/2007 (May 8, 2007)
    _selectedDate = DateTime(2007, 5, 8);
    _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900), // An arbitrary past date
      lastDate: DateTime.now(), // Cannot select a future date
      helpText: 'SÉLECTIONNER LA DATE DE NAISSANCE', // Customization for the date picker
      cancelText: 'ANNULER',
      confirmText: 'CONFIRMER',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Header background color
            colorScheme: const ColorScheme.light(primary: Colors.blue), // Controls various colors
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inscrivez vos informations',
          style: TextStyle(color: Colors.black87), // AppBar title color
        ),
        backgroundColor: Colors.white, // AppBar background color
        elevation: 0, // No shadow for AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Indicator (Steps)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: index == 1 ? Colors.blue : Colors.grey[300], // Highlight step 2
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          color: index == 1 ? Colors.white : Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (index == 1) // Only show text for the active step
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Date de naissance',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 40),
            // Date of Birth Input Field Container
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date de naissance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _dateController,
                    readOnly: true, // Make it read-only, user picks from calendar
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      hintText: 'jj/mm/aaaa',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today, color: Colors.blue),
                        onPressed: () => _selectDate(context),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none, // No border line
                      ),
                      filled: true,
                      fillColor: Colors.grey[100], // Background color of the input field
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const Spacer(), // Pushes buttons to the bottom
            // Navigation Buttons (Précédent and Suivant)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle previous button action
                                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>PatientInscriptionPage ()),
                        );
                      // Navigator.pop(context); // Example: go back to the previous screen
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    label: const Text(
                      'PRÉCÉDENT',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Button background
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(color: Colors.blue, width: 1.5), // Border for previous button
                      ),
                      elevation: 0, // No shadow
                    ),
                  ),
                ),
                const SizedBox(width: 16), // Space between buttons
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                       Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PhoneNumberInputPage()),
    );
                    },
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    label: const Text(
                      'SUIVANT',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Button background
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 0, // No shadow
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}