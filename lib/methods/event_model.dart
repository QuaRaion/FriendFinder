class Event {
  final String id;
  final String title;
  final String date;
  final String timeFrom;
  final String timeTo;
  final String peopleCount;
  final double latitude;
  final double longitude;
  final String creatorEmail;
  final String creatorUsername;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.peopleCount,
    required this.latitude,
    required this.longitude,
    required this.creatorEmail,
    required this.creatorUsername,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'peopleCount': peopleCount,
      'latitude': latitude,
      'longitude': longitude,
      'creatorEmail': creatorEmail,
      'creatorUsername': creatorUsername,
    };
  }

  factory Event.fromMap(String id, Map<String, dynamic> map) {
    return Event(
      id: id,
      title: map['title'],
      date: map['date'],
      timeFrom: map['timeFrom'],
      timeTo: map['timeTo'],
      peopleCount: map['peopleCount'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      creatorEmail: map['creatorEmail'],
      creatorUsername: map['creatorUsername'],
    );
  }
}
