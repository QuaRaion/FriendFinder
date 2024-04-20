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
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text(
                          "Мой профиль",
                          style: TextStyle(
                            fontSize: 35,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ), // Добавляем отступ после иконки
                      Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100), // половина ширины и высоты контейнера
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/img/lahta.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                           Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print('Изображение нажато');
                                      // Ваши действия при нажатии
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.settings, color: accentColor, size: 40), // Ваша иконка
                                        SizedBox(width: 10), // Отступ между иконкой и текстом
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  const Text(
                                    "Лахта",
                                    style: TextStyle(
                                      fontSize: 39,
                                      color: accentColor,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  const Row(
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

                      SizedBox(height: 20), // Добавляем отступ после аватара

                      Column(
                        children: [

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Действие при нажатии на кнопку
                              },
                              icon: Icon(Icons.person_2, color: accentColor), // Указываем цвет иконки
                              label: Text('Друзья', style: TextStyle(color: blackColor, fontSize: 20,)), // Указываем цвет текста
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white, // Задаем белый цвет фона
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
                              icon: Icon(Icons.calendar_month, color: accentColor),
                              label: Text('Мои события',style: TextStyle(color: blackColor, fontSize: 20,)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
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
                              icon: Icon(Icons.heart_broken, color: accentColor),
                              label: Text('Любимые события',style: TextStyle(color: blackColor, fontSize: 20,)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
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
                              icon: Icon(Icons.lock, color: accentColor),
                              label: Text('Безопасность',style: TextStyle(color: blackColor, fontSize: 20,)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ),




                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Row(
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
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      print('Изображение нажато');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const CreateScreen()),
                                      );
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


