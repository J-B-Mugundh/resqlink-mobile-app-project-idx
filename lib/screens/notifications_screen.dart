import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import '../utils/intent_utils.dart'; // ensure this is correctly imported

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
      backgroundColor: const Color(0xFFFFF1F1), // light pastel red
      appBar: AppBar(title: const Text('Active Cases')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cases')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("No active cases"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              final lat = (data['location'][0] as num).toDouble();
              final lng = (data['location'][1] as num).toDouble();

              return GestureDetector(
                onTap: () {
                  // IntentUtils.launchGoogleMaps(latitude: lat, longitude: lng);
                },
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  color: _getSeverityColor(data['severity']),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: ListTile(
                      title: Text(
                        data['message'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Location: $lat, $lng\nScore: ${data['score']}",
                      ),
                      trailing: Text(
                        data['severity'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class NotificationsPage extends StatelessWidget {
//   const NotificationsPage({super.key});

//   Color _getSeverityColor(String severity) {
//     switch (severity.toLowerCase()) {
//       case 'level1':
//         return Colors.red.shade300;
//       case 'level2':
//         return Colors.orange.shade300;
//       case 'level3':
//         return Colors.yellow.shade300;
//       default:
//         return Colors.grey.shade300;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Active Cases')),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('cases')
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final docs = snapshot.data!.docs;

//           if (docs.isEmpty) return const Center(child: Text("No active cases"));

//           return ListView.builder(
//             itemCount: docs.length,
//             itemBuilder: (context, index) {
//               final data = docs[index].data() as Map<String, dynamic>;
//               return Card(
//                 color: _getSeverityColor(data['severity']),
//                 child: ListTile(
//                   title: Text(data['message']),
//                   subtitle: Text(
//                     "Location: ${data['location'][0]}, ${data['location'][1]}\nScore: ${data['score']}",
//                   ),
//                   trailing: Text(
//                     data['severity'],
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
