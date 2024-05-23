import 'package:flutter/material.dart';
import '../design/colors.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor,
      body: Padding(
        padding: MediaQuery.of(context).size.width > 600
            ? EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width - 430) * 0.49,)
            : EdgeInsets.zero,
        child: Column(
          children: [
            const SizedBox(height: 100),
            Expanded(
              child: Container(
                width: double.infinity,
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
                      Column(
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Text(
                              "Настройки",
                              style: TextStyle(
                                fontSize: 40,
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  fixedSize: const Size(180, 180),
                                  elevation: 6,
                                  shadowColor: Colors.black.withOpacity(0.3),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.mail_rounded,
                                      color: accentColor,
                                      size: 60,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Сменить почту',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: blackColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white, // Устанавливаем цвет кнопки
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  fixedSize: const Size(180, 180),
                                  elevation: 6,
                                  shadowColor: Colors.black.withOpacity(0.3),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.lock_rounded,
                                      color: accentColor,
                                      size: 60,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Поменять пароль',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: blackColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const LoginPage()
                                    )
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                minimumSize: const Size(double.infinity, 80),
                                elevation: 6,
                                shadowColor: Colors.black.withOpacity(0.3),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    'Выйти из аккаунта',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 130),

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
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}