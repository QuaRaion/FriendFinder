import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/cupertino.dart';
import '../design/colors.dart';
import 'search_events.dart';
import 'create_events.dart';
import 'profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final MapController _mapController;
  LatLng? _userLocation;
  final List<Marker> _markers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _checkLocationPermission();
  }

  void _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _isLoading = false; // Скрываем индикатор загрузки, если нет разрешения
        });
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _isLoading = false; // Скрываем индикатор загрузки, если нет разрешения
      });
      return;
    }
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
      _addUserLocationMarker(_userLocation!);
      _mapController.move(_userLocation!, 15);
      _isLoading = false; // Скрываем индикатор загрузки после получения геолокации
      _fetchEvents(); // Загрузка событий при получении геолокации пользователя
    });
  }

  void _addUserLocationMarker(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          width: 40,
          height: 40,
          point: position,
          child: Image.asset(
            'assets/img/user_location.png',
            width: 50,
            height: 50,
          ),
        ),
      );
    });
  }


  Future<void> _fetchEvents() async {
    try {
      final eventsSnapshot = await FirebaseFirestore.instance.collection('events').get();
      final eventsData = eventsSnapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
        _markers.clear();
        _addUserLocationMarker(_userLocation!);

        for (final eventData in eventsData) {
          final LatLng position = LatLng(eventData['latitude'], eventData['longitude']);
          final Map<String, dynamic> details = {
            'creatorUsername': eventData['creatorUsername'],
            'title': eventData['title'],
            'date': eventData['date'],
            'timeFrom': eventData['timeFrom'],
            'timeTo': eventData['timeTo'],
            'peopleCount': eventData['peopleCount'],
          };

          _addMarkerWithDetails(position, details);
        }
      });
    } catch (e) {
      print("Ошибка загрузки событий: $e");
    }
  }


  void _addMarkerWithDetails(LatLng position, Map<String, dynamic> details) {
    setState(() {
      _markers.add(
        Marker(
          width: 40,
          height: 40,
          point: position,
          child: GestureDetector(
            onTap: () {
              _showMarkerInfo(details);
            },
            child: Image.asset(
              'assets/img/marker.png',
              width: 40,
              height: 40,
            ),
          ),
        ),
      );
    });
  }

  void _showMarkerInfo(Map<String, dynamic> markerData) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(markerData['title']?.isNotEmpty == true ? markerData['title']! : 'Не знает чем заняться...',
            style: const TextStyle(
              color: accentColor,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            )
        ),
        content: RichText(
          text: TextSpan(
            style: const TextStyle(
              color: blackColor,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
            children: [
              const TextSpan(
                text: 'Пользователь: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: blackColor,
                  height: 1.7,
                ),
              ),
              TextSpan(text: '${markerData['creatorUsername']}\n',
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: blackColor
                ),
              ),
              const TextSpan(
                text: 'Дата: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: blackColor,
                  height: 1.7,
                ),
              ),
              TextSpan(text: '${markerData['date']}\n',
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: blackColor,
                ),
              ),

              const TextSpan(
                text: 'Со скольки: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: blackColor,
                  height: 1.7,
                ),
              ),
              TextSpan(text: '${markerData['timeFrom']}\n',
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: blackColor
                ),
              ),
              const TextSpan(
                text: 'До скольки: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: blackColor,
                  height: 1.7,

                ),
              ),
              TextSpan(text: '${markerData['timeTo']}\n',
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: blackColor
                ),
              ),
              const TextSpan(
                text: 'Кол-во человек: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: blackColor,
                  height: 1.7,

                ),
              ),
              TextSpan(text: '${markerData['peopleCount']}',
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: blackColor
                ),
              ),
            ],
          ),
        ),

        // actions: <Widget>[
        //
        //     TextButton(
        //     child: const Text('Присоединиться',
        //       style: TextStyle(
        //         color: accentColor,
        //         fontWeight: FontWeight.bold,
        //         fontSize: 18,
        //       ),
        //     ),
        //     onPressed: () {
        //       Navigator.of(ctx).pop();
        //     },
        //   ),
        // ],
      ),
    );
  }


  void _onMapLongPress(TapPosition tapPosition, LatLng point) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateScreen(coordinates: point)),
    );

    if (result != null && result is Map<String, dynamic>) {
      _addMarkerWithDetails(point, result);
    }
    _fetchEvents();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
          FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: _userLocation ?? const LatLng(59.9343, 30.3351),
            zoom: 10,
            onLongPress: _onMapLongPress,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.flutter_map_example',
            ),
            MarkerLayer(markers: _markers),
          ],
        ),
        if (_isLoading)
    const Center(
      child: CircularProgressIndicator(),
    ),
    const Positioned(
    bottom: 82,
    left: 0,
    right: 0,
    child: Center(
    child: Stack(
    alignment: Alignment.center,
    children: [
      // GestureDetector(
      //   onTap: () {
      //     print('Нажата кнопка создания события');
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => CreateScreen(coordinates: _userLocation!)),
      //     );
      //
      //   },
      //   child: Image.asset(
      //     'assets/img/add_events.png',
      //     width: 110,
      //     height: 110,
      //   ),
      // ),
    ],
    ),
    ),
    ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          print('Нажата кнопка фокусировки карты на геолокации пользователя');
                          _fetchEvents();
                          if (_userLocation != null) {
                            _mapController.move(_userLocation!, 15);
                          }
                        },
                        icon: const Icon(CupertinoIcons.location_fill),
                        color: accentColor,
                        iconSize: 40,
                      ),

                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SearchScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text(
                      'Найти событие',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          print('Нажата кнопка открытия профиля');
                          _fetchEvents();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileScreen()),
                          );
                        },
                        icon: const Icon(Icons.person),
                        color: accentColor,
                        iconSize: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
