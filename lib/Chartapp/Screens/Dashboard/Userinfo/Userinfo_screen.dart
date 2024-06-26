import 'package:demo/Chartapp/Screens/Auth/Login/Login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserinfoScreen extends StatefulWidget {
  const UserinfoScreen({super.key});

  @override
  State<UserinfoScreen> createState() => _UserinfoScreenState();
}

class _UserinfoScreenState extends State<UserinfoScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userphoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
        backgroundColor: Colors.grey.shade200,
        actions: [
          TextButton(
              onPressed: () async {
                Get.offAll(LoginScreen());
              },
              child: Text('Log-out')
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(radius: 30),
                      title: Text('Enter your name and add an optional profile picture'),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Enter your name',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('Phone Number'),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _userphoneController,
                            decoration: InputDecoration(
                              hintText: 'enter here',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('About'),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '?',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){},
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
