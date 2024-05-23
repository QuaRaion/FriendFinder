import 'package:cloud_firestore/cloud_firestore.dart';
import 'event_model.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createEvent(Event event, String id) async {
    try {
      await _firestore.collection('events').doc(id).set(event.toMap());
      print("Событие успешно добавлено с id: ${id}");
    } catch (e) {
      print("Ошибка при добавлении события: $e");
    }
  }

  Future<List<Event>> getEvents() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('events').get();
      return snapshot.docs
          .map((doc) => Event.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Ошибка при получении событий: $e");
      return [];
    }
  }

}

Future<List<Map<String, dynamic>>> fetchEvents() async {
  final eventsSnapshot = await FirebaseFirestore.instance.collection('events').get();
  return eventsSnapshot.docs.map((doc) => doc.data()).toList();
}
