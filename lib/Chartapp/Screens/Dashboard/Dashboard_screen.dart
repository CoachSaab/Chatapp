import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Chartapp/Screens/Message/Message_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';  // For jsonEncode and jsonDecode
import 'Userinfo/Userinfo_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Users> users = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  late Map<String, dynamic> userMap = {};
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  Future<void> loadUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usersString = prefs.getString('users');
    if (usersString != null) {
      setState(() {
        List<dynamic> usersJson = jsonDecode(usersString);
        users = usersJson.map((userJson) => Users.fromJson(userJson)).toList();
      });
    }
  }

  Future<void> saveUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usersString = jsonEncode(users.map((user) => user.toJson()).toList());
    await prefs.setString('users', usersString);
  }

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
          if (value.docs.isNotEmpty) {
            userMap = value.docs[0].data();
            if (!users.any((user) => user.description == userMap['email'])) {
              users.add(
                Users(
                  username: userMap['name'] ?? 'No name',
                  description: userMap['email'] ?? 'No email',
                  img: userMap['img'] ?? 'https://imgs.search.brave.com/up0gxYmDpVS7RGqtUKxXAVNW0TB1xBiwgaqJQ1J0FEE/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA1Lzg3Lzc2LzY2/LzM2MF9GXzU4Nzc2/NjY1M19Qa0JOeUd4/N21RaDlsMVhYUHRD/QXExbEJnT3NMbDZ4/SC5qcGc', // Add a placeholder image URL
                ),
              );
              saveUsers();  // Save users list after adding a new user
              Get.snackbar(
                'User Added',
                'User has been added to the list.',
                snackPosition: SnackPosition.BOTTOM,
              );
            } else {
              Get.snackbar(
                'User Exists',
                'This user is already in the list.',
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          } else {
            Get.snackbar(
              'User Not Found',
              'No user found with this email.',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
          isLoading = false;
          _search.clear();
        });
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
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: Key(users[index].description),
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            setState(() {
                              users.removeAt(index);
                              saveUsers();  // Save users list after removing a user
                            });
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        onTap: () {
                          String roomId = chatRoomId(
                              _auth.currentUser!.displayName!,
                              userMap!['name']);

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => Message_Screen(
                                chatRoomId: roomId,
                                userMap: userMap,
                              ),
                            ),
                          );
                        },
                        title: Text(
                          users[index].username,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        subtitle: Text(users[index].description),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(users[index].img),
                          maxRadius: 35,
                        ),
                        trailing: Icon(Icons.verified_user),
                      ),
                    ),
                  );
                },
              ),
            ),
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
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      onSearch();
                      Get.back();
                    },
                    child: Text('OK'),
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

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      username: json['username'],
      description: json['description'],
      img: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'description': description,
      'img': img,
    };
  }
}
