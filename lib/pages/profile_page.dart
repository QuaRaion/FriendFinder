import 'package:flutter/material.dart';
import 'package:vers2/design/colors.dart';
import 'package:vers2/pages/settings_page.dart';
import 'map_page.dart';
import 'create_events.dart';
import 'package:flutter/cupertino.dart';
import 'search_events.dart';
import 'settings_page.dart';


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
                            fontSize: 40,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/img/avatar.jpeg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                           const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    "Лахта",
                                    style: TextStyle(
                                      fontSize: 39,
                                      color: accentColor,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.edit, color: Colors.grey, size: 20), // Иконка редактирования
                                      SizedBox(width: 5), // Отступ между иконкой и текстом
                                      Text(
                                        "Редактировать профиль",
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
                        ],
                      ),

                      const SizedBox(height: 20),

                      Column(
                        children: [

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Действие при нажатии на кнопку
                              },
                              icon: const Icon(Icons.people_alt_rounded,
                                  color: accentColor,
                                  size: 30,
                              ), // Указываем цвет иконки
                              label: const Text('Друзья', style: TextStyle(color: blackColor, fontSize: 22,)), // Указываем цвет текста
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white, // Задаем белый цвет фона
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Действие при нажатии на кнопку
                              },
                              icon: const Icon(Icons.calendar_month,
                                color: accentColor,
                                size: 30,
                              ),
                              label: const Text('Мои события',style: TextStyle(color: blackColor, fontSize: 22,)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Действие при нажатии на кнопку
                              },
                              icon: const Icon(Icons.favorite,
                                  color: accentColor,
                                  size: 30,
                              ),
                              label: const Text('Любимые события',
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 22,)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ),

                          const SizedBox(height: 80),

                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    print('Нажата кнопка открытия карты');
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
                                          spreadRadius: 3, // Радиус рассеивания тени
                                          blurRadius: 9, // Радиус размытия тени
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
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      print('Кнопка создания события нажата');
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => const CreateScreen()),
                                      // );
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        'assets/img/add_events.png',
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print('Нажата кнопка открытия настроек');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const SettingsScreen()),
                                    );
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
                                          spreadRadius: 3, // Радиус рассеивания тени
                                          blurRadius: 9, // Радиус размытия тени
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.settings,
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


