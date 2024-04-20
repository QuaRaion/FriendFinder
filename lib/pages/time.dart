import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Лахтавлад",
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 40,
                                  color: accentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: null,
                                // действия при нажатии на кнопку редактирования профиля
                                style: ButtonStyle(
                                  padding:
                                      MaterialStatePropertyAll(EdgeInsets.zero),
                                  alignment: Alignment.topLeft,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      size: Checkbox.width,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "Редактировать профиль",
                                      style: TextStyle(
                                        color: greyColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          CircleAvatar(
                            radius: 55,
                            // Здесь должен быть аватар пользователя
                            backgroundImage:
                                AssetImage('assets/img/account.png'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 70,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Действие при нажатии на кнопку
                              },
                              icon: const Icon(
                                Icons.people_alt_rounded,
                                color: accentColor,
                                size: 32,
                              ),
                              label: const Text(
                                'Друзья',
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: whiteColor,
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          SizedBox(
                            width: double.infinity,
                            height: 70,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Действие при нажатии на кнопку
                              },
                              icon: const Icon(
                                Icons.calendar_today_rounded,
                                color: accentColor,
                                size: 32,
                              ),
                              label: const Text(
                                'Мои события',
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: whiteColor,
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ), // Отступ между кнопками
                          const SizedBox(height: 15),

                          SizedBox(
                            width: double.infinity,
                            height: 70,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Действие при нажатии на кнопку
                              },
                              icon: const Icon(
                                Icons.favorite_rounded,
                                color: accentColor,
                                size: 32,
                              ),
                              label: const Text(
                                'Любимые события',
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: whiteColor,
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          SizedBox(
                            width: double.infinity,
                            height: 70,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Действие при нажатии на кнопку
                              },
                              icon: const Icon(
                                Icons.local_fire_department_rounded,
                                color: accentColor,
                                size: 32,
                              ),
                              label: const Text(
                                'Популярные события',
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: whiteColor,
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Material(
                                elevation: 4, // Высота тени
                                shadowColor: Colors.black.withOpacity(0.6),
                                shape: const CircleBorder(),
                                color: whiteColor.withOpacity(0.9),
                                child: SizedBox(
                                  width: 65,
                                  height: 65,
                                  child: IconButton(
                                    onPressed: () {
                                      // Действие при нажатии на кнопку
                                    },
                                    icon: const Icon(CupertinoIcons.globe,
                                        size: 50),
                                    color: accentColor,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('Изображение нажато');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateScreen()),
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
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileScreen()),
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
