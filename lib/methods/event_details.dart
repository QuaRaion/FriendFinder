import 'package:flutter/material.dart';
import 'event_model.dart';

class EventDetails extends StatelessWidget {
  final Event event;

  const EventDetails({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Created by: ${event.creatorUsername} (${event.creatorEmail})'),
        ],
      ),
    );
  }
}
