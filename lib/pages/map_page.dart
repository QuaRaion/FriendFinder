import 'dart:js';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/cupertino.dart';
import '../design/colors.dart';
import 'search_events.dart';
import 'create_events.dart';
import 'profile_page.dart';

class MapState {
  final LatLng? userLocation;
  final List<Marker> markers;
  final bool isLoading;

  MapState({this.userLocation, this.markers = const [], this.isLoading = true});

  MapState copyWith({
    LatLng? userLocation,
    List<Marker>? markers,
    bool? isLoading,
  }) {
    return MapState(
      userLocation: userLocation ?? this.userLocation,
      markers: markers ?? this.markers,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState());

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(state.copyWith(isLoading: false));
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      emit(state.copyWith(isLoading: false));
      return;
    }
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final userLocation = LatLng(position.latitude, position.longitude);
    addUserLocationMarker(userLocation);
    emit(state.copyWith(userLocation: userLocation, isLoading: false));
    fetchEvents(context as BuildContext);
  }

  void addUserLocationMarker(LatLng position) {
    final markers = [
      Marker(
        point: position,
        width: 40,
        height: 40,
        child: Image.asset(
          'assets/img/user_location.png',
          width: 50,
          height: 50,
        ),
      ),
      ...state.markers.where((marker) => marker.point != position),
    ];
    emit(state.copyWith(markers: markers));
  }

  Future<void> fetchEvents(BuildContext context) async {
    try {
      final eventsSnapshot = await FirebaseFirestore.instance.collection('events').get();
      final eventsData = eventsSnapshot.docs.map((doc) => doc.data()).toList();

      final markers = [
        Marker(
          point: state.userLocation!,
          width: 40,
          height: 40,
          child: Image.asset(
            'assets/img/user_location.png',
            width: 50,
            height: 50,
          ),
        ),
        ...eventsData.map((eventData) {
          final LatLng position = LatLng(eventData['latitude'], eventData['longitude']);
          final Map<String, dynamic> details = {
            'creatorUsername': eventData['creatorUsername'],
            'title': eventData['title'],
            'date': eventData['date'],
            'timeFrom': eventData['timeFrom'],
            'timeTo': eventData['timeTo'],
            'peopleCount': eventData['peopleCount'],
          };
          return Marker(
            point: position,
            width: 40,
            height: 40,
            child: GestureDetector(
              onTap: () {
                showMarkerInfo(context, details);
              },
              child: Image.asset(
                'assets/img/marker.png',
                width: 40,
                height: 40,
              ),
            ),
          );
        }).toList()
      ];

      emit(state.copyWith(markers: markers));
    } catch (e) {
      print("Ошибка загрузки событий: $e");
    }
  }


  void showMarkerInfo(BuildContext context, Map<String, dynamic> markerData) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          markerData['title']?.isNotEmpty == true ? markerData['title']! : 'Не знает чем заняться...',
          style: const TextStyle(
            color: accentColor,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
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
              TextSpan(
                text: '${markerData['creatorUsername']}\n',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: blackColor,
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
              TextSpan(
                text: '${markerData['date']}\n',
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
              TextSpan(
                text: '${markerData['timeFrom']}\n',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: blackColor,
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
              TextSpan(
                text: '${markerData['timeTo']}\n',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: blackColor,
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
              TextSpan(
                text: '${markerData['peopleCount']}',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: blackColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit()..checkLocationPermission(),
      child: Scaffold(
        body: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            final mapCubit = context.read<MapCubit>();
            final mapController = MapController(); // Добавляем MapController здесь

            return Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    center: state.userLocation ?? const LatLng(59.9343, 30.3351),
                    zoom: 10,
                    onLongPress: (tapPosition, point) async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateScreen(coordinates: point)),
                      );

                      if (result != null && result is Map<String, dynamic>) {
                        mapCubit.fetchEvents(context); // Обновление событий после создания нового
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.flutter_map_example',
                    ),
                    MarkerLayer(markers: state.markers),
                  ],
                ),
                if (state.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
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
                              mapCubit.fetchEvents(context);
                              if (state.userLocation != null) {
                                mapController.move(state.userLocation!, 15);
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
                              mapCubit.fetchEvents(context);
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
            );
          },
        ),
      ),
    );
  }
}


