import 'package:flutter/material.dart';

class S2 extends StatefulWidget {
  final String name;
  final String lastname;
  final String cllg;
  final String age;

  const S2({
    super.key,
    required this.name,
    required this.lastname,
    required this.cllg,
    required this.age, required String email, required String phone,
  });

  @override
  State<S2> createState() => _S2State();
}

class _S2State extends State<S2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('First Name: ${widget.name}', style: TextStyle(fontSize: 24)),
            Text('Last Name: ${widget.lastname}', style: TextStyle(fontSize: 24)),
            Text('College: ${widget.cllg}', style: TextStyle(fontSize: 24)),
            Text('Age: ${widget.age}', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}