import 'package:flutter/material.dart';

class ContactinfoScreen extends StatefulWidget {
  const ContactinfoScreen({super.key});

  @override
  State<ContactinfoScreen> createState() => _ContactinfoScreenState();
}

class _ContactinfoScreenState extends State<ContactinfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact info'),
        backgroundColor: Colors.grey.shade200,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(maxRadius: 140,),
            Text('dsgdu yufdsu  gdus',style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
            Text('+9273676xxxx',style: TextStyle(fontSize: 25,),),
          ],
        ),
      ),
    );
  }
}
