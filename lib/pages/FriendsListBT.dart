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
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                  builder: (context) => buildSheetFriends(),
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
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(16),
        child: _buildSheetFriends(controller),
      ),
    ),
  );

  Widget buildSheetFriends() => makeDismissible(
    child: DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(16),
        child: _buildSheetFriends(controller),
      ),
    ),
  );

  Widget _buildFindFriendsButton({
    required VoidCallback onPressed,
    required String label,
    required TextEditingController searchController,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: () {
          // Показываем клавиатуру при нажатии на кнопку
          FocusScope.of(context).requestFocus(FocusNode());
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: TextField(
                  controller: searchController,
                  autofocus: true, // Фокус на поле ввода
                  decoration: InputDecoration(
                    labelText: 'Поиск друзей',
                    border: OutlineInputBorder(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Закрыть'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Действие при нажатии на кнопку "Найти"
                      // Можно обработать введенные данные для поиска друзей
                      Navigator.of(context).pop();
                    },
                    child: Text('Найти'),
                  ),
                ],
              );
            },
          );
        },
        child: Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          // Убираем тень
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Colors.white), // Белая граница
          ),
        ),
      ),
    );
  }


  Widget _buildElevatedButtonWithImage({
    required VoidCallback onPressed,
    required String imagePath,
    required String label,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 35,
        ),
        label: Text(
          label,
          style: TextStyle(
            color: blackColor,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: whiteColor,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }



  Widget _buildSheetFriends(ScrollController controller) {
    return ListView(
      controller: controller,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 0),
          child: Center(
            child: Text(
              "Мои друзья",
              style: TextStyle(
                fontSize: 35,
                color: blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        SizedBox(height: 40),


        _buildFindFriendsButton(
          onPressed: () {
            // Действие при нажатии на кнопку "Найти друзей"
          },
          label: 'Найти друзей',
          searchController: _searchController,
        ),
        SizedBox(height: 30),

        _buildElevatedButtonWithImage(
          onPressed: () { },
          imagePath: 'assets/img/stanislav.png',
          label: 'Разделяй и властвуй',
        ),

        SizedBox(height: 15),

        _buildElevatedButtonWithImage(
          onPressed: () { },
          imagePath: 'assets/img/Lizzka.png',
          label: 'БингаБонга Николаева',
        ),

        SizedBox(height: 15), // Расстояние между кнопками

        _buildElevatedButtonWithImage(
          onPressed: () { },
          imagePath: 'assets/img/bingabonga.png',
          label: 'Дочь Полковника',
        ),

        SizedBox(height: 15),

        _buildElevatedButtonWithImage(
          onPressed: () { },
          imagePath: 'assets/img/niger.png',
          label: 'Бездельник',
        ),

        SizedBox(height: 15),

        _buildElevatedButtonWithImage(
          onPressed: () { },
          imagePath: 'assets/img/burat.png',
          label: 'Сын Мамы',
        ),

        SizedBox(height: 15),

        _buildElevatedButtonWithImage(
          onPressed: () { },
          imagePath: 'assets/img/liza_s.png',
          label: 'Пабгер',
        ),

        SizedBox(height: 15),

        _buildElevatedButtonWithImage(
          onPressed: () { },
          imagePath: 'assets/img/sher.png',
          label: 'Старостик',
        ),

        SizedBox(height: 15),

        _buildElevatedButtonWithImage(
          onPressed: () { },
          imagePath: 'assets/img/Lizzka.png',
          label: 'Друг 10',
        ),

        SizedBox(height: 15),

        _buildElevatedButtonWithImage(
          onPressed: () { },
          imagePath: 'assets/img/Lizzka.png',
          label: 'Друг 10',
        ),

        SizedBox(height: 15),

        _buildElevatedButtonWithImage(
          onPressed: () { },
          imagePath: 'assets/img/Lizzka.png',
          label: 'Друг 10',
        ),

        SizedBox(height: 15),

        _buildElevatedButtonWithImage(
          onPressed: () { },
          imagePath: 'assets/img/Lizzka.png',
          label: 'Друг 10',
        ),


        SizedBox(height: 15),

        Row(
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


      ],
    );
  }

}
