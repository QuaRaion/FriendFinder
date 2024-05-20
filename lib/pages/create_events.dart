import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:vers2/design/colors.dart';

class CreateScreen extends StatefulWidget {
  final LatLng coordinates;
  const CreateScreen({Key? key, required this.coordinates}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTimeFrom;
  TimeOfDay? _selectedTimeTo;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _peopleController = TextEditingController();

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

  Future<void> _selectTime(BuildContext context, bool isFrom) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _selectedTimeFrom = picked;
        } else {
          _selectedTimeTo = picked;
        }
      });
    }
  }

  void _createEvent() {
    Navigator.pop(context, {
      'title': _titleController.text,
      'date': _dateController.text,
      'timeFrom': _selectedTimeFrom?.format(context) ?? 'N/A',
      'timeTo': _selectedTimeTo?.format(context) ?? 'N/A',
      'people': _peopleController.text,
      'coordinates': widget.coordinates,
    });
  }

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
                              "Создать событие",
                              style: TextStyle(
                                fontSize: 35,
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          buildTextField(_titleController, "Прогуляться в парке..."),
                          const SizedBox(height: 20),
                          buildDateTextField(),
                          const SizedBox(height: 20),
                          buildTimeTextField("со скольки", true),
                          const SizedBox(height: 5),
                          buildTimeTextField("до скольки", false),
                          const SizedBox(height: 20),
                          buildNumTextField(_peopleController, "Количество"),
                          const SizedBox(height: 20),
                          MaterialButton(
                            minWidth: 170,
                            height: 60,
                            onPressed: _createEvent,
                            color: accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text(
                              "Создать",
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
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hintText) {
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
          controller: controller,
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

  Widget buildDateTextField() {
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
                  : const Text(
                'Выберите дату',
                style: TextStyle(
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

  Widget buildTimeTextField(String hintText, bool isFrom) {
    return GestureDetector(
      onTap: () {
        _selectTime(context, isFrom);
      },
      child: Container(
        height: 60,
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (isFrom ? _selectedTimeFrom?.format(context) : _selectedTimeTo?.format(context)) ?? hintText,
                style: const TextStyle(
                  color: blackColor,
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

  Widget buildNumTextField(TextEditingController controller, String hintText) {
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
          controller: controller,
          keyboardType: TextInputType.number,
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
}

