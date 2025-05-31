import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'level1':
        return Colors.red.shade300;
      case 'level2':
        return Colors.orange.shade300;
      case 'level3':
        return Colors.yellow.shade300;
      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Active Cases')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cases').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) return const Center(child: Text("No active cases"));

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              return Card(
                color: _getSeverityColor(data['severity']),
                child: ListTile(
                  title: Text(data['message']),
                  subtitle: Text("Location: ${data['location'][0]}, ${data['location'][1]}\nScore: ${data['score']}"),
                  trailing: Text(data['severity'], style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
