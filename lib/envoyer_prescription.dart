import 'package:flutter/material.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({Key? key}) : super(key: key);

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  final _formKey = GlobalKey<FormState>();
  final _medicationNoticeController = TextEditingController();

  bool _isSending = false;

  Future<void> _envoyer() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      // Simuler un délai d'envoi
      await Future.delayed(const Duration(seconds: 2));

      final notice = _medicationNoticeController.text;
      print("Notice des médicaments envoyée : $notice");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notice des médicaments envoyée avec succès')),
        );
      }

      _medicationNoticeController.clear();

      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  void dispose() {
    _medicationNoticeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Envoyer une notice de médicaments'),
        backgroundColor: const Color(0xFF10BAC0),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Rédigez ici la notice détaillée des médicaments pour votre patient. "
                  ,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 20),

                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _medicationNoticeController,
                      maxLines: 8,
                      minLines: 6,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Exemple :\n- Prendre 1 comprimé matin et soir\n- Ne pas dépasser 5 jours\n- Conserver à température ambiante",
                        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
                      ),
                      style: const TextStyle(fontSize: 16),
                      validator: (value) =>
                          value == null || value.trim().isEmpty ? 'Veuillez saisir la notice' : null,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isSending ? null : _envoyer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10BAC0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                    ),
                    child: _isSending
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            "Envoyer la notice",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
