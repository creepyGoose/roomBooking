import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'home_screen.dart';

final databaseReference = Firestore.instance;
final roomController = TextEditingController();
final checkInDayController = TextEditingController();
final format = DateFormat("dd-MM-yyyy HH:mm");
final FirebaseAuth auth = FirebaseAuth.instance;
final _scaffoldKey = GlobalKey<ScaffoldState>();

void createRecord() async {
  final FirebaseUser user = await auth.currentUser();
  final uid = user.uid;
  databaseReference
      .collection("users")
      .document(uid)
      .collection("schedule")
      .add({'sala': roomController.text, 'checkIn': checkInDayController.text});
}

final List<Map<String, dynamic>> _items = [
  {
    'label': 'Sala de Reunião 1',
    'value': 'Sala de Reunião 1',
  },
  {
    'label': 'Sala de Reunião 2',
    'value': 'Sala de Reunião 2',
  },
  {
    'label': 'Sala de Reunião 3',
    'value': 'Sala de Reunião 3',
  },
];

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Agendamento';
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: true,
      ),
      body: MyCustomForm(),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  //String _initialValue;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SelectFormField(
                controller: roomController,
                //icon: Icon(Icons.door_front_outlined),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Selecione uma Sala',
                ),

                changeIcon: true,
                items: _items,

                onChanged: (val) => setState(() => _valueChanged = val),
                validator: (val) {
                  setState(() => _valueToValidate = val ?? '');
                  return null;
                },
                onSaved: (val) => setState(() => _valueSaved = val ?? ''),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: DateTimeField(
                  decoration: InputDecoration(
                    labelText: 'Insira a data e a hora',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  format: format,
                  controller: checkInDayController,
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2021),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.combine(date, time);
                    } else {
                      return currentValue;
                    }
                  },
                )),
            new Container(
                padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                child: new ElevatedButton(
                  child: const Text('Agendar Sala'),
                  style: ElevatedButton.styleFrom(onPrimary: Colors.white),
                  onPressed: () {
                    // It returns true if the form is valid, otherwise returns false
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Registro Concluído"),
                          backgroundColor: Theme.of(context).primaryColor));
                      createRecord();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
