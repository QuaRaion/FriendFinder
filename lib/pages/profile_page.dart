import 'package:flutter/material.dart';
import 'package:vers2/design/colors.dart';
import 'map_page.dart';
import 'create_events.dart';
import 'package:flutter/cupertino.dart';
import 'search_events.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime? _selectedDate;

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
                constraints: const BoxConstraints.expand(),
                padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                    topRight: Radius.circular(60.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text(
                          "Мой профиль",
                          style: TextStyle(
                            fontSize: 35,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Stack(
                        children: [
                          const Positioned(
                            right: 16,
                            child: CircleAvatar(
                              radius: 70,
                              // Здесь должен быть ваш аватар
                              backgroundImage: AssetImage('assets/img/logo.png'),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      print('Изображение нажато');
                                      // Фокусировка карты на геолокации пользователя
                                    },
                                    icon: const Icon(Icons.settings),
                                    color: accentColor,
                                    iconSize: 40,
                                  ),
                                  const Text(
                                    "ЛАХТАМЕТ",
                                    style: TextStyle(
                                      fontSize: 39,
                                      color: accentColor,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  const Text(
                                    "Описание профиля",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Действие при нажатии на кнопку
                              },
                              icon: Icon(Icons.person_2),
                              label: Text('Друзья'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ),
                          SizedBox(height: 10), // Отступ между кнопками
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Действие при нажатии на кнопку
                              },
                              icon: Icon(Icons.calendar_month),
                              label: Text('Мои события'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Действие при нажатии на кнопку
                              },
                              icon: Icon(Icons.heart_broken),
                              label: Text('Любимые события'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Действие при нажатии на кнопку
                              },
                              icon: Icon(Icons.lock),
                              label: Text('Безопасность'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Действие при нажатии на кнопку
                                },
                                icon: Icon(CupertinoIcons.location_fill),
                                color: accentColor,
                                iconSize: 40,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('Изображение нажато');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const CreateScreen()),
                                  );
                                },
                                child: Image.asset(
                                  'assets/img/add_events.png',
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  print('Изображение нажато');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                                  );
                                },
                                icon: Icon(Icons.person),
                                color: accentColor,
                                iconSize: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
