import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _travel = true;
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
        children: <Widget>[
          Center(
            child: Text(
              'Создайте свое событие',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Место',
              icon: Icon(
                Icons.location_on,
                size: 25.0,
                color: Colors.indigo.shade900,
              ),
            ),
          ),
          Divider(height: 40.0),
          InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: TextField(
              enabled: false,
              controller: TextEditingController(
                text: _selectedDate != null ? _selectedDate!.toString() : '',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Выберите дату',
                icon: Icon(
                  Icons.calendar_today,
                  size: 25.0,
                  color: Colors.indigo.shade900,
                ),
              ),
            ),
          ),
          Divider(height: 40.0),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Количество человек',
              icon: Icon(
                Icons.person,
                size: 25.0,
                color: Colors.indigo.shade900,
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Возвращаемся на предыдущий экран
              },
              child: Text(
                'Поиск',
                style: TextStyle(
                  fontSize:24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo.shade900),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0)),
                minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(70)),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Действие для кнопки "Самые популярные события"
              },
              child: Text(
                'Самые популярные события',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo.shade900),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0)),
                minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(60)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
