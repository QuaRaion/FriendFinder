import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../design/colors.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({Key? key}) : super(key: key);

  @override
  _MyEventsScreenState createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  late User? currentUser;
  List<Map<String, dynamic>> events = [];

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _fetchUserEvents(currentUser!.email!);
    }
  }

  Future<void> _fetchUserEvents(String email) async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('events').where('creatorEmail', isEqualTo: email).get();

      setState(() {
        events = snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  Future<void> _deleteEvent(String eventId) async {
    final snapshot = await FirebaseFirestore.instance.collection('events').where('id', isEqualTo: eventId).get();
    try {
      setState(() {
        events.removeWhere((event) => event['id'] == eventId);
      });
      await FirebaseFirestore.instance.collection('events').doc(eventId).delete();
    } catch (e) {
      print('Error deleting event: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor,
      body: Padding(
        padding: MediaQuery.of(context).size.width > 600
            ? EdgeInsets.symmetric(
          horizontal: (MediaQuery.of(context).size.width - 430) * 0.49,
        )
            : EdgeInsets.zero,
        child: Column(
          children: [
            const SizedBox(height: 100),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                    topRight: Radius.circular(60.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text(
                        "Мои события",
                        style: TextStyle(
                          fontSize: 40,
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          var event = events[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 9,
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              title: Text(
                                event['title']?.isNotEmpty == true
                                    ? event['title']!
                                    : 'Не знаю чем заняться',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: accentColor,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              subtitle: Text(
                                event['date']?.isNotEmpty == true
                                    ? event['date']!
                                    : 'Без даты',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: blackColor,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_rounded,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onPressed: () {
                                  _deleteEvent(event['id']);
                                },
                              ),
                              onTap: () {

                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              print('Нажата кнопка открытия карты');
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.map_rounded,
                                color: accentColor,
                                size: 45,
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       print('Кнопка создания события нажата');
                          //       // Navigator.push(
                          //       //   context,
                          //       //   MaterialPageRoute(builder: (context) => const CreateScreen()),
                          //       // );
                          //     },
                          //     child: Align(
                          //       alignment: Alignment.center,
                          //       child: Image.asset(
                          //         'assets/img/add_events.png',
                          //         width: 100,
                          //         height: 100,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          InkWell(
                            onTap: () {
                              print('Нажата кнопка закрытия настроек');
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 9,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.person,
                                color: accentColor,
                                size: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
