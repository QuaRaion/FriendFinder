import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'login_page.dart';
import 'package:vers2/design/colors.dart';
import 'create_events.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyFriendsScreen(),
  ));
}

class MyFriendsScreen extends StatefulWidget {
  const MyFriendsScreen({Key? key}) : super(key: key);

  @override
  _MyFriendsScreenState createState() => _MyFriendsScreenState();
}

class _MyFriendsScreenState extends State<MyFriendsScreen> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentColor,
        title: Text('Modal Bottom Sheet'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(
              text: 'Кнопка',
              onClicked: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => buildSheet(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );

  Widget makeDismissible({required Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.of(context).pop(),
    child: GestureDetector(onTap: () {}, child: child),
  );

  Widget buildSheet() => makeDismissible(
    child: DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(16),
        child: _buildSheetContent(controller),
      ),
    ),
  );

  Widget _buildSheetContent(ScrollController controller) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Center(
            child: Text(
              "Настройки",
              style: TextStyle(
                fontSize: 35,
                color: blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        Expanded(
          child: ListView(
            controller: controller,
            children: [
              buildTwoButtonsWithIconAndText(),
              const SizedBox(height: 20),
              buildLogoutButton(
                onPressed: () {
                  // Действие при нажатии на кнопку
                },
              ),
              // Убран лишний child
            ],
          ),
        ),
        // Размещаем Row внизу экрана

        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  print('На карту');
                  // Фокусировка карты на геолокации пользователя
                },
                icon: const Icon(CupertinoIcons.location_fill),
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
                  print('Настройки');
                },
                icon: const Icon(Icons.person),
                color: accentColor,
                iconSize: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget buildLogoutButton({
    required VoidCallback onPressed,
  }) =>
      Container(
        height: 70,
        width: 362,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            backgroundColor: Colors.white, // Цвет кнопки
          ),
          child: Text(
            'Выйти из аккаунта',
            style: TextStyle(fontSize: 20,
                color: Colors.redAccent),
          ),
        ),
      );

  Widget buildTwoButtonsWithIconAndText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 173,
          height: 173,
          child: ElevatedButton(
            onPressed: () {
              // Действие при нажатии на кнопку
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mail,
                  size: 70,
                  color: accentColor,
                ),
                Text(
                  'Сменить\nпочту',
                  style: TextStyle(color: accentColor, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
        SizedBox(
          width: 173,
          height: 173,
          child: ElevatedButton(
            onPressed: () {
              // Действие при нажатии на кнопку
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 70,
                  color: accentColor,
                ),
                Text(
                  'Поменять\nпароль',
                  style: TextStyle(color: accentColor, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }



}
