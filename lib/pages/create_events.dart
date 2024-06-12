import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import '../methods/event_model.dart';
import '../methods/event_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vers2/design/colors.dart';

class CreateEventState {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTimeFrom;
  final TimeOfDay? selectedTimeTo;
  final bool isLoading;

  CreateEventState({
    this.selectedDate,
    this.selectedTimeFrom,
    this.selectedTimeTo,
    this.isLoading = false,
  });
}

class CreateEventCubit extends Cubit<CreateEventState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeFromController = TextEditingController();
  final TextEditingController timeToController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController peopleCountController = TextEditingController();

  CreateEventCubit() : super(CreateEventState());

  void selectDate(DateTime date) {
    dateController.text = DateFormat('dd.MM.yyyy').format(date);
    emit(CreateEventState(
      selectedDate: date,
      selectedTimeFrom: state.selectedTimeFrom,
      selectedTimeTo: state.selectedTimeTo,
      isLoading: state.isLoading,
    ));
  }

  void selectTimeFrom(TimeOfDay time) {
    timeFromController.text = _formatTime(time);
    emit(CreateEventState(
      selectedDate: state.selectedDate,
      selectedTimeFrom: time,
      selectedTimeTo: state.selectedTimeTo,
      isLoading: state.isLoading,
    ));
  }

  void selectTimeTo(TimeOfDay time) {
    timeToController.text = _formatTime(time);
    emit(CreateEventState(
      selectedDate: state.selectedDate,
      selectedTimeFrom: state.selectedTimeFrom,
      selectedTimeTo: time,
      isLoading: state.isLoading,
    ));
  }

  Future<String> _getCurrentUserEmail() async {
    User? user = _auth.currentUser;
    return user?.email ?? '';
  }

  Future<String> _getUsernameByEmail(String email) async {
    String username = "Аноним";
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data() as Map<String, dynamic>;
        username = data['username'] ?? "Аноним";
      }
    } catch (e) {
      print("Ошибка при получении имени пользователя: $e");
    }
    return username;
  }

  Future<void> createEvent(BuildContext context, LatLng coordinates) async {
    emit(CreateEventState(
      selectedDate: state.selectedDate,
      selectedTimeFrom: state.selectedTimeFrom,
      selectedTimeTo: state.selectedTimeTo,
      isLoading: true,
    ));

    String email = await _getCurrentUserEmail();
    String username = await _getUsernameByEmail(email);

    CollectionReference eventsCollection = FirebaseFirestore.instance.collection('events');
    DocumentReference newEventDoc = eventsCollection.doc();
    String newEventId = newEventDoc.id;

    Event event = Event(
      id: newEventId,
      title: titleController.text,
      date: dateController.text,
      timeFrom: timeFromController.text,
      timeTo: timeToController.text,
      peopleCount: peopleCountController.text,
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
      creatorEmail: email,
      creatorUsername: username,
    );

    print("Создание события: ${event.toMap()}");

    try {
      await EventService().createEvent(event, newEventId);
      print("Событие успешно создано");
    } catch (e) {
      print("Ошибка при создании события: $e");
    }

    emit(CreateEventState(
      selectedDate: state.selectedDate,
      selectedTimeFrom: state.selectedTimeFrom,
      selectedTimeTo: state.selectedTimeTo,
      isLoading: false,
    ));

    Navigator.pop(context);
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final formattedTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(formattedTime);
  }
}

class CreateScreen extends StatelessWidget {
  final LatLng coordinates;
  const CreateScreen({Key? key, required this.coordinates}) : super(key: key);

  Future<void> _selectDate(BuildContext context, CreateEventCubit cubit) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      cubit.selectDate(picked);
    }
  }

  Future<void> _selectTime(BuildContext context, bool isFrom, CreateEventCubit cubit) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      isFrom ? cubit.selectTimeFrom(picked) : cubit.selectTimeTo(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateEventCubit(),
      child: Scaffold(
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
                        BlocBuilder<CreateEventCubit, CreateEventState>(
                          builder: (context, state) {
                            final cubit = context.read<CreateEventCubit>();
                            return Column(
                              children: <Widget>[
                                buildTextField(
                                    cubit.titleController,
                                    "Прогуляться в парке..."),
                                const SizedBox(height: 20),
                                buildDateTextField(context, state, cubit),
                                const SizedBox(height: 20),
                                buildTimeTextField(
                                    context,
                                    "со скольки",
                                    true,
                                    state,
                                    cubit),
                                const SizedBox(height: 5),
                                buildTimeTextField(
                                    context,
                                    "до скольки",
                                    false,
                                    state,
                                    cubit),
                                const SizedBox(height: 20),
                                buildNumTextField(
                                    cubit.peopleCountController,
                                    "Количество"),
                                const SizedBox(height: 20),
                                MaterialButton(
                                  minWidth: 170,
                                  height: 60,
                                  onPressed: () =>
                                      cubit.createEvent(context, coordinates),
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
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
            border: InputBorder.none,hintText: hintText,
            hintStyle: const TextStyle(
              color: greyColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDateTextField(BuildContext context, CreateEventState state, CreateEventCubit cubit) {
    return GestureDetector(
      onTap: () => _selectDate(context, cubit),
      child: AbsorbPointer(
        child: buildTextField(cubit.dateController, "Выберите дату"),
      ),
    );
  }

  Widget buildTimeTextField(BuildContext context, String hintText, bool isFrom, CreateEventState state, CreateEventCubit cubit) {
    return GestureDetector(
      onTap: () => _selectTime(context, isFrom, cubit),
      child: AbsorbPointer(
        child: buildTextField(isFrom ? cubit.timeFromController : cubit.timeToController, hintText),
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
