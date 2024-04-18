import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vers2/design/colors.dart';
import 'search_event.dart';
import 'package:flutter/cupertino.dart';
import 'NavBar.dart';

class _MapPageState extends State<MapPage> {
  late final MapController _mapController;
  LatLng? _userLocation;
  int _selectedIndex = 0; // Индекс выбранного элемента нижней панели навигации

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
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _userLocation = LatLng(position.latitude, position.longitude);
    print('User location: $_userLocation');
    setState(() {});
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  // Метод для переключения между страницами на основе выбранного элемента
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Ваш FlutterMap
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _userLocation ?? LatLng(59.9343, 30.3351),
              initialZoom: 10,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.flutter_map_example',
              ),
            ],
          ),

          // Ваш поиск
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        hintText: 'Найти событие',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, size: 26),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 82,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Действия при нажатии на изображение
                      print('Изображение нажато');
                    },
                    child: Image.asset(
                      'assets/img/add_events.png', // Путь к вашему изображению PNG
                      width: 100, // Размер изображения
                      height: 100,
                    ),
                  ),
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print('Изображение нажато');
                        // Действия при нажатии на иконку геолокации
                      },
                      icon: Icon(CupertinoIcons.location_fill),
                      color: accentColor, // Цвет иконки
                      iconSize: 40, // Размер иконки
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                  child: Text(
                    'Создать событие',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    textStyle: TextStyle(fontSize: 22),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                ),

                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print('Изображение нажато');
                        // Действия при нажатии на иконку геолокации
                      },
                      icon: Icon(Icons.person),
                      color: accentColor, // Цвет иконки
                      iconSize: 50, // Размер иконки
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


class MapPage extends StatefulWidget {
  const MapPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}
