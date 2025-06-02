import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'EspacePatient2.dart';
import 'login.dart'; // Import the package

class PhoneNumberInputPage extends StatefulWidget {
  const PhoneNumberInputPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberInputPage> createState() => _PhoneNumberInputPageState();
}

class _PhoneNumberInputPageState extends State<PhoneNumberInputPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isNextButtonEnabled = false;
  String? _fullPhoneNumber; // To store the complete phone number with country code

  @override
  void initState() {
    super.initState();
    _phoneNumberController.addListener(_validatePhoneNumber);
    // You might want to initialize with a default value, like "0650-123456"
    // _phoneNumberController.text = '0650-123456';
    // _validatePhoneNumber(); // Call validation if you set an initial text
  }

  @override
  void dispose() {
    _phoneNumberController.removeListener(_validatePhoneNumber);
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _validatePhoneNumber() {
    // This is a basic validation. For real-world apps, you'd use more robust validation.
    // For simplicity, we'll enable the button if the text field is not empty.
    // The intl_phone_field package also provides its own validation mechanisms.
    setState(() {
      _isNextButtonEnabled = _phoneNumberController.text.isNotEmpty && (_fullPhoneNumber != null && _fullPhoneNumber!.length > 5); // A simple check for length
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inscrivez vos informations',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
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
                      backgroundColor: index == 2 ? Colors.blue : Colors.grey[300], // Highlight step 3
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          color: index == 2 ? Colors.white : Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (index == 2) // Only show text for the active step
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Numéro de téléphone',
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
            // Phone Number Input Field Container
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
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Numéro de téléphone',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  IntlPhoneField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Numéro de téléphone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    initialCountryCode: 'MA', // Set an initial country code, e.g., 'MA' for Morocco
                    onChanged: (phone) {
                      print(phone.completeNumber); // This will give you the full number with country code
                      _fullPhoneNumber = phone.completeNumber;
                      _validatePhoneNumber(); // Re-validate on change
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ${country.name}');
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // You can add validation logic here using validator
                    validator: (phoneNumber) {
                      if (phoneNumber == null || phoneNumber.number.isEmpty) {
                        return 'Veuillez entrer votre numéro de téléphone';
                      }
                      // Add more specific validation if needed
                      // Example: if (!phoneNumber.isValidNumber()) return 'Numéro de téléphone invalide';
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Navigation Buttons (Précédent and Suivant)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>BirthdayInputPage ()),
                        );
                      // Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    label: const Text(
                      'PRÉCÉDENT',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(color: Colors.blue, width: 1.5),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: 
                         () {
                           Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage ()),
                        );
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => NextFormPage()));
                          },
                         // Disable if _isNextButtonEnabled is false
                    icon: Icon(Icons.arrow_forward, color: _isNextButtonEnabled ? Colors.white : Colors.blueGrey[300]),
                    label: Text(
                      'SUIVANT',
                      style: TextStyle(color:  Colors.white , fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isNextButtonEnabled ? Colors.blue : Colors.blue[100], // Change color when disabled
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 0,
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