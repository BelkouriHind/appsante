import 'package:flutter/material.dart';
import 'EspacePatient2.dart'; // Ensure this import path is correct for your project structure
import 'EspacePatient2.dart'; // IMPORTANT: Make sure this path is correct for your BirthdayInputPage file

// Placeholder for BirthdayInputPage if it's not imported or defined elsewhere
// If you have your actual BirthdayInputPage, remove this placeholder.



class PatientInscriptionPage extends StatefulWidget {
  const PatientInscriptionPage({super.key});

  @override
  State<PatientInscriptionPage> createState() => _PatientInscriptionPageState();
}

class _PatientInscriptionPageState extends State<PatientInscriptionPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  String? _nom;
  String? _prenom;
  String? _sexe;
  String? _adresse;
  String? _email;
  String? _password;
   String? _sexeErrorMessage;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  // Helper method for step number display
  Widget _buildStepNumber(int number, {bool isActive = false, String? label}) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (isActive && label != null) // Only show label if active and provided
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  // Helper method for step line display
  Widget _buildStepLine() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey[300],
        margin: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
   // Custom validation for Sexe when form is submitted
  bool _validateSexe() {
    if (_sexe == null || _sexe!.isEmpty) {
      setState(() {
        _sexeErrorMessage = 'Veuillez sélectionner votre sexe';
      });
      return false;
    }
    setState(() {
      _sexeErrorMessage = null; // Clear error if valid
    });
    return true;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final patientData = {
        'nom': _nom,
        'prenom': _prenom,
        'sexe': _sexe,
        'adresse': _adresse,
        'email': _email,
        'password': _password,
      };

      debugPrint('Patient Data: $patientData');

      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // Header with title
            Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: const Text(
                'Inscrivez vos informations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Step numbering and label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStepNumber(1, isActive: true, label: 'Identité'), // <--- Changed here
                  _buildStepLine(),
                  _buildStepNumber(2),
                  _buildStepLine(),
                  _buildStepNumber(3),
                  _buildStepLine(),
                  _buildStepNumber(4),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // Removed the separate "Identité" Text widget here
            // const Text(
            //   'Identité',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 20), // Adjusted spacing accordingly

            // Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                     // Sexe (Gender) - Radio Buttons in a Row
                      const Text(
                        'Sexe',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text(
                                'Homme',
                                style: TextStyle(fontSize: 10), // Applied font size 12
                              ),
                              value: 'Homme',
                              groupValue: _sexe,
                              onChanged: (String? value) {
                                setState(() {
                                  _sexe = value;
                                  _sexeErrorMessage = null;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text(
                                'Femme',
                                style: TextStyle(fontSize: 10), // Applied font size 12
                              ),
                              value: 'Femme',
                              groupValue: _sexe,
                              onChanged: (String? value) {
                                setState(() {
                                  _sexe = value;
                                  _sexeErrorMessage = null;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      // Display selected gender and/or validation error
                      if (_sexe != null && _sexe!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Text(
                            'Sexe sélectionné : $_sexe', // Show selected sex
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.green, // Or Colors.blue for selection
                            ),
                          ),
                        )
                      else if (_sexeErrorMessage != null) // Display validation error
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Text(
                            _sexeErrorMessage!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
                        ),


                      // Nom and Prénom
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Nom',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre nom';
                                }
                                return null;
                              },
                              onSaved: (value) => _nom = value,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Prénom',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor:Colors.white,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre prénom';
                                }
                                return null;
                              },
                              onSaved: (value) => _prenom = value,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),


                      const SizedBox(height: 10),

                      // Adresse (Address)
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Adresse',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre adresse';
                          }
                          return null;
                        },
                        onSaved: (value) => _adresse = value,
                      ),

                      const SizedBox(height: 20),

                      // Email
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Email invalide';
                          }
                          return null;
                        },
                        onSaved: (value) => _email = value,
                      ),

                      const SizedBox(height: 20),

                      // Mot de passe
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Mot de passe',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un mot de passe';
                          }
                          if (value.length < 6) {
                            return 'Le mot de passe doit avoir au moins 6 caractères';
                          }
                          return null;
                        },
                        onSaved: (value) => _password = value,
                      ),

                      const SizedBox(height: 30),

                      // SUIVANT Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                   Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>BirthdayInputPage ()),
                        );
                },
                          child: const Text(
                            'SUIVANT',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}