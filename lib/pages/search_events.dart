import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:vers2/design/colors.dart';
import 'package:vers2/pages/map_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DateTime? _selectedDate;
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = 'Выберите дату';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd.MM.yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor,
      body: Column(
        children: [
          const SizedBox(height: 100),
          Expanded(
            child: Container(
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
                            "Найти событие",
                            style: TextStyle(
                              fontSize: 35,
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Чем хочешь заняться?",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: buildTextField("Прогуляться в парке..."),

                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Выбери день",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: buildDateTextField("Дата"),
                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Выбери время",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: TimeInputField(hintText: "со скольки"),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: TimeInputField(hintText: "до скольки"),
                        ),
                        const SizedBox(height: 20),


                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Количество человек",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: buildNumTextField("Количество"),
                        ),
                        const SizedBox(height: 20),


                        MaterialButton(
                          minWidth: 150,
                          height: 70,
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const MapPage()));
                          },
                          color: accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Text(
                            "Найти",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        child: TextField(
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: greyColor,
              fontSize: 18,
            ),

          ),
        ),
      ),
    );
  }

  Widget buildDateTextField(String hintText) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GestureDetector(
        onTap: () {
          _selectDate(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _selectedDate != null
                  ? Text(
                DateFormat('dd.MM.yyyy').format(_selectedDate!),
                style: const TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              )
                  : Text(
                hintText,
                style: const TextStyle(
                  color: greyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              const Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNumTextField(String hintText) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        child: TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(
              fontSize: 18,
          fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: greyColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class TimeInputField extends StatefulWidget {
  final String hintText;

  const TimeInputField({Key? key, required this.hintText}) : super(key: key);

  @override
  _TimeInputFieldState createState() => _TimeInputFieldState();
}

class _TimeInputFieldState extends State<TimeInputField> {
  TimeOfDay? _selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        height: 60,
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedTime != null
                    ? '${_selectedTime!.hour}:${_selectedTime!.minute}'
                    : widget.hintText,
                style: TextStyle(
                  color: _selectedTime != null ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              const Icon(Icons.access_time),
            ],
          ),
        ),
      ),
    );
  }
}

