import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'contenu': 'Votre rendez-vous du 2 juin est confirmé.',
      'date': '2025-05-30'
    },
    {
      'contenu': 'Nouvelles recommandations santé disponibles.',
      'date': '2025-05-29'
    },
    {
      'contenu': 'Votre tension a dépassé le seuil normal.',
      'date': '2025-05-28'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? Center(child: Text('Aucune notification pour le moment.'))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Icon(Icons.notifications_active, color: Colors.blue),
                    title: Text(notif['contenu'] ?? ''),
                    subtitle: Text('Reçu le : ${notif['date']}'),
                  ),
                );
              },
            ),
    );
  }
}
