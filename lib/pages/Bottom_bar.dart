import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:vers2/design/colors.dart';

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
      initialChildSize: 0.8,
      maxChildSize: 0.8,
      minChildSize: 0.5,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(16),
        child: ListView(
          controller: controller,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 0),

              child: Center(
                child: Text(
                  "Мой профиль",
                  style: TextStyle(
                    fontSize: 35,
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
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
                      style: ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
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
                  backgroundImage: AssetImage('assets/img/lahta.jpg'),
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
                      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ],
        ),
      ),
    ),
  );

}
