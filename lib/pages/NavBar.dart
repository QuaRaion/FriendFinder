import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(
                'Пользователь',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              accountEmail: Text(
                'victor.dunduk@mail.ru',
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/welcome.png',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.indigo.shade900,
            image: DecorationImage(
              image: AssetImage(
                'assets/backforuser.png',
              ),
              fit: BoxFit.cover,
            ),
          )
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Избранное'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Друзья'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Поделиться'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Уведомления'),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                color: Colors.indigo.shade900,
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Настройки'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Политика'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Выход'),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
