import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Userinfo/Userinfo_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Users> users = [
    Users(username: 'user1', description: 'This is user 1', img: 'https://...'),
    // Add other users similarly
  ];

  bool isLoading = false;
  late Map<String, dynamic> userMap;
  final TextEditingController _search = TextEditingController();

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    try {
      await _firestore
          .collection('users')
          .where('email', isEqualTo: _search.text)
          .get()
          .then((value) {
        setState(() {
          userMap = value.docs[0].data();
          isLoading = false;
        });
        print(userMap);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey.shade200,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserinfoScreen()),
                );
              },
              child: Icon(Icons.person),
            ),
          )
        ],
      ),

      body: Center(
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Column(
          children: [
            userMap != null? ListTile(
              title: Text(userMap['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              subtitle: Text(userMap['email']),
              leading: CircleAvatar(maxRadius: 35,),
              trailing: Icon(Icons.verified_user),
            ): Container(),Divider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: "Add Users",
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 45,
                    width: 300,
                    child: Center(
                      child: TextField(
                        controller: _search,
                        decoration: InputDecoration(
                            hintText: 'Search',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      onSearch();
                      Get.back();
                    },
                    child: Text('ok'),
                  ),
                ],
              ),
            ),
          );
        },
        backgroundColor: Colors.blueGrey.shade200,
        child: Icon(Icons.add, color: Colors.grey.shade700, size: 30),
      ),
    );
  }
}

class Users {
  final String username;
  final String description;
  final String img;

  Users({
    required this.username,
    required this.description,
    required this.img,
  });
}