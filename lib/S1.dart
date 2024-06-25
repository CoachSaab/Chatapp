import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/S2.dart';
import 'package:intl/intl.dart';

class S1 extends StatefulWidget {
  const S1({super.key});

  @override
  State<S1> createState() => _S1State();
}

class _S1State extends State<S1> {
  final TextEditingController _fstnam = TextEditingController();
  final TextEditingController _college = TextEditingController();
  final TextEditingController _lastnam = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = DateFormat.yMMMd().format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 370,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: "First Name"),
                    controller: _fstnam,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(hintText: "Last Name"),
                    controller: _lastnam,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(hintText: "College Name"),
                    controller: _college,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(hintText: "Age"),
                    controller: _age,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Select Date',
                    ),
                    readOnly: true,
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 350),
                      child: Center(child: Icon(Icons.calendar_month)),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Email"),
                    controller: _email,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(hintText: "Phone Number"),
                    controller: _phone,
                  ),
                  SizedBox(height: 20),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String firstname = _fstnam.text;
                      String lastname = _lastnam.text;
                      String cllg = _college.text;
                      String age = _age.text;
                      String email = _email.text;
                      String phone = _phone.text;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => S2(
                            name: firstname,
                            lastname: lastname,
                            cllg: cllg,
                            age: age,
                            email: email,
                            phone: phone,
                          ),
                        ),
                      );
                    },
                    child: Text('Send to S2'),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}