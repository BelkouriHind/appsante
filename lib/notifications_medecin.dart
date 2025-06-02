import 'package:flutter/material.dart';

class NotificationsMedecinPage extends StatefulWidget {
  @override
  _NotificationsMedecinPageState createState() => _NotificationsMedecinPageState();
}

class _NotificationsMedecinPageState extends State<NotificationsMedecinPage> {
  final _formKey = GlobalKey<FormState>();
  final _patientIdController = TextEditingController();
  final _messageController = TextEditingController();

  void _envoyerNotification() {
    if (_formKey.currentState!.validate()) {
      final id = _patientIdController.text;
      final message = _messageController.text;
      print("Notification envoyée à $id : $message");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notification envoyée à $id')),
      );

      _patientIdController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Envoyer une notification')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _patientIdController,
                decoration: InputDecoration(labelText: 'ID du patient'),
                validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              ),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(labelText: 'Contenu du message'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _envoyerNotification,
                child: Text('Envoyer'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
